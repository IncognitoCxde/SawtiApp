//
//  SawtiWidget.swift
//  SawtiWidget
//
//  Created by Ilmhona 10 on 22/11/24.
//

import WidgetKit
import Intents
import SwiftUI

// MARK: - Entry
struct SawtiWidgetEntry: TimelineEntry {
    let date: Date
}

// MARK: - Provider
struct SawtiWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> SawtiWidgetEntry {
        SawtiWidgetEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SawtiWidgetEntry) -> Void) {
        let entry = SawtiWidgetEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SawtiWidgetEntry>) -> Void) {
        let entry = SawtiWidgetEntry(date: Date())
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

// MARK: - Widget View
struct SawtiWidgetEntryView: View {
    var entry: SawtiWidgetEntry

    var body: some View {
        ZStack {
            Color("Milk")
                .ignoresSafeArea()
            VStack {
                Image("1984")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 80)
                    .cornerRadius(5)
                HStack {
                    Image(systemName: "book.fill")
                        .foregroundColor(Color("Brown"))
                        .font(.system(size: 18))
                    
                    Text("Continue Reading")
                        .foregroundColor(Color("Brown"))
                        .font(.custom("Inter24pt-Bold", size: 14))
                        .bold()
                }
            }
            .padding()
        }
    }
}

// MARK: - Main Widget

struct SawtiWidget: Widget {
    let kind: String = "SawtiWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SawtiWidgetProvider()) { entry in
            SawtiWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Sawti Widget")
        .description("Track your progress in the book.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Preview
struct SawtiWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        SawtiWidgetEntryView(entry: SawtiWidgetEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
