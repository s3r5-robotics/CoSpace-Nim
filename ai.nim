const TeamName: cstring = "SERS TEAM"

var CurGame: cint = 0
var CurAction: cint = 0
var Teleport: cint = 0
var bGameEnd: cint = 0
var AI_TeamID = 0

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

proc setGameID(GameID: cint): void {.exportc: "SetGameID", dynlib.} =
    CurGame = GameID
    bGameEnd = 0

proc setTeamID(TeamID: cint): void {.exportc: "SetTeamID", dynlib.} =
    AI_TeamID = TeamID

proc getGameID(): cint {.exportc: "GetGameID", dynlib.} =
    return CurGame

proc isGameEnd(): cint {.exportc: "IsGameEnd", dynlib.} =
    return bGameEnd

# GetDebugInfo

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

# SetDataAI
# GetCommand
