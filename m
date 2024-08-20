Return-Path: <bpf+bounces-37599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC16B957FCA
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 09:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F0C1F22E91
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 07:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF05318A6D0;
	Tue, 20 Aug 2024 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="il0cDl/v"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED1189BA0;
	Tue, 20 Aug 2024 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139223; cv=none; b=hD6tXmLZV+fz/gBLCOVMRh0muLLhZE3drkKXiKKKfLMpPR8oaHyUaAkPkin7mkwU/vXl75fhZsCJVMZaTgdJ3/D8xdwWzUFHZVSjo4V5R0XoEp7kfqmlNxkcDKFPuIizMFyNJ9p9OYqfxUyZwmJZ1L92GQk0Ivnw4zaU2eCyV/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139223; c=relaxed/simple;
	bh=LUB1UpR90U48foI1auUrwk6knVsthHGGHTS1BClQDBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eodC/xTVGWfD3SLqdFW5Q2wZdA/gQ4RnH+YUfGcyVtvYdyJQ/wEKXYRAYz1VgND/BDExsO2pQmBMjOuSPYvk39Sse0tkbxpvJvfBTI3eH1TsP8elp3wko96nzmqwwgPTIQBKK1yacUGSm4ZDq7t/qYKaXnYJYDGjZqbHnfNOh9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=il0cDl/v; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724139217; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=44Vo+P2JdG9HJ3DR2kFrWtdm6mxsHIKx9tFqv2Pv0zk=;
	b=il0cDl/vTWptAX0lLFJxZtneRo5lYdvdb39d6XQ2RDnE/xMl5+Uh+q8SnprfYinfoyXc1lH/OQwGMB6vvf/lzAAhBTcKLjhCrq2r2Mqc+5gDhS5N/EANXAYXXyw44HQQ6psoMfuufLD/AaC5ZcUKYTJFG6N/GsryEFLh6AAEnlk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WDHh9jB_1724139215)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 15:33:36 +0800
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
Subject: [PATCH net-next 05/13] virtio-net: rq submits premapped buffer per buffer
Date: Tue, 20 Aug 2024 15:33:22 +0800
Message-Id: <20240820073330.9161-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: b206d29d23af
Content-Transfer-Encoding: 8bit

virtio-net rq submits premapped buffer per buffer.
And removes the call of the virtnet_rq_set_premapped().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6c79fc43fa31..41aaea3b90fd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -539,6 +539,13 @@ static struct sk_buff *ptr_to_skb(void *ptr)
 	return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLAG);
 }
 
+static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
+{
+	sg_assign_page(sg, NULL);
+	sg->dma_address = addr;
+	sg->length = len;
+}
+
 static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 			    bool in_napi, struct virtnet_sq_free_stats *stats)
 {
@@ -907,8 +914,7 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	addr = dma->addr - sizeof(*dma) + offset;
 
 	sg_init_table(rq->sg, 1);
-	rq->sg[0].dma_address = addr;
-	rq->sg[0].length = len;
+	sg_fill_dma(&rq->sg[0], addr, len);
 }
 
 static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
@@ -967,19 +973,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 	return buf;
 }
 
-static void virtnet_rq_set_premapped(struct virtnet_info *vi)
-{
-	int i;
-
-	/* disable for big mode */
-	if (!vi->mergeable_rx_bufs && vi->big_packets)
-		return;
-
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		/* error should never happen */
-		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
-}
-
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
@@ -1071,12 +1064,6 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
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
@@ -6109,8 +6096,6 @@ static int init_vqs(struct virtnet_info *vi)
 	if (ret)
 		goto err_free;
 
-	virtnet_rq_set_premapped(vi);
-
 	cpus_read_lock();
 	virtnet_set_affinity(vi);
 	cpus_read_unlock();
-- 
2.32.0.3.g01195cf9f


