import random
fileNames  = []
histLetters = []
correctLetters=[]
trials = 10
def readRandom():
    with open(r"C:\Users\Abdo\Desktop\iti_AI\sessions\first month\fourth week\python4\words.txt", 'r') as f:
        for i in f:
            fileNames.append(i.strip().lower())

        randName = random.choices(fileNames)
        correctLetters.extend(["_" for i in randName[0]])
        print("this is the random word" , randName[0])
    return randName[0]

#get new character
def enterNew(histLetters):
    while True:
        entry = input("enter new character :")
        #check for enter
        if (len(entry)!=0):
            #check if letter is not in history letters
            if (not(entry[0] in histLetters) ):
                global trials
                trials -= 1
                histLetters.append(entry[0])
                return entry[0]
            else:
                print("character was entered before")
        else:
            print("empty character")

# check if character is in the random word and append it to correct letters
def foundChar(letter,randomWord):
    founded = lambda l , r: True if l in r else False
    if founded(letter,randomWord):
        #put the letter in its corresponding places
        for i in range(len(randomWord)):
            if randomWord[i] == letter:
                correctLetters[i] = letter
    else:
        print("character is wrong")


    return founded(letter ,randomWord )

def correctLetter(correctLetters):
    print(correctLetters)

def compare(randName1):
    for i in range(len(correctLetters)):
        if not(correctLetters[i] == randName1[i]):
            return False
    print("you guess it right")
    return True

randName1 = readRandom()
while (trials > 0 and not(compare(randName1)) ):
    print("you have",trials,"trials")
    newLetter = enterNew(histLetters)
    foundChar(newLetter,randName1)
    print(correctLetters)

if(trials==0 and not(compare(randName1)) ):print("you guess it wrong")

