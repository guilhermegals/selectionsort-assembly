#=======BublleSort C# ======================================================

#int vetor[10];
#int main(){
#	for (int i = 0; i < 10; i++){
#		vetor[i] = int.Parse(Console.ReadLine());
#   }
#	int aux;
#   for (int i = 0; i < 10; i++){
#       for (int j = i + 1; j < 10; j++){
#			if(vetor[i] > vetor[j]){
#				aux = vetor[i];
#				vetor[i] = vetor[j];
#				vetor[j] = aux;
#           }
#       }
#   }
#   for (int i = 0; i < 10; i++){
#       Console.Write(vetor[i] + "| ");
#   }
#}

#===========================================================================

	.data
programa:		.asciiz "\n-------- Ordenador de Numeros --------\n\n"
ordenado:		.asciiz "\n-------- Numeros Ordenados --------\n"
mensagem:		.asciiz "Informe um numero inteiro: \n"	
blank:			.asciiz " "	
vetor: 			.word 10	        	
	.text                     
main: 
#Imprimi a mensagem de Inicializacao na tela -------------------------------
	li		$v0, 4					
	la		$a0, programa		#Imprimi "Ordenador de Numeros" na tela
	syscall					#Chamada do Sistema 
#---------------------------------------------------------------------------
	
#Loop para ler os valores digitados e salvar no vetor ----------------------
	addi		$t0, $0, 0		#i = 0
	addi		$t3, $0, 4		#t3 = 4
forler:						
	slti		$t2, $t0, 10		#? (i < 4)
	beq		$t2, $0, fimforler	#Se for falso pula para fimforler
	
	li 		$v0, 4					
	la		$a0, mensagem		#Imprimi "Informe um numero inteiro:" na tela
	syscall					#Chamada do Sistema 
	
	li 		$v0, 5			#Leitura
	syscall					#Chamada do Sistema
	mul		$t1, $t0, $t3		#Indice I
	sw		$v0, vetor($t1)		#Salva o valor no vetor
	addi		$t0, $t0, 1		#i++
	j		forler
fimforler:
#---------------------------------------------------------------------------

#Ordena o vetor ------------------------------------------------------------
	addi 		$t0, $0, 0		#i = 0
	addi		$t7, $0, 4		#t7 = 4
for1:
	slti		$t1, $t0, 10		#? (i menor 10)
	beq		$t1, $0, fimfor1	#Se for falso, pula para fimfor1
	addi		$t2, $t0, 1 		#j = i + 1
for2:
	slti		$t3, $t2, 10		#? (j menor 10)
	beq		$t3, $0, fimfor2	#Se for falso, pula para fimfor2
	mul 		$t4, $t7, $t0		#Indice I
	mul		$t5, $t7, $t2		#Indice J
	lw		$s1, vetor($t4)		#vetor[i]
	lw		$s2, vetor($t5)		#vetor[j]
if1:
	sgt		$t6, $s1, $s2		#? (vetor[i] maior vetor[j])
	beq		$t6, $0, fimif1
	add		$t6, $s1, $0		#aux = vetor[i]
	add		$s1, $s2, $0		#vetor[i] = vetor[j]
	add		$s2, $t6, $0		#vetor[j] = aux
	sw		$s1, vetor($t4)		#salva vetor[i] na memoria
	sw		$s2, vetor($t5)		#salva vetor[j] na memoria
fimif1:
	addi		$t2, $t2, 1		#j++
	j		for2
fimfor2:
	addi 		$t0, $t0, 1		#i++
	j 		for1
fimfor1:
#---------------------------------------------------------------------------

#Imprimi na tela a mensagem mostrando o vetor ------------------------------
	li		$v0, 4					
	la		$a0, ordenado		#Imprimi "Ordenador de Numeros" na tela
	syscall					#Chamada do Sistema 
	
	addi 		$t0, $0, 0		#i = 0
	addi 		$t3, $0, 4		#t3 = 4
forimprimir:
	slti 		$t1, $t0, 10		#? (i < 10)
	beq		$t1, $0, fimforimprimir
	mul		$t2, $t0, $t3		#Indice I
	
	lw		$a0, vetor($t2)		#vetor[i]
	li		$v0, 1	
	syscall
	
	li 		$v0, 4					
	la		$a0, blank		#Imprimi " " na tela
	syscall					#Chamada do Sistema 
	
	addi 		$t0, $t0, 1		#i++
	j		forimprimir
fimforimprimir:
#---------------------------------------------------------------------------
	jr		$ra	
