.global _start

.equ amark, 90     
.equ bmark, 75     
.equ cmark, 50     

_start:

    LDR R6, =amark  // Load the value of 'amark' into register R6
    LDR R7, =bmark  // Load the value of 'bmark' into register R7
    LDR R8, =cmark  // Load the value of 'cmark' into register R8

    LDR R1, =prompt // Load the memory address of the prompt message
    LDR R2, =plen   // Load the length of the prompt message
    MOV R7, #4       // Set the syscall number for 'write'
    SWI #0           // Invoke syscall to print the prompt

    // Read the percentage grade from the user
    MOV R7, #3       // Set the syscall number for 'read'
    LDR R1, =grade   // Load the memory address of the 'grade' variable
    LDR R2, =1       // Load the number of bytes to read
    SWI #0           // Invoke syscall to read the input

    LDR R5, [grade]  // Load the value of 'grade' into register R5

    // Compare the percentage grade with the grading thresholds
    CMP R5, R6       // Compare with 'amark' (A grade threshold)
    BGE a_grade      // Branch to a_grade if R5 >= R6

    CMP R5, R7       // Compare with 'bmark' (B grade threshold)
    BGE b_grade      // Branch to b_grade if R5 >= R7

    CMP R5, R8       // Compare with 'cmark' (C grade threshold)
    BGE c_grade      // Branch to c_grade if R5 >= R8

    // If none of the conditions were met, print "Sorry, you got an F."
    LDR R1, =fmessage
    LDR R2, =flen
    MOV R7, #4      // Set the syscall number for 'write'
    SWI #0          // Invoke sycall to print the message
    B end           // Branch to the end of the program

a_grade:
    // Print "Congratulations! You got an A."
    LDR R1, =amessage
    LDR R2, =alen
    MOV R7, #4      // Set the syscall number for 'write'
    SWI #0          // Invoke sycall to print the message
    B end           // Branch to the end of the program     

b_grade:
    // Print "Good job! You got a B."
    LDR R1, =bmessage
    LDR R2, =blen
    MOV R7, #4      // Set the syscall number for 'write'
    SWI #0          // Invoke sycall to print the message
    B end           // Branch to the end of the program

c_grade:
    // Print "Not bad, you got a C."
    LDR R1, =cmessage
    LDR R2, =clen
    MOV R7, #4      // Set the syscall number for 'write'
    SWI #0          // Invoke sycall to print the message
    B end           // Branch to the end of the program

end:
    // End of the program
    MOV R7, #1       // Set the syscall number for 'exit'
    MOV R0, #0       // Set the exit status code
    SWI #0           // Invoke syscall to exit

.data
prompt:
    .asciz "Please enter your percentage grade: "
plen = . - prompt   // Calculate the length of the prompt message

grade:
    .byte 0           // Storage for the input percentage grade

amessage:
    .asciz "Congratulations! You got an A.\n"
alen = . - amessage // Calculate the length of the A-grade message

bmessage:
    .asciz "Good job! You got a B.\n" 
blen = . - bmessage // Calculate the length of the B-grade message

cmessage:
    .asciz "Not bad, you got a C.\n"
clen = . - cmessage // Calculate the length of the C-grade message

fmessage:
    .asciz "Sorry, you got an F.\n"
flen = . - fmessage // Calculate the length of the F-grade message
