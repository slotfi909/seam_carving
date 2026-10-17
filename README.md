# Seam Carving

A MATLAB script for reducing image width by removing vertical seams. It uses a supplied saliency map as the energy map, computes cumulative seam costs with dynamic programming, and displays the resized image. The default configuration removes approximately 30% of the original width.

## Usage

Use MATLAB with Image Processing Toolbox. The script's existing input paths use Windows-style separators; these instructions assume Windows and MATLAB's current folder set to this repository.

Input data is not included. Supply an RGB image and a single-channel saliency map with matching height and width in this layout:

```text
parent/
    seam_carving/
        seamcarving.m
    data/
        Samples dataset/
            Snowman/
                Snowman.png
                Snowman_SMap.png
```

In MATLAB, run:

```matlab
seamcarving
```

To use another image pair, edit `name` near the top of `seamcarving.m` and use the corresponding folder and filenames. Adjust `percentage` to change the fraction of the original width to remove. The script clears the workspace and closes existing figures before running; it displays the result with `imshow` and does not save an output file.
