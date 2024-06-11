Return-Path: <bpf+bounces-31824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25816903AD3
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9A7282722
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E70217FAAA;
	Tue, 11 Jun 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OvX63dSc"
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F196917F4F8;
	Tue, 11 Jun 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106120; cv=none; b=S66VBWDjN5Jn49yP02078aMtrQDjnoBk1Oyh5AdHDnf/kolZvoMraCCAFHFhhoPFA6tiNTGBmyZcopd4T7aQsWBuQMhx+iLEZcDPfXbNl+7mSqdd9hgNeLObK7M7IcN6Ea4b15QDgCFJ06Jdiw5xOhrw1iWe1agktHIvGFcrBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106120; c=relaxed/simple;
	bh=4seTsozVSv+ezpete5JyfgV166HQrZcU8nGvlj7gUss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOnHtpUqk/MCiX1qyvf1QPf0P21YSLLCaWKJ1Z9olTKKnsVC3noAO3kZhm6ybxUyJgE3LD9/gTMNQTlv/Ye38Bp4cQsdsxkBFBJlpWsr/OqHhE+8y3RRugVUtw1fLBpUPRJb5TerFNpgpIHdJYcA+qIpXV3BhASi3pxfsehoQPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OvX63dSc; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718106116; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=npQee9M15+Lo4pMMFfrdbZsJ16sd84cpsyzjvN2BTSw=;
	b=OvX63dSc1A6v2NjlpvaOIPi6YATbbh+uERrkxqgMFMo5TQQQgD76eIE253/YIdQUuSpWc7KkwFPejsbyGUPaAQjGrsR3JuaOux7wu4uKrHWq9rKBGsbIwX22Urw+ppF6mbQ9fzuN2qTy1oV5iI+R+rVb1BnVIRiYDAGq/wKxGvM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8GMZNM_1718106114;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8GMZNM_1718106114)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 19:41:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 06/15] virtio_net: separate receive_buf
Date: Tue, 11 Jun 2024 19:41:38 +0800
Message-Id: <20240611114147.31320-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: c1658a8c15b0
Content-Transfer-Encoding: 8bit

This commit separates the function receive_buf(), then we wrap the logic
of handling the skb to an independent function virtnet_receive_done().
The subsequent commit will reuse it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 56 +++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8c51947abce9..161694957065 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1935,32 +1935,11 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
 }
 
-static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
-			void *buf, unsigned int len, void **ctx,
-			unsigned int *xdp_xmit,
-			struct virtnet_rq_stats *stats)
+static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
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
@@ -1990,6 +1969,35 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	dev_kfree_skb(skb);
 }
 
+static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
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


