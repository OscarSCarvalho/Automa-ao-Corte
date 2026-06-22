"""
Inspetor de telas da aplicação CORTE.
Navega por cada tela e imprime todos os elementos interativos encontrados.
"""
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

BASE_URL = "https://corte.vercel.app/"
WIDTH, HEIGHT = 720, 1280


def make_driver():
    opts = Options()
    opts.add_argument("--start-maximized")
    driver = webdriver.Chrome(options=opts)
    driver.set_window_size(WIDTH, HEIGHT)
    driver.set_window_position(100, 50)
    return driver


def dump_interactivos(driver, label):
    print(f"\n{'='*60}")
    print(f"TELA: {label}")
    print(f"URL : {driver.current_url}")
    print(f"{'='*60}")

    seletores = [
        ("button", By.TAG_NAME, "button"),
        ("a[href]", By.CSS_SELECTOR, "a[href]"),
        ("[role=button]", By.CSS_SELECTOR, "[role='button']"),
        ("[onclick]", By.CSS_SELECTOR, "[onclick]"),
        (".clickable / [class*=btn]", By.CSS_SELECTOR, "[class*='btn']"),
        ("[class*=card]", By.CSS_SELECTOR, "[class*='card']"),
        ("[class*=pickup]", By.CSS_SELECTOR, "[class*='pickup']"),
        ("[class*=cat]", By.CSS_SELECTOR, "[class*='cat-']"),
        ("[class*=back]", By.CSS_SELECTOR, "[class*='back']"),
        ("[class*=nav]", By.CSS_SELECTOR, "[class*='nav']"),
    ]

    seen_ids = set()
    for desc, by, val in seletores:
        try:
            els = driver.find_elements(by, val)
            for el in els:
                uid = (el.tag_name, el.get_attribute("class"), el.text.strip()[:60])
                if uid in seen_ids:
                    continue
                seen_ids.add(uid)
                classes = el.get_attribute("class") or ""
                text = el.text.strip().replace("\n", " ")[:80]
                visible = el.is_displayed()
                enabled = el.is_enabled()
                role = el.get_attribute("role") or ""
                href = el.get_attribute("href") or ""
                onclick = el.get_attribute("onclick") or ""
                print(
                    f"  [{desc}]"
                    f"\n    tag={el.tag_name}  class='{classes}'"
                    f"\n    text='{text}'"
                    f"\n    visible={visible}  enabled={enabled}"
                    + (f"  role={role}" if role else "")
                    + (f"\n    href={href}" if href else "")
                    + (f"\n    onclick={onclick}" if onclick else "")
                )
        except Exception as e:
            print(f"  [{desc}] ERRO: {e}")

    # dump do HTML resumido relevante
    print(f"\n--- BODY classes relevantes (classes únicas) ---")
    try:
        all_els = driver.find_elements(By.CSS_SELECTOR, "*")
        class_set = set()
        for el in all_els:
            c = el.get_attribute("class") or ""
            for cls in c.split():
                class_set.add(cls)
        interesting = [c for c in sorted(class_set)
                       if any(kw in c for kw in
                              ("btn","card","back","nav","screen","heading",
                               "cta","pickup","cat","product","modal","toast",
                               "badge","tag","price","qty","quantity","cart",
                               "confirm","cancel","close","arrow","icon","chip",
                               "step","schedule","date","time","slot","select",
                               "check","tick","done","error","empty","search"))]
        print(" ", "\n  ".join(interesting))
    except Exception as e:
        print(f"  ERRO dump classes: {e}")


def main():
    driver = make_driver()
    wait = WebDriverWait(driver, 15)

    try:
        # ── TELA 1: Home ──────────────────────────────────────────────
        driver.get(BASE_URL)
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".home-cta-btn")))
        time.sleep(2)
        dump_interactivos(driver, "HOME")

        # ── TELA 2: Pickup / Seleção de Retirada ──────────────────────
        driver.execute_script("document.querySelector('.home-cta-btn').scrollIntoView({block:'center'})")
        driver.find_element(By.CSS_SELECTOR, ".home-cta-btn").click()
        driver.execute_script("window.scrollTo(0,0)")
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".pickup-mode-screen")))
        time.sleep(1.5)
        dump_interactivos(driver, "PICKUP - Seleção de Retirada")

        # ── TELA 3: Categorias (via Agendar) ──────────────────────────
        driver.execute_script("document.querySelector('.pickup-card--scheduled').click()")
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".cat-grid")))
        time.sleep(1.5)
        dump_interactivos(driver, "CATEGORIAS")

        # ── TELA 4: Produtos - Carnes ──────────────────────────────────
        driver.execute_script(
            "Array.from(document.querySelectorAll('.cat-name'))"
            ".find(el => el.textContent.trim() === 'Carnes')"
            ".parentElement.click()"
        )
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".product-card")))
        time.sleep(1.5)
        dump_interactivos(driver, "PRODUTOS - Carnes")

        # ── TELA 5: Detalhe de produto (clicar no 1º card) ────────────
        try:
            cards = driver.find_elements(By.CSS_SELECTOR, ".product-card")
            if cards:
                cards[0].click()
                time.sleep(2)
                dump_interactivos(driver, "DETALHE DO PRODUTO (1º card)")
        except Exception as e:
            print(f"\nDetalhe produto: {e}")

        # ── TELA 6: Voltar a Categorias e testar Frangos ──────────────
        driver.back()
        time.sleep(1)
        try:
            wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".cat-grid")))
            dump_interactivos(driver, "CATEGORIAS (pós-back)")
        except Exception:
            pass

        # ── TELA 7: Balcão (desde Home de novo) ───────────────────────
        driver.get(BASE_URL)
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".home-cta-btn")))
        driver.execute_script("document.querySelector('.home-cta-btn').scrollIntoView({block:'center'})")
        driver.find_element(By.CSS_SELECTOR, ".home-cta-btn").click()
        driver.execute_script("window.scrollTo(0,0)")
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".pickup-card--immediate")))
        time.sleep(1)
        driver.execute_script("document.querySelector('.pickup-card--immediate').click()")
        time.sleep(2)
        dump_interactivos(driver, "PÓS-BALCÃO (imediato)")

    finally:
        time.sleep(3)
        driver.quit()
        print("\n\n=== FIM DA INSPEÇÃO ===")


if __name__ == "__main__":
    main()
