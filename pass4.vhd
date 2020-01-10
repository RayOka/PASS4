library ieee;
use ieee.std_logic_1164.all;

entity PASS4 is
	port (
		CLK : in std_logic;
		RESET : in std_logic; 
		MODE : in std_logic;
		A : in std_logic;
		B : in std_logic;
		ENTER : in std_logic;
		LED0 : out std_logic_vector(6 downto 0);
		LED1 : out std_logic_vector(6 downto 0);
		LED2 : out std_logic_vector(6 downto 0);
		LED3 : out std_logic_vector(6 downto 0);
		MLED : out std_logic_vector(6 downto 0)
	);
end PASS4;

architecture RTL of PASS4 is
	
	signal TA : std_logic;
	signal TB : std_logic;
	signal TENTER : std_logic;
	signal TINC : std_logic;
	signal TDEC : std_logic;
	signal TRIGHT : std_logic;
	signal TLEFT : std_logic;
	signal TUNLOCK : std_logic;
	signal EN100MSEC : std_logic;
	
	component CLKDOWN
		port (
			CLK : in std_logic;			-- global clock 50MHz
			RSTN : in std_logic;			-- global reset signal
			EN100MSEC : out std_logic	-- enable (100m sec interval)
		);
	end component;
	
	component SWITCH 
		port (
			CLK : in std_logic;
			RSTN : in std_logic;
			A_N : in std_logic;
			B_N : in std_logic;
			ENTER_N : in std_logic;
			A_ONE : out std_logic;
			B_ONE : out std_logic;
			ENTER_ONE : out std_logic
		);
	end component;

	component CONTROL
		port (
			CLK : in std_logic;
			RSTN : in std_logic;
			MODE : in std_logic;
			A : in std_logic;
			B : in std_logic;
			UNLOCK : in std_logic;
			TDEC : out std_logic;
			TINC : out std_logic;
			TLEFT : out std_logic;
			TRIGHT : out std_logic
		);
	end component;
	
	component DATAPATH
		port (
			CLK : in std_logic;
			RESET : in std_logic;
			EN100MSEC : in std_logic;
			TMODE : in std_logic;
			TDEC : in std_logic;
			TINC : in std_logic;
			TLEFT :  in std_logic;
			TRIGHT : in std_logic;
			TENTER : in std_logic;
			UNLOCK_N : out std_logic;
			LED0 : out std_logic_vector(6 downto 0);
			LED1 : out std_logic_vector(6 downto 0);
			LED2 : out std_logic_vector(6 downto 0);
			LED3 : out std_logic_vector(6 downto 0);
			MLED : out std_logic_vector(6 downto 0)
		);
	end component;	

begin
	U1 : CLKDOWN port map (
		CLK=>CLK, RSTN=>RESET, EN100MSEC=>EN100MSEC
	);
		
	U2 : SWITCH port map (
		CLK=>CLK, RSTN=>RESET, A_N=>A, B_N=>B, ENTER_N=>ENTER,
		A_ONE=>TA, B_ONE=>TB, ENTER_ONE=>TENTER
	);
	
	U3 : CONTROL port map (
		CLK=>CLK, RSTN=>RESET, MODE=>MODE, A=>TA, B=>TB, UNLOCK=>TUNLOCK,
		TDEC=>TDEC, TINC=>TINC, TLEFT=>TLEFT, TRIGHT=>TRIGHT
	);
	
	U4 : DATAPATH port map (
		CLK=>CLK, RESET=>RESET, EN100MSEC=>EN100MSEC, TMODE=>MODE, TINC=>TINC,
		TDEC=>TDEC, TLEFT=>TLEFT, TRIGHT=>TRIGHT, TENTER=>TENTER, UNLOCK_N=>TUNLOCK,
		LED0=>LED0, LED1=>LED1, LED2=>LED2, LED3=>LED3, MLED=>MLED
	);

end RTL;