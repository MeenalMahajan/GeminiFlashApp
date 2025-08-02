//
//  MultiModalChatView.swift
//  GeminiMultiModalChat
//
//  Created by Meenal Mahajan on 02/08/25.
//

import SwiftUI
import PhotosUI

struct MultiModalChatView: View {
    
    @State private var textInput: String = ""
    @State private var chatService = ChatService()
    @State private var photoPickerItems = [PhotosPickerItem]()
    @State private var selectedMedia = [Media]()
    @State private var showAttachmentsOption = false
    @State private var showPhotoPicker = false
    @State private var showFilePicker = false
    @State private var showEmptyTextAlert = false
    @State private var loadingMedia = false
  
    var body: some View {
        VStack{
            
            // Logo
            
            Image(.geminiStarLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            
            ScrollViewReader { proxy in
                
                ScrollView(showsIndicators: false) {
                    
                    ForEach(chatService.messages){ chatMessage in
                        //MARK: chat message view
                       // chatMessageView(chatMessage)
                    }
                    
                }
                .onChange(of: chatService.messages) { _, _ in
                    guard let recentMessage = chatService.messages.last else {return}
                    DispatchQueue.main.async{
                        withAnimation(.spring) {
                            proxy.scrollTo(recentMessage.id, anchor: .bottom)
                        }
                    }
                }
               
                // Attachment preview:
                
                if selectedMedia.count > 0{
                    ScrollView(.horizontal){
                        LazyHStack(spacing:10){
                            ForEach(0..<selectedMedia.count,id: \.self){ index in
                                
                                Image(uiImage: selectedMedia[index].thumbnail)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                            }
                        }
                    }
                }
                
                HStack{
                    Button {
                        showAttachmentsOption.toggle()
                    } label: {
                        if loadingMedia{
                            ProgressView()
                                .tint(.white)
                                .frame(width: 40)
                        }
                        else{
                            Image(systemName: "paperclip")
                                .frame(width: 40,height: 25)
                        }
                    }
                    .confirmationDialog("What would you like to attach?",
                                        isPresented: $showAttachmentsOption,
                                        titleVisibility: .visible) {
                        Button("Images") {
                            showPhotoPicker.toggle()
                        }
                        Button("Videos") {
                            showPhotoPicker.toggle()
                        }
                        Button("Documents") {
                            showFilePicker.toggle()
                        }
                    }.photosPicker(isPresented: $showPhotoPicker,
                                   selection: $photoPickerItems,
                                   maxSelectionCount: 2,
                                   matching: .any(of: [.images,.videos]))
                    .onChange(of: photoPickerItems) { _,_ in
                        
                    }
                    .fileImporter(isPresented: $showFilePicker, allowedContentTypes: [.pdf,.text], allowsMultipleSelection: true) { result in
                        selectedMedia.removeAll()
                        loadingMedia.toggle()
                    }
                    
                    
                    TextField("Enter a message...", text: $textInput)
                        .foregroundStyle(.black)
                        .alert("Please enter a message", isPresented: $showEmptyTextAlert, actions: {})
                        .padding()
                        .background(Color.white.cornerRadius(30))

                    if chatService.loadingResponse{
                        ProgressView()
                            .tint(.white)
                            .frame(width: 30)
                    }
                    else{
                        Button {
                            sendMessage()
                        } label: {
                            Image(systemName: "paperplane.fill")
                        }
                        .frame(width: 30)
                        
                    }
                }
                
                
            }
        }
        .foregroundStyle(.white)
        .padding()
        //.ignoresSafeArea(edges: .bottom)
        .background{
            ZStack{
                Color.black
                    .ignoresSafeArea()
            }
        }
    }
    
    //Chat Media
    
    @ViewBuilder
    private func chatMessageView(_ message: ChatMessage) -> some View {
        if let media = message.media, media.isEmpty == false{
            GeometryReader { reader in
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        Spacer()
                            .frame(width: spacerWidth(for: media, geometry: reader))
                        
                        ForEach(0..<media.count, id: \.self) { index in
                            let mediaItem = media[index]
                            
                            Image(uiImage: mediaItem.thumbnail)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .overlay(alignment: .topLeading) {
                                    Image(systemName: mediaItem.overlayIconName)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .shadow(color:.black,radius: 10)
                                        .padding(8)
                                }
                        }
                    }
                }
            }
            .frame(height: 150)
        }
        
        ChatBubble(direction: message.role == .aiModel ? .left : .right) {
            Text(message.message)
                .font(.title2)
                .padding(.horizontal,20)
                .padding(.vertical,10)
                .foregroundStyle(.white)
                .background(message.role == .aiModel ? .blue : .gray)
        }
    }
    
    private func sendMessage() {
        guard !textInput.isEmpty else {
            showEmptyTextAlert = true
            return
        }
    }
    
    private func spacerWidth(for media: [Media],geometry: GeometryProxy) -> CGFloat{
        var totalWidth: CGFloat = 0
        for mediaItem in media {
            let scaledWidth = mediaItem.thumbnail.size.width * (150/mediaItem.thumbnail.size.height)
            
            totalWidth += scaledWidth + 20
        }
        return totalWidth < geometry.size.width ? geometry.size.width - totalWidth : 0
    }
}

#Preview {
    MultiModalChatView()
}
