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
    
}
