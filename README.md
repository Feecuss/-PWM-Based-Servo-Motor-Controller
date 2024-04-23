# Topic 3: PWM-Based Servo Motor Controller

## Rozdělení rolí:

  Ondřej Pulpit má na starosti programování a sestavování schéma
  
  Filip Rákos je zodpovědný za programování
  
  Lukáš Poláček pomáhá s programováním a stará se o GitHub


## Schéma projektu:

![image](https://github.com/Feecuss/PWM-Based-Servo-Motor-Controller/assets/165302466/0cdd67f1-5dfc-44ef-ac10-77c279308322)

## Deska NEXYS A7-50t
![image](https://github.com/Feecuss/PWM-Based-Servo-Motor-Controller/assets/165302466/2c7c87aa-d130-43c4-8428-c5c4d612e36e)


## Teoretický popis
Naše skupina si vybrala projekt PWM-Based Servo Motor Controller. Pomocí tlačítek se budou ovládat motory a reset. Switch se bude používat pro zapnutí a vypnutí motoru.
Clock_enable_slow bude sloužit na řízení PWM a Clock_enable_fast zase řídí rychlost čítače a tím pádem tedy rychlost otáčení motoru právě díky střídě.
