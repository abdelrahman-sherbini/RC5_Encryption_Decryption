.def K=r16
.def P2= r18  ;high
.def P1 =r19  ;low
.def Q2 = r20 ;high
.def Q1 = r21 ;low
#define	r_remL	r26	/* remainder Low */
#define	r_remH	r27	/* remainder High */

/* return: remainder */
#define	r_arg1L	r6	/* dividend Low */
#define	r_arg1H	r7	/* dividend High */

#define	r_arg1L2	r16	/* dividend Low */
#define	r_arg1H2	r17	/* dividend High */

/* return: quotient */
#define	r_arg2L	r22	/* divisor Low */
#define	r_arg2H	r23	/* divisor High */
	
#define	r_cnt	r24	/* loop count */
;carr: ldi r24,1 
;push r24
;ldi K, $00000000
;ldi r17, $00000000

;key K is 24 zeros in 0x200 to 0x212 12 byte so is L
; we are dealing with 16 bits key two neighboring registers
ldi P1, 0xe1
ldi P2, 0xb7
ldi Q1, 0x37
ldi Q2, 0x9e
LDI R30, HIGH($8FF)
OUT SPH, R30
LDI R30, LOW($8FF)
OUT SPL, R30
push p1
push p2
push r0
ldi r31,0x17
mov r1,r31
Sarray:pop r24  ;carry
pop r22 ;high
pop r23 ;low
push r23
push r22
push r24
add r23,q1
adc r22,q2
adc r24,r0
push r23
push r22
push r24
;brcs carr
dec r1
cpse r1,r0
rjmp Sarray

ldi r30,LOW(0x900)
ldi r31,HIGH(0x900)
ldi r29,54
mov r2,r29
ldi r29,0x3
mov r15,r29
ldi r28,LOW(0x1fe)
ldi r29,HIGH(0x1fe)
;r3 r4 r5 A r6 r7 r8 B   25 26 27
ldi r16,17 ; sub from z
ldi r17,5; sub from y

sthru:
ld r23,-z ;13
ld r22,-z ;12
ld r24,-z ;14
add r3,r23 ;13
adc r4,r22 ;12
adc r5,r24 ;14
add r3,r6
adc r4,r7
adc r5,r8
rotate:
mov r9,r3
mov r10,r4
mov r11,r5
rol r3
bst r10,7
bld r3,0
rol r4
bst r9,7
bld r4,0
;bst r10,7
;bld r5,0
dec r15
brne rotate
ld r14,z+
st z+,r4
st z+,r3
ld r12,-z
ld r12,-z
ld r12,-z
add r6,r3
adc r7,r4
adc r8,r5
;mov r12,r6 ;loop 1
;mov r13,r7
;mov r14,r8 call here
ld r23,y+
ld r22,y+
add r6,r23
adc r7,r22
adc r8,r0
ldi r_arg2L, LOW(0x11)
ldi r_arg2H, HIGH(0x11)
call mod

rotate2:
mov r9,r6
mov r10,r7
;mov r11,r8
rol r6
bst r10,7
bld r6,0
rol r7
bst r9,7
bld r7,0
;bst r10,7
;bld r8,0
dec r26
brne rotate2
st y+,r6
st y+,r7
ld r12,-y
ld r12,-y
;st y+,r8
;#define	r_arg1L	r6	/* dividend Low */
;#define	r_arg1H	r7	/* dividend High */
;ldi r_arg2L,LOW(0x18)
;ldi r_arg2H, HIGH(0x18)
;call mod2
;sub r0,r16

dec r16
sub r16,r0
in r18,sreg
sbrc r18,1
call reset
dec r17
sub r17,r0
in r18,sreg
sbrc r18,1
call reset2
dec r2
cpse r2,r0
rjmp sthru

ldi r30,LOW(0x900)
ldi r31,HIGH(0x900)
ldi r28,LOW(0x800)
ldi r29,HIGH(0x800)
ldi r18,80
copy:
ld r12,-z
st y+,r12
dec r18
cpse r18,r0
rjmp copy

ldi r28,LOW(0x800)  ;S[] y
ldi r29,HIGH(0x800)

ldi r30,LOW(0x600)   ;raw data A 1st block z
ldi r31,HIGH(0x600) 
;word word 16 16 
ldi r26,LOW(0x500)  ;raw data B 2nd block  x
ldi r27,HIGH(0x500)


ldi r16,LOW(0x5005)
ldi r17,HIGH(0x5005)
ldi r18,LOW(0x8997)
ldi r19,HIGH(0x8997)
st z+,r16
st z+,r17
ld r11,-z
ld r11,-z
st x+,r18
st x+,r19
ld r11,-x
ld r11,-x

ld r1 ,z+
ld r3 ,y+
add r1,r3
ld r2 ,z+
ld r4 ,y+
adc r2,r4
ld r12,y+
ld r12 ,-z
ld r12 ,-z
st z+,r1
st z+,r2


