//
//  ContentView.swift
//  MegaMonitoring
//
//  Created by Nestor Adrian Sandoval Ortiz on 10/06/23.
//

import SwiftUI
import MapKit


struct ContentView: View {
    @State private var choices = ["All", "Missed"]
    @State private var choice = 0
    @State var selectedFilter = "Temperature"
    var filters = ["Temperature", "Humidity"]
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @State private var contacts = [("Anna Lisa Moreno", "9:40 AM"), ("Justin Shumaker", "9:35 AM")]
    
    @State private var showAddPage = false // Track the state of the add page
    
    struct AnnotationItem: Identifiable {
        let id = UUID()
        let annotation: MKPointAnnotation
    }
    
    var annotations: [AnnotationItem] {
        // Generate map annotations based on the selected filter
        if selectedFilter == "Temperature" {
            return [
                AnnotationItem(annotation: makeAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), title: "Location 1", subtitle: "Temperature: 25°C")),
                AnnotationItem(annotation: makeAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.600000, longitude: 127.000000), title: "Location 2", subtitle: "Temperature: 28°C"))
            ]
        } else if selectedFilter == "Humidity" {
            return [
                AnnotationItem(annotation: makeAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), title: "Location 1", subtitle: "Humidity: 60%")),
                AnnotationItem(annotation: makeAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.600000, longitude: 127.000000), title: "Location 2", subtitle: "Humidity: 55%"))
            ]
        } else {
            return []
        }
    }
    
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
                            showAddPage = true // Set the state to true to navigate to the add page
                        }
                    }
                    .padding(.trailing) // Add padding to align the "Add" button to the right
                    .padding(.bottom) // Add padding below the "Add" button
                    
                    Picker("Choose a filter", selection: $selectedFilter) {
                        ForEach(filters, id: \.self) { filter in
                            Text(filter)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: geometry.size.width * 0.9) // Set segment control width to 90% of the available width
                    
                    Spacer()
                    Map(coordinateRegion: $region, annotationItems: annotations) { item in
                        MapAnnotation(coordinate: item.annotation.coordinate) {
                            VStack {
                                Text(item.annotation.title ?? "")
                                    .font(.headline)
                                Text(item.annotation.subtitle ?? "")
                                    .font(.subheadline)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                        }
                    }


                    
                    // List {
                    //     Text("asdas")
                    // }
                }
                .sheet(isPresented: $showAddPage) {

                    AddPage() // Show the add page when the state is true
                }
            }
        }
    }
    
    private func makeAnnotation(coordinate: CLLocationCoordinate2D, title: String,
 subtitle: String) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        return annotation
    }
}

struct AddPage: View {
    var body: some View {
        VStack {
            List {
                Section(header: Text("Scaned by wifi"))
 {
                     Text("Staria Device")
                     Text("Staria Device")
                      }
       
             }
        }

    }
}
