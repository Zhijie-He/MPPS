# MPPS : Research on a Model of Multi-Project Parallel Scheduling with Flexible Competitive Collaboration Planning

Codebase for [MPPS: Research on a Model of Multi-Project Parallel Scheduling with Flexible Competitive Collaboration Planning
](https://www.hanspub.org/journal/PaperInformation.aspx?paperID=27483) 

<p align="center">
<img src="https://github.com/Zhijie-He/MPPS/blob/main/images/MPPS_generation_3d.gif" width="80%" height="80%"/>
</p>

## Abstract

To solve the resource conflict in the process of implementation of the multi-project management, a model of multi-project parallel scheduling with flexible competitive collaboration planning in which tasks can be outsourced arbitrarily and be competed among multiple partners was proposed to minimize the total cost of the projects and the duration of each project. According to the characteristic of the problem, this paper designed **an improved NSGA-II algorithm for the scheduling model**, including the three-dimensional chromosome encoding scheme to identify the attributes of collaboration ratio, partners and priorities. With the practice project confirmation, the practicality of this model and the validity of this algorithm are verified. The optimization method can effectively coordinate the resource allocation among projects and improve the efficiency of multi project management as well.

## Getting Started
We use this repository with MATLAB2016a Windows.

Get code: `git clone https://github.com/Zhijie-He/MPPS.git`

## Running the code
Use MATLAB open project and put all files in the same workspace.
```bash
nsga_2(pop, gen)
```
- `--pop` specifies the size of population.
- `--gen` sepcifies the number of generations (iterations).

Enter the number of objective functions : 2 or 3
- `2` in this case, X axis is the total time of all project and Y axis is the total cost of all projects.
- `3` in this case, X axis is the expected time of project A ,Y axis is the expected time of project B, and Z axis is the total cost of all projects.

## Project Configure
In the Const.m file, we preset the project information, here we use two project data as simulation, including the relationship between tasks, required resources and the cost and time of insourcing and outsourcing.

## Results

###  2 Objective functions
<img src="https://github.com/Zhijie-He/MPPS/blob/main/images/MPPS_generation_2d.gif"/>

<img src="https://github.com/Zhijie-He/MPPS/blob/main/images/visualization_2d.png"/>

### 3 Objective functions

<p align="center">
<img src="https://github.com/Zhijie-He/MPPS/blob/main/images/MPPS_generation_3d.gif" width="80%" height="80%"/>
</p>

<p align="center">
<img src="https://github.com/Zhijie-He/MPPS/blob/main/images/MPPS_generation_3d_rotation.gif" width="80%" height="80%"/>
</p>

### Gante Chart
<p align="center">
<img src="https://github.com/Zhijie-He/MPPS/blob/main/images/project_gante.png"/>
</p>



