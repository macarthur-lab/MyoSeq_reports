import pandas as pd
import re

input = "/Users/kchao/Documents/MYOSEQ/Reports/Nov_2019/saved_report_variants_myoseq_v20.xlsx"

#Read excel file into a dataframe
data_xlsx = pd.read_excel(input, 'Sheet1', index_col=None)

#Replace all columns having spaces with underscores
data_xlsx.columns = [c.replace(' ', '_') for c in data_xlsx.columns]

#Replace all fields having line breaks with space
df = data_xlsx.replace('\n', ' ',regex=True)
output = re.sub("xlsx", "tsv", input)

#Write dataframe into csv
df.to_csv(output, sep='\t', encoding='utf-8',  index=False, line_terminator='\r\n')
