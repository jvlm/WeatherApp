//
//  LocationWeatherView.swift
//  Weather
//
//  Created by Joao Melo on 03/05/23.
//

import SwiftUI

struct LocationWeatherView: View {
    var name: String = ""
    var temperature: Double = 99
    var background: String = ""
    
    var body: some View {
     
        ScrollView {
            HStack {
                Spacer()
                VStack {
                    Text(name)
                        .font(Font.system(size: 32))
                    Text(String(format: " %.0f°", temperature))
                        .font(Font.system(size: 100))
                        .fontWeight(.thin)
                }
                .shadow(radius: 5)
                .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, 50)
        }
        .padding(.top, 0.1)
        .background(
            Image(background)
        )
        
    }
}

struct LocationWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        LocationWeatherView()
    }
}
