Return-Path: <bpf+bounces-34892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411E39320B3
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 08:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01E9B20AED
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 06:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A413D13A88D;
	Tue, 16 Jul 2024 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rfFbIv7j"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF103611B;
	Tue, 16 Jul 2024 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112406; cv=none; b=lCS4uOxUKRNlPT7M8AHjESK6vqKtlnaC78uuVwVPRok+J0xYlKsK/p29tHYprtI/WCL1f083CWLtlHjHcQK9Mt2Dl3fmmtl+pfZh0RtLYGZw1euR8P85RzYTiCOCGugr8Z6HTUTsk4nZpzAHPSpfA3ZLXxEXiCZDPiCbbkqF1oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112406; c=relaxed/simple;
	bh=Fo0tLIRdCpCNr3DcPkSLf0thbd11uDRBZaotNgPF6og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXAsxZSFFMfbDkIu9Wa9+pNgV9I65VPSr8AcnZLeTTWwx8qHaeA4/SWEPIUhgEJrZrvPp6mvN+aXibuL2k6XeL/Hk7gmNQajM4j7R1QXJdQ1VwB20YZqAP6snNZJZmdqr+HoPTchTbjvjJeoS6iJ+M1jDace4y7QyGOM19RHUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rfFbIv7j; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721112395; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mwmfqBaZ7Ox3HOKtuwZ+8paiPA3duaqjUnc9bH3Pg30=;
	b=rfFbIv7jdwsZLMZ6XZY29KD5z4/qN/su9NoH50WyIJ5CllE1Y74N2sCTkoKU8rT6LsWqPaurboLBbiJgj1iHXj94zJ3AqSA5kNVGLZvmkwzRIhNM7QPoKTBUc2iwMXxB6LTK6uf45KY844caUO+7bcmx2oZAeKaMOqod/cQxAII=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WAgbUhp_1721112393;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WAgbUhp_1721112393)
          by smtp.aliyun-inc.com;
          Tue, 16 Jul 2024 14:46:33 +0800
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
Subject: [RFC net-next 05/13] virtio-net: rq submits premapped buffer per buffer
Date: Tue, 16 Jul 2024 14:46:20 +0800
Message-Id: <20240716064628.1950-6-xuanzhuo@linux.alibaba.com>
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

virtio-net rq submits premapped buffer per buffer.
And removes the call of the virtnet_rq_set_premapped().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index af474cc191d0..ce83826df90f 100644
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
@@ -6088,8 +6075,6 @@ static int init_vqs(struct virtnet_info *vi)
 	if (ret)
 		goto err_free;
 
-	virtnet_rq_set_premapped(vi);
-
 	cpus_read_lock();
 	virtnet_set_affinity(vi);
 	cpus_read_unlock();
-- 
2.32.0.3.g01195cf9f


