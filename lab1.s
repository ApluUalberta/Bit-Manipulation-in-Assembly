# The following format is required for all submissions in CMPUT 229
	
#---------------------------------------------------------------
# Assignment:           1
# Due Date:             January 25, 2019
# Name:                 Allen Lu
# Unix ID:              Aplu
# Lecture Section:      B2
# Instructor:           Karim Ali
# Lab Section:          H10 (Thursday 1700 - 1930)
# Teaching Assistant:   Ahmed Elbashir
#---------------------------------------------------------------
#---------------------------------------------------------------
# The main program loads a hexadecimal number expression onto $t0
# and then uses the AND command to store the desired bytes into $t2.
# The given byte is shifted to its desired location, and then added
# to the $t6 register (Or mask) by using OR command AFTER shifting the AND mask.
# This process is repeated until $t6 has the final Endian-reversed expression.
#
# Register Usage:
#
#       $t0: Contains the AND mask which updates by shifting
#       $v0: Contains the input of the user
#       $t2: Contains the NN or lsb value to be stored in 0xXX000000 position
#       $t3: Contains the byte value to be stored in the 0x00XX0000 position
#       $t4: Contains the byte value to be stored in the 0x0000XX00 position
#       $t5: Contains the byte value to be stored in the 0x000000XX position
#       $t6: Contains the final converted number
#       $a0: Contains the $t6 number to be printed out
#---------------------------------------------------------------
#CMPUT 229 Student Submission License (Version 1.1)
#
#Copyright 2018 student name
#
#Unauthorized redistribution is forbidden in all circumstances. Use of this software without explicit authorization from the author or CMPUT 229 Teaching Staff is prohibited.
#
#This software was produced as a solution for an assignment in the course CMPUT 229 (Computer Organization and Architecture I) at the University of Alberta, Canada. This solution is #confidential and remains confidential after it is submitted for grading. The course staff has the right to run plagiarism-detection tools on any code developed under this license, even #beyond the duration of the course.
#
#Copying any part of this solution without including this copyright notice is illegal.
#
#If any portion of this software is included in a solution submitted for grading at an educational institution, the submitter will be subject to the sanctions for plagiarism at that #institution.
#
#This software cannot be publicly posted under any circumstances, whether by the original student or by a third party. If this software is found in any public website or public #repository, the person finding it is kindly requested to immediately report, including the URL or other repository locating information, to the following email address: #cmput229@ualberta.ca.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF #MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, #EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED #AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED #OF THE POSSIBILITY OF SUCH DAMAGE.
    
    
    .data
    .text

main:
	# Print the prompt

	# Read in N
	li $v0, 5
	syscall

    li $t0, 0xFF000000 #AND mask
    li $t6, 0x00000000 #Or mask

    and $t2, $t0, $v0 #and AND mask and input, and copying to $t2
    srl $t2, $t2, 24 # move $t2 by 24 bits left
    srl $t0, $t0, 8 # 0x00FF0000
    or $t6, $t6, $t2 #0xNN000000

    and $t3, $t0, $v0 #Extract second 8 bits.
    srl $t3, $t3, 8 #shift t3 by  bits
    srl $t0, $t0, 8 # 0x0000FF00
    or $t6, $t6, $t3 #0xNNMM0000

    and $t4, $t0, $v0 #Extract third 8 bits
    sll $t4, $t4, 8 #shift t4 by 8 bits
    srl $t0, $t0, 8 # 0x000000FF
    or $t6, $t6, $t4 #0xNNMMOO00

    and $t5, $t0, $v0 # Extract last 8 bits
    sll $t5, $t5, 24 # shift t5 by 24 bits
    srl $t0, $t0, 8 # 0x00000000
    or $t6, $t6, $t5 # 0xNNMMOOPP

    #print
    add $a0, $t6, $zero
    li $v0, 1
    syscall
    
    jr $ra
    
    
