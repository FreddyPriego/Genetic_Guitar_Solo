%% Play Guitar C
%This file recreates any chord of a guitar of 6 strings and 24 frets 
%with regular tuning using Karplus-strong algorithm
%The inputs of the following function are time, which is how long do you
%want the chord to last; and chord, which is a row vector of 6 elements
%each element being the position of the fingers in the 6 strings of the
%guitar

function [combinedNote] = playguitarc(time,chord)

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

delay = [guitar(6,(chord(1)+1)),guitar(5,(chord(2)+1)),guitar(4,(chord(3)+1)),...
    guitar(3,(chord(4)+1)),guitar(2,(chord(5)+1)),guitar(1,(chord(6)+1))];

    b = cell(length(delay),1); 
    a = cell(length(delay),1); 
    H = zeros(length(delay),4096); 
    note = zeros(length(x),length(delay)); 
    
    for indx = 1:length(delay)          
    % Build a cell array of numerator and denominator coefficients.     
    b{indx} = firls(42, [0 1/delay(indx) 2/delay(indx) 1], [0 0 1 1]).';     
    a{indx} = [1 zeros(1, delay(indx)) -0.5 -0.5].';          
    % Populate the states with random numbers and filter the input zeros.     
    zi = rand(max(length(b{indx}),length(a{indx}))-1,1);          
    note(:, indx) = filter(b{indx}, a{indx}, x, zi);          
    % Make sure that each note is centered on zero.     
    note(:, indx) = note(:, indx)-mean(note(:, indx));          
    [H(indx,:),W] = freqz(b{indx}, a{indx}, F, Fs); 
    end

combinedNote = sum(note,2); 
combinedNote = combinedNote/max(abs(combinedNote));  

% To hear, type: 
%hplayer = audioplayer(combinedNote, Fs); 
%play(hplayer)

%Add the "rasgueo" effect adding 50 miliseconds between note 

offset = 50;  offset = ceil(offset*Fs/1000);
for indx = 1:size(note, 2)     
    note(:, indx) = [zeros(offset*(indx-1),1); ...                 
        note((1:end-offset*(indx-1)), indx)]; 
end
combinedNote = sum(note,2); 
combinedNote = combinedNote/max(abs(combinedNote));    

end