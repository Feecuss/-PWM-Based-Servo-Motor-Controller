library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.round;

entity motor is
  port (
    clk : in std_logic;
    rst : in std_logic;
    en : in std_logic;
    en_cnt : in std_logic;
    position : in std_logic_vector (4 downto 0);
    pos : out std_logic_vector (4 downto 0);
    led : out std_logic_vector (4 downto 0);
    pwm : out std_logic
  );
end motor;


architecture rtl of motor is
  constant clk_hz : real := 100.0e6;
  constant min_count : integer := 100000; -- perioda
  constant max_count : integer := 200000; --perioda
  constant cycles_per_step : integer := 20000;

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
    
        if current_position = 0 then
        led <= "00001";
        end if;
        if current_position = 1 then
        led <= "00011";
        end if;
        if current_position = 2 then
        led <= "00111";
        end if;
        if current_position = 3 then
        led <= "01111";
        end if;
        if current_position = 4 then
        led <= "11111";
        end if;
        
    pos <= std_logic_vector (to_unsigned(current_position, pos'length));
    
  end process;

end architecture;