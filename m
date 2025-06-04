Return-Path: <bpf+bounces-59682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A6EACE602
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 23:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7BE189AA81
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 21:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB39220B7FB;
	Wed,  4 Jun 2025 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDbav/iu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D722139B;
	Wed,  4 Jun 2025 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749071167; cv=none; b=g24Rdy3g0WlrVDd90ZUS4jlq9CppLcWu2clXHaQjFN3xIj5ZuuuuwZlu90WsPKc2vNPO0/RQk4twd1rBL4IdbaifpVyLhi/kbLXnFGLrDiuIVh8s4Vofn8O33QDnln9wODGanOZ9oO4OKjvxw9ftCkfaZ8J93W2hMEjcaAKh9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749071167; c=relaxed/simple;
	bh=NcPyZ8tjKyFGSliqHUcNgiWbK4bN2r/Ki5XsJuIe6Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IzouYRYVkeDWWqx4fiqInDjj6b/mBOpHpkDBf2bwt29c1kIyuEu/nLsenQxbS0SdFfh66no3aFpRn49IXlarSoOxs5x06Ny6O4mfqrLsRXfhTpGviD8G7holVizMPOrhupkQs0YCiebKuRInZyi++Oa0toDqIJSQcU2Vae6o8LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDbav/iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E644C4CEE4;
	Wed,  4 Jun 2025 21:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749071166;
	bh=NcPyZ8tjKyFGSliqHUcNgiWbK4bN2r/Ki5XsJuIe6Yg=;
	h=From:To:Cc:Subject:Date:From;
	b=MDbav/iu/HgzFbUK5RwlvpDHrJVdTBFhS7llgMgdrh456LuN1X4gMVJGP2vAeZWsK
	 oQFa91PjK6jdZBIONHVtsV6qigfRL3Xw/8Zj3scoLecNyL8163qyybAw7DrTzKwj+Z
	 k7DVlCSsuxp7C5Tq4yXLXiFzoYalcW3JJKQDeWg5WbHDSBc9RCOyVxPfo9z/Wog9fa
	 UYPTVA7wBF3c9jZqJ2fI+QrzoXbLuAuleqhsrTT6OzD+jrWJ01ByKWkPKV3u9TOzL9
	 PRoSNGsXUI4gQmZzuJrtui9NyT/1hthEsmhlZPJmfDk0oHkhPlOQllHcHOCn9zJKko
	 UW1nB3xBqISXA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	eddyz87@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	willemb@google.com,
	william.xuanziyang@huawei.com,
	alan.maguire@oracle.com,
	bpf@vger.kernel.org,
	maze@google.com
Subject: [PATCH net] net: clear the dst when changing skb protocol
Date: Wed,  4 Jun 2025 14:06:04 -0700
Message-ID: <20250604210604.257036-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A not-so-careful NAT46 BPF program can crash the kernel
if it indiscriminately flips ingress packets from v4 to v6:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
    ip6_rcv_core (net/ipv6/ip6_input.c:190:20)
    ipv6_rcv (net/ipv6/ip6_input.c:306:8)
    process_backlog (net/core/dev.c:6186:4)
    napi_poll (net/core/dev.c:6906:9)
    net_rx_action (net/core/dev.c:7028:13)
    do_softirq (kernel/softirq.c:462:3)
    netif_rx (net/core/dev.c:5326:3)
    dev_loopback_xmit (net/core/dev.c:4015:2)
    ip_mc_finish_output (net/ipv4/ip_output.c:363:8)
    NF_HOOK (./include/linux/netfilter.h:314:9)
    ip_mc_output (net/ipv4/ip_output.c:400:5)
    dst_output (./include/net/dst.h:459:9)
    ip_local_out (net/ipv4/ip_output.c:130:9)
    ip_send_skb (net/ipv4/ip_output.c:1496:8)
    udp_send_skb (net/ipv4/udp.c:1040:8)
    udp_sendmsg (net/ipv4/udp.c:1328:10)

The output interface has a 4->6 program attached at ingress.
We try to loop the multicast skb back to the sending socket.
Ingress BPF runs as part of netif_rx(), pushes a valid v6 hdr
and changes skb->protocol to v6. We enter ip6_rcv_core which
tries to use skb_dst(). But the dst is still an IPv4 one left
after IPv4 mcast output.

