# my_flightmare
copy of flightmare files corrected for installing it as a docker container



download this repository on you computer in a folder named `flightmare_src`
```
git clone git@github.com:giovisca-github/flightmare.git
```
go to the folder you downloaded build the docker images 
```Docker
docker build -t flightmare_simulator ./flightmare
```
run the image:
```
docker run -it -v $(pwd)/flightmare:/root/catkin_ws/src/flightmare --rm --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=all  -p 10253:10253 -p 10254:10254 --name flightmare_container flightmare_simulator
```
## install dependencies

on the docker container run:
```bash
    cd src
    vcs-import < flightmare/flightros/dependencies.yaml

```
at this point you should have all the dependencies installed inside the folder `catkin_ws`
open a new terminal by running on the host:
```
docker exec -it flightmare_container bash 
```

### download unity executable 
place on the flightmare/flightrender folder

### how to use
build the catkin_ws 
 source the `~/catkin_ws/devel/setup.bash`

Install Unity Binary from https://github.com/uzh-rpg/flightmare/releases
