work_dir=docs
source=${work_dir}/*.md
include_dir=build
filename=程序员的认知心得
title='程序员的认知心得'

clear:
	rm -f ${work_dir}/$(filename).md

# combine chapters to one file
combine: clear
	awk 'FNR==1{print ""}{print}' $(source) > $(filename).md

epub: combine
	pandoc $(filename).md -o $(filename).epub --resource-path ${work_dir} \
    --epub-metadata $(include_dir)/metadata.xml \
    --css $(include_dir)/epub.css \
    --title-prefix $(title)

word: combine
	pandoc $(filename).md -o $(filename).docx --resource-path ${work_dir} \
    --epub-metadata $(include_dir)/metadata.xml \
    --css $(include_dir)/epub.css \
    --title-prefix $(title) \
    --reference-doc $(include_dir)/template.docx \
    --toc

html: combine
	pandoc $(filename).md -o index.html --resource-path ${work_dir} \
    --css $(include_dir)/html.css \
    --title-prefix $(title) \
    --toc
