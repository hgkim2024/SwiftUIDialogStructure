//
//  ContentView.swift
//  SwiftUIDialogStructure
//
//  Created by 김현구 on 10/29/24.
//

import SwiftUI

enum NavigationStackType: String {
    case first
    case second
    case third
}

struct ContentView: View {
    
    @EnvironmentObject var dialogData: DialogData
    @EnvironmentObject var navigationData: NavigationData
    
    var body: some View {
        NavigationRootView() {
            NavigationStack(path: $navigationData.path) {
                VStack {
                    Text("최상위 뷰")
                        .navigationTitle("Home")
                    
                    Button("첫 번째 이동") {
                        navigationData.append(.first)
                    }
                    
                    Button("두 번째 이동") {
                        navigationData.append(.second)
                    }
                    Button("show dialog") {
                        showDialog()
                    }
                }
                .navigationBarHidden(true)
                .navigationDestination(for: String.self) { value in
                    let type = NavigationStackType(rawValue: value)
                    
                    switch type {
                    case .first:
                        NavigationStackView() {
                            VStack {
                                AsuNavigationBar(title: "첫 번째 뷰", action: {
                                    navigationData.clear()
                                })
                                Spacer()
                                Text("첫 번째 뷰")
                                
                                Button("두 번째 이동") {
                                    navigationData.append(.second)
                                }
                                
                                Button("모두 지우기") {
                                    navigationData.path.removeLast(navigationData.path.count)
                                }
                                
                                Button("하나 지우기") {
                                    navigationData.path.removeLast()
                                }
                                Button("show dialog") {
                                    showDialog()
                                }
                                Spacer()
                            }
                        }
                    case .second:
                        NavigationStackView() {
                            VStack {
                                AsuNavigationBar(title: "두 번째 뷰", action: {
                                    navigationData.path.removeLast()
                                })
                                Spacer()
                                Text("두 번째 뷰")
                                Button("세 번째 이동") {
                                    navigationData.append(.third)
                                }
                                Button("모두 지우기") {
                                    navigationData.clear()
                                }
                                Button("하나 지우기") {
                                    navigationData.path.removeLast()
                                }
                                Button("show dialog") {
                                    showDialog()
                                }
                                Spacer()
                            }
                        }
                    case .third:
                        NavigationStackView() {
                            VStack {
                                AsuNavigationBar(title: "세 번째 뷰", action: {
                                    navigationData.path.removeLast()
                                })
                                Spacer()
                                Text("세 번째 뷰")
                                Button("모두 지우기") {
                                    navigationData.clear()
                                }
                                Button("두개 지우기") {
                                    navigationData.path.removeLast(2)
                                }
                                Button("첫 번째로 이동") {
                                    navigationData.removePaths(.first)
                                }
                                Button("하나 지우기") {
                                    navigationData.path.removeLast()
                                }
                                Button("show dialog") {
                                    showDialog()
                                }
                                Spacer()
                            }
                        }
                    case .none:
                        Text("")
                    }
                }
            }
        }
    }
    
    func showDialog() {
        dialogData.dialogModel = DialogModel.mock
    }
}

struct AsuNavigationBar: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 0) {
                Image(.left_chevron)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 9)
                Text(title)
                    .asuFont(.subtitle2)
                    .padding(.vertical, 3.5)
                Spacer()
            }
            .foregroundColor(asu: .textNormal)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .background(.white)
    }
}

#Preview {
    ContentView()
        .environmentObject(DialogData.mock)
        .environmentObject(NavigationData.mock)
}
