//
//  SplashScreenView.swift
//  Byte_Love
//
//  Created by Hiba Wajeeh on 24/08/2024.
//

import SwiftUI

struct SplashScreenView: View {
    @Binding var isActive: Bool

    var body: some View {
        ZStack {
            // Background Color or Image
            Color(hex: "#001514")
                .edgesIgnoringSafeArea(.all)
            
            // Splash Screen Content
            VStack {
                Image(systemName: "star.fill") // Replace with your own image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                
                Text("Welcome to Byte Love")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .onAppear {
            // Simulate a delay before transitioning
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = false
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(isActive: .constant(true))
    }
}
