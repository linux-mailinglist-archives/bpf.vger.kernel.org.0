Return-Path: <bpf+bounces-34891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D289320B1
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 08:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F7A1C218B9
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 06:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA8179B84;
	Tue, 16 Jul 2024 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="saFgceen"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780A4315F;
	Tue, 16 Jul 2024 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112406; cv=none; b=LRZJ+hHCbYEQYr2SE7S+J1SeY2z6pTppSlhX7endvr7iS2UMV6CJAZwZd0YXzI0MZaNzaMh06esUR7cw/MVD1Exfz4R8s8gXXWTDXtE+f0gnA7R9688AdCB/8r62AsAa64xlU6Fbb0qDp98VduRWmirMVl9Q6lKbwcYmDnUPb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112406; c=relaxed/simple;
	bh=0C5+FDJY0BXZ4xDdxz+ej1I37yo3lwQlgPgTRpQAsj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ScABrmCKWuJdKsBWQyS+4t4c97Xx/F8A2RLtpUKskZY22kksjrdYDAWB3h8SHCLvv8pZrBc7+jOJEeOCFALMG8hICfPjZyr/0tfSnGAKu4aLcicmyNCrZQs66iky79ShFIlU/WhM4af7mP/a60LdfM524tmw8nyNLpBLmiVHO0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=saFgceen; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721112396; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kzG6BmesP3ErofVGTifad/vz8//tve2WHW3/xWHmFQY=;
	b=saFgceenxNU3D8pUxWA6QlO6N2kk1qQpKbbpRzfeyA7D6xtfovK2EyPnfNMT2xHZmusY1Faz1d9VeMv/8SoNBVVLz2WG3TzUvY5LfmpQey5GyE0vI2ltALi5fwJe0aDEH6vPeEksVV7wjkXtFhliYd23mqgplQzkcWvetcEJoCk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WAgbUiw_1721112395;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WAgbUiw_1721112395)
          by smtp.aliyun-inc.com;
          Tue, 16 Jul 2024 14:46:35 +0800
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
Subject: [RFC net-next 07/13] virtio_net: refactor the xmit type
Date: Tue, 16 Jul 2024 14:46:22 +0800
Message-Id: <20240716064628.1950-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
References: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: d3e48bf059c8
Content-Transfer-Encoding: 8bit

Because the af-xdp will introduce a new xmit type, so I refactor the
xmit type mechanism first.

We use the last two bits of the pointer to distinguish the xmit type,
so we can distinguish four xmit types. Now we have three types: skb,
orphan and xdp.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 90 +++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ce83826df90f..f5edd8be4668 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -45,9 +45,6 @@ module_param(napi_tx, bool, 0644);
 #define VIRTIO_XDP_TX		BIT(0)
 #define VIRTIO_XDP_REDIR	BIT(1)
 
-#define VIRTIO_XDP_FLAG		BIT(0)
-#define VIRTIO_ORPHAN_FLAG	BIT(1)
-
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
  * at once, the weight is chosen so that the EWMA will be insensitive to short-
@@ -509,34 +506,35 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize);
 
-static bool is_xdp_frame(void *ptr)
-{
-	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
-}
+enum virtnet_xmit_type {
+	VIRTNET_XMIT_TYPE_SKB,
+	VIRTNET_XMIT_TYPE_ORPHAN,
+	VIRTNET_XMIT_TYPE_XDP,
+};
 
-static void *xdp_to_ptr(struct xdp_frame *ptr)
-{
-	return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
-}
+#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_ORPHAN \
+				| VIRTNET_XMIT_TYPE_XDP)
 
-static struct xdp_frame *ptr_to_xdp(void *ptr)
+static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
 {
-	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
-}
+	unsigned long p = (unsigned long)*ptr;
 
-static bool is_orphan_skb(void *ptr)
-{
-	return (unsigned long)ptr & VIRTIO_ORPHAN_FLAG;
+	*ptr = (void *)(p & ~VIRTNET_XMIT_TYPE_MASK);
+
+	return p & VIRTNET_XMIT_TYPE_MASK;
 }
 
-static void *skb_to_ptr(struct sk_buff *skb, bool orphan)
+static void *virtnet_xmit_ptr_mix(void *ptr, enum virtnet_xmit_type type)
 {
-	return (void *)((unsigned long)skb | (orphan ? VIRTIO_ORPHAN_FLAG : 0));
+	return (void *)((unsigned long)ptr | type);
 }
 
-static struct sk_buff *ptr_to_skb(void *ptr)
+static int virtnet_add_outbuf(struct send_queue *sq, int num, void *data,
+			      enum virtnet_xmit_type type)
 {
-	return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLAG);
+	return virtqueue_add_outbuf(sq->vq, sq->sg, num,
+				    virtnet_xmit_ptr_mix(data, type),
+				    GFP_ATOMIC);
 }
 
 static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
@@ -549,29 +547,37 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 			    bool in_napi, struct virtnet_sq_free_stats *stats)
 {
+	struct xdp_frame *frame;
+	struct sk_buff *skb;
 	unsigned int len;
 	void *ptr;
 
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		if (!is_xdp_frame(ptr)) {
-			struct sk_buff *skb = ptr_to_skb(ptr);
+		switch (virtnet_xmit_ptr_strip(&ptr)) {
+		case VIRTNET_XMIT_TYPE_SKB:
+			skb = ptr;
 
 			pr_debug("Sent skb %p\n", skb);
+			stats->napi_packets++;
+			stats->napi_bytes += skb->len;
+			napi_consume_skb(skb, in_napi);
+			break;
 
-			if (is_orphan_skb(ptr)) {
-				stats->packets++;
-				stats->bytes += skb->len;
-			} else {
-				stats->napi_packets++;
-				stats->napi_bytes += skb->len;
-			}
+		case VIRTNET_XMIT_TYPE_ORPHAN:
+			skb = ptr;
+
+			stats->packets++;
+			stats->bytes += skb->len;
 			napi_consume_skb(skb, in_napi);
-		} else {
-			struct xdp_frame *frame = ptr_to_xdp(ptr);
+			break;
+
+		case VIRTNET_XMIT_TYPE_XDP:
+			frame = ptr;
 
 			stats->packets++;
 			stats->bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
+			break;
 		}
 	}
 	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
@@ -1421,8 +1427,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 			    skb_frag_size(frag), skb_frag_off(frag));
 	}
 
-	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
-				   xdp_to_ptr(xdpf), GFP_ATOMIC);
+	err = virtnet_add_outbuf(sq, nr_frags + 1, xdpf, VIRTNET_XMIT_TYPE_XDP);
 	if (unlikely(err))
 		return -ENOSPC; /* Caller handle free/refcnt */
 
@@ -3000,8 +3005,9 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 			return num_sg;
 		num_sg++;
 	}
-	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg,
-				    skb_to_ptr(skb, orphan), GFP_ATOMIC);
+
+	return virtnet_add_outbuf(sq, num_sg, skb,
+				  orphan ? VIRTNET_XMIT_TYPE_ORPHAN : VIRTNET_XMIT_TYPE_SKB);
 }
 
 static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -5877,10 +5883,16 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
-	if (!is_xdp_frame(buf))
+	switch (virtnet_xmit_ptr_strip(&buf)) {
+	case VIRTNET_XMIT_TYPE_SKB:
+	case VIRTNET_XMIT_TYPE_ORPHAN:
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


