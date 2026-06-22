"""Investiga por que flow-choice-heading retorna text vazio no Selenium."""
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

BASE_URL = "https://corte.vercel.app/"

def main():
    opts = Options()
    driver = webdriver.Chrome(options=opts)
    driver.set_window_size(720, 1280)
    wait = WebDriverWait(driver, 15)

    driver.get(BASE_URL)
    wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, ".home-cta-btn")))
    driver.execute_script("document.querySelector('.home-cta-btn').scrollIntoView({block:'center'})")
    driver.find_element(By.CSS_SELECTOR, ".home-cta-btn").click()
    driver.execute_script("window.scrollTo(0,0)")
    wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".pickup-card--immediate")))
    driver.find_element(By.CSS_SELECTOR, ".pickup-card--immediate").click()
    wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".flow-choice-screen")))
    time.sleep(1.5)

    el = driver.find_element(By.CSS_SELECTOR, ".flow-choice-heading")
    print(f"tag          : {el.tag_name}")
    print(f"class        : {el.get_attribute('class')}")
    print(f"text         : '{el.text}'")
    print(f"innerText    : '{el.get_attribute('innerText')}'")
    print(f"textContent  : '{el.get_attribute('textContent')}'")
    print(f"innerHTML    : {el.get_attribute('innerHTML')[:300]}")
    print(f"is_displayed : {el.is_displayed()}")
    print(f"is_enabled   : {el.is_enabled()}")

    # Verifica o CSS aplicado
    font_size  = driver.execute_script("return window.getComputedStyle(arguments[0]).fontSize", el)
    visibility = driver.execute_script("return window.getComputedStyle(arguments[0]).visibility", el)
    display    = driver.execute_script("return window.getComputedStyle(arguments[0]).display", el)
    color      = driver.execute_script("return window.getComputedStyle(arguments[0]).color", el)
    print(f"CSS fontSize   : {font_size}")
    print(f"CSS visibility : {visibility}")
    print(f"CSS display    : {display}")
    print(f"CSS color      : {color}")

    # Tenta via JS
    txt_js = driver.execute_script("return document.querySelector('.flow-choice-heading').textContent")
    print(f"JS textContent : '{txt_js}'")

    # Pega bounding box
    rect = driver.execute_script(
        "const r = arguments[0].getBoundingClientRect();"
        "return {top:r.top, left:r.left, width:r.width, height:r.height}",
        el
    )
    print(f"BoundingRect   : {rect}")
    print(f"Window size    : {driver.get_window_size()}")

    driver.quit()

if __name__ == "__main__":
    main()
