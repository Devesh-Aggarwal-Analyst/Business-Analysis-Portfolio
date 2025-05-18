#!/usr/bin/env python
# coding: utf-8

# ## Python Basic Programming Exercises
Q1: What is the output of following expression
    5 + 4 * 9 % (3 + 1) / 6 - 1
# In[1]:


5 + 4 * 9 % (3 + 1) / 6 - 1

Q2: Write a program to check if a Number is Odd or Even. Take number as a input from user at runtime.
# In[5]:


num = int(input('enter a number'))
if num%2 == 0:
    print('even')
elif num%2 != 0:
    print('odd')
else:
    print('zero')
    

Q3: Write a program to display the multiplication table by taking a number as input. 
    [Hint : Use print statement inside of a loop]
# In[25]:


var1 = int(input('enter a number'))
number = 1
while number <=10:
     number += 1
     var1 = var1 * number
     print(var1)

    

Q4: Write a program which will find all numbers between 2000 and 3200 which are divisible by 7 
    but are not a multiple of 5.
 
Note: The numbers obtained should be printed in a comma-separated sequence on a single line.
# In[68]:


result = "" 

for num in range(2000, 3201):  
    if num % 7 == 0 and num % 5 != 0:  
        if result:
            result += "," 
        result += str(num)  

print(result)

Q5: Count the elements of each datatype inside the list and display in output
    [2, 3, 'Py', '10', 1, 'SQL', 5.5, True, 3, 'John', None, 7]    
# In[2]:


data = [2, 3, 'Py', '10', 1, 'SQL', 5.5, True, 3, 'John', None, 7]

int_count = 0
str_count = 0
float_count = 0
bool_count = 0
none_count = 0

for item in data:
    if isinstance(item, int):
        int_count += 1
    elif isinstance(item, str):
        str_count += 1
    elif isinstance(item, float):
        float_count += 1
    elif isinstance(item, bool):
        bool_count += 1
    elif item is None:
        none_count += 1

print("Integer count:", int_count)
print("String count:", str_count)
print("Float count:", float_count)
print("Boolean count:", bool_count)
print("None count:", none_count)

Q6: Add all values from the list with numeric datatypes 
    [2, 3, 'Py', '10', 1, 'SQL', 5.5, True, 3, 'John', None, 7] 
# In[4]:


l2 = [2, 3, 'Py', '10', 1, 'SQL', 5.5, True, 3, 'John', None, 7] 

sum_num = 0

for i in l2:
    if type(i) == int or type(i) == float:
        sum_num += i  
print(sum_num)

Q7: Concat all str datatypes with hyphen as a delimiter
    [2, 3, 'Py', '10', 1, 'SQL', 5.5, True, 3, 'John', None, 7] 
# In[62]:


data = [2, 3, 'Py', '10', 1, 'SQL', 5.5, True, 3, 'John', None, 7]

concatt = ""

for s in data:
    if isinstance(s,str):
        concatt += "-" + s

print(concatt)

Q8: Write a UDF that takes list as input and returns sum of all numbers 
    (exclude bool) and count of all str 
    [2, 3, 'Py', '10', 1, 'SQL', 5.5, True, 3, 'John', None, 7] 
    
Hint:
-----
def my_func:
    # your code
        
my_func(l1)
# output --> {'Sum': xxx, 'Count_of_Strs': xxx}
# In[42]:


def my_func(list1):
    sum1 = 0
    count_str = 0
    
    for i in range(len(list1)):
        if type(i) == int:
            sum1 += i
        elif type(i) == str:
            count_str += 1
    return {'Sum': sum1 , 'Count_of_Strs': count_str}


# In[56]:


my_func([2, 3, 'Py', '10', 1, 'SQL', 5.5, True, 3, 'John', None, 7])

Q9: Get only odd numbers from the following list and store the numbers in new list
    li = [5, 7, 22, 97, 54, 62, 77, 23, 73, 61]

    i. Use loops to get the answer
   ii. Use list comprehensions
  iii. Use lambda function with filter
# In[5]:


li = [5, 7, 22, 97, 54, 62, 77, 23, 73, 61]

odd_num = []

for num in li:
    if num%2 != 0:
        odd_num.append(num)

print(odd_num)


# In[ ]:


li = [5, 7, 22, 97, 54, 62, 77, 23, 73, 61]

odd_numb = [num for num in li if num % 2 != 0]

print(odd_numbers)


# In[11]:


li = [5, 7, 22, 97, 54, 62, 77, 23, 73, 61]

list(filter(lambda x: x%2 != 0, li))

Q10: Write a UDF to return the descriptives [sum, count, min, mean, max] for a list of n number of input 
    numbers.
# In[ ]:




Q11: Write an udf to calculate the area of different shapes

Take shape and dimensions as arguments to udf as follows : 

1. square which has side
2. rectangle which has length and width
3. circle which has radius

The shape should be a positional argument and it's dimensions are taken as kwargs

Perform proper validation for the user inputs and then calculate area.

E.g. if shape is square, ensure kwargs has "side" and if so, then you may return the area, else display appropriate error message like "Please enter 'side' for a square"
# In[23]:


