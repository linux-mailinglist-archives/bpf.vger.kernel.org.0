Return-Path: <bpf+bounces-15022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC127EA7AE
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 01:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9A61C20A4E
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 00:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2516A5237;
	Tue, 14 Nov 2023 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="p9iZA0kX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159A8833;
	Tue, 14 Nov 2023 00:42:51 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A755AD6F;
	Mon, 13 Nov 2023 16:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=clU03dAmGi/aMQ1bi+3LeTUKfGz3giZCeCcvgiUn2Ds=; b=p9iZA0kXqvjzf9JPJ4N/NuNzgW
	PUCpHFlYbVhaPy3fLOgUuZmhvxj94zm2YNZjWS8hNxfAqfCLR+lOMrQbIWOMhPj4YmS5VrNj5h004
	YD/7vfAGxRNSHXykak3WNzAramX+qmLl61b2Rk1I/1G4XGJp05iRhaOnyer8Oi+XJdroa40IN+VoI
	hG4yLFpijVc2kiDjzMgV19jMkrryW658VbXKvpitkxfXAi867eW0YAweb0jW4XuYmdiXhuzVj9pL1
	04J1x+hakjFp+c51I1CI2IuGuC7uiiy7ppUIJMKP0BVxmaCnDlozxU6ok3cLszfqzCSjNcHLQJxa9
	OLsOF5PA==;
Received: from mob-194-230-158-57.cgn.sunrise.net ([194.230.158.57] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2hVu-0006VK-SW; Tue, 14 Nov 2023 01:42:47 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: kuba@kernel.org,
	razor@blackwall.org,
	sdf@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Peilin Ye <peilin.ye@bytedance.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v3 4/8] veth: Use tstats per-CPU traffic counters
Date: Tue, 14 Nov 2023 01:42:16 +0100
Message-Id: <20231114004220.6495-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231114004220.6495-1-daniel@iogearbox.net>
References: <20231114004220.6495-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27092/Mon Nov 13 09:38:20 2023)

From: Peilin Ye <peilin.ye@bytedance.com>

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
---
 drivers/net/veth.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index ac030c241d1a..6cc352296c67 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -373,7 +373,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	skb_tx_timestamp(skb);
 	if (likely(veth_forward_skb(rcv, skb, rq, use_napi) == NET_RX_SUCCESS)) {
 		if (!use_napi)
-			dev_lstats_add(dev, length);
+			dev_sw_netstats_tx_add(dev, 1, length);
 		else
 			__veth_xdp_flush(rq);
 	} else {
@@ -387,14 +387,6 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -432,24 +424,24 @@ static void veth_get_stats64(struct net_device *dev,
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
@@ -1783,7 +1775,7 @@ static void veth_setup(struct net_device *dev)
 			       NETIF_F_HW_VLAN_STAG_RX);
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = veth_dev_free;
-	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 
 	dev->hw_features = VETH_FEATURES;
-- 
2.34.1


