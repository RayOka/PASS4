library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CHANGER is
	port (
		CLK : in std_logic;
		RSTN : in std_logic;
		DEC : in std_logic;
		INC : in std_logic;
		TLEFT : in std_logic;
		TRIGHT : in std_logic;
		TNUM : out std_logic_vector(15 downto 0);
		DIGITN : out std_logic_vector(1 downto 0)
	);
end CHANGER;

architecture RTL of CHANGER is

	signal D0, D1, D2, D3 : std_logic_vector(3 downto 0);
	signal TDIGIT : std_logic_vector(1 downto 0);
	
	constant MAXVALUE : std_logic_vector(3 downto 0)
							:= "1001";
							
	constant ZEROVALUE : std_logic_vector(3 downto 0)
							 := "0000";
	
	constant MAXDIGIT : std_logic_vector(1 downto 0)
							:= "11";
							
	constant ZERODIGIT : std_logic_vector(1 downto 0)
							 := "00";
							 
begin 
	
	process (CLK, RSTN, DEC, INC, TLEFT, TRIGHT) begin
		if (RSTN = '0') then
			TDIGIT <= ZERODIGIT;
			D0 <= ZEROVALUE;
			D1 <= ZEROVALUE;
			D2 <= ZEROVALUE;
			D3 <= ZEROVALUE;
		elsif (CLK'event and CLK = '1') then
			if (DEC = '1') then
				if (TDIGIT = "00") then
					if (D0 = ZEROVALUE) then
						D0 <= MAXVALUE;
					else
						D0 <= D0 - 1;
					end if;
				elsif (TDIGIT = "01") then
				if (D1 = ZEROVALUE) then
						D1 <= MAXVALUE;
					else
						D1 <= D1 - 1;
					end if;
				elsif (TDIGIT = "10") then
					if (D2 = ZEROVALUE) then
						D2 <= MAXVALUE;
					else
						D2 <= D2 - 1;
					end if;
				elsif (TDIGIT = "11") then
					if (D3 = ZEROVALUE) then
						D3 <= MAXVALUE;
					else
						D3 <= D3 - 1;
					end if;
				end if;
			elsif (INC = '1') then
				if (TDIGIT = "00") then
					if (D0 = MAXVALUE) then
						D0 <= ZEROVALUE;
					else
						D0 <= D0 + 1;
					end if;
				elsif (TDIGIT = "01") then
					if (D1 = MAXVALUE) then
						D1 <= ZEROVALUE;
					else
						D1 <= D1 + 1;
					end if;
				elsif (TDIGIT = "10") then
					if (D2 = MAXVALUE) then
						D2 <= ZEROVALUE;
					else
						D2 <= D2 + 1;
					end if;
				elsif (TDIGIT = "11") then
					if (D3 = MAXVALUE) then
						D3 <= ZEROVALUE;
					else
						D3 <= D3 + 1;
					end if;
				end if;
			elsif (TLEFT = '1') then
				if (TDIGIT = ZERODIGIT) then
					TDIGIT <= MAXDIGIT;
				else
					TDIGIT <= TDIGIT - 1;
				end if;
			elsif (TRIGHT = '1') then
				if (TDIGIT = MAXDIGIT) then
					TDIGIT <= ZERODIGIT;
				else
					TDIGIT <= TDIGIT + 1;
				end if;
			end if;
		end if;
	end process;
	
	TNUM(15 downto 12) <= D0;
	TNUM(11 downto 8) <= D1;
	TNUM(7 downto 4) <= D2;
	TNUM(3 downto 0) <= D3;
	DIGITN <= TDIGIT;
	
end RTL;