Return-Path: <bpf+bounces-30512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D8C8CE8C7
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 18:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2F82839FC
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7858812F378;
	Fri, 24 May 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NrBws/lc"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738F912D77F;
	Fri, 24 May 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568586; cv=none; b=CXYNg82X2di1jk16DQMnZLFnxamFEe4aOIngORx/t3lduJ6NIcrOf3AV+5YL+Er+0nmWYG1ov2WpDTaSogTxg4umzCeIOxYUtmLhaXhWMPU4jv0mIRhwUwfypOnkfdPuBoWZyV1NhEgpgQO9JU/3sttQdu7e8lBYfdSoSt9fH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568586; c=relaxed/simple;
	bh=IFFrk2TrmPWk0HrnnuyIUMVYLoUi6g+4npqGyyTK5gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+KxFxLGYaKPsfUF8SrlVlqYSWLEHqqr/dkHMS2e/SOjpCPpb8JoGPLxNf4fgjbC8nHJae3Vc/HvR1wjP3tNR0fMYyo8r1j3LREyclI/bSNCW1TlJA8CWYPCRJNqllx7HHNi4FnkwBT8t+OvEdIPXPG237+qm8h9tMtIMWeV/6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NrBws/lc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=e60LfvlchEiu7e5oiLaH1krDe5mH762VSh8SA9TrKzU=; b=NrBws/lcjYtiPkx6x0nVMFCT2N
	eruacRNFM24Kc/SCmHl2f55tloWNOE1MSuH806A94qhHEmWlXZ8I+d3ulVUOWAeFm6tM32Cruu26W
	0OXnfyLcR6/3MOdZTK8zJvhNNfj0pa8/aIwuwxh3UlMJo7uTsPuwkD5dc4aKCP4wnuJ/gv7Yoaeuf
	DwSEa3uhlAC73wqInjafHXqcSSaCzImFS7mwot8fMU/Hmvb8XYfSIz+pv/FmpWPVmmcjXQTrY6LR1
	4dUrDmafd9VPMxpY1exBaz5nfiWlFIXdBLKv8+pQPwT7Pv3jPiou+y6TWbGSYy3C5Z0tWe5AsLeZn
	zizyxXQA==;
Received: from 14.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.14] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAXu2-000IRO-40; Fri, 24 May 2024 18:36:22 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: razor@blackwall.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 2/4] netkit: Fix pkt_type override upon netkit pass verdict
Date: Fri, 24 May 2024 18:36:17 +0200
Message-Id: <20240524163619.26001-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240524163619.26001-1-daniel@iogearbox.net>
References: <20240524163619.26001-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27285/Fri May 24 10:30:55 2024)

When running Cilium connectivity test suite with netkit in L2 mode, we
found that compared to tcx a few tests were failing which pushed traffic
into an L7 proxy sitting in host namespace. The problem in particular is
around the invocation of eth_type_trans() in netkit.

In case of tcx, this is run before the tcx ingress is triggered inside
host namespace and thus if the BPF program uses the bpf_skb_change_type()
helper the newly set type is retained. However, in case of netkit, the
late eth_type_trans() invocation overrides the earlier decision from the
BPF program which eventually leads to the test failure.

Instead of eth_type_trans(), split out the relevant parts, meaning, reset
of mac header and call to eth_skb_pkt_type() before the BPF program is run
in order to have the same behavior as with tcx, and refactor a small helper
called eth_skb_pull_mac() which is run in case it's passed up the stack
where the mac header must be pulled. With this all connectivity tests pass.

Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c        | 4 +++-
 include/linux/etherdevice.h | 8 ++++++++
 net/ethernet/eth.c          | 4 +---
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 272894053e2c..16789cd446e9 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -55,6 +55,7 @@ static void netkit_prep_forward(struct sk_buff *skb, bool xnet)
 	skb_scrub_packet(skb, xnet);
 	skb->priority = 0;
 	nf_skip_egress(skb, true);
+	skb_reset_mac_header(skb);
 }
 
 static struct netkit *netkit_priv(const struct net_device *dev)
@@ -78,6 +79,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 		     skb_orphan_frags(skb, GFP_ATOMIC)))
 		goto drop;
 	netkit_prep_forward(skb, !net_eq(dev_net(dev), dev_net(peer)));
+	eth_skb_pkt_type(skb, peer);
 	skb->dev = peer;
 	entry = rcu_dereference(nk->active);
 	if (entry)
@@ -85,7 +87,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 	switch (ret) {
 	case NETKIT_NEXT:
 	case NETKIT_PASS:
-		skb->protocol = eth_type_trans(skb, skb->dev);
+		eth_skb_pull_mac(skb);
 		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 		if (likely(__netif_rx(skb) == NET_RX_SUCCESS)) {
 			dev_sw_netstats_tx_add(dev, 1, len);
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 2ad1ffa4ccb9..0ed47d00549b 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -636,6 +636,14 @@ static inline void eth_skb_pkt_type(struct sk_buff *skb,
 	}
 }
 
+static inline struct ethhdr *eth_skb_pull_mac(struct sk_buff *skb)
+{
+	struct ethhdr *eth = (struct ethhdr *)skb->data;
+
+	skb_pull_inline(skb, ETH_HLEN);
+	return eth;
+}
+
 /**
  * eth_skb_pad - Pad buffer to mininum number of octets for Ethernet frame
  * @skb: Buffer to pad
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 049c3adeb850..4e3651101b86 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -161,9 +161,7 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 	skb->dev = dev;
 	skb_reset_mac_header(skb);
 
-	eth = (struct ethhdr *)skb->data;
-	skb_pull_inline(skb, ETH_HLEN);
-
+	eth = eth_skb_pull_mac(skb);
 	eth_skb_pkt_type(skb, dev);
 
 	/*
-- 
2.34.1


