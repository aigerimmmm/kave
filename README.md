# Kave Project

Interaction dataset has been selected as the mining challenge for the "International Conference on Mining Software Repositories" (MSR'18).The project presents a technique to determine a developer based on their Visual Studio IDE event data. The KaVE data set was used  which recorded IDE activities from 85 developers. The dataset has the active window (windows within the IDE) that have received developer clicks and edits behavior (without any of the actual code information). The problem will be analyzing the connection between developers activities, edits behavior, duration spent on the activity, etc.
First figure shows distribution of number of activity during a day from edits file.

![Screenshot](/images/distribution.png)

![Screenshot](/images/feature.png)

Figure 2. Graphical representation  activity duration, edit duration and general programming skills


![Screenshot](/images/PCA1.jpeg)

The principal components are calculated by R language and the result is  PC1 and PC2, where PC1 developers which are not skilled marked as green have 38.7% and PC2 developers which are skilled marked as red 21.7%.


![Screenshot](/images/pca.png)

The Figure 3 shows the PCA values for seven features such as activity and edit duration, programming general, education, position, code reviews and programmingCSharp.


![Screenshot](/images/PCA-clusters.jpeg)

In Figure 4, the red dots is skilled developers and black dots is developers which are not skilled. We can conclude  that if the value of PC2 more than approximately 3, classify as not skilled and if the value of PC2 is less than 3, classify as professional. Therefore, if we have a new developer with above given seven features we can calculate the PC2 value and classify. The formula for PC2 can be calculated as: PC2 = 0.69*(Activity Duration) + 0.67*(Edit Duration)-0.064*(Programming General) +0.17*(education) +0.14*(position)-0.07*(codeReview)-0.103*(programmingCSharp).
