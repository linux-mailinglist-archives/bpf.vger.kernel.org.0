Return-Path: <bpf+bounces-70810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC3BD572F
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 19:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F03425689
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A798129D266;
	Mon, 13 Oct 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Luaek1lw"
X-Original-To: bpf@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D187298CA7;
	Mon, 13 Oct 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374309; cv=none; b=OUNsj85glo1x8YzHpWcMZQuytuVxxPPbxd3Warf8E+xMU5sB1Ql8LpRqoptxknpdqS/71RaTZsFNNUDGE7DM8Burn/3QsfBepyJOjsvAkjRDg/Wb1SdariL3ZJqOYPHg2HlbAK9uRL+W2MZZzu5O4F8FGlqQuxsZLXiLEIxatSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374309; c=relaxed/simple;
	bh=7yvJVotM6dgiP4LTJZR5k6jV6UGL5cKkSeGextoxd8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViMKEvoJEza0e3MNJWKJXniqorHW6Bkz/HUEK3BJVkw0abA5dzj+L4evHrwTlh1xN4ixGSvUZj9u2aIDlVrsnsMG05b56K+Cg2XIrxLF3YR7Hu3+GaSbPZlHu46xK7TVcenOIInYQo/2v6aDq5+B3DK76buRhMOTBpplUolFJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Luaek1lw; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1760374303;
	bh=7yvJVotM6dgiP4LTJZR5k6jV6UGL5cKkSeGextoxd8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Luaek1lwsdlDAUxEyLxMaysSLgu8ouvjzcX2ZRUUhlFZYVPHlREshaSJV7BppNPex
	 RHZcWbvGTH+raIS5HJQq9ohWL6Drzj9Eh2igDkdJAiiiRlU0BtU4BOJcCm/rY/6FNQ
	 0oqc2Ofwy9Qy03RKF/VoXGyMbodDemO78MBpwAo4gu8Lo7ICQggdrJAgacducMq0F2
	 mRQewxa8luKt/yuVhI5M15lSkzyxbivO1GyR/EWoHNeMX/c5vntlyePE9GymbxzPvg
	 6Vy8szfwn+tgR1Ye+CTgSdUoW3aTeXXB/sjJhh3yjv+n3QoL9oPParUMJ3/wNF9tSr
	 0d0Obhx0STq5A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9ECA9600BF;
	Mon, 13 Oct 2025 16:50:35 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 1A97920129B; Mon, 13 Oct 2025 16:50:23 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Joe Damato <jdamato@fastly.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/6] tools: ynl-gen: bitshift the flag values in the generated code
Date: Mon, 13 Oct 2025 16:49:58 +0000
Message-ID: <20251013165005.83659-2-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013165005.83659-1-ast@fiberby.net>
References: <20251013165005.83659-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of pre-computing the flag values within the code generator,
then move the bitshift operation into the generated code.

This IMHO makes the generated code read more like handwritten code.

No functional changes.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/uapi/linux/dpll.h                     |  6 ++--
 .../uapi/linux/ethtool_netlink_generated.h    | 20 ++++++-------
 include/uapi/linux/netdev.h                   | 28 +++++++++----------
 tools/include/uapi/linux/netdev.h             | 28 +++++++++----------
 tools/net/ynl/pyynl/lib/nlspec.py             |  7 +++--
 tools/net/ynl/pyynl/ynl_gen_c.py              |  2 +-
 6 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index ab1725a954d74..28c9c8e5761b4 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -185,9 +185,9 @@ enum dpll_pin_state {
  * @DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE: pin state can be changed
  */
 enum dpll_pin_capabilities {
-	DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE = 1,
-	DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE = 2,
-	DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE = 4,
+	DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE = 1U << 0,
+	DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE = 1U << 1,
+	DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE = 1U << 2,
 };
 
 #define DPLL_PHASE_OFFSET_DIVIDER	1000
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 0e8ac0d974e20..14c9baacde0e8 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -26,9 +26,9 @@ enum {
  * @ETHTOOL_FLAG_STATS: request statistics, if supported by the driver
  */
 enum ethtool_header_flags {
-	ETHTOOL_FLAG_COMPACT_BITSETS = 1,
-	ETHTOOL_FLAG_OMIT_REPLY = 2,
-	ETHTOOL_FLAG_STATS = 4,
+	ETHTOOL_FLAG_COMPACT_BITSETS = 1U << 0,
+	ETHTOOL_FLAG_OMIT_REPLY = 1U << 1,
+	ETHTOOL_FLAG_STATS = 1U << 2,
 };
 
 enum ethtool_tcp_data_split {
@@ -68,13 +68,13 @@ enum hwtstamp_source {
  *   power control from software
  */
 enum ethtool_pse_event {
-	ETHTOOL_PSE_EVENT_OVER_CURRENT = 1,
-	ETHTOOL_PSE_EVENT_OVER_TEMP = 2,
-	ETHTOOL_C33_PSE_EVENT_DETECTION = 4,
-	ETHTOOL_C33_PSE_EVENT_CLASSIFICATION = 8,
-	ETHTOOL_C33_PSE_EVENT_DISCONNECTION = 16,
-	ETHTOOL_PSE_EVENT_OVER_BUDGET = 32,
-	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
+	ETHTOOL_PSE_EVENT_OVER_CURRENT = 1U << 0,
+	ETHTOOL_PSE_EVENT_OVER_TEMP = 1U << 1,
+	ETHTOOL_C33_PSE_EVENT_DETECTION = 1U << 2,
+	ETHTOOL_C33_PSE_EVENT_CLASSIFICATION = 1U << 3,
+	ETHTOOL_C33_PSE_EVENT_DISCONNECTION = 1U << 4,
+	ETHTOOL_PSE_EVENT_OVER_BUDGET = 1U << 5,
+	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 1U << 6,
 };
 
 enum {
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 48eb49aa03d41..db0526cb6672d 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -26,13 +26,13 @@
  *   non-linear XDP buffer support in ndo_xdp_xmit callback.
  */
 enum netdev_xdp_act {
-	NETDEV_XDP_ACT_BASIC = 1,
-	NETDEV_XDP_ACT_REDIRECT = 2,
-	NETDEV_XDP_ACT_NDO_XMIT = 4,
-	NETDEV_XDP_ACT_XSK_ZEROCOPY = 8,
-	NETDEV_XDP_ACT_HW_OFFLOAD = 16,
-	NETDEV_XDP_ACT_RX_SG = 32,
-	NETDEV_XDP_ACT_NDO_XMIT_SG = 64,
+	NETDEV_XDP_ACT_BASIC = 1U << 0,
+	NETDEV_XDP_ACT_REDIRECT = 1U << 1,
+	NETDEV_XDP_ACT_NDO_XMIT = 1U << 2,
+	NETDEV_XDP_ACT_XSK_ZEROCOPY = 1U << 3,
+	NETDEV_XDP_ACT_HW_OFFLOAD = 1U << 4,
+	NETDEV_XDP_ACT_RX_SG = 1U << 5,
+	NETDEV_XDP_ACT_NDO_XMIT_SG = 1U << 6,
 
 	/* private: */
 	NETDEV_XDP_ACT_MASK = 127,
@@ -48,9 +48,9 @@ enum netdev_xdp_act {
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
  */
 enum netdev_xdp_rx_metadata {
-	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
-	NETDEV_XDP_RX_METADATA_HASH = 2,
-	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1U << 0,
+	NETDEV_XDP_RX_METADATA_HASH = 1U << 1,
+	NETDEV_XDP_RX_METADATA_VLAN_TAG = 1U << 2,
 };
 
 /**
@@ -63,9 +63,9 @@ enum netdev_xdp_rx_metadata {
  *   by the driver.
  */
 enum netdev_xsk_flags {
-	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
-	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
-	NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO = 4,
+	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1U << 0,
+	NETDEV_XSK_FLAGS_TX_CHECKSUM = 1U << 1,
+	NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO = 1U << 2,
 };
 
 enum netdev_queue_type {
@@ -74,7 +74,7 @@ enum netdev_queue_type {
 };
 
 enum netdev_qstats_scope {
-	NETDEV_QSTATS_SCOPE_QUEUE = 1,
+	NETDEV_QSTATS_SCOPE_QUEUE = 1U << 0,
 };
 
 enum netdev_napi_threaded {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 48eb49aa03d41..db0526cb6672d 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -26,13 +26,13 @@
  *   non-linear XDP buffer support in ndo_xdp_xmit callback.
  */
 enum netdev_xdp_act {
-	NETDEV_XDP_ACT_BASIC = 1,
-	NETDEV_XDP_ACT_REDIRECT = 2,
-	NETDEV_XDP_ACT_NDO_XMIT = 4,
-	NETDEV_XDP_ACT_XSK_ZEROCOPY = 8,
-	NETDEV_XDP_ACT_HW_OFFLOAD = 16,
-	NETDEV_XDP_ACT_RX_SG = 32,
-	NETDEV_XDP_ACT_NDO_XMIT_SG = 64,
+	NETDEV_XDP_ACT_BASIC = 1U << 0,
+	NETDEV_XDP_ACT_REDIRECT = 1U << 1,
+	NETDEV_XDP_ACT_NDO_XMIT = 1U << 2,
+	NETDEV_XDP_ACT_XSK_ZEROCOPY = 1U << 3,
+	NETDEV_XDP_ACT_HW_OFFLOAD = 1U << 4,
+	NETDEV_XDP_ACT_RX_SG = 1U << 5,
+	NETDEV_XDP_ACT_NDO_XMIT_SG = 1U << 6,
 
 	/* private: */
 	NETDEV_XDP_ACT_MASK = 127,
@@ -48,9 +48,9 @@ enum netdev_xdp_act {
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
  */
 enum netdev_xdp_rx_metadata {
-	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
-	NETDEV_XDP_RX_METADATA_HASH = 2,
-	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1U << 0,
+	NETDEV_XDP_RX_METADATA_HASH = 1U << 1,
+	NETDEV_XDP_RX_METADATA_VLAN_TAG = 1U << 2,
 };
 
 /**
@@ -63,9 +63,9 @@ enum netdev_xdp_rx_metadata {
  *   by the driver.
  */
 enum netdev_xsk_flags {
-	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
-	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
-	NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO = 4,
+	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1U << 0,
+	NETDEV_XSK_FLAGS_TX_CHECKSUM = 1U << 1,
+	NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO = 1U << 2,
 };
 
 enum netdev_queue_type {
@@ -74,7 +74,7 @@ enum netdev_queue_type {
 };
 
 enum netdev_qstats_scope {
-	NETDEV_QSTATS_SCOPE_QUEUE = 1,
+	NETDEV_QSTATS_SCOPE_QUEUE = 1U << 0,
 };
 
 enum netdev_napi_threaded {
diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
index 85c17fe01e35a..465d8fd909a04 100644
--- a/tools/net/ynl/pyynl/lib/nlspec.py
+++ b/tools/net/ynl/pyynl/lib/nlspec.py
@@ -90,9 +90,12 @@ class SpecEnumEntry(SpecElement):
     def raw_value(self):
         return self.value
 
-    def user_value(self, as_flags=None):
+    def user_value(self, as_flags=None, as_c=None):
         if self.enum_set['type'] == 'flags' or as_flags:
-            return 1 << self.value
+            if as_c:
+                return f'1U << {self.value}'
+            else:
+                return 1 << self.value
         else:
             return self.value
 
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 58086b1010573..e6df0e2b63a8c 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -3209,7 +3209,7 @@ def render_uapi(family, cw):
             for entry in enum.entries.values():
                 suffix = ','
                 if entry.value_change:
-                    suffix = f" = {entry.user_value()}" + suffix
+                    suffix = f" = {entry.user_value(as_c=True)}" + suffix
                 cw.p(entry.c_name + suffix)
 
             if const.get('render-max', False):
-- 
2.51.0


