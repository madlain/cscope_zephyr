#!/bin/sh

cd "$ZEPHYR_BASE"
rm -f cscope.* TAGS gtags.files GPATH GRTAGS GTAGS
cd -

find "$PWD"/src -type f -name *.c -o -name *.h  >> "$ZEPHYR_BASE"/cscope.files

# Warn user about missing generated header files
if test -d "$PWD"/build/zephyr/include/generated ; then
    find "$PWD"/build/zephyr/include/generated -type f -name *.h  >> "$ZEPHYR_BASE"/cscope.files
else
    printf "Generated header files board will be missing...\n"
fi

cd "$ZEPHYR_BASE"

find arch/arm/core -type f -name *.c -o -name *.h  -o -name *.S >> cscope.files
find arch/arm/include -type f -name *.c -o -name *.h  >> cscope.files

find soc/arm/atmel_sam/common -type f -name *.c -o -name *.h  >> cscope.files
# find soc/arm/atmel_sam/sam4l4  -type f -name *.c -o -name *.h  >> cscope.files
find soc/arm/atmel_sam/sam4l4  -type f -name *.c -o -name *.h  | grep -v fixup >> cscope.files

find boards/arm/atsam4l_xpro -type f -name *.c -o -name *.h  >> cscope.files

find drivers -type f -name *.c -o -name *.h  >> cscope.files

# ASF header files
find ext/hal/atmel/asf/sam/include/sam4l4/component -type f -name *.h  >> cscope.files
find ext/hal/atmel/asf/sam/include/sam4l4/instance -type f -name *.h  >> cscope.files

find include -type f -name *.c -o -name *.h -not -path "include/arch/*" >> cscope.files
find include/arch/arm -type f -name *.c -o -name *.h >> cscope.files
find kernel -type f -name *.c -o -name *.h  >> cscope.files
find misc -type f -name *.c -o -name *.h  >> cscope.files

find subsys/console -type f -name *.c -o -name *.h  >> cscope.files
find subsys/debug -type f -name *.c -o -name *.h  >> cscope.files
find subsys/logging -type f -name *.c -o -name *.h  >> cscope.files
find subsys/usb -type f -name *.c -o -name *.h  >> cscope.files

cscope -bkq

ctags -e -L cscope.files

cp -p cscope.files gtags.files

cd -
