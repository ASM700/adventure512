# Adventure512
Extremely simple adventure game in 512 bytes

## Instructions for compiling

Compile with FASM or other assembler. Run on VirtualBox(tested), QEMU, etc. THIS HAS NOT BEEN TESTED ON **REAL HARDWARE**! BEWARE! It might be buggy or crash.

## How to play

You can type `north`,`south`,`east`,`west`,`take`,`drop`,`pack`,and `plugh`

### Cardinal directions

For now, since this is 1-room, these just say "Ow!" because you bonk into a wall.

### Object interaction

For now, there is only one object, a key. You can type `take key` and `drop key`. The description changes from

`Entrance`

`A key is here`

to just

`Entrance`

Taking and dropping the key sets a byte to 1 and 0.

### Pack (inventory)

The command `pack` shows you your inventory.

Normal output with key:
`Inventory: key`

### Plugh (easter egg)

The command `plugh` references Colossal Cave Adventures. It displays `No cave here`, as a joke.

## Limitations
 - Since the code only looks at the command and not what follows it, `plughlol` will be interpreted as `plugh`.
 - This takes all 512 bytes, with no extra space, so not much room for improvement.
 - Since it all has to fit into 512 bytes, the strings are very short and don't give much information.
