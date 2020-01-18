library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CONTROL is
	port (
		CLK : in std_logic;
		RSTN : in std_logic;
		MODE : in std_logic;
		A : in std_logic;
		B : in std_logic;
		ENTER : in std_logic;
		UNLOCK : in std_logic;
		TDEC : out std_logic;
		TINC : out std_logic;
		TLEFT : out std_logic;
		TRIGHT : out std_logic
	);
end CONTROL;

architecture RTL of CONTROL is
	
	type STATE is (VALUE_ST, DIGIT_ST, DEC_ST, INC_ST, LEFT_ST, RIGHT_ST, UNLOCK_ST);
	signal CURRENT_STATE, NEXT_STATE : STATE;
	
begin
	
	STATE_SET : process(CLK, RSTN, MODE) begin
		if (RSTN = '0') then
			if (MODE = '1') then
				CURRENT_STATE <= VALUE_ST;
			else
				CURRENT_STATE <= DIGIT_ST;
			end if;
		elsif (CLK'event and CLK='1') then
			CURRENT_STATE <= NEXT_STATE;
		end if;
	end process;
	
	STATE_TRANS : process(MODE, A, B, ENTER, UNLOCK, CURRENT_STATE) begin
		if (CURRENT_STATE = VALUE_ST) then
			if (A = '1') then
				NEXT_STATE <= DEC_ST;
			elsif (B = '1') then
				NEXT_STATE <= INC_ST;
			elsif (MODE = '0') then
				NEXT_STATE <= DIGIT_ST;
			elsif (UNLOCK = '1') then
				NEXT_STATE <= UNLOCK_ST;
			else
				NEXT_STATE <= VALUE_ST;
			end if;
		elsif (CURRENT_STATE = DIGIT_ST) then
			if (A = '1') then
				NEXT_STATE <= LEFT_ST;
			elsif (B = '1') then
				NEXT_STATE <= RIGHT_ST;
			elsif (MODE = '1') then
				NEXT_STATE <= VALUE_ST;
			elsif (UNLOCK = '1') then
				NEXT_STATE <= UNLOCK_ST;
			else
				NEXT_STATE <= DIGIT_ST;
			end if;
		elsif (CURRENT_STATE = DEC_ST) then
			NEXT_STATE <= VALUE_ST;
		elsif (CURRENT_STATE = INC_ST) then
			NEXT_STATE <= VALUE_ST;
		elsif (CURRENT_STATE = LEFT_ST) then
			NEXT_STATE <= DIGIT_ST;
		elsif (CURRENT_STATE = RIGHT_ST) then
			NEXT_STATE <= DIGIT_ST;
		elsif (CURRENT_STATE = UNLOCK_ST) then
			if (ENTER = '1') then
				if (MODE = '0') then
					NEXT_STATE <= VALUE_ST;
				else
					NEXT_STATE <= DIGIT_ST;
				end if;
			end if;
		end if;
	end process;
	
	OUTPUT : process(CURRENT_STATE) begin
		if (CURRENT_STATE = VALUE_ST) then
			TDEC <= '0';
			TINC <= '0';
			TLEFT <= '0';
			TRIGHT <= '0';
		elsif (CURRENT_STATE = DEC_ST) then
			TDEC <= '1';
			TINC <= '0';
			TLEFT <= '0';
			TRIGHT <= '0';
		elsif (CURRENT_STATE = INC_ST) then
			TDEC <= '0';
			TINC <= '1';
			TLEFT <= '0';
			TRIGHT <= '0';
		elsif (CURRENT_STATE = DIGIT_ST) then
			TDEC <= '0';
			TINC <= '0';
			TLEFT <= '0';
			TRIGHT <= '0';
		elsif (CURRENT_STATE = LEFT_ST) then
			TDEC <= '0';
			TINC <= '0';
			TLEFT <= '1';
			TRIGHT <= '0';
		elsif (CURRENT_STATE = RIGHT_ST) then
			TDEC <= '0';
			TINC <= '0';
			TLEFT <= '0';
			TRIGHT <= '1';
		elsif (CURRENT_STATE = DIGIT_ST) then
			TDEC <= '0';
			TINC <= '0';
			TLEFT <= '0';
			TRIGHT <= '0';
		elsif (CURRENT_STATE = UNLOCK_ST) then
			TDEC <= '0';
			TINC <= '0';
			TLEFT <= '0';
			TRIGHT <= '0';
		end if;
	end process;
	
end RTL;