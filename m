Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E014151B7A3
	for <lists+bpf@lfdr.de>; Thu,  5 May 2022 07:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiEEF7c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 May 2022 01:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243889AbiEEF7b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 May 2022 01:59:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E86825E81;
        Wed,  4 May 2022 22:55:45 -0700 (PDT)
X-UUID: 809fa0c2bdf147d594d6b23e33d32a82-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:7eadf22f-04c3-40a6-862d-bf403d77d3de,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-12
X-CID-META: VersionHash:faefae9,CLOUDID:b8f7a2b2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 809fa0c2bdf147d594d6b23e33d32a82-20220505
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <lina.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 372878867; Thu, 05 May 2022 13:55:39 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 5 May 2022 13:55:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 5 May 2022 13:55:37 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 5 May 2022 13:55:35 +0800
From:   Lina Wang <lina.wang@mediatek.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Maciej enczykowski <maze@google.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <llvm@lists.linux.dev>,
        Lina Wang <lina.wang@mediatek.com>
Subject: [PATCH v6 2/2] selftests net: add UDP GRO fraglist + bpf self-tests
Date:   Thu, 5 May 2022 13:48:50 +0800
Message-ID: <20220505054850.4878-2-lina.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220505054850.4878-1-lina.wang@mediatek.com>
References: <20220505054850.4878-1-lina.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When NET_F_F_GRO_FRAGLIST is enabled and bpf_skb_change_proto is used,
check if udp packets and tcp packets are successfully delivered to user
space. If wrong udp packets are delivered, udpgso_bench_rx will exit
with "Initial byte out of range"

Signed-off-by: Maciej enczykowski <maze@google.com>
Signed-off-by: Lina Wang <lina.wang@mediatek.com>
---
 tools/testing/selftests/net/Makefile          |   3 +
 tools/testing/selftests/net/bpf/Makefile      |  17 ++
 tools/testing/selftests/net/bpf/nat6to4.c     | 286 ++++++++++++++++++
 tools/testing/selftests/net/udpgro_frglist.sh | 101 +++++++
 4 files changed, 407 insertions(+)
 create mode 100644 tools/testing/selftests/net/bpf/Makefile
 create mode 100644 tools/testing/selftests/net/bpf/nat6to4.c
 create mode 100755 tools/testing/selftests/net/udpgro_frglist.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 3fe2515aa616..f670c20fbc57 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -25,6 +25,7 @@ TEST_PROGS += bareudp.sh
 TEST_PROGS += amt.sh
 TEST_PROGS += unicast_extensions.sh
 TEST_PROGS += udpgro_fwd.sh
+TEST_PROGS += udpgro_frglist.sh
 TEST_PROGS += veth.sh
 TEST_PROGS += ioam6.sh
 TEST_PROGS += gro.sh
@@ -60,6 +61,8 @@ TEST_FILES := settings
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
+include bpf/Makefile
+
 $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread
 $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
diff --git a/tools/testing/selftests/net/bpf/Makefile b/tools/testing/selftests/net/bpf/Makefile
new file mode 100644
index 000000000000..47e715e54cab
--- /dev/null
+++ b/tools/testing/selftests/net/bpf/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CLANG ?= clang
+CCINCLUDE += -I../../bpf 
+CCINCLUDE += -I../../../../../usr/include/
+
+TEST_CUSTOM_PROGS = $(OUTPUT)/bpf/nat6to4.o
+all: $(TEST_CUSTOM_PROGS)
+
+$(OUTPUT)/%.o: %.c
+	$(CLANG) -O2 -target bpf -c $< $(CCINCLUDE) -o $@
+
+clean:
+	rm -f $(TEST_CUSTOM_PROGS)
+
+
+
diff --git a/tools/testing/selftests/net/bpf/nat6to4.c b/tools/testing/selftests/net/bpf/nat6to4.c
new file mode 100644
index 000000000000..fe30f260cde6
--- /dev/null
+++ b/tools/testing/selftests/net/bpf/nat6to4.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This code is taken from the Android Open Source Project and the author
+ * (Maciej Żenczykowski) has gave permission to relicense it under the
+ * GPLv2. Therefore this program is free software;
+ * You can redistribute it and/or modify it under the terms of the GNU
+ * General Public License version 2 as published by the Free Software
+ * Foundation
+
+ * The original headers, including the original license headers, are
+ * included below for completeness.
+ *
+ * Copyright (C) 2019 The Android Open Source Project
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+#include <linux/bpf.h>
+#include <linux/if.h>
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/pkt_cls.h>
+#include <linux/swab.h>
+#include <stdbool.h>
+#include <stdint.h>
+
+
+#include <linux/udp.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define IP_DF 0x4000  // Flag: "Don't Fragment"
+
+SEC("schedcls/ingress6/nat_6")
+int sched_cls_ingress6_nat_6_prog(struct __sk_buff *skb)
+{
+	const int l2_header_size =  sizeof(struct ethhdr);
+	void *data = (void *)(long)skb->data;
+	const void *data_end = (void *)(long)skb->data_end;
+	const struct ethhdr * const eth = data;  // used iff is_ethernet
+	const struct ipv6hdr * const ip6 =  (void *)(eth + 1);
+
+	// Require ethernet dst mac address to be our unicast address.
+	if  (skb->pkt_type != PACKET_HOST)
+		return TC_ACT_OK;
+
+	// Must be meta-ethernet IPv6 frame
+	if (skb->protocol != bpf_htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	// Must have (ethernet and) ipv6 header
+	if (data + l2_header_size + sizeof(*ip6) > data_end)
+		return TC_ACT_OK;
+
+	// Ethertype - if present - must be IPv6
+	if (eth->h_proto != bpf_htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	// IP version must be 6
+	if (ip6->version != 6)
+		return TC_ACT_OK;
+	// Maximum IPv6 payload length that can be translated to IPv4
+	if (bpf_ntohs(ip6->payload_len) > 0xFFFF - sizeof(struct iphdr))
+		return TC_ACT_OK;
+	switch (ip6->nexthdr) {
+	case IPPROTO_TCP:  // For TCP & UDP the checksum neutrality of the chosen IPv6
+	case IPPROTO_UDP:  // address means there is no need to update their checksums.
+	case IPPROTO_GRE:  // We do not need to bother looking at GRE/ESP headers,
+	case IPPROTO_ESP:  // since there is never a checksum to update.
+		break;
+	default:  // do not know how to handle anything else
+		return TC_ACT_OK;
+	}
+
+	struct ethhdr eth2;  // used iff is_ethernet
+
+	eth2 = *eth;                     // Copy over the ethernet header (src/dst mac)
+	eth2.h_proto = bpf_htons(ETH_P_IP);  // But replace the ethertype
+
+	struct iphdr ip = {
+		.version = 4,                                                      // u4
+		.ihl = sizeof(struct iphdr) / sizeof(__u32),                       // u4
+		.tos = (ip6->priority << 4) + (ip6->flow_lbl[0] >> 4),             // u8
+		.tot_len = bpf_htons(bpf_ntohs(ip6->payload_len) + sizeof(struct iphdr)),  // u16
+		.id = 0,                                                           // u16
+		.frag_off = bpf_htons(IP_DF),                                          // u16
+		.ttl = ip6->hop_limit,                                             // u8
+		.protocol = ip6->nexthdr,                                          // u8
+		.check = 0,                                                        // u16
+		.saddr = 0x0201a8c0,                            // u32
+		.daddr = 0x0101a8c0,                                         // u32
+	};
+
+	// Calculate the IPv4 one's complement checksum of the IPv4 header.
+	__wsum sum4 = 0;
+
+	for (int i = 0; i < sizeof(ip) / sizeof(__u16); ++i)
+		sum4 += ((__u16 *)&ip)[i];
+
+	// Note that sum4 is guaranteed to be non-zero by virtue of ip.version == 4
+	sum4 = (sum4 & 0xFFFF) + (sum4 >> 16);  // collapse u32 into range 1 .. 0x1FFFE
+	sum4 = (sum4 & 0xFFFF) + (sum4 >> 16);  // collapse any potential carry into u16
+	ip.check = (__u16)~sum4;                // sum4 cannot be zero, so this is never 0xFFFF
+
+	// Calculate the *negative* IPv6 16-bit one's complement checksum of the IPv6 header.
+	__wsum sum6 = 0;
+	// We'll end up with a non-zero sum due to ip6->version == 6 (which has '0' bits)
+	for (int i = 0; i < sizeof(*ip6) / sizeof(__u16); ++i)
+		sum6 += ~((__u16 *)ip6)[i];  // note the bitwise negation
+
+	// Note that there is no L4 checksum update: we are relying on the checksum neutrality
+	// of the ipv6 address chosen by netd's ClatdController.
+
+	// Packet mutations begin - point of no return, but if this first modification fails
+	// the packet is probably still pristine, so let clatd handle it.
+	if (bpf_skb_change_proto(skb, bpf_htons(ETH_P_IP), 0))
+		return TC_ACT_OK;
+	bpf_csum_update(skb, sum6);
+
+	data = (void *)(long)skb->data;
+	data_end = (void *)(long)skb->data_end;
+	if (data + l2_header_size + sizeof(struct iphdr) > data_end)
+		return TC_ACT_SHOT;
+
+	struct ethhdr *new_eth = data;
+
+	// Copy over the updated ethernet header
+	*new_eth = eth2;
+
+	// Copy over the new ipv4 header.
+	*(struct iphdr *)(new_eth + 1) = ip;
+	return bpf_redirect(skb->ifindex, BPF_F_INGRESS);
+}
+
+SEC("schedcls/egress4/snat4")
+int sched_cls_egress4_snat4_prog(struct __sk_buff *skb)
+{
+	const int l2_header_size =  sizeof(struct ethhdr);
+	void *data = (void *)(long)skb->data;
+	const void *data_end = (void *)(long)skb->data_end;
+	const struct ethhdr *const eth = data;  // used iff is_ethernet
+	const struct iphdr *const ip4 = (void *)(eth + 1);
+
+	// Must be meta-ethernet IPv4 frame
+	if (skb->protocol != bpf_htons(ETH_P_IP))
+		return TC_ACT_OK;
+
+	// Must have ipv4 header
+	if (data + l2_header_size + sizeof(struct ipv6hdr) > data_end)
+		return TC_ACT_OK;
+
+	// Ethertype - if present - must be IPv4
+	if (eth->h_proto != bpf_htons(ETH_P_IP))
+		return TC_ACT_OK;
+
+	// IP version must be 4
+	if (ip4->version != 4)
+		return TC_ACT_OK;
+
+	// We cannot handle IP options, just standard 20 byte == 5 dword minimal IPv4 header
+	if (ip4->ihl != 5)
+		return TC_ACT_OK;
+
+	// Maximum IPv6 payload length that can be translated to IPv4
+	if (bpf_htons(ip4->tot_len) > 0xFFFF - sizeof(struct ipv6hdr))
+		return TC_ACT_OK;
+
+	// Calculate the IPv4 one's complement checksum of the IPv4 header.
+	__wsum sum4 = 0;
+
+	for (int i = 0; i < sizeof(*ip4) / sizeof(__u16); ++i)
+		sum4 += ((__u16 *)ip4)[i];
+
+	// Note that sum4 is guaranteed to be non-zero by virtue of ip4->version == 4
+	sum4 = (sum4 & 0xFFFF) + (sum4 >> 16);  // collapse u32 into range 1 .. 0x1FFFE
+	sum4 = (sum4 & 0xFFFF) + (sum4 >> 16);  // collapse any potential carry into u16
+	// for a correct checksum we should get *a* zero, but sum4 must be positive, ie 0xFFFF
+	if (sum4 != 0xFFFF)
+		return TC_ACT_OK;
+
+	// Minimum IPv4 total length is the size of the header
+	if (bpf_ntohs(ip4->tot_len) < sizeof(*ip4))
+		return TC_ACT_OK;
+
+	// We are incapable of dealing with IPv4 fragments
+	if (ip4->frag_off & ~bpf_htons(IP_DF))
+		return TC_ACT_OK;
+
+	switch (ip4->protocol) {
+	case IPPROTO_TCP:  // For TCP & UDP the checksum neutrality of the chosen IPv6
+	case IPPROTO_GRE:  // address means there is no need to update their checksums.
+	case IPPROTO_ESP:  // We do not need to bother looking at GRE/ESP headers,
+		break;         // since there is never a checksum to update.
+
+	case IPPROTO_UDP:  // See above comment, but must also have UDP header...
+		if (data + sizeof(*ip4) + sizeof(struct udphdr) > data_end)
+			return TC_ACT_OK;
+		const struct udphdr *uh = (const struct udphdr *)(ip4 + 1);
+		// If IPv4/UDP checksum is 0 then fallback to clatd so it can calculate the
+		// checksum.  Otherwise the network or more likely the NAT64 gateway might
+		// drop the packet because in most cases IPv6/UDP packets with a zero checksum
+		// are invalid. See RFC 6935.  TODO: calculate checksum via bpf_csum_diff()
+		if (!uh->check)
+			return TC_ACT_OK;
+		break;
+
+	default:  // do not know how to handle anything else
+		return TC_ACT_OK;
+	}
+	struct ethhdr eth2;  // used iff is_ethernet
+
+	eth2 = *eth;                     // Copy over the ethernet header (src/dst mac)
+	eth2.h_proto = bpf_htons(ETH_P_IPV6);  // But replace the ethertype
+
+	struct ipv6hdr ip6 = {
+		.version = 6,                                    // __u8:4
+		.priority = ip4->tos >> 4,                       // __u8:4
+		.flow_lbl = {(ip4->tos & 0xF) << 4, 0, 0},       // __u8[3]
+		.payload_len = bpf_htons(bpf_ntohs(ip4->tot_len) - 20),  // __be16
+		.nexthdr = ip4->protocol,                        // __u8
+		.hop_limit = ip4->ttl,                           // __u8
+	};
+	ip6.saddr.in6_u.u6_addr32[0] = bpf_htonl(0x20010db8);
+	ip6.saddr.in6_u.u6_addr32[1] = 0;
+	ip6.saddr.in6_u.u6_addr32[2] = 0;
+	ip6.saddr.in6_u.u6_addr32[3] = bpf_htonl(1);
+	ip6.daddr.in6_u.u6_addr32[0] = bpf_htonl(0x20010db8);
+	ip6.daddr.in6_u.u6_addr32[1] = 0;
+	ip6.daddr.in6_u.u6_addr32[2] = 0;
+	ip6.daddr.in6_u.u6_addr32[3] = bpf_htonl(2);
+
+	// Calculate the IPv6 16-bit one's complement checksum of the IPv6 header.
+	__wsum sum6 = 0;
+	// We'll end up with a non-zero sum due to ip6.version == 6
+	for (int i = 0; i < sizeof(ip6) / sizeof(__u16); ++i)
+		sum6 += ((__u16 *)&ip6)[i];
+
+	// Packet mutations begin - point of no return, but if this first modification fails
+	// the packet is probably still pristine, so let clatd handle it.
+	if (bpf_skb_change_proto(skb, bpf_htons(ETH_P_IPV6), 0))
+		return TC_ACT_OK;
+
+	// This takes care of updating the skb->csum field for a CHECKSUM_COMPLETE packet.
+	// In such a case, skb->csum is a 16-bit one's complement sum of the entire payload,
+	// thus we need to subtract out the ipv4 header's sum, and add in the ipv6 header's sum.
+	// However, we've already verified the ipv4 checksum is correct and thus 0.
+	// Thus we only need to add the ipv6 header's sum.
+	//
+	// bpf_csum_update() always succeeds if the skb is CHECKSUM_COMPLETE and returns an error
+	// (-ENOTSUPP) if it isn't.  So we just ignore the return code (see above for more details).
+	bpf_csum_update(skb, sum6);
+
+	// bpf_skb_change_proto() invalidates all pointers - reload them.
+	data = (void *)(long)skb->data;
+	data_end = (void *)(long)skb->data_end;
+
+	// I cannot think of any valid way for this error condition to trigger, however I do
+	// believe the explicit check is required to keep the in kernel ebpf verifier happy.
+	if (data + l2_header_size + sizeof(ip6) > data_end)
+		return TC_ACT_SHOT;
+
+	struct ethhdr *new_eth = data;
+
+	// Copy over the updated ethernet header
+	*new_eth = eth2;
+	// Copy over the new ipv4 header.
+	*(struct ipv6hdr *)(new_eth + 1) = ip6;
+	return TC_ACT_OK;
+}
+
+char _license[] SEC("license") = ("GPL");
+
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
new file mode 100755
index 000000000000..807b74c8fd80
--- /dev/null
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -0,0 +1,101 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Run a series of udpgro benchmarks
+
+readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
+
+cleanup() {
+	local -r jobs="$(jobs -p)"
+	local -r ns="$(ip netns list|grep $PEER_NS)"
+
+	[ -n "${jobs}" ] && kill -INT ${jobs} 2>/dev/null
+	[ -n "$ns" ] && ip netns del $ns 2>/dev/null
+}
+trap cleanup EXIT
+
+run_one() {
+	# use 'rx' as separator between sender args and receiver args
+	local -r all="$@"
+	local -r tx_args=${all%rx*}
+	local rx_args=${all#*rx}
+
+
+
+	ip netns add "${PEER_NS}"
+	ip -netns "${PEER_NS}" link set lo up
+	ip link add type veth
+	ip link set dev veth0 up
+	ip addr add dev veth0 192.168.1.2/24
+	ip addr add dev veth0 2001:db8::2/64 nodad
+
+	ip link set dev veth1 netns "${PEER_NS}"
+	ip -netns "${PEER_NS}" addr add dev veth1 192.168.1.1/24
+	ip -netns "${PEER_NS}" addr add dev veth1 2001:db8::1/64 nodad
+	ip -netns "${PEER_NS}" link set dev veth1 up
+	ip netns exec "${PEER_NS}" ethtool -K veth1 rx-gro-list on
+
+
+	ip -n "${PEER_NS}" link set veth1 xdp object ../bpf/xdp_dummy.o section xdp_dummy
+	tc -n "${PEER_NS}" qdisc add dev veth1 clsact
+	tc -n "${PEER_NS}" filter add dev veth1 ingress prio 4 protocol ipv6 bpf object-file ../bpf/nat6to4.o section schedcls/ingress6/nat_6  direct-action
+	tc -n "${PEER_NS}" filter add dev veth1 egress prio 4 protocol ip bpf object-file ../bpf/nat6to4.o section schedcls/egress4/snat4 direct-action
+        echo ${rx_args}
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
+
+	# Hack: let bg programs complete the startup
+	sleep 0.1
+	./udpgso_bench_tx ${tx_args}
+}
+
+run_in_netns() {
+	local -r args=$@
+  echo ${args}
+	./in_netns.sh $0 __subprocess ${args}
+}
+
+run_udp() {
+	local -r args=$@
+
+	echo "udp gso - over veth touching data"
+	run_in_netns ${args} -u -S 0 rx -4 -v
+
+	echo "udp gso and gro - over veth touching data"
+	run_in_netns ${args} -S 0 rx -4 -G
+}
+
+run_tcp() {
+	local -r args=$@
+
+	echo "tcp - over veth touching data"
+	run_in_netns ${args} -t rx -4 -t
+}
+
+run_all() {
+	local -r core_args="-l 4"
+	local -r ipv4_args="${core_args} -4  -D 192.168.1.1"
+	local -r ipv6_args="${core_args} -6  -D 2001:db8::1"
+
+	echo "ipv6"
+	run_tcp "${ipv6_args}"
+	run_udp "${ipv6_args}"
+}
+
+if [ ! -f ../bpf/xdp_dummy.o ]; then
+	echo "Missing xdp_dummy helper. Build bpf selftest first"
+	exit -1
+fi
+
+if [ ! -f bpf/nat6to4.o ]; then
+	echo "Missing nat6to4 helper. Build bpfnat6to4.o selftest first"
+	exit -1
+fi
+
+if [[ $# -eq 0 ]]; then
+	run_all
+elif [[ $1 == "__subprocess" ]]; then
+	shift
+	run_one $@
+else
+	run_in_netns $@
+fi
-- 
2.18.0

