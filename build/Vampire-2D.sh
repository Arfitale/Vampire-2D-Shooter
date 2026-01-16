#!/bin/sh
printf '\033c\033]0;%s\a' Your First 2D Game With Godot 4- START (GDQuest)
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Vampire-2D.x86_64" "$@"
