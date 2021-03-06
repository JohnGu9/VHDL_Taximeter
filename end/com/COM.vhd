library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity com is
	port(wheel : in std_logic;
		CLK : in std_logic;				--1000Hz
		button_start : in std_logic;
		button_night : in std_logic;
		button_run_inc : in std_logic;
		button_run_de : in std_logic;
		button_wait_inc : in std_logic;
		button_wait_de : in std_logic;
		button_start_inc : in std_logic;
		button_start_de : in std_logic;
		pulse_detect :out std_logic;
		price : out std_logic_vector(15 downto 0);
		display_num3, display_num2, display_num1, display_num0 : out std_logic_vector(6 downto 0);
		sound0, sound1 : out std_logic;
		run_state_display, wait_state_display : out std_logic);
		
end;

architecture bhv of com is
component buzz
	port(pulse : in std_logic;
		CLK : in std_logic;
		sound : out std_logic);
end component;
component decode
    port (num4  : in std_logic_vector (3 downto 0);
          reset : in std_logic;
          num7  : out std_logic_vector(6 downto 0));
end component;
component h_l_detect
	port(CLK : in std_logic;							--1000Hz
		wheel : in std_logic;
		EN : out std_logic;
		clr : out std_logic);
end component;
component run
	port(EN : in std_logic;
		EN2 : in std_logic;
		start : in std_logic;
		wheel : in std_logic;	--2.5m 
		pulse : out std_logic);
end component;
component start_price
	port(wheel : in std_logic;
		rst : in std_logic;
		start_inc, start_de : in std_logic;
		unit_price : in std_logic_vector(15 downto 0);
		start : out std_logic;
		total_price : out std_logic_vector(15 downto 0));
end component;
component state
	port(button : in std_logic;
		 CLK : in std_logic;
		 EN: out std_logic;
		 RST:out std_logic);
end component;
component tobcd
    port (data : in std_logic_vector (15 downto 0);
          bcd3, bcd2, bcd1, bcd0 : out std_logic_vector (3 downto 0));
end component;
component unit_price
	port(rst : in std_logic; 
		run_pulse : in std_logic;
		wait_pulse : in std_logic;
		run_inc, run_de : in std_logic;
		wait_inc, wait_de : in std_logic; 
		night : in std_logic;
		price : out std_logic_vector(15 downto 0));		--*warning: unit--0.1yuan
end component;
component WIT
	port(EN : in std_logic;
		EN2 : in std_logic;
		start : in std_logic;
		CLK : in std_logic;		--1000Hz
		pulse : out std_logic);
end component;
component run_wait_state_display
	port(EN : in std_logic;
		start : in std_logic;
		run_state_display : out std_logic;
		wait_state_display : out std_logic);
end component;

signal EN, EN2, start, run_pulse, wait_pulse, rst : std_logic;
signal u_price, t_price : std_logic_vector(15 downto 0);
signal num3, num2, num1, num0 : std_logic_vector(3 downto 0);
begin
	hldetect : h_l_detect port map(CLK => CLK, wheel => wheel, EN =>EN);
	state_control : state port map(button => button_start, CLK => CLK, EN => EN2, RST => rst);
	
	run_pulse_generator : run port map(EN => EN, EN2 => EN2, start => start, wheel => wheel, pulse => run_pulse);
	wait_pulse_generator : wit port map(EN => not EN, EN2 => EN2, start => start, CLK => CLK, pulse => wait_pulse);	
	
	unit_price_counter : unit_price port map(rst => rst, run_pulse => run_pulse, wait_pulse => wait_pulse, night => button_night, price => u_price, 
			run_inc => button_run_inc, run_de => button_run_de, wait_inc => button_wait_inc, wait_de => button_wait_de);
	total_price_counter : start_price port map(wheel => wheel, rst => rst, unit_price => u_price, start => start, total_price => t_price, 
			start_inc => button_start_inc, start_de => button_start_de);
	
	bitto4bcd : tobcd port map(data => t_price, bcd3 => num3, bcd2 => num2, bcd1 => num1, bcd0 => num0);
	display3 : decode port map(num4 => num3, reset => not EN2, num7 => display_num3);
	display2 : decode port map(num4 => num2, reset => not EN2, num7 => display_num2);
	display1 : decode port map(num4 => num1, reset => not EN2, num7 => display_num1);
	display0 : decode port map(num4 => num0, reset => not EN2, num7 => display_num0);
	
	buzz_run  : buzz port map(pulse => run_pulse,  CLK => CLK, sound => sound0);
	buzz_wait : buzz port map(pulse => wait_pulse, CLK => CLK, sound => sound1);
	state_display : run_wait_state_display port map(EN => EN, start => start, run_state_display => run_state_display, wait_state_display => wait_state_display);
	
	price <= t_price;
	pulse_detect <= wait_pulse;
end bhv;
