#!/bin/bash

print () {
    echo ""
    echo "------------"
    echo " $@"
    echo "------------"
}

print_lite () {
    echo ""
    echo "----- $@"
}

run_build() {
    bash $(pwd)/../build_arm64.sh gcc-10.3 clang+llvm-13 X01AD_defconfig
}

print "Checkout upstream"
git checkout -b upstream

print "Merge v4.9.269 to v4.9.282"
count=0
for i in {269..282}
do
    print_lite "Merge v4.9.$i"
    git merge -X ours --allow-unrelated-histories --no-edit v4.9.$i
    ((count=count+1))
    echo $count

    if [[ $count -eq 10 ]]; then
        if run_build; then
            break
        else
            break
        fi
    fi
done
print "DONE"