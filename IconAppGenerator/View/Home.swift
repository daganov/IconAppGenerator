//
//  Home.swift
//  IconAppGenerator
//
//  Created by Denis Aganov on 16.05.2022.
//

import SwiftUI

struct Home: View {
    
    @StateObject var iconModel = IconViewModel()
    
    // MARK: Environment Values for adopting UI for dark/light mode
    @Environment(\.self) var env
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            if let image = iconModel.pickedImage {
                // MARK: Displaying Image with Action
                Group {
                    Image(nsImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipped()
                        .onTapGesture(perform: iconModel.pickImage)
                    
                    // MARK: Generate Button
                    Button {
                        iconModel.generateIconSet()
                    } label: {
                        Text("Создать набор иконок")
                            .foregroundColor(env.colorScheme == .dark ? .black : .white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 18)
                            .background(.primary, in: RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.top, 10)
                }
            } else {
                // MARK: Add Button
                ZStack {
                    Button {
                        iconModel.pickImage()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(env.colorScheme == .dark ? .black : .white)
                            .padding(15)
                            .background(.primary, in: RoundedRectangle(cornerRadius: 10))
                    }
                    
                    // Recommended Size Text
                    Text("Рекомендовано разрешение 1024 x 1024.")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
        }
        .frame(width: 400, height: 400)
        .buttonStyle(.plain)
        // MARK: Show Alert View
        .alert(iconModel.alertMsg, isPresented: $iconModel.showAlert) {
            
        }
        // MARK: Loading View
        .overlay {
            ZStack {
                if iconModel.isGenerating {
                    Color.black
                        .opacity(0.4)
                    
                    ProgressView()
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 10))
                    // Always Light Mode
                        .environment(\.colorScheme, .light)
                        
                }
            }
        }
        .animation(.easeInOut, value: iconModel.isGenerating)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
