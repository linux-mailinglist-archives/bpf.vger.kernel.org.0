Return-Path: <bpf+bounces-29011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBE48BF47D
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 04:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F5A1C23583
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 02:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C863BE7F;
	Wed,  8 May 2024 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EHGcPwfa"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B21A2C25;
	Wed,  8 May 2024 02:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135028; cv=none; b=gvMsGpz6c8TSMR003aBXG5Zk6d8pvGcTHGYztnF7vHUZOT2eue+zJDVF6IFODwuU9YjJjUKalJg/AOAkXUQNMusnueDzk5ySj8nhGfoH0AoEYrn9SzazxjmKGguvmYGj7ObloYtinF2OJpn6FG55t95SvZ1KZsDmR69slCyHiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135028; c=relaxed/simple;
	bh=D0LZB1jqUO4M2Lu/Kb0xMb37tvHIxAOAL5WwMRt0I2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBdt088zmjHnwkLB+XxNlD0B5wbc6cLAEBQTF9cbm+ElWWGzIkgruFwSX/+NOKkgI2OIGJlPWL3kitxbLr1aStSuvn0rq+hHzlfsNKJC+TVYP1YDKbjW1qHq+VmsHmJ/53xR1D2GRDYIc3182Kc8EwAJu/wXoSTaJhbI6/2ZDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EHGcPwfa; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715135018; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SguPATYh4XBUzhYH0ZZ/UftrHp+cShC1ybwgVBb53fA=;
	b=EHGcPwfabjBuCdSS18AOZjjp3EkmFKd0RMFrpuToizVH/hPs6t9U+Q5ub54xUFujCHEpNRHLDU2TlEs1AKflfighzowspjcjQcYqLWWCFv1AN/mHxTj+hHpyYeg03zjQb7PcDefPap6f0EAqxyErvxdyj1smq4m9066VUtOOJ7s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W61t.UO_1715135016;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W61t.UO_1715135016)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 10:23:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost 3/5] virtio_ring: introduce virtqueue_dma_map_sg_attrs
Date: Wed,  8 May 2024 10:23:29 +0800
Message-Id: <20240508022331.63751-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240508022331.63751-1-xuanzhuo@linux.alibaba.com>
References: <20240508022331.63751-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: a0fef46c457b
Content-Transfer-Encoding: 8bit

Introduce a helper to do dma map for scatterlist.
That can be used by other drivers.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 653c7ea24fb7..dab7f7fa8ec1 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3162,6 +3162,38 @@ int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
 
+/**
+ * virtqueue_dma_map_sg_attrs - map scatterlist addr DMA for _vq
+ * @_vq: the struct virtqueue we're talking about.
+ * @sg: the scatterlist to do dma
+ * @dir: DMA direction
+ * @attrs: DMA Attrs
+ *
+ * The caller calls this to do dma mapping in advance. The sg can be
+ * passed to this _vq when it is in pre-mapped mode.
+ *
+ * Returns zero or a negative error.
+ *   0: success
+ *   -ENOMEM: dma map error
+ */
+int virtqueue_dma_map_sg_attrs(struct virtqueue *_vq, struct scatterlist *sg,
+			       enum dma_data_direction dir, unsigned long attrs)
+{
+	dma_addr_t addr;
+	int err;
+
+	addr = virtqueue_dma_map_page_attrs(_vq, sg_page(sg), sg->offset,
+					    sg->length, dir, attrs);
+	err = virtqueue_dma_mapping_error(_vq, addr);
+	if (err)
+		return err;
+
+	sg->dma_address = addr;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_map_sg_attrs);
+
 /**
  * virtqueue_dma_need_sync - check a dma address needs sync
  * @_vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index d92aa7be2c44..18694d201698 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -234,6 +234,9 @@ void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
 				    unsigned long attrs);
 int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
 
+int virtqueue_dma_map_sg_attrs(struct virtqueue *_vq, struct scatterlist *sg,
+			       enum dma_data_direction dir, unsigned long attrs);
+
 bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
 void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t addr,
 					     unsigned long offset, size_t size,
-- 
2.32.0.3.g01195cf9f


