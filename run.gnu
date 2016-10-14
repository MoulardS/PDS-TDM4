set title "Graphical of ./mcat-scd execution"
set xlabel "Time"
set grid
set ylabel "Buffer size"
plot "mcat-tm.dat" using 2:1
pause -1

