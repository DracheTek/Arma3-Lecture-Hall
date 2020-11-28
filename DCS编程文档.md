# DCS 编程文档

## 单个对象（Singleton）

有以下几种单个对象

* env

编程环境对象。

* timer

计时器对象

* land

地表对象

* atmosphere

大气对象

* world

世界对象

* coalition

阵营管理对象

* trigger

触发器对象

* coord

坐标管理对象

* missionCommands

任务管理对象

* VoiceChat

语音聊天室对象

## 函数库

### A

Group.activate(class self)

激活一个组

trigger.action.activateGroup(Group group)

trigger.action.deactivateGroup(Group group)

激活/取消激活一个组。作为触发器的动作使用。原理是调用Group.activate。

world.addEventHandler(EventHandler handler)

添加事件处理器。事件的种类见“事件”

coalition.addGroup(enum countryId, enum groupCategoryh, table groupData)

生成一个新的组。单位数据GroupData的格式如下

```lua
local groupData = {
	--必需值

	["name"] = "Ground Group",			--组名。组名可以与单位名重复，但是组和组之间不能重复。
	["task"] = "Ground Nothing",		--主任务名
	["x"] = -288585.71428572,
	["y"] = 616314.28571429,			--x坐标和y坐标

	--可选值

	["groupId"] = 2,					--组ID。不填默认自动分配
	["start_time"] = 0,					--延时启动时间，从任务开始时开始计算。填0则执行代码时立即生成
	["lateActivation"] = false,			--强制延时生成。只有通过触发器动作才能激活。覆盖延时激活时间。
	["visible"] = false,				--激活前可见
	["hidden"] = false,					--在F10地图上可见
	["taskSelected"] = true,
	["route"] =							--复杂表格。表示路径点
	{
	}, -- end of ["route"]
	["tasks"] =							--复杂表格，表示任务
	{
	}, -- end of ["tasks"]
	["units"] =							--单位的表格
	{
		[1] =
		{
			--必需值
			["name"] = "Ground Unit1",
			["type"] = "LAV-25",
			["x"] = -288585.71428572,
			["y"] = 616314.28571429,
			--可选值
			["transportable"] =
			{
				["randomTransportable"] = false,
			}, -- end of ["transportable"]
			["unitId"] = 2,
			["skill"] = "Average",
			["playerCanDrive"] = true,
			["heading"] = 0.28605144170571,
		}, -- end of [1]
	}, -- end of ["units"]

} -- end of [1]

coalition.addGroup(country.id.USA, Group.Category.GROUND, groupData)
```

可选的值（固定翼和直升机）

```lua
 uncontrolled    boolean for ground starts, whether or not the aircraft will be visible but not active
 modulation      number (0 or 1) for AM or FM radio
 frequency       number of the radio frequency the unit will broadcast to
 communication   boolean for whether or not the group will communicate over the radio
 ```

地面部队和水面舰艇的可选值

```lua
 visible         boolean For whether or not the group is visible before its start time
 ```

单位的必需值

```lua
name         name for the type of object
type         string for the type of object
x            number for x coordinate
y            number for y coordinate
```

固定翼和直升机单位的必需值

```lua
 alt         number altitude in meters
 alt_type    string "BARO" or "RADIO" for Above sea level or above ground level
 speed       number velocity the aircraft will spawn at measured in meters per second
 payload     table of the aircrafts payload including fuel, weapons, and countermeasures
 callsign    table/number of the callsign for the unit. NATO countries use a table to define callsigns while the Russian style uses a number
 ```

其他可选值

```lua
unitId       number unitId
heading      number heading of the object in radians
skill        string of the units skill level. Can be "Excellent", "High", "Good", "Average", "Random", "Player"
```

固定翼和直升机的值

```lua
 livery_id   string name of the livery for the aircraft
 psi         number
 onboard_num string of the tail number on the aircraft
 ```

直升机的值

```lua
 ropeLength  number length of a rope used for sling loading, default is 15
```

coalition.addRefPoint(enum coalitionId, table refPoint)

添加一个参考点。JTAC的工作需要用到参考点。参考点的格式如下

```lua
RefPoint={
    callsign = number,
    type = number,
    point = Vec3
}
```

coalition.addStaticObject(enum countryId, table groupData)
动态生成一组静态对象。静态对象是只有模型和血量，没有动作的单位。

