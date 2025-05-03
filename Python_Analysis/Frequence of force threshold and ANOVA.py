import pandas as pd
import statsmodels.api as sm
import seaborn as sns
from statsmodels.formula.api import ols
from statsmodels.stats.multicomp import pairwise_tukeyhsd
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib.patches import Patch

# Load and format data
data = pd.read_csv('combined_data.csv', delimiter='\t|,', engine='python')
data.columns = ['Gender', 'Amplitude', 'Pitch', 'PainSound', 'Choice', 'ForceThreshold', 'Participant']

# Create the base plot
plt.figure(figsize=(10, 7))
ax = sns.countplot(
    x='ForceThreshold',
    hue='Choice',
    data=data,
    palette='Set1',
    dodge=True
)

# Mapping: raw choice → descriptive labels
label_map = {
    'a': "Strongly Agree",
    'b': "Agree",
    'c': "Disagree",
    'd': "Strongly Disagree"
}

# Build new legend manually from bars
handles, labels = ax.get_legend_handles_labels()
custom_handles = []
custom_labels = []

# Loop through actual bar colors in Seaborn order and match them
for handle, label in zip(handles, labels):
    desc = label_map[label.strip("'")]  # e.g., 'a' → Strongly Agree
    custom_handles.append(Patch(color=handle.get_facecolor(), label=desc))
    custom_labels.append(desc)

# Apply custom legend
ax.legend(title='Participant Choice', handles=custom_handles)

# Final formatting
plt.title('Frequency of Force Threshold', fontsize=16)
plt.xlabel('Force Threshold', fontsize=12)
plt.ylabel('Count', fontsize=12)
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.tight_layout()
plt.savefig("ForceThreshold_frequency_by_choice_barplot_final.png", dpi=300)
# plt.show()

"""ANOVA (Example with ForceThreshold and Choice):"""
model = ols('ForceThreshold ~ C(Choice)', data=data).fit()
anova_table = sm.stats.anova_lm(model, typ=2)
print("\nANOVA Results (ForceThreshold by Choice):")
print(anova_table)

# Tukey's HSD test to compare Pitch across participant Choices
tukey_results = pairwise_tukeyhsd(endog=data['ForceThreshold'], groups=data['Choice'], alpha=0.05)

# Display the results clearly
print(tukey_results.summary())

# Convert results to a DataFrame clearly for easier interpretation
tukey_df = pd.DataFrame(data=tukey_results._results_table.data[1:],
                        columns=tukey_results._results_table.data[0])

# Display the DataFrame
print(tukey_df)