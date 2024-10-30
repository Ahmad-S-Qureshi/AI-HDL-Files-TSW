<img src="images/Ai-HDl_Logo.png.webp" alt="AI-HDL Logo" style="float: middle;">
<h1>Welcome to AI-HDL!</h1> 

In this folder you will find the following source files required to build the first iteration of your digital watch. However,
these files will only contain the required inputs and outputs of the modules. It is up to you to create them by prompting
your language model of choice. Below are explanations of each module to help you better understand the baseline project:

<ul>
<li><b>seven_segment_display.v</b>: Manages the display of the stopwatch time on the Basys 3's four-digit seven-segment display.</li>
<li><b>clock_divider.v</b>: Divides the 100 MHz Basys 3 clock down to a slower frequency suitable for timing and display purposes.</li>
<li><b>buttonDebouncer.v</b>: Provides stable, debounced input signals for the start/stop and reset buttons.</li>
<li><b>top_level.v</b>: The main module that integrates all components.</li>
<li><b>stopwatch.v</b>: Implements the stopwatch logic, handling start/stop and reset functionality.</li>
</ul>
It will also include 1 simulation source that can be used to test the output of your code:
<br></br>
<ul>
<li><b>top_level_tb.v</b>: A testbench that simulates the top_level module, allowing you to test the full stopwatch functionality in Vivado.</li>
</ul>

Once all files have been generated and debugged, press the <b>Run Simulation</b> button on Vivado to generate the waveform for the 
behavioral simulation. This will tell you whether or not the modules are functioning properly.

<h2>Download</h2>
In order to download the files, on the main AI-HDL repository page select the <b>Code</b> button and select <b>Download ZIP</b>. Once the file has downloaded, extract the files from the ZIP folder. These files are now ready to be added as source files to the Vivado directory.

