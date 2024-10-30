Return-Path: <bpf+bounces-43527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 124939B5DB9
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A33B216CC
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 08:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE731E32B9;
	Wed, 30 Oct 2024 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OtHix6CL"
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CB61E25EE;
	Wed, 30 Oct 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276712; cv=none; b=pbTHLa6fFyfFcQIyZ3DWdHuMrU4mNxRKUWAvcR/kc23s8JRuzZtpzfOyn5P6haRxoDi7bop745bxaU7JC5rBPwl1QD1b1+DXR+oys22U8ahBnGbeZeJicpGmtWsyZkkEpqZYjC0Ec8I/Y8X2z/Z5s9Lgh8ulLWi3jOd6cDWZ1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276712; c=relaxed/simple;
	bh=AJ9D7oQT6JQ8fedtWVmm4QuaoNdORhTD2UGKdnPIF0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dXXurL5M6E78QnvYQ94oNMAQL1FQlgMWxyzgUmc/Thxg4k2aAn5f0rEVkFbAav59FUoDo7o9N4rHmq59HQFGu611BqgOCb6cyIHif50S5eZODFA192KtC/ZSumTtemXwsar6ClZzuTLwXKfFqYoVhVe/9/y4d8PElVTZp7Ne/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OtHix6CL; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730276701; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XMJHFDmsQxRw6b5sjaO0dd4XVZO5Yi05rgG7tjXVUsg=;
	b=OtHix6CLgoAi+B+mQfVfQwJf5oP+eDhqqE/w0A07bJay2el+tUC9k6ZoXr1Xdhh97dY00vTN+N9WHEfvABN1i4THiLowpLs7/02AViXreKY/1yRNfHnXTbgokkiNATZ0Fknc0pF6yX4Nm5HYxszth4M/0oSiuAtwCvpNeYlQCK0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIDOTjf_1730276699 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 16:25:00 +0800
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
Subject: [PATCH net-next v2 06/13] virtio-net: rq submits premapped per-buffer
Date: Wed, 30 Oct 2024 16:24:46 +0800
Message-Id: <20241030082453.97310-7-xuanzhuo@linux.alibaba.com>
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

virtio-net rq submits premapped per-buffer by setting sg page to NULL;

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 792e9eadbfc3..09757fa408bd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -542,6 +542,12 @@ static struct sk_buff *ptr_to_skb(void *ptr)
 	return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLAG);
 }
 
+static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
+{
+	sg->dma_address = addr;
+	sg->length = len;
+}
+
 static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 			    bool in_napi, struct virtnet_sq_free_stats *stats)
 {
@@ -915,8 +921,7 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	addr = dma->addr - sizeof(*dma) + offset;
 
 	sg_init_table(rq->sg, 1);
-	rq->sg[0].dma_address = addr;
-	rq->sg[0].length = len;
+	sg_fill_dma(rq->sg, addr, len);
 }
 
 static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
@@ -1068,12 +1073,6 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	}
 }
 
-static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
-{
-	sg->dma_address = addr;
-	sg->length = len;
-}
-
 static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
 				   struct receive_queue *rq, void *buf, u32 len)
 {
@@ -1354,7 +1353,8 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 		sg_init_table(rq->sg, 1);
 		sg_fill_dma(rq->sg, addr, len);
 
-		err = virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[i], gfp);
+		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, xsk_buffs[i],
+						    NULL, true, gfp);
 		if (err)
 			goto err;
 	}
@@ -2431,7 +2431,8 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
 
-	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
+	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx,
+					    rq->do_dma, gfp);
 	if (err < 0) {
 		if (rq->do_dma)
 			virtnet_rq_unmap(rq, buf, 0);
@@ -2546,7 +2547,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	virtnet_rq_init_one_sg(rq, buf, len);
 
 	ctx = mergeable_len_to_ctx(len + room, headroom);
-	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
+	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx,
+					    rq->do_dma, gfp);
 	if (err < 0) {
 		if (rq->do_dma)
 			virtnet_rq_unmap(rq, buf, 0);
-- 
2.32.0.3.g01195cf9f


