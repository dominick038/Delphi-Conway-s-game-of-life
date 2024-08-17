# Conway's Game of Life - Delphi Implementation

## Introduction

Conway's Game of Life is a cellular automaton devised by mathematician John Horton Conway in 1970. This Delphi implementation provides a graphical and interactive simulation of the Game of Life, where you can observe the evolution of cell patterns based on simple rules.

## Features

- **Interactive Simulation:** Start, pause, and step through the simulation using keyboard controls.
- **Random Initialization:** Generate a new random grid of living and dead cells.
- **Real-time Evolution:** Watch the grid evolve over time with a configurable timer.
- **Customizable Grid:** 30x30 grid where each cell’s state is automatically wrapped around the edges.
- **Generation Counter:** Keep track of the number of generations that have passed.

## Installation
### Prerequisites
- **Delphi IDE**: Any version of Embarcadero RAD Studio that supports SKIA.
- **Windows Operating System**: Required to run the Delphi application.

### Setup
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/dominick038/cDelphi-Conway-s-game-of-life.git
2. **Open the Project:**
- Navigate to the project directory and open the .dproj file in the Delphi IDE.
3. **Build and Run:**
- Compile and run the project using the Delphi IDE

## Usage
### Controls
- **Spacebar:** Pause/Resume the simulation.
- **Right Arrow Key:** Step through the simulation one generation at a time (only works when paused).
- **R Key**: Reset the grid with a new random configuration and reset the generation counter (only works when paused).


## How it Works
- **Grid Initialization:** The grid is randomly initialized with a 10% chance of any cell being alive.
- **Evolution Rules:** Each cell's state in the next generation is determined by its 8 neighbors:
- **Underpopulation:** A living cell with fewer than 2 live neighbors dies.
- **Overpopulation:** A living cell with more than 3 live neighbors dies.
- **Reproduction:** A dead cell with exactly 3 live neighbors becomes alive.
- **Survival:** A living cell with 2 or 3 live neighbors survives.

## Example

https://github.com/user-attachments/assets/bb4bab7a-9ff2-46b1-8f73-a494df2365ef

