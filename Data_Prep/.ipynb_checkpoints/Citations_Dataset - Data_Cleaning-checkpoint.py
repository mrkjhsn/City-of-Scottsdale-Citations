#minor cleaning before CSV import into SQL

import pandas as pd

df = pd.read_csv('spd_PDCitations - 2.19.2019.csv')

df['Officer Badge #'] = df['Officer Badge #'].str.replace('B','') #removes 'B' from the front of some officer badge numbers in the 'Officer Badge #' field

df['Zip'] = df['Zip'].str.replace(r'\D+', '') #removes non-numerical characters from 'Zip' field

df.to_csv('spd_PDCitations - 2-19-2019_CLEAN.csv', sep=',' , index=False)

