import pandas as pd
import sys

hgt_filename = sys.argv[1].split('.')[0]
#print(hgt_filename)
diamond_filename = sys.argv[2].split('.')[0]
#print(diamond_filename)
output_filename = sys.argv[3]

#print(output_filename)

hgt_df = pd.read_csv(sys.argv[1], sep='\t')
diamond_df = pd.read_csv(sys.argv[2], sep='\t')


all = diamond_df.iloc[:,0].to_list()
set_all = set(all)

filtered_df = hgt_df[hgt_df.Gene_1.isin(set_all)]

print (filtered_df)
filtered_df.drop(filtered_df.columns[0], axis=1)

filtered_df.to_csv(output_filename, sep=',')




