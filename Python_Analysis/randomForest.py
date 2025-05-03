import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans
from sklearn.ensemble import RandomForestClassifier
import matplotlib.pyplot as plt
import seaborn as sns

# Step 1: Load your data
data = pd.read_csv('combined_data.csv', delimiter='\t|,', engine='python')
data.columns = ['Gender', 'Amplitude', 'Pitch', 'PainSound', 'Choice', 'ForceThreshold', 'Participant']

# Step 2: Select features and scale
features = ['Amplitude', 'Pitch', 'PainSound', 'ForceThreshold']
X = data[features]
X_scaled = StandardScaler().fit_transform(X)

# Step 3: Apply KMeans to generate cluster labels
kmeans = KMeans(n_clusters=2, random_state=42)
cluster_labels = kmeans.fit_predict(X_scaled)

# Step 4: Train a Random Forest classifier to predict cluster from features
rf = RandomForestClassifier(n_estimators=100, random_state=42)
rf.fit(X, cluster_labels)

# Step 5: Extract feature importance
importances = pd.Series(rf.feature_importances_, index=features).sort_values(ascending=False)

# **Key Change for Y-Axis Labels and Higher Resolution**
# Step 6: Plot the feature importance
plt.figure(figsize=(8, 5))
sns.barplot(x=importances.values, y=importances.index, palette='viridis')
plt.title('Random Forest Feature Importance for Cluster Prediction')
plt.xlabel('Importance Score')
plt.ylabel('Feature')  # Add y-axis label

# Set the y-axis labels to the correct feature names
plt.yticks(range(len(features)), ['Amplitude', 'Pitch', 'Pain Sound', 'Force Threshold'])  # Correct labels

plt.tight_layout()

# Save as a vector graphic (e.g., PDF or SVG)
plt.savefig('random_forest_feature_importance.pdf', format='pdf', dpi=300)  # or .svg
plt.show()

# Step 7: Print importances
print("Random Forest Feature Importances:")
print(importances)