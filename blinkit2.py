# importing libraries 
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# reading file/inserting file
df = pd.read_csv("/Users/macairm4/Downloads/CovidVaccinations.csv")

#checking first 20 raws
print(df.head(20))

#checking last 20 raws
print(df.tail(20))

#printing size fo data
print("size of data :" ,df.shape)

# printig field informations
print(df.columns)

#printing datatype
print(df.dtypes)

#finding out the data to be cleaned 
print(df['Item Fat Content'].unique())

#data cleaning 
df['Item Fat Content'] = df['Item Fat Content'].replace({'LF':'Low Fat','low fat': 'Low Fat','reg':'Regular'})

#cleaned data
print(df['Item Fat Content'].unique())

# business requirments/ kpi requirments
# total sales
total_sales = df['Total Sales'].sum()

#average sales
avg_sales = df['Total Sales'].mean()

#no.of items sold
no_of_items_sold = df['Total Sales'].count()

#average ratings
avg_ratings =df['Rating'].mean()

#display
print(f"Total Sales : ${total_sales:,.2f}")
print(f"avg_sales: ${avg_sales:,.2f}")
print(f"no_of_items_sold : ${no_of_items_sold:,.2f}")
print(f"avg_ratings: ${avg_ratings:,.2f}")

#chart requirments
#total sale by fat content
sales_by_fat = df.groupby('Item Fat Content')['Total Sales'].sum()

plt.pie(sales_by_fat, labels= sales_by_fat.index, autopct ='%.1f%%', startangle= 90)
plt.title('sales by fat content')
plt.axis('equal')
#plt.show()

#total sales by item type
sales_by_type = df.groupby('Item Type')['Total Sales'].sum().sort_values(ascending=False)

plt.figure(figsize=(10,6))
bars = plt.bar(sales_by_type.index, sales_by_type.values)

plt.xticks(rotation=90)
plt.xlabel('Item Type')
plt.ylabel('Total Sales')
plt.title('Total Sales by Item Type')

for bar in bars:
    plt.text(
        bar.get_x() + bar.get_width()/2,
        bar.get_height(),
        f'{bar.get_height():,.0f}',
        ha='center',
        va='bottom',
        fontsize=8
    )

plt.tight_layout()
#plt.show()

#fat content by outlet sales
grouped = df.groupby(['Outlet Location Type','Item Fat Content'])['Total Sales'].sum().unstack()
grouped = grouped[['Regular', 'Low Fat']]

ax = grouped.plot(kind='bar', figsize=(8, 5), title='outlet tier by fat content')
plt.xlabel('Outlet Location Tier')
plt.ylabel('Total Sales')
plt.legend(title='Item Fat Content')
plt.tight_layout()
#plt.show()

#total sales by outlet establishment

sales_by_year = df.groupby('Outlet Establishment Year')['Total Sales'].sum().sort_index()

plt.figure(figsize=(9, 5))
plt.plot(sales_by_year.index, sales_by_year.values, marker='o', linestyle='-')

plt.xlabel('Outlet Establishment Year')
plt.ylabel('Total Sales')
plt.title('Outlet Establishment')

for x,y, in zip(sales_by_year.index, sales_by_year.values):
    plt.text(x,y,f'{y:,.0f}', ha='center', va = 'bottom', fontsize=8)

plt.tight_layout()
#plt.show()

#sales by outlet size
sales_by_size = df.groupby('Outlet Size')[ 'Total Sales'].sum()

plt.figure(figsize=(4, 4))
plt.pie(sales_by_size, labels= sales_by_size.index, autopct='%1.1f%%', startangle=90)
plt.title('outlet size')
plt.tight_layout()
#plt.show()

#sales by outlet location
sales_by_location = df.groupby('Outlet Location Type')['Total Sales'].sum().reset_index()
sales_by_location = sales_by_location.sort_values('Total Sales', ascending=False)

plt.figure(figsize=(8, 3)) #smaller height enough width
ax = sns.barplot(x= 'Total Sales', y= 'Outlet Location Type', data=sales_by_location)

plt.title(' total sales by outlet location type')
plt.xlabel('total sales')
plt.ylabel('outlet location type')
plt.tight_layout() # ensures layout files without scroll
plt.show()

