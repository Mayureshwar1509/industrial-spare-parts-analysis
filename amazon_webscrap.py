
pip install selenium pandas webdriver-manager

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import pandas as pd
import time

# Configure headless Chrome browser
options = Options()
options.add_argument("--headless")
options.add_argument("--disable-gpu")
options.add_argument("--window-size=1920,1080")

# Initialize the Chrome driver
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

# List of products to search
products = ["Ball Bearing", "Hydraulic Filter", "Spiral Gasket", "Tool Kit", "Hose Pipe"]

results = []

for product in products:
    print(f"Searching on Amazon: {product}")
    search_url = f"https://www.amazon.in/s?k={product.replace(' ', '+')}"
    driver.get(search_url)
    time.sleep(3)  # wait for page to load

    # Get top 5 product listings
    product_elements = driver.find_elements(By.XPATH, "//div[@data-component-type='s-search-result']")[:5]

    for elem in product_elements:
        try:
            title = elem.find_element(By.TAG_NAME, "h2").text
        except:
            title = None
        try:
            price = elem.find_element(By.CLASS_NAME, "a-price-whole").text
        except:
            price = None
        try:
            rating = elem.find_element(By.CLASS_NAME, "a-icon-alt").text
        except:
            rating = None
        try:
            reviews = elem.find_element(By.XPATH, ".//span[@class='a-size-base']").text
        except:
            reviews = None

        results.append({
            "Search_Item": product,
            "Title": title,
            "Price": price,
            "Rating": rating,
            "Reviews": reviews,
            "Availability": "In Stock" if title else "Unavailable"
        })

    time.sleep(2)  # pause between searches

driver.quit()

# Save results to CSV
df = pd.DataFrame(results)
df.to_csv("amazon_scraped_data.csv", index=False)
print("✅ Data scraped and saved to amazon_scraped_data.csv")
