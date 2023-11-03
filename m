Return-Path: <bpf+bounces-14152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6E7E0B18
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FAFBB211C1
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC48250F9;
	Fri,  3 Nov 2023 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lloaATbo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42667249EA;
	Fri,  3 Nov 2023 22:28:02 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB505D61;
	Fri,  3 Nov 2023 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZvpBiyZYl/YBSEiNqZ+qEKxLEAaWkofCYhxMiUxw/sA=; b=lloaATbofQRutZuSzLi1gVafGX
	ZP5Ck/oszt1opHrC0FxOrGq+IlHbPHzrm3SzpnU/sF5sB2WEeYqo8uc5vxjhEo7gJzcQ6tdPFB7Z2
	B4qIQ3IIGhfy9AdlM/rsa9aC0tOi/3dzbiAWIrWfyITGNp8Xpyt3zv8mTdrzoeeIYkfP4hOabiqrM
	PR9CVSEcH4xhvIjJzbUSYujWoQqNMHJDtCZfsxIDdQ0b4+Vi8YAsTDEsBrOI51HMkoZ0G+GwnHB1D
	3mejHasKTVh9gHmjr1zDengI/gRu0miUHDKQyM6/4/nrzzyb/PcBtMBjQf2N+N44fS8JUHtwsJv+U
	+4WBqKgw==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qz2dw-000CpX-TK; Fri, 03 Nov 2023 23:27:56 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH bpf 1/6] netkit: Add tstats per-CPU traffic counters
Date: Fri,  3 Nov 2023 23:27:43 +0100
Message-Id: <20231103222748.12551-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231103222748.12551-1-daniel@iogearbox.net>
References: <20231103222748.12551-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27081/Fri Nov  3 08:43:47 2023)

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
 drivers/net/netkit.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5a0f86f38f09..dc51c23b40f0 100644
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
@@ -174,8 +182,26 @@ static struct net_device *netkit_peer_dev(struct net_device *dev)
 	return rcu_dereference(netkit_priv(dev)->peer);
 }
 
+static void netkit_get_stats(struct net_device *dev,
+			     struct rtnl_link_stats64 *stats)
+{
+	dev_fetch_sw_netstats(stats, dev->tstats);
+	stats->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
+}
+
+static int netkit_init(struct net_device *dev)
+{
+	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	return !dev->tstats ? -ENOMEM : 0;
+}
+
 static void netkit_uninit(struct net_device *dev);
 
+static void netkit_free(struct net_device *dev)
+{
+	free_percpu(dev->tstats);
+}
+
 static const struct net_device_ops netkit_netdev_ops = {
 	.ndo_open		= netkit_open,
 	.ndo_stop		= netkit_close,
@@ -184,6 +210,8 @@ static const struct net_device_ops netkit_netdev_ops = {
 	.ndo_set_rx_headroom	= netkit_set_headroom,
 	.ndo_get_iflink		= netkit_get_iflink,
 	.ndo_get_peer_dev	= netkit_peer_dev,
+	.ndo_get_stats64	= netkit_get_stats,
+	.ndo_init		= netkit_init,
 	.ndo_uninit		= netkit_uninit,
 	.ndo_features_check	= passthru_features_check,
 };
@@ -235,6 +263,7 @@ static void netkit_setup(struct net_device *dev)
 	dev->vlan_features = dev->features & ~netkit_features_hw_vlan;
 
 	dev->needs_free_netdev = true;
+	dev->priv_destructor = netkit_free;
 
 	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
 }
@@ -911,7 +940,7 @@ static struct rtnl_link_ops netkit_link_ops = {
 	.maxtype	= IFLA_NETKIT_MAX,
 };
 
-static __init int netkit_init(void)
+static __init int netkit_mod_init(void)
 {
 	BUILD_BUG_ON((int)NETKIT_NEXT != (int)TCX_NEXT ||
 		     (int)NETKIT_PASS != (int)TCX_PASS ||
@@ -921,13 +950,13 @@ static __init int netkit_init(void)
 	return rtnl_link_register(&netkit_link_ops);
 }
 
-static __exit void netkit_exit(void)
+static __exit void netkit_mod_exit(void)
 {
 	rtnl_link_unregister(&netkit_link_ops);
 }
 
-module_init(netkit_init);
-module_exit(netkit_exit);
+module_init(netkit_mod_init);
+module_exit(netkit_mod_exit);
 
 MODULE_DESCRIPTION("BPF-programmable network device");
 MODULE_AUTHOR("Daniel Borkmann <daniel@iogearbox.net>");
-- 
2.34.1


