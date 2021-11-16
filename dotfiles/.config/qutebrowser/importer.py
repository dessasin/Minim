from BeautifulSoup import BeautifulSoup
import gdbm
import pickle
import time

def main():
    f = open('bookmarks.html','r')
    soup = BeautifulSoup(f.read())
    f.close()
    
    dt=[]
    for d in soup.findAll('dt'):
        dt.append(d)
    f = gdbm.open('bookmark','c')    
    for i in range(len(dt)):
        if dt[i].contents[0].has_key('href') and dt[i].contents[0].has_key('add_date'):
            uri =  dt[i].contents[0]['href']
            title = dt[i].contents[0].contents[0]
            add_date = time.ctime(int(dt[i].contents[0]['add_date']))
            last_modified = time.ctime(int(dt[i].contents[0]['last_modified']))
            f[uri] = pickle.dumps((str(title), add_date, last_modified))
    f.close()        
if __name__ == '__main__':
    main()