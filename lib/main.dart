import 'package:convertor/global/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/time.dart';
import 'dart:io';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    ),
  );
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin{

  TabController?  tabController;
  PageController pageController = PageController();
  DateTime? SelectedDate;
  TimeOfDay? SelectTime;
  Duration? duration;
  bool isIos = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return (isIos)
        ?CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle:  Text("WhatsApp",style: TextStyle(color: Color(0xff8596a0),fontSize: 23),),
          backgroundColor: Color(0xff1f2c34),
          trailing:Icon(Icons.more_vert_outlined,color: Color(0xff8596a0),),
          leading: CupertinoSwitch(
            thumbColor:  Color(0xff00a884),
            activeColor:Color(0xff8596a0),
            value: isIos,
            onChanged: (val){
              setState((){
                isIos = val;
              });
            },
          ),
        ),
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: Color(0xff1f2c34),
            inactiveColor: Color(0xff8596a0),
            activeColor:Color(0xff00a884) ,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                    size: 25,),),
              BottomNavigationBarItem(
                icon: Icon(Icons.call,
                  size: 25,),),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined,
                  size: 25,),),
            ],
          ),
          tabBuilder: (context,i){
            return IndexedStack(
              index: i,
              children: [
                Container(
                 child: ListView.builder(
                   itemCount: Globals.allContact.length,
                     itemBuilder: (context, i) => Card(
                       elevation: 0,
                       margin: EdgeInsets.only(bottom: 2,top: 2),
                       color: Color(0xff121b22),
                       child: ListTile(
                         leading: CircleAvatar(
                           radius: 25,
                           backgroundImage: AssetImage(Globals.allContact[i]['image']),
                         ),
                         title: Text("${Globals.allContact[i]['title']}",style: TextStyle(
                             color:Color(0xffeaeef1),fontSize: 20,fontWeight: FontWeight.w400
                         ),),
                         subtitle: Text(Globals.allContact[i]['subtitle'],style: TextStyle(color:Color(0xff8596a0),fontSize: 16,fontWeight: FontWeight.w500),),
                         trailing: Text(Globals.allContact[i]['time'],style: TextStyle(color:Color(0xff8596a0),fontSize: 18),),
                       ),
                     ),
                 ),
                ),

                Container(
                  child: ListView.builder(
                    itemCount: Globals.allContact.length,
                    itemBuilder: (context, i) => Card(
                      elevation: 0,
                      margin: EdgeInsets.only(bottom: 2,top: 2),
                      color: Color(0xff121b22),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(Globals.allContact[i]['image']),
                        ),
                        title: Text("${Globals.allContact[i]['title']}",style: TextStyle(
                            color:Color(0xffeaeef1),fontSize: 20,fontWeight: FontWeight.w400
                        ),),
                        subtitle: Text(Globals.allContact[i]['call'],style: TextStyle(color:Color(0xff8596a0),fontSize: 16,fontWeight: FontWeight.w500),),
                          trailing: Icon(Icons.video_camera_back,color:Color(0xff00a884),size: 27,)
                      ),
                    ),
                  ),
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage("assets/images/Screenshot_20220909-105804_Google.jpg"),
                          ),
                          SizedBox(width: 15,),
                          Column(
                            children: [
                              Text("Kesha",
                                style: TextStyle(fontSize: 23,color:Color(0xffeaeef1),fontWeight: FontWeight.w400 ),),
                              SizedBox(height: 5,),
                              Text("Available",
                                style: TextStyle(color:Color(0xff8596a0),fontSize: 15,fontWeight: FontWeight.w500),),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.qr_code_2_sharp, color:  Color(0xff00a884),size: 30,),
                          SizedBox(width: 10,),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Divider(
                      color:  Color(0xff1f2c34),
                      height: 6,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.calendar_month_outlined,color: Color(0xff8596a0),size: 30,),
                          SizedBox(width: 30,),
                          Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CupertinoButton(
                                  child: Text("Calender",style: TextStyle(color: Color(0xffe9edf0),fontSize: 20),),
                                  onPressed: (){
                                   showCupertinoModalPopup(
                                       context: context,
                                       builder:(context) => Container(
                                         height: 200,
                                         color: CupertinoColors.white,
                                         child: Column(
                                           children: [
                                             Expanded(
                                               flex: 3,
                                               child: CupertinoDatePicker(
                                                 initialDateTime: DateTime.now(),
                                                 backgroundColor: Colors.black26,
                                                 maximumYear: 2050,
                                                 minimumYear: 1950,
                                                 onDateTimeChanged: (data){
                                                   setState((){
                                                     SelectedDate = data;
                                                   });
                                                 },
                                                 mode: CupertinoDatePickerMode.date,
                                               ),),
                                             Expanded(child: CupertinoButton(
                                               child: Text("Done",style: TextStyle(color: Colors.black),),
                                               // color: Colors.black,
                                               onPressed: (){
                                                 Navigator.pop(context);
                                               },
                                             )),
                                           ],
                                         ),
                                       ),
                                   );
                                  }
                              ),
                              SizedBox(height: 10,),
                              (SelectedDate  != null)
                                  ? Text("${SelectedDate!.day} / ${SelectedDate!.month} / ${SelectedDate!.year}",style: TextStyle(fontSize: 18,color: Color(0xff8596a0),) )
                                  : Text("${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",style: TextStyle(fontSize: 18,color: Color(0xff8596a0),),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.timer,color: Color(0xff8596a0),size: 30,),
                          SizedBox(width: 30,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CupertinoButton(
                                  child: Text("Time",style: TextStyle(color: Color(0xffe9edf0),fontSize: 20),),
                                  onPressed: (){
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder:(context) => Container(
                                        height: 200,
                                        color: CupertinoColors.white,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: CupertinoTimerPicker(
                                                initialTimerDuration: Duration(),
                                                mode: CupertinoTimerPickerMode.hms,
                                                onTimerDurationChanged: (data){
                                                 setState((){
                                                  duration = data;
                                                 });
                                                },
                                              ),
                                      ),
                                            Expanded(child: CupertinoButton(
                                              child: Text("Done",style: TextStyle(color: Colors.black),),
                                              // color: Colors.black,
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              ),
                              SizedBox(height: 10,),
                              (SelectedDate  != null)
                                  ? Text("${duration!.inHours} : ${duration!.inMinutes}",style: TextStyle(fontSize: 18,color: Color(0xff8596a0),) )
                                  : Text("${DateTime.now().hour} : ${DateTime.now().minute}",style: TextStyle(fontSize: 18,color: Color(0xff8596a0),),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
          backgroundColor:  Color(0xff121b22) ,
        ),
      ),
    )
        : MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("WhatsApp",style: TextStyle(color: Color(0xff8596a0),fontSize: 23),),
            backgroundColor: Color(0xff1f2c34),
            elevation: 0,
            actions: [
              Switch(
                  inactiveThumbColor: Color(0xff00a884),
                  inactiveTrackColor:  Color(0xff8596a0),
                  value: isIos,
                  onChanged: (val){
                    setState((){
                      isIos = val;
                    });
                  }
              ),
              SizedBox(width: 12,),
              Icon(Icons.camera_alt_outlined,color: Color(0xff8596a0),),
              SizedBox(width: 12,),
              Icon(Icons.search,color: Color(0xff8596a0),),
              SizedBox(width: 12,),
              Icon(Icons.more_vert_outlined,color: Color(0xff8596a0),),
            ],
            bottom: TabBar(
              controller: tabController!,
             unselectedLabelColor: Color(0xff8596a0),
              labelColor: Color(0xff00a884),
              indicatorColor: Color(0xff00a884),
              tabs: [
                Tab(
                  child: Text("CHATS",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,
                  ),),
                ),
                Tab(
                  child: Text("CALLS",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,
                  ),),
                ),
                Tab(
                  child: Text("Settings",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,
                  ),),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              Container(
                child: ListView.builder(
                  itemCount: Globals.allContact.length,
                    itemBuilder: (context,i) => ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(Globals.allContact[i]['image']),
                      ),
                      title: Text("${Globals.allContact[i]['title']}",style: TextStyle(
                          color:Color(0xffeaeef1),fontSize: 20,fontWeight: FontWeight.w400
                      ),),
                      subtitle: Text(Globals.allContact[i]['subtitle'],style: TextStyle(color:Color(0xff8596a0),fontSize: 16,fontWeight: FontWeight.w500),),
                      trailing: Text(Globals.allContact[i]['time'],style: TextStyle(color:Color(0xff8596a0),fontSize: 18),),
                    ),
                ),
              ),


              Container(
                child: ListView.builder(
                  itemCount: Globals.allContact.length,
                  itemBuilder: (context,i) => ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(Globals.allContact[i]['image']),
                    ),
                    title: Text("${Globals.allContact[i]['title']}",style: TextStyle(
                        color:Color(0xffeaeef1),fontSize: 20,fontWeight: FontWeight.w400
                    ),),
                    subtitle: Text(Globals.allContact[i]['call'],style: TextStyle(color:Color(0xff8596a0),fontSize: 16,fontWeight: FontWeight.w500),),
                    trailing: Icon(Icons.video_camera_back,color:Color(0xff00a884),size: 27,)
                  ),
                ),
              ),


              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage("assets/images/Screenshot_20220909-105804_Google.jpg"),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          children: [
                            Text("Kesha",
                              style: TextStyle(fontSize: 23,color:Color(0xffeaeef1),fontWeight: FontWeight.w400 ),),
                            SizedBox(height: 5,),
                            Text("Available",
                              style: TextStyle(color:Color(0xff8596a0),fontSize: 15,fontWeight: FontWeight.w500),),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.qr_code_2_sharp, color:  Color(0xff00a884),size: 30,),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    color:  Color(0xff1f2c34),
                    height: 6,
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: () async {
                      SelectedDate =  await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050),
                      initialDatePickerMode: DatePickerMode.day,
                        initialEntryMode: DatePickerEntryMode.calendar,
                        builder: (context,child) => Theme(
                            data: ThemeData.dark().copyWith(colorScheme: ColorScheme.dark(
                              primary: Color(0xff00a884),
                              onPrimary: Colors.white,
                           surface:  Color(0xff121b22),
                              onSurface: Color(0xffeaeef1),
                            ),),
                            child: child!,
                          ),

                      );
                      setState((){});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.calendar_month_outlined,color: Color(0xff8596a0),size: 30,),
                          SizedBox(width: 30,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20,),
                              Text("Calender",style: TextStyle(color: Color(0xffe9edf0),fontSize: 20),),
                              SizedBox(height: 10,),
                              (SelectedDate  != null)
                                  ? Text("${SelectedDate!.day} / ${SelectedDate!.month} / ${SelectedDate!.year}",style: TextStyle(fontSize: 18,color: Color(0xff8596a0),) )
                                  : Text("${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",style: TextStyle(fontSize: 18,color: Color(0xff8596a0),),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),


                  InkWell(
                    onTap: () async {
                      SelectTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        builder: (context,child) {
                          return TimePickerTheme(
                              data: TimePickerThemeData(
                                helpTextStyle: TextStyle(fontSize: 15,color: Color(0xffeaeef1) ),
                               dialHandColor: Color(0xff00a884),
                                dialTextColor: Color(0xffeaeef1) ,
                                backgroundColor: Color(0xff121b22),
                                hourMinuteColor:  Colors.black26,
                                hourMinuteTextColor: Color(0xffeaeef1),
                                entryModeIconColor: Color(0xff00a884),
                              ),
                              child: child!);
                        },
                      );
                      setState((){});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.timer,color: Color(0xff8596a0),size: 30,),
                          SizedBox(width: 30,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20,),
                              Text("Timer",style: TextStyle(color: Color(0xffe9edf0),fontSize: 20),),
                              SizedBox(height: 10,),
                              (SelectTime  != null)
                                  ? Text("${SelectTime!.hour} : ${SelectTime!.minute}",style: TextStyle(fontSize: 18,color: Color(0xff8596a0),) )
                                  : Text("${DateTime.now().hour} : ${DateTime.now().minute}",style: TextStyle(fontSize: 18,color: Color(0xff8596a0),),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
           backgroundColor: Color(0xff00a884),
          onPressed: (){},
            child: Icon(Icons.print),
          ),
          backgroundColor:  Color(0xff121b22),
        ),
      ),
    );
  }
}


