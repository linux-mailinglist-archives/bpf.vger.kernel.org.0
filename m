Return-Path: <bpf+bounces-7456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5620777789B
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 14:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0B02823F7
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 12:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F8D25165;
	Thu, 10 Aug 2023 12:31:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4742515A;
	Thu, 10 Aug 2023 12:31:19 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E91B4;
	Thu, 10 Aug 2023 05:31:16 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VpTnUa2_1691670671;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VpTnUa2_1691670671)
          by smtp.aliyun-inc.com;
          Thu, 10 Aug 2023 20:31:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
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
	bpf@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH vhost v13 10/12] virtio_ring: introduce dma map api for virtqueue
Date: Thu, 10 Aug 2023 20:30:55 +0800
Message-Id: <20230810123057.43407-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 6ea114ee5d47
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Added virtqueue_dma_map_api* to map DMA addresses for virtual memory in
advance. The purpose is to keep memory mapped across multiple add/get
buf operations.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 69 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  8 +++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 639c20b19e06..916479c9c72c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3106,4 +3106,73 @@ const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_vring);
 
+/**
+ * virtqueue_dma_map_single_attrs - map DMA for _vq
+ * @_vq: the struct virtqueue we're talking about.
+ * @ptr: the pointer of the buffer to do dma
+ * @size: the size of the buffer to do dma
+ * @dir: DMA direction
+ * @attrs: DMA Attrs
+ *
+ * The caller calls this to do dma mapping in advance. The DMA address can be
+ * passed to this _vq when it is in pre-mapped mode.
+ *
+ * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
+ */
+dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
+					  size_t size,
+					  enum dma_data_direction dir,
+					  unsigned long attrs)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (!vq->use_dma_api)
+		return (dma_addr_t)virt_to_phys(ptr);
+
+	return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attrs);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
+
+/**
+ * virtqueue_dma_unmap_single_attrs - unmap DMA for _vq
+ * @_vq: the struct virtqueue we're talking about.
+ * @addr: the dma address to unmap
+ * @size: the size of the buffer
+ * @dir: DMA direction
+ * @attrs: DMA Attrs
+ *
+ * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
+ *
+ */
+void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
+				      size_t size, enum dma_data_direction dir,
+				      unsigned long attrs)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (!vq->use_dma_api)
+		return;
+
+	dma_unmap_single_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
+
+/**
+ * virtqueue_dma_mapping_error - check dma address
+ * @_vq: the struct virtqueue we're talking about.
+ * @addr: DMA address
+ *
+ * Returns 0 means dma valid. Other means invalid dma address.
+ */
+int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (!vq->use_dma_api)
+		return 0;
+
+	return dma_mapping_error(vring_dma_dev(vq), addr);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 49a640e0a6f4..79e3c74391e0 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
+#include <linux/dma-mapping.h>
 
 /**
  * struct virtqueue - a queue to register buffers for sending or receiving.
@@ -212,4 +213,11 @@ void unregister_virtio_driver(struct virtio_driver *drv);
 #define module_virtio_driver(__virtio_driver) \
 	module_driver(__virtio_driver, register_virtio_driver, \
 			unregister_virtio_driver)
+
+dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr, size_t size,
+					  enum dma_data_direction dir, unsigned long attrs);
+void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
+				      size_t size, enum dma_data_direction dir,
+				      unsigned long attrs);
+int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
 #endif /* _LINUX_VIRTIO_H */
-- 
2.32.0.3.g01195cf9f


