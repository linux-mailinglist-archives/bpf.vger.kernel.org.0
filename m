Return-Path: <bpf+bounces-31823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1398903AD2
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773F61F2546B
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F4517FAA3;
	Tue, 11 Jun 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RV/NC+un"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FB217F4E5;
	Tue, 11 Jun 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106119; cv=none; b=EO9EjfSXwciNHNusncawa0O1nqiGRCArY3IdqtgHEIn5TRgf69GmK71YAH+/Y6lnGWWTAVVtTe4UNZODEmbJ4MVn+RaPAPZYYfIrE2iyL0ExWW1PmIfCZWQwJCFrL/wp1Zr5soFemrNkfPuT4Wngt28AVD1s/GE9rJUHumpeif8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106119; c=relaxed/simple;
	bh=3DSBcnmGF/DEN0QAR3fj/e/jRUhx673CEWZkWHCOo7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jg4xB7pFKHYtikqMeBE3zReT4yZXxVVsw51dEj+lkhf4Giwb7Sy0tmoevokPrcxNko80J/vnmxQyo2KReA8LCj2FlbHzRLff5HGq/9tUP7xghJgnYpJW7O+QiKEhfjqY4b7W15jzGlWVP0+j+6J+MCBrwS3BgoT2lkUbAApTsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RV/NC+un; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718106110; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=q7i3wAwDs//0cHvqacoq6jjoegYvB8IaBH0RBZ5AYvc=;
	b=RV/NC+unitV7fYAXm2BdqNLJ/h/y8m/OaPNovtUQY+uD0TgAPEptXJiiDKr/D4XJCkls0vYlUHOiBpH4Prh4gpgyrw9JjTjlzSlKGmjMHocQHwmRyDY3xLJ+RwxCB2b/M078outVva0xYyDpqnfux5HN0FCSjO9U/WQlgoC83Og=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8GFQkv_1718106108;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8GFQkv_1718106108)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 19:41:49 +0800
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
Subject: [PATCH net-next v4 01/15] virtio_ring: introduce dma map api for page
Date: Tue, 11 Jun 2024 19:41:33 +0800
Message-Id: <20240611114147.31320-2-xuanzhuo@linux.alibaba.com>
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

The virtio-net sq will use these APIs to map the scatterlist.
For scatterlist, the page dma APIs are more appropriate.

dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
                                       size_t offset, size_t size,
                                       enum dma_data_direction dir,
                                       unsigned long attrs);
void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
                                   size_t size, enum dma_data_direction dir,
                                   unsigned long attrs);

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 54 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  7 +++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2a972752ff1b..3d28008d6cd4 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3152,6 +3152,60 @@ void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
 
+/**
+ * virtqueue_dma_map_page_attrs - map DMA for _vq
+ * @_vq: the struct virtqueue we're talking about.
+ * @page: the page to do dma
+ * @offset: the offset inside the page
+ * @size: the size of the page to do dma
+ * @dir: DMA direction
+ * @attrs: DMA Attrs
+ *
+ * The caller calls this to do dma mapping in advance. The DMA address can be
+ * passed to this _vq when it is in pre-mapped mode.
+ *
+ * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
+ */
+dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
+					size_t offset, size_t size,
+					enum dma_data_direction dir,
+					unsigned long attrs)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (!vq->use_dma_api) {
+		kmsan_handle_dma(page, offset, size, dir);
+		return page_to_phys(page) + offset;
+	}
+
+	return dma_map_page_attrs(vring_dma_dev(vq), page, offset, size, dir, attrs);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_map_page_attrs);
+
+/**
+ * virtqueue_dma_unmap_page_attrs - unmap DMA for _vq
+ * @_vq: the struct virtqueue we're talking about.
+ * @addr: the dma address to unmap
+ * @size: the size of the buffer
+ * @dir: DMA direction
+ * @attrs: DMA Attrs
+ *
+ * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
+ *
+ */
+void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
+				    size_t size, enum dma_data_direction dir,
+				    unsigned long attrs)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (!vq->use_dma_api)
+		return;
+
+	dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_page_attrs);
+
 /**
  * virtqueue_dma_mapping_error - check dma address
  * @_vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 96fea920873b..ca318a66a7e1 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -234,6 +234,13 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr, size
 void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
 				      size_t size, enum dma_data_direction dir,
 				      unsigned long attrs);
+dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
+					size_t offset, size_t size,
+					enum dma_data_direction dir,
+					unsigned long attrs);
+void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
+				    size_t size, enum dma_data_direction dir,
+				    unsigned long attrs);
 int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
 
 bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
-- 
2.32.0.3.g01195cf9f


