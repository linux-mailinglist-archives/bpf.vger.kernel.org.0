Return-Path: <bpf+bounces-20714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E4D8423C9
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 12:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3291C244CB
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9757E77B;
	Tue, 30 Jan 2024 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yfRxuvRe"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A516D1DC;
	Tue, 30 Jan 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614971; cv=none; b=WZeVtKBp3WLpwoheQXWnNNJXPtO/1Ua0/VnagBm9xE7i42rSIoIwguEH+Er1HZ0N1LEnrAV5F0HGEYfLVgJaOdhnZ+ZKC36PHX2np+ICHtCMO2LeLetxetVTd4QplRNIx1DYlhiuUBdpXFSvQTj4xsu8tFb+hTWmIUYxfyud2T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614971; c=relaxed/simple;
	bh=5IgO3w2jHi8Q2MuL+rtVJApgugyMR6DBtap1jTRrado=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JS+aVG1UUbvIM55bMfM6DJIrPbwmdLg3bbJjlZ9AQz6aypsdfQY3BmD3g8CdF3GBOsj3mE1IaOHiZ/Bqsm/5IJrUTwzX8qSg+kB9Mc9MZiP1xUL+zrendtZKzoCbw0tPERDmArq3EaH9OZB7exwSFUXpJjpcnY9CClwoC5EJB+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yfRxuvRe; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706614961; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VKC8H6yGQqai4Wir7Iq0SqQqScYgwESPvSh8zQB9EUA=;
	b=yfRxuvResV8YIV4Od6r8JuIwl9txQUo53YyzMaaVi4HvVrdqxwKTnuNaDFYDDddXMrwMLzB8DnbzU7zbI4nxLECv9tfOIW1rd1jgscH9yRPrrWKL3mkBZppmBK6YfoK7656e99smjtSzVIRQ72YTxPgegIPfE5drqnnHbzI9Hkc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=37;SR=0;TI=SMTPD_---0W.g61UH_1706614958;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.g61UH_1706614958)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 19:42:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost 08/17] virtio: vring_new_virtqueue(): pass struct instead of multi parameters
Date: Tue, 30 Jan 2024 19:42:15 +0800
Message-Id: <20240130114224.86536-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 239d1d475be4
Content-Transfer-Encoding: 8bit

