library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity motor is
  port (
    clk : in std_logic; --internal clock of 100MHz
    rst : in std_logic; -- stop
    en : in std_logic;  -- enable of setting the duty cycle
    position : in std_logic_vector (2 downto 0); -- switches on FPGA to set position
    pos : out std_logic_vector (2 downto 0); -- output of position, only for simulations
    led : out std_logic_vector (7 downto 0); -- indicates the position on FPGA by leds
    led_en : out std_logic; -- FPGA indicates if servo is on or off, for 1st servo it is blue, for 2nd it is red
    pwm : out std_logic -- PWM output
  );
end motor;

architecture rtl of motor is
  constant min_count : integer := 100000; -- minimal period [1 ms] 
  constant max_count : integer := 200000; --maximal period [2 ms]
  constant cycles_per_step : integer := 14286; --signal period control [1.4286 ms]
  constant counter_max : integer := 1999999; --max value of counter, lenght of period pwm
  
  signal counter : integer range 0 to counter_max; --signal for counter
  signal duty_cycle : integer range 0 to max_count; --signal for duty cycle of pwm signal
  signal current_position : integer range 0 to 7 ; --signal for current position of pwm motor
  
begin

  COUNTER_PROC : process(clk)
  begin
    if rising_edge(clk) and en = '1' then --condition for the rising edge and enable
      if rst = '1' then --condition for active rst
        counter <= 0; --the counter will be reset      
      else
        if counter < counter_max  then --condition for not exceeding the maximum value
          counter <= counter + 1; --adding the value of the counter
        else
          counter <= 0; --the counter will be reset
        end if;

      end if;
    end if;
  end process;

  PWM_PROC : process(clk)
  begin
    if rising_edge(clk) and en = '1' then --condition for the rising edge and enable
      if rst = '1' then --condition for active rst
        pwm <= '0'; --pwm is set to 0
      else
       pwm <= '0'; --pwm is seto to 0

        if counter < duty_cycle then --if the counter value is less than the dutycycle value
          pwm <= '1'; --pwm is set to 1
        end if;

      end if;
    end if;
  end process;
  
  DUTY_CYCLE_PROC : process(clk)
  begin
    current_position <= to_integer(unsigned(position)); --converting a binary position value to an integer and assigns it to signal 
    if rising_edge(clk) and en = '1' then --condition for the rising edge and enable
        duty_cycle <= current_position * cycles_per_step + min_count; --calculating a duty cycle based on position, cycles per step, and a minimum count
    end if;
    
    -- setting leds depending on current_position and if servo is on or off        
        if current_position = 0 then
        led <= "00000001";
        end if;
        if current_position = 1 then
        led <= "00000011";
        end if;
        if current_position = 2 then
        led <= "00000111";
        end if;
        if current_position = 3 then
        led <= "00001111";
        end if;
        if current_position = 4 then
        led <= "00011111";
        end if;
        if current_position = 5 then
        led <= "00111111";
        end if;
        if current_position = 6 then
        led <= "01111111";
        end if;
        if current_position = 7 then
        led <= "11111111";
        end if;
    -- setting leds depending if servo is on or off (blue and red)     
    if en = '1' then
        led_en <= '1';     
    else    
        led_en <= '0';
    end if;
        
    pos <= std_logic_vector (to_unsigned(current_position, pos'length)); --converting an integer to a standard logic vector and assigns it to pos
    
  end process;

end architecture;
