data=readmatrix("Kenya_table.csv");
data2=readtable("Kenya_table.csv");
f=data(:,30);x=data(:,24);y=data(:,25);year=data(:,4); state= table2cell(data2(:,20));
event_type= table2cell(data2(:,7));
subevent_type= table2cell(data2(:,10));


ass_actors = table2cell(data2(:,10));
assa_type_list=sort(unique(ass_actors));
for i =1:length(assa_type_list)
    numero=strcmp(ass_actors,assa_type_list(i));
    assa_fat(i)=sum(f(numero));
end

rows = strcmpi(data2.ASSOC_ACTOR_1, 'Pastoralists (Kenya)'); 
filteredpastoralist = data2(rows,:);

writetable(filteredpastoralist,'pastoralists.xlsx')


scatter(x,y,80,f,"filled");colorbar

hold on;scatter(x(i),y(i),'fill','r')

[lon,lat]=meshgrid(x(1:20:end),y(1:20:end));
B=griddata(x,y,f,lon,lat,'natural');
figure;pcolor(lon,lat,B);shading flat;colorbar;colormap('jet');

year_list=sort(unique(year));
for i =1:length(year_list)
    numero=find(year==year_list(i));
    year_fat(i)=sum(f(numero));
end

state_list=sort(unique(state));
for i =1:length(state_list)
    numero=strcmp(state,state_list(i));
    state_fat(i)=sum(f(numero));
end
etype_list=sort(unique(event_type));
for i =1:length(etype_list)
    numero=strcmp(event_type,etype_list(i));
    etype_fat(i)=sum(f(numero));
end

setype_list=sort(unique(subevent_type));
for i =1:length(setype_list)
    numero=strcmp(subevent_type,setype_list(i));
    setype_fat(i)=sum(f(numero));
end
figure
plot(1:length(state_list),state_fat);
xlim([1,47]);xticks(1:47);
xticklabels(state_list)