import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
from sklearn.metrics import silhouette_score
# Step 1: Load and clean data
data = pd.read_csv('combined_data.csv', delimiter='\t|,', engine='python')
data.columns = ['Gender', 'Amplitude', 'Pitch', 'PainSound', 'Choice', 'ForceThreshold', 'Participant']

# Step 2: Select all four relevant features
X = data[['Amplitude', 'Pitch', 'PainSound', 'ForceThreshold']]

# Step 3: Standardize features
X_scaled = StandardScaler().fit_transform(X)

# Step 4: Find optimal number of clusters using silhouette score
silhouette_scores = {}
for k in range(2, 7):
    kmeans = KMeans(n_clusters=k, random_state=42, n_init=10)
    labels = kmeans.fit_predict(X_scaled)
    silhouette_scores[k] = silhouette_score(X_scaled, labels)
    print(silhouette_scores[k])

# Step 5: Choose best k
optimal_k = max(silhouette_scores, key=silhouette_scores.get)

# Step 6: Final KMeans clustering
kmeans = KMeans(n_clusters=optimal_k, random_state=42, n_init=10)
cluster_labels = kmeans.fit_predict(X_scaled)

# Step 7: Apply PCA for visualization
pca = PCA(n_components=2)
X_pca = pca.fit_transform(X_scaled)

# Step 8: Add PCA and cluster labels to dataframe
data['PC1'] = X_pca[:, 0]
data['PC2'] = X_pca[:, 1]
data['Cluster'] = cluster_labels

# Step 9: Plot PCA with clusters
plt.figure(figsize=(8, 6))
sns.scatterplot(
    data=data,
    x='PC1', y='PC2',
    hue='Cluster',
    palette='tab10',
    alpha=0.85,
    s=100  # increase dot size (default is ~40)
)
#
# # Add text labels for Choice
# for _, row in data.iterrows():
#     plt.text(row['PC1'], row['PC2'], row['Choice'].strip("'"), fontsize=7, alpha=0.7)

plt.title(f'K-Means Clustering on Auditory and Force Features (k={optimal_k})',fontsize=14)
plt.xlabel(f'PC1 ({pca.explained_variance_ratio_[0]*100:.1f}% Variance)',fontsize=12)
plt.ylabel(f'PC2 ({pca.explained_variance_ratio_[1]*100:.1f}% Variance)',fontsize=12)
plt.grid(True)
plt.legend(title='Cluster',title_fontsize=11)
plt.tight_layout()
plt.savefig('kmeans_clusters_on_4features.png')
plt.show()