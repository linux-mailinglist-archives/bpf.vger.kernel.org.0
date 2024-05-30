Return-Path: <bpf+bounces-30943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5CE8D4AD4
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 13:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC5F2828B1
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 11:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A5183A67;
	Thu, 30 May 2024 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oyxYW+lc"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EA217FAD6;
	Thu, 30 May 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068263; cv=none; b=A4BYWyNsacU0vo8gWr6nvQ7l5mYG2eUU7ncNE7jMlBfKtjwohwsZKPhGetSyNqbvnmNXZHBkptaCaF8CDKfboGZHf4K/0sabixQ1M52ZqqQjkku9sAYV+PG+2dfZhcSpGsxWyJBBf7YU2qu7YOCd2CC2lu9VYK2HDpyWcXwSnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068263; c=relaxed/simple;
	bh=tdPoSdIc0Oaxikvfh/2WnEPug/B5tQ8MDGCpIAkFRXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GgaUwnUQ7gR+IFeKytYPY5URIAUyQSHMtgdpciHLISanj64N9FPq6EEf9sYsdx4+9KcIlXUl275A+iDdZwlgx8II49xM5prtJGZ0NsywbTAGkygHIeaRmqqb/kUfEXQ1e3DFwx5YduP3+BLjBFNE9LniuxLyJdtJSTh9tU/sLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oyxYW+lc; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717068259; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DcuYAgvfw57t9kUpYEityIwfKgzkIpU3UuPCoycBsSQ=;
	b=oyxYW+lcsL+TKxe1quHJVoGVHbshiVwz7r2ouk6876knC5GIXMBId9Sl9QqWUsfzz/ZPJ0cL0j3twmdrq08Jwqv5shX5MnF3CUmlZQGXt/0SeKQOYXNdTsymc/SESotGEvs/WU1k7eR1DQtKyxEi13WuY5DUeqXsgpSJzif7ahA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7Ws89W_1717068258;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7Ws89W_1717068258)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 19:24:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 12/12] virtio_net: refactor the xmit type
Date: Thu, 30 May 2024 19:24:06 +0800
Message-Id: <20240530112406.94452-13-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: fcf606ca5ff8
Content-Transfer-Encoding: 8bit

Because the af-xdp and the sq premapped mode will introduce two
new xmit types, so I refactor the xmit type mechanism first.
Then we can add two new xmit types simply by add two new enum.

We can use the last two bits of the pointer to distinguish the xmit type,
so we can distinguish four xmit types.

Now we have two xmit types: SKB and XDP.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtnet_main.c | 58 +++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/virtio/virtnet_main.c b/drivers/net/virtio/virtnet_main.c
index 60ef7bb2228d..3ec821106c1d 100644
--- a/drivers/net/virtio/virtnet_main.c
+++ b/drivers/net/virtio/virtnet_main.c
@@ -47,8 +47,6 @@ module_param(napi_tx, bool, 0644);
 #define VIRTIO_XDP_TX		BIT(0)
 #define VIRTIO_XDP_REDIR	BIT(1)
 
-#define VIRTIO_XDP_FLAG	BIT(0)
-
 #define VIRTNET_DRIVER_VERSION "1.0.0"
 
 static const unsigned long guest_offloads[] = {
@@ -260,42 +258,62 @@ struct virtio_net_common_hdr {
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 
-static bool is_xdp_frame(void *ptr)
+enum virtnet_xmit_type {
+	VIRTNET_XMIT_TYPE_SKB,
+	VIRTNET_XMIT_TYPE_XDP,
+};
+
+#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP)
+
+static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
 {
-	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
+	unsigned long p = (unsigned long)*ptr;
+
+	*ptr = (void *)(p & ~VIRTNET_XMIT_TYPE_MASK);
+
+	return p & VIRTNET_XMIT_TYPE_MASK;
 }
 
-static void *xdp_to_ptr(struct xdp_frame *ptr)
+static void *virtnet_xmit_ptr_mix(void *ptr, enum virtnet_xmit_type type)
 {
-	return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
+	return (void *)((unsigned long)ptr | type);
 }
 
-static struct xdp_frame *ptr_to_xdp(void *ptr)
+static int virtnet_add_outbuf(struct virtnet_sq *sq, int num, void *data,
+			      enum virtnet_xmit_type type)
 {
-	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
+	return virtqueue_add_outbuf(sq->vq, sq->sg, num,
+				    virtnet_xmit_ptr_mix(data, type),
+				    GFP_ATOMIC);
 }
 
 static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 			    struct virtnet_sq_free_stats *stats)
 {
+	struct xdp_frame *frame;
+	struct sk_buff *skb;
 	unsigned int len;
 	void *ptr;
 
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		++stats->packets;
 
-		if (!is_xdp_frame(ptr)) {
-			struct sk_buff *skb = ptr;
+		switch (virtnet_xmit_ptr_strip(&ptr)) {
+		case VIRTNET_XMIT_TYPE_SKB:
+			skb = ptr;
 
 			pr_debug("Sent skb %p\n", skb);
 
 			stats->bytes += skb->len;
 			napi_consume_skb(skb, in_napi);
-		} else {
-			struct xdp_frame *frame = ptr_to_xdp(ptr);
+			break;
+
+		case VIRTNET_XMIT_TYPE_XDP:
+			frame = ptr;
 
 			stats->bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
+			break;
 		}
 	}
 }
@@ -833,8 +851,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 			    skb_frag_size(frag), skb_frag_off(frag));
 	}
 
-	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
-				   xdp_to_ptr(xdpf), GFP_ATOMIC);
+	err = virtnet_add_outbuf(sq, nr_frags + 1, xdpf, VIRTNET_XMIT_TYPE_XDP);
 	if (unlikely(err))
 		return -ENOSPC; /* Caller handle free/refcnt */
 
@@ -2343,7 +2360,7 @@ static int xmit_skb(struct virtnet_sq *sq, struct sk_buff *skb)
 			return num_sg;
 		num_sg++;
 	}
-	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
+	return virtnet_add_outbuf(sq, num_sg, skb, VIRTNET_XMIT_TYPE_SKB);
 }
 
 static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -5051,10 +5068,15 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
-	if (!is_xdp_frame(buf))
+	switch (virtnet_xmit_ptr_strip(&buf)) {
+	case VIRTNET_XMIT_TYPE_SKB:
 		dev_kfree_skb(buf);
-	else
-		xdp_return_frame(ptr_to_xdp(buf));
+		break;
+
+	case VIRTNET_XMIT_TYPE_XDP:
+		xdp_return_frame(buf);
+		break;
+	}
 }
 
 static void free_unused_bufs(struct virtnet_info *vi)
-- 
2.32.0.3.g01195cf9f


