//
//  AsyncImageView.swift
//  
//
//  Created by Tamás Nieszner on 2021. 11. 04..
//

import SwiftUI

struct AsyncImageView: View {
    // MARK: - Properties
    private let imageURL: String = "https://credo.academy/credo-academy@3x.png"
    
    // MARK: - Body
    var body: some View {
        AsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
            switch phase {
            case .success(let image):
                image
                    .imageModifiers()
                    .transition(.scale)
            case .failure(_):
                Image(systemName: "xmark.circle.fill").iconModifiers()
            case .empty:
                Image(systemName: "photo.circle.fill").iconModifiers()
            @unknown default:
                ProgressView()
            }
        }
        .padding(40)
    }
}

// MARK: - Extensions
extension Image {
    func imageModifiers() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifiers() -> some View {
        self
            .imageModifiers()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}

// MARK: - Previews
struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView()
    }
}