ld r1 ,x+
ld r3 ,y+
add r1,r3
ld r2 ,x+
ld r4 ,y+
adc r2,r4
ld r12,y+
ld r12 ,-x
ld r12 ,-x
st x+,r1
st x+,r2

ldi r19,9 
ldi r20,1
ldi r18,6 ;increemamdms
#define	r_remL2	r16	/* remainder Low */
#define	r_remH2	r17	/* remainder High */

/* return: remainder */
;#define	r_arg1L	r6	/* dividend Low */
;#define	r_arg1H	r7	/* dividend High */


/* return: quotient */
;#define	r_arg2L	r22	/* divisor Low */
;#define	r_arg2H	r23	/* divisor High */ 
ldi r21 ,0x80
encloop:
ld r3 , -z
ld r2 , -z
ld r4 , -x ;high ***-** mod
ld r5 , -x ;low
eor r2,r5
eor r3,r4  ;high
ldi r_arg2L, LOW(0x10)
ldi r_arg2H, HIGH(0x10)
mov r6,r5
mov r7,r4
call mod2
r6rotate:
mov r9,r2
mov r10,r3
rol r2
bst r10,7
bld r2,0
rol r3
bst r9,7
bld r3,0
dec r6
brne r6rotate
;ld r11,y+2
;ldi r28,LOW(0x800)  ;S[] y
;ldi r29,HIGH(0x800)
ld r11,y+
ld r12,y+
add r2,r11
adc r3,r12
/*ld r12,-y
ld r12,-y*/
ld r12,z+ ;comment if in place next 4
ld r12,z+
ld r12,x+
ld r12,x+
st z+,r2 ;A enc
st z+,r3 ;B enc


ld r5 , -x ;high ***-** mod
ld r4 , -x ;low
eor r4,r2
eor r5,r3
ldi r_arg2L, LOW(0x10)
ldi r_arg2H, HIGH(0x10)
mov r6,r2
mov r7,r3
call mod2
r62rotate:
mov r9,r4
mov r10,r5
rol r4
bst r10,7
bld r4,0
rol r5
bst r9,7
bld r5,0
dec r6
brne r62rotate
;ld r11,y+2
;ldi r28,LOW(0x800)  ;S[] y
;ldi r29,HIGH(0x800)
ld r11,y+
ld r11,y+
ld r12,y+
add r4,r11 ;change low hifgh
adc r5,r12  ;high
ld r12,y+
ld r12,x+;comment if in place next 2
ld r12,x+
st x+,r4  ;enc data
st x+,r5  ;enc data

/*ldi r25,0x80
sub r25,r0
in r24,sreg
sbrs r24,1*/
;add r28,r18 ;add
/*ldi r25,0x80
sub r25,r0
in r24,sreg
sbrc r24,1
mov r0,r21*/
;mov r28,r0  ;S[] y

;wa2f 3and s[2*i+1]
inc r20
cpse r20,r19
rjmp encloop

;ldi r16,3
;ldd r12,y+3
ldi r20,8
;ldi r24,3
clr r0
/*fixloop:



dec r24
brne fixloop*/
;mov r2,r28
;mov r3,r29
;ldi r28,0x50
/*fixlo:
st y+,r0
sub r28,r0
brne fixlo
mov r28,r2
mov r29,r3*/
;ldi r21,4
;ldi r28,0xc0
ldi r19,2

decloop:
ld r3 , -x ;high
ld r2 , -x
ld r4 , -z ;high ***-** mod
ld r5 , -z ;low
;ldi r_arg2L, LOW(0x2)
;ldi r_arg2H, HIGH(0x2)
;mov r6,r28

;sub r7,r7
;ldi r25,0x80
;sub r25,r6
;in r24,sreg
;sbrc r24,1
;call fix
;call mod2
;sub r21,r0
;in r24,sreg
;sbrs r24,1
;dec r21
;in r24,sreg
;sbrs r24,1
;call fix2
;mov r28,r22
ld r11,-y
ld r12,-y
ld r11,-y
sub r2,r11
sbc r3,r12
ldi r_arg2L, LOW(0x10)
ldi r_arg2H, HIGH(0x10)
mov r6,r5
mov r7,r4
call mod2
r6rotater:
mov r9,r2 ;low
mov r10,r3 ;high
ror r2
bst r10,0
bld r2,7
ror r3
bst r9,0
bld r3,7
dec r6
brne r6rotater
eor r2,r5
eor r3,r4
st -x,r3 ;e7tmal low high 5laas
st -x,r2  ;decr data 
ld r5,z+
ld r4,z+
ld r11,-y
ld r12,-y
ld r11,-y
sub r5,r11
sbc r4,r12 ;high
ldi r_arg2L, LOW(0x10)
ldi r_arg2H, HIGH(0x10)
ld r6,x+
ld r7,x+
call mod2
r62rotater:
mov r9,r5
mov r10,r4
ror r5
bst r10,0
bld r5,7
ror r4
bst r9,0
bld r4,7
dec r6
brne r62rotater
ld r7,-x ;cha
ld r6,-x
ld r6,x+ ;comment if in place next 2
ld r7,x+
eor r5,r6
eor r4,r7
/*sub r19,r0
in r24,sreg
sbrs r24,1
dec r19
in r24,sreg
sbrs r24,1
ld r12, -z
sbrs r24,1
ld r12, -z*/
/*sbrs r24,1
ld r12, z+
sbrs r24,1
ld r12, z+*/
ld r12,-z ;comment if in place next 2
ld r12,-z
st -z,r4 ;dec data
st -z,r5  ;dec data
ld r12,z+ 
ld r12,z+
dec r20
in r18,sreg
sbrs r18,1
rjmp decloop

