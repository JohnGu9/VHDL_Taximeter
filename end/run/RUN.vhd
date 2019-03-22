library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity RUN is
	port(EN : in std_logic;
		EN2 : in std_logic;
		start : in std_logic;
		wheel : in std_logic;	--2.5m 
		pulse : out std_logic);
end;

architecture bhv of RUN is
	signal o : std_logic;
	signal cnt : integer range 0 to 255;
begin
process(EN, EN2, start, wheel, o)	begin
	if start = '1' and EN = '1' and EN2 = '1' 
		then	
			if rising_edge(wheel)	then cnt <= cnt + 1;
				if cnt = 100 then o <= '1'; cnt <= 0;
				end if;
	
			end if;
	end if;
	if o = '1' then o <= '0';
	end if;
	pulse <= o;
end process;
end bhv;