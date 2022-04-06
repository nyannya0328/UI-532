//
//  Home.swift
//  UI-532
//
//  Created by nyannyan0328 on 2022/04/06.
//

import SwiftUI

struct Home: View {
    @State var showDetail : Bool = false
    @State var currentItem : Today?
    @Namespace var animation
    @State var scrollOffset : CGFloat = 0
    
    
    @State var animationView : Bool = false
    
    @State var animationContent : Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:0){
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 13) {
                        
                        Text("Monday 4 April")
                            .font(.title3.bold())
                            .foregroundColor(.gray)
                        
                        Text("Today")
                            .font(.largeTitle.bold())
                        
                        
                    }
                    .frame(maxWidth:.infinity,alignment: .leading)
                    
                    
                    Button {
                        
                    } label: {
                        
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                    }

                    
                }
                .padding(.bottom)
                .padding(.horizontal)
                .opacity(showDetail ? 0 : 1)
                
                
                ForEach(todayItems){today in
                    
                    
                    
                    Button {
                        
                        withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)){
                            
                            currentItem = today
                            showDetail = true
                            
                        }
                        
                    } label: {
                        
                        
                        cardView(today: today)
                            .scaleEffect(currentItem?.id == today.id && showDetail ? 1 : 0.95)
                        
                    }
                    .buttonStyle(buttonModifier())
                    .opacity(showDetail ? (currentItem?.id == today.id ? 1 : 0) : 1)
                    .zIndex(currentItem?.id == today.id && showDetail ? 10 : 0)

                }
                
                
            
                
                
                
                
                
                
            }
            .padding(.vertical)
        }
        .overlay {
            
            if let currentItem = currentItem,showDetail {
                
                DetailView(today: currentItem)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
        .background(alignment: .top) {
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color("BG"))
                .frame(height: animationView ? nil : 350, alignment: .top)
                .scaleEffect(animationView ? 1 : 0.93)
                .opacity(animationView ? 1 : 0)
                .ignoresSafeArea()
                
            
            
        }
    }
    @ViewBuilder
    func cardView(today : Today)->some View{
        
        VStack(alignment: .leading, spacing: 15) {
            
            ZStack(alignment:.topLeading){
                
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    
                    Image(today.artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(CustomCorner(coner: [.topLeft,.topRight], radi: 30))
                }
                .frame(height:400)
                
                LinearGradient(colors: [
                
                    .black.opacity(0.3),
                    .gray.opacity(0.3),
                    .black.opacity(0.3),
                
                
                ], startPoint: .top, endPoint: .bottom)
                
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(today.platformTitle.uppercased())
                        .font(.callout.weight(.semibold))
                    
                    
                    Text(today.platformTitle)
                        .font(.largeTitle.weight(.black))
                    
                    
                }
                .padding([.leading,.top])
                .offset(y: currentItem?.id == today.id && animationView ? getSafeArea().top : 0)
                
                
              
                
                
                
            }
            
            HStack(spacing:20){
                
                
                Image(today.appLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                
                
                VStack(alignment: .leading, spacing: 13) {
                    
                    Text(today.platformTitle)
                        .foregroundColor(.gray)
                    
                    
                    Text(today.appName)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                    
                    Text(today.appDescription)
                        .foregroundColor(.gray)
                    
                    
                    
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                
                
                Button {
                    
                } label: {
                    
                    
                    Text("GET")
                        .font(.caption)
                        .padding(.vertical,7)
                        .padding(.horizontal,15)
                        .background(
                        
                        Capsule()
                            .fill(.ultraThinMaterial)
                        
                        )
                }

                
            }
            .padding([.horizontal,.bottom])
            
            
        }
        .background(
        
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color("BG"))
        )
        .matchedGeometryEffect(id: today.id, in: animation)
      
        
        
        
        
    }
    
    @ViewBuilder
    func DetailView(today : Today) -> some View{
        
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack{
                
                cardView(today: today)
                    .scaleEffect(animationView ? 1 : 0.95)
                
                
                VStack(spacing:15){
                    
                    Text(dummyText)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(15)
                    
                    
                    Divider()
                        .background(.orange)
                    
                    
                    Button {
                        
                        
                    } label: {
                        
                        
                        Label {
                            Text("Share Story")
                                
                        } icon: {
                            Image(systemName: "square.and.arrow.up.fill")
                        }

                    }
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .background(
                    
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.ultraThinMaterial)
                    
                    )

                    
                }
                .padding()
                .offset(y: scrollOffset > 0 ? scrollOffset : 0)
                .opacity(animationContent ? 1 : 0)
               .scaleEffect(animationView ? 1 : 0,anchor: .top)
                
            }
            .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            .offset(offset: $scrollOffset)
          
        })
      
        .coordinateSpace(name: "SCROLL")
        .overlay(alignment: .topTrailing, content: {
            
            Button {
                
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                    
                    
                    animationView = false
                    animationContent = false
                }
                
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                    
                    showDetail = false
                    currentItem = nil
                }
                
                
            } label: {
                
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
           
            .padding(.top,getSafeArea().top)
            .offset(x: -10)
            .opacity(animationView ? 1 : 0)
            

            
        })
        .onAppear {
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                
                
                animationView = true
            }
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                
                
                animationContent = true
            }
        }
        .transition(.identity)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

extension View{
    
    func getSafeArea()->UIEdgeInsets{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return .zero}
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {return .zero}
        
        return safeArea
        
    }
    
    func offset(offset : Binding<CGFloat>) -> some View{
        
        
        return self
            .overlay {
                GeometryReader{proxy in
                    
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                }
                .onPreferenceChange(OffsetKey.self) { value in
                    
                    offset.wrappedValue = value
                }
                
            }
    }
    
    
    
}

struct OffsetKey : PreferenceKey{
    
  static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct buttonModifier : ButtonStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
            
    }
}
