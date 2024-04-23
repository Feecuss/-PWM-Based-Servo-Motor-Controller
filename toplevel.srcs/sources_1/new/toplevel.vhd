library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( clk100MHz : in STD_LOGIC;
           BTNC : in std_logic;
           BTNR : in std_logic;
           BTNU : in std_logic;
           BTND : in std_logic;
           BTNL : in std_logic;
           SW : in STD_LOGIC_vector(1 downto 0);
           JA : out STD_LOGIC_vector(2 downto 1);
           LED : out std_logic_vector(4 downto 0)
           );

end top_level;

architecture Behavioral of top_level is
--components
component simple_counter
generic (
   N_BITS : integer
);
port (
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           count : out   std_logic_vector(N_BITS - 1 downto 0)
);
end component;

component clock_enable_fast
generic (
    n1_periods : integer := 2000000
);
port (
           clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           pulse_fast    : out STD_LOGIC
);
end component;

component clock_enable_slow
generic (
    n2_periods : integer := 50000
);
port (
           clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           pulse_slow    : out STD_LOGIC
);
end component;

component PWM_controller
port (
    	clk		: in STD_LOGIC;
        en		: in STD_LOGIC;
        rst 	: in STD_LOGIC;
        left	: in STD_LOGIC;
        right	: in STD_LOGIC;
        pos_count	: in STD_LOGIC_VECTOR(9 downto 0);
        pwm		: out STD_LOGIC;
        pos     : out STD_LOGIC_VECTOR(4 downto 0);
        en_sw      : in STD_LOGIC
);
end component;

signal sig_slow : std_logic;
signal sig_fast : std_logic;
signal sig_pos : std_logic_vector(9 downto 0);

begin

fast : clock_enable_fast
generic map (
   n1_periods => 50000
)
port map (
   clk => clk100MHz,
   rst => BTNC,
   pulse_fast => sig_fast
);

slow : clock_enable_slow
generic map (
   n2_periods => 2000000
)
port map (
   clk => clk100MHz,
   rst => BTNC,
   pulse_slow => sig_slow
);

count : simple_counter
generic map (
   N_BITS => 10
)
port map (
   clk => clk100MHz,
   rst => BTNC,
   en => sig_fast,
   count => sig_pos
    );

pwm1 : PWM_controller
port map (
   clk => clk100MHz,
   rst => BTNC,
   en => sig_slow,
   left => BTNL,
   right => BTNU,
   pos_count => sig_pos,
   en_sw => SW(0),
   pos => LED,
   pwm => JA(1)
   
);

pwm2 : PWM_controller
port map (
   clk => clk100MHz,
   rst => BTNC,
   en => sig_slow,
   left => BTND,
   right => BTNR,
   pos_count => sig_pos,
   en_sw => SW(1),
   pos => LED,
   pwm => JA(2)
   
);
end Behavioral;