def shape_area(shape, **dimension):
   
    '''This function takes in a shape and takes in their
        parameters.

        circile: expects radius.
        square: expects side
        rectangle: expects lenght and breath'''
    
    
    if shape == 'square':
        return dimension['side']**2
    elif shape == 'rectangle':
        return dimension['lenght'] * dimension['breath']

    elif shape == 'circle':
        return 22/7 * dimension['radius']**2


# In[25]:


shape_area('circle', radius = 2)


# In[27]:


shape_area('rectangle' , lenght = 4 , breath = 5)

Q12: Write a UDF to reconcile the values within two lists.
    l1 = ['January', 'February', 'March', 'May', 'June', 'September', 'December']
    l2 = ['January', 'February', 'April', 'June', 'October', 'December']

Hint:
-----
def func(l1, l2):
    your code here...
    
Output:
{'Matched': ['January', 'February', 'June', 'December'],
    'Only in l1': ['March', 'May', 'September'],
        'Only in l2': ['April', 'October']}
# In[ ]:


l1 = ['January', 'February', 'March', 'May', 'June', 'September', 'December']
l2 = ['January', 'February', 'April', 'June', 'October', 'December']

def func1(l1,l2):
    

Q13: write a UDF to check if a number is prime or not.
# In[3]:


def is_prime(num):
    for n in range(2,num):
        if num%n == 0:
            return 'not prime'

        else:
            return 'is prime'
        


# In[9]:


is_prime(8)

Q14. Write a program which can compute the factorial of a given numbers. 
#   The results should be printed in a comma-separated sequence on a single line. 
# input() function can be used for getting user(console) input


#Suppose the input is supplied to the program:  8  
#Then, the output should be:  40320 
#Hints: In case of input data being supplied to the question, it should be assumed to be a console input. 

# In[77]:


num = int(input('enter number'))
factorial = 1
result = []
while num > 1:
    factorial *= num
    num -= 1
    result.append(str(factorial))   
print(",".join(result))

Q15. With a given integral number n, write a program to generate a dictionary that contains (i, i*i) such that is an integral number between 1 and n (both included). and then the program should print the dictionary.

#Suppose the following input is supplied to the program: 8
#Then, the output should be: {1: 1, 2: 4, 3: 9, 4: 16, 5: 25, 6: 36, 7: 49, 8: 64}
#Hints: In case of input data being supplied to the question, it should be assumed to be a console input. Consider using dict()

# In[46]:


cubes = {}
n = int(input('enter numer'))
d = 1
while d <= n :
    cubes[d] = d ** 2
    d += 1
print(cubes)

Q16. Write a program which accepts a sequence of comma-separated numbers from console and generate a list and a tuple which contains every number.
#Suppose the following input is supplied to the program: 34,67,55,33,12,98
    #Then, the output should be: ['34', '67', '55', '33', '12', '98'] ('34', '67', '55', '33', '12', '98')

#Hints: In case of input data being supplied to the question, it should be assumed to be a console input. you may use tuple() method to convert list to tuple

# In[1]:


values = input("Enter comma-separated numbers: ")  
values_list = values.split(",")  
values_tuple = tuple(values_list)  
print(values_list, values_tuple)  

Q17. Write a program that accepts a comma separated sequence of words as input and 
# prints the words in a comma-separated sequence after sorting them alphabetically.

# Suppose the following input is supplied to the program: without,hello,bag,world
# Then, the output should be: bag,hello,without,world

#Hints: In case of input data being supplied to the question, it should be assumed to be a console input.

# In[29]:


words = input("Enter comma-separated words: ").split(",")  
words = [word.strip() for word in words]   
words.sort()  
print(",".join(words))  

Q18. Write a program that accepts a sequence of whitespace separated words 
# as input and prints the words after removing all duplicate words and sorting them alphanumerically.
# Suppose the following input is supplied to the program: hello world and practice makes perfect and hello world again
# Then, the output should be: again and hello makes perfect practice world

#Hints: In case of input data being supplied to the question, it should be assumed to be a console input.
#We use set container to remove duplicated data automatically and then use sorted() to sort the data.

# In[36]:


words = input('enter words with space:').split(" ")
final_words = []

for word in words:
    if word not in final_words:
        final_words.append(word)
        final_words.sort()

print(" ".join(final_words))

Q19. Write a program that accepts a sentence and calculate the number of upper case 
# letters and lower case letters.
#Suppose the following input is supplied to the program: Hello world!
#Then, the output should be: UPPER CASE 1 LOWER CASE 9

#Hints: In case of input data being supplied to the question, it should be assumed to be a console input.

# In[58]:


sentence = input("Enter a sentence: ")  
upper_count = 0  
lower_count = 0  

for char in sentence:  
    if char.isupper():  
        upper_count += 1  
    elif char.islower():  
        lower_count += 1  

print("UPPER CASE", upper_count)  
print("LOWER CASE", lower_count)  

Q20. Write a program that takes a string and returns reversed string. i.e. if input is "abcd123" output should be "321dcba"
# In[74]:


str1 = input()
str2 = str1[::-1]
print(str2)

