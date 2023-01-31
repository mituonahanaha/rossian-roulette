//
//  GameStartView.swift
//  Russian Roulette
//
//  Created by Shimpei on 2022/12/23.
//

import SwiftUI

struct GameStartView: View {
    let SoundPlay = SoundPlayer()
    let captureImage: UIImage
    var answer = Int.random(in: 1...16)
    @State var Count = 0
    @State var isShowSheet: Bool = false
    @State var array = Array(repeating: [Int](repeating: 1,count: 4),count: 4)
    
    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Don't Pick Miss")
                    .font(.system(size: 40, weight: .heavy, design: .serif))
                    .foregroundColor(Color.white)
                    .offset(x: 0,y: 25)
                    .padding(.bottom, 40)
                    .frame(width: 500.0, height: 50.0)
                
                ForEach(0..<4){k in
                    HStack {
                        ForEach(0..<4) {i in
                            Button {
                                array[k][i]=0
                                Count+=1
                                if Count == answer {
                                    SoundPlay.PlayB()
                                    isShowSheet.toggle()
                                } else {
                                    SoundPlay.PlayA()
                                }
                            } label: {
                                if array[k][i] == 1 {
                                    Image(uiImage: captureImage)
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 80.0,height: 140.0)
                                } else {
                                    Image("")
                                        .resizable()
                                        .scaledToFit()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 95.0,height: 140)
                                }
                            }
                            .frame(width: 90.0, height: 130.0)
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $isShowSheet) {
                GameLoseView(captureImage: captureImage)
            }
        }
    }
}

struct GameStartView_Previews: PreviewProvider {
    static var previews: some View {
        GameStartView(captureImage: UIImage(named: "background")!)
    }
}

