The goal is to restrict container cpu consumption. 
The test uses an Alpine-based container runnign the application stress. 

Use the included script to spawn as many containers as needed:
> ./multi.sh ajnouri/stress-cpu-alpine <nbr-of-container> {docker option to test}

Use docker stats for monitoring CPU resource consumption of the spawned containers: 
> docker stats $(for i in {1..5}; do echo -n "test-container$i "; done)


1- Let's first observe 10 containers Without any restriction. By default, all containers will share the totality of cpu of all cores.  
- https://youtu.be/7oAE-hQLxHU

2- Now let's set max cpu% restriction per container using docker run option **--cpu-quota=x000 (x%)**  
- https://youtu.be/8NZagDhZ9kU

3- It is also possible to assign containers to specific cpu cores using **--cpuset="<core1>,<core2>,..."**  
- https://youtu.be/C-YmHp0PZIw

