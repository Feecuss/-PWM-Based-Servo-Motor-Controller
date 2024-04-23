-- Code your design here
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PWM_controller is
	
    Port ( 
    	clk		: in STD_LOGIC;
        en		: in STD_LOGIC;
        rst 	: in STD_LOGIC;
        left	: in STD_LOGIC;
        right	: in STD_LOGIC;
        count	: in STD_LOGIC_VECTOR(9 downto 0);
        pwm		: out STD_LOGIC;
        pos     : out STD_LOGIC_VECTOR(4 downto 0);
        sw      : in STD_LOGIC
    );
end PWM_controller;

architecture behavioral of PWM_controller is 
	signal width : integer range 0 to 250; 

begin

    process(clk)
    begin
    if(rising_edge(clk)) then
        if rst = '1' then
          pwm <= '0';        
          width <= 100;
        elsif left = '1' and width < 250 and sw = '1' then
          width <= width + 5;
        elsif right = '1' and width > 50 and sw = '1' then
          width <= width - 5;
        end if;
    
        if en = '1' then
          if count = 0 then	
            pwm <= '1';
          elsif width < count then
            pwm <= '0';
          end if;
        end if;
        
        
        pos <= (others => '1');
        
        if width < 55 then
            pos(0) <= '0';
            pos <= (others => '1');
        end if;
        if width < 100 and width > 55 then
            pos(1) <= '0';
            pos <= (others => '1');
        end if;
        if width < 150 and width > 100 then
            pos(2) <= '0';
            pos <= (others => '1');
        end if;
        if width < 200 and width > 150 then
            pos(3) <= '0';
            pos <= (others => '1');
        end if;
        if width < 250 and width > 200 then
            pos(4) <= '0';
            pos <= (others => '1');
        end if;
        
     end if;
  end process;    
  
    


end architecture behavioral;
