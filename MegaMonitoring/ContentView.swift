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
    
    struct GauageTemp {
        var id = UUID() // Use UUID as the identifier
        var subtitle: String
    }
    
    struct GauageExample: View {
        var celsius: GauageTemp // Correct the spelling of GaugeTemp
        
        private let minValue = 16.0
        private let maxValue = 25.0
        
        let gradient = Gradient(colors: [.blue, .green, .orange])
        
        var body: some View {
            VStack {
                Gauge(value: Double(celsius.subtitle) ?? 0, in: minValue...maxValue) { // Convert the subtitle to a Double
                    Label("Temperature (°C)", systemImage: "thermometer.medium")
                } currentValueLabel: {
                    Text("\(celsius.subtitle)°")
                        .foregroundColor(.green)
                } minimumValueLabel: {
                    Text("16")
                        .foregroundColor(.blue)
                } maximumValueLabel: {
                    Text("25")
                        .foregroundColor(.orange)
                }
                .tint(gradient)
            }
            .gaugeStyle(.accessoryCircular)
        }
    }
    
    struct GauageExampleHu: View {
        var hu: GauageTemp // Correct the spelling of GaugeTemp
        
        private let minValue = 0.0
        private let maxValue = 100.0
        
        let gradient = Gradient(colors: [.blue, .green, .orange])
        
        var body: some View {
            VStack {
                Gauge(value: Double(hu.subtitle) ?? 0, in: minValue...maxValue) { // Convert the subtitle to a Double
                    Label("hu (%)", systemImage: "humidity").foregroundColor(.green)
                } currentValueLabel: {
                    Text("\(hu.subtitle)%")
                        .foregroundColor(.green)
                }
                .tint(gradient)
            }
            .gaugeStyle(.accessoryCircular)
        }
    }
    
    var annotations: [AnnotationItem] {
        // Generate map annotations based on the selected filter
        if selectedFilter == "Temperature" {
            return [
                AnnotationItem(annotation: makeAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), subtitle: "18")),
                AnnotationItem(annotation: makeAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.600000, longitude: 127.000000), subtitle: "24"))
            ]
        } else if selectedFilter == "Humidity" {
            return [
                AnnotationItem(annotation: makeAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), subtitle: "60")),
                AnnotationItem(annotation: makeAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.600000, longitude: 127.000000), subtitle: "55"))
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
                    
                    Picker("Choose a filter", selection: $selectedFilter
                    ) {
                                            ForEach(filters, id: \.self) { filter in
                                                Text(filter)
                                            }
                                        }
                                        .pickerStyle(SegmentedPickerStyle())
                                        .frame(width: geometry.size.width * 0.9) // Set picker width to 90% of the available width
                                        
                                        Spacer()
                                        Map(coordinateRegion: $region, annotationItems: annotations) { item in
                                            MapAnnotation(coordinate: item.annotation.coordinate) {
                                                VStack {
                                                    if selectedFilter == "Temperature" {
                                                        GauageExample(celsius: GauageTemp(subtitle: item.annotation.subtitle ?? "")) // Pass the subtitle value to GaugeExample
                                                    } else if selectedFilter == "Humidity" {
                                                        GauageExampleHu(hu: GauageTemp(subtitle: item.annotation.subtitle ?? "")) // Pass the subtitle value to GaugeExample
                                                    }
                                                    
                                    
                                                }
                                                .padding(4)
                                                .background(Color.white)
                                                .cornerRadius(100)
                                                .shadow(radius: 4)
                                            }
                                        }
                                        
                                    }
                                    .sheet(isPresented: $showAddPage) {
                                        AddPage() // Show the add page when the state is true
                                    }
                                }
                            }
                        }
                        
                        private func makeAnnotation(coordinate: CLLocationCoordinate2D, subtitle: String) -> MKPointAnnotation {
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = coordinate
                            annotation.subtitle = subtitle
                            return annotation
                        }
                    }

                    struct AddPage: View {
                        var body: some View {
                            VStack {
                                List {
                                    Section(header: Text("Scanned by Wi-Fi")) {
                                        Text("Staria Device")
                                        Text("Staria Device")
                                    }
                                }
                            }
                        }
                    }
