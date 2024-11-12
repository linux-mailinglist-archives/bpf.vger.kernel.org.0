Return-Path: <bpf+bounces-44562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DF59C4BC8
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 02:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1910FB262BC
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 01:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99824205E07;
	Tue, 12 Nov 2024 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="komrtlGk"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044FD204F9C;
	Tue, 12 Nov 2024 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374980; cv=none; b=jHLYJs1TYdgWG5FEXeM3/WhN1BbiMjCP7Skh+ITeMDpcy/y4OVIQsW00+A4QseFl1qpjVshjwiuqrlrdSDyzvCwzaYCGSJWwDIlSwURPifNsUU7ED7Zy26/PZ5e6OJWgSWkfKxcCvPoBn8udDK7YGb12iJz6rb5AN5s6BFKiZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374980; c=relaxed/simple;
	bh=oCk2bVUFA80jcN8pFvgMFpUaQsCcZ0uuN66m6pjzcqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWL/lWA47YPiaoTm1uqCvKTrGp90eKGKJkqORGb6E7Q0Ve98hfNqUJbrqN8OSJzrkwQUG64mdeE+SK1tdNYLqqNf29ualPWOfpmRP5Po6t4vSkNUIoqNwje+7UhKA3boShKhI6XU3xDqHNLJxKeYL3M3CawiQp24413sAJDjzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=komrtlGk; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731374975; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=P2sKNOH/t68GirPzwwed7ITZs+MsxtSCxJBgVGe9vb4=;
	b=komrtlGkbUSz+GN9abw/7flVtJRDN6VW9p7E8f2q/h3tjCqz1N6AKPBFMwMk0iOe0owXKTAr4T7kIgJIuaTXxrNZ0sxhID/giJTK6DtToIWXHToVqxSdxrCaHV/r0LBUVffLS0wzqyKYZCpQM8YTfs6Pk2FVJ61reS++0ple4k4=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WJF5q-V_1731374974 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 09:29:35 +0800
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
Subject: [PATCH net-next v4 05/13] virtio_ring: introduce add api for premapped
Date: Tue, 12 Nov 2024 09:29:20 +0800
Message-Id: <20241112012928.102478-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241112012928.102478-1-xuanzhuo@linux.alibaba.com>
References: <20241112012928.102478-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: ee9bd377a389
Content-Transfer-Encoding: 8bit

Two APIs are introduced to submit premapped per-buffers.

int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
                                 struct scatterlist *sg, unsigned int num,
                                 void *data,
                                 void *ctx,
                                 gfp_t gfp);

int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
                                  struct scatterlist *sg, unsigned int num,
                                  void *data,
                                  gfp_t gfp);

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 48 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       | 11 +++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fefa85a5e6b6..0842d27886e5 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2276,6 +2276,29 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
 
+/**
+ * virtqueue_add_outbuf_premapped - expose output buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg readable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Return:
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
+				   struct scatterlist *sg, unsigned int num,
+				   void *data,
+				   gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, true, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_outbuf_premapped);
+
 /**
  * virtqueue_add_inbuf - expose input buffers to other end
  * @vq: the struct virtqueue we're talking about.
@@ -2322,6 +2345,31 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
 
+/**
+ * virtqueue_add_inbuf_premapped - expose input buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg writable by other side
+ * @data: the token identifying the buffer.
+ * @ctx: extra context for the token
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Return:
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
+				  struct scatterlist *sg, unsigned int num,
+				  void *data,
+				  void *ctx,
+				  gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, true, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
+
 /**
  * virtqueue_dma_dev - get the dma dev
  * @_vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 306137a15d07..13b3f55abca3 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -56,6 +56,17 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 			    void *ctx,
 			    gfp_t gfp);
 
+int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
+				  struct scatterlist *sg, unsigned int num,
+				  void *data,
+				  void *ctx,
+				  gfp_t gfp);
+
+int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
+				   struct scatterlist *sg, unsigned int num,
+				   void *data,
+				   gfp_t gfp);
+
 int virtqueue_add_sgs(struct virtqueue *vq,
 		      struct scatterlist *sgs[],
 		      unsigned int out_sgs,
-- 
2.32.0.3.g01195cf9f


