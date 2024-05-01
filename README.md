# Topic 3: PWM-Based Servo Motor Controller

## Roles:

  Ondřej Pulpit is in charge of programming
  
  Filip Rákos is responsible for programming
  
  Lukáš Poláček takes care of GitHub and editing video

## Theoretical description and explanation

This project appears to be a servo motor controller implemented on an FPGA using VHDL. It consists of two main components: a motor module (motor), and a top-level module (toplevl).

The motor module controls the servo motor's behavior based on input signals such as clock, reset, enable, position settings, and switches. It calculates the duty cycle of the PWM signal based on the desired position of the servo motor.

The toplevl module serves as the top-level entity integrating the clock enable module and two instances of the motor module for controlling two servo motors. It interfaces with the FPGA's switches and LEDs for input and output visualization.

## Project diagram:

![little_tru](https://github.com/Feecuss/PWM-Based-Servo-Motor-Controller/assets/165302466/f985309f-7486-422d-991b-b1a4ef5c602e)

## Board NEXYS A7-50t
![image](https://github.com/Feecuss/PWM-Based-Servo-Motor-Controller/assets/165302466/2c7c87aa-d130-43c4-8428-c5c4d612e36e)

### motor
This VHDL code defines an entity named "motor" for controlling a servo motor and is inspired from this website https://vhdlwhiz.com/. It takes inputs including clock, reset, enable signals, position setting, and generates outputs including a PWM signal, LED indicators for position and servo status. Inside the architecture, there are processes for counting, generating PWM signals based on the duty cycle, and updating the duty cycle based on the selected position. LEDs indicate the current position and whether the servo is active. The duty cycle of the PWM signal is adjusted based on the selected position, controlling the motor's angle.

### toplevel
This VHDL code defines the top-level module "toplevl" which integrates two servo motors controlled by switches on an FPGA board. It takes inputs such as clock, servo positions from switches, enable signals, and a reset signal. Outputs include PWM signals for the servo motors, LED indicators for position and servo status, and PWM outputs for each servo. Inside the architecture, instances of the "motor" component control each servo's behavior based on the provided inputs.

## Images from an oscilloscope

### Maximum position 2ms

![Snímek obrazovky 2024-05-01 153503](https://github.com/Feecuss/PWM-Based-Servo-Motor-Controller/assets/165302466/abcb97ed-a9f5-4213-be34-133a3f710852)

### Minimum position 1ms

![Snímek obrazovky 2024-05-01 153648](https://github.com/Feecuss/PWM-Based-Servo-Motor-Controller/assets/165302466/cad9c804-4af0-4e3d-a8d7-4886b01a02ee)

## Motor testbench

### Here is the engine testbench where the position value is changed. You can see the entire testbench here and then zoom in to see how it changes.

![111](https://github.com/Feecuss/PWM-Based-Servo-Motor-Controller/assets/165302466/de58e2d4-f73a-4d2c-b07d-beaebd9c3a46)