ldi r28,LOW(0x800)  ;S[] y
ldi r29,HIGH(0x800)

ldi r30,LOW(0x600)   ;raw data A 1st block z
ldi r31,HIGH(0x600) 
;word word 16 16 
ldi r26,LOW(0x500)  ;raw data B 2nd block  x
ldi r27,HIGH(0x500)
;last decr
ld r10,z+
ld r11,z+
ld r3,y+
ld r4,y+
sub r10,r3
sbc r11,r4
st -z ,r11
st -z,r10
ld r1,x+
ld r2,x+
ld r12,y+
ld r3,y+
ld r4,y+
sub r1,r3
sbc r2,r4
st -x,r2
st -x,r1
inf: rjmp inf
;ldi r_arg1L,LOW(0xbf0a)
;ldi r_arg1H,HIGH(0xbf0a)

mod:
	sub	r_remL,r_remL
	sub	r_remH,r_remH	; clear remainder and carry
	mov r13,r_arg1L
	mov r14,r_arg1H
	ldi	r_cnt,17	; init loop counter
	rjmp	__udivmodhi4_ep	; jump to entry point
__udivmodhi4_loop:
        rol	r_remL		; shift dividend into remainder
	rol	r_remH
        cp	r_remL,r_arg2L	; compare remainder & divisor
	cpc	r_remH,r_arg2H
        brcs	__udivmodhi4_ep	; remainder < divisor
        sub	r_remL,r_arg2L	; restore remainder
        sbc	r_remH,r_arg2H
__udivmodhi4_ep:
        rol	r_arg1L		; shift dividend (with CARRY)
        rol	r_arg1H
        dec	r_cnt		; decrement loop counter
        brne	__udivmodhi4_loop
	com	r_arg1L
	com	r_arg1H
; div/mod results to return registers, as for the div() function
	mov	r_arg2L, r_arg1L	; quotient
	mov	r_arg2H, r_arg1H
	mov	r_arg1L, r_remL		; remainder
	mov	r_arg1H, r_remH
	mov	r_arg1L, r13		; remainder
	mov	r_arg1H, r14
	
	ret
mod2:
	sub	r_remL2,r_remL2
	sub	r_remH2,r_remH2	; clear remainder and carry
	;mov r13,r_arg1L
	;mov r14,r_arg1H
	ldi	r_cnt,17	; init loop counter
	rjmp	__udivmodhi4_ep2	; jump to entry point
__udivmodhi4_loop2:
        rol	r_remL2		; shift dividend into remainder
	rol	r_remH2
        cp	r_remL2,r_arg2L	; compare remainder & divisor
	cpc	r_remH2,r_arg2H
        brcs	__udivmodhi4_ep2	; remainder < divisor
        sub	r_remL2,r_arg2L	; restore remainder
        sbc	r_remH2,r_arg2H
__udivmodhi4_ep2:
        rol	r_arg1L		; shift dividend (with CARRY)
        rol	r_arg1H
        dec	r_cnt		; decrement loop counter
        brne	__udivmodhi4_loop2
	com	r_arg1L
	com	r_arg1H
; div/mod results to return registers, as for the div() function
	mov	r_arg2L, r_arg1L	; quotient
	mov	r_arg2H, r_arg1H
	mov	r_arg1L, r_remL2		; remainder
	mov	r_arg1H, r_remH2
	;mov	r_arg1L2, r13		; remainder
	;mov	r_arg1H2, r14
	
	ret
reset:
ldi r16,17
ldi r30,LOW(0x900)
ldi r31,HIGH(0x900)
ret
reset2:
ldi r17,5
ldi r28,LOW(0x1fe)
ldi r29,HIGH(0x1fe)
ret
fix:
bst r24,1
bld r7,0
ret
fix2:
ldi r22,0x80
ret