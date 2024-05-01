# Topic 3: PWM-Based Servo Motor Controller

## Roles:

  Ondřej Pulpit is in charge of programming and drawing up the scheme
  
  Filip Rákos is responsible for programming
  
  Lukáš Poláček helps with programming and takes care of GitHub

## Theoretical description and explanation

This project appears to be a servo motor controller implemented on an FPGA using VHDL. It consists of three main components: a clock enable module (clk_en_50), a motor module (motor), and a top-level module (toplevl).

The clk_en_50 module generates pulses with a frequency of 50Hz, serving as a timing reference for the servo motor control.

The motor module controls the servo motor's behavior based on input signals such as clock, reset, enable, position settings, and switches. It calculates the duty cycle of the PWM signal based on the desired position of the servo motor.

The toplevl module serves as the top-level entity integrating the clock enable module and two instances of the motor module for controlling two servo motors. It interfaces with the FPGA's switches and LEDs for input and output visualization.

## Project diagram:

![image](https://github.com/Feecuss/PWM-Based-Servo-Motor-Controller/assets/165302466/0cdd67f1-5dfc-44ef-ac10-77c279308322)

## Board NEXYS A7-50t
![image](https://github.com/Feecuss/PWM-Based-Servo-Motor-Controller/assets/165302466/2c7c87aa-d130-43c4-8428-c5c4d612e36e)

## Partical codes
### clock_en_50
This VHDL code defines an entity named "clk_en_50" which generates a periodic pulse signal with a frequency of 50Hz (20ms period). The code uses a clock input of 100MHz and a reset signal. Inside the architecture, there's a process that increments a counter on each rising edge of the clock until it reaches a count corresponding to the specified period. When the count matches the period minus one, it generates a pulse signal. The pulse signal remains low otherwise. The counter resets on a reset signal or when it reaches the specified period.

### motor
This VHDL code defines an entity named "motor" for controlling a servo motor. It takes inputs including clock, reset, enable signals, position setting, and generates outputs including a PWM signal, LED indicators for position and servo status. Inside the architecture, there are processes for counting, generating PWM signals based on the duty cycle, and updating the duty cycle based on the selected position. LEDs indicate the current position and whether the servo is active. The duty cycle of the PWM signal is adjusted based on the selected position, controlling the motor's angle.

### toplevel
This VHDL code defines the top-level module "toplevl" which integrates two servo motors controlled by switches on an FPGA board. It takes inputs such as clock, servo positions from switches, enable signals, and a reset signal. Outputs include PWM signals for the servo motors, LED indicators for position and servo status, and PWM outputs for each servo. Inside the architecture, instances of the "clk_en_50" component generate a 50Hz pulse used for synchronizing servo control, while instances of the "motor" component control each servo's behavior based on the provided inputs.

## Images from an oscilloscope

### Maximum position 2ms
