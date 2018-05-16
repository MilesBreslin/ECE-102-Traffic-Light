# ECE 102 Traffic Systems Coordinator

A simple traffic light controller using a LabJack and Matlab code!

### How to Use

This code is entirely modular and should not require any editing to use different pins or traffic light patterns. To use this, only edit the DATA files. For example, *cyclemap.dat*:

```matlab
%% For each cycle we have, create a new line showing which lines
%% are green and which lines are red by marking the green ones as
%% 1's and the red with 0's
%%
%% This is followed by the time of the cycle.
1,0,30
0,1,30
```
For each light cycle, signify which lights are active and which lights are not. Each line must have the total number of lights denoted by the *pinmap.dat* and one more for the time of the cycle. Each line in *pinmap.dat* is a new trafflic light. For example:

```matlab
%%For each Light Signal, mark down the pin used.
%%For example, if pin 1 is red and pin 2 is green,
%%Create a line 1,2
1,2
3,4
```