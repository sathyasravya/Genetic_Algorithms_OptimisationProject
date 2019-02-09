from __future__ import print_function
from random import randint
import os

gen = input('')

def get_lw_value(s):
    arr = s.split(' ')
    l=float([s for s in arr if 'l=' in s][0].split('=')[1].split('n')[0])
    w=float([s for s in arr if 'w=' in s][0].split('=')[1].split('n')[0])
    return (l,w)

def get_lw_arr(data):
    ll = []
    wl = []
    for i in range(34,62):
        (l,w) = get_lw_value(data[i])
        ll.append(l)
        wl.append(w)
    return (ll,wl)

def get_lw_from_file(i):
    f = open('gen'+str(gen)+'/crossover/leakage/'+str(i)+'_leakage.sp')
    data = f.readlines()
    f.close()
    return get_lw_arr(data)

def getDataL(data, l, w):
    for i in range(34,62):
        arr = data[i].split(' ')
        temp = [s for s in arr if 'l=' in s][0]
        li = arr.index(temp)
        arr[li] = 'l=' + str(l[i-34]) +'n'
        temp = [s for s in arr if 'w=' in s][0]
        wi = arr.index(temp)
        arr[wi] = 'w=' + str(w[i-34]) +'n'
        data[i] = ' '.join(arr)
    return data

def getDataD(data, l, w):
    for i in range(33,61):
        arr = data[i].split(' ')
        temp = [s for s in arr if 'l=' in s][0]
        li = arr.index(temp)
        arr[li] = 'l=' + str(l[i-33]) +'n'
        temp = [s for s in arr if 'w=' in s][0]
        wi = arr.index(temp)
        arr[wi] = 'w=' + str(w[i-33]) +'n'
        data[i] = ' '.join(arr)
    return data


f=open('fa_leak_25,1.sp')
ldata=f.readlines()
f.close()

(ll,wl) = get_lw_arr(ldata)

f=open('fa_del_25,1.sp')
ddata=f.readlines()
f.close()

def random1(val):
    k = 0
    k = val + randint(-int(val/10),int(val/10))
    if k >= 45 and k <= 60:
        return k
    else:
        return 45
def random2(val):
    k = val + randint(-int(val/10),int(val/10))
    if k < 3200:
        return k
    else:
        return randint(360,1080)
def get_random_lw(ll,wl):
    length = len(ll)
    nll = [ll[i] for i in range(length)]
    nwl = [wl[i] for i in range(length)]
    if randint(0,1) == 1:
    	return (nll,nwl)
       
    for i in range(0,length):
          nll[i]=random1(ll[i])
          nwl[i]=random2(wl[i])
    return (nll,nwl)

def get_hash(a,b):
    return int((a+b)*(a+b+1)/2 + b)

hassh={}
import sys

path, dirs, files = next(os.walk('gen'+str(gen)+'/crossover/leakage/'))
num = len(files)

os.system('mkdir gen'+str(gen)+'/mutation')
os.system('mkdir gen'+str(gen)+'/mutation/delay')
os.system('mkdir gen'+str(gen)+'/mutation/leakage')
for i in range(0,num):
    a=0
    while True:
        while True:
            a=randint(0,num-1)
            if a in hassh:
                continue
            else:
                break
        (tll,twl) = get_lw_from_file(a)
    	(nll,nwl) = get_random_lw(tll,twl)
        data_new = getDataD(ddata, nll, nwl)
        data_new_l = getDataL(ldata, nll, nwl)

        if data_new and data_new_l:
            break
    #sys.stderr.write('did '+str(i)+'in gen '+str(gen)+'\n')
    thefile = open('gen'+str(gen)+'/mutation/delay/'+str(i) + '_delay.sp', 'w')
    for item in data_new:
        thefile.write("%s" % item)
    hassh[a] = True

    thefile = open('gen'+str(gen)+'/mutation/leakage/'+str(i) + '_leakage.sp', 'w')
    for item in data_new_l:
        thefile.write("%s" % item)
