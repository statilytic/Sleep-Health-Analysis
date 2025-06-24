## Sleep Health SQL Analysis
This project explores patterns and insights in a sleep health dataset using MySQL.

# Description of data
The data consists of synthetic data created by a user on Kaggle.

Details about disorder columns:
- None: The individual does not exhibit any specific sleep disorder.
- Insomnia: The individual experiences difficulty falling asleep or staying asleep, leading to inadequate or poor-quality sleep.
- Sleep Apnea: The individual suffers from pauses in breathing during sleep, resulting in disrupted sleep patterns and potential health risks.

Sleep duration is measured in hours.
Physical activity level is measured in minutes per day.
Heart rate is measured in BPM.

I created the following categories for convenience and easier understanding :

Details about fitness levels: 
- Low :  Less than 40 minutes of physical activity per day and less than 5000 daily steps
- Moderate : 40-60 minutes of physical activity per day and 5000-8000 daily steps
- High : More than 60 minutes per day of physical activity and more than 8000 steps per day

Details about quality of sleep category
- Low sleep quality : 1 <= Quality of Sleep <= 5 
- Moderate sleep quality : 6 <= Quality of Sleep <= 7 
- High sleep quality : Quality of Sleep >= 8 

Details about sleep duration category
- Short sleep duration : Sleep Duration < 6 
- Adequate sleep duration : 6 <= Sleep Duration <= 8 
- Long Sleep Duration : Sleep Duration > 8 


# Tools
MySQL for data querying and analysis.

# Cleaning Process
The BMI column contained inconsistent labels such as “Normal” and “Normal weight” which were standardised to “Normal” for consistency.

# Insights
1. *Stress levels by occupation and impact on quality of sleep.*
	- Calculates average quality of sleep and stress level for each occupation.
	- Calculates the disorder rate for each occupation by the total individuals that suffers from sleep disorders by occupation.
	- Results indicate that engineers have the lowest average stress level with the highest average quality of sleep and a disorder rate of 9.52%. Sales representatives have the 		highest average stress level with the lowest average quality of sleep and a disorder rate of 100%.

2. *Relationship between BMI and  sleep disorder*
	- Groups individuals by BMI category and counts number of cases for each sleep disorder.
	- Results indicate overweight and obese individuals are more prone to sleep disorders.

3.  *Relationship between fitness level and sleep disorder*
	- Shows the distribution of sleep disorders across different levels of fitness. Results indicate that majority of highly active individuals are not prone to having sleeping 		disorders whilst some suffer from sleep apnea and moderately active individuals suffer from insomnia. This suggests fitness levels doesn’t indicate whether an individual will 		have a sleep disorder.

4. *Relationship between sleep duration and quality of sleep*
	- Analyses how different sleep durations relate to perceived sleep quality.




