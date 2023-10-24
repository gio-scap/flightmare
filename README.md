# my_flightmare
copy of flightmare files corrected for installing it as a docker container

## download dependencies

```bash
sudo apt-get install python3-vcstool
```
download this repository on you computer in a folder named `flightmare_src`
```
git clone git@github.com:giovisca-github/flightmare.git

```
on the same folder run:
```
vcs-import < flightmare/flightros/dependencies.yaml
```
in this way all the packages are downloaded on the host machine

build the docker images 
```Docker
docekr buil -t flightmare_simulator ./flightmare
```
run the image:
```
docker run -it -v $(pwd):/root/catkin_ws/src --rm --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=all  -p 10253:10253 -p 10254:10254 --name flightmare_container flightmare_simulator
```
to open a new terminal run on the host:
```
docker exec -it flightmare_container bash 
```

### download unity executable 
place on the flightmare/flightrender folder

### how to use
build the catkin_ws 
 source the `~/catkin_ws/devel/setup.bash`

aaaas
