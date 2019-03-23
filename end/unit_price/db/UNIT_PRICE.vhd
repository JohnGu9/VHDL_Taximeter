library ieee;
use ieee.std_logic_arith;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity unit_price is
	port(rst : in std_logic; 
		run_pulse : in std_logic;
		wait_pulse : in std_logic;
		run_inc, run_de : in std_logic;
		wait_inc, wait_de : in std_logic; 
		night : in std_logic;
		price : out std_logic_vector(15 downto 0));		--*warning: unit--0.1yuan
end;

architecture bhv of unit_price is
	signal run_price : std_logic_vector(7 downto 0);	--0.1 yuan
	signal run_times : std_logic_vector(7 downto 0);
	signal wait_price: std_logic_vector(7 downto 0);	
	signal wait_times: std_logic_vector(7 downto 0);
	signal night_price:std_logic_vector(7 downto 0);
	signal price_reg : std_logic_vector(15 downto 0);
	signal run_price_inc: std_logic_vector(7 downto 0);	
	signal run_price_de: std_logic_vector(7 downto 0);
	signal wait_price_inc: std_logic_vector(7 downto 0);	
	signal wait_price_de: std_logic_vector(7 downto 0);	
begin
process(rst, run_pulse, wait_pulse, night, 
		run_price, run_times, wait_price, wait_times, price_reg)	begin
	run_price <= "00011010";	--2.6yuan
	wait_price<= "00000101";	--1yuan
	night_price <= "00011110";	--3yuan
	if rst = '1'
		then run_times <= (others => '0'); wait_times <= (others => '0');
	else 	
		if rising_edge(run_pulse)	
			then run_times <= run_times + 1;
		else run_times <= run_times; end if;
		if rising_edge(wait_pulse)	
			then wait_times <= wait_times + 1;
		else wait_times <= wait_times; end if;
	end if;
	if night = '1' then price_reg <= (run_price+run_price_inc-run_price_de)*run_times 
									+ (wait_price+wait_price_inc-wait_price_de)*wait_times + night_price;
	else price_reg <= (run_price+run_price_inc-run_price_de)*run_times 
					+ (wait_price+wait_price_inc-wait_price_de)*wait_times ; end if;
	price <= price_reg;							
end process;

process(run_inc, run_de, wait_inc, wait_de) begin
	if rising_edge(run_inc) then run_price_inc <= run_price_inc + 1; end if;
	if rising_edge(run_de) then run_price_de <= run_price_de + 1; end if;
	if rising_edge(wait_inc) then wait_price_inc <= wait_price_inc + 1; end if;
	if rising_edge(wait_de) then wait_price_de <= wait_price_de + 1; end if;	
end process;
end bhv;