#!/bin/bash

function findMd() {
    path=$1
    hasIndex=false
    depth=$(expr $(echo "$path" | awk -F"/" '{print NF-1}') - 1)
    bangs=''
    basename=$(basename "${path}")
    name="../src/pages/projects/${basename}.md"
    imageSlug=$(echo -n "$basename" | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z.md)
    sedImages="s,\[(.+)\]\(.\/(.+).(jpg|jpeg|png|gif|svg)\),[\1](../../images\/projects\/$imageSlug\/\2.\3),g"
    if [ "$depth" -gt "0" ]; then
        bangs=$(seq -f "#" -s '' $depth)
    fi

    if [ -f "$path/index.md" ]; then
        date=$(git log --pretty='format:%C(auto)%ai' -1 "HEAD" -- "$path/index.md")
        title=$(echo -n $(head -n 1 "$path/index.md") | sed -e 's/# //g')
        author=$(git log --pretty='format:%C(auto)%an' -1 "HEAD" -- "$path/index.md")
        slug=$(echo -n $title | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z.md)

        echo "- [${title}](/projects/$slug)" >>../src/pages/projects.md

        cat >"${name}" <<EOF |
---
title: "${title}"
date: "${date}"
author: "${author}"
type: "page"
path: "/projects/${slug}"
tags: ["Projects", "${title}"]
---
EOF
            echo '' >>"${name}"

        if [ -d "$path/images" ]; then
            mkdir -p "../src/images/projects/$imageSlug/images"
            cp -r "$path/images/." "../src/images/projects/$imageSlug/images/"
        fi

        images=$(cat "$path/index.md" | grep -- '\.jpg\|\.jpeg\|\.png\|\.gif\|\.svg' | sed -E "s,\!\[(.+)\]\(.\/(.+).(jpg|jpeg|png|gif|svg)\),\2.\3,g")
        for image in $images; do
            if [ -f "$path/$image" ]; then
                # echo "$path/$image"
                mkdir -p "../src/images/projects/$imageSlug/images"
                cp "$path/$image" "../src/images/projects/$imageSlug/$image"
            fi
        done

        cat "$path/index.md" | sed -E "s/^#/$bangs/g" | sed -E "s/^# $title//g" | sed -E "$sedImages" >>"${name}"
        hasIndex=true
    fi
    for file in "$path"/*.md; do
        if [ -f "$file" ]; then
            # echo "$path -> $file ($depth) -> $bangs"
            if [[ "$file" != "$path/index.md" && "$file" != "$path/$name" && "$file" != "$path/Markdown Cheatsheet.md" ]]; then
                echo '' >>"${name}"
                if [ "$hasIndex" == "true" ]; then
                    cat "$file" | sed -E "s/^#/#$bangs/g" | sed -E "$sedImages" >>"${name}"
                else
                    cat "$file" | sed -E "s/^#/$bangs/g" | sed -E "$sedImages" >>"${name}"
                fi
            fi
        fi
    done

    for i in "$path"/*; do
        if [ -d "$i" ]; then
            findMd "$i"
        fi
    done
}

cat >"./src/pages/projects.md" <<EOF |
---
title: "Projects"
date: "2020-05-07"
author: "Daniel Rufus Kaldheim"
type: "page"
path: "/projects"
---

Over the years I have had so many ideas that I forgot to do something about so I made my self a promise to write them down.
Here's a list of my notes about ideas and projects I'm currently working on.

You could also checkout my [github repo](https://github.com/danielkaldheim/my-public-notes) for my public notes

## My project notes

EOF
    echo "Start..."

cd notes
for path in ./Projects/*; do
    if [ -d "$path" ]; then
        if [ -f "$path/index.md" ]; then
            findMd "${path}"
        fi
    fi
done
