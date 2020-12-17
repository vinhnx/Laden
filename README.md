<h1 align="center">Laden</h1>
<p align="center">SwiftUI loading indicator view</p>
<p align="center"><img src="./Resources/loading.gif"/></p>

---

### Installation

Since this component is built using Swift Package Manager, it is pretty straight forward to use:

1. In Xcode (11+), open your project and navigate to File > Swift Packages > Add Package Dependency...
2. Paste the repository URL (https://github.com/vinhnx/Laden) and click Next.
3. For Rules, select Branch (with branch set to master).
4. Click Finish to resolve package into your Xcode project.

### Usage

At simplest form:

```swift
import SwiftUI
import Laden

struct ContentView: View {
    var body: some View {
        Laden.CircleLoadingView()
    }
}
```

---

To show loading view on top on current view by embedding inside a `ZStack`:

```swift
ZStack {
    Text("Some text") // your content view
    Laden.CircleOutlineLoadingView()
}
```

![ZStack](./Resources/loading_zstack.gif "ZStack")

---

To indicate loading state, have a private loading bool `@State` and bind it to Laden's `isAnimating` initialzier:

```swift
import SwiftUI
import Laden

struct ContentView: View {
    @State private var isLoading = true

    var body: some View {
        VStack {
            Laden.CircleLoadingView(isAnimating: isLoading)
            Button(isLoading ? "Stop loading" : "Start loading") {
                self.isLoading.toggle()
            }
        }
    }
}
```

---

To show or hide loading view, have a private show/hide bool `@State` and modify said loading with `.hidden` attribute, when toggled:

```swift
import SwiftUI
import Laden

struct ContentView: View {
    @State private var shouldLoadingView = true

    private var loadingView = SwiftUILoading.CircleOutlineLoadingView()

    var body: some View {
        VStack {
            if shouldLoadingView {
                loadingView
                    .hidden()
            } else {
                loadingView
            }

            Button(shouldCircleView ? "Show" : "Hide") {
                self.shouldLoadingView.toggle()
            }
        }
    }
}
```

---

To customize loading view color, use `color` initializer:

```swift
Laden.CircleOutlineLoadingView(color: .red)
```

---

### Help, feedback or suggestions?

Feel free to open issue or contact me on [Twitter](https://twitter.com/@vinhnx) for discussions, news & announcements & other projects. 🚀

I hope you like it! :)
