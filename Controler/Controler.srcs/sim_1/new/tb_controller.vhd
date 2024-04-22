-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 3.4.2024 09:34:05 UTC

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_PWM_controller is
end tb_PWM_controller;

architecture tb of tb_PWM_controller is

    component PWM_controller
        port (clk   : in std_logic;
              en    : in std_logic;
              rst   : in std_logic;
              left  : in std_logic;
              right : in std_logic;
              count : in std_logic_vector (10 downto 0);
              pwm   : out std_logic;
              pos   : out std_logic_vector (4 downto 0);
              sw    : in std_logic
  );
    end component;

    signal clk   : std_logic;
    signal en    : std_logic;
    signal rst   : std_logic;
    signal left  : std_logic;
    signal right : std_logic;
    signal count : std_logic_vector (10 downto 0);
    signal pwm   : std_logic;
    signal pos   : std_logic_vector (4 downto 0);
    signal sw    : std_logic;

    constant TbPeriod : time := 100 ps; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : PWM_controller
    port map (clk   => clk,
              en    => en,
              rst   => rst,
              left    => left,
              right   => right,
              count => count,
              pwm   => pwm,
              pos => pos,
              sw => sw
);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        en <= '1';
        left <= '1';
        right <= '0';
        count <= (others => '0');

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for 1 ns;
        rst <= '0';
        wait for 1 ns;

        -- EDIT Add stimuli here
        
        for i in 0 to 10000 loop
            wait for 1* TbPeriod;
            count <= count + 1;
        end loop;
        
        
        
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_PWM_controller of tb_PWM_controller is
    for tb
    end for;
end cfg_tb_PWM_controller;
