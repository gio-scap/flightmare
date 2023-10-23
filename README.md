# my_flightmare
copy of flightmare files corrected for installing it as a docker container

## download dependencies

```bash
sudo apt-get install python3-vcstool
```
download this repository on you computer in a folder named `flightmare_src`
```
git clone ...
```
on the same folder run:
```
vcs-import < flightmare/flightros/dependencies.yaml
```
in this way all the packages are downloaded on the host machine

build the image from the dockerfile
run it