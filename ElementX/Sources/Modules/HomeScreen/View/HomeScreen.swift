// 
// Copyright 2021 New Vector Ltd
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI
import Kingfisher

struct HomeScreen: View {
    
    @ObservedObject var context: HomeScreenViewModel.Context
    
    // MARK: Views
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16.0) {
                if context.viewState.isLoadingRooms {
                    VStack {
                        Text("Loading rooms")
                        ProgressView()
                    }
                } else {
                    List {
                        Section("People") {
                            ForEach(context.viewState.firstDirectRooms) { room in
                                RoomCell(room: room, context: context)
                            }
                            
                            let other = context.viewState.otherDirectRooms
                            
                            if other.count > 0 {
                                DisclosureGroup("See more") {
                                    ForEach(other) { room in
                                        RoomCell(room: room, context: context)
                                    }
                                }
                            }
                        }
                        
                        Section("Rooms") {
                            ForEach(context.viewState.firstNondirectRooms) { room in
                                RoomCell(room: room, context: context)
                            }
                            
                            let other = context.viewState.otherNondirectRooms
                            
                            if other.count > 0 {
                                DisclosureGroup("See more") {
                                    ForEach(other) { room in
                                        RoomCell(room: room, context: context)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                
                Spacer()
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        if let avatar = context.viewState.userAvatar {
                            Image(uiImage: avatar)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40, alignment: .center)
                                .mask(Circle())
                        } else {
                            let _ = context.send(viewAction: .loadUserAvatar)
                        }
                        Text("Hello, \(context.viewState.userDisplayName)!")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        context.send(viewAction: .logout)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RoomCell: View {
    
    let room: HomeScreenRoom
    let context: HomeScreenViewModel.Context
    
    var body: some View {
        HStack(spacing: 16.0) {
            if let avatar = room.avatar {
                Image(uiImage: avatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .mask(Circle())
            } else {
                let _ = context.send(viewAction: .loadRoomData(roomId: room.id))
                Image(systemName: "person.3")
                    .frame(width: 40, height: 40)
            }
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text(roomName(room))
                    .font(.headline)
                    .fontWeight(.regular)
                
                if let roomTopic = room.topic, roomTopic.count > 0 {
                    Text(roomTopic)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
                
                if let lastMessage = room.lastMessage {
                    Text(lastMessage)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .lineLimit(1)
                }
            }
        }
        .frame(minHeight: 60.0)
    }
    
    private func roomName(_ room: HomeScreenRoom) -> String {
        room.displayName ?? room.id + (room.isEncrypted ? "🛡": "")
    }
}

// MARK: - Previews

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeScreenViewModel(userDisplayName: "Johnny Appleseed", imageCache: ImageCache.default)
        
        let rooms = [MockRoomModel(displayName: "Alfa"),
                     MockRoomModel(displayName: "Beta"),
                     MockRoomModel(displayName: "Omega")]
        
        viewModel.updateWithRoomList(rooms)
        
        viewModel.updateWithUserAvatar(UIImage(systemName: "person.fill.questionmark"))
        
        return HomeScreen(context: viewModel.context)
    }
}
