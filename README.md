# ABC PSO Path Planning
- ABC + PSO Path Planning Problem

<div align="justify">

- Here, system tries to find the most optimal path between starting point and destination point with aid of Artificial Bee Colony (ABC) algorithm and Particle Swarm Optimization (PSO) algorithm combined. It is good strategy in robotics path finding. In each run new obstacles in new positions defines and a curved line tries to find the best path. Run multiple times to find the best result. 


</div>



- Hope this code help you :)

![ABC+PSO Path Planning](https://user-images.githubusercontent.com/11339420/151452025-793a0df1-524e-404f-83fb-fddcbc43ad22.gif)

<div align="justify">

This project implements a hybrid Artificial Bee Colony (ABC) and Particle Swarm Optimization (PSO) algorithm for robotic path planning. The objective is to find the most optimal path between a starting point and a destination while avoiding obstacles.



</div>


## Features
- Combines ABC and PSO for robust optimization.
- Handles dynamic obstacle placement.
- Generates feasible paths using spline interpolation.
- Visualizes the path with obstacles in 2D space.

## Table of Contents
1. [Overview](#overview)
2. [Algorithms](#algorithms)
3. [Code Files](#code-files)


---

## Overview
Path planning is crucial in robotics for navigating an environment with obstacles. This implementation uses:
- **Artificial Bee Colony (ABC)**: Mimics the foraging behavior of bees.
- **Particle Swarm Optimization (PSO)**: Simulates the social behavior of particles for optimization.

The combination leverages the exploratory strengths of ABC and the exploitative abilities of PSO for efficient pathfinding.

---

## Algorithms

### Artificial Bee Colony (ABC)
ABC simulates the behavior of honeybees to optimize a solution:
1. **Recruited Bees**: Exploit known solutions.
2. **Onlooker Bees**: Select good solutions probabilistically.
3. **Scout Bees**: Explore random solutions to avoid local optima.

### Particle Swarm Optimization (PSO)
PSO optimizes a solution by updating particle positions based on:
1. Personal best position.
2. Global best position.
3. Velocity influenced by inertia and learning coefficients.

### Hybrid Approach
The hybrid algorithm alternates between:
- ABC for global exploration.
- PSO for local exploitation.

---

## Code Files
1. **[ABC_PSO_PathPlanning.m](./ABC_PSO_PathPlanning.m)**: Main script to execute the algorithm.
2. **[Basics.m](./Basics.m)**: Defines the environment, including start/destination points and obstacles.
3. **[Cost.m](./Cost.m)**: Evaluates the cost of a given solution.
4. **[CRSolution.m](./CRSolution.m)**: Generates random candidate solutions.
5. **[Pars.m](./Pars.m)**: Parses and computes path properties like length and violations.
6. **[Plotting.m](./Plotting.m)**: Visualizes the path and obstacles.
7. **[RWSelection.m](./RWSelection.m)**: Implements roulette wheel selection for probabilistic choices.

