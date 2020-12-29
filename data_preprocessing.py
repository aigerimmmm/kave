# Prepare the data for processing, change date format to time only in the triggeredat column
import pandas as pd 
df = pd.read_csv('/data/debugger.csv')
df['triggeredat'] = df['triggeredat'].str.split('T').str[1]
df['triggeredat'] = df['triggeredat'].str.split('+').str[0]
df.to_csv (r'/data/debuggers.csv', index = False, header=True)


df = pd.read_csv('/data/activity.csv')
df['triggeredat'] = df['triggeredat'].str.split('T').str[1]
df['triggeredat'] = df['triggeredat'].str.split('+').str[0]
df.to_csv (r'/data/activities.csv', index = False, header=True)

df = pd.read_csv('/data/edit.csv')
df['triggeredat'] = df['triggeredat'].str.split('T').str[1]
df['triggeredat'] = df['triggeredat'].str.split('+').str[0]
df.to_csv (r'/data/edits.csv', index = False, header=True)

df = pd.read_csv('/data/navigation.csv')
df['triggeredat'] = df['triggeredat'].str.split('T').str[1]
df['triggeredat'] = df['triggeredat'].str.split('+').str[0]
df.to_csv (r'/data/navigation.csv', index = False, header=True)


df = pd.read_csv('/data/build.csv')
df['triggeredat'] = df['triggeredat'].str.split('T').str[1]
df['triggeredat'] = df['triggeredat'].str.split('+').str[0]
df.to_csv (r'/data/builds.csv', index = False, header=True)
