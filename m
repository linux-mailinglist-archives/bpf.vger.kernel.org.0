Return-Path: <bpf+bounces-46279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE449E7485
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DBF188229B
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED97320E003;
	Fri,  6 Dec 2024 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hzbUznQC"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5019820E016;
	Fri,  6 Dec 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499284; cv=none; b=kw5HAOqMR7VRSx8RogFYKdne8e4iOqEU+zqDrOx2STr7BZbbuVv++kZ3Dz+iOGk3HEx/ur9MCES2E81HLWqbXvCW6XM4RcFo6mhGRUxIkuxsyiD0RiIDOFC4sVyX8urQ0d5UJrs5YEtKNJIFdh9EbTxARIsWCHxt4V/qLn7qUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499284; c=relaxed/simple;
	bh=1ITbAn22++Ob7kA1nEk7YQEuphiXTzhZj2P7KDqtLQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fkeqhu1HsgVZVOEwmc8N4dYJm5a0Xvgd+X5B0WwfyzA8xe7CwG3fWBXFDm9XQ8Ft4vgUEb55Gxwb6D6HG94oW2DeUIdS/fxlr/Hr3zhoAH2NDKbZSr1fjBTAaR9LMasElSon0ECZ2Wh17DTh/jDlkiNCL3ZgXQRXwKQm71YuchI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=hzbUznQC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yDvV13jrwvg/8LFAnBn/yTTKslVhcmcZpdcecddhnVw=; b=hzbUznQC2tNOQ2Oolvrlp6bH4J
	72/NVj7vTywifcs8H7GO74W/4l6j/sCtHNmQgf5Gtog7wZRDWGxXcFy9NIq3+lcJXXckTqI/kLNPF
	+T8df0sFfVilfwzWjbfKhA3ZtKTYL/M0gSHmWB0pCco0xWGjzev84qhyM34kqV3R6CQBTSbQxJyjD
	CUJ2X2J7KOIBMcyuRJnF8+/v8Rj4QmaYRw149VKRLeqtsnD5KJFnm+iiRCUSU3TgIeurX+iRVH51l
	GkIfi+6+lJSaId2vo/2nQI8cHK4pHd7ygPfECyU4fP65qczV5ns1Yckj5hxAtsHFRU1tlh0/+5Z2x
	jxXVMM9g==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tJaLZ-000ESD-0q; Fri, 06 Dec 2024 16:34:25 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	leitao@debian.org,
	martin.lau@linux.dev,
	peilin.ye@bytedance.com,
	kuba@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH stable 6.1 3/3] veth: Use tstats per-CPU traffic counters
Date: Fri,  6 Dec 2024 16:34:03 +0100
Message-ID: <20241206153403.273068-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206153403.273068-1-daniel@iogearbox.net>
References: <20241206153403.273068-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27479/Fri Dec  6 10:40:14 2024)

From: Peilin Ye <peilin.ye@bytedance.com>

[ Upstream commit 6f2684bf2b4460c84d0d34612a939f78b96b03fc ]

Currently veth devices use the lstats per-CPU traffic counters, which only
cover TX traffic. veth_get_stats64() actually populates RX stats of a veth
device from its peer's TX counters, based on the assumption that a veth
device can _only_ receive packets from its peer, which is no longer true:

For example, recent CNIs (like Cilium) can use the bpf_redirect_peer() BPF
helper to redirect traffic from NIC's tc ingress to veth's tc ingress (in
a different netns), skipping veth's peer device. Unfortunately, this kind
of traffic isn't currently accounted for in veth's RX stats.

In preparation for the fix, use tstats (instead of lstats) to maintain
both RX and TX counters for each veth device. We'll use RX counters for
bpf_redirect_peer() traffic, and keep using TX counters for the usual
"peer-to-peer" traffic. In veth_get_stats64(), calculate RX stats by
_adding_ RX count to peer's TX count, in order to cover both kinds of
traffic.

veth_stats_rx() might need a name change (perhaps to "veth_stats_xdp()")
for less confusion, but let's leave it to another patch to keep the fix
minimal.

Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20231114004220.6495-5-daniel@iogearbox.net
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 drivers/net/veth.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0a8154611d7f..e1e7df00e85c 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -342,7 +342,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	skb_tx_timestamp(skb);
 	if (likely(veth_forward_skb(rcv, skb, rq, use_napi) == NET_RX_SUCCESS)) {
 		if (!use_napi)
-			dev_lstats_add(dev, length);
+			dev_sw_netstats_tx_add(dev, 1, length);
 	} else {
 drop:
 		atomic64_inc(&priv->dropped);
@@ -357,14 +357,6 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	return ret;
 }
 
-static u64 veth_stats_tx(struct net_device *dev, u64 *packets, u64 *bytes)
-{
-	struct veth_priv *priv = netdev_priv(dev);
-
-	dev_lstats_read(dev, packets, bytes);
-	return atomic64_read(&priv->dropped);
-}
-
 static void veth_stats_rx(struct veth_stats *result, struct net_device *dev)
 {
 	struct veth_priv *priv = netdev_priv(dev);
@@ -402,24 +394,24 @@ static void veth_get_stats64(struct net_device *dev,
 	struct veth_priv *priv = netdev_priv(dev);
 	struct net_device *peer;
 	struct veth_stats rx;
-	u64 packets, bytes;
 
-	tot->tx_dropped = veth_stats_tx(dev, &packets, &bytes);
-	tot->tx_bytes = bytes;
-	tot->tx_packets = packets;
+	tot->tx_dropped = atomic64_read(&priv->dropped);
+	dev_fetch_sw_netstats(tot, dev->tstats);
 
 	veth_stats_rx(&rx, dev);
 	tot->tx_dropped += rx.xdp_tx_err;
 	tot->rx_dropped = rx.rx_drops + rx.peer_tq_xdp_xmit_err;
-	tot->rx_bytes = rx.xdp_bytes;
-	tot->rx_packets = rx.xdp_packets;
+	tot->rx_bytes += rx.xdp_bytes;
+	tot->rx_packets += rx.xdp_packets;
 
 	rcu_read_lock();
 	peer = rcu_dereference(priv->peer);
 	if (peer) {
-		veth_stats_tx(peer, &packets, &bytes);
-		tot->rx_bytes += bytes;
-		tot->rx_packets += packets;
+		struct rtnl_link_stats64 tot_peer = {};
+
+		dev_fetch_sw_netstats(&tot_peer, peer->tstats);
+		tot->rx_bytes += tot_peer.tx_bytes;
+		tot->rx_packets += tot_peer.tx_packets;
 
 		veth_stats_rx(&rx, peer);
 		tot->tx_dropped += rx.peer_tq_xdp_xmit_err;
@@ -1612,7 +1604,7 @@ static void veth_setup(struct net_device *dev)
 			       NETIF_F_HW_VLAN_STAG_RX);
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = veth_dev_free;
-	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 
 	dev->hw_features = VETH_FEATURES;
-- 
2.43.0


