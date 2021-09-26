//
//  ContentView.swift
//  Card Scan
//
//  Created by Admin on 9/24/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var myRequest: TextRequest
    @State var mainText = "Description"
    @State var mainImage = UIImage(named: "placeholder")!
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var imageSelected = UIImage()
    @State var changeProfileImage = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        
        VStack {
            
            
            Image(uiImage: mainImage).resizable().scaledToFit().frame(height: UIScreen.main.bounds.height*0.4, alignment: .top).padding()
            
            
            
            
            ScrollView{
                VStack {
                    Text(mainText)
                }
            }
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 12.0).foregroundColor(Color("bottomBarColor")).frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.height/12)
                
                Button {
                    self.showActionSheet = true
                    self.changeProfileImage = true
                    
                    
                    if changeProfileImage == true {
                        mainImage = imageSelected
                        myRequest.recognizeText(image: imageSelected)
                        mainText = myRequest.text
                        
                        
                    } else {
                        self.mainImage = UIImage(named: "placeholder")!
                    }
                    
                    
                    
                    
                    
                } label: {
                    Image(systemName: "camera").font(.largeTitle).foregroundColor(Color("cameraButtonColor"))
                    
                    
                }        .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("Select picture"), message: nil,
                                buttons: [
                                    .default(Text("Camera"), action: {
                                        self.showImagePicker = true
                                        self.sourceType = .camera
                                        
                                        
                                    }),
                                    .default(Text("Photo Library"), action: {
                                        self.showImagePicker = true
                                        self.sourceType = .photoLibrary
                                        
                                        
                                    }),
                                    .cancel()
                                ])
                }.sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: self.$imageSelected, sourceType: self.sourceType)
                    
                    
                    
                }
                
                
                
                
                
            }
        }
    }
}