```lua
local staticObj = {
	--必需值
	["name"] = "dynBuilding",	--名字
	["type"] = "Cafe",			--类别
	["x"] = -294100,			--x坐标和y坐标
	["y"] = 621528.57142856,
	--可选值
	["dead"] = false,			--是已经破坏的
	["rate"] = 100,				--炸毁所值的分数
	["groupId"] = 3,			--组ID
	["unitId"] = 3,				--单位ID
	["heading"] = 0,			--朝向
	["shape_name"] = "stolovaya",		--模型名字
	["category"] = "Fortifications",	--类别
	--货物类静态单位的可选值
	["mass"] = 100,			--质量
	["canCargo"] = false,	--能被吊运与否
	--飞机类静态单位的可选值
	["livery_id"] = "xxx"
}

coalition.addStaticObject(country.id.USA, staticObj)
```

### C

createInfraRed
createLaser(Object Source, Vec3 localRef, Vec3 point, [number laseCode])

创建红外或激光光点。其中激光光点允许进行激光编码。激光编码从1111到1788.

localRef表示从相对source中心的哪个位置发出。

createRoom
创建语音房间

### D

Object.destroy(class Self)

摧毁一个对象，不触发对象摧毁的事件

dostring in
多人模式函数，执行字符串形式的lua代码。

### E

trigger.action.effectSmokeBig(table vec3, enum smoke_preset, number density)

产生大烟火效果。smoke_preset种类如下：

 1 = small smoke and fire
 2 = medium smoke and fire
 3 = large smoke and fire
 4 = huge smoke and fire
 5 = small smoke
 6 = medium smoke
 7 = large smoke
 8 = huge smoke

density值在0到1之间。

error(string log, [boolean showMessageBox])
warning
info
在log文件中记录一条错误/警告/信息，可选变量表示弹出警告框与否。
DCS.exitProcess
关闭游戏
trigger.action.explosion(table vec3, number power)

制造给定当量的爆炸。

### F

land.findPathOnRoads(string roadType, number xCoord, number yCoord, number destX, number destY)

求连接两点之间的道路。返回值是一系列在道路上的点。roadType可以是'rails'（铁路）或'roads'（公路）

### G

groupContinueMoving
groupStopMoving

暂停/恢复一个组的移动/执行在途任务

### H

hasAttribute
hasSensors
hasTask

### I

illuminationBomb

产生照明弹效果

inAir

isActive
isExist
isMultiplayer
isServer
isTargetDetected
isVisible

### J

json2lua
lua2json

lua和json代码相互转换

### K

kick
knowTarget

### L

LLtoLO
LOtoLL
LLtoMGRS
MGRStoLL
net.load_next_mission

### M

markToAll
markToCoalition
markToGroup

推送一个F10地图标记给所有人/特定阵营/特定组

### O

outSound
outSoundForCoalition
outSoundForCountry
outSoundForGroup

outText
outTextForCoalition
outTextForCountry
outTextForGroup

推送声音/显示文字给所有人/特定单位/特定国家/特定组

### P

popTask
profile
pushAITask
pushTask

### R

radioTransmission
removeEventHandler
removeFunction
removeItem
removeItemForCoalition
removeItemForGroup
removeMark
resetTask

### S

scheduleFunction
searchObjects
net.send_chat

给客户端发送聊天信息

signalFlare
smoke
stopMission

### get/set 系列函数

timer.getAbsTime

返回任务开始后的秒数

coalition.getAirbases(enum coalitionId)

返回一个阵营的所有空军基地

unit.getAmmo(class self)

返回一个单位目前持有的弹药

DCS.getAvailableCoalitions()

返回客户端所有的阵营（多人游戏）

DCS.getAvailableSlots(number/string coalitionId)

返回给定阵营在客户端可用的玩家格子（多人游戏）

Group/Unit/StaticObject.getByName(string name)

按照输入的名字返回一个对象。

Unit/Airbase.getCallsign(class self)

返回一个对象的呼号

Static_Object.getCargoDisplayName(class self)

返回一个货物对象的质量，格式是"*质量* kg"

Static_Object.getCargoWeight(class self)

以数字形式返回一个货物对象的质量

Object/Group/Spot/Airbase.getCategory(class self)

返回一个对象的类别

land.getClosestPointOnRoads(string roadType, number xCoord, number yCoord, number zCoord)

返回离输入点最近的道路。道路种类字符串可以是roads或railroads

Object/Group/Coalition_Object.getCoalition(class self)

返回对象所属的阵营。

Spot.getCode(class self)

返回激光点的激光代码。

Group.getController(class self)

返回一个组或单位的AI实体。

水面舰船和地面单位必须按组控制，固定翼和直升机可以按单位或按组控制。

coalition.getCountryCoalition(enum countryId)

返回一个国家所属的阵营

Object.getCountry(class self)

返回一个单位所属的国家

DCS.getCurrentMission

返回任务文件中安排的任务

Object.getDescByName(String typeName)

返回对象类别名所对的描述。

Object.getDesc(class self)

返回对象所对的描述

Controller.getDetectedTargets(class self, [enum detectionType1],[enum detectionType2...])

