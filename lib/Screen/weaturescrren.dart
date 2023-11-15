import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weature/Repo.dart';

import '../Model/WeatureModel.dart';
import '../bloc/bloc.dart';
import '../bloc/weature_event.dart';
import '../bloc/weature_state.dart';

class WeatureScreen extends StatefulWidget {
  final city;
  final state;
  final country;
  final lat;
  final lon;

   WeatureScreen({Key? key,  this.lat, this.lon, this.city, this.state, this.country,}) : super(key: key);

  @override
  State<WeatureScreen> createState() => _WeatureScreenState();
}

class _WeatureScreenState extends State<WeatureScreen> {



  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }
  getdata(){
    context.read<WeatBloc>().add(getdataEvent(widget.lat,widget.lon));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromRGBO(46, 67, 116, 1),

      body:BlocBuilder <WeatBloc,WeatState>(
          builder:(context,state){
            if(state is ProductLoading){
              Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  CircularProgressIndicator(color: Colors.white,),
                  Align(
                      alignment: Alignment.center,
                      child: Text('Loadind ...',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.white),)),

                ],
              ));

            }
            if(state is ProductSuccess){

              return RefreshIndicator(
                  onRefresh: () {
                    return getdata();

                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Container(
       child: Column(
        children: [

      SizedBox(
        height: 60,
      ),
Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(20)
  ),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Icon(Icons.location_on_outlined,color: Colors.white,),
        Text(widget.city.toString()+" "+widget.state.toString()+" "+widget.country.toString(),maxLines:1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 13,color: Colors.white),)
      ],
    ),
  ),
),
          SizedBox(
            height: 30,
          ),
Table(
  columnWidths: {
    0:FlexColumnWidth(6),
    1:FlexColumnWidth(3)

  },
  children: [
    TableRow(
      children: [
      Align(
      alignment:Alignment.topLeft,
      child: Text(state.model.current.temperature2M.toString()+ state.model.currentUnits.temperature2M.toString(),style: TextStyle(fontSize:68,color: Colors.white,fontWeight: FontWeight.w400),)),
Icon(Icons.cloudy_snowing,color: Colors.white,size: 110,)
      ]
    )
  ],
),
     SizedBox(
       height: 20,
     )           , // Text(state.model.timezone.toString()),
Table(
  children: [
    TableRow(
      children: [

      Align(
        alignment:Alignment.topLeft,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text("Utc offset seconds",style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400),),
        Text(state.model.utcOffsetSeconds.toString()+ state.model.currentUnits.temperature2M.toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400),),

      ],
        )),
      Align(
        alignment:Alignment.topRight,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text("Timezone",style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400),),
        Text(state.model.timezone.toString()+ state.model.currentUnits.temperature2M.toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400),),

      ],
        )),

      ]
    ),

  ],
),
      SizedBox(
        height: 50,
      ),
      Table(
        children: [

          TableRow(
              children: [

                    Align(
                        alignment:Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Timezone abbreviation",style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400),),
                            Text(state.model.timezoneAbbreviation.toString()+ state.model.currentUnits.temperature2M.toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400),),

                          ],
                        )),
                    Align(
                        alignment:Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text("Elevation",style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400),),
                            Text(state.model.elevation.toString()+ state.model.currentUnits.temperature2M.toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400),),

                          ],
                        )),

              ]
          ),
        ],
      ),
SizedBox(
  height: 50,
),
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child:   Row(
    children: [
      for(var i=0;i<state.model.daily.weathercode.length;i++)...[
      Padding(
      padding: const EdgeInsets.only(top:8,right: 8,bottom: 8),
      child: Container(
        decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(20)
        ),

        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          state.model.daily.weathercode[i]==0?Icon(Icons.cloud_off_outlined,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==1?Icon(Icons.cloud,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==2?Icon(Icons.cloud,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==3?Icon(Icons.cloud,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==45?Icon(Icons.foggy,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==48?Icon(Icons.foggy,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==51?Icon(Icons.light_outlined,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==55?Icon(Icons.light_outlined,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==53?Icon(Icons.light_outlined,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==61?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==63?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==65?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==66?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==67?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==71?Icon(Icons.snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==73?Icon(Icons.snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==75?Icon(Icons.snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==77?Icon(Icons.snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==80?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==81?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==82?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==85?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==86?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==82?Icon(Icons.thunderstorm,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==85?Icon(Icons.thunderstorm,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==86?Icon(Icons.thunderstorm,color: Colors.white,size: 85,)


              :Icon(Icons.cloud,color: Colors.white,size: 85),

           Row(
             children: [
               Text(state.model.daily.temperature2MMin[i].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),
              Icon(Icons.vertical_align_bottom,color: Colors.white,),
               Text(state.model.daily.temperature2MMax[i].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),
               Icon(Icons.vertical_align_top,color: Colors.white,)
             ],
           ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                    children: [
                      Icon(Icons.sunny,color: Colors.yellow,),

                      Text(state.model.daily.sunrise[i].substring(0,10).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),

                    ],
              ),
              SizedBox(
                    width: 10,
              ),
              Column(
                    children: [
                      Icon(Icons.sunny_snowing,color: Colors.yellow,),
                      Text(state.model.daily.sunset[i].substring(0,10).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),

                    ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          // Text(state.model.daily.time[i].substring(0,10).toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),

        ],
      ),
        ),
      ),
      )
      ]
    ],
  ),
)

        ],
      )
      ),
                    ),
                  ),
                );
              
            }
            if(state is ProductError){
              return Text(state.msg);                    }
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CircularProgressIndicator(color: Colors.white,),
                Align(
                    alignment: Alignment.center,
                    child: Text('Loadind ...',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.white),)),

              ],
            ));

          }


      ),


    );
  }
}
