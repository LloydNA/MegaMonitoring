//
//  ContentView.swift
//  MegaMonitoring
//
//  Created by Nestor Adrian Sandoval Ortiz on 10/06/23.
//

import SwiftUI
import MapKit

struct AddView: View {
    @State private var choices = ["All", "Missed"]
    @State private var choice = 0
    @State var selectedFilter = "Temperature"
    var filters = ["Temperature", "Humidity"]
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @State private var contacts = [("Anna Lisa Moreno", "9:40 AM"), ("Justin Shumaker", "9:35 AM")]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Status")
                        Spacer()
                        Button("Add") {
                            // do stuff
                        }
                    }
                    .padding(.trailing) // Add padding to align the "Add" button to the right
                    .padding(.bottom) // Add padding below the "Add" button
                    
                
                    
                     List {
                         Text("asdas")
                     }
                }
            }
        }
    }
}

