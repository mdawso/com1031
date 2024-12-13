.data
// Mat Dawson 6 12 22

.include "gpiolib.s"

// Aliases
.set middle, pin19
.set topLeft, pin13
.set topBar, pin6
.set topRight, pin5
.set dot, pin12
.set bottomRight, pin16
.set bottom, pin20
.set bottomLeft, pin21

.set button, pin18                                                                                  

.text

.global main

main:

	// enable pins

	ldr r0, =middle
	bl loadpin

	ldr r0, =topLeft
	bl loadpin

	ldr r0, =topBar
	bl loadpin

	ldr r0, =topRight
	bl loadpin

	ldr r0, =dot
	bl loadpin

	ldr r0, =bottomRight
	bl loadpin

	ldr r0, =bottom
	bl loadpin

	ldr r0, =bottomLeft
	bl loadpin
	
	ldr r0, =button
	bl loadpin
	
	bl nanoSleep
	
	// set direction
	
	mov r1, #1 		// Set the direction to out

	ldr r0, =middle		// Load the pin
	bl set_direction	// Set the direction

	ldr r0, =topLeft
	bl set_direction

	ldr r0, =topBar
	bl set_direction

	ldr r0, =topRight
	bl set_direction

	ldr r0, =dot
	bl set_direction

	ldr r0, =bottomRight
	bl set_direction

	ldr r0, =bottom
	bl set_direction

	ldr r0, =bottomLeft
	bl set_direction
	
	mov r1, #0
	
	ldr r0, =button
	bl set_direction
	
	bl nanoSleep
	
	bl none
	
	bl nanoSleep
	
	mov r4, #0
	mov r5, #0
	
	bl welcome
	
	bl loop

loop:

	mov r0, #1		// sleep r0/100 of a second
	bl partSleep
	
	ldr r0, =button
	bl read_value
	
	cmp r0, #0		// if button not pressed show output and reset r4
	bleq check_and_output
	
	cmp r0, #0
	moveq r4, #0
	
	cmp r0, #1
	addeq r4, r4, #1		// if button pressed begin to increment r4
		
	cmp r4, #30
	movlt r5, #1	// r5 = 1 represents a dot
	
	cmp r4, #0
	moveq r5, #0	// r5 = 0 represents no input
	
	cmp r4, #30
	movgt r5, #2		// r5 = 2 represents a dash
	
	cmp r4, #70
	movgt r5, #3		// r5 = 3 represents an invalid input
	
	bl loop
	
check_and_output:

	push {lr}

	cmp r5, #0
	bleq none
	
	cmp r5, #1
	bleq set_e
	
	cmp r5, #2
	bleq set_t
	
	cmp r5, #3
	bleq error
	
	pop {lr}
	bx lr
	
welcome:

	push {r0-r7, lr}
	
	mov r0, #50
	
	bl set_w
	
	bl partSleep
	
	bl none
	
	bl set_e
	
	bl partSleep
	
	bl none
	
	bl set_l
	
	bl partSleep
	
	bl none
	
	bl set_c
	
	bl partSleep
	
	bl none
	
	bl set_o
	
	bl partSleep
	
	bl none
	
	bl set_m
	
	bl partSleep
	
	bl none
	
	bl set_e
	
	bl partSleep
	
	bl none
	
	pop {r0-r7, lr}
	bx lr

error:

	push {r0-r7, lr}
	
	mov r0, #50
	
	bl set_e
	
	bl partSleep
	
	bl none
	
	bl set_r
	
	bl partSleep
	
	bl none
	
	bl set_r
	
	bl partSleep
	
	bl none
	
	bl set_o
	
	bl partSleep
	
	bl none
	
	bl set_r
	
	bl partSleep
	
	bl none
	
	pop {r0-r7, lr}
	bx lr
	
none:

	push {r0-r7, lr}

	ldr r1, =high 		// Set the direction to out

	ldr r0, =middle
	bl set_value

	ldr r0, =topLeft
	bl set_value

	ldr r0, =topBar
	bl set_value

	ldr r0, =topRight
	bl set_value

	ldr r0, =dot
	bl set_value

	ldr r0, =bottomRight
	bl set_value

	ldr r0, =bottom
	bl set_value

	ldr r0, =bottomLeft
	bl set_value
	
	pop {r0-r7, lr}
	bx lr
	
set_a:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =topLeft
	bl set_value
	
	ldr r0, =topBar
	bl set_value
	
	ldr r0, =topRight
	bl set_value
	
	ldr r0, =bottomRight
	bl set_value
	
	ldr r0, =middle
	bl set_value
	
	pop {r0-r7, lr}
	bx lr
	
set_b:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =topLeft
	bl set_value
	
	ldr r0, =bottomRight
	bl set_value
	
	ldr r0, =middle
	bl set_value
	
	ldr r0, =bottom
	bl set_value
	
	pop {r0-r7, lr}
	bx lr
	
set_c:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =middle
	bl set_value
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =bottom
	bl set_value
	
	pop {r0-r7, lr}
	bx lr
	
set_d:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =topRight
	bl set_value
	
	ldr r0, =bottomRight
	bl set_value
	
	ldr r0, =bottom
	bl set_value
	
	ldr r0, =middle
	bl set_value
	
	ldr r0, =bottomLeft
	bl set_value
	
	pop {r0-r7, lr}
	bx lr
	
set_e:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =topBar
	bl set_value
	
	ldr r0, =middle
	bl set_value
	
	ldr r0, =bottom
	bl set_value
	
	ldr r0, =topLeft
	bl set_value
	
	ldr r0, =bottomLeft
	bl set_value
	
	mov r0, #50
	bl partSleep
	
	pop {r0-r7, lr}
	bx lr
	
