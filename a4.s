.global _start

.equ amark, 90     
.equ bmark, 75     
.equ cmark, 50    

_start:

    LDR R6, =amark  // Load the value of 'amark' into register R6
    LDR R7, =bmark  // Load the value of 'bmark' into register R7
    LDR R8, =cmark  // Load the value of 'cmark' into register R8

input_loop:
    LDR R1, =prompt // Load the memory address of the prompt message
    LDR R2, =plen   // Load the length of the prompt message
    MOV R7, #4      // Set the syscall number for 'write'
    SWI #0          // Invoke syscall to print the prompt

    // Read the percentage grade from the user
    MOV R7, #3      // Set the syscall number for 'read'
    LDR R1, =buffer // Load the memory address of the buffer
    LDR R2, =buffer // Load the size of the buffer
    SWI #0          // Invoke syscall to read the input

    // Convert the buffer content to an integer value
    LDR R5, [R1]    // Load the integer value from the buffer

    // Compare the percentage grade with the grading thresholds
    CMP R5, R6      // Compare with 'amark' (A grade threshold)
    BGE agrade      // Branch to agrade if R5 >= R6

    CMP R5, R7      // Compare with 'bmark' (B grade threshold)
    BGE bgrade      // Branch to bgrade if R5 >= R7

    CMP R5, R8      // Compare with 'cmark' (C grade threshold)
    BGE cgrade      // Branch to cgrade if R5 >= R8

    // If none of the conditions were met, print "Sorry, you got an F."
    LDR R1, =fmessage
    LDR R2, =flen
    MOV R7, #4      // Set the syscall number for 'write'
    SWI #0          // Invoke syscall to print the message
    B input_loop    // Loop back to the input loop

agrade:
    // Print "Congratulations! You got an A."
    LDR R1, =amessage
    LDR R2, =alen
    MOV R7, #4      // Set the syscall number for 'write'
    SWI #0          // Invoke syscall to print the message
    B input_loop    // Loop back to the input loop

bgrade:
    // Print "Good job! You got a B."
    LDR R1, =bmessage
    LDR R2, =b_len  // Has to be set to b_len because of branching 
    MOV R7, #4      // Set the syscall number for 'write'
    SWI #0          // Invoke syscall to print the message
    B input_loop    // Loop back to the input loop

cgrade:
    // Print "Not bad, you got a C."
    LDR R1, =cmessage
    LDR R2, =clen
    MOV R7, #4      // Set the syscall number for 'write'
    SWI #0          // Invoke syscall to print the message
    B input_loop    // Loop back to the input loop

end:
    // End of the program
    MOV R7, #1       // Set the syscall number for 'exit'
    MOV R0, #0       // Set the exit status code
    SWI #0           // Invoke syscall to exit

.data
prompt:
    .asciz "Please enter your percentage grade: "
plen = . - prompt   // Calculate the length of the prompt message

buffer:
    .space 10 // Define the buffer for input storage

grade:
    .byte 0          // Storage for the input percentage grade

amessage:
    .asciz "Congratulations! You got an A.\n"
alen = . - amessage // Calculate the length of the A-grade message

bmessage:
    .asciz "Good job! You got a B.\n"
b_len = . - bmessage // Calculate the length of the B-grade message

cmessage:
    .asciz "Not bad, you got a C.\n"
clen = . - cmessage // Calculate the length of the C-grade message

fmessage:
    .asciz "Sorry, you got an F.\n"
flen = . - fmessage // Calculate the length of the F-grade message
