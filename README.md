# MatrixCalculator-Lex-YACC
A matrix operation calculator that is lexically analyzed using Flex and parsed using Bison.
Year 3 Semester 1 project by Lee Jean Sean, Brad Loo Siu Hang, Ma Jing Yang, Ng Chee Yang, Lai Jun Yan and Wong Zhan Song.

## This repository contains two files:
- lex.l, a Lex file that matches input strings to be parsed by the YACC file
- matrix.y, YACC file that receives string inputs and perform operations within it.

## Instructions:
Installing Lex and Yacc
First of all, to run and compile Yacc and Lex files in windows, we have to use Flex and Bison, which are compiler tools. We can compile Yacc and Lex source code to obtain a program that works. The first step to master using Flex and Bison is to of course download them.
1. Download of Flex and Bison
To download Flex and Bison files we can go to these two links:
- Flex: https://sourceforge.net/projects/gnuwin32/files/Flex/2.5.4a-1/Flex-2.5.4a-1.exe/download?use_mirror=jaist&download=
- Bison: https://sourceforge.net/projects/gnuwin32/files/bison/2.4.1/bison-2.4.1-setup.exe/download?use_mirror=jaist
 
The files will be automatically downloaded and the webpage looks like this:
![image](https://github.com/s7eady/MatrixCalculator-Lex-YACC/assets/152954536/91a4a505-63b8-4255-a85b-433c5e3ee224)

Then click and install both of the files. Do note that the installation locations must be changed to C:\GnuWin32.

2. Add path to environment variable
To actually utilize Flex and Bison in windows, we must add their paths to the environment variable. This is to specify the directories of Flex and bison commands to be used. Since both Flex and Bison are saved in GnuWin32 file, we only needed to add GnuWin32’s path. GnuWin32 will be located in the C drive. Then copy C:\GnuWin32\bin into the environment variables.
System properties -> environment variables -> path -> edit path
I already have the path added as shown in the image below.
![image](https://github.com/s7eady/MatrixCalculator-Lex-YACC/assets/152954536/6eb2ca37-72ab-492c-a9f1-76faccdf01af)

3. Check existence of Flex and Bison
Lastly we will check whether Flex, bison and gcc commands are working in the command prompt. We will enter the following commands in command prompt:
- Flex --version
- Bison --version
![image](https://github.com/s7eady/MatrixCalculator-Lex-YACC/assets/152954536/4d4e85e2-fc04-4432-b089-681ae3df5acd)

If there are any errors or nothing shows up, please re-download or check the location of the files.

4. Looking at our Lex and Yacc files
First of all let's look at our Lex and Yacc files. They are in “assignment lab report” folder. Note that Lex is the Lex file specified by L file type, matrix is the Yacc file specified by Y file.
![image](https://github.com/s7eady/MatrixCalculator-Lex-YACC/assets/152954536/ce5f8bff-7181-494f-b324-beeeea4c596b)

We can edit the files by opening them in the notepad.
 ![image](https://github.com/s7eady/MatrixCalculator-Lex-YACC/assets/152954536/85bea82a-0e5e-48fc-888d-d0913a25ad40)

5. Compilation of Lex and Yacc files
We have to compile both of the files to obtain an application to run the code. To compile, head to the location where the files are stored and type cmd in the path, a command prompt window will pop out.
![image](https://github.com/s7eady/MatrixCalculator-Lex-YACC/assets/152954536/617ef9dc-4c17-4014-a2ee-fa315557cf17)

 
Next we type in the following commands:
Flex Lex.l

This command will produce a Lex.yy file.
Bison -dy matrix.y

This command will produce a  y.tab C file and header file.
Cc Lex.yy.c y.tab.c -o application
This is to compile both Lex and Yacc files together and output an execution file named application.
![image](https://github.com/s7eady/MatrixCalculator-Lex-YACC/assets/152954536/4f8cc58e-d58f-497b-a828-24211dbe240b)

Now the files are successfully compiled and an  execution file is produced.

6. Run the application
We can now run the program by pressing on the application.
![image](https://github.com/s7eady/MatrixCalculator-Lex-YACC/assets/152954536/5c8465f4-5e1f-4146-bff3-4f70cc581d21)

