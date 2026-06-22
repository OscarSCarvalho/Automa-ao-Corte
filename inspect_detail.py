"""Inspeção focada: tela de detalhe e chips de filtro."""
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

BASE_URL = "https://corte.vercel.app/"

def go_to_catalog(driver, wait):
    driver.get(BASE_URL)
    wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, ".home-cta-btn")))
    driver.execute_script("document.querySelector('.home-cta-btn').scrollIntoView({block:'center'})")
    driver.find_element(By.CSS_SELECTOR, ".home-cta-btn").click()
    driver.execute_script("window.scrollTo(0,0)")
    wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".pickup-card--scheduled")))
    driver.execute_script("document.querySelector('.pickup-card--scheduled').click()")
    wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".cat-grid")))
    driver.execute_script(
        "Array.from(document.querySelectorAll('.cat-name'))"
        ".find(el=>el.textContent.trim()==='Carnes').parentElement.click()"
    )
    wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".product-card")))
    time.sleep(1)


def dump_html_snippet(driver, selector, label):
    try:
        els = driver.find_elements(By.CSS_SELECTOR, selector)
        print(f"\n--- {label} ({len(els)} elem) ---")
        for i, el in enumerate(els[:10]):
            print(f"  [{i}] tag={el.tag_name} class='{el.get_attribute('class')}'"
                  f" text='{el.text.strip()[:80].encode('ascii','replace').decode()}'")
    except Exception as e:
        print(f"  ERRO {label}: {e}")


def main():
    opts = Options()
    driver = webdriver.Chrome(options=opts)
    driver.set_window_size(720, 1280)
    wait = WebDriverWait(driver, 15)

    try:
        # ── Tela Catálogo: chips, back-btn, catalog-count ──────────────
        go_to_catalog(driver, wait)

        print("\n" + "="*60)
        print("CATÁLOGO - CHIPS/FILTROS")
        print("="*60)
        dump_html_snippet(driver, ".chips", "chips container")
        dump_html_snippet(driver, ".chip", "chips individuais")
        dump_html_snippet(driver, ".catalog-count", "catalog-count")
        dump_html_snippet(driver, ".catalog-heading", "catalog-heading")
        dump_html_snippet(driver, ".step-dot", "step-dots")
        dump_html_snippet(driver, ".back-btn", "back-btn")
        dump_html_snippet(driver, ".product-card-add", "botoes add (+)")
        dump_html_snippet(driver, ".product-card-badge", "badges")

        # inner HTML do back-btn para pegar o texto/ícone
        try:
            bb = driver.find_element(By.CSS_SELECTOR, ".back-btn")
            print(f"\n  back-btn innerHTML: {bb.get_attribute('innerHTML')[:200]}")
            print(f"  back-btn text: '{bb.text}'")
            print(f"  back-btn visible: {bb.is_displayed()}")
        except Exception as e:
            print(f"  back-btn: {e}")

        # ── Detalhe: clicar no 1º produto ─────────────────────────────
        cards = driver.find_elements(By.CSS_SELECTOR, ".product-card")
        print(f"\n  Produtos encontrados: {len(cards)}")
        cards[0].click()
        time.sleep(2)

        print("\n" + "="*60)
        print("DETALHE DO PRODUTO")
        print("="*60)
        dump_html_snippet(driver, ".detail-qty-btn", "qty botões")
        dump_html_snippet(driver, ".detail-qty-val", "qty valor")
        dump_html_snippet(driver, ".detail-price", "preço")
        dump_html_snippet(driver, ".detail-price-label", "price label")
        dump_html_snippet(driver, ".detail-price-row", "price rows")
        dump_html_snippet(driver, ".btn-primary", "btn-primary (checkout)")
        dump_html_snippet(driver, ".detail-cta", "detail-cta area")
        dump_html_snippet(driver, ".detail-checkout", "detail-checkout")
        dump_html_snippet(driver, ".back-btn", "back-btn detalhe")
        dump_html_snippet(driver, ".step-dot", "step-dots detalhe")

        # texto dos qtd buttons
        try:
            qtd_btns = driver.find_elements(By.CSS_SELECTOR, ".detail-qty-btn")
            for i, btn in enumerate(qtd_btns):
                print(f"  qty-btn[{i}] innerHTML: {btn.get_attribute('innerHTML')[:100]}")
                print(f"  qty-btn[{i}] text: '{btn.text}'  visible={btn.is_displayed()}")
        except Exception as e:
            print(f"  qty-btns: {e}")

        # full detail-cta html
        try:
            cta = driver.find_element(By.CSS_SELECTOR, ".detail-cta")
            print(f"\n  detail-cta innerHTML:\n{cta.get_attribute('innerHTML')[:500]}")
        except Exception as e:
            print(f"  detail-cta: {e}")

        # ── Fluxo balcão: o que acontece após clicar? ─────────────────
        driver.get(BASE_URL)
        wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, ".home-cta-btn")))
        driver.execute_script("document.querySelector('.home-cta-btn').scrollIntoView({block:'center'})")
        driver.find_element(By.CSS_SELECTOR, ".home-cta-btn").click()
        driver.execute_script("window.scrollTo(0,0)")
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".pickup-card--immediate")))
        driver.execute_script("document.querySelector('.pickup-card--immediate').click()")
        time.sleep(2)

        print("\n" + "="*60)
        print("FLUXO BALCÃO")
        print("="*60)
        dump_html_snippet(driver, ".flow-choice-heading", "flow-heading")
        dump_html_snippet(driver, ".flow-card", "flow-cards")
        dump_html_snippet(driver, ".flow-card--counter", "card balcão")
        dump_html_snippet(driver, ".flow-card--preferential", "card preferencial")

        # clicar no flow-card--counter
        try:
            counter_card = driver.find_element(By.CSS_SELECTOR, ".flow-card--counter")
            counter_card.click()
            time.sleep(2)
            print(f"\n  PÓS-CLIQUE BALCÃO: URL={driver.current_url}")
            # pegar todas as classes únicas
            all_els = driver.find_elements(By.CSS_SELECTOR, "*")
            class_set = set()
            for el in all_els:
                c = el.get_attribute("class") or ""
                for cls in c.split():
                    class_set.add(cls)
            print("  classes presentes:", sorted(class_set)[:50])
        except Exception as e:
            print(f"  flow-card--counter click: {e}")

        # voltar e clicar no preferencial
        driver.get(BASE_URL)
        wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, ".home-cta-btn")))
        driver.execute_script("document.querySelector('.home-cta-btn').scrollIntoView({block:'center'})")
        driver.find_element(By.CSS_SELECTOR, ".home-cta-btn").click()
        driver.execute_script("window.scrollTo(0,0)")
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".pickup-card--immediate")))
        driver.execute_script("document.querySelector('.pickup-card--immediate').click()")
        time.sleep(2)
        try:
            pref_card = driver.find_element(By.CSS_SELECTOR, ".flow-card--preferential")
            pref_card.click()
            time.sleep(2)
            print(f"\n  PÓS-CLIQUE PREFERENCIAL: URL={driver.current_url}")
            all_els = driver.find_elements(By.CSS_SELECTOR, "*")
            class_set2 = set()
            for el in all_els:
                c = el.get_attribute("class") or ""
                for cls in c.split():
                    class_set2.add(cls)
            print("  classes presentes:", sorted(class_set2)[:60])
        except Exception as e:
            print(f"  flow-card--preferential click: {e}")

    finally:
        time.sleep(2)
        driver.quit()
        print("\n=== FIM ===")


if __name__ == "__main__":
    main()
