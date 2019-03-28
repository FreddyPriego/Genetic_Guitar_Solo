%% Play Guitar N
%This file recreates any note of a guitar of 6 strings and 24 frets 
%with regular tuning using Karplus-strong algorithm
%The inputs of the following function are time, which is how long do you
%want the note to last; string, which is a number between 1 to 6 following
%the strings of the guitar; and fret which follows the position of the fret
%from an open note in 0 to 24.

function [note] = playguitarn(time,string,fret)

%Defining the frequencies
Fs = 44100; 
A = 110; % The A string of a guitar is normally tuned to 110 Hz 
%time = 4;

F = linspace(1/Fs, 1000, 2^12);
x = zeros(Fs*time, 1);

%All notes for a 24 frets guitar configuration 
nfrets = 24;
nnotes = linspace(0,nfrets*2,nfrets*2 + 1);
allnotes = round(Fs./(A.*2.^((nnotes-5)./12)));

S6 = allnotes(1:nfrets+1);
S5 = allnotes(6:nfrets+6);
S4 = allnotes(11:nfrets+11);
S3 = allnotes(16:nfrets+16);
S2 = allnotes(20:nfrets+20);
S1 = allnotes(25:nfrets+25);

guitar = [S1; S2; S3; S4; S5; S6];

delay = guitar(string,fret+1);
b  = firls(42, [0 1/delay 2/delay 1], [0 0 1 1]); 
a  = [1 zeros(1, delay) -0.5 -0.5];
zi = rand(max(length(b),length(a))-1,1); 
note = filter(b, a, x, zi);
note = note-mean(note); 
note = note/max(abs(note));  

end