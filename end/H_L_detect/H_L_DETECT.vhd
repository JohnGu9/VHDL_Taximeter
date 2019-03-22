library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity H_L_DETECT is		
	port(CLK : in std_logic;							--1000Hz
		wheel : in std_logic;
		EN : out std_logic;
		clr : out std_logic);
end;

architecture bhv of H_L_DETECT is
	signal cnt : integer range 0 to 1023;
	signal wheel_cnt_threhold : integer range 0 to 1023;
	signal clear : std_logic;
	signal b1 : std_logic;
	signal enable : std_logic;
begin
	wheel_cnt_threhold <= 500;
process(CLK) begin
	if rising_edge(CLK) then 
		if b1 /= clear then 
			cnt <= 0;
			if cnt < wheel_cnt_threhold then enable <= '1';
			else enable <= '0'; end if;
		else				
			if cnt < wheel_cnt_threhold then cnt <= cnt + 1; enable <= enable;
			else cnt <= cnt; enable <= '0';end if;
		end if;
		b1 <= clear;
	end if;
	EN <= enable;
end process;

process(wheel) begin
	if rising_edge(wheel) then 
		clear <= not clear;
	end if;
	clr <= clear;
end process;

end bhv;