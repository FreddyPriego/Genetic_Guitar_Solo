%% Play Note
%This file recreates any note of a guitar using Karplus-strong algorithm
%within the function playguitarn

Fs = 44100;

%Producing a note  
time = 1/2;
string = 6 ;
fret = 0 ;

note1 = playguitarn(time,string,fret);

%Producing another note  
note2 = playguitarn(1/2,6,2);

notesum = [note1; note2; note1; note1];
% To hear, type: 
% hplayer = audioplayer(note, Fs); 
% play(hplayer)
sound(notesum, Fs); 