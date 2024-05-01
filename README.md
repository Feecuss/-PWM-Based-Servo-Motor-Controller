# Topic 3: PWM-Based Servo Motor Controller

## Roles:

  Ondřej Pulpit is in charge of programming and drawing up the scheme
  
  Filip Rákos is responsible for programming
  
  Lukáš Poláček helps with programming and takes care of GitHub

## Teoretický popis a vysvětlení
Naše skupina si zvolila PWM-Based Servo Motor Controller. Základní ovládaní bude probíhat pomocí tlačítek a to ovládání motorů a resetu. Switch bude sloužit k zapnutí nebo vypnutí motoru. Clock_enable_slow bude sloužit pro řízení PWM a Clock_enable_fast pro rychlost čítače a tím i rychlost otáčení motoru právě díky střídě.

## Schéma projektu:

![image](https://github.com/Feecuss/PWM-Based-Servo-Motor-Controller/assets/165302466/0cdd67f1-5dfc-44ef-ac10-77c279308322)

## Deska NEXYS A7-50t
![image](https://github.com/Feecuss/PWM-Based-Servo-Motor-Controller/assets/165302466/2c7c87aa-d130-43c4-8428-c5c4d612e36e)

## Dílčí kódy
### PWM
Tento kód implementuje řídicí jednotku PWM (Pulse Width Modulation). Když je aktivován signál en, kontroluje šířku pulsu PWM na výstupu pwm podle stavu signálů left a right, které slouží k nastavení šířky pulsu doleva a doprava. Signál en_sw řídí možnost změny šířky pulsu. Dále kód generuje vektor pos, který indikuje pozici šířky pulsu pomocí jednotlivých bitů v závislosti na hodnotě width.

### Clock_enable_slow
Tento kód implementuje modul pro generování pomalého impulzního signálu na výstupu pulse_slow s periodou definovanou generickým parametrem PERIOD, který výchozí hodnotou má 2000000 (což odpovídá frekvenci 50 Hz). Signál clk je vstupní hodinový signál, zatímco rst je vstup pro resetování modulu. Modul generuje impulzy s délkou jednoho taktu hodin na výstupu pulse_slow, přičemž se synchronizuje s hranami náběžné hrany hodinového signálu clk a respektuje stav signálu rst pro resetování čítače.

### Clock_enable_fast
Tento kód implementuje modul pro generování rychlého impulzního signálu na výstupu pulse_fast s periodou definovanou generickým parametrem PERIOD, který výchozí hodnotou má 200000 (což odpovídá frekvenci 500 Hz). Signál clk je vstupní hodinový signál, zatímco rst je vstup pro resetování modulu. Modul generuje impulzy s délkou jednoho taktu hodin na výstupu pulse_fast, přičemž se synchronizuje s hranami náběžné hrany hodinového signálu clk a respektuje stav signálu rst pro resetování čítače.

### Top_level
Tento kód implementuje vrchní úroveň systému, který zahrnuje moduly pro generování rychlého a pomalého impulzního signálu (clock_enable_fast a clock_enable_slow). Dále obsahuje dva instance modulu PWM_controller, které řídí PWM signály pro dva servomotory, přičemž vstupy těchto modulů jsou ovládány tlačítky (BTNL, BTNU, BTND, BTNR) a přepínači (SW(0), SW(1)). Signál clk100MHz je vstupní hodinový signál systému.
