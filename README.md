# SwiftUI Dialog Structure
> 처음에 SwiftUI 에서 Dialog 사용 시 showDialogFlag 파라미터를 만들고 파라미터를 통해 ZStack 안에서 표기하는 방식으로 구현했었다. 굉장히 불편하고 관리가 힘들었다. 그래서 "Dialog 를 공통화처리하려면 어떻게 해야될까"를 고민하다가 나오게된 결과물이다.

<br>

## GIF
![ScreenRecording_10-30-2024 10-23-33_1](https://github.com/user-attachments/assets/cf9e3e5e-ca62-46e2-945a-094618fcab08)

<br>

## 사용법

```swift

struct ContentView: View {
    
    @EnvironmentObject var dialogData: DialogData
    
    var body: some View {
        Button("show dialog") {
          dialogData.dialogModel = DialogModel(title: title,
                                             contents: contents,
                                             cancelBtnTitle: cancelBtnTitle,
                                             okBtnTitle: okBtnTitle,
                                             cancel: true) { text in
                if text == nil {
                    // cancel action
                } else {
                    // ok action
                }
            }
        }
    }
```

<br>

## 구조
- iOS 16 이상 지원하는 NavigationPath 로 구현된 예제이다.
- navigationDestination(isPresented) 을 사용해도 동일하게 동작한다.
- 최상단에 표기해야될 View 가 있다면 이 방식으로 처리하면 편했다. 예를 들어 API Progress Bar 가 있다.


### NavigationRootView
- Navigation Stack 에 가장 하단 있는 View 이다.
- Dialog 를 표기하는 View 이다.
- fullScreenCover(isPresented) 를 통해 새로운 View 로 이동 시 이동한 View 에 NavigationRootView 로 구현되어야 Dialog 가 정상적으로 나타난다. 

```swift
struct NavigationRootView<T: View>: View {
    
    @EnvironmentObject var dialogData: DialogData
    @State var isShow = false
    
    let contents: T
    
    init(@ViewBuilder _ contents: () -> T) {
        self.contents = contents()
    }

    var body: some View {
        ZStack {
            
            ZStack {
                contents
            } // : ZS
            
            ZStack {
                if isShow {
                    if dialogData.show,
                       let dialogModel = dialogData.dialogModel {
                        AsuDialog(model: dialogModel)
                            .id(dialogModel.uuid)
                    }

                }
            } // : ZS
            .ignoresSafeArea()
        } // : ZS
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .onAppear {
            isShow = true
        }
        .onDisappear {
            isShow = false
        }
    }
}
```

- 사용법
```
struct ContentView: View {
    
    @EnvironmentObject var dialogData: DialogData
    @EnvironmentObject var navigationData: NavigationData
    
    var body: some View {
        NavigationRootView() {
            // add View
        }
    }
}
```

<br>

## 문제점
- 다이얼로그 UI 가 다른 경우 위와 같은 구조로 추가해주어야 한다.
- 동일한 UI 다이얼로그는 동시에 하나만 표기가능하다.


