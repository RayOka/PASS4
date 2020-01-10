library ieee;
use ieee.std_logic_1164.all;
entity TBPASS4 is
end TBPASS4;
architecture TBPASS4 of TBPASS4 is
	component PASS4
		port (
			CLK : in std_logic;
			RESET : in std_logic;
			MODE : in std_logic;
			A : in std_logic;
			B : in std_logic;
			ENTER : in std_logic;
			LED0 : out std_logic_vector(6 downto 0);
			LED1 : out std_logic_vector(6 downto 0);
			LED2 : out std_logic_vector(6 downto 0);
			LED3 : out std_logic_vector(6 downto 0)
	);
end component;

	signal TBCLK : std_logic;
	signal TBRESET : std_logic;
	signal TBMODE : std_logic;
	signal TBA, TBB : std_logic;
	signal TBENTER : std_logic;
	signal TBLED0, TBLED1, TBLED2, TBLED3 : std_logic_vector(6 downto 0);
begin

	U1 : PASS4 port map (
		CLK=>TBCLK, RESET=>TBRESET, MODE=>TBMODE, A=>TBA, B=>TBB, ENTER=>TBENTER,
		LED0=>TBLED0, LED1=>TBLED1, LED2=>TBLED2, LED3=>TBLED3
	);
	
	process begin
		TBCLK <= '0'; wait for 50 ns;
		TBCLK <= '1'; wait for 50 ns;
	end process;
	
	process begin
		TBRESET <= '0'; wait for 80 ns;
		TBRESET <= '1'; wait;
	end process;
	
	process begin
		TBMODE <= '0'; wait for 200 ns;
		TBA <= '0'; wait for 200 ns;
		TBA <= '1'; wait for 200 ns;			-- DIGIT = 01
		TBA <= '0'; wait for 200 ns;
		TBA <= '1'; wait for 200 ns;			-- DIGIT = 10
		
		TBMODE <= '1'; wait for 200 ns;
		TBA <= '0'; wait for 200 ns;
		TBA <= '1'; wait for 200 ns;
		TBA <= '0'; wait for 200 ns;
		TBA <= '1'; wait;							-- LED2 = 10100100
	end process;
	
end TBPASS4;

configuration CFG_TBPASS4 of TBPASS4 is
	for TBPASS4
		for U1 : PASS4
		end for;
	end for;
end;