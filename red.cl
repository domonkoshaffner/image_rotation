__kernel void rotation(read_only image2d_t orig_im, write_only image2d_t new_im, sampler_t grid_sampler, 
                        int height, int width, int new_height, int new_width, int center_height, 
                        int center_width, int new_center_height, int new_center_width, float angle) 
{
    
// Saving the global ids in variables

    int i = get_global_id(0);
    int j = get_global_id(1);

// Calculating the new coordinates

    int x = width - 1 - i - center_width;
    int y = height - 1 - j - center_height;

    int new_x = new_center_width - round(x*cos(angle) + y*sin(angle));
    int new_y = new_center_height - round(-x*sin(angle) + y*cos(angle));

// Creating the 2D image objects
// Saving the original coordinates in the new ones

    float4 pixel = read_imagef(orig_im, grid_sampler, (int2)(i,j));

    if (0 < new_x && new_x < new_width && 0 < new_y && new_y < new_height)
    {
        write_imagef(new_im, (int2)(new_x,new_y), pixel);
    }

}
