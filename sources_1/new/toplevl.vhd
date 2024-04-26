----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2024 23:21:47
-- Design Name: 
-- Module Name: toplevl - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity toplevl is
 Port ( 
        CLK : in std_logic;
        SW1 : in std_logic_vector (4 downto 0);
        SW2 : in std_logic_vector (4 downto 0); -- ovládací tlaèítka
        SW_en1 : in std_logic; --zapnutí 1. motorku
        SW_en2 : in std_logic; -- zapnutí 2. motorku
        SW_rst : in std_logic;
        LED1 : out std_logic_vector (4 downto 0);
        LED2 : out std_logic_vector (4 downto 0); --2 ledky by mìli chybìt pro signalizaci zapnutí motorku, pøivést na sw_en
        JA : out std_logic;
        JB : out std_logic
        
 );
end toplevl;

architecture Behavioral of toplevl is

component clk_en_50
generic (
    PERIOD : integer
);
port (
           clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           pulse    : out STD_LOGIC
);
end component;

component motor

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
end component;

signal sig_pulse : std_logic;

begin

clock_en : clk_en_50
generic map (
   PERIOD => 2000000
)
port map (
   clk => CLK,
   rst => SW_rst,
   pulse => sig_pulse
);

PWM1 : motor
port map (
   clk => CLK,
   rst => SW_rst,
   en => SW_en1,
   en_cnt => sig_pulse,
   position => SW1,
   led => LED1(4 downto 0),
   pwm => JA

);

PWM2 : motor
port map (
   clk => CLK,
   rst => SW_rst,
   en => SW_en2,
   en_cnt => sig_pulse,
   position => SW2,
   led => LED2(4 downto 0),
   pwm => JB

);

end Behavioral;
