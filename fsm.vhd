-- fsm.vhd: Finite State Machine
-- Author(s): Richard Klem xklemr00
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (NUM1, NUM2, NUM3, NUM4, NUM5, NUM6ab, NUM7a, NUM7b, NUM8a,
						  NUM8b, NUM9a, NUM9b, NUM10a, NUM10b, NUM11a, NUM_END,
						  PRINT_DENIED, BAD_KEY, PRINT_ALLOWED, FINISH);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= NUM1;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when NUM1 =>
		next_state <= NUM1;
		
		if (KEY(1) = '1') then
			next_state <= NUM2;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	 -- - - - - - - - - - - - - - - - - - - - - - -
   when NUM2 =>
		next_state <= NUM2;
		
		if (KEY(3) = '1') then
			next_state <= NUM3;
      elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM3 =>
		next_state <= NUM3;
		
      if (KEY(8) = '1') then
			next_state <= NUM4;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when NUM4 =>
		next_state <= NUM4;
		
      if (KEY(1) = '1') then
			next_state <= NUM5;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM5 =>
		next_state <= NUM5;
		
      if (KEY(7) = '1') then
			next_state <= NUM6ab;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM6ab =>
		next_state <= NUM6ab;
		
      if (KEY(3) = '1') then
			next_state <= NUM7a;
		elsif (KEY(7) = '1') then
			next_state <= NUM7b;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM7a =>
		next_state <= NUM7a;
		
      if (KEY(3) = '1') then
			next_state <= NUM8a;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM7b =>
		next_state <= NUM7b;
		
      if (KEY(7) = '1') then
			next_state <= NUM8b;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM8a =>
		next_state <= NUM8a;
		
      if (KEY(2) = '1') then
			next_state <= NUM9a;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM8b =>
		next_state <= NUM8b;
		
      if (KEY(4) = '1') then
			next_state <= NUM9b;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM9a =>
		next_state <= NUM9a;
		
      if (KEY(4) = '1') then
			next_state <= NUM10a;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM9b =>
		next_state <= NUM9b;
		
      if (KEY(6) = '1') then
			next_state <= NUM10b;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
		-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM10a =>
		next_state <= NUM10a;
		
      if (KEY(0) = '1') then
			next_state <= NUM11a;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM10b =>
		next_state <= NUM10b;
		
      if (KEY(6) = '1') then
			next_state <= NUM_END;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM11a =>
		next_state <= NUM11a;
		
      if (KEY(0) = '1') then
			next_state <= NUM_END;
		elsif (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when NUM_END =>
		next_state <= NUM_END;
		
		if (KEY(15) = '1') then
         next_state <= PRINT_ALLOWED;
		elsif (KEY(14 downto 0) /= "000000000000000") then
			next_state <= BAD_KEY;
      end if;
	-- - - - - - - - - - - - - - - - - - - - - - -
   when BAD_KEY =>
		next_state <= BAD_KEY;
		
		if (KEY(15) = '1') then
         next_state <= PRINT_DENIED;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_ALLOWED =>
      next_state <= PRINT_ALLOWED;
		
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_DENIED =>
      next_state <= PRINT_DENIED;
		
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      next_state <= FINISH;
		
      if (KEY(15) = '1') then
         next_state <= NUM1; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      null;
		--next_state <= TEST1;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE <= '0';
   FSM_MX_MEM <= '0';
   FSM_MX_LCD <= '0';
   FSM_LCD_WR <= '0';
   FSM_LCD_CLR <= '0';

   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_ALLOWED =>
	   FSM_CNT_CE <= '1';
      FSM_MX_LCD <= '1';
      FSM_MX_MEM <= '1';
		
      if (CNT_OF = '0') then
         FSM_LCD_WR <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_DENIED =>
      FSM_CNT_CE <= '1';
      FSM_MX_LCD <= '1';
		
      if (CNT_OF = '0') then
         FSM_LCD_WR <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
		if (KEY(15) = '1') then
         FSM_LCD_CLR <= '1';
		elsif (KEY(14 downto 0) /= "000000000000000") then
		FSM_LCD_WR <= '1';
		end if;
   end case;
	
end process output_logic;

end architecture behavioral;

