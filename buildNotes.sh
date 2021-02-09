#!/bin/bash

url_var() {
    local LC_ALL=C
    local encoded=""
    local i c

    for ((i = 0; i < ${#1}; i++)); do
        c=${1:$i:1}
        case "$c" in
        [a-zA-Z0-9/_.~-]) encoded="${encoded}$c" ;;
        *) printf -v encoded "%s%%%02x" "$encoded" "'${c}" ;;
        esac
    done
    [ $# -gt 1 ] &&
        printf -v "$2" "%s" "${encoded}" ||
        printf "%s\n" "${encoded}"
}

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

    if [ -f "$path/Readme.md" ]; then
        echo "$path/Readme.md"
        cat "$path/Readme.md" | sed -E 's/\[\< Parent\]\(..\/Readme.md\)//g' | sed -E '1,2{/^$/d;}' > "$path/Readme.md.tmp"

        date=$(git log --pretty='format:%C(auto)%ai' -1 "HEAD" -- "$path/Readme.md")
        title=$(echo -n $(head -n 1 "$path/Readme.md.tmp") | sed -e 's/# //g')
        author=$(git log --pretty='format:%C(auto)%an' -1 "HEAD" -- "$path/Readme.md")
        slug=$(echo -n $title | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z.md)
        githubUrl=$(url_var "$basename")

        echo "---"
        echo "title: ${title}"
        echo "date: ${date}"
        echo "author: ${author}"
        echo "slug: ${slug}"
        echo "github: ${githubUrl}"
        echo "---"
        echo "- [${title}](/projects/$slug)" >>../src/pages/projects.md

        #tags: ["Projects", "${title}"]
        cat >"${name}" <<EOF |
---
title: "${title}"
date: "${date}"
author: "${author}"
type: "page"
path: "/projects/${slug}"
github: https://github.com/danielkaldheim/my-public-notes/tree/master/Projects/${githubUrl}
---
EOF
            if [ -d "$path/images" ]; then
                mkdir -p "../src/images/projects/$imageSlug/images"
                cp -r "$path/images/." "../src/images/projects/$imageSlug/images/"
            fi

        images=$(cat "$path/Readme.md" | grep -- '\.jpg\|\.jpeg\|\.png\|\.gif\|\.svg' | sed -E "s,\!\[(.+)\]\(.\/(.+).(jpg|jpeg|png|gif|svg)\),\2.\3,g")
        for image in $images; do
            if [ -f "$path/$image" ]; then
                # echo "$path/$image"
                mkdir -p "../src/images/projects/$imageSlug/images"
                cp "$path/$image" "../src/images/projects/$imageSlug/$image"
            fi
        done

        cat "$path/Readme.md.tmp" | sed -E "s/^#/$bangs/g" | sed -E "s/^# $title//g" | sed -E "$sedImages" | sed -E "s/\`\`\`sh/\`\`\`bash/g" >>"${name}"
        hasIndex=true
    fi
    for file in "$path"/*.md; do
        if [ -f "$file" ]; then
            # echo "$path -> $file ($depth) -> $bangs"
            if [[ "$file" != "$path/Readme.md" && "$file" != "$path/$name" && "$file" != "$path/Markdown Cheatsheet.md" ]]; then

                images=$(cat "$file" | grep -- '\.jpg\|\.jpeg\|\.png\|\.gif\|\.svg' | sed -E "s,\!\[(.+)\]\(.\/(.+).(jpg|jpeg|png|gif|svg)\),\2.\3,g")
                for image in $images; do
                    if [ -f "$path/$image" ]; then
                        # echo "$path/$image"
                        mkdir -p "../src/images/projects/$imageSlug/images"
                        cp "$path/$image" "../src/images/projects/$imageSlug/$image"
                    fi
                done
                echo '' >>"${name}"
                if [ "$hasIndex" == "true" ]; then
                    cat "$file" | sed -E 's/\[\< Parent\](..\/Readme.md).*//g' | sed -E '1,2{/^$/d;}' | sed -E "s/^#/#$bangs/g" | sed -E "$sedImages" | sed -E "s/\`\`\`sh/\`\`\`bash/g" >>"${name}"
                else
                    cat "$file" | sed -E 's/\[\< Parent\](..\/Readme.md).*//g' | sed -E '1,2{/^$/d;}' | sed -E "s/^#/$bangs/g" | sed -E "$sedImages" | sed -E "s/\`\`\`sh/\`\`\`bash/g" >>"${name}"
                fi
            fi
        fi
    done

    if [ -f "$path/Readme.md.tmp" ]; then
        rm "$path/Readme.md.tmp"
    fi
    for i in "$path"/*; do
        if [ -d "$i" ]; then
            findMd "$i"
        fi
    done
}

#git submodule update --init --recursive --remote

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

You could also checkout my [github repo](https://github.com/danielkaldheim/my-public-notes) for my public notes.

## My project notes

EOF
    echo "Start..."

cd notes
for path in ./Projects/*; do
    if [ -d "$path" ]; then
        if [ -f "$path/Readme.md" ]; then
            findMd "${path}"
        fi
    fi
done
