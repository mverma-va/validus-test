from selenium import webdriver
import time
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By

driver = webdriver.Chrome('C:\\Users\\Applicant\\Desktop\\QATools\\chromedriver.exe')
driver.get("https://www.validusholdings.com/careers/")
assert "Validus - Careers" in driver.title
elem = driver.find_element_by_class_name("//a[@class='btn btn-primary']")
elem.click()

# there might be some issue since this opens in new tab, so we need to handle that case.
time.sleep(2)

driver.find_element_by_xpath("//div[@id='wd-FacetValue-CheckBox-bc33aa3152ec42d4995f4791a106ed09']//div[@class='WHGF']").click()
driver.input_text("//input[@id='wd-AdvancedFacetedSearch-SearchTextBox-input']", "Quality")
driver.find_element_by_xpath("//button[@class='WK1M WO1M WCHO WLD- WI0M WED-']']//div[@class='WHGF']").click()

results= get_text("//span[@id='wd-FacetedSearchResultList-PaginationText-facetSearchResultList.newFacetSearch.Report_Entry']")
noofresults = results.split(" ")
print("noofresults[0]")

elements = driver.find_elements_by_class("localtor for class ")
for item in elements:
	txt = item.get_text()
	if "Today" in txt:
		print ("find the job id here")
		


driver.find_element_by_xpath("//span[contains(text(),'Clear All')]").click()
driver.close()
