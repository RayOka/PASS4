library  ieee;
use ieee.std_logic_1164.all;

entity DATAPATH is
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
		TRESET : out std_logic;
		LED0 : out std_logic_vector(7 downto 0);
		LED1 : out std_logic_vector(7 downto 0);
		LED2 : out std_logic_vector(7 downto 0);
		LED3 : out std_logic_vector(7 downto 0)
	);
end DATAPATH;

architecture RTL of DATAPATH is
	
	signal TUNLOCK : std_logic;
	signal TNUM : std_logic_vector(15 downto 0);
	signal TDIGIT : std_logic_vector(1 downto 0);
	signal DISP0, DISP1, DISP2, DISP3 : std_logic_vector(3 downto 0);
	
	component CHANGER 
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
	end component;
	
	component VALIDATION
		port (
			CLK : in std_logic;
			ENTER_N : in std_logic;
			NUM_N : in std_logic_vector(15 downto 0);
			UNLOCK_N : out std_logic;
			RESET_N : out std_logic
		);
	end component;

	component DISP_CTL
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
	end component;
	
	component LEDDEC
		port (
			DATA : in std_logic_vector(3 downto 0);
			TMODE: in std_logic;
			LEDOUT : out std_logic_vector(7 downto 0)
		);
	end component;
	
begin

	U1 : CHANGER port map (
		CLK=>CLK, RSTN=>RESET, DEC=>TDEC, INC=>TINC, TLEFT=>TLEFT,
		TRIGHT=>TRIGHT, TNUM=>TNUM, DIGITN=>TDIGIT
	);
	
	U2 : VALIDATION port map (
		CLK=>CLK, ENTER_N=>TENTER, NUM_N=>TNUM,
		UNLOCK_N=>TUNLOCK, RESET_N=>TRESET
	);
	
	U3 : DISP_CTL port map (
		FLASH=>EN100MSEC, UNLOCK=>TUNLOCK, DIGIT=>TDIGIT, NUM=>TNUM,
		DISP0=>DISP0, DISP1=>DISP1, DISP2=>DISP2, DISP3=>DISP3
	);
	
	U4 : LEDDEC port map (
		DATA=>DISP0, TMODE=>TMODE, LEDOUT=>LED0
	);
	U5 : LEDDEC port map (
		DATA=>DISP1, TMODE=>TMODE, LEDOUT=>LED1
	);
	U6 : LEDDEC port map (
		DATA=>DISP2, TMODE=>TMODE, LEDOUT=>LED2
	);
	U7 : LEDDEC port map (
		DATA=>DISP3, TMODE=>TMODE, LEDOUT=>LED3
	);
	
	UNLOCK_N <= TUNLOCK;
	
end RTL;