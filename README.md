3D-printing-preprocessing-software
====  
Instruction
-------  
1.Run printing.m and input the name of the data.

![](https://github.com/Philipcjh/3D-printing-preprocessing-software/blob/main/ins1.png)
2. Then rotate the model to the angel need to be printed and set the threshold of angel as judgement for generating support. (You need to wait for some time because there is no optimization for the supporting algorithm)

![](https://github.com/Philipcjh/3D-printing-preprocessing-software/blob/main/ins2.png)
3. Pull the slide and then you can see the slice of the model and support structure when the printer prints to the corresponding height.

![](https://github.com/Philipcjh/3D-printing-preprocessing-software/blob/main/ins3.png)
Function
-------  
halfedge_generate.m
------- 
This MATLAB function aims at rapidly transforming the triangular facets information to halfedge data structure. 

slice_stl_create_path_ycut.m & plot_slices_3D.m
------- 
The slicing algorithm is referred to [wtzzclk/FDM_3D_Printing_Slice_Algorithm](https://github.com/wtzzclk/FDM_3D_Printing_Slice_Algorithm ). 
I solved the problem that the contours of slice would be connected by extra lines if there are more than 2 close contours. 
