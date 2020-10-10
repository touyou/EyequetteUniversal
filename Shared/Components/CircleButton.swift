//
//  CircleButton.swift
//  EyequetteUniversal
//
//  Created by 藤井陽介 on 2020/10/10.
//

import SwiftUI

struct CircleButton: View {
    @State var isActive: Bool = false
    let activeColor: Color
    let inactiveColor: Color

    var body: some View {
        Button(action: {
            isActive.toggle()
        }) {
            Circle()
                .fill(isActive ? activeColor : inactiveColor)
                .frame(width: 100, height: 100)
        }
    }
}

struct CircleButton_Previews: PreviewProvider {

    @State static var isSelected = false

    static var previews: some View {
        CircleButton(activeColor: Color.red, inactiveColor: Color.blue)
    }
}
