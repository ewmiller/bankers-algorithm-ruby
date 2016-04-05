# Banker's Algorithm in Ruby

This is a Ruby implementation of the [Banker's Algorithm](https://en.wikipedia.org/wiki/Banker%27s_algorithm). There are two parts to the program, as described below.

**Part 1** is a program that analyzes a given system state and determines if the state is safe or not. State is represented by a specifically formatted text file, which lists the number of processes and resources, as well as what resources the processes will request and in what amount. If deadlock is possible given this information, the program will report that the state is unsafe. If it is a safe state, an example of a safe sequence will be provided.

**Part 2** involves multithreading. One Banker thread runs alongside m Customer threads. The customers request resources from the banker, or notify the banker that they have released resources. The banker thread must manage resources. This part of the program also uses text files, to determine the starting state of the system.

## Usage

To run part one, enter `rake one` from the main directory. For part two, `rake two`. To run both, simply type `rake`.
