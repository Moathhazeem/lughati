import 'package:flutter/material.dart';
class IntroScreen extends StatelessWidget{
  const IntroScreen({super.key});

 @override
 Widget build(BuildContext context){
    return Scaffold(
        backgroundColor:Colors.white,
        body: SafeArea(
            child:Padding(
                padding: const EdgeInsets.symmetric(horizontal:24.0,vertical:16.0),
                child: Column(
                    crossAxisAlignment:CrossAxisAlignment.stretch,
                    children:[
                        Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                                const Text(
                                    'Lughati',
                                    style:TextStyle(
                                        fontSize:16,
                                        color:Colors.grey,
                                        fontWeight:FontWeight.w500,
                                    ),
                                ),
                                TextButton(
                                    onPressed:(){},
                                    child:const Text(
                                        'Skip',
                                        style:TextStyle(color:Colors.grey,fontSize:16,),
                                    ),
                                ),
                            ],
                        ),
                        const Spacer(),
                        Center(
                            child: Image.asset('assets/photo/intro_!.jpg',
                            height:280,
                            fit:BoxFit.contain,
                            ),
                        ),
                        const Spacer(),
                        const Text('Speak with confidence from day one!',
                        textAlign:TextAlign.center,
                        style:TextStyle(
                            fontSize:22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.3,
                        ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                            'Go beyond memorizing words. Develop your conversational skills with quick, interactive lessons that fit into your day.',
                            textAlign: TextAlign.center,
                            style:TextStyle(
                                fontSize:14,
                                color: Colors.grey,
                                height: 1.4,
                            ),
                        ),
                        const SizedBox(height:28),
                        Row(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: [
                                Container(
                                    width: 32,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        color:const Color(0xFF3B82F6),
                                        borderRadius: BorderRadius.circular(4),
                                    ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                    width: 20,
                                    height:8,
                                    decoration:BoxDecoration(
                                        color:Colors.grey.shade300,
                                        borderRadius:BorderRadius.circular(4),
                                    ),
                                ),
                                const SizedBox(width:8),
                                Container(
                                    width: 20,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        color:Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(4),
                                    ),
                                ),
                            ],
                        ),
                        const SizedBox(height: 28),

                        ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                backgroundColor:const Color(0xFFE0F2FE),
                                elevation:0,
                                padding:const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                ),
                            ),
                            child:const Row(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children:[
                                    Text(
                                        'Continue',
                                        style:TextStyle(
                                            color:Color(0xFF2563EB),
                                            fontSize:16,
                                            fontWeight:FontWeight.w600,
                                        ),
                                    ),
                                    SizedBox(width:6),
                                    Icon(
                                        Icons.arrow_forward_ios,
                                        size:14,
                                        color:Color(0xFF2563EB)
                                    ),
                                ],
                            ),
                        ),
                        const SizedBox(height:12),
                    ]
                )
            )
        )
    )
 }
}