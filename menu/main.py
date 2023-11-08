import os
import pickle
flag = 0
k=0
id_list=[]
name_list=[]
sal_list=[]
dep_list =[]
returnedIdx=[]
dict = {}
def printData(idx):
    print(f"ID:{id_list[idx]} ,name:{name_list[idx]}  ,salary:{sal_list[idx]}  ,department:{dep_list[idx]}")

def addNew(eValues):
    evaluesList = eValues.split(",")
    if len(evaluesList) == 3:
        for i in range(len(evaluesList)):
            evaluesList[i] = evaluesList[i].strip()
            if i == 0:
                if evaluesList[0] != "":
                    name_list.append(evaluesList[0])
                else:
                    name_list.append("")

            elif i == 1:
                str1= evaluesList[1].strip()
                if str1.isnumeric() or (len(str1)>0 and str1[-1] =="0"):
                    sal_list.append(float(str1))
                else:
                    sal_list.append(0.0)

            elif i == 2:
                if evaluesList[2] != "":
                    dep_list.append(evaluesList[2])
                else:
                    dep_list.append(evaluesList[2])
        global k
        id_list.append(k)
        print(f"ID:{k} ,name:{evaluesList[0]}  ,salary:{sal_list[-1]}  ,department:{evaluesList[2]}")
        k = k + 1

    else:
        print("invalid")

def search(firstName):

    firstname3 = firstName.strip().lower()
    returnedIdx = []
    for idx, name in enumerate(name_list):
        if name.lower().startswith(firstname3) and len(firstname3) > 0:
            printData(idx)
            returnedIdx.append(idx)
    return returnedIdx

def delete(returnedIdx):
    i=0
    n = 0
    while (i < len(returnedIdx)):
        id_list.pop(returnedIdx[i]-n)
        name_list.pop(returnedIdx[i]-n)
        sal_list.pop(returnedIdx[i]-n)
        dep_list.pop(returnedIdx[i]-n)
        n = n+1
        i = i+1




while flag != 1:

    print("welcome to new employee database")
    while True:
        #k = max(id_list)+1
        #input()
        os.system("cls")
        print("0 - import csv or pickle")
        print("1 - new")
        print("2 - search")
        print("3 - delete")
        print("4 - showall")
        print("5 - export")
        print("6 - export department")
        print("7 - export pickle")
        print("8 - Quit")
        process = input("choose process")
        match process:
            case "0":
                m = 0
                print("1 -csv")
                print("2 -pickle")
                method = input("choose method:")
                if method == "1":
                    if os.path.exists(r"C:\Users\Abdo\Desktop\iti_AI\sessions\first month\fourth week\python3\emps_in.csv"):
                        with open(r"C:\Users\Abdo\Desktop\iti_AI\sessions\first month\fourth week\python3\emps_in.csv")as f:
                            for l in f:
                                if m!=0: # not to get first element
                                    addNew(l)
                                m = m+1
                    else:
                        print("File not found")

                elif method=="2":
                    if os.path.exists(r"C:\Users\Abdo\Desktop\iti_AI\sessions\first month\fourth week\python3\new.pkl"):
                        with open(r"C:\Users\Abdo\Desktop\iti_AI\sessions\first month\fourth week\python3\new.pkl" , 'rb')as f:
                            pic = pickle.load(f)
                            for l in pic:
                                addNew(l)
                    else:
                        print("File not found")

                else:
                    print("out of range")
            #new
            case "1":
                eValues = input("please enter name ,salary ,department : ")
                addNew(eValues)
            #search
            case "2":
                firstName = input("search by first name")
                search(firstName)
            #delete
            case "3":
                firstName = input("search by first name")
                delete(search(firstName))
            #show all
            case "4":
                for id , name ,salary , dep in zip(id_list,name_list,sal_list,dep_list):
                    print(f"ID:{id} ,name:{name}  ,salary:{salary}  ,department:{dep}")
            # export
            case "5":
                with open(r"C:\Users\Abdo\Desktop\iti_AI\sessions\first month\fourth week\python3\emp.txt",'w') as f:
                    for id, name, salary, dep in zip(id_list, name_list, sal_list, dep_list):
                        f.write(f"ID:{id} ,name:{name}  ,salary:{salary}  ,department:{dep} \n")
            #export department
            case "6":
                list2 = []

                #for dep in dep_list:
                    #dict[dep] = [[id,name,salary]for id, name, salary , dep1 in zip(id_list, name_list, sal_list, dep_list) if dep1==dep ]

                for dep in dep_list:
                    # for id, name, salary, dep1 in zip(id_list, name_list, sal_list, dep_list):
                    #     if dep1 == dep:
                    #         list2.append([name,salary,dep1])
                    [list2.append([name, salary, dep1]) for id, name, salary, dep1 in zip(id_list, name_list, sal_list, dep_list) if dep1 == dep]

                    dict[dep] = list2
                    list2=[]
                with open(r"C:\Users\Abdo\Desktop\iti_AI\sessions\first month\fourth week\python3\dep.txt", 'w') as f:
                    for dep , value in dict.items():
                        f.write(f"department:{dep} \n")
                        for depval in dict[dep]:
                            f.write(f"ID:{depval[0]} ,name:{depval[1]}  ,salary:{depval[2]}  \n")
            #export pickle
            case "7":
                list = []

                for id , name ,salary , dep in zip(id_list,name_list,sal_list,dep_list):
                    str_to_write=f"{name},{salary},{dep}"
                    list.append(str_to_write)
                with open(r"C:\Users\Abdo\Desktop\iti_AI\sessions\first month\fourth week\python3\new.pkl", 'wb') as f:
                    pickle.dump( list, f)

            case "8":
                flag = 1
                break
