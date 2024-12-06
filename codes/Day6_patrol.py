import re
import copy
#Turn rules

R_turndict={
    "^": ">",
    ">": "V",
    "V": "<",
    "<": "^"
}

next_pred={
    "^": [-1,0],
    ">": [0,1],
    "V": [1,0],
    "<": [0,-1]
}

class Player():
    def __init__(self, pos, face):
        super(Player, self).__init__()
        self.pos = pos
        self.face = face
        self.path =[]
        self.rpath =[]
        self.rpath.append(str(self.pos)+str(self.face))
    def move(self, target_del):
        self.pathUpdate(target_del)
        self.pathUpdate2(target_del)
        self.pos = target_del
    def turnClockwise(self):
        self.face =R_turndict[self.face]
    def pathUpdate2(self,target):
        self.rpath.append(str(target)+str(self.face))
    def pathUpdate(self,target):
        self.path.append(str(target))
    def showpos(self):
        return self.pos
    def showdir(self):
        return self.face
    def getPlayerPath(self):
        return self.path
    def loopCheck(self):
        if self.rpath[-1] in self.rpath[0:-1]:
            return True
        else:
            return False


#Quasi collision detection
def fwdDetect(Player,map):
    playerpos = Player.showpos()
    playerface = Player.showdir()
    nextmove = [x + y for x, y in zip(playerpos, next_pred[playerface])]
    #print("###"+str(playerpos)+"|"+str(nextmove))
    try:
        if nextmove[0] >= 0 and nextmove[1] >= 0:
            if map[nextmove[0]][nextmove[1]] == "." or map[nextmove[0]][nextmove[1]] == "^":
                return nextmove
            elif map[nextmove[0]][nextmove[1]] == "#":
                return [0,0]
            else:
                return None
        else:
           return 0 
    except:
        #print("Gaurd is gone!")
        return 0
    

##game flow##
def map_mutate(map, r, c):
    newmap=copy.copy(map)
    newr=list(newmap[r])
    newr[c]="#"
    newmap[r]="".join(newr)
    return newmap

def run_game_mod(map):
    M = len(map)
    N = len(map[0])
    game_rst_count = 0
    for m in range(len(map)):
        for n in range(len(map[m])):
            if str([m,n]) not in gameoripath:
                #print(str([m,n])+" not in")
                continue
            if map[m][n] == "#" or map[m][n] == "^":
                continue
            if map[m][n] == ".":
                new_map=map_mutate(map,m,n)
            game_rst_status = run_game(new_map)[0]
            print(m,n,game_rst_status)
            game_rst_count = game_rst_count + game_rst_status
    return game_rst_count


def run_game(map):
    NewPlayer = Player([PlayerStartPosR,PlayerStartPosC],PlayerStartFace)
    game_on = True
    while(game_on):
        nextstatus = fwdDetect(NewPlayer,map)
        #print(NewPlayer.showpos(),NewPlayer.showdir())
        if isinstance(nextstatus, list):
            if nextstatus == [0,0]:
                NewPlayer.turnClockwise()
            else:
                NewPlayer.move(nextstatus)
            if NewPlayer.loopCheck():
                game_on = False
                print ("Loop Found!")
                return 1,NewPlayer.getPlayerPath()
        else:
            print("###"+str(nextstatus))
            game_on = False
    
    #Part One
    # End of game Calculation
    playerFinPath=NewPlayer.getPlayerPath()
    PFP=set(playerFinPath)
    print("Entries covered: ",len(PFP))
    return 0,playerFinPath

###Initialize###

PlayerSymbol=re.compile("[<>V^]")
PlayerStartPosR = 0
PlayerStartPosC = 0
PlayerStartFace = "V"
input_mat = []
rc=0
PlayerPath=dict()
with open('input.txt') as f:
   for line in f:
       input_mat.append(line.rstrip())
       for m in PlayerSymbol.finditer(line.rstrip()):
            PlayerStartPosR = rc
            PlayerStartPosC =m.start()
            PlayerStartFace=m.group()
       rc += 1


gameoripath=run_game(input_mat)[1]

pt2_count = run_game_mod(input_mat)
print(pt2_count)

exit
