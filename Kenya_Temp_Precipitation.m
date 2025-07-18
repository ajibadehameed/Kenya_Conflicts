data=readmatrix("Kenya_Precipitation_processed_2008.xls");
data=readtable("Africa_1997-2023_Aug04-2.xlsx");


figure;scatter(data(:,2),data(:,3),[],data(:,4),'filled');colorbar;caxis([-10,10])

x=data(1:762,2);y=data(1:762,3);
tmm=[];
  for i=1:762
        tm=mean(data(i:762:end,4));
        tmm=[tmm,[tm]];
  end
  figure;scatter(x,y,[],tmm,'filled');colorbar;%caxis([-120,10]);
  colormap(flipud(jet))
writetable(table(x,y,tmm'),'kp2008.xls')
%%
data=readmatrix("Kenya_Temperature_processed_2008.xls");
figure;scatter(data(:,2),data(:,3),[],data(:,4),'filled');colorbar;caxis([-10,10])

tmm=[];
  for i=1:762
        tm=mean(data(i:762:end,4));
        tmm=[tmm,[tm]];
  end
  figure;scatter(x,y,[],tmm,'filled');colorbar;%caxis([-120,10]);
  colormap(flipud(jet))
writetable(table(x,y,tmm'),'kt2008.xls')

%%
  k=boundary(x,y);
bdry(:,1)=x(k);bdry(:,2)=y(k);
  [lon,lat]=meshgrid(min(x):0.005:max(x),min(y):0.005:max(y));
  in=insidepoly(lon,lat,bdry(:,1),bdry(:,2));
F=scatteredInterpolant(x,y,tmm','natural');
B=F(lon,lat);B(~in)=nan;
figure;pcolor(lon,lat,B);shading flat;colorbar;caxis([-120,10]);colormap(flipud(jet));




tmm=[];
for i=1:762:length(data)
    tm=mean(data(i:i+761,4));
    tmm=[tmm,[tm]];
end

data2=readmatrix("Kenya_Temperature_processed_2000.xls");
% scatter(data2(:,2),data2(:,3),[],data2(:,4),'filled');colorbar;caxis([-10,10])

tmm2=[];
for i=1:762:length(data2)
    tm2=mean(data2(i:i+761,4));
    tmm2=[tmm2,[tm2]];
end


figure
yyaxis("right")
plot(tmm)
ylabel('Precipitation')
yyaxis("left")
plot(tmm2)
ylabel('Temperature')

a=data(:,4);max(a)