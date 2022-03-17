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
    @Environment(\.colorScheme) var systemColorScheme
    @State var myColorScheme: ColorScheme?
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        
                        Text("Time to update: \(viewModel.data?.time.updated ?? "")")
                        Text("Actual rate: \(viewModel.data?.bpi.usd.rate ?? "") \(viewModel.data?.bpi.usd.code ?? "")")
                        Spacer()
                        
                        Button(action: viewModel.updateData) {
                            Image(systemName: "plus")
                        }
                        
                        LineView(data: viewModel.chart, title: "Price chart")
                    }
                    .onAppear(perform: viewModel.updateData)
                }
                .padding()
                Spacer()
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
