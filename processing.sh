#!/usr/bin/env zsh

# for i in `ls | grep ^5`
# do
#     fname=`basename ${i} .tif`
#     # reproject to WGS84
#     echo "reproject ${i} to tmp/${fname}_wgs84.gpkg...."
#     gdalwarp -t_srs EPSG:4326 -dstnodata 0 \
#         -r near -te 119.131095886 21.54776001 122.356811523 25.860013962 \
#         -ot Int16 -of GPKG "${i}" "tmp/${fname}_wgs84.gpkg"
#     # clip
#     echo "translate format from tmp/${fname}_wgs84.gpkg tmp/${fname}_wgs84_clip.gpkg"
#     gdalwarp -overwrite -ot Int16 -of GPKG -tr 9.438540604517812e-05 -9.438689237638706e-05 \
#         -tap -cutline "Landuse2017-2021.gpkg" -cl Landuse2017-2021 \
#         -crop_to_cutline -dstnodata 0.0 "tmp/${fname}_wgs84.gpkg" "tmp/${fname}_wgs84_clip.gpkg"
# done

for (( i=2017; i<=2021; i++ ))
do
    # echo "merging ${i} landuse ..."
    # ls tmp/ | grep clip | grep  _${i} > tmp/merge_list_${i}.txt
    # sed -i '' 's/^/"tmp\//' tmp/merge_list_${i}.txt
    # sed -i '' 's/$/"/' tmp/merge_list_${i}.txt

    # # > merge_list_${i}.txt
    # gdal_merge.py -ot Int16 -of GPKG -o data/Landuse_TW_${i}.gpkg \
    #     --optfile tmp/merge_list_${i}.txt
    # # translate to twd97tm2
    echo "reproject Landuse_TW_${i} to data/Landuse_TW_${i}_twd97.gpkg...."
    gdalwarp -t_srs EPSG:3826 -dstnodata 0 \
        -r near \
        -ot Int16 -of GPKG "data/Landuse_TW_${i}.gpkg" "data/Landuse_TW_${i}_twd97.gpkg"
done
