Return-Path: <bpf+bounces-44204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16239C0082
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 09:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE162834E6
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 08:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D141DED79;
	Thu,  7 Nov 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o+97ylYY"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAEE1DE88D;
	Thu,  7 Nov 2024 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969715; cv=none; b=gYGKR3Kh6ZHEsc5V1UOxWHwroX2DfCGTNhutZukv2qfyB43zR2ktpmhvNtZMcMkGIxlIEqAJIzxtfsk+3JY3G0knRDunFmdTs9YKDaor26Q+auIPp/12vXpIhWUwuGcnuA9rVM7DLw7ijsiBCONTXF3jmc3nVovitLIwDK204V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969715; c=relaxed/simple;
	bh=roVPX9xlNybEw8IeYWV41K0SbVN+x0LB7yCkwhZbQw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3T4dZT53yVCfbGtdqTE0etFSyB/+D9XItLcSU47vrntYf0xmdILyf8odYoGi0h4ahpWKNLyccQ2sa0K03keA9tnHgxYnOgoC+gyEml70QCgN6z2L+zZRcXbKEDN+AMHKk9snGJf6zaoKluwOR1dPeo8I+wtxSpyi+87PLkStV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o+97ylYY; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730969711; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eePXxJvR7XKHoYFkKSiyQPkc0tD1PUqK6tBiZ1shguI=;
	b=o+97ylYYnUvNjmOFP3JHHZkLTPz7+iiH/i0SJiry2WqvQvEyEiSDxgeNdRyY2S5cvimfgBhyy//IXb0toyufCOJ1YWS1MnVIVe1T2kRvNHnnVFJPBMePeXoTk+TNRwc9A+o9my1BZqcYmLVZ/Q95KtG5758PwJCx3627Cpol1+M=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIuulRL_1730969709 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 16:55:10 +0800
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
Subject: [PATCH net-next v3 05/13] virtio_ring: introduce add api for premapped
Date: Thu,  7 Nov 2024 16:54:56 +0800
Message-Id: <20241107085504.63131-6-xuanzhuo@linux.alibaba.com>
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
---
 drivers/virtio/virtio_ring.c | 46 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       | 11 +++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fefa85a5e6b6..26d218f6235d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2276,6 +2276,28 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
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
@@ -2322,6 +2344,30 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
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


