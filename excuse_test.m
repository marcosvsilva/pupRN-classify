

%   Version 1.0, 08.06.2015, Copyright University of Tübingen.
% 
%   The Code is created based on the method from the paper:
%   "ExCuSe: Robust Pupil Detection in Real-World Scenarios", W. Fuhl, T. C. Kübler, K. Sippel, W. Rosenstiel, E. Kasneci
%   CAIP 2015 : Computer Analysis of Images and Patterns
%  
%   The code and the algorithm are for non-comercial use only.





% Test function of the algorithm on all data sets
% 
function   run_test()




base_folder='D:\Projects\Datasets\tmp2\'; % folder where the data sets are
base_folder_fig='D:\Projects\Datasets\results\'; % folder to save figure


ins_base_folder=dir(base_folder);


for i=1:size(ins_base_folder,1)
    disp(ins_base_folder(i))
    if ins_base_folder(i).isdir==1 && ~strcmp(ins_base_folder(i).name,'.') && ~strcmp(ins_base_folder(i).name,'..')
        
        name=[ins_base_folder(i).name '.txt'];
        img_folder=[ base_folder ins_base_folder(i).name '\' ];

        file=fopen( [ base_folder name ],'r');
        fgetl(file);%skip description
        
     
        anz_imgs=0;
        vec=0;
ins_base_folder(i).name


        while ~feof(file)
             
        data = textscan(file, '%n %n %n %n ', 1);
        data=cell2mat(data);
        img_name=data(2);

        pic = imread([img_folder num2str(img_name,'%010d') '.png']);
        anz_imgs=anz_imgs+1;
        [x,y,c]=size(pic);

        txt_x=data(3)/2;

        txt_y=x-data(4)/2;
        
        
        [ point ] = detect_pupil( pic );
        

        
        
        vec(anz_imgs)=sqrt((txt_y-point(1))^2 + (txt_x-point(2))^2);
        
        fgetl(file);
        
        
        end
        
        anz_imgs
        
        
hist_dist_v=zeros(16,1);


[nu sv]=size(vec);
for j=1:16
    for k=1:sv
    
        if vec(k)<=(j-1)
            hist_dist_v(j)=hist_dist_v(j)+1;
        end
     
    end
end



hist_dist_v=hist_dist_v./sv;

figure(i);
tt=plot(0:1:15,hist_dist_v);
        

saveas(tt,[base_folder_fig ins_base_folder(i).name '.fig'],'fig');
        
    end
    
    
end



end

