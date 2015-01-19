for file in *.html; do
	echo ${file##*/};
    sed -i "s/alert(1)/alert(\/${file##*/}\/)/g" ${file##*/};
done