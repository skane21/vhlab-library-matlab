function remap_umich2x2(pathname)

% REMAP_UMICH2X2  - Remap channels for UMich 2x2 tetrode probe, 16 channel
%
%   REMAP_UMICH2X2(PATHNAME)
%
%  Renames files from r###_tet1_c## to the appropriate numbers for 
%  channels from a 2x2 tetrode from University of Michigan.
%
%  For example, r###_tet1_c01 is renamed to r###_tet3_c01 because
%  channel 1 on the output connector is Umich probe channel 9.
%
%  Saves a file called 'remapped' in any directory that is remapped.
%  The program checks for the existence of a 'remapped' file and warns
%  the user if it exists before remapping.

currpath = pwd;
cd(pathname);

if exist('remapped'),
	disp(['This directory seems to have been remapped already.']);
	r=input(['Proceed (0=no, 1=yes) ?']);
	if r==0, cd(currpath); return; end;
end;

l = loadStructArray('acqParams_out');
R = l(1).reps;

for r=1:R,

ns = sprintf('%.3d',r);
eval(['!cp r' ns '_tet1_c01 2r' ns '_tet3_c01']);  % 1   =>  9
eval(['!cp r' ns '_tet1_c02 2r' ns '_tet4_c01']);  % 2   => 13
eval(['!cp r' ns '_tet1_c03 2r' ns '_tet4_c04']);  % 3   => 16
eval(['!cp r' ns '_tet1_c04 2r' ns '_tet3_c03']);  % 4   => 11 
eval(['!cp r' ns '_tet2_c01 2r' ns '_tet4_c03']);  % 5   => 15
eval(['!cp r' ns '_tet2_c02 2r' ns '_tet3_c04']);  % 6   => 12
eval(['!cp r' ns '_tet2_c03 2r' ns '_tet4_c02']);  % 7   => 14
eval(['!cp r' ns '_tet2_c04 2r' ns '_tet3_c02']);  % 8   => 10
eval(['!cp r' ns '_tet3_c01 2r' ns '_tet1_c03']);  % 9   =>  3
eval(['!cp r' ns '_tet3_c02 2r' ns '_tet2_c03']);  % 10  =>  7
eval(['!cp r' ns '_tet3_c03 2r' ns '_tet2_c02']);  % 11  =>  6
eval(['!cp r' ns '_tet3_c04 2r' ns '_tet2_c01']);  % 12  =>  5
eval(['!cp r' ns '_tet4_c01 2r' ns '_tet1_c01']);  % 13  =>  1
eval(['!cp r' ns '_tet4_c02 2r' ns '_tet1_c02']);  % 14  =>  2
eval(['!cp r' ns '_tet4_c03 2r' ns '_tet2_c04']);  % 15  =>  8
eval(['!cp r' ns '_tet4_c04 2r' ns '_tet1_c04']);  % 16  =>  4

if 1,
eval(['!cp 2r' ns '_tet1_c01 r' ns '_tet1_c01']);  % 1
eval(['!cp 2r' ns '_tet1_c02 r' ns '_tet1_c02']);  % 2
eval(['!cp 2r' ns '_tet1_c03 r' ns '_tet1_c03']);  % 3
eval(['!cp 2r' ns '_tet1_c04 r' ns '_tet1_c04']);  % 4
eval(['!cp 2r' ns '_tet2_c01 r' ns '_tet2_c01']);  % 5
eval(['!cp 2r' ns '_tet2_c02 r' ns '_tet2_c02']);  % 6
eval(['!cp 2r' ns '_tet2_c03 r' ns '_tet2_c03']);  % 7 
eval(['!cp 2r' ns '_tet2_c04 r' ns '_tet2_c04']);  % 8 
eval(['!cp 2r' ns '_tet3_c01 r' ns '_tet3_c01']);  % 9
eval(['!cp 2r' ns '_tet3_c02 r' ns '_tet3_c02']);  % 10
eval(['!cp 2r' ns '_tet3_c03 r' ns '_tet3_c03']);  % 11 
eval(['!cp 2r' ns '_tet3_c04 r' ns '_tet3_c04']);  % 12 
eval(['!cp 2r' ns '_tet4_c01 r' ns '_tet4_c01']);  % 13
eval(['!cp 2r' ns '_tet4_c02 r' ns '_tet4_c02']);  % 14
eval(['!cp 2r' ns '_tet4_c03 r' ns '_tet4_c03']);  % 15
eval(['!cp 2r' ns '_tet4_c04 r' ns '_tet4_c04']);  % 16
end;  % if

! rm 2r*;

end; % for

save remapped l -mat

cd(currpath);
