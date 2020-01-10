library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity DISP_CTL is
	port (
		CLK : in std_logic;
		FLASH : in std_logic;
		UNLOCK : in std_logic;
		MODE_N : in std_logic;
		DIGIT : in std_logic_vector(1 downto 0);
		NUM : in std_logic_vector(15 downto 0);
		DISP0 : out std_logic_vector(3 downto 0);
		DISP1 : out std_logic_vector(3 downto 0);
		DISP2 : out std_logic_vector(3 downto 0);
		DISP3 : out std_logic_vector(3 downto 0);
		MDISP : out std_logic_vector(3 downto 0)
	);
end DISP_CTL;

architecture RTL of DISP_CTL is

begin
	
	DISP : process(FLASH, UNLOCK, DIGIT) begin
		if (CLK'event and CLK = '1') then
			if (UNLOCK = '1') then
				DISP0 <= "1111";
				DISP1 <= "1111";
				DISP2 <= "1111";
				DISP3 <= "1111";
			else
				DISP0 <= NUM(15 downto 12);
				DISP1 <= NUM(11 downto 8);
				DISP2 <= NUM(7 downto 4);
				DISP3 <= NUM(3 downto 0);
				if (FLASH = '1') then
					if (DIGIT = "00") then
						DISP0 <= "1100";
					elsif (DIGIT = "01") then
						DISP1 <= "1100";
					elsif (DIGIT = "10") then
						DISP2 <= "1100";
					elsif (DIGIT = "11") then
						DISP3 <= "1100";
					end if;
				end if;
			end if;
		end if;
	end process;
	
	MODE : process(MODE_N) begin
		if (CLK'event and CLK = '1') then
			if (MODE_N = '0') then
				MDISP <= "0000";
			elsif (MODE_N = '1') then
				MDISP <= "0001";
			end if;
		end if;
	end process;
		
end RTL;