library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity LEDDEC is
	port (
		DATA : in std_logic_vector(3 downto 0);
		TMODE: in std_logic;
		LEDOUT : out std_logic_vector(7 downto 0)
	);
end LEDDEC;

architecture RTL of LEDDEC is
begin
	process (DATA, TMODE, TUNLOCK) begin
		if (TMODE = '1') then
			case DATA is
				when "0000" => LEDOUT <= "11000000";
				when "0001" => LEDOUT <= "11111001";
				when "0010" => LEDOUT <= "10100100";
				when "0011" => LEDOUT <= "10110000";
				when "0100" => LEDOUT <= "10011001";
				when "0101" => LEDOUT <= "10010010";
				when "0110" => LEDOUT <= "10000010";
				when "0111" => LEDOUT <= "11110000";
				when "1000" => LEDOUT <= "10000000";
				when "1001" => LEDOUT <= "10010000";
				when "1100" => LEDOUT <= "11111111";	-- FLASH
				when "1111" => LEDOUT <= "10111111";	-- UNLOCK
				when others => LEDOUT <= "10110110";	-- unspecified
			end case;
		else
			case DATA is
				when "0000" => LEDOUT <= "01000000";
				when "0001" => LEDOUT <= "01111001";
				when "0010" => LEDOUT <= "00100100";
				when "0011" => LEDOUT <= "00110000";
				when "0100" => LEDOUT <= "00011001";
				when "0101" => LEDOUT <= "00010010";
				when "0110" => LEDOUT <= "00000010";
				when "0111" => LEDOUT <= "01110000";
				when "1000" => LEDOUT <= "00000000";
				when "1001" => LEDOUT <= "00010000";
				when "1100" => LEDOUT <= "11111111";	-- FLASH
				when "1111" => LEDOUT <= "10111111";	-- UNLOCK
				when others => LEDOUT <= "00110110";	-- unspecified
			end case;
		end if;
	end process;
end RTL;