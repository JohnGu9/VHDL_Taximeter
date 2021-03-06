library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity tobcd is 
    port (data : in std_logic_vector (15 downto 0);
          bcd3, bcd2, bcd1, bcd0 : out std_logic_vector (3 downto 0));
end entity ;

architecture bhv of tobcd is       
begin 
    process(data)
		variable q,b,s,g : std_logic_vector (3 downto 0);  
        begin 
		g := conv_std_logic_vector((conv_integer(data) rem 10), 4);
		s := conv_std_logic_vector((conv_integer(data) rem 100) / 10, 4);
		b := conv_std_logic_vector((conv_integer(data) rem 1000) / 100, 4);
		q := conv_std_logic_vector((conv_integer(data) rem 10000) / 1000, 4);
		
        bcd0 <= g;
        bcd1 <= s;
        bcd2 <= b;
        bcd3 <= q;       
    end process;
end bhv;