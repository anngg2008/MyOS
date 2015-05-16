SRC:=pmtest4.asm
BIN:=$(subst .asm,.com,$(SRC))

.PHONY : everything

everything : $(BIN) abc.img
	sudo mkdir aaa
	sudo mount -o loop abc.img aaa/
	sudo cp $(BIN) aaa/ -v
	sudo umount aaa/
	sudo rm -rf aaa/
	
$(BIN) : $(SRC)
	nasm $< -o $@

abc.img:
	bximage -fd -size=1.44 -q a.img
	mv a.img abc.img
	sudo mkfs.msdos $@

.PHONY : run
run:
	bochs -q
.PHONY : clean
clean:
	 rm $(BIN)
	 rm abc.img
