//
//  ChatService.swift
//  GeminiMultiModalChat
//
//  Created by Meenal Mahajan on 02/08/25.
//

import Foundation
import SwiftUI
import GoogleGenerativeAI

@Observable
class ChatService {
    
    private(set) var messages = [ChatMessage]()
    private(set) var loadingResponse = false
    private var model = GenerativeModel(name: "gemini-2.5-flash", apiKey: APIKEY.default)
    
    func sendMessage(message: String, media: [Media]) async {
        loadingResponse = true
        
        messages.append(.init(role: .user, message: message, media: media))
        messages.append(.init(role: .aiModel, message: "", media: nil))
        
        do{
           
            var chatMedia = [any ThrowingPartsRepresentable]()
            for mediaItem in media {
                if mediaItem.mimeType == "video/mp4" || mediaItem.mimeType == "text/plain" || mediaItem.mimeType == "application/pdf" {
                    chatMedia.append(ModelContent.Part.data(mimetype: mediaItem.mimeType, mediaItem.data))
                }else{
                    chatMedia.append(ModelContent.Part.jpeg(mediaItem.data))
                }
                
            }
            
            let response = try await model.generateContent(message,chatMedia)
            loadingResponse = false
            
            guard let text = response.text else{
                messages.append(.init(role: .aiModel, message: "Something went wrong!", media: nil))
                return
            }
            
            messages.removeLast()
            messages.append(.init(role: .aiModel, message: text, media: nil))
        }catch{
            loadingResponse = false
            messages.removeLast()
            messages.append(.init(role: .aiModel, message: "Something went wrong!", media: nil))
            print(error.localizedDescription)
        }
    }
}
