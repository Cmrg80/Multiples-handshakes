import pandas as pd
import matplotlib.pyplot as plt

# Load CSV
df = pd.read_csv("data/benchmark_results.csv")

print("\n=== Benchmark Results ===")
print(df)

# Basic statistics
print("\n=== Statistics ===")
print(df.describe())

# Plot: Connections per second
plt.figure(figsize=(8,5))
plt.bar(df["TLS"], df["connections_per_sec"])

plt.xlabel("TLS Version")
plt.ylabel("Connections per second")
plt.title("TLS Handshake Throughput")

plt.tight_layout()
plt.savefig("figures/connections_per_sec.png")

# Plot: Estimated total latency
plt.figure(figsize=(8,5))
plt.bar(df["TLS"], df["Estimated_Total_ms"])

plt.xlabel("TLS Version")
plt.ylabel("Estimated Total Latency (ms)")
plt.title("Estimated TLS Handshake Latency")

plt.tight_layout()
plt.savefig("figures/estimated_latency.png")

print("\nPlots saved in figures/")
