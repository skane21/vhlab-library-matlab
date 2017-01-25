function [h,data] = plot_csd_latency_family(N,M,csd1,csd2,stiminds,time,xaxis, yaxis, depths)

% PLOT_CSD_FAMILY - Plots CSD tuning across stimulus conditions
%  % read file this documentation is no good
%   [H,DATA] = PLOT_CSD_TUNING(N,M,CSD,STIMINDS,TIME,XAXIS,YAXIS,DEPTHS)
%
%   Plots means and standard errors of of responses for each channel in a CSD struct.
%   CSD structure is assumed to be an array [NUMSTIMS]x[NUMCHANNELS] of structures.
%   TIME is a vector that is TIME = [ START STOP STEP WINDOWSIZE],
%   where START and STOP indicate the time (in seconds) to start and stop plotting and
%   STEP indicates the step between data points.  WINDOWSIZE is the windowsize.  
%   PLOT_CSD_LATENCY will use this information to look for named entries in the
%   CSD struct.  For example, if TIME = [ 0.030 0.050 0.020 0.020 ] will look for
%   a struct entries called 'tm_030_050' and 'tm_050_070'.
%   STIMINDS is a vector of stimuli numbers to include in the average.  All of the
%   stimuli will be averaged together.
%
%   [XMIN XMAX] and [YMIN YMAX] are used to set the axes for all conditions.
%   (They are all set to be the same.)
%
%   DEPTHS is an array of depths for each channel.

start = time(1); stop = time(2); step = time(3); wsz = time(4);

%if size(stiminds,2)>size(stiminds,1), stiminds = stiminds'; end;

name1 = {};
name2 = {};
for t=start:step:stop,
	name1{end+1} = sprintf('tm_%.3d_%.3d',round(t*1000),round(1000*(t+wsz)));
	name2{end+1} = sprintf('tms_%.3d_%.3d',round(t*1000),round(1000*(t+wsz)));
end;

for j=1:size(stiminds,2),
	data{1,j} = compute_csd_tune2(csd1,stiminds(:,j),name1,name2);
    data{2,j} = compute_csd_tune2(csd2,stiminds(:,j),name1,name2);
end;
h=[];

xdata = (start:step:stop) + wsz/2;

h = [];

ymax = -Inf; ymin = Inf;

colorchars = 'bk';
for j=1:size(stiminds,2),
for k=1:2,

for i=1:N*M,
  if i<=size(data{k,j}(1).mn,1),
	h(end+1) = subplot(N,M,i);
    if j==1&k==1, hold off; end;
	ydata = []; yerr = [];
	for t=1:length(data{k,j}),
		ydata(end+1) = data{k,j}(t).mn(i,1);
		yerr(end+1) = data{k,j}(t).stderr(i,1);
	end;
	hold on;
	g=plot(xdata,ydata,'linewidth',2);
    if k==2, set(g,'color',[0.7 0.7 0.7]);
    else, set(g,'color',[0 0 0]); end;
	A = axis;
	if A(3)<ymin, ymin = A(3); end;
	if A(4)>ymax, ymax = A(4); end;
	title([int2str(depths(i)) ' \mum']);
    set(gca,'ytick',[]);
    axis([xaxis yaxis]);
  end;
end;
if 0,
for i=1:length(h),
  if i<=size(data{k,j}(1).mn,1),  
	axes(h(i));
	A = axis;
	axis([xaxis yaxis]);
	hold on;
	ydata = []; yerr = []; stats = [];
	for t=1:length(data),
		ydata(end+1) = data{k,j}(t).mn2(i,1);
		yerr(end+1) = data{k,j}(t).stderr2(i,1);
		stats(end+1) = data{k,j}(t).kw(i,1);
	end;
	g = myerrorbar(xdata,ydata,yerr,yerr,colorchars(k));
	set(g,'color',[0.7 0.7 0.7]);
	plot(xdata, (stats<0.01)*[max(yaxis)-min(yaxis)]+min(yaxis), 'o');
	set(gca,'ytick',[]);
    end;
end;
end;
end;
end;