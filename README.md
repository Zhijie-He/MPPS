# MPPS : Research on a Model of Multi-Project Parallel Scheduling with Flexible Competitive Collaboration Planning

Codebase for [MPPS: Research on a Model of Multi-Project Parallel Scheduling with Flexible Competitive Collaboration Planning
](https://www.hanspub.org/journal/PaperInformation.aspx?paperID=27483)

<p align="center">
<img src="https://github.com/HybridRobotics/GenLoco/blob/main/motion_imitation/data/genloco.gif" width="80%" height="80%"/>
</p>

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
- `2` X axis is the total time of all project and Y axis is the total cost of all projects.
- `3` X axis is the expected time of project A ,Y axis is the expected time of project B, and Z axis is the total cost of all projects.

## Result






