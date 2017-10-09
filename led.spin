CON
_clkmode = xtal1 + pll16x
_XINFREQ = 5_000_000

PUB Main
'    cognew(@pasm_1,0)
'    cognew(@pasm_2,0)
'    cognew(@pasm_3,0)
'    cognew(@pasm_4,0)
'    cognew(@pasm_6,0)
'    cognew(@pasm_7,0)
'    cognew(@pasm_8,0)
    cognew(@pasm_9,0)



DAT
pasm_1      org
            or      dira,:Pin_16
            or      outa,:Pin_16
            jmp     #$

:Pin_16     long    1<<18

'-----------------------------------------
pasm_2      org
            or      dira,:Pin_16
:loop
            or      outa,:Pin_16
            andn    outa,:Pin_16
            jmp     #:loop

:Pin_16     long    1<<18

'-----------------------------------------
pasm_3          org
                or      dira,:Pin_16
:loop
                or      outa,:Pin_16
                mov     :Delay_counter,:Delay_1s
                djnz    :Delay_counter,#$
                andn    outa,:Pin_16
                mov     :Delay_counter,:Delay_1s
                djnz    :Delay_counter,#$
                
                jmp     #:loop

:Pin_16         long    101<<18
:Delay_1s       long    20_000_000
:Delay_counter  res 1

'-----------------------------------------
pasm_4          org
                or      dira,:Pin_16_23
:loop
                add     outa,:Pin_16
                mov     :Delay_counter,:Delay_1s
                djnz    :Delay_counter,#$
                
                jmp     #:loop

:Pin_16         long    1<<16
:Pin_16_23      long    $FF<<16
:Delay_1s       long    20_000_000
:Delay_counter  res 1

'-----------------------------------------
pasm_6          org
                or      dira,:Pin_16_23
:reset
                mov     outa,:Pin_16
:loop
                mov     :Delay_counter,:Delay_1s
                djnz    :Delay_counter,#$
                rol     outa,#1
                cmp     outa,:Pin_24    wz
    if_z        jmp     #:reset
                jmp     #:loop

:Pin_16         long    1<<16
:Pin_16_23      long    $FF<<16
:Pin_24         long    1<<24
:Delay_1s       long    20_000_000
:Delay_counter  res 1

'-----------------------------------------
pasm_7          org
                or      dira,:Pin_16_23
:addloop
                add     outa,:Pin_16
                mov     :Delay_counter,:Delay_50ms
                djnz    :Delay_counter,#$
                cmp     outa,:Pin_24    wz
    if_ne       jmp     #:addloop

:rotateloop
                ror     outa,#1
                mov     :Delay_counter,:Delay_100ms
                djnz    :Delay_counter,#$
                cmp     outa,:Pin_16    wz
    if_ne       jmp     #:rotateloop
                jmp     #:addloop

:Pin_16         long    1<<16
:Pin_16_23      long    $FF<<16
:Pin_24         long    1<<24
:Delay_50ms     long    1_000_000
:Delay_100ms    long    2_000_000
:Delay_counter  res 1

'-----------------------------------------
pasm_8          org
                or      dira,:Pin_16_23
                mov     :nb,#0
:reset
                add     :nb,#1
                mov     outa,:Pin_16
                cmp     :nb,#5          wz
   if_z         jmp     #$
:loop
                mov     :Delay_counter,:Delay_1s
                djnz    :Delay_counter,#$
                rol     outa,#1
                cmp     outa,:Pin_24    wz
    if_z        jmp     #:reset
                jmp     #:loop

:Pin_16         long    1<<16
:Pin_16_23      long    $FF<<16
:Pin_24         long    1<<24
:Delay_1s       long    20_000_000
:Delay_counter  res     1
:nb             res     1

'---------------------------------------
pasm_9          org
                or      dira,:Pin_16_23
                mov     :blinky,#%10101010
:loop
                shr     :blinky,#1      wc,wz
                muxc    outa,:Pin_16
                muxnc   outa,:Pin_17
                muxz    outa,:Pin_18
                muxnz   outa,:Pin_19
                mov     :Delay_counter,:Delay_1s
                djnz    :Delay_counter,#$
                jmp     #:loop
                
:Pin_16         long    1<<16
:Pin_17         long    1<<17
:Pin_18         long    1<<18
:Pin_19         long    1<<19
:Pin_16_23      long    $FF<<16
:Delay_1s       long    20_000_000
:Delay_counter  res     1
:blinky         res     1
                fit 496