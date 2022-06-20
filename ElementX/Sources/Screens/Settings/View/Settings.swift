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

struct Settings: View {

    // MARK: Private

    @State private var showingLogoutConfirmation = false
    
    // MARK: Public
    
    @ObservedObject var context: SettingsViewModel.Context
    
    // MARK: Views
    
    var body: some View {
        Form {
            Section {
                Button { context.send(viewAction: .reportBug) } label: {
                    Text(ElementL10n.sendBugReport)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .accessibilityIdentifier("reportBugButton")

                if BuildSettings.settingsCrashButtonVisible {
                    Button("Crash the app",
                           role: .destructive,
                           action: { context.send(viewAction: .crash) })
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .accessibilityIdentifier("crashButton")
                }
            }

            Section {
                Button { showingLogoutConfirmation = true } label: {
                    Text(ElementL10n.actionSignOut)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .accessibilityIdentifier("logoutButton")
                .confirmationDialog(ElementL10n.actionSignOutConfirmationSimple,
                                    isPresented: $showingLogoutConfirmation,
                                    titleVisibility: .visible) {
                    Button(ElementL10n.actionSignOut,
                           role: .destructive,
                           action: { context.send(viewAction: .logout) })
                }
            }
        }
        .navigationTitle(ElementL10n.settings)
    }
}

// MARK: - Previews

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let viewModel = SettingsViewModel()
            Settings(context: viewModel.context)
                .previewInterfaceOrientation(.portrait)
        }
    }
}
