import pandas as pd

# read in csv files from previous downloads
# set tcmainid as index
# to be able to cross reference against most recent download
citations = pd.read_csv('data/citations.csv ', index_col='Citation #')

# download most recent citations
citations_recent = pd.read_csv('https://opendatafiles.blob.core.windows.net/odfiles/spd_PDCitations.csv', 
                               index_col='Citation #',
                               low_memory=False)
# combine citations
all_citations = pd.concat([citations,
                           citations_recent])

# remove duplicates
all_citations = all_citations.loc[~all_citations.index.duplicated(),:]

# save the most recently updated citations
all_citations.to_csv('data/citations.csv')