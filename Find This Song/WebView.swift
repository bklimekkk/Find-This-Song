//
//  WebView.swift
//  Find This Song
//
//  Created by Bartosz Klimek on 10/08/2022.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
