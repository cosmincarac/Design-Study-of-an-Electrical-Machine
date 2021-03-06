# Design Study of an Electrical Machine for the U.S. Department of Energy FreedomCAR 2020 project

Intro
---

This project represents my Final Year University Project, where I designed a high performance electric motor, which met the U.S. Department of Energy FreedomCAR 2020 project targets.

Objectives
---

1. Literature review of electrical machine design principles and equations 
1. Analytical model
   1. Create an analytical model based on machine design equations 
   1. Use the analytical model to get the initial sizing parameters of machine design
1. Finite element analysis
   1. Input initial sizing parameters from analytical model into Motor-CAD
   1. Validate analytical model
1. Sensitivity analysis
   1. Varying key parameters with an optimisation algorithm to improve the design 
1. Final electrical machine design
   1. Finalise a machine design based on information learned from the sensitivity analysis  
1. Final thesis

Scripts
---

__Motor Geometry Analytical Model.m__ - This Matlab script contained a series of motor design equations used to generate the geometric parameters for the initial MotorCAD motor model.

__MotorCAD Simulation Design.mot__ - The initial geometrical parameters were used to generate this model. The simulation was run, using Finite Element Analysis, to generate the magnetic, thermal and performance characteristics of the motor. 

__Sensitivity Analysis.m__ - This Matlab script was used for varying specific geometric of the motor design in order improve performance and meet the FreedomCAR 2020 Targets.

FreedomCAR 2020 Targets vs Results
---

Requirements | DoE Targets | Final Design
------------ | ------------- | -------------
Peak Power | 58.6 kW | 58.6 kW
Rated Power | 29.3 kW | 31.5 kW
Peak Torque | 200 Nm | 200.01 Nm
Rated Torque | 20 Nm | 20.13 Nm
Rated Speed | 2800 rpm | 2800 rpm
Top Speed | 14000 rpm | 14925 rpm
Max. Torque Ripple  | 5 % | 4.12 %
DC Link Voltage | 325 V | 325 V
Max. per phase current | 400 A | 398 A
Max. Diameter | 250 mm | 250 mm
Max. Length | 200 mm | 200 mm
Min. Peak Efficiency  | 95 % | 94.84 %

Final Design - Radial and Axial View
---

Images are presented from the final MotorCAD electric motor design:

![FinalDesign](https://user-images.githubusercontent.com/63413381/104093153-94c28680-5280-11eb-97c6-cd570d89c311.PNG)