Just like find_vqs(), it is time to refactor the
vring_new_virtqueue(). We pass the similar struct to
vring_new_virtqueue.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 12 ++++---
 drivers/remoteproc/remoteproc_virtio.c   | 11 ++++---
 drivers/virtio/virtio_ring.c             | 29 +++++++++++-----
 include/linux/virtio_ring.h              | 42 +++++++++++++++++++-----
 tools/virtio/virtio_test.c               |  4 +--
 tools/virtio/vringh_test.c               | 32 +++++++++---------
 6 files changed, 86 insertions(+), 44 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 1b5593965068..765f54a16bf7 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -992,6 +992,7 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 					struct virtio_vq_config *cfg)
 {
 	struct mlxbf_tmfifo_vdev *tm_vdev = mlxbf_vdev_to_tmfifo(vdev);
+	struct transport_vq_config tp_cfg = {};
 	struct virtqueue **vqs = cfg->vqs;
 	struct mlxbf_tmfifo_vring *vring;
 	unsigned int nvqs = cfg->nvqs;
@@ -1012,10 +1013,13 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 		size = vring_size(vring->num, vring->align);
 		memset(vring->va, 0, size);
 
-		vq = vring_new_virtqueue(i, vring->num, vring->align, vdev,
-					 false, false, vring->va,
-					 mlxbf_tmfifo_virtio_notify,
-					 cfg->callbacks[i], cfg->names[i]);
+		tp_cfg.num = vring->num;
+		tp_cfg.vring_align = vring->align;
+		tp_cfg.weak_barriers = false;
+		tp_cfg.notify = mlxbf_tmfifo_virtio_notify;
+
+		cfg->cfg_idx = i;
+		vq = vring_new_virtqueue(vdev, i, vring->va, &tp_cfg, cfg);
 		if (!vq) {
 			dev_err(&vdev->dev, "vring_new_virtqueue failed\n");
 			ret = -ENOMEM;
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 57d51c9c7b63..d1212361da30 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -106,6 +106,7 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 {
 	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
 	struct rproc *rproc = vdev_to_rproc(vdev);
+	struct transport_vq_config tp_cfg;
 	struct device *dev = &rproc->dev;
 	struct rproc_mem_entry *mem;
 	struct rproc_vring *rvring;
@@ -138,14 +139,16 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 	dev_dbg(dev, "vring%d: va %pK qsz %d notifyid %d\n",
 		id, addr, num, rvring->notifyid);
 
+	tp_cfg.num = num;
+	tp_cfg.vring_align = rvring->align;
+	tp_cfg.weak_barriers = false;
+	tp_cfg.notify = rproc_virtio_notify;
+
 	/*
 	 * Create the new vq, and tell virtio we're not interested in
 	 * the 'weak' smp barriers, since we're talking with a real device.
 	 */
-	vq = vring_new_virtqueue(id, num, rvring->align, vdev, false,
-				 cfg->ctx ? cfg->ctx[cfg->cfg_idx] : false,
-				 addr, rproc_virtio_notify, cfg->callbacks[cfg->cfg_idx],
-				 cfg->names[cfg->cfg_idx]);
+	vq = vring_new_virtqueue(vdev, id, addr, &tp_cfg, cfg);
 	if (!vq) {
 		dev_err(dev, "vring_new_virtqueue %s failed\n", cfg->names[cfg->cfg_idx]);
 		rproc_free_vring(rvring);
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5652ff91c6f9..d87b80a5b9df 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2908,18 +2908,29 @@ int virtqueue_reset(struct virtqueue *_vq,
 EXPORT_SYMBOL_GPL(virtqueue_reset);
 
 /* Only available for split ring */
-struct virtqueue *vring_new_virtqueue(unsigned int index,
-				      unsigned int num,
-				      unsigned int vring_align,
-				      struct virtio_device *vdev,
-				      bool weak_barriers,
-				      bool context,
+struct virtqueue *vring_new_virtqueue(struct virtio_device *vdev,
+				      unsigned int index,
 				      void *pages,
-				      bool (*notify)(struct virtqueue *vq),
-				      void (*callback)(struct virtqueue *vq),
-				      const char *name)
+				      struct transport_vq_config *tp_cfg,
+				      struct virtio_vq_config *cfg)
 {
 	struct vring_virtqueue_split vring_split = {};
+	unsigned int num;
+	unsigned int vring_align;
+	bool weak_barriers;
+	bool context;
+	bool (*notify)(struct virtqueue *_);
+	void (*callback)(struct virtqueue *_);
+	const char *name;
+
+	num            = tp_cfg->num;
+	vring_align    = tp_cfg->vring_align;
+	weak_barriers  = tp_cfg->weak_barriers;
+	notify         = tp_cfg->notify;
+
+	name     = cfg->names[cfg->cfg_idx];
+	callback = cfg->callbacks[cfg->cfg_idx];
+	context  = cfg->ctx ? cfg->ctx[cfg->cfg_idx] : false;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return NULL;
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 0de46ed17cc0..316dadcde47a 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -85,16 +85,40 @@ struct virtqueue *vring_create_virtqueue(struct virtio_device *vdev,
  * Creates a virtqueue with a standard layout but a caller-allocated
  * ring.
  */
-struct virtqueue *vring_new_virtqueue(unsigned int index,
-				      unsigned int num,
-				      unsigned int vring_align,
-				      struct virtio_device *vdev,
-				      bool weak_barriers,
-				      bool ctx,
+struct virtqueue *vring_new_virtqueue(struct virtio_device *vdev,
+				      unsigned int index,
 				      void *pages,
-				      bool (*notify)(struct virtqueue *vq),
-				      void (*callback)(struct virtqueue *vq),
-				      const char *name);
+				      struct transport_vq_config *tp_cfg,
+				      struct virtio_vq_config *cfg);
+
+static inline struct virtqueue *vring_new_virtqueue_one(unsigned int index,
+							unsigned int num,
+							unsigned int vring_align,
+							struct virtio_device *vdev,
+							bool weak_barriers,
+							bool context,
+							void *pages,
+							bool (*notify)(struct virtqueue *vq),
+							void (*callback)(struct virtqueue *vq),
+							const char *name)
+{
+	struct transport_vq_config tp_cfg = {};
+	struct virtio_vq_config cfg = {};
+	vq_callback_t *callbacks[] = { callback };
+	const char *names[] = { name };
+
+	tp_cfg.num = num;
+	tp_cfg.vring_align = vring_align;
+	tp_cfg.weak_barriers = weak_barriers;
+	tp_cfg.notify = notify;
+
+	cfg.nvqs = 1;
+	cfg.callbacks = callbacks;
+	cfg.names = names;
+	cfg.ctx = &context;
+
+	return vring_new_virtqueue(vdev, index, pages, &tp_cfg, &cfg);
+}
 
 /*
  * Destroys a virtqueue.  If created with vring_create_virtqueue, this
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 028f54e6854a..e41300d71d5e 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -102,8 +102,8 @@ static void vq_reset(struct vq_info *info, int num, struct virtio_device *vdev)
 
 	memset(info->ring, 0, vring_size(num, 4096));
 	vring_init(&info->vring, num, info->ring, 4096);
-	info->vq = vring_new_virtqueue(info->idx, num, 4096, vdev, true, false,
-				       info->ring, vq_notify, vq_callback, "test");
+	info->vq = vring_new_virtqueue_one(info->idx, num, 4096, vdev, true, false,
+					   info->ring, vq_notify, vq_callback, "test");
 	assert(info->vq);
 	info->vq->priv = info;
 }
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 98ff808d6f0c..37f8c5d34285 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -316,11 +316,11 @@ static int parallel_test(u64 features,
 		if (sched_setaffinity(getpid(), sizeof(cpu_set), &cpu_set))
 			err(1, "Could not set affinity to cpu %u", first_cpu);
 
-		vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &gvdev.vdev, true,
-					 false, guest_map,
-					 fast_vringh ? no_notify_host
-					 : parallel_notify_host,
-					 never_callback_guest, "guest vq");
+		vq = vring_new_virtqueue_one(0, RINGSIZE, ALIGN, &gvdev.vdev, true,
+					     false, guest_map,
+					     fast_vringh ? no_notify_host
+					     : parallel_notify_host,
+					     never_callback_guest, "guest vq");
 
 		/* Don't kfree indirects. */
 		__kfree_ignore_start = indirects;
@@ -391,7 +391,7 @@ static int parallel_test(u64 features,
 				/* Swallow all notifies at once. */
 				if (read(to_guest[0], buf, sizeof(buf)) < 1)
 					break;
-				
+
 				receives++;
 				virtqueue_disable_cb(vq);
 				continue;
@@ -424,7 +424,7 @@ static int parallel_test(u64 features,
 				continue;
 			if (read(to_guest[0], buf, sizeof(buf)) < 1)
 				break;
-				
+
 			receives++;
 			virtqueue_disable_cb(vq);
 		}
@@ -485,10 +485,10 @@ int main(int argc, char *argv[])
 	memset(__user_addr_min, 0, vring_size(RINGSIZE, ALIGN));
 
 	/* Set up guest side. */
-	vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true, false,
-				 __user_addr_min,
-				 never_notify_host, never_callback_guest,
-				 "guest vq");
+	vq = vring_new_virtqueue_one(0, RINGSIZE, ALIGN, &vdev, true, false,
+				     __user_addr_min,
+				     never_notify_host, never_callback_guest,
+				     "guest vq");
 
 	/* Set up host side. */
 	vring_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
@@ -668,11 +668,11 @@ int main(int argc, char *argv[])
 
 		/* Force creation of direct, which we modify. */
 		__virtio_clear_bit(&vdev, VIRTIO_RING_F_INDIRECT_DESC);
-		vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true,
-					 false, __user_addr_min,
-					 never_notify_host,
-					 never_callback_guest,
-					 "guest vq");
+		vq = vring_new_virtqueue_one(0, RINGSIZE, ALIGN, &vdev, true,
+					     false, __user_addr_min,
+					     never_notify_host,
+					     never_callback_guest,
+					     "guest vq");
 
 		sg_init_table(guest_sg, 4);
 		sg_set_buf(&guest_sg[0], d, sizeof(*d)*2);
-- 
2.32.0.3.g01195cf9f