set_f:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =topBar
	bl set_value
	
	ldr r0, =middle
	bl set_value
	
	ldr r0, =topLeft
	bl set_value
	
	ldr r0, =bottomLeft
	bl set_value
	
	pop {r0-r7, lr}
	bx lr
	
set_g:
	push {r0-r7, lr}

	ldr r1, =low

	ldr r0, =topBar
	bl set_value
	
	ldr r0, =topLeft
	bl set_value

	ldr r0, =topRight
	bl set_value

	ldr r0, =middle
	bl set_value

	ldr r0, =bottomRight
	bl set_value

	ldr r0, =bottom
	bl set_value

	pop {r0-r7, lr}
	bx lr
	
set_h:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =topLeft
	bl set_value
	
	ldr r0, =bottomLeft
	bl set_value

	ldr r0, =middle
	bl set_value

	ldr r0, =bottomRight
	bl set_value

	pop {r0-r7, lr}
	bx lr
	
set_i:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =topRight
	bl set_value

	ldr r0, =bottomRight
	bl set_value

	pop {r0-r7, lr}
	bx lr
	
set_j:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =topRight
	bl set_value

	ldr r0, =bottomRight
	bl set_value
	
	ldr r0, =bottom
	bl set_value

	pop {r0-r7, lr}
	bx lr
	
set_k:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =topLeft
	bl set_value
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =middle
	bl set_value
	
	ldr r0, =topRight
	bl set_value
	
	ldr r0, =bottomRight
	bl set_value

	pop {r0-r7, lr}
	bx lr
	
set_l:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =topLeft
	bl set_value
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =bottom
	bl set_value

	pop {r0-r7, lr}
	bx lr
	
set_m:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =topLeft
	bl set_value
	
	ldr r0, =topBar
	bl set_value
	
	ldr r0, =topRight
	bl set_value
	
	ldr r0, =bottomRight
	bl set_value
	
	pop {r0-r7, lr}
	bx lr
	
set_n:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =middle
	bl set_value
	
	ldr r0, =bottomRight
	bl set_value
	
	pop {r0-r7, lr}
	bx lr
	
set_o:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =middle
	bl set_value
	
	ldr r0, =bottomRight
	bl set_value
	
	ldr r0, =bottom
	bl set_value
	
	pop {r0-r7, lr}
	bx lr
	
set_p:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =middle
	bl set_value
	
	ldr r0, =topBar
	bl set_value
	
	ldr r0, =topRight
	bl set_value
	
	ldr r0, =topLeft
	bl set_value
	
	pop {r0-r7, lr}
	bx lr
	
set_q:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =bottomRight
	bl set_value
	
	ldr r0, =middle
	bl set_value
	
	ldr r0, =topBar
	bl set_value
	
	ldr r0, =topRight
	bl set_value
	
	ldr r0, =topLeft
	bl set_value
	
	ldr r0, =dot
	bl set_value
	
	pop {r0-r7, lr}
	bx lr
	
set_r:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =middle
	bl set_value
	
	pop {r0-r7, lr}
	bx lr
	
set_s:
	push {r0-r7, lr}

	ldr r1, =low

	ldr r0, =topLeft
	bl set_value

	ldr r0, =middle
	bl set_value

	ldr r0, =topBar
	bl set_value

	ldr r0, =bottom
	bl set_value

	ldr r0, =bottomRight
	bl set_value

	ldr r0, =dot
	bl set_value

	pop {r0-r7, lr}
	bx lr
	
set_t:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =topLeft
	bl set_value
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =middle
	bl set_value
	
	ldr r0, =bottom
	bl set_value
	
	mov r0, #50
	bl partSleep

	pop {r0-r7, lr}
	bx lr
	
set_u:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =bottomRight
	bl set_value
	
	ldr r0, =bottom
	bl set_value
	
	ldr r0, =dot
	bl set_value

	pop {r0-r7, lr}
	bx lr
	
set_v:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =topLeft
	bl set_value
	
	ldr r0, =topRight
	bl set_value
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =bottomRight
	bl set_value
	
	ldr r0, =bottom
	bl set_value

	pop {r0-r7, lr}
	bx lr
	
set_w:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =topLeft
	bl set_value
	
	ldr r0, =topRight
	bl set_value
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =bottomRight
	bl set_value
	
	ldr r0, =bottom
	bl set_value
	
	ldr r0, =dot
	bl set_value

	pop {r0-r7, lr}
	bx lr
	
set_x:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =topLeft
	bl set_value
	
	ldr r0, =topRight
	bl set_value
	
	ldr r0, =bottomLeft
	bl set_value
	
	ldr r0, =bottomRight
	bl set_value
	
	ldr r0, =middle
	bl set_value

	pop {r0-r7, lr}
	bx lr

set_y:
	push {r0-r7, lr}

	ldr r1, =low
	
	ldr r0, =topLeft
	bl set_value

	ldr r0, =topRight
	bl set_value

	ldr r0, =middle
	bl set_value

	ldr r0, =bottomRight
	bl set_value

	ldr r0, =bottom
	bl set_value

	pop {r0-r7, lr}
	bx lr
	
set_z:
	push {r0-r7, lr}

	ldr r1, =low

	ldr r0, =topBar
	bl set_value

	ldr r0, =topRight
	bl set_value

	ldr r0, =middle
	bl set_value

	ldr r0, =bottomLeft
	bl set_value

	ldr r0, =bottom
	bl set_value
	
	ldr r0, =dot
	bl set_value

	pop {r0-r7, lr}
	bx lr
	
exit:
	
	bl none
	mov r0, #0	// Set to no error code
	mov r7, #1	// set the systemcall
	svc #0		// So the system call

.end
	
	
