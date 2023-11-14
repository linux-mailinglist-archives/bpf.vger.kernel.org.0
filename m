Return-Path: <bpf+bounces-15021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07347EA7AA
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 01:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D01A1C209FA
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 00:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6FB443E;
	Tue, 14 Nov 2023 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="H4BUeErv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202946137;
	Tue, 14 Nov 2023 00:42:46 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9428B189;
	Mon, 13 Nov 2023 16:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GmCNYe88O88YYGkw4HOTS9BNA/qGhpz4y1T/7yqIr5w=; b=H4BUeErvbK0L7GemJw9g+CpJyo
	ZU6GUqHSa1lfFz33/gTDZRha1sg30r/9udOw/1uUcsJl860ppJ5c+gxNNvJkXqT08J6X3hRKlIE25
	/7GG/ECaNclB8/W5FRYydjktyCiLASp+PK60uZvVQpuHpPAagAzo7vVHzbDiIOxB7isfcyVVgQuij
	P3dJNbpr3n14lgj8uPgKl3m6qjgICFgK8spw7t0qGc3ahyYm2dqfH6LLB+7Q8AOt/8Xyw5YFqy1be
	ejbSpFdZRpEMEpuMi0BF42wXULTzWyimSQUTtvOqMvpJEey78skYG/LIUT/PUMgpwubmw3CHfbkXA
	/hoOfrpg==;
Received: from mob-194-230-158-57.cgn.sunrise.net ([194.230.158.57] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2hVq-0006Uf-EU; Tue, 14 Nov 2023 01:42:42 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: kuba@kernel.org,
	razor@blackwall.org,
	sdf@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v3 3/8] netkit: Add tstats per-CPU traffic counters
Date: Tue, 14 Nov 2023 01:42:15 +0100
Message-Id: <20231114004220.6495-4-daniel@iogearbox.net>
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

Add dev->tstats traffic accounting to netkit. The latter contains per-CPU
RX and TX counters.

The dev's TX counters are bumped upon pass/unspec as well as redirect
verdicts, in other words, on everything except for drops.

The dev's RX counters are bumped upon successful __netif_rx(), as well
as from skb_do_redirect() (not part of this commit here).

Using dev->lstats with having just a single packets/bytes counter and
inferring one another's RX counters from the peer dev's lstats is not
possible given skb_do_redirect() can also bump the device's stats.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5a0f86f38f09..99de11f9cde5 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -68,6 +68,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 	netdev_tx_t ret_dev = NET_XMIT_SUCCESS;
 	const struct bpf_mprog_entry *entry;
 	struct net_device *peer;
+	int len = skb->len;
 
 	rcu_read_lock();
 	peer = rcu_dereference(nk->peer);
@@ -85,15 +86,22 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 	case NETKIT_PASS:
 		skb->protocol = eth_type_trans(skb, skb->dev);
 		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
-		__netif_rx(skb);
+		if (likely(__netif_rx(skb) == NET_RX_SUCCESS)) {
+			dev_sw_netstats_tx_add(dev, 1, len);
+			dev_sw_netstats_rx_add(peer, len);
+		} else {
+			goto drop_stats;
+		}
 		break;
 	case NETKIT_REDIRECT:
+		dev_sw_netstats_tx_add(dev, 1, len);
 		skb_do_redirect(skb);
 		break;
 	case NETKIT_DROP:
 	default:
 drop:
 		kfree_skb(skb);
+drop_stats:
 		dev_core_stats_tx_dropped_inc(dev);
 		ret_dev = NET_XMIT_DROP;
 		break;
@@ -174,6 +182,13 @@ static struct net_device *netkit_peer_dev(struct net_device *dev)
 	return rcu_dereference(netkit_priv(dev)->peer);
 }
 
+static void netkit_get_stats(struct net_device *dev,
+			     struct rtnl_link_stats64 *stats)
+{
+	dev_fetch_sw_netstats(stats, dev->tstats);
+	stats->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
+}
+
 static void netkit_uninit(struct net_device *dev);
 
 static const struct net_device_ops netkit_netdev_ops = {
@@ -184,6 +199,7 @@ static const struct net_device_ops netkit_netdev_ops = {
 	.ndo_set_rx_headroom	= netkit_set_headroom,
 	.ndo_get_iflink		= netkit_get_iflink,
 	.ndo_get_peer_dev	= netkit_peer_dev,
+	.ndo_get_stats64	= netkit_get_stats,
 	.ndo_uninit		= netkit_uninit,
 	.ndo_features_check	= passthru_features_check,
 };
@@ -218,6 +234,7 @@ static void netkit_setup(struct net_device *dev)
 
 	ether_setup(dev);
 	dev->max_mtu = ETH_MAX_MTU;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	dev->flags |= IFF_NOARP;
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
-- 
2.34.1


