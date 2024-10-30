Return-Path: <bpf+bounces-43524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5559B5DAD
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8125F1C212D1
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D481A1E260D;
	Wed, 30 Oct 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R4x1J/IL"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C441E1C3F;
	Wed, 30 Oct 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276709; cv=none; b=AaD1dut2u7ob0PbSHWCoAkxrLSfYcj+MRqbwAYjR3ZthANuKtI88Lhxwpmq9za31PRGLGXBbIZzyAHEbrFzAHQcD7sKjDR3WMR/5o884UUoz8hMdBCiJaBXAOutYI5m4K+iqO+dbYD2NuIbVbpJkGlCpguaI1AbCKEzZuf/SD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276709; c=relaxed/simple;
	bh=kEGfIjeXQr0v+Tit9Ms5/f/Wn4GKquaKQOBthIrf1Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M1mHrk4EIkLghRvUbQ2XuFvQ1uWrGpdUK3HqZiNIhBoMpWdrS79ZW272sdsOyTbxcLn4cdsxuoZig2Jddkksef1oc8JuTQ6keY7Lxpv5m/O35ewGQWdpAZDWhG+8vcVTwo6SOV0zEKmbf9q4evLOsi7z2Ci+Z0seJ4hG3uQamZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R4x1J/IL; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730276702; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=crJSwD/Qm8hhmC5AxXbd1FqTa2S83hUr2tP6ia6viQI=;
	b=R4x1J/ILnwxO/PJFdawKRzmft2sU15czxUULLKOGbw+xYu+AUqu4rRhDsHcnjLs8Nk+HAKMVR4xT5nw6OtkXObZY1UGfhW8aTSboiATfDwFh11E4uzXv6O0kS0gCZ+6CSRy2WXqN11F+Usb0jRWivf0Hwpqz8FgiGpqVVMyCbA0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIDOTko_1730276701 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 16:25:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH net-next v2 08/13] virtio_net: refactor the xmit type
Date: Wed, 30 Oct 2024 16:24:48 +0800
Message-Id: <20241030082453.97310-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 87bfcb32ef14
Content-Transfer-Encoding: 8bit

Because the af-xdp will introduce a new xmit type, so I refactor the
xmit type mechanism first.

We know both xdp_frame and sk_buff are at least 4 bytes aligned.
For the xdp tx, we do not pass any pointer to virtio core as data,
we just need to pass the len of the packet. So we will push len
to the void pointer. We can make sure the pointer is 4 bytes aligned.

And the data structure of AF_XDP also is at least 4 bytes aligned.

So the last two bits of the pointers are free, we can't use these to
distinguish them.

    00 for skb
    01 for SKB_ORPHAN
    10 for XDP
    11 for AF-XDP tx

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 90 +++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 09757fa408bd..37e86e0a1d8e 100644
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
@@ -512,34 +509,35 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize);
 
-static bool is_xdp_frame(void *ptr)
-{
-	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
-}
+enum virtnet_xmit_type {
+	VIRTNET_XMIT_TYPE_SKB,
+	VIRTNET_XMIT_TYPE_SKB_ORPHAN,
+	VIRTNET_XMIT_TYPE_XDP,
+};
 
-static void *xdp_to_ptr(struct xdp_frame *ptr)
-{
-	return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
-}
+/* We use the last two bits of the pointer to distinguish the xmit type. */
+#define VIRTNET_XMIT_TYPE_MASK (BIT(0) | BIT(1))
 
-static struct xdp_frame *ptr_to_xdp(void *ptr)
+static enum virtnet_xmit_type virtnet_xmit_ptr_unpack(void **ptr)
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
+static void *virtnet_xmit_ptr_pack(void *ptr, enum virtnet_xmit_type type)
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
+				    virtnet_xmit_ptr_pack(data, type),
+				    GFP_ATOMIC);
 }
 
 static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
@@ -551,29 +549,37 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
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
+		switch (virtnet_xmit_ptr_unpack(&ptr)) {
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
+		case VIRTNET_XMIT_TYPE_SKB_ORPHAN:
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
@@ -1431,8 +1437,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 			    skb_frag_size(frag), skb_frag_off(frag));
 	}
 
-	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
-				   xdp_to_ptr(xdpf), GFP_ATOMIC);
+	err = virtnet_add_outbuf(sq, nr_frags + 1, xdpf, VIRTNET_XMIT_TYPE_XDP);
 	if (unlikely(err))
 		return -ENOSPC; /* Caller handle free/refcnt */
 
@@ -3048,8 +3053,9 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 			return num_sg;
 		num_sg++;
 	}
-	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg,
-				    skb_to_ptr(skb, orphan), GFP_ATOMIC);
+
+	return virtnet_add_outbuf(sq, num_sg, skb,
+				  orphan ? VIRTNET_XMIT_TYPE_SKB_ORPHAN : VIRTNET_XMIT_TYPE_SKB);
 }
 
 static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -5926,10 +5932,16 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
-	if (!is_xdp_frame(buf))
+	switch (virtnet_xmit_ptr_unpack(&buf)) {
+	case VIRTNET_XMIT_TYPE_SKB:
+	case VIRTNET_XMIT_TYPE_SKB_ORPHAN:
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


