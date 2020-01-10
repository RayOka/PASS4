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
		LED0 : out std_logic_vector(6 downto 0);
		LED1 : out std_logic_vector(6 downto 0);
		LED2 : out std_logic_vector(6 downto 0);
		LED3 : out std_logic_vector(6 downto 0);
		MLED : out std_logic_vector(6 downto 0)
	);
end DATAPATH;

architecture RTL of DATAPATH is
	
	signal TUNLOCK : std_logic;
	signal TNUM : std_logic_vector(15 downto 0);
	signal TDIGIT : std_logic_vector(1 downto 0);
	signal TDISP0, TDISP1, TDISP2, TDISP3, TMDISP : std_logic_vector(3 downto 0);
	
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
	end component;
	
	component LEDDEC
		port (
			DATA : in std_logic_vector(3 downto 0);
			LEDOUT : out std_logic_vector(6 downto 0)
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
		CLK=>CLK, FLASH=>EN100MSEC, UNLOCK=>TUNLOCK, MODE_N=>TMODE, DIGIT=>TDIGIT, NUM=>TNUM,
		DISP0=>TDISP0, DISP1=>TDISP1, DISP2=>TDISP2, DISP3=>TDISP3, MDISP=>TMDISP
	);
	
	U4 : LEDDEC port map (
		DATA=>TDISP0, LEDOUT=>LED0
	);
	U5 : LEDDEC port map (
		DATA=>TDISP1, LEDOUT=>LED1
	);
	U6 : LEDDEC port map (
		DATA=>TDISP2, LEDOUT=>LED2
	);
	U7 : LEDDEC port map (
		DATA=>TDISP3, LEDOUT=>LED3
	);
	
	U8 : LEDDEC port map (
		DATA=>TMDISP, LEDOUT=>MLED
	);
	
	UNLOCK_N <= TUNLOCK;
	
end RTL;