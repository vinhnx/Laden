//
//  Created by Vĩnh Nguyễn on 12/15/20.
//

import SwiftUI

/// Loading view protocol that define default configurations.
public protocol LoadingAnimatable: View {
    /// Whether this loading view is animating.
    var isAnimating: Bool { get }

    /// Default color for loading view.
    var color: Color { get }

    /// The default size for loading view.
    var size: CGSize { get set }

    /// Default stroke line width for loading bar.
    var strokeLineWidth: CGFloat { get }
}

/// Loading view container, for namespacing.
public enum Laden {}

extension Laden {
    /// Circular loading view
    public struct CircleLoadingView: LoadingAnimatable {
        
        public var isAnimating: Bool = true
        public var color: Color = .green
        public var size: CGSize = CGSize(width: 30, height: 30)
        public var strokeLineWidth: CGFloat = 3
        
        /// The left lobe fraction of the loading bar.
        public var trimEndFraction: CGFloat = 0.8
        
        /// Current rotation value.
        @State private var rotation: Double = 0
        
        /// Timer that will continously draw the animation for loading view.
        private let timer = Timer
            .publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
        
        /// - Parameters:
        ///   - isAnimating: Whether this loading view is animating
        ///   - color: Default color for loading view.
        ///   - size: The default size for loading view.
        ///   - trimEndFraction: The left lobe fraction of the loading bar.
        ///   - strokeLineWidth: Default stroke line width for loading bar.
        public init(isAnimating: Bool = true, color: Color = .green, size: CGSize = CGSize(width: 30, height: 30), trimEndFraction: CGFloat = 0.8, strokeLineWidth: CGFloat = 8) {
            self.isAnimating = isAnimating
            self.color = color
            self.size = size
            self.trimEndFraction = trimEndFraction
            self.strokeLineWidth = strokeLineWidth
        }
        
        public var body: some View {
            Circle()
                .trim(from: 0, to: trimEndFraction)
                .stroke(color, lineWidth: strokeLineWidth)
                .frame(width: size.width, height: size.height)
                .rotationEffect(.degrees(rotation))
                .animation(isAnimating ? .linear : .none)
                .onReceive(timer) { _ in
                    if isAnimating { rotation += 36 }
                }
        }
    }
    
    /// Circular loading view with outline background
    public struct CircleOutlineLoadingView: LoadingAnimatable {
        public var isAnimating: Bool = true
        public var color: Color = .green
        public var size: CGSize = CGSize(width: 30, height: 30)
        public var strokeLineWidth: CGFloat = 8
        
        /// The left lobe fraction of the loading bar.
        public var trimEndFraction: CGFloat = 0.8
        
        /// Outline bar color.
        public var outlineBarColor: Color = Color(.systemGray5)
        
        /// Current rotation value.
        @State private var rotation: Double = 0
        
        /// Timer that will continously draw the animation for loading view.
        private let timer = Timer
            .publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
        
        /// - Parameters:
        ///   - isAnimating: Whether this loading view is animating
        ///   - color: Default color for loading view.
        ///   - size: The default size for loading view.
        ///   - trimEndFraction: The left lobe fraction of the loading bar.
        ///   - strokeLineWidth: Default stroke line width for loading bar.
        public init(isAnimating: Bool = true, color: Color = .green, size: CGSize = CGSize(width: 30, height: 30), strokeLineWidth: CGFloat = 8, trimEndFraction: CGFloat = 0.8) {
            self.isAnimating = isAnimating
            self.color = color
            self.size = size
            self.strokeLineWidth = strokeLineWidth
            self.trimEndFraction = trimEndFraction
        }
        
        public var body: some View {
            ZStack {
                Circle()
                    .stroke(outlineBarColor, lineWidth: strokeLineWidth)
                    .frame(width: size.width, height: size.height)
                
                Circle()
                    .trim(from: 0, to: trimEndFraction)
                    .stroke(color, lineWidth: strokeLineWidth / 2)
                    .frame(width: size.width, height: size.height)
                    .rotationEffect(.degrees(rotation))
                    .animation(isAnimating ? .linear : .none)
                    .onReceive(timer) { _ in
                        if isAnimating { rotation += 36 }
                    }
            }
        }
    }
    
    /// Reversible loading bar view.
    public struct BarLoadingView: LoadingAnimatable {
        public var isAnimating: Bool = true
        public var color: Color = .green
        public var size: CGSize = CGSize(width: 200, height: 30)
        public var strokeLineWidth: CGFloat = 3
        
        /// Outline bar color.
        public var outlineBarColor: Color = Color(.systemGray5)
        
        /// Current indicator view's x offset.
        @State private var offset: CGFloat = 0
        
        /// The caculated width of indicator view.
        private var indicatorWidth: CGFloat {
            size.width * 0.3
        }
        
        /// Timer that will continously draw the animation for loading view.
        private let timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
        
        /// - Parameters:
        ///   - isAnimating: Whether this loading view is animating
        ///   - color: Default color for loading view.
        ///   - size: The default size for loading view.
        ///   - strokeLineWidth: Default stroke line width for loading bar.
        public init(isAnimating: Bool = true, color: Color = .green, size: CGSize = CGSize(width: 200, height: 30), strokeLineWidth: CGFloat = 3) {
            self.isAnimating = isAnimating
            self.color = color
            self.size = size
            self.strokeLineWidth = strokeLineWidth
        }
        
        public var body: some View {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                RoundedRectangle(cornerRadius: strokeLineWidth)
                    .stroke(outlineBarColor, lineWidth: strokeLineWidth)
                    .frame(width: size.width, height: strokeLineWidth)
                
                RoundedRectangle(cornerRadius: strokeLineWidth)
                    .stroke(color, lineWidth: strokeLineWidth)
                    .frame(width: indicatorWidth, height: strokeLineWidth)
                    .offset(x: offset, y: 0)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
                    .onReceive(timer) { _ in
                        if isAnimating { offset = size.width - indicatorWidth }
                    }
            }
        }
    }
}

struct Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 50) {
            Laden.BarLoadingView(color: .red)
            Laden.CircleLoadingView(color: .green)
            Laden.CircleOutlineLoadingView(color: .orange)
        }
    }
}
