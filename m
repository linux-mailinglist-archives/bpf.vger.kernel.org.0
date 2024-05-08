Return-Path: <bpf+bounces-29046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 314108BF815
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3560B210C7
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC203FBAF;
	Wed,  8 May 2024 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Es6mZe+B"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEFC446D5;
	Wed,  8 May 2024 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155531; cv=none; b=eoMwdBYBfrtjQiqIgAXsLgbfrAEpJEZ3/t6EB2+rriPE06RvcgpaIX/4DA5AQpjeTym9lqV37HycGN+MPlcjlgDDybiboosE72UrQ9ZJOLsuB2SEtKmwPyZDmrlEPjo75WoEBTHR4FUQnb4JWefr+G7dY/RnWZeOA4lqDs5a84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155531; c=relaxed/simple;
	bh=M6IHOKJRRYPsEuLZjQBxmT2ckffgMam5ZaDdxoQvWNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abLlQmGNTUnnJNZuylTNV5bFYRexEPqsPpUIfd0zOQ43N4fHI87Bz62GjbofgsjjPz7QuY1aDcLc1yJ+o3HYbNIV/FuxaehCgJYUNTuTXsCs7oegw0ll1Mc6VKC3Sebh+9ZS8GLha8fMwT9RuAT/lyZE+pZ2Pc4GP1IKeRT0IcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Es6mZe+B; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715155527; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UGAOD3aYJgOA6zditqst7wDseYupZpLflTPjPNcQfuc=;
	b=Es6mZe+BtYmCruvElm0epdu9Wl+5ScmeAfC4lXaoQHXFQaccTISglEo4s1Dry1rdceqYb2AmlkgSmxcx7qpwgPEW2VE7fPVjqVGaol34cZ+eQquPAuvBEU7vFqLMgvl4QBIpJ0IJqdDlO4zgwdT4UkzpoB8YbLDHeRvzMwvDK68=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W62uyxT_1715155525;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W62uyxT_1715155525)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 16:05:26 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next 7/7] virtio_net: separate receive_buf
Date: Wed,  8 May 2024 16:05:14 +0800
Message-Id: <20240508080514.99458-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 7cdcbabd0b89
Content-Transfer-Encoding: 8bit

This commit separates the function receive_buf(), then we wrap the logic
of handling the skb to an independent function virtnet_receive_done().
The subsequent commit will reuse it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtnet_main.c | 56 ++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/net/virtio/virtnet_main.c b/drivers/net/virtio/virtnet_main.c
index fcfe190300a6..abb8989d2e0a 100644
--- a/drivers/net/virtio/virtnet_main.c
+++ b/drivers/net/virtio/virtnet_main.c
@@ -1713,32 +1713,11 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
 }
 
-static void receive_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
-			void *buf, unsigned int len, void **ctx,
-			unsigned int *xdp_xmit,
-			struct virtnet_rq_stats *stats)
+static void virtnet_receive_done(struct virtnet_info *vi, struct virtnet_rq *rq,
+				 struct sk_buff *skb)
 {
-	struct net_device *dev = vi->dev;
-	struct sk_buff *skb;
 	struct virtio_net_common_hdr *hdr;
-
-	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
-		pr_debug("%s: short packet %i\n", dev->name, len);
-		DEV_STATS_INC(dev, rx_length_errors);
-		virtnet_rq_free_buf(vi, rq, buf);
-		return;
-	}
-
-	if (vi->mergeable_rx_bufs)
-		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
-					stats);
-	else if (vi->big_packets)
-		skb = receive_big(dev, vi, rq, buf, len, stats);
-	else
-		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
-
-	if (unlikely(!skb))
-		return;
+	struct net_device *dev = vi->dev;
 
 	hdr = skb_vnet_common_hdr(skb);
 	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
@@ -1768,6 +1747,35 @@ static void receive_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
 	dev_kfree_skb(skb);
 }
 
+static void receive_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
+			void *buf, unsigned int len, void **ctx,
+			unsigned int *xdp_xmit,
+			struct virtnet_rq_stats *stats)
+{
+	struct net_device *dev = vi->dev;
+	struct sk_buff *skb;
+
+	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
+		pr_debug("%s: short packet %i\n", dev->name, len);
+		DEV_STATS_INC(dev, rx_length_errors);
+		virtnet_rq_free_buf(vi, rq, buf);
+		return;
+	}
+
+	if (vi->mergeable_rx_bufs)
+		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
+					stats);
+	else if (vi->big_packets)
+		skb = receive_big(dev, vi, rq, buf, len, stats);
+	else
+		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
+
+	if (unlikely(!skb))
+		return;
+
+	virtnet_receive_done(vi, rq, skb);
+}
+
 /* Unlike mergeable buffers, all buffers are allocated to the
  * same size, except for the headroom. For this reason we do
  * not need to use  mergeable_len_to_ctx here - it is enough
-- 
2.32.0.3.g01195cf9f


