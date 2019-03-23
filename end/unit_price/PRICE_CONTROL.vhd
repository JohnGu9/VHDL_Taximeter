library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity price_control is
	port(run+, run- : in std_logic;
		waits+, waits- : in std_logic;
		start+, start- : in std_logic);
end;

architecture bhv of price_control is
	signal run_price_origin : std_logic_vector(7 downto 0);
	signal wait_price_origin : std_logic_vector(7 downto 0);
	signal start_price_origin : std_logic_vector(15 downto 0)
begin
process(run+, run-)

end bhv;
