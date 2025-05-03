import pandas as pd
import glob
import os

# Set the path to the folder containing your CSV files
folder_path = "data/"

# Generate a list of file paths for files S1.csv to S20.csv
file_list = [os.path.join(folder_path, f"S{i}.csv") for i in range(1, 21)]

# Load and concatenate data
df_list = []
for file in file_list:
    if os.path.exists(file):
        df_temp = pd.read_csv(file)
        participant_id = os.path.splitext(os.path.basename(file))[0]  # Get S1, S2, etc.
        df_temp['Participant'] = participant_id
        df_list.append(df_temp)
    else:
        print(f"File not found: {file}")

# Combine all individual dataframes into a single dataframe
data_combined = pd.concat(df_list, ignore_index=True)

# Quick verification
print(f"Combined DataFrame shape: {data_combined.shape}")
print(data_combined.head())

# Optionally, save combined data to CSV
data_combined.to_csv("combined_data.csv", index=False)

