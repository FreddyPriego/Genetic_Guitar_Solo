%% Play Chord
%This file recreates any chord of a guitar using Karplus-strong algorithm
%within the function playguitarc 
%The chords of the light solo of Comfortably numb are already given 

Fs = 44100;

%Producing a chord 
time = 3.5;

chordC = [3 3 2 0 1 3]; %C chord
chordEm = [0 2 2 0 0 0]; %Em chord
chordG = [3 2 0 0 3 3]; %G chord
chordBm = [0 2 4 4 3 0]; %Bm chord
chordA = [0 0 2 2 2 0]; %A chord
chordD = [0 0 0 2 3 2]; %D chord

Bm = playguitarc(time,chordBm);
Em = playguitarc(time,chordEm);
A = playguitarc(time,chordA);
D = playguitarc(time,chordD);
C = playguitarc(time,chordC);
G = playguitarc(time,chordG);

%Producing another note  
%note2 = playguitarn(1/2,6,2);

%light solo
notesum = [D; A; D; A; C; G; C; G; A];

%dark solo
%notesum = [Bm; A; G; C; Em; Bm; Bm; A; G; C; Em; Bm; Bm; A; G; C; Em; Bm; Bm; A; G; C; Em; Bm;];

% To hear, type: 
% hplayer = audioplayer(note, Fs); 
% play(hplayer)
sound(notesum, Fs); 