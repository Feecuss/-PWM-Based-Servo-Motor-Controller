library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;

entity motor_tb is
end motor_tb; 

architecture sim of motor_tb is


  constant clk_period : time := 10ns;
  signal en_cnt : std_logic := '1';
  signal en : std_logic := '1';
  signal clk : std_logic := '1';
  signal rst : std_logic := '1';
  signal left : std_logic := '0';
  signal right : std_logic := '0';
  signal pos : integer range 0 to 4;
  signal pwm : std_logic;

begin

  clk <= not clk after clk_period / 2;

  DUT : entity work.motor(rtl)
  port map (
    en => en,
    en_cnt => en_cnt,
    clk => clk,
    rst => rst,
    left => left,
    right => right,
    pos => pos,
    pwm => pwm
  );

  STIMULI : process
  begin
    wait for 10 * clk_period;
    rst <= '0';
    for i in 0 to 25000 loop
    en_cnt <= '1';
    wait for 10ms;
    en_cnt <= '0';
    wait for 10ms;
    end loop;
    -- Test moving left
    left <= '0';
    right <= '1';
    wait for 100ms;
    left <= '1';
    right <= '0';
    wait for 100ms;


    finish; -- End simulation
  end process;

end architecture;