library ieee;
use ieee.std_logic_1164.all;
use ieee. std_logic_unsigned.all;

entity CLKDOWN is
	port (
		CLK : in std_logic;			-- global clock 50MHz
		RSTN : in std_logic;			-- global reset signal
		EN100MSEC : out std_logic	-- enable (100m sec interval)
	);
end CLKDOWN;
		
architecture RTL of CLKDOWN is

	signal COUNT23 : std_logic_vector(22 downto 0);
							 
	constant MAX23BIT : std_logic_vector(22 downto 0)
						   :="10011000100101101000000";
--							:="00000000000000000000011";		-- for simulation
						  
   constant ZERO23BIT : std_logic_vector(22 downto 0)
							:= "00000000000000000000000";
							 
begin
	
	process(CLK, RSTN) begin
		if (RSTN = '0') then
			COUNT23 <= MAX23BIT;
			EN100MSEC <= '0';
		elsif (CLK'event and CLK = '1') then
			if (COUNT23 = ZERO23BIT) then
				COUNT23 <= MAX23BIT;
				EN100MSEC <= '1';
			else
				COUNT23 <= COUNT23 - 1;
				EN100MSEC <= '0';
			end if;
		end if;
	end process;
			
end RTL;
					