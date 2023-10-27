Return-Path: <bpf+bounces-13474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795097DA0FD
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C12228259E
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7D83CCE0;
	Fri, 27 Oct 2023 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVaYQ2iq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3CC374C5;
	Fri, 27 Oct 2023 18:47:53 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E60B10C3;
	Fri, 27 Oct 2023 11:47:36 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66fbcaf03c6so5839106d6.1;
        Fri, 27 Oct 2023 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698432455; x=1699037255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/a0tTu9/JPEdXuV8EJT0RD0nNZ+OkcyleZ2EfTC0bM=;
        b=ZVaYQ2iqIz9F5TFk7CLpbyBMbcXcwvexEV7SoDSi72/eGV4GwTaRcSyJANW1O+k8VW
         k6ESSNi9IFwfo3c7OWITAlbfsNjwaVUgANzXBvmYNUsOyzpZe4tLFB9rx/uOvDJN7sOq
         zbdAT3BlSo3zWO0VAth8FV4YaB1DDi3QlX4cP1vnLQleLsuMjaG9QcVA8QR7Ljexn5nb
         URA1tRjZbz3zJ0Ho4eYC0xSPTWwGjydtrMst3eDR39pfVAZxu1wS6afI3/qEmHxFEayX
         ZIrJo5Lf9aG4IDp1VTWc9lNkFZEbUGnLB108DjRQQ5UBLYJYH5aQklHexKrFEbAXpXPy
         uuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698432455; x=1699037255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/a0tTu9/JPEdXuV8EJT0RD0nNZ+OkcyleZ2EfTC0bM=;
        b=oALmuctOrMLAKK3sbCrxeWHy7T7K7Fjyx+wIkGLDVTNEzLxPpGV74GeZM3Cfun0quA
         uhd8NXfejxRs355hf3yul9uE6rLIziSlUkQTxpeFpLXHaifB8e2o1Hg4fyHb1Bt0WYZw
         R9+TfbXHv9OfC/MtCkcAiUaV/idezdQ3DkaoC3rwQJ/AeNCmaiT8/DaqJD5u3T8uKO5S
         zo1SOS3N8GomtrRyOYL3R21OD6qwRI6Ln/o+k9UwnZCPnwngpe4/1GD8nmWN/+0y1u0u
         wG5k2r6bFAZ+GJATtygB9+IDlGLvX+0tkBY1fcJY12/TWEQc9TsY5rxlDZ+YWflEAQi5
         sJ3A==
X-Gm-Message-State: AOJu0YzPdyVyqlCGahuX9w6ztODtEaVCFIVSeHtbo6x3ibmlsKXRDQGG
	EMdNdqZbCc3MCwiAgwkXKQ==
X-Google-Smtp-Source: AGHT+IH4eVOUIF76haowlEtb/fcEKTnFPVsn6mTG+2WQozJbnW3yB6tp9L86bBH9YWLUnz06tElP5w==
X-Received: by 2002:a05:6214:21aa:b0:66d:12c7:bf85 with SMTP id t10-20020a05621421aa00b0066d12c7bf85mr4456312qvc.31.1698432455054;
        Fri, 27 Oct 2023 11:47:35 -0700 (PDT)
Received: from n191-129-154.byted.org ([130.44.215.123])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a110100b0076d25b11b62sm773944qkk.38.2023.10.27.11.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 11:47:34 -0700 (PDT)
From: Peilin Ye <yepeilin.cs@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Peilin Ye <peilin.ye@bytedance.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	Jiang Wang <jiang.wang@bytedance.com>,
	Youlun Zhang <zhangyoulun@bytedance.com>,
	Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH net] veth: Fix RX stats for bpf_redirect_peer() traffic
Date: Fri, 27 Oct 2023 18:46:57 +0000
Message-Id: <20231027184657.83978-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peilin Ye <peilin.ye@bytedance.com>

Traffic redirected by bpf_redirect_peer() (used by recent CNIs like
Cilium) is not accounted for in the RX stats of veth devices, confusing
user space metrics collectors such as cAdvisor [1], as reported by
Youlun.

Currently veth devices use the @lstats per-CPU counters, which only
cover TX traffic.  veth_get_stats64() actually collects RX stats of a
veth device from its peer's TX (@lstats) counters, based on the
assumption that a veth device can _only_ receive packets from its peer,
which is no longer true.

Instead, use @tstats to maintain both per-CPU RX and TX traffic counters
for each veth device, and count bpf_redirect_peer() traffic in
skb_do_redirect().

veth_stats_rx() might need a name change (perhaps to "veth_stats_xdp()")
for less confusion, but let's leave it to a separate patch to keep this
fix minimal.

[1] Specifically, the "container_network_receive_{byte,packet}s_total"
    counters are affected.

Reported-by: Youlun Zhang <zhangyoulun@bytedance.com>
Fixes: 9aa1206e8f48 ("bpf: Add redirect_peer helper")
Cc: Jiang Wang <jiang.wang@bytedance.com>
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
---
 drivers/net/veth.c | 36 ++++++++++++++----------------------
 net/core/filter.c  |  1 +
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 9980517ed8b0..df7a7c21a46d 100644
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
@@ -1508,13 +1500,13 @@ static int veth_dev_init(struct net_device *dev)
 {
 	int err;
 
-	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
-	if (!dev->lstats)
+	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!dev->tstats)
 		return -ENOMEM;
 
 	err = veth_alloc_queues(dev);
 	if (err) {
-		free_percpu(dev->lstats);
+		free_percpu(dev->tstats);
 		return err;
 	}
 
@@ -1524,7 +1516,7 @@ static int veth_dev_init(struct net_device *dev)
 static void veth_dev_free(struct net_device *dev)
 {
 	veth_free_queues(dev);
-	free_percpu(dev->lstats);
+	free_percpu(dev->tstats);
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
diff --git a/net/core/filter.c b/net/core/filter.c
index 21d75108c2e9..7aca28b7d0fd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2492,6 +2492,7 @@ int skb_do_redirect(struct sk_buff *skb)
 			     net_eq(net, dev_net(dev))))
 			goto out_drop;
 		skb->dev = dev;
+		dev_sw_netstats_rx_add(dev, skb->len);
 		return -EAGAIN;
 	}
 	return flags & BPF_F_NEIGH ?
-- 
2.20.1


