---------------------------------------------------------------------------------
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
        CLK : in std_logic; -- Internal clock 100MHz
        SW1 : in std_logic_vector (2 downto 0); --Switches for position of 1st servo
        SW2 : in std_logic_vector (2 downto 0); --Switches for position of 2nd servo
        SW_en1 : in std_logic; -- Enable switch for 1st servo
        SW_en2 : in std_logic; -- Enable switch for 1st servo
        SW_rst : in std_logic; -- Stop switch
        LED1 : out std_logic_vector (7 downto 0); -- LEDs on FPGA for better reading of position 1st  servo
        LED2 : out std_logic_vector (7 downto 0); ---- LEDs on FPGA for better reading of position 1st  servo
        LED_en1 : out std_logic; -- blue led indicates if 1st servo is on
        LED_en2 : out std_logic; -- red led indicates if 2nd servo is on
        JA : out std_logic; --PWM output of 1st servo
        JB : out std_logic --PWM output of 2nd servo
        
 );
end toplevl;

architecture Behavioral of toplevl is
 
--comoponents of servo
component motor
port (
        clk : in std_logic;
        rst : in std_logic;
        en : in std_logic;
        position : in std_logic_vector (2 downto 0);
        pos : out std_logic_vector (2 downto 0);
        led : out std_logic_vector (7 downto 0);
        led_en : out std_logic;
        pwm : out std_logic
);
end component;

begin

-- port map of 1st servo
PWM1 : motor
port map (
   clk => CLK,
   rst => SW_rst,
   en => SW_en1,
   position => SW1,
   led => LED1(7 downto 0),
   led_en => LED_en1,
   pwm => JA

);
-- port map of 2nd servo
PWM2 : motor
port map (
   clk => CLK,
   rst => SW_rst,
   en => SW_en2,
   position => SW2,
   led => LED2(7 downto 0),
   led_en => LED_en2,
   pwm => JB

);

end Behavioral;
