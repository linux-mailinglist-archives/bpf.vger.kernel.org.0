Return-Path: <bpf+bounces-7457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E877789E
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 14:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0714D1C215DE
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76502253D7;
	Thu, 10 Aug 2023 12:31:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A2D253CC;
	Thu, 10 Aug 2023 12:31:21 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404DF212F;
	Thu, 10 Aug 2023 05:31:18 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VpTrCYt_1691670672;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VpTrCYt_1691670672)
          by smtp.aliyun-inc.com;
          Thu, 10 Aug 2023 20:31:13 +0800
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
Subject: [PATCH vhost v13 11/12] virtio_ring: introduce dma sync api for virtqueue
Date: Thu, 10 Aug 2023 20:30:56 +0800
Message-Id: <20230810123057.43407-12-xuanzhuo@linux.alibaba.com>
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

These API has been introduced:

* virtqueue_dma_need_sync
* virtqueue_dma_sync_single_range_for_cpu
* virtqueue_dma_sync_single_range_for_device

These APIs can be used together with the premapped mechanism to sync the
DMA address.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 76 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  8 ++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 916479c9c72c..81ecb29c88f1 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3175,4 +3175,80 @@ int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
 
+/**
+ * virtqueue_dma_need_sync - check a dma address needs sync
+ * @_vq: the struct virtqueue we're talking about.
+ * @addr: DMA address
+ *
+ * Check if the dma address mapped by the virtqueue_dma_map_* APIs needs to be
+ * synchronized
+ *
+ * return bool
+ */
+bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (!vq->use_dma_api)
+		return false;
+
+	return dma_need_sync(vring_dma_dev(vq), addr);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
+
+/**
+ * virtqueue_dma_sync_single_range_for_cpu - dma sync for cpu
+ * @_vq: the struct virtqueue we're talking about.
+ * @addr: DMA address
+ * @offset: DMA address offset
+ * @size: buf size for sync
+ * @dir: DMA direction
+ *
+ * Before calling this function, use virtqueue_dma_need_sync() to confirm that
+ * the DMA address really needs to be synchronized
+ *
+ */
+void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
+					     dma_addr_t addr,
+					     unsigned long offset, size_t size,
+					     enum dma_data_direction dir)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct device *dev = vring_dma_dev(vq);
+
+	if (!vq->use_dma_api)
+		return;
+
+	dma_sync_single_range_for_cpu(dev, addr, offset, size,
+				      DMA_BIDIRECTIONAL);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
+
+/**
+ * virtqueue_dma_sync_single_range_for_device - dma sync for device
+ * @_vq: the struct virtqueue we're talking about.
+ * @addr: DMA address
+ * @offset: DMA address offset
+ * @size: buf size for sync
+ * @dir: DMA direction
+ *
+ * Before calling this function, use virtqueue_dma_need_sync() to confirm that
+ * the DMA address really needs to be synchronized
+ */
+void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
+						dma_addr_t addr,
+						unsigned long offset, size_t size,
+						enum dma_data_direction dir)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct device *dev = vring_dma_dev(vq);
+
+	if (!vq->use_dma_api)
+		return;
+
+	dma_sync_single_range_for_device(dev, addr, offset, size,
+					 DMA_BIDIRECTIONAL);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 79e3c74391e0..1311a7fbe675 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -220,4 +220,12 @@ void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
 				      size_t size, enum dma_data_direction dir,
 				      unsigned long attrs);
 int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
+
+bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
+void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t addr,
+					     unsigned long offset, size_t size,
+					     enum dma_data_direction dir);
+void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma_addr_t addr,
+						unsigned long offset, size_t size,
+						enum dma_data_direction dir);
 #endif /* _LINUX_VIRTIO_H */
-- 
2.32.0.3.g01195cf9f


