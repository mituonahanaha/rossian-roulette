//
//  ImageSelectView.swift
//  Russian Roulette
//
//  Created by Shimpei on 2022/12/23.
//

import SwiftUI
import PhotosUI

struct ImageSelectView: View {
    @State var captureImage: UIImage? = nil
    @State var isShowSheet = false
    @State var isShowSheet2 = false
    @State var photoPickerSelectedImage: PhotosPickerItem? = nil
    let SoundPlay = SoundPlayer()
    
    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                if let captureImage {
                    Text("")
                        .padding()
                    if captureImage.size.height > captureImage.size.width {
                        Image(uiImage: captureImage)
                            .resizable()
                            .scaledToFit()
                            .offset(x: 0,y: 0)
                    } else {
                        Image(uiImage: captureImage)
                            .resizable()
                            .scaledToFit()
                            .offset(x: 0,y: 50)
                    }
                }
                
                Spacer()
                if let captureImage {
                    Button {
                        SoundPlay.PlayC()
                        isShowSheet2.toggle()
                    } label: {
                        Text("Game Start")
                            .font(.system(size: 25, weight: .heavy, design: .serif))
                            .frame(maxWidth: 360)
                            .frame(height: 50)
                            .multilineTextAlignment(.center)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                    }
                    .fullScreenCover(isPresented: $isShowSheet2) {
                        GameStartView(captureImage: captureImage)
                    }
                }
                
                Button {
                    if UIImagePickerController.isSourceTypeAvailable(.camera){
                        print("カメラは利用できます")
                        isShowSheet.toggle()
                    }else{
                        print("カメラは利用できません")
                    }
                } label: {
                    Text("Launch the Camera")
                        .font(.system(size: 25, weight: .heavy, design: .serif))
                        .frame(maxWidth: 360)
                        .frame(height: 50)
                        .background(Color.white)
                        .foregroundColor(Color.black)
                }
                .padding()
                .sheet(isPresented: $isShowSheet) {
                    ImagePickerView(isShowSheet: $isShowSheet,captureImage: $captureImage)
                }
                
                PhotosPicker(selection: $photoPickerSelectedImage,matching: .images,preferredItemEncoding: .automatic,photoLibrary: .shared()) {
                    Text("Select from Photolibrary")
                        .font(.system(size: 25, weight: .heavy, design: .serif))
                        .frame(maxWidth: 360)
                        .frame(height: 50)
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .padding(.bottom,100)
                }
                .onChange(of: photoPickerSelectedImage) {photosPickerItem in
                    if let photosPickerItem {
                        photosPickerItem.loadTransferable(type: Data.self) { result in
                            switch result {
                            case.success(let data):
                                if let data {
                                    captureImage = UIImage(data: data)
                                }
                            case.failure:
                                return
                            }
                        }
                    }
                }
            }
            .padding(.top)
        }
    }
}

struct ImageSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelectView()
    }
}

