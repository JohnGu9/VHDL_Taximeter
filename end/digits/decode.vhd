library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity decode is
    port (
          num4  : in std_logic_vector (3 downto 0);
          reset : in std_logic;
          num7  : out std_logic_vector(6 downto 0)
          );
end entity;

architecture bhv of decode is 
begin 
    process (num4) is
    begin 
        if reset = '1' then 
            num7<="0000000";
        else
        case num4 is 
            when "0000" =>num7<="1111110"; 
            when "0001" =>num7<="0110000";
            when "0010" =>num7<="1101101";
            when "0011" =>num7<="1111001";
            when "0100" =>num7<="0110011";
            when "0101" =>num7<="1011011";
            when "0110" =>num7<="1011000";
            when "0111" =>num7<="1110000";
            when "1000" =>num7<="1111111";
            when "1001" =>num7<="1111011";
            when others =>num7<="0000000";
        end case;
        end if ;
    end process;
end bhv;            
          