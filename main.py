import matplotlib.pyplot as plt
import csv

x = []
y = []

with open('data.csv','r') as csvfile:
    plots = csv.reader(csvfile, delimiter=',')
    for ind, row in enumerate(plots):
        if ind == 0:
            continue
        if ind % 500 == 0:
            x.append(row[0])
            y.append(float(row[4]))
plt.xticks(rotation=50)
plt.plot(x,y, label='curve')
plt.xlabel('date')
plt.ylabel('price')
plt.legend()
plt.show()
