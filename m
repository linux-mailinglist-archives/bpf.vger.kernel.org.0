Return-Path: <bpf+bounces-29008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4978BF475
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 04:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28451C235A1
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 02:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC4EDDCD;
	Wed,  8 May 2024 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uMgItCbJ"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD9BA2E;
	Wed,  8 May 2024 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135021; cv=none; b=lQg6ozmzta9SvJzemLyt9JNYWyyML8UXpwvf3Wqk6KnPXE0Qbe8VI9iywwYyKDSKZr86JJfmyJS6m8Ok7ppROmlJNMtvuj+kS/x6UyiTLkhaI3vMpbxQ3v4VCQ5dAXyEnZ9VuCD+xYXe+NajfSs+Jz6ScRwTbNhWvYSldwoCtN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135021; c=relaxed/simple;
	bh=6QiS0/5CmZ0pf2KdZ/qXZV/mvc3EUYF6n+eahZDi2Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPgRT7V3HvqZOb6WwumKUySfaFCAO37nBswl+jmu+RgyhbDA40BEGGCUf3E3RW/XssdUF4shXx1kYWzvbBhLBzKDAdUad5FpDfPqXkaGVXHU4hgWQM1n1oWLyA1CLZCCFKXZviwva/XI1zTUgSPtyDp8PEkhNkZE7UR3DkNfoAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uMgItCbJ; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715135016; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nOMJaXwRPFppSnIk7SgaJEXuyHcqypZO3nEf/f3kmLk=;
	b=uMgItCbJ8l6UArY6xz6DQYWVEQsfvjWdh54xCpLPIZY35cnYZGmxHS+PoMuamuMbIo6k0FW6+6AxCgT5HIKX85CP+Rj04U/1bb6En5x5BNaMiMTcqoEg/UUexdwcE30eFruoj2fTBoXyTZiDIjHe8M3iFD2v5aax28P/ISKKFMo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W61ibMG_1715135014;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W61ibMG_1715135014)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 10:23:36 +0800
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
Subject: [PATCH vhost 2/5] virtio_ring: introduce dma map api for page
Date: Wed,  8 May 2024 10:23:28 +0800
Message-Id: <20240508022331.63751-3-xuanzhuo@linux.alibaba.com>
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
 drivers/virtio/virtio_ring.c | 52 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  7 +++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d7059bacb593..653c7ea24fb7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3092,6 +3092,58 @@ void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
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
+	if (!vq->use_dma_api)
+		return page_to_phys(page) + offset;
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
index b0201747a263..d92aa7be2c44 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -225,6 +225,13 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr, size
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


