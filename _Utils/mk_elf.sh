#! /bin/bash



#To prepare amforth for simulation in simulavr one needs to convert
#the hex files generated by avrasm2 into the elf format.
#Assuming, that you've generated amforth from the template,
#you can do it using the following commands:

#srec_cat template.eep.hex -Intel \
# -fill 0xFF 0x00 -maximum-address template.eep.hex -Intel \
# -multiple  -Output eeprom.bin -Binary

FN_HEX=AttoBASICV230.hex
FN_BIN=AttoBASICV230.bin
FN_ELF=AttoBASICV230.elf

srec_cat ${FN_HEX} -Intel \
 -fill 0xFF 0x00 -maximum-address ${FN_HEX} -Intel \
 -multiple -Output ${FN_BIN} -Binary

avr-objcopy --rename-section .data=.text,CONTENTS,ALLOC,LOAD,READONLY,CODE \
	-I binary ${FN_BIN} -O elf32-avr ${FN_ELF}

#avr-objcopy --rename-section .data=.text,CONTENTS,ALLOC,LOAD,READONLY,CODE \
#  --set-section-flags .eeprom=CONTENTS,ALLOC,LOAD,READONLY \
#  --add-section .eepromîprom.bin \
#  --change-section-vma .eeprom=0x810000 \
#  -I binary  code.bin  -O elf32-avr code.elf