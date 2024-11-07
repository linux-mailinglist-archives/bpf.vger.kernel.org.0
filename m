Return-Path: <bpf+bounces-44205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF919C0085
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 09:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C0D2834E6
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78BE1DD867;
	Thu,  7 Nov 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jnXAvSgN"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE9F1DD543;
	Thu,  7 Nov 2024 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969716; cv=none; b=HZNFhrAqoX+8hATTdOBiPOWUchaFo6ytNpymWLKb13xo80X3IgKOzEsdpo2GInkccogubgoQLoam80k1U4PBf79+XS3vSFHiIFr6Rcnuvarl5qbgHGbjRH3b9nh1S0Y+A0DBPctk+ueabQtc+I/iDRTVUeX7Yb9WIMYt4ATRE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969716; c=relaxed/simple;
	bh=OLL51eOxgF6EA/BUCu9JHkdInS8Hr8nFmCDwfuCPuUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EBE563z/ibur7uTfwuLV/SYKAoGn8i3wYZD985G/0AQl0T/2Qop6SVGVWmJ7fqIp2TEk8y1U3aK0uha3ieL2m/m5s7slje7INcgb4bXd3kb05rQB+X4cqBTTkk9y2mvRNpmlo44ShwTDDGbl0vbKQx3S0cdb22t9Dsl/jLmc5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jnXAvSgN; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730969711; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gbAhWwtmNWJP1qvm4V1+2kl2EwcvK2UuAErUIu7yeUM=;
	b=jnXAvSgNtWJwWhXLWNwVmlEyCd98bWIaSYxvgmA84IN0rHhyqsCpWM6uN8CInWixOd5w/3n+XUj6iq8H14njTXtFFpqrlSESbzkokLOHuF+2Y2L8qfG7xSbTTquyDzL7L3RJNonQsr41tuXFcBBuloSirA0KzITmPvDmy8+t8jc=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIv0ukG_1730969710 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 16:55:11 +0800
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
Subject: [PATCH net-next v3 06/13] virtio-net: rq submits premapped per-buffer
Date: Thu,  7 Nov 2024 16:54:57 +0800
Message-Id: <20241107085504.63131-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 2634baada01d
Content-Transfer-Encoding: 8bit

virtio-net rq submits premapped per-buffer by setting sg page to NULL;

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4b27ded8fc16..862beacef5d7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -539,6 +539,12 @@ static struct sk_buff *ptr_to_skb(void *ptr)
 	return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLAG);
 }
 
+static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
+{
+	sg_dma_address(sg) = addr;
+	sg_dma_len(sg) = len;
+}
+
 static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 			    bool in_napi, struct virtnet_sq_free_stats *stats)
 {
@@ -916,8 +922,7 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	addr = dma->addr - sizeof(*dma) + offset;
 
 	sg_init_table(rq->sg, 1);
-	rq->sg[0].dma_address = addr;
-	rq->sg[0].length = len;
+	sg_fill_dma(rq->sg, addr, len);
 }
 
 static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
@@ -1067,12 +1072,6 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
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
@@ -1353,7 +1352,8 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 		sg_init_table(rq->sg, 1);
 		sg_fill_dma(rq->sg, addr, len);
 
-		err = virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[i], gfp);
+		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
+						    xsk_buffs[i], NULL, gfp);
 		if (err)
 			goto err;
 	}
@@ -2433,7 +2433,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
 
-	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
+	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
 		virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
@@ -2553,7 +2553,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	virtnet_rq_init_one_sg(rq, buf, len);
 
 	ctx = mergeable_len_to_ctx(len + room, headroom);
-	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
+	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
 		virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
-- 
2.32.0.3.g01195cf9f


