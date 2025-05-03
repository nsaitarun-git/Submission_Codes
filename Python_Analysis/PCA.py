import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
import matplotlib.pyplot as plt
import seaborn as sns
from matplotlib.lines import Line2D  # Use Line2D for scatter legend

# === Load the data ===
data = pd.read_csv('combined_data.csv', delimiter='\t|,', engine='python')
data.columns = ['Gender', 'Amplitude', 'Pitch', 'PainSound', 'Choice', 'ForceThreshold', 'Participant']

# === Select and standardize features ===
features = ['Amplitude', 'Pitch', 'PainSound', 'ForceThreshold']
X = data[features]
y = data['Choice']
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# === PCA ===
pca = PCA(n_components=2)
X_pca = pca.fit_transform(X_scaled)
pca_df = pd.DataFrame({'PC1': X_pca[:, 0], 'PC2': X_pca[:, 1], 'Choice': y})

# === Plot PCA result ===
plt.figure(figsize=(8, 6))
ax = sns.scatterplot(
    data=pca_df,
    x='PC1',
    y='PC2',
    hue='Choice',
    s=100,
    alpha=0.85,
    palette='Set1'
)

# === Custom legend mapping ===
label_map = {
    'a': "Strongly Agree",
    'b': "Agree",
    'c': "Disagree",
    'd': "Strongly Disagree"
}

# Create new legend using Line2D to match scatterplot style
handles, labels = ax.get_legend_handles_labels()
custom_handles = []
for handle, label in zip(handles, labels):
    clean_label = label.strip("'")
    mapped_label = label_map.get(clean_label, clean_label)
    color = handle.get_color()
    custom_handles.append(Line2D([0], [0], marker='o', color='w', label=mapped_label,
                                 markerfacecolor=color, markersize=10, alpha=0.85))

ax.legend(handles=custom_handles, title="Participant Choice")

# === Final touches ===
plt.title('PCA of Auditory and Force Features', fontsize=14)
plt.xlabel(f"PC1 ({pca.explained_variance_ratio_[0]*100:.1f}% Variance)", fontsize=12)
plt.ylabel(f"PC2 ({pca.explained_variance_ratio_[1]*100:.1f}% Variance)", fontsize=12)
plt.grid(True)
plt.tight_layout()
plt.savefig("pca_sound_features_by_choice_large_dots_custom_legend.png", dpi=300)
plt.show()
