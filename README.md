# Square-Stacker
This project uses a VGA monitor to display a simple tower building game designed on VHDL.  
[Project_mp.docx](https://github.com/MustafaParlar/Square-Stacker/files/10289374/Project_mp.docx)


## Methodology:
A VGA monitor is used to display the game. The monitor has 640x480 pixels. The monitor displays images by lighting up each pixel individually. For it to seem like every pixel is lit up at the same time, the persistence of vision effect is used. A whole frame is displayed (all 640x480 pixels) 60 times every second. This would require a clock of 18,432,000 Hz. However, the mechanism used by the monitor to light up the screens adds time loss. Between each sweep of the horizontal and vertical lines, there are front porches, back porches and sync pulses. If we appropriate the time loss to pixels, we can model the monitor as 800x525 pixels. This process requires a clock of 25,200,000 Hz.

 ![image](https://github.com/MustafaParlar/Square-Stacker/assets/121253152/209417e0-3e7a-4e09-a179-3aec835ad645)

Figure 1: VGA Signal Timing

After the FPGA sends the sync pulse (96 pixels) to the monitor, it waits out the back porch (48 pixels) and starts sending RGB values to be displayed on the monitor. After the 640 horizontal pixels, it waits for the front porch (16 pixels). Then, it repeats the process for the next horizontal line while incrementing the vertical line by 1. It repeats a similar process for the vertical lines. In the vga modules, there are nested if statements controlled by the clock. These statements increment the hpos (horizontal position) and vpos (vertical position) values. An additional if statement sets the hysnc (horizontal sync pulse) and the vsync (vertical sync pulse). These sync values alone communicate the positional value while the RGB outputs communicate the color. The hpos and vpos values are used by the FPGA to determine what the RGB values should be.
The FPGA code used in this project is as follows;
vga:top module with four sub-modules vga_sync, vga_win, vga_start, clk_div. It drives the clocks of the vga sub-modules using the clock output from the clock divider and cycles through the hysnc, vysnc and the RGB outputs of the modules using a FSM (Moore).
clk_div: takes 100 MHZ FPGA clock as input and outputs a 25 MHz clock
vga_win:using the nested if statements mentioned above, it turns a bitmap to the win screen.
vga_start: using the nested if statements mentioned above, it turns a bitmap to the starting menu.
vga_sync: using the nested if statements mentioned above, it turns a bitmap to the moving squares and displays the title. It controls the motion of the squares with an FSM (Mealy). 



Image resolution was decreased to improve compiling time when testing.

Results:

 ![image](https://github.com/MustafaParlar/Square-Stacker/assets/121253152/b0a31b16-0a3f-4ce3-b889-d7e703ca206d)

Figure 2: Start Menu

![image](https://github.com/MustafaParlar/Square-Stacker/assets/121253152/6feb6902-5d00-4ddf-a72a-948dfda48f79)

 
Figure 3: First square off screen

![image](https://github.com/MustafaParlar/Square-Stacker/assets/121253152/174f1783-75a6-4189-a899-166a069bb21a)

 
Figure 4: Second square

![image](https://github.com/MustafaParlar/Square-Stacker/assets/121253152/7434d91f-9aa9-4d2b-af3e-b0a135a7de4c)

 
Figure 5: Third square

![image](https://github.com/MustafaParlar/Square-Stacker/assets/121253152/85dfef5f-e41b-4577-bab1-a04b6ffe41af)

 
Figure 6: Fourth square

![image](https://github.com/MustafaParlar/Square-Stacker/assets/121253152/83e34ef1-abbb-4c53-8191-3a83900c7ab7)

 
Figure 7: Fifth square

![image](https://github.com/MustafaParlar/Square-Stacker/assets/121253152/c618b72b-1faf-4aca-bdb3-1a98680fe8e9)

 
Figure 8: Sixth square

![image](https://github.com/MustafaParlar/Square-Stacker/assets/121253152/1f0351f5-31c1-43a3-a2c4-9664d829a89d)

 
Figure 9: Seventh square

![image](https://github.com/MustafaParlar/Square-Stacker/assets/121253152/b6f9c7fa-c2e0-405b-817d-bef1e59920aa)

 
Figure 10: Eighth square

![image](https://github.com/MustafaParlar/Square-Stacker/assets/121253152/f07ae894-2540-4483-a07d-3824e869aa11)

 
Figure 11: Win screen
