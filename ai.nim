import strutils

const TeamName: cstring = "SERS TEAM"

var CurGame: cint = 0
var CurAction: cint = 0
var Teleport: cint = 0
var bGameEnd: cint = 0
var AI_TeamID = 0

var WheelLeft: cint = 0
var WheelRight: cint = 0
var LED_1: cint = 0
var MyState: cint = 0

var SuperObj_X: cint = 0
var SuperObj_Y: cint = 0
var SuperObj_Num: cint = 0

var OtherRob_SMS: cint = 0
var OtherRob_PositionX: cint = 0
var OtherRob_PositionY: cint = 0

var ObjState: cint = 0
var ObjPositionX: cint = 0
var ObjPositionY: cint = 0
var ObjDuration: cint = 0

var MySMS: cint = 0

var US_Front: cint = 0
var US_Left: cint = 0
var US_Right: cint = 0
var CSLeft_R: cint = 0
var CSLeft_G: cint = 0
var CSLeft_B: cint = 0
var CSRight_R: cint = 0
var CSRight_G: cint = 0
var CSRight_B: cint = 0
var PositionX: cint = 0
var PositionY: cint = 0
var TM_State: cint = 0
var Compass: cint = 0
var Time: cint = 0

proc setGameID(GameID: cint): void {.exportc: "SetGameID", dynlib.} =
    CurGame = GameID
    bGameEnd = 0

proc setTeamID(TeamID: cint): void {.exportc: "SetTeamID", dynlib.} =
    AI_TeamID = TeamID

proc getGameID(): cint {.exportc: "GetGameID", dynlib.} =
    return CurGame

proc isGameEnd(): cint {.exportc: "IsGameEnd", dynlib.} =
    return bGameEnd

proc getDebugInfo*(): cstring {.exportc: "GetDebugInfo", dynlib.} =
    let infoData = @[
        "bGameEnd=$1" % [$bGameEnd],
    ]
    
    let info = infoData.join(";") & ";"
    return info

proc getTeamName(): cstring {.exportc: "GetTeamName", dynlib.} =
    return TeamName

proc getCurAction(): cint {.exportc: "GetCurAction", dynlib.} =
    return CurAction

proc getTeleport(): cint {.exportc: "GetTeleport", dynlib.} =
    ## Only Used by CsBot Rescue Platform
    return Teleport

proc setSuperObj(x: cint, y: cint, num: cint): void {.exportc: "SetSuperObj", dynlib.} =
    ## Only Used by CsBot Rescue Platform
    SuperObj_X = x
    SuperObj_Y = y
    SuperObj_Num = num

proc getSuperObj*(x: ptr cint; y: ptr cint; num: ptr cint): void {.exportc: "GetSuperObj", dynlib.} =
    ## Only Used by CsBot Rescue Platform
    x[] = SuperObj_X
    y[] = SuperObj_Y
    num[] = SuperObj_Num

proc updateRobInfo(sms: cint, x: cint, y: cint): void {.exportc: "UpdateRobInfo", dynlib.} =
    ## Used by CoSpace Rescue Simulation.
    ## Called each time frame by simulator to update the other robot information.
    OtherRob_SMS = sms
    OtherRob_PositionX = x
    OtherRob_PositionY = y

proc updateObjectInfo(x: cint, y: cint, state: cint, duration: cint): void {.exportc: "UpdateObjectInfo", dynlib.} =
    ## Only Used by CsBot Rescue Platform
    ObjState = state
    ObjPositionX = x
    ObjPositionY = y
    ObjDuration = duration

proc getMySMS(): cint {.exportc: "GetMySMS", dynlib.} =
    return MySMS

proc setDataAI*(packet: ptr seq[cint]; AI_IN: ptr seq[cint]): void {.exportc: "SetDataAI", dynlib.} =
  var sum: cint = 0
  US_Front = AI_IN[0]
  packet[0] = US_Front
  inc(sum, US_Front)
  US_Left = AI_IN[1]
  packet[1] = US_Left
  inc(sum, US_Left)
  US_Right = AI_IN[2]
  packet[2] = US_Right
  inc(sum, US_Right)
  CSLeft_R = AI_IN[3]
  packet[3] = CSLeft_R
  inc(sum, CSLeft_R)
  CSLeft_G = AI_IN[4]
  packet[4] = CSLeft_G
  inc(sum, CSLeft_G)
  CSLeft_B = AI_IN[5]
  packet[5] = CSLeft_B
  inc(sum, CSLeft_B)
  CSRight_R = AI_IN[6]
  packet[6] = CSRight_R
  inc(sum, CSRight_R)
  CSRight_G = AI_IN[7]
  packet[7] = CSRight_G
  inc(sum, CSRight_G)
  CSRight_B = AI_IN[8]
  packet[8] = CSRight_B
  inc(sum, CSRight_B)
  PositionX = AI_IN[9]
  packet[9] = PositionX
  inc(sum, PositionX)
  PositionY = AI_IN[10]
  packet[10] = PositionY
  inc(sum, PositionY)
  TM_State = AI_IN[11]
  packet[11] = TM_State
  inc(sum, TM_State)
  Compass = AI_IN[12]
  packet[12] = Compass
  inc(sum, Compass)
  Time = AI_IN[13]
  packet[13] = Time
  inc(sum, Time)
  packet[14] = sum

proc getCommand*(AIOut: ptr seq[cint]): void {.exportc: "GetCommand", dynlib.} =
  AIOut[0] = WheelLeft
  AIOut[1] = WheelRight
  AIOut[2] = LED_1
  AIOut[3] = MyState

