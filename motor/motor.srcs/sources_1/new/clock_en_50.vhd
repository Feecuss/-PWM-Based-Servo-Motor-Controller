library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;  
use IEEE.std_logic_unsigned.all;

----------------------------------------------------------------------------------

entity clk_en_50 is

    generic(
            PERIOD : integer := 2000000 --determines the length of the periodic signal [20ms/50Hz]
            );

    Port ( clk      : in STD_LOGIC; --internal clock of 100MHz
           rst      : in STD_LOGIC; --reset
           pulse    : out STD_LOGIC); --output pulse
end clk_en_50;

----------------------------------------------------------------------------------

architecture Behavioral of clk_en_50 is

    constant BITS_NEEDED : integer := integer(ceil(log2(real(PERIOD+1)))); --calculating the number of bits needed to represent a given period
    signal sig_count : std_logic_vector(BITS_NEEDED - 1 downto 0); --count pulses that have a length corresponding to the specified period of the signal

begin
    p_clk_enable : process (clk) is
    begin

        if (rising_edge(clk)) then --condition for rising edge of clk
            if (rst = '1') then --condition for active rst               
                sig_count <= (others => '0'); --clear all bits of local counter               
                pulse <= '0'; -- set output `pulse` to low
            elsif (sig_count = PERIOD-1) then --condition for value of sig_count value equal to PERIOD-1                
                sig_count <= (others => '0'); --clear all bits of local counter                
                pulse <= '1'; --set output `pulse` to high
            else 
                
                sig_count <= sig_count +1; --increment local counter                
                pulse <= '0'; --set output `pulse` to low
            end if;
        end if;

    end process p_clk_enable;

end architecture behavioral;
