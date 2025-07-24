//
//  ContentView.swift
//  CourseOf-cs193p
//
//  Created by 杨家豪 on 2025/7/20.
//

import SwiftUI

struct ContentView: View {
    @State var  emojisCount=emojis.count-1
    @State var emojiIndex=0.0
    var emojiControl:some View{
        Slider(value: $emojiIndex,in: 0...Double(emojisCount),step: 1.0){
            Text("Try")
        }minimumValueLabel: {
            Image(systemName: "minus.circle")
        }maximumValueLabel: {
            Image(systemName: "plus.circle")
        }
    }
    var body: some View {
        VStack{
            HStack (content:{
                ForEach(0..<Int(emojiIndex),id: \.self){index in
                    CardView(index: index)
                    
                }
            })
            .foregroundColor(.orange)
            .padding()
            
            emojiControl
                .foregroundStyle(.blue)
                .frame(width: 300)
            
        }
    }
}
//图案
let emojis=["👻","🤪","😈","😱","👻","💀","🎃"]


//模组部分-矩形
let  base:RoundedRectangle = RoundedRectangle(cornerRadius: 12)


//卡片部分——模组（翻面后）
struct BaseBlock:View {
    
    var body: some View {
        ZStack{
            base
                .foregroundColor(.white)
           base
                .strokeBorder(lineWidth: 2)
           
        }
    }
}
//卡片部分——模组（翻面前）
struct BaseBlockBeforePopUp:View {
    var body: some View {
        base
    }
}

//卡片
struct CardView:View {
    @State var isFaceUp = CardPopUp().popUp
    @State var index:Int
    var body: some View {
        ZStack(content: {
            if isFaceUp{
                ZStack{
                    BaseBlock()
                    Text(emojis[index])
                }
            }else{
                ZStack{
                    BaseBlockBeforePopUp()
                    Text(emojis[index])
                }
                  
            }
        })
        .gesture(
            touch
        )
    }
    var touch:_EndedGesture<TapGesture> {
        TapGesture()
            .onEnded{_ in
                isFaceUp.toggle()
                
            }
       
    }
}

//玩法
class CardPopUp{
    var popUp = false
    func popUp(isFaceUp:Bool){
        popUp = !isFaceUp
    }
}

#Preview {
    ContentView()
}
