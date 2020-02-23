org 0x7c00
setup:

push word 0
pop cs
push word 0
pop ds
push word 0
pop es
jmp start

print:
  pusha
  mov ah, 0Eh
  mov bh, 0
.loop:
  lodsb
  cmp al, 0
  je .end
  int 10h
  jmp .loop
.end:
  popa
  ret

getstring:
  pusha
  mov di, buffer
.loop:
  xor ah, ah
  int 16h
  cmp al, 13
  je .end
  stosb
  mov ah, 0x0E
  mov bh, 0
  int 10h
  jmp .loop
.end:
  xor al, al
  stosb
  popa
  ret
.tmp db 0

start:
  mov si, welcome
  call print
.entrance:
  mov si, entrancedesc
  call print
  cmp [has_key], 0
  jne .entrance_rep
  mov si, keyis
  call print
.entrance_rep:
  mov si, prompt
  call print
  call getstring
  mov si, nl
  call print
  cmp dword [buffer], "take"
  je .take_ent
  cmp dword [buffer], "drop"
  je .drop_ent
  cmp dword [buffer], "desc"
  je .entrance
  cmp dword [buffer], "pack"
  je .inventory
  cmp dword [buffer], "plug"
  je .plugh
  cmp dword [buffer], "nort"
  je .finish_bump
  cmp dword [buffer], "sout"
  je .finish_bump
  cmp dword [buffer], "east"
  je .bonk
  cmp dword [buffer], "west"
  je .bonk
.huh_ent:
  mov si, what
  call print
  jmp .entrance_rep
.take_ent:
  cmp word [buffer+5], "ke"
  jne .huh_ent
  cmp byte [buffer+7], "y"
  jne .huh_ent
  cmp [has_key], 0
  jne .huh_ent
  mov [has_key], 1
  mov si, grabkey
  call print
  jmp .entrance_rep
.drop_ent:
  cmp word [buffer+5], "ke"
  jne .huh_ent
  cmp byte [buffer+7], "y"
  jne .huh_ent
  cmp [has_key], 0
  je .huh_ent
  mov [has_key], 0
  mov si, dropkey
  call print
  jmp .entrance_rep
.inventory:
  mov si, inventory
  cmp [has_key], 0
  je .inventory_has_no
  mov si, key
  call print
  mov si, nl
  call print
  jmp .entrance_rep
.inventory_has_no:
  mov si, nothing
  call print
  mov si, nl
  call print
  jmp .entrance_rep
.plugh:
  cmp byte [buffer+4], "h"
  jne .entrance_rep
  mov si, plugh
  call print
  jmp .entrance_rep
.finish_bump:
  cmp byte [buffer+4], "h"
  jne .huh_ent
.bonk:
  mov si, bonk
  call print
  jmp .entrance_rep

welcome db "* Adventure512 *",13,10,13,10,0
entrancedesc db "Entrance",13,10,0
keyis db "A key is here.",13,10,0
bonk db "Ow!",13,10,0
grabkey db "You take the key.",13,10,0
dropkey db "You drop the key.",13,10,0
what db "???",0
inventory db "Inventory:",0
key db "key",0
nothing db "nothing",0
nl db 13,10,0
prompt db ">",0
plugh db "No cave here",13,10,0
has_key db 0

dw 0xAA55
buffer:
times (1024*1440-512) db 0
