library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity buzz is
	port(pulse : in std_logic;
		CLK : in std_logic;
		sound : out std_logic);
end;

architecture bhv of buzz is
	signal cnt : integer range 0 to 1023;
begin
process(pulse, CLK) begin
	if pulse = '1' then cnt <= 0;
	else
		if rising_edge(CLK) and cnt < 1000 then cnt <= cnt + 1;
		end if;
		
		if cnt < 500 then sound <= CLK;
		else sound <= '0';
		end if;
	end if;

end process;
end bhv;
