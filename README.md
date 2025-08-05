# 📱 Gemini Multimodal Chat App (SwiftUI)

An iOS Chat UI powered by Google's **Gemini 2.5 Flash** model, built with **SwiftUI**. This project supports **multimodal inputs**, allowing users to send text, images, videos, and PDFs to the Gemini model and get intelligent responses.
---

## 🚀 Features

- ✅ Chat with **Gemini 2.5 Flash** using `generateContent` API
- 🧠 **Text + Multimodal** Input (Images, Videos, PDFs, Text Files)
- ⚡️ Modern SwiftUI interface
- 🖼️ Dynamic thumbnails for uploaded media
- 💬 Async messaging with real-time response handling
- 📁 File type detection and MIME handling

---

## 🛠 Tech Stack

- **SwiftUI** – Modern declarative UI framework
- **Gemini API (Google AI Client)** – For LLM interaction
- **Combine / async-await** – Smooth async data flow
- **UIKit Integration** – For media pickers when needed

---

## 📦 Supported Media Types

| Type     | Description                     |
|----------|---------------------------------|
| 📝 Text   | Natural language queries        |
| 🖼️ Image  | JPEG and PNG formats            |
| 📹 Video  | MP4 and MOV formats             |
| 📄 PDF    | Documents & text files (UTF-8)  |

---
