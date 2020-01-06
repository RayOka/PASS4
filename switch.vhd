library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SWITCH is
	port (
		CLK : in std_logic;			-- global clock
		RSTN : in std_logic;			-- key input asynohronous RESET
		A_N : in std_logic;			-- key input A
		B_N : in std_logic;			-- key input B
		ENTER_N : in std_logic; 	-- key input ENTER
		A_ONE : out std_logic;		-- A one-shot
		B_ONE : out std_logic;		-- B one-shot
		ENTER_ONE : out std_logic 	-- ENTER one-shot
	);
end SWITCH;

architecture RTL of SWITCH is

	signal DIVCOUNT : std_logic_vector(14 downto 0);
	signal ENABLE : std_logic;
	signal ABEFORE_N : std_logic;
	signal BBEFORE_N : std_logic;
	signal ENTERBEFORE_N : std_logic;
	
begin
	SAMPLING_COUNTER : process (CLK,RSTN) begin
		if (RSTN = '0' ) then
			ENABLE <= '0';
			DIVCOUNT <= "000000000000000";
		elsif ( CLK'event and CLK = '1' ) then
			if (DIVCOUNT = "00000000000000") then -- for 1msec
				ENABLE <= '1';
			else
				ENABLE <= '0';
				DIVCOUNT <= DIVCOUNT + 1;
			end if;
		end if;
	end process;
	
	A_SWITCH : process (CLK, RSTN) begin
		if (RSTN = '0') then
			A_ONE <= '0';
			ABEFORE_N <= '1';
		elsif ( CLK'event and CLK = '1') then
			if (ENABLE = '1') then
				if (A_N = '0' and ABEFORE_N = '1') then
					A_ONE <= '1';
				else
					A_ONE <= '0';
				end if;
				ABEFORE_N <= A_N;
			else
				A_ONE <= '0';
			end if;
		end if;
	end process;
		
	B_SWITCH : process (CLK, RSTN) begin
		if (RSTN = '0') then
			B_ONE <= '0';
			BBEFORE_N <= '1';
		elsif ( CLK'event and CLK = '1') then
			if (ENABLE = '1') then
				if (B_N = '0' and BBEFORE_N = '1') then
					B_ONE <= '1';
				else
					B_ONE <= '0';
				end if;
				BBEFORE_N <= B_N;
			else
				B_ONE <= '0';
			end if;
		end if;
	end process;
	
	ENTER_SWITCH : process (CLK, RSTN) begin
		if (RSTN = '0') then
			ENTER_ONE <= '0';
			ENTERBEFORE_N <= '1';
		elsif ( CLK'event and CLK = '1') then
			if (ENABLE = '1') then
				if (ENTER_N = '0' and ENTERBEFORE_N = '1') then
					ENTER_ONE <= '1';
				else
					ENTER_ONE <= '0';
				end if;
				ENTERBEFORE_N <= ENTER_N;
			else
				ENTER_ONE <= '0';
			end if;
		end if;
	end process;
	
end RTL;