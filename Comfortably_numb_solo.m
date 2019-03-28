%% Comfortably numb solo
%This file uses the function playguitarn to play all the notes of the Comfortably numb
% light solo (first solo) given by guitar tabs of tabpro

Fs = 44100;


originalsolo = [playguitarn(3,1,14);...
    playguitarn(1/2,1,14);...
    playguitarn(1/2,1,15);...
    playguitarn(1/2,1,14);...
    playguitarn(1/2,2,15);...
    playguitarn(1/2,2,17);...
    playguitarn(1/2,2,15);...
    playguitarn(1/2,2,15);...
    playguitarn(1/2,2,14);...
    playguitarn(1/2,2,14);...
    playguitarn(1/2,3,14);...
    playguitarn(1,4,14);...
    playguitarn(1/4,4,12);...
    playguitarn(2,4,12);...
    playguitarn(1/2,1,14);...
    playguitarn(1/2,1,15);...
    playguitarn(1/2,1,14);...
    playguitarn(1/2,2,15);...
    playguitarn(2,2,17);...
    playguitarn(1/2,2,15);...
    playguitarn(1,2,14);...
    playguitarn(1/2,3,14);...
    playguitarn(1/2,4,14);...
    playguitarn(1/2,4,12);...
    playguitarn(1/2,4,11);...
    playguitarn(1/2,4,9);...
    playguitarn(1/2,4,7);...
    playguitarn(2,3,12);...
    playguitarn(1/2,3,11);...
    playguitarn(1/2,4,14);...
    playguitarn(1/2,4,12);...
    playguitarn(1/4,3,11);...
    playguitarn(1/2,3,9);...
    playguitarn(1/4,3,9);...
    playguitarn(1/2,3,7);...
    playguitarn(1/4,3,9);...
    playguitarn(1/4,3,7);...
    playguitarn(1/2,4,9);...
    playguitarn(1/2,3,7);...
    playguitarn(1/2,4,9);...
    playguitarn(1/2,4,11);...
    playguitarn(3,4,12);...
    playguitarn(1/2,1,15);...
    playguitarn(1/2,1,14);...
    playguitarn(1/2,1,12);...
    playguitarn(1/2,2,15);...
    playguitarn(1/2,2,12);...
    playguitarn(1/2,3,12);...
    playguitarn(1,4,12);...
    playguitarn(1/4,4,10);...
    playguitarn(1/2,4,9);...
    playguitarn(1/4,4,10);...
    playguitarn(1/4,4,9);...
    playguitarn(1,4,7)];

% To hear, type: 
% hplayer = audioplayer(note, Fs); 
% play(hplayer)
sound(originalsolo, Fs); 