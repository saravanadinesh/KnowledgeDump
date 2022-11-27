# pid.py -------------------------------------------------------------------------------------
#   Simulates Proportional-Integral-Derivative control using a drone flying to a certain height
# and a heater heating up a liquid
# --------------------------------------------------------------------------------------------
# TODO: Convert this to plotly 
import math
import matplotlib.pyplot as plt
import numpy as np

# Drone flying to a certin height
sim_iterations = 100 # seconds. We will assume that 1 iteration = 1 second
set_point = 100 # meters in height
Kp = 0.08   # The output of all P, I, D blocks is voltage going to the propeller.
Ki = 0.01  # Let us arbitrarily assume that the propeller function that converts voltage to 
Kd = 0.1   # force is a linear function outputting 50N for 5V and 250N at 12V and that 12V is 
            # the max voltage

drone_weight = 5    # kilograms
gravitational_force = drone_weight*9.8  # newtons

current_height = 0  # meters
prev_height = 0
acc_error = 0
heights = np.zeros(sim_iterations) 

# Iterations
for i in range(sim_iterations):
    heights[i] = current_height # Just a variable for collecting all the current_heights for 
                                # visualization purposes
    error = set_point - current_height
    p_out = Kp*error;
    acc_error = acc_error + error
    i_out = Ki*acc_error
    if i != 0:
        d_out = Kd*(error - prev_error)
    else:
        d_out = 0
   
    cv = p_out + i_out + d_out  # Control variable (volts) . Traditionally referred to as u(t)
                                # in block diagrams. 
    if cv > 12:
        cv = 12 # motor max voltage is 12 votls
    if cv < 0:
        cv = 0  # motor max voltage cannot be negative
    
    propeller_force = (200/7) * (cv-5) + 50 
    
    effective_force = propeller_force - gravitational_force
    acceleration = effective_force/drone_weight

    # Update height variables
    prev_height = current_height
    current_height = acceleration * 1/2 + current_height # Since acceleration is a constant  
    if current_height < 0:
        current_height = 0 # Drone can't go below the surface

    prev_error = error

fig1,ax1 = plt.subplots()
ax1.plot(np.arange(0,sim_iterations), heights, color='blue', linewidth=3)
plt.show()
