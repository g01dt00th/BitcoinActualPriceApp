//
//  ContentView.swift
//  BitcoinActualPrice
//
//  Created by dan4 on 09.03.2022.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State var countTimer = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.colorScheme) var systemColorScheme
    @State var myColorScheme: ColorScheme?
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        
                        Text("Time to update: \(viewModel.data?.time.updated ?? "")")
                            .onReceive(timer) { _ in
                                if countTimer != 60{
                                    countTimer += 1
                                    if countTimer == 60 {
                                        viewModel.updateData()
                                        countTimer = 0
                                    }
                                }
                            }
                        Text("Actual rate: \(viewModel.data?.bpi.usd.rate ?? "") \(viewModel.data?.bpi.usd.code ?? "")")
                        Spacer()
                        LineView(data: viewModel.chart, title: "Price chart")
                    }
                    .onAppear(perform: viewModel.updateData)
                }
                .padding()
            }
            .navigationBarItems(leading: Text("Bitcoin price").font(.title2).bold(), trailing: NavigationLink("⚙", destination: SettingsView(colorScheme: $myColorScheme)))
            .navigationBarTitleDisplayMode(.inline)
        }
        .colorScheme(myColorScheme ?? systemColorScheme)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
