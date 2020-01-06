library ieee;
use ieee.std_logic_1164.all;

entity PASS4 is
	port (
		CLK, RESET, MODE, A, B, ENTER : in std_logic;
		LED0, LED1, LED2, LED3 : out std_logic_vector(7 downto 0)
	);
end PASS4;

architecture RTL of PASS4 is

	signal TDATA : std_logic_vector(3 downto 0);
	signal TDIGIT, TUNLOCK : std_logic;
	
component SWITCH port (
		CLK : in std_logic;			-- global clock
		RSTN : in std_logic;			-- key input asynohronous RESET
		A_N : in std_logic;			-- key input A
		B_N : in std_logic;			-- key input B
		ENTER_N : in std_logic; 	-- key input ENTER
		A_ONE : out std_logic;		-- A one-shot
		B_ONE : out std_logic;		-- B one-shot
		ENTER_ONE : out std_logic 	-- ENTER one-shot
	);
end component;

begin

end RTL;