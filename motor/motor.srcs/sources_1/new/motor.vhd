library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.round;

entity motor is
  port (
    clk : in std_logic; --internal clock of 100MHz
    rst : in std_logic; -- reset
    en : in std_logic;  -- enable of setting the duty cycle
    en_cnt : in std_logic; -- puts counter ON/OFF with 50Hz
    position : in std_logic_vector (2 downto 0); -- switches on FPGA to set position
    pos : out std_logic_vector (2 downto 0); -- output of position, only for simulations
    led : out std_logic_vector (7 downto 0); -- indicates the position on FPGA by leds
    led_en : out std_logic; -- FPGA indicates if servo is on or off, for 1st servo it is blue, for 2nd it is red
    pwm : out std_logic -- PWM output
  );
end motor;

architecture rtl of motor is
  constant min_count : integer := 100000; -- minimal period [
  constant max_count : integer := 200000; --maximal period
  constant cycles_per_step : integer := 14286; --

  constant counter_max : integer := 1999999; --delka periody pwm
  signal counter : integer range 0 to counter_max;

  signal duty_cycle : integer range 0 to max_count;
  signal   current_position : integer range 0 to 7 ;
  
begin

  COUNTER_PROC : process(clk)
  begin
    if rising_edge(clk) and en = '1' then
      if rst = '1' then
        counter <= 0;   
      else
        if counter < counter_max  then
          counter <= counter + 1;
        else
          counter <= 0;
        end if;

      end if;
    end if;
  end process;

  PWM_PROC : process(clk)
  begin
    if rising_edge(clk) and en = '1' then
      if rst = '1' then
        pwm <= '0';
      else
       pwm <= '0';

        if counter < duty_cycle then
          pwm <= '1';
        end if;

      end if;
    end if;
  end process;
  
  DUTY_CYCLE_PROC : process(clk)
  begin
    current_position <= to_integer(unsigned(position));
    if rising_edge(clk) and en = '1' then
    
        duty_cycle <= current_position * cycles_per_step + min_count;
        
    end if;
    
    -- setting leds depending on current_position and if servo is on or 
    
        
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
        
    if en = '1' then
        led_en <= '1';     
    else    
        led_en <= '0';
    end if;
        
    pos <= std_logic_vector (to_unsigned(current_position, pos'length));
    
  end process;

end architecture;