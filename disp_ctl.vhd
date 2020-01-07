library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity DISP_CTL is
	port (
		FLASH : in std_logic;
		UNLOCK : in std_logic;
		DIGIT : in std_logic_vector(1 downto 0);
		NUM : in std_logic_vector(15 downto 0);
		DISP0 : out std_logic_vector(3 downto 0);
		DISP1 : out std_logic_vector(3 downto 0);
		DISP2 : out std_logic_vector(3 downto 0);
		DISP3 : out std_logic_vector(3 downto 0)
	);
end DISP_CTL;

architecture RTL of DISP_CTL is

	signal D0, D1, D2, D3 : std_logic_vector(3 downto 0);

begin

	INIT : process (NUM, DIGIT) begin
		D0 <= NUm(3 downto 0);
		D1 <= NUm(7 downto 4);
		D2 <= NUM(11 downto 8);
		D3 <= NUM(15 downto 12);
	end process;
	
	DISP : process(FLASH, UNLOCK, MODE, DIGIT) begin
		if (UNLOCK = '0') then
			if (DIGIT = "00" and FLASH = '1') then
				D0 <= "1100";
			elsif (DIGIT = "01" and FLASH = '1') then
				D1 <= "1100";
			elsif (DIGIT = "10" and FLASH = '1') then
				D2 <= "1100";
			elsif (DIGIT = "11" and FLASH = '1') then
				D3 <= "1100";
		else
			D0 <= "1111";
			D1 <= "1111";
			D2 <= "1111";
			D3 <= "1111";
		end if;
	end process;
	
end RTL;