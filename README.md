# DroneControl
__Thöni Andreas, Peer Samuel__ ___MA-MECH-25-VZ___  
Mathematical model of a drone in 3D-space, following specified waypoints. Controlled via LQR controller based on linearized model of the drone.

Advised Sequence of execution:
1. Run full DroneControlMain.mlx
2. Open DroneControlSimulink.slx
3. Open DataInsp_drone.mldatx
4. Run DroneControlSimulink.slx
5. Run DroneControlPlot.m

## File Structure

__Main File__
~~~
DroneControlMain.mlx
~~~
Run the entire script to initialize parameters and setup.

---

__Simulink Model__  
~~~
DroneControlSimulink.slx
~~~
Simulink file containing the model, control, etc. . Run main file first.

__Data Inspector Session__  
~~~
DataInsp_drone.mldatx
~~~
Data-Inspector session to visualize the position, angle and input information of the simulation.

---

__3D-Plot__  
~~~
DroneControlPlot.m
~~~
3D animated plot of the Simulink model's output data. Run Simulink model first.

---

__Linearization__  
~~~
DroneControlLinearization.mlx
~~~
Script for linearization of the non-linear model using syms.

__miscellaneous/__    
Directory containing files that helped in creating the mathematical model. Not needed for anything.
