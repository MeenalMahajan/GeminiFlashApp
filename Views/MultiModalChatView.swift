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
            
        }
    }
}

#Preview {
    MultiModalChatView()
}
