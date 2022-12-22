


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga is
 Port ( clk,space_in : in STD_LOGIC;
       vga_hs, vga_vs : out STD_LOGIC; 
        vga_red, vga_green, vga_blue : out std_logic_vector(3 downto 0) 
         );
end vga;

architecture Behavioral of vga is

component vga_sync is
 Port (  clk,space : in  std_logic;
 hsync, vsync, product,winner: out std_logic ;
 red,green,blue: out std_logic_vector(3 downto 0));
end component;

component vga_start is
Port (  clk : in  std_logic;
hsync, vsync: out std_logic ;
red,green,blue: out std_logic_vector(3 downto 0));
end component;

component vga_win is
Port (  clk : in  std_logic;
hsync, vsync: out std_logic ;
red,green,blue: out std_logic_vector(3 downto 0));
end component;

component clk_div is 
port ( 
        clk: in std_logic;
        clk25: out std_logic);
        
end component;

signal vga_clk: std_logic;
signal lose,wine : std_logic:='0';
signal hs0,hs1,hs2: std_logic; 
signal vs0,vs1,vs2: std_logic; 
signal red0,red1,red2: std_logic_vector(3 downto 0);
signal blue0,blue1,blue2: std_logic_vector(3 downto 0);
signal green0,green1,green2: std_logic_vector(3 downto 0);
type states is ( start, play, win);
signal state2, n_state : states := start; 


begin

process(clk,space_in)
begin 
if rising_edge(clk) then
    case state2 is
    when start=>
        vga_hs <=hs0;
        vga_vs <=vs0;
        vga_red <=red0;
        vga_green <=green0;
        vga_blue <=blue0;
        if space_in='1' then
            state2<=play;
        end if;
    when play=>         

        vga_hs <=hs1;
        vga_vs <=vs1;
        vga_red <=red1;
        vga_green <=green1;
        vga_blue <=blue1;
        
        if lose ='1' then
            state2<=start;
        end if;
        if wine='1' then
            state2<=win;
        end if;        
    when win=>
        vga_hs <=hs2;
        vga_vs <=vs2;
        vga_red <=red2;
        vga_green <=green2;
        vga_blue <=blue2;
        if space_in='1' then
            state2<=start;
        end if;
end case;
end if;
end process;



clk1 : clk_div port map(clk=>clk, clk25=>vga_clk);

square0 : vga_sync port map (clk=>vga_clk, space=>space_in, hsync=>hs1, vsync=>vs1, product=>lose, winner=>wine, red=>red1, green=>green1, blue=>blue1);
start0 : vga_start port map (clk=>vga_clk, hsync=>hs0, vsync=>vs0, red=>red0, green=>green0, blue=>blue0);
win0 : vga_win port map (clk=>vga_clk, hsync=>hs2, vsync=>vs2, red=>red2, green=>green2, blue=>blue2);

end Behavioral;


