library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity VALIDATION is
	port (
		CLK : in std_logic;
		RSTN : in std_logic;
		ENTER_N : in std_logic;
		NUM_N : in std_logic_vector(15 downto 0);
		UNLOCK_N : out std_logic;
		RESET_N : out std_logic
	);
end VALIDATION;

architecture RTL of VALIDATION is
	
	constant PASS : std_logic_vector(15 downto 0)
					  := "0111010100011001";		-- 7519
	
begin

	process (CLK, RSTN, ENTER_N, NUM_N) begin
		if (RSTN = '0') then
			UNLOCK_N <= '0';
		elsif (CLK'event and CLK = '1') then
			if (ENTER_N = '1') then
				if (NUM_N = PASS) then
					UNLOCK_N <= '1';
				else
					UNLOCK_N <= '0';
					RESET_N <= '0';
				end if;
			else
				RESET_N <= '1';
			end if;
		end if;
	end process;
	
end RTL;
					