按照所提供的探测手段返回已经探测到的目标。

目标格式如下：

```lua
DetectedTarget = {
  object = Object, --the target
  visible = boolean, --the target is visible
  type = boolean, --the target type is known
  distance = boolean --distance to the target is known
```

对单个单位控制器有效，对组控制器无效。

Unit.getDrawArgumentValue(class self, number arg)

按编号返回单位的“绘制参数值”，即模型的某个部件运动到某个位置的值。

Unit.getFuel(class self)

返回单位**内油**的百分比。如果单位携带副油箱该百分比可能超过1.

Unit.getGroup(class self)

返回单位所在的组

coalition.getGroups(enum coalitionId, [enum GroupCategory])

返回某个阵营所有特定种类的组。

land.getHeight(table vec2)

返回地面一点的海拔高度

Group.getID(class self)

返回一个对象的任务ID

Group.getInitialSize(class self)/
Group.getSize(class self)

返回一个组的初始成员数/当前成员数

land.getIP(table origin, table direction, number distance)

将原点-方向-距离值转换为点。如果无法转换则返回nil

Weapon.getLauncher(class self)

返回武器的发射者

Unit.getLife0(class self)
getLife

返回初始/当前血量

coalition.getMainRefPoint(enum coalitionId)

返回阵营靶眼位置

world.getMarkPanels()

返回目前所有的标记点

```lua
 [1] ={
   idx = idxMark(IDMark),
   time = Time,
   initiator = Unit,
   coalition = -1 (or RED/BLUE),
   groupID = -1 (or ID),
   text = markText,
   pos = vec3
 }
 ```

DCS.getMissionFilename()

返回任务文件名

DCS.getMissionName()

返回任务名称

DCS.getMissionOptions()

返回任务选项

DCS.getMissionResult(string side)

根据任务目标定义，返回特定阵营的任务进度

DCS.getModelTime()

返回DCS模拟持续时间。单位秒。

Object.getName(class self)

返回对象的名字

Unit.getNearestCargos(class self)

返回最近的货物单位。如果输入的单位不是直升机，返回nil。

Unit.getNumber(class self)

返回特定单位在组内的编号

Airbase.getParking(class self, boolean available)

返回特定空军基地的停机位信息。类别数字格式如下：

```lua
16 : Valid spawn points on runway
40 : Helicopter only spawn  
68 : Hardened Air Shelter
72 : Open/Shelter air airplane only
104: Open air spawn
```

DCS.getPause()

返回服务器是否为暂停状态

world.getPlayer()

返回技术水平设为“玩家”的单位。

Unit.getPlayerName(Class Self)

如果传入的单位由玩家控制，返回玩家名字，否则返回nil

coalition.getPlayers(enum coalitionId)

返回某个阵营目前被玩家控制的单位表格

Object/Spot.getPoint(class self)

返回给定对象所在的3d位置

Object/Spot.getPosition(class self)

返回给定对象的3d位置和3d朝向

```lua
Position3 = {   p = Vec3,
                x = Vec3,
                y = Vec3,
                z = Vec3 }
```

Unit.getRadar(class self)

返回两个值，一个bool值表示有无雷达，另一个object是该雷达正在跟踪或最感兴趣的搜索目标。

DCS.getRealTime()

返回DCS程序启动后的秒数

coalition.getRefPoints(enum coalitionId)

返回一个阵营所有参考点。JTAC会用到参考点。

Unit.getSensors(class self)

返回一个单位的传感器信息

coalition.getServiceProviders(enum coalitionId, enum coalition.service)

返回某一阵营某种空中服务的提供者。空中服务包括加油TANKER,预警AWACS,空管ATC,前进火力控制FAC

coalition.getStaticObjects(enum coalitionId)

返回某一阵营所有静态对象的列表

land.getSurfaceType(table vec2)

返回某一点的地面种类

Weapon.getTarget(class self)

返回武器正在追踪的目标

atmosphere.getTemperatureAndPressure(table vec3)

返回当前点的气温和气压（2个返回值）

timer.getTime0()

返回任务开始后的时间

timer.getTime()

返回任务开始后的时间，精确到毫秒。即使暂停这个数字也会增长。

Object.getTypeName()

返回对象的类名。例如对一架A-10C战机对象使用返回字符串"A-10C"

Group.getUnit(number unitIndex)

按照编号返回组内的一个单位

DCS.getUnitProperty(number unitId, string propertyId)

返回一个单位的一项属性。

```lua
  DCS.UNIT_RUNTIME_ID, -- unique within runtime mission. int
  DCS.UNIT_MISSION_ID, -- unique within mission file. int>0
  DCS.UNIT_NAME, -- unit name, as assigned by mission designer.
  DCS.UNIT_TYPE, -- unit type (Ural, ZU-23, etc)
  DCS.UNIT_CATEGORY,
  DCS.UNIT_GROUP_MISSION_ID, -- group ID, unique within mission file. int>0
  DCS.UNIT_GROUPNAME, -- group name, as assigned by mission designer.
  DCS.UNIT_GROUPCATEGORY,
  DCS.UNIT_CALLSIGN,
  DCS.UNIT_HIDDEN,-- ME hiding
  DCS.UNIT_COALITION,-- "blue", "red" or "unknown"
  DCS.UNIT_COUNTRY_ID,
  DCS.UNIT_TASK, --"unit.group.task"
  DCS.UNIT_PLAYER_NAME, -- valid for network "humanable" units
  DCS.UNIT_ROLE,--"artillery_commander", "instructor", etc
  DCS.UNIT_INVISIBLE_MAP_ICON,--ME invisible map icon
```

Group.getUnits(class self)

返回一个组的所有单位

DCS.getUnitTypeAttribute(string typeName, string attribute)

返回一个单位类别的一种属性

DCS.getUnitType(number missionId)

等效于DCS.getUnitProperty(missionId, DCS.UNIT_TYPE)

trigger.misc.getUserFlag(string flagnum/flagname)

按照ID号或名字返回用户flag

env.getValueDictByKey(string value)

返回字典键值对应的值。

Object.getVelocity(class self)

返回对象的速度

atmosphere.getWind(table vec3)

返回当前点的风

atmosphere.getWindWithTurbulence(table vec3)

返回当前点的风和湍流

trigger.misc.getZone(string zoneName)

按名字返回触发区

setAITask
setCode
setCommand
setErrorMessageBoxEnabled
setFunctionTime
setGroupAIOff
setGroupAIOn
setOnOff
setOption
setPause
setPoint
setTask
setUnitInternalCargo
setUserFlag

### F10无线电指令函数

missionCommands.addCommand(string name, table/nil path, function functionToRun, [any anyArgument])

missionCommands.addCommandForCoalition(enum coalitionId, 同上)

missionCommands.addCommandForGroup(enum groupId, 同上)

为所有人/指定阵营/指定组添加F10命令。可选变量Argument是functionToRun的参数。返回一个table，该table从上往下表示所添加的子菜单的路径。

例：

```lua
local displayRequests = missionCommands.addSubMenu( "Display Requests")
local negativeReply = missionCommands.addCommand( "Negative Ghostrider", displayRequests , displayMsg, {flyby = false})
local positiveReply = missionCommands.addCommand( "Roger Ghostrider", displayRequests , displayMsg, {flyby = true})
```

这样可以添加三个命令，其中negative/positiveReply两个命令在displayRequests之下。

trigger.action.addOtherCommand(string name, string userFlagName, number userFlagValue)

trigger.action.addOtherCommandForCoalition(enum coalitionId, 其他同上)

trigger.action.addOtherCommandForGroup(number groupId, 其他同上)

trigger.action.removeOtherCommand(string name, string userFlagName, number userFlagValue)

trigger.action.removeOtherCommandForCoalition

trigger.action.removeOtherCommandForGroup

为所有人/阵营/组添加/移除F10命令，与之前的函数不同，这里的命令只能更改一个flag值，且不能有子菜单。该函数作为触发器的动作使用。

addSubMenu(string name, [table path])
addSubMenuForCoalition
addSubMenuForGroup

为所有人/阵营/组添加子菜单.子菜单是没有函数与之挂钩的F10命令.路径表格是可选项，如果不填则加到根目录下。返回值是路径表格，从上到下表示所添加子菜单所在的路径。

例如以下代码会添加标题为“Request Asset”的子菜单，子菜单下有“SEAD”“CAS”“CAP”三个命令。

```lua
 local requestM = missionCommands.addSubMenu('Request Asset')
 local rSead = missionCommands.addCommand('SEAD', requestM, doRequestFunction, {type = 'SEAD"})
 local rCAS = missionCommands.addCommand('CAS', requestM, doRequestFunction, {type = 'CAS"})
 local rCAP= missionCommands.addCommand('CAP', requestM, doRequestFunction, {type = 'CAP"})
```

以下可以创建嵌套的子菜单。

```lua
 local subR = missionCommands.addSubMenu('Root SubMenu')
 local subN1 = missionCommands.addSubMenu('SubMenu within RootSubmenu', subR)
 local subN2 = missionCommands.addSubMenu('we must go deeper', subN1)
 local subN3 = missionCommands.addSubMenu('Go take a UX class', subN2)
```

### net函数

```lua
net.get_my_player_id()
net.get_name()
net.get_player_info()
net.get_player_listinfo()
net.get_server_id()
net.get_slot()
net.get_stat()
```
