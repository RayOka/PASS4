library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CHANGER is
	port (
		CLK : in std_logic;
		RSTN : in std_logic;
		TDEC : in std_logic;
		TINC : in std_logic;
		TLEFT : in std_logic;
		TRIGHT : in std_logic;
		TNUM : out std_logic_vector(15 downto 0);
		DIGITN out std_logic_vector(1 downto 0)
	);
end CHANGER;

architecture RTL of CHANGER is

	signal D0, D1, D2, D3 : std_logic_vector(3 downto 0);
	signal TDIGIT : std_logic_vector(
		