import pandas as pd
import sys

#print("Number of arguments:", len(sys.argv))
#print("List of arguments: ", str(sys.argv))
#print(sys.argv[1])
filename = sys.argv[1].split('.')[0]

df = pd.read_csv(sys.argv[1], sep='\t')

filtered_df = df.loc[(df["Completeness"]<40) | (df["Contamination"]>5)]

filtered_df.to_csv(filename+"_filtered.csv", sep=',')