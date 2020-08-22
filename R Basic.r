# Statistical Programming
# R Calculator
5*(-3.2) 
5^2 
sin(2*pi/3)
sqrt(4) 
log(1) 
x = 8
y = 4
x + y               # Addition
x - y               # Subtraction
x * y               # Multiplication
x/y                 # Division        
x^y                 # Rank/Power 
sqrt(x*y)           # Square root
log(x)              # logarithm 
exp(y)              # exponential
c(1,2,3,4,5) 
c(1,2,3,4,5)*2 

a = 8 ; b = 2
h=a%%b #modulus operator : reaminder / sisaan
h
i=a%/%b #integer/bilangan bulat division operator
i
6%/%2
5%/%2
7%/%2
5%%2

# Variable Asignment
total <- x+y
total

sp <- c(1,2,3,4,5) # Variable Asignment
sp

# Tipe Data
# Vectors, Lists, Matrices, Arrays
# Factors, Data Frames 
# logical
v <- TRUE 
print(class(v))

x = 1; y = 2
z = x > y
z
print(class(z))

# numerik dan integer
v <- 23.5 
print(class(v))
as.integer(v)
is.integer(v)

# mengkombinasikan 2 vector
n = c(2, 3, 5) 
s = c("aa", "bb", "cc", "dd", "ee") 
c(n, s) 

# Aritmatika vector
a = c(1, 3, 5, 7) 
b = c(1, 2, 4, 8)

5*a
a + b 

u = c(10, 20, 30) 
v = c(1, 2, 3, 4, 5, 6, 7, 8, 9) 
u+v

# indeks pada vector
s = c("aa", "bb", "cc", "dd", "ee")
s
s[3]
s[-3]
s[10]
s[c(2, 3)]
s[c(2, 3, 3)] 
s[c(2, 1, 3)] 

#Logical Indeks Vector
L = c(FALSE, TRUE, FALSE, TRUE, FALSE) 
s[L] 
s[c(FALSE, TRUE, FALSE, TRUE, FALSE)]

# Penamaan anggota pada vector
v = c("ana", "susi")
v
names(v) = c("1", "2")
v
v["1"] 
v[c("2", "1")] 

data.frame(v)

# Matrik
A = matrix( 
c(2, 4, 3, 1, 5, 7), # data 
nrow=2,              # jumlah baris 
ncol=3,              # jumlah kolom 
byrow = TRUE)        # didasarkan pada baris 
A

# A[m, n]
A[2, 3]
A[ ,3]
A[ ,c(1,3)] 
A[c(1,2) ,c(1,2)]
A[c(1,2) ,c(1,3)]

# Penamaan baris kolom pada matrik
dimnames(A) = list( 
c("a1", "a2"),         # nama baris  
c("b1", "b2", "b3")) # nama kolom 
A

B = matrix(c(2, 4, 3, 1, 5, 7),nrow=3,ncol=2) 
B
# mengkombinasikan matrik
C = matrix(c(7, 4, 2),nrow=3, ncol=1) 
C
# tambahkan matrik B ke matrik C
D = cbind(B, C)
D
dimnames(D) = list( 
  c("a1", "a2", "a3"),         # nama baris  
  c("b1", "b2", "b3")) # nama kolom 
D

E = matrix(c(6, 2), nrow=1, ncol=2) 
E
rbind(B, E)

# list
n = c(2, 3, 5) 
s = c("aa", "bb", "cc", "dd", "ee") 
b = c(TRUE, FALSE, TRUE, FALSE, FALSE) 
x = list(n, s, b, 3)   # x terdiri dari komponen n, s, b
x

x[2]
x[c(2, 4)] 

x[[2]]  
x[[2]][1]="ag"
x[[2]]

x[[2]][3]="aga"
x[[2]]

# penamaan list
v = list(bob=c(2, 3, 5), john=c("aa", "bb")) 
v

c(c(v$bob[1]), c(v$john[1]))

c(c(v$bob[3]), c(v$john[1]))

# data frame pada R
n = c(2, 3, 5) 
s = c("aa", "bb", "cc") 
b = c(TRUE, FALSE, TRUE) 
df = data.frame(n, s, b)  
df

#relational operator
# >, >=, <, <=, ==, !=

#logical operator
# and operator
TRUE & TRUE
FALSE & TRUE
TRUE & FALSE
FALSE & FALSE

x=12
x>5 & x<15

# or operator
TRUE | TRUE
TRUE | FALSE
FALSE | TRUE
FALSE | FALSE

y=4
y<5 | y>15

#Pengulangan (Loop) dengan for
x <- c(1,2,3,4,5)
for (n in x)
{
  print(n^2)
}

#Kondisi (Condition) dengan if
x <- c(3,4,5,100,2)
for(n in x)
{
  if(n%%2==0)
  {
    cat(sprintf("%d adalah bilangan genap \n",n))
  }
  else
  {
    cat(sprintf("%d adalah bilangan ganjil \n",n))
  }
}
# cat(sprint()) digunakan untuk mencetak
# if (condition) {do TRUE}else {do FALSE}

# dengan menggunakan for tentukan faktorial dari 5

# Fungsi
nama <- function(argumen1, argumen2, ...){
  hasil <- argumen1 + argumen2
  return(hasil)
}

jumlah <- function(x,y)
{hasil <- x + y
print(hasil)
}
jumlah(5,5)

f <- function (x)
{ hasil.f <- abs(x-3.5) + (x-2)^2
print(hasil.f)
}
f(0)
f(1)
f(2)
f(3)
f(4)
f(5)
curve(f,from = 0, to = 5)

# Import Data
data <- read.csv("jatim.csv")
data

# import data
data1 <- read.delim("jatim.txt")
data1

# Data Manipulasi
# summarise() statistik deskriptif
library("dplyr")
data %>% # %>% piping
summarise(mean1=mean(x1),
          mean2=mean(x2))

data.rename <- data %>% 
rename(
    persentase_kemiskinan = y,
      Angka_Harapan_Hidup = x1
    )
data.rename

# menambahkan kolom baru mutate()
data.mutate <- data %>%
mutate(z1=1:38, z2=38:1)
names(data.mutate)

data.mutate

library("ggplot2")
library("scales") 

data.rename
