Return-Path: <bpf+bounces-30939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDBD8D4AC9
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 13:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CDA1C22D16
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBADD17FADA;
	Thu, 30 May 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IWl53cMy"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776EB17799B;
	Thu, 30 May 2024 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068261; cv=none; b=YpZK97KW555doH81fR6pb9RroNYgWCwWhSkZlPdTGwrb7VCxrY5Za9EygEnCC2G/iYZyYCAxVbKaL/3cIcftIXA8tXdKw+eQSh5j3iYYFhpjag+SP+h13NokqOWvV5FyDVRHs6T6SX1BVsjHspC2LQtJTMbhpNOYGVMc1SOFAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068261; c=relaxed/simple;
	bh=T/jdBORVBl+dxoyiYezNnp8KTTT99JZ3rGMCogqBi8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lio604CGre2b083UsxQPLVgKb+EvkC0k2qohHmnplcRwcgQ6JwcIVjdrKf2nAbRbn9NEb7vATR4i6+bypgR7JO/mqGF1gOZjeKZ5RD9E+Q6zsg43dlvxCc1LNrbIF+NW1wR6C+3wZ8g+09k0oLuvhDdp+9bN5MDu71bONkNzWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IWl53cMy; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717068257; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DDhCTStLcl/+P+V2frq3hSL+R0AzYiDFSGdq3xtyrCs=;
	b=IWl53cMyfmhB3ZDiCwEucnqSLHZJ4iVTBaqJfax/3qvVMJAuYU2Qk82w/MeNi/fhoqppjoAZAhV/UItst2Z0V3drPWodEzPTYMzXISglgQYnERdKMBbFzTub0r+/fHnUKrsfnywrHLq3nhxuloXfGOWvNevFgEdiLHbbR6RUWWk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7Ws89._1717068255;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7Ws89._1717068255)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 19:24:16 +0800
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
Subject: [PATCH net-next v2 09/12] virtio_ring: introduce dma map api for page
Date: Thu, 30 May 2024 19:24:03 +0800
Message-Id: <20240530112406.94452-10-xuanzhuo@linux.alibaba.com>
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

The virtio-net sq will use these APIs to map the scatterlist.

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
index df8eb0521aa0..acb6dba4bb55 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3149,6 +3149,58 @@ void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
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


