# ECE 102 Traffic Systems Coordinator

A simple traffic light controller using a LabJack and Matlab code!

### How to Use

This code is entirely modular and should not require any editing to use different pins or traffic light patterns. To use this, only edit the *DATA* files.

### CycleMap
Cycle Map is the map of the main traffic lights. It consists of 1's and 0's for the main cycle part. Each line is a part of the cycle, which defines what directions are active and for how long. This CycleMap must have the exact same number of columns + 1 as the *cyclepinmap.dat* which defines the pins used. The last column defines how long each cycle is and is excluded from any pin setting.

An example 4 way intersection with no rails.
```matlab
1,0,1,0,30
0,1,0,1,30
```
An example, a 4 way intersection using rails for aligned directions with 30 second delays.
```matlab
1,0,30
0,1,30
```

### PinMap
Pin Map is the data file which contains all the FIO pin numbers. Each line contains a new standalone traffic light or rail. For each line, a column must be created in the *cyclemap.dat* as stated above. There must be 3 columns, red, yellow, and green, in that order.

An example 4 way intersection with no rails.
```matlab
1,2,3
4,5,6
7,8,9
10,11,12
```
An example, a 4 way intersection using rails for aligned directions with 30 second delays.
```matlab
1,2,3
4,5,6
```

### WalkMap
Walk Map assignes which set of Walk Lights are assigned to which cycle. The number of lines of this file must match the number of lines in *CycleMap.dat*. Each column must correspond to a line in the *walkpinmap.dat* plus an extra one for the pin of the button that controls it.

You're going to need rails, so this is an example of a 4 way intersection with rail.
```matlab
1,0,1
0,1,2
```

### WalkPinMap
Walk Pin Map is the data file which contains all the FIO pin numbers for the Walk Signals. Each line contains a new standalone walk signal or rail. There must be 2 columns red and green.

```matlab
1,2
3,4
```

## License

This project is licensed under the MIT License. For more details, see the `LICENSE` file.
