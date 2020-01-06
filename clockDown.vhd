library ieee;
use ieee.std_logic_1164.all;
use ieee. std_logic_unsigned.all;

entity CLKDOWN is
	port (
		CLK : in std_logic;			-- global clock 50MHz
		RSTN : in std_logic;			-- global reset signal
		ENABLE : out std_logic;		-- enable (1 sec interval)
		EN100MSEC : out std_logic	-- enable (100m sec interval)
	);
end CLKDOWN;
		
architecture RTL of CLKDOWN is
	signal COUNT26 : std_logic_vector(25 downto 0);
	signal COUNT23 : std_logic_vector(22 downto 0);
	
	constant MAX26BIT : std_logic_vector(25 downto 0)
--				         := "10111110101111000010000000";
							:= "00000000000000000000000010";
							
	constant ZERO26BIT : std_logic_vector(25 downto 0)
				          := "00000000000000000000000000";
							 
	constant MAX23BIT : std_logic_vector(22 downto 0)
						   :="10011000100101101000000";
						  
   constant ZERO23BIT : std_logic_vector(22 downto 0)
							:= "00000000000000000000000";
							 
begin

	TIMER1SEC : process (CLK, RSTN) begin
		if (RSTN = '0') then
			COUNT26 <= ZERO26BIT;
			ENABLE <= '0';
		elsif (CLK'event and CLK = '1') then
			if (COUNT26 = ZERO26BIT) then
				COUNT26 <= MAX26BIT;
				ENABLE <= '1';
			else
				COUNT26 <= COUNT26 - 1;
				ENABLE <= '0';
			end if;
		end if;
	end process;
	
	TIMER100MSEC : process(CLK, RSTN) begin
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
					