Clear the dst in all BPF helpers which change the protcol.
Try to preserve metadata dsts, those won't hurt.

Fixes: d219df60a70e ("bpf: Add ipip6 and ip6ip decap support for bpf_skb_adjust_room()")
Fixes: 1b00e0dfe7d0 ("bpf: update skb->protocol in bpf_skb_net_grow")
Fixes: 6578171a7ff0 ("bpf: add bpf_skb_change_proto helper")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
I wonder if we should not skip ingress (tc_skip_classify?)
for looped back packets in the first place. But that doesn't
seem robust enough vs multiple redirections to solve the crash.

Ignoring LOOPBACK packets (like the NAT46 prog should) doesn't
work either, since BPF can change pkt_type arbitrarily.

CC: martin.lau@linux.dev
CC: daniel@iogearbox.net
CC: john.fastabend@gmail.com
CC: eddyz87@gmail.com
CC: sdf@fomichev.me
CC: haoluo@google.com
CC: willemb@google.com
CC: william.xuanziyang@huawei.com
CC: alan.maguire@oracle.com
CC: bpf@vger.kernel.org
CC: edumazet@google.com
CC: maze@google.com
---
 net/core/filter.c                      | 19 +++++++++++++------
 tools/testing/selftests/net/nat6to4.sh | 15 +++++++++++++++
 2 files changed, 28 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/net/nat6to4.sh

diff --git a/net/core/filter.c b/net/core/filter.c
index 327ca73f9cd7..7a72f766aacf 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3233,6 +3233,13 @@ static const struct bpf_func_proto bpf_skb_vlan_pop_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
+static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
+{
+	skb->protocol = htons(proto);
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+}
+
 static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
 {
 	/* Caller already did skb_cow() with len as headroom,
@@ -3329,7 +3336,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 		}
 	}
 
-	skb->protocol = htons(ETH_P_IPV6);
+	bpf_skb_change_protocol(skb, ETH_P_IPV6);
 	skb_clear_hash(skb);
 
 	return 0;
@@ -3359,7 +3366,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb)
 		}
 	}
 
-	skb->protocol = htons(ETH_P_IP);
+	bpf_skb_change_protocol(skb, ETH_P_IP);
 	skb_clear_hash(skb);
 
 	return 0;
@@ -3550,10 +3557,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 		/* Match skb->protocol to new outer l3 protocol */
 		if (skb->protocol == htons(ETH_P_IP) &&
 		    flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
-			skb->protocol = htons(ETH_P_IPV6);
+			bpf_skb_change_protocol(skb, ETH_P_IPV6);
 		else if (skb->protocol == htons(ETH_P_IPV6) &&
 			 flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
-			skb->protocol = htons(ETH_P_IP);
+			bpf_skb_change_protocol(skb, ETH_P_IP);
 	}
 
 	if (skb_is_gso(skb)) {
@@ -3606,10 +3613,10 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 	/* Match skb->protocol to new outer l3 protocol */
 	if (skb->protocol == htons(ETH_P_IP) &&
 	    flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
-		skb->protocol = htons(ETH_P_IPV6);
+		bpf_skb_change_protocol(skb, ETH_P_IPV6);
 	else if (skb->protocol == htons(ETH_P_IPV6) &&
 		 flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
-		skb->protocol = htons(ETH_P_IP);
+		bpf_skb_change_protocol(skb, ETH_P_IP);
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
diff --git a/tools/testing/selftests/net/nat6to4.sh b/tools/testing/selftests/net/nat6to4.sh
new file mode 100755
index 000000000000..0ee859b622a4
--- /dev/null
+++ b/tools/testing/selftests/net/nat6to4.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+NS="ns-peer-$(mktemp -u XXXXXX)"
+
+ip netns add "${NS}"
+ip -netns "${NS}" link set lo up
+ip -netns "${NS}" route add default via 127.0.0.2 dev lo
+
+tc -n "${NS}" qdisc add dev lo ingress
+tc -n "${NS}" filter add dev lo ingress prio 4 protocol ip \
+   bpf object-file nat6to4.bpf.o section schedcls/egress4/snat4 direct-action
+
+ip netns exec "${NS}" \
+   bash -c 'echo 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789abc | socat - UDP4-DATAGRAM:224.1.0.1:6666,ip-multicast-loop=1'
-- 
2.49.0


