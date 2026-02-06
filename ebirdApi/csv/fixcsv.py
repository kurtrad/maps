import pandas as pd
import os

# Change to the script's directory
os.chdir(os.path.dirname(os.path.abspath(__file__)))

# ---------------------------------------------------------
# 1. Load your files
# ---------------------------------------------------------

# Your species list (the one you posted originally)
species_df = pd.read_csv("exotics.csv")

# Your trimmed taxonomy file
taxonomy_df = pd.read_csv("allspecies_trimmed.csv")

# Rename columns to lowercase for consistency
taxonomy_df = taxonomy_df.rename(columns={
    'COMMON_NAME': 'comName',
    'SPECIES_CODE': 'speciesCode'
})

# ---------------------------------------------------------
# 2. Normalize names for matching
# ---------------------------------------------------------

def normalize(s):
    return s.strip().lower() if isinstance(s, str) else s

species_df["comName_norm"] = species_df["comName"].apply(normalize)
taxonomy_df["comName_norm"] = taxonomy_df["comName"].apply(normalize)

# ---------------------------------------------------------
# 3. Merge to bring speciesCode into your list
# ---------------------------------------------------------

merged = species_df.merge(
    taxonomy_df[["comName_norm", "speciesCode"]],
    on="comName_norm",
    how="left",
    suffixes=("", "_tax")
)

# If your CSV already had some speciesCode values, keep them
merged["speciesCode"] = merged["speciesCode"].fillna(merged["speciesCode_tax"])

# Drop helper columns
merged = merged.drop(columns=["comName_norm", "speciesCode_tax"])

# ---------------------------------------------------------
# 4. Save the completed CSV
# ---------------------------------------------------------

merged.to_csv("species_with_codes.csv", index=False)

# ---------------------------------------------------------
# 5. Report any species that still have no match
# ---------------------------------------------------------

missing = merged[merged["speciesCode"].isna()]["comName"].tolist()

if missing:
    print("\nSpecies with no match found:")
    for name in missing:
        print(" -", name)
else:
    print("\nAll species matched successfully!")
