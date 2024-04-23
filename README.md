# Topic 3: PWM-Based Servo Motor Controller

## Rozdělení rolí:

  Ondřej Pulpit má na starosti programování a sestavování schéma
  
  Filip Rákos je zodpovědný za programování
  
  Lukáš Poláček pomáhá s programováním a stará se o GitHub

## Teoretický popis a vysvětlení
Naše skupina si zvolila PWM-Based Servo Motor Controller. Základní ovládaní bude probíhat pomocí tlačítek a to ovládání motorů a resetu. Switch bude sloužit k zapnutí nebo vypnutí motoru. Clock_enable_slow bude sloužit pro řízení PWM a Clock_enable_fast pro rychlost čítače a tím i rychlost otáčení motoru právě díky střídě.

## Schéma projektu:

![image](https://github.com/Feecuss/PWM-Based-Servo-Motor-Controller/assets/165302466/0cdd67f1-5dfc-44ef-ac10-77c279308322)

## Deska NEXYS A7-50t
![image](https://github.com/Feecuss/PWM-Based-Servo-Motor-Controller/assets/165302466/2c7c87aa-d130-43c4-8428-c5c4d612e36e)

## Dílčí kódy
### PWM
Tento kód implementuje řídicí jednotku PWM (Pulse Width Modulation). Když je aktivován signál en, kontroluje šířku pulsu PWM na výstupu pwm podle stavu signálů left a right, které slouží k nastavení šířky pulsu doleva a doprava. Signál en_sw řídí možnost změny šířky pulsu. Dále kód generuje vektor pos, který indikuje pozici šířky pulsu pomocí jednotlivých bitů v závislosti na hodnotě width.

