/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

#include "glean/private/ping.h"
#if not(defined(MVPN_WASM) || defined(BUILD_QMAKE))
#  include "vpnglean.h"
#endif

Ping::Ping(int aId) : m_id(aId) {}

void Ping::submit() const {
#if not(defined(MVPN_WASM) || defined(BUILD_QMAKE))
  glean_submit_ping_by_id(m_id);
#endif
}
