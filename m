Return-Path: <bpf+bounces-15019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1347EA7A5
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 01:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE3C281057
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 00:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81946A4;
	Tue, 14 Nov 2023 00:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="g//291w+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D576BA50;
	Tue, 14 Nov 2023 00:42:38 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08B5189;
	Mon, 13 Nov 2023 16:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=s3xKXzO+yiGaZ7l2RVjfaCH3AkwTeqQoZKIKWlL7Hks=; b=g//291w+TbAfb6HL9SnNp719Op
	YXRrwKgbn4TLw69uQopbVEvVb5W1Ng6UjoI9VLcp/RUFuXvV90vVYE77JDe1sHO54p58bufCkmP9w
	6Z5VlWuGKevLy0ozj6EdaJ/7rKt/3dJa/DnKxwU0VMrNx+x8f8sVxyv0FVNySyQLORWI8gc/TdBI+
	b9WvIZ6kohhcsT+m459DP/R9L5JTMsQzCjnurrIHI4o3drSPyM9MxhqpD0tPNrjwsV8ltSv6sH6XL
	irKl2KEUyj6X+puIJ0OYlxpJrA3ed9LG28CdrRjONA97E4QUQDFVkozn/kSAXlIXZO7N34zBJYxS/
	FZEIHuNg==;
Received: from mob-194-230-158-57.cgn.sunrise.net ([194.230.158.57] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2hVi-0006Tl-Hf; Tue, 14 Nov 2023 01:42:35 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: kuba@kernel.org,
	razor@blackwall.org,
	sdf@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH bpf v3 1/8] net, vrf: Move dstats structure to core
Date: Tue, 14 Nov 2023 01:42:13 +0100
Message-Id: <20231114004220.6495-2-daniel@iogearbox.net>
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

Just move struct pcpu_dstats out of the vrf into the core, and streamline
the field names slightly, so they better align with the {t,l}stats ones.

No functional change otherwise. A conversion of the u64s to u64_stats_t
could be done at a separate point in future. This move is needed as we are
moving the {t,l,d}stats allocation/freeing to the core.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
---
 drivers/net/vrf.c         | 24 +++++++-----------------
 include/linux/netdevice.h | 10 ++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index db766941b78f..3e6e0fdc3ba7 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -121,22 +121,12 @@ struct net_vrf {
 	int			ifindex;
 };
 
-struct pcpu_dstats {
-	u64			tx_pkts;
-	u64			tx_bytes;
-	u64			tx_drps;
-	u64			rx_pkts;
-	u64			rx_bytes;
-	u64			rx_drps;
-	struct u64_stats_sync	syncp;
-};
-
 static void vrf_rx_stats(struct net_device *dev, int len)
 {
 	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
 
 	u64_stats_update_begin(&dstats->syncp);
-	dstats->rx_pkts++;
+	dstats->rx_packets++;
 	dstats->rx_bytes += len;
 	u64_stats_update_end(&dstats->syncp);
 }
@@ -161,10 +151,10 @@ static void vrf_get_stats64(struct net_device *dev,
 		do {
 			start = u64_stats_fetch_begin(&dstats->syncp);
 			tbytes = dstats->tx_bytes;
-			tpkts = dstats->tx_pkts;
-			tdrops = dstats->tx_drps;
+			tpkts = dstats->tx_packets;
+			tdrops = dstats->tx_drops;
 			rbytes = dstats->rx_bytes;
-			rpkts = dstats->rx_pkts;
+			rpkts = dstats->rx_packets;
 		} while (u64_stats_fetch_retry(&dstats->syncp, start));
 		stats->tx_bytes += tbytes;
 		stats->tx_packets += tpkts;
@@ -421,7 +411,7 @@ static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
 		vrf_rx_stats(dev, len);
 	else
-		this_cpu_inc(dev->dstats->rx_drps);
+		this_cpu_inc(dev->dstats->rx_drops);
 
 	return NETDEV_TX_OK;
 }
@@ -616,11 +606,11 @@ static netdev_tx_t vrf_xmit(struct sk_buff *skb, struct net_device *dev)
 		struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
 
 		u64_stats_update_begin(&dstats->syncp);
-		dstats->tx_pkts++;
+		dstats->tx_packets++;
 		dstats->tx_bytes += len;
 		u64_stats_update_end(&dstats->syncp);
 	} else {
-		this_cpu_inc(dev->dstats->tx_drps);
+		this_cpu_inc(dev->dstats->tx_drops);
 	}
 
 	return ret;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a16c9cc063fe..98082113156e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2755,6 +2755,16 @@ struct pcpu_sw_netstats {
 	struct u64_stats_sync   syncp;
 } __aligned(4 * sizeof(u64));
 
+struct pcpu_dstats {
+	u64			rx_packets;
+	u64			rx_bytes;
+	u64			rx_drops;
+	u64			tx_packets;
+	u64			tx_bytes;
+	u64			tx_drops;
+	struct u64_stats_sync	syncp;
+} __aligned(8 * sizeof(u64));
+
 struct pcpu_lstats {
 	u64_stats_t packets;
 	u64_stats_t bytes;
-- 
2.34.1


