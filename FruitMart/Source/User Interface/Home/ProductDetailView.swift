//
//  ProductDetailView.swift
//  FruitMart
//
//  Created by Yukyung Huh on 10/24/23.
//  Copyright © 2023 Giftbot. All rights reserved.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    var body: some View {
        VStack(spacing: 0) {
            productImage // 상품 이미지
            orderView // 상품 정보를 출력하고 그 상품을 주문하기 위한 뷰
        }.edgesIgnoringSafeArea(.top)
    }
}

private extension ProductDetailView {
    var productImage: some View {
        GeometryReader { _ in
            Image(self.product.imageName)
                .resizable()
                .scaledToFill()
        }
    }
    
    var orderView: some View { // 상품 설명과 주문하기 버튼 등을 모두 포함하는 컨테이너
        GeometryReader {
            VStack(alignment: .leading) {
                self.productDescription // 상품명과 즐겨찾기 버튼
                Spacer()
                self.priceInfo
                self.placeOrderButton
            }
            .frame(height: $0.size.height + 10)
            .padding(32)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
        }
    }
    
    var productDescription: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack{
                Text(product.name) // 상품명
                    .font(.largeTitle).fontWeight(.medium)
                    .foregroundColor(.black)
                Spacer()
                
                Image(systemName: "heart") // 즐겨찾기 버튼
                    .imageScale(.large)
                    .foregroundColor(Color.peach)
                    .frame(width: 32, height: 32)
            }
            
            Text(splitText(product.description))
                .foregroundColor(.secondaryText)
                .fixedSize()
        }
    }
    
    var priceInfo: some View {
        HStack {
            (Text("₩") // 통화 기호는 작게 나타내고 가격만 더 크게 표시
             + Text("\(product.price)").font(.title)
            ).fontWeight(.medium)
            Spacer()
            // 수량 선택 버튼이 들어갈 위치 - 챕터 5에서 구현 예정
        }
        .foregroundColor(.black)
    }
    
    var placeOrderButton: some View {
        Button(action: {}) {
            Capsule()
                .fill(Color.peach)
                // 너비는 주어진 공간을 최대로 사용하고 높이는 최소, 최대치 지정
                .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
                .overlay(Text("주문하기").font(.system(size: 20)).fontWeight(.medium).foregroundColor(Color.white))
                .padding(.vertical, 8)
        }
    }
    
    func splitText(_ text: String) -> String {
        guard !text.isEmpty else { return text }
        let centerIdx = text.index(text.startIndex, offsetBy: text.count / 2)
        let centerSpaceIdx = text[..<centerIdx].lastIndex(of: " ") ?? text[centerIdx...].firstIndex(of: " ") ?? text.index(before: text.endIndex)
        let afterSpaceldx = text.index(after: centerSpaceIdx)
        let lhsString = text[..<afterSpaceldx].trimmingCharacters(in: .whitespaces)
        let rhsString = text[afterSpaceldx...].trimmingCharacters(in: .whitespaces)
        return String(lhsString + "\n" + rhsString)
    }
}

#Preview {
    ProductDetailView(product: productSamples[0])
}
