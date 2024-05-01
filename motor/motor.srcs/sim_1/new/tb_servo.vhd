library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;

entity motor_tb is
end motor_tb; 

architecture sim of motor_tb is


  constant clk_period : time := 10ns;
  signal en : std_logic := '1';
  signal clk : std_logic := '1';
  signal position : std_logic_vector (2 downto 0);
  signal rst : std_logic := '1';
  signal pos : std_logic_vector (2 downto 0);
  signal pwm : std_logic;

begin

  clk <= not clk after clk_period / 2;

  DUT : entity work.motor(rtl)
  port map (
    en => en,
    clk => clk,
    rst => rst,
    position => position,
    pwm => pwm,
    pos => pos
  );

  STIMULI : process
  begin
    rst <= '0';
    wait for 10ns;
    position <= "001";
    wait for 50ms;
        position <= "010";
    wait for 50ms;
        position <= "011";
    wait for 50ms;
        position <= "100";
    wait for 50ms;
        position <= "101";
    wait for 50ms;
        position <= "110";
    wait for 50ms;
        position <= "111";
    wait for 10 * clk_period;


    finish; -- End simulation
  end process;

end architecture;