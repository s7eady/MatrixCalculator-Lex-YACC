%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<math.h>
	void yyerror(const char *);
	int* var[26] = {NULL}; // Initializing the array of pointer variables to NULL
	int row[26] = {0}, col[26] = {0}; // Initializing the array of row and column variable with 0

	int determinant(int matrix[10][10], int n);
	int* adjacent(int matrix[10][10], int n);
%}

%token VARIABLE INTEGER MATRIX SET SHOW DET TRANSPOSE INVERSE HELP

%%
program:
	program stmt '\n'
	| stmt
	;
stmt:
	generate_matrix
	| matrix_operation
	| option
	|
	;
generate_matrix:	
	MATRIX VARIABLE INTEGER INTEGER		{
						row[$2] = $3;
						col[$2] = $4;
						printf("Matrix %c [%d x %d] has been declared\n", $2 + 'a', $3, $4);
						printf("----- Matrix Declaration -----\n\n");
						}

	| SET VARIABLE				{
						if (row[$2] == 0 && col[$2] == 0) {
							printf("No Matrix has been declared in this variable\n"); }
						else {
							if (var[$2] != NULL) {
								int *ptr = var[$2];
								free(ptr);
								}
							
							int iteration = 0, total, r = row[$2], c = col[$2];
							int *ptr = (int*)malloc(r * c * sizeof(int));
							var[$2] = ptr;
							printf("Matrix Size = [%d x %d]\n", r, c);
							printf("Input all the integers in a row-major order:\n");
							total = r * c;
							while (iteration != total) {
								scanf("%d", &ptr[iteration]);
								printf("Matrix[%d][%d] = %d\n", iteration / c, iteration % c, ptr[iteration]);
								iteration++;
								}
							fflush(stdin);
							printf("Matrix has been successfully initialized\n");
							}
							printf("----- Matrix Initialization -----\n\n");
						}
	;

matrix_operation:
	SHOW VARIABLE		{
				if (row[$2] == 0 || col[$2] == 0) {
					printf("Invalid Operation. The Matrix has not been declared.\n"); }
				else if (var[$2] == NULL) {
					printf("Invalid Operation. The Matrix has not been initialized.\n"); }
				else {
					int i, j;
					int *ptr = var[$2];
					printf("Matrix %c:\n", $2 + 'a');
					for (i = 0; i < row[$2]; i++) {
						for (j = 0; j < col[$2]; j++) {
							printf("%d\t", ptr[i * col[$2] + j]); 
							}
						printf("\n"); 
						}
					}
				printf("----- Display Matrix -----\n\n");
				}
					
	| VARIABLE '+' VARIABLE	{
				if (row[$1] == 0 || row[$3] == 0 || col[$1] == 0 || col[$3] == 0) {
					printf("Invalid Operation. One of the Matrix has not been declared.\n"); }
				else if (var[$1] == NULL || var[$3] == NULL) {
					printf("Invalid Operation. One of the Matrix has not been initialized.\n"); }
				else if (row[$1] != row[$3] || col[$1] != col[$3]) {
					printf("Invalid Operation. Both Matrix does not have the 'exact' same dimension.\n"); }
				else {
					int i, j;
					int r = row[$1], c = col[$1];
					int *ptr1 = var[$1];
					int *ptr2 = var[$3];
					printf("Result of Addition Operation:\n");
					for (i = 0; i < r; i++) {
						for (j = 0; j < c; j++) {
							printf("%d\t", ptr1[i * c + j] + ptr2[i * c + j]); 
							}
						printf("\n"); 
						}
					}
				printf("----- Addition Operation -----\n\n");
				}

	| VARIABLE '-' VARIABLE	{
				if (row[$1] == 0 || row[$3] == 0 || col[$1] == 0 || col[$3] == 0) {
					printf("Invalid Operation. One of the Matrix has not been declared.\n"); }
				else if (var[$1] == NULL || var[$3] == NULL) {
					printf("Invalid Operation. One of the Matrix has not been initialized.\n"); }
				else if (row[$1] != row[$3] || col[$1] != col[$3]) {
					printf("Invalid Operation. Both Matrix does not have the 'exact' same dimension.\n"); }
				else {
					int i, j;
					int r = row[$1], c = col[$1];
					int *ptr1 = var[$1];
					int *ptr2 = var[$3];
					printf("Result of Subtraction Operation:\n");
					for (i = 0; i < r; i++) {
						for (j = 0; j < c; j++) {
							printf("%d\t", ptr1[i * c + j] - ptr2[i * c + j]); 
							}
						printf("\n"); 
						}
					}
				printf("----- Subtraction Operation -----\n\n"); 
				}

	| VARIABLE '*' VARIABLE {
				if (row[$1] == 0 || row[$3] == 0 || col[$1] == 0 || col[$3] == 0) {
					printf("Invalid Operation. One of the Matrix has not been declared.\n"); }
				else if (var[$1] == NULL || var[$3] == NULL) {
					printf("Invalid Operation. One of the Matrix has not been initialized.\n"); }
				else if (col[$1] != row[$3]) {
					printf("Invalid Operation. Row Matrix %c and Column Matrix %c is not equal.\n", $1 + 'a', $3 + 'a'); }
				else {
					int i, j, k;
					int size = col[$1];
					int *ptr1 = var[$1];
					int *ptr2 = var[$3];
					for (i = 0; i < row[$1]; i++) {
						for (j = 0; j < col[$3]; j++) {
							int sum = 0;
							for (k = 0; k < size; k++) {
								sum += ptr1[i * size + k] * ptr2[k * col[$3] + j];
								}
							printf("%d\t", sum); 
							}
						printf("\n");
						}
					}
				printf("----- Multiplication Operation -----\n\n");
				}

	| DET VARIABLE		{
				if (row[$2] == 0 || col[$2] == 0) {
					printf("Invalid Operation. The Matrix has not been declared.\n"); }
				else if (var[$2] == NULL) {
					printf("Invalid Operation. The Matrix has not been initialized.\n"); }
				else if (row[$2] != col[$2]) {
					printf("Invalid Operation. The Matrix is not a square matrix.\n"); }
				else {
					int i, j;
					int *ptr = var[$2];
					int size = row[$2];
					int matrix[10][10];
					for (i = 0; i < size; i++) {
						for (j = 0; j < size; j++) {
							matrix[i][j] =  ptr[i * size + j];
							}
						}
					int det = determinant(matrix, size);
					printf("Determinant of the Matrix: %d\n", det);
					}
				printf("----- Determinant Matrix -----\n\n");
				}
	
	| TRANSPOSE VARIABLE	{
				if (row[$2] == 0 || col[$2] == 0) {
					printf("Invalid Operation. The Matrix has not been declared.\n"); }
				else if (var[$2] == NULL) {
					printf("Invalid Operation. The Matrix has not been initialized.\n"); }
				else {
					int i, j;
					int r = col[$2], c = row[$2];
					int* ptr = var[$2];
					for (i = 0; i < r; i++) {
						for (j = 0; j < c; j++) {
							printf("%d\t", ptr[j * r + i]);
							}
						printf("\n");
						}
					}
				printf("----- Transpose Matrix -----\n\n");
				}
	
	| INVERSE VARIABLE	{
				if (row[$2] == 0 || col[$2] == 0) {
					printf("Invalid Operation. The Matrix has not been declared.\n"); }
				else if (var[$2] == NULL) {
					printf("Invalid Operation. The Matrix has not been initialized.\n"); }
				else if (row[$2] != col[$2]) {
					printf("Invalid Operation. The Matrix is not a square matrix.\n"); }
				else {
					int i, j, k, l;
					int *ptr = var[$2];
					int size = row[$2];
					int matrix[10][10];
					for (i = 0; i < size; i++) {
						for (j = 0; j < size; j++) {
							matrix[i][j] =  ptr[i * size + j];
							}
						}
					int det = determinant(matrix, size);
					
					if (det == 0) {
						printf("Determinant of the Matrix: 0. The Matrix has no inverse.\n");
						}
					else {
						int Tmatrix[10][10];
						for (i = 0; i < size; i++) {
							for (j = 0; j < size; j++) {
								Tmatrix[i][j] = ptr[j * size + i];
								}
							}
						int *ptr1 = adjacent(Tmatrix, size);
						for (k = 0; k < size; k++ ) {
							for (l = 0; l < size; l++) {
								float inv = (float)*(ptr1+(k * size + l))/ det;
								printf("%.2f\t", inv);
								}
							printf("\n");
							}
						}
					}
				printf("----- Inverse Matrix -----\n\n");
				}
	;

option:
	HELP		{ 
			printf("Matrix Declaration: matrix [a-z] integer integer\n");
			printf("Matrix Initialization: set [a-z]\n");
			printf("Display Matrix: show [a-z]\n");
			printf("Addition Operation: [a-z] + [a-z]\n");
			printf("Subtraction Operation: [a-z] - [a-z]\n");
			printf("Multiplication Operation: [a-z] * [a-z]\n");
			printf("Determinant Matrix: det [a-z]\n");
			printf("Transpose Matrix: transpose [a-z]\n");
			printf("Inverse Matrix: inverse [a-z]\n");
			printf("----- Help Option -----\n\n");
			}
	;

%%
void yyerror(const char *s) {
	fprintf(stderr, "%s\n", s);
}

int main() {
	yyparse();
	return 0;
}

int determinant(int matrix[10][10], int n) {
	if (n == 1) {
		return matrix[0][0]; }
	else if (n == 2) {
		return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0]; }
	else {
		int i, j, k;
		int det = 0;
		int sign = 1;
		int submatrix[10][10];

		for (k = 0; k < n; k++) {
			int subi = 0;
			for (i = 1; i < n; i++) {
				int subj = 0;
				for (j = 0; j < n; j++) {
					if (j == k) { 
						continue; 
						}	
					submatrix[subi][subj] = matrix[i][j];
					subj++;
					}
				subi++;
				}
			det = det + sign * matrix[0][k] * determinant(submatrix, n - 1);
			sign = -sign;
			}
		return det;
		}
	}

int* adjacent(int matrix[10][10], int n) {
	int i, j, k, l;
	int *adjmatrix = (int*)malloc(n * n * sizeof(int));
	for (k = 0; k < n; k++) {
		for (l = 0; l < n; l++) {
			int submatrix[10][10];
			int subi = 0;
			for (i = 0; i < n; i++) {
				int subj = 0;
				if (i == k) {
					continue;
					}
				else {
					for (j = 0; j < n; j++) {
						if (j == l) {
							continue;
							}
						else {
							submatrix[subi][subj] = matrix[i][j];
							subj++;
							}
						}
					subi++;
					}
				}
			adjmatrix[k * n + l] = determinant(submatrix, n - 1 ) * pow(-1, (k + l));
			}
		}
	return adjmatrix;
	}