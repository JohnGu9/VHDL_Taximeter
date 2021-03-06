library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity state is
	port(button : in std_logic;
		 CLK : in std_logic;
		 EN: out std_logic;
		 RST:out std_logic);
		 
end entity;

		 
architecture bhv of state is
	signal c:std_logic;
	signal enable : std_logic;
	signal flag : std_logic;
	begin
	process(CLK) begin
		if rising_edge(CLK) then
			if flag /= enable and flag = '0' then 
				c <= '1';				
			end if;		
		flag <= enable;	
		end if;
		if c /= '0' then c<= '0';
		end if;
		RST <= c;
		EN <= enable;	
	end process;
	
	process(button) begin
		if rising_edge(button) then enable <= not enable; 		end if;
	end process;
end bhv;
		
		