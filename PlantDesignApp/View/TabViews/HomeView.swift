//
//  HomeView.swift
//  PlantDesignApp
//
//  Created by Carlos Mendez on 9/4/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var currentIndex: Int = 0
    
    @State var showDetailView: Bool = false
    @State var currentDetailPlant: Plant?
    @Namespace var animation
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 15){
                HeaderView()
                
                SearchView()
                
                PlantView()
            }
            .padding(15)
            // MARK: Tab bar padding(since tab view is in the zstack)
            .padding(.bottom, 50)
        }
        .overlay{
            if let currentDetailPlant, showDetailView{
                DetailView(showView: $showDetailView, animation: animation, plant: currentDetailPlant)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(x: 0.5)))
            }
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View{
        HStack{
            VStack(alignment: .leading, spacing: 7){
                Text("Welcome")
                    .font(.title)
                    .foregroundColor(.black)
                Text("Name")
                    .font(.title.bold())
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button{
                
            }label: {
                Image(systemName: "bell")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(17)
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                    }
                    .overlay(alignment: .topTrailing){
                        Text("1")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(6)
                            .background{
                                Circle()
                                    .fill(Color("Green"))
                            }
                            .offset(x: 5, y: -10)
                    }
            }
        }
    }
    
    @ViewBuilder
    func SearchView() -> some View {
        HStack(spacing: 15){
            HStack(spacing: 15){
                Image("Search")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                
                Divider()
                    .padding(.vertical, -6)
                
                TextField("search", text: .constant(""))
                
            }
            .padding(15)
            .background{
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.white)
            }
            
            Button{
                
            } label: {
                Image("Filter")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 22, height: 22)
                    .padding(15)
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.black)
                    }
            }
        }
        .padding(.top,15)
    }
    
    @ViewBuilder
    func PlantView() -> some View{
        VStack(alignment: .center, spacing: 15){
            HStack(alignment: .center, spacing: 15){
                Image("Grid")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 13, height: 13)
                
                Text("Most Popular")
                    .font(.title3)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button("Show All"){
                    
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            .padding(.leading, 5)
            
            CustomCarousel(index: $currentIndex, items: plants, spacing: 25, cardPadding: 90, id: \.id){ plant, size in
                PlantCardView(plant: plant, size: size)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        hideTabBar()
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)){
                            currentDetailPlant = plant
                            showDetailView = true
                        }
                    }
            }
            .frame(height: 380)
            .padding(.top, 20)
            .padding(.horizontal, 10)
        }
        .padding(.top, 22)
    }
    
    @ViewBuilder
    func PlantCardView(plant: Plant, size: CGSize) -> some View{
        ZStack{
            LinearGradient(colors: [Color("Card Top"), Color("Card Bottom")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            VStack{
                Button {
                    
                } label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.title3)
                        .foregroundColor(Color("Green"))
                        .frame(width: 50, height: 50)
                        .background{
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.white)
                        }
                }
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .padding(15)
                
                VStack{
                    if currentDetailPlant?.id == plant.id && showDetailView{
                        Rectangle()
                            .fill(.clear)
                    }else{
                        Image(plant.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: plant.id, in: animation)
                            .padding(.bottom, -35)
                            .padding(.top, -40)
                    }
                }
                    .zIndex(1)
                
                HStack{
                    VStack(alignment: .leading, spacing: 7){
                        Text(plant.plantName)
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text(plant.price)
                            .font(.title3)
                            .fontWeight(.black)
                            .foregroundColor(.black)
                    }
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button{
                        
                    } label: {
                        Image("Cart")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                            .background{
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(.black)
                            }
                    }
                }
                .padding([.horizontal, .top], 15)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                .padding(10)
                .zIndex(0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
