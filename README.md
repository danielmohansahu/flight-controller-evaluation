# flight-controller-evaluation
Simulation evaluation of several different open source Flight Controllers

### Set up Development Environment

Install prerequisites:
```bash
# @TODO nvidia-docker, docker, etc.
```

Build docker image and drop into a container:
```bash
./build_and_run.sh
```

### Build Instructions

@TODO

### Launch

In one terminal, run the following the launch a quadcopter world.
```bash
gz sim -r --render-engine ogre `realpath worlds/windy_quadcopter.sdf`
```

You can run commands from another terminal to directly command the quad and/or update wind speed:
```bash
# command all 4 motors to 700 RPM
gz topic -t /X3/gazebo/command/motor_speed --msgtype gz.msgs.Actuators -p 'velocity:[700, 700, 700, 700]'

# command a hurricane
gz topic -t "/world/windy_quadcopter/wind/" -m gz.msgs.Wind  -p "linear_velocity: {x:-50, y:50}, enable_wind: true"
```
