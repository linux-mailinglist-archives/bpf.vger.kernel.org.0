Return-Path: <bpf+bounces-23008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF2F86C20A
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 08:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B30B1C22BED
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 07:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718B852F8A;
	Thu, 29 Feb 2024 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Rtx3Ejd4"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5750A63;
	Thu, 29 Feb 2024 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191265; cv=none; b=eS/PonBK7Qb6DGoCibf9Rn/BNGWKBgxrpYESrITgQAzQGiAi1E6+jPedHvaSPCgX9xfh4F6d/J+/BpmP3VraXQg2Gm8OUldMByKLJAGHj0dZRnCR1grrQPLe8dCc66ZM3BZut8KchLa+BoBPanCmCYnC+BEyB+bFF78woK5obUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191265; c=relaxed/simple;
	bh=BRox4FiCq951I/RbIkvW5AnS+b7Qw07PDlz2qIHlijQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d46yD9dAy+yLs8tsZXMTPLGaKwqtrEM3QYVRURo670uWEwomBjBYTSueAvOoZLLJwA5MYVtHAu6VTQ+epXlzOMsNpofkZophmx8xzNbML0j0vY+P4uOjQlQAya8aSWZyNy9/ZCqSAzVaEmQ0REFQar40YQdnIRydxP5wcR4ltec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Rtx3Ejd4; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709191260; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YoK3ALUSYa3j1VpVnzQ4hfs+4cPUm8QpU+PNW4oH2jY=;
	b=Rtx3Ejd4OvAm9CYV8+3GgJnWcvOK2SkCyjEs7/scpIStfPgdMI4dQVUQ7yL464dpLn7appey18p7oAoTtI0nnm3JA1O/B2hNfJovxCw5RrBICdAzn0IT5OjHFfKNb0/CU4+RHEgIt5GyyZ6EhWS/On9gq/PDdUEluu0dFifsidY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0W1S3KTx_1709191258;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1S3KTx_1709191258)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 15:20:58 +0800
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
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost v3 08/19] virtio: vring_create_virtqueue: pass struct instead of multi parameters
Date: Thu, 29 Feb 2024 15:20:33 +0800
Message-Id: <20240229072044.77388-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
References: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: e3a3e51d6b70
Content-Transfer-Encoding: 8bit

Now, we pass multi parameters to vring_create_virtqueue. These parameters
may from transport or from driver.

vring_create_virtqueue is called by many places.
Every time, we try to add a new parameter, that is difficult.

If parameters from the driver, that should directly be passed to vring.
Then the vring can access the config from driver directly.

If parameters from the transport, we squish the parameters to a
structure. That will be helpful to add new parameter.

Because the virtio_uml.c changes the name, so change the "names" inside
the virtio_vq_config from "const char *const *names" to
"const char **names".

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 arch/um/drivers/virtio_uml.c       | 14 +++++---
 drivers/s390/virtio/virtio_ccw.c   | 14 ++++----
 drivers/virtio/virtio_mmio.c       | 14 ++++----
 drivers/virtio/virtio_pci_legacy.c | 15 ++++----
 drivers/virtio/virtio_pci_modern.c | 15 ++++----
 drivers/virtio/virtio_ring.c       | 57 ++++++++++++------------------
 drivers/virtio/virtio_vdpa.c       | 21 +++++------
 include/linux/virtio_config.h      |  6 ++--
 include/linux/virtio_ring.h        | 40 ++++++++-------------
 9 files changed, 93 insertions(+), 103 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index c13dfeeb90c4..1c2d59d3d02b 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -942,6 +942,7 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 {
 	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
 	struct platform_device *pdev = vu_dev->pdev;
+	struct vq_transport_config tp_cfg = {};
 	struct virtio_uml_vq_info *info;
 	struct virtqueue *vq;
 	int num = MAX_SUPPORTED_QUEUE_SIZE;
@@ -955,10 +956,15 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 	snprintf(info->name, sizeof(info->name), "%s.%d-%s", pdev->name,
 		 pdev->id, cfg->names[cfg->cfg_idx]);
 
-	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
-				    cfg->ctx ? cfg->ctx[cfg->cfg_idx] : false,
-				    vu_notify,
-				    cfg->callbacks[cfg->cfg_idx], info->name);
+	tp_cfg.num = num;
+	tp_cfg.vring_align = PAGE_SIZE;
+	tp_cfg.weak_barriers = true;
+	tp_cfg.may_reduce_num = true;
+	tp_cfg.notify = vu_notify;
+
+	cfg->names[cfg->cfg_idx] = info->name;
+
+	vq = vring_create_virtqueue(vdev, index, &tp_cfg, cfg);
 	if (!vq) {
 		rc = -ENOMEM;
 		goto error_create;
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 11eea5086cff..f8d5bbd13359 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -503,6 +503,7 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 					     struct virtio_vq_config *cfg)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
+	struct vq_transport_config tp_cfg = {};
 	bool (*notify)(struct virtqueue *vq);
 	int err;
 	struct virtqueue *vq = NULL;
@@ -536,13 +537,14 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 		goto out_err;
 	}
 	may_reduce = vcdev->revision > 0;
-	vq = vring_create_virtqueue(i, info->num, KVM_VIRTIO_CCW_RING_ALIGN,
-				    vdev, true, may_reduce,
-				    cfg->ctx ? cfg->ctx[cfg->cfg_idx] : false,
-				    notify,
-				    cfg->callbacks[cfg->cfg_idx],
-				    cfg->names[cfg->cfg_idx]);
 
+	tp_cfg.num = info->num;
+	tp_cfg.vring_align = KVM_VIRTIO_CCW_RING_ALIGN;
+	tp_cfg.weak_barriers = true;
+	tp_cfg.may_reduce_num = may_reduce;
+	tp_cfg.notify = notify;
+
+	vq = vring_create_virtqueue(vdev, i, &tp_cfg, cfg);
 	if (!vq) {
 		/* For now, we fail if we can't get the requested size. */
 		dev_warn(&vcdev->cdev->dev, "no vq\n");
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index feb823d279d2..cb172fa4d7cc 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -373,6 +373,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 				     struct virtio_vq_config *cfg)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	struct vq_transport_config tp_cfg = {};
 	bool (*notify)(struct virtqueue *vq);
 	struct virtio_mmio_vq_info *info;
 	struct virtqueue *vq;
@@ -411,13 +412,14 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 		goto error_new_virtqueue;
 	}
 
+	tp_cfg.num = num;
+	tp_cfg.vring_align = VIRTIO_MMIO_VRING_ALIGN;
+	tp_cfg.weak_barriers = true;
+	tp_cfg.may_reduce_num = true;
+	tp_cfg.notify = notify;
+
 	/* Create the vring */
-	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
-				 true, true,
-				 cfg->ctx ? cfg->ctx[cfg->cfg_idx] : false,
-				 notify,
-				 cfg->callbacks[cfg->cfg_idx],
-				 cfg->names[cfg->cfg_idx]);
+	vq = vring_create_virtqueue(vdev, index, &tp_cfg, cfg);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index e8d22fce32f5..6fe675b2a5e5 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -113,6 +113,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  struct virtio_vq_config *cfg,
 				  u16 msix_vec)
 {
+	struct vq_transport_config tp_cfg = {};
 	struct virtqueue *vq;
 	u16 num;
 	int err;
@@ -125,14 +126,14 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
 	info->msix_vector = msix_vec;
 
+	tp_cfg.num = num;
+	tp_cfg.vring_align = VIRTIO_PCI_VRING_ALIGN;
+	tp_cfg.weak_barriers = true;
+	tp_cfg.may_reduce_num = false;
+	tp_cfg.notify = vp_notify;
+
 	/* create the vring */
-	vq = vring_create_virtqueue(index, num,
-				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
-				    true, false,
-				    cfg->ctx ? cfg->ctx[cfg->cfg_idx] : false,
-				    vp_notify,
-				    cfg->callbacks[cfg->cfg_idx],
-				    cfg->names[cfg->cfg_idx]);
+	vq = vring_create_virtqueue(&vp_dev->vdev, index, &tp_cfg, cfg);
 	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index b2cdf5d3824d..dd75534346d1 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -535,6 +535,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 {
 
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct vq_transport_config tp_cfg = {};
 	bool (*notify)(struct virtqueue *vq);
 	struct virtqueue *vq;
 	bool is_avq;
@@ -558,14 +559,14 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
 	info->msix_vector = msix_vec;
 
+	tp_cfg.num = num;
+	tp_cfg.vring_align = SMP_CACHE_BYTES;
+	tp_cfg.weak_barriers = true;
+	tp_cfg.may_reduce_num = true;
+	tp_cfg.notify = notify;
+
 	/* create the vring */
-	vq = vring_create_virtqueue(index, num,
-				    SMP_CACHE_BYTES, &vp_dev->vdev,
-				    true, true,
-				    cfg->ctx ? cfg->ctx[cfg->cfg_idx] : false,
-				    notify,
-				    cfg->callbacks[cfg->cfg_idx],
-				    cfg->names[cfg->cfg_idx]);
+	vq = vring_create_virtqueue(&vp_dev->vdev, index, &tp_cfg, cfg);
 	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c1e4edaeb446..b77ee139a5d9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2729,43 +2729,32 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	return &vq->vq;
 }
 
-struct virtqueue *vring_create_virtqueue(
-	unsigned int index,
-	unsigned int num,
-	unsigned int vring_align,
-	struct virtio_device *vdev,
-	bool weak_barriers,
-	bool may_reduce_num,
-	bool context,
-	bool (*notify)(struct virtqueue *),
-	void (*callback)(struct virtqueue *),
-	const char *name)
+struct virtqueue *vring_create_virtqueue(struct virtio_device *vdev,
+					 unsigned int index,
+					 struct vq_transport_config *tp_cfg,
+					 struct virtio_vq_config *cfg)
 {
+	struct device *dma_dev;
+	unsigned int num;
+	unsigned int vring_align;
+	bool weak_barriers;
+	bool may_reduce_num;
+	bool context;
+	bool (*notify)(struct virtqueue *_);
+	void (*callback)(struct virtqueue *_);
+	const char *name;
 
-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
-		return vring_create_virtqueue_packed(index, num, vring_align,
-				vdev, weak_barriers, may_reduce_num,
-				context, notify, callback, name, vdev->dev.parent);
+	dma_dev = tp_cfg->dma_dev ? : vdev->dev.parent;
 
-	return vring_create_virtqueue_split(index, num, vring_align,
-			vdev, weak_barriers, may_reduce_num,
-			context, notify, callback, name, vdev->dev.parent);
-}
-EXPORT_SYMBOL_GPL(vring_create_virtqueue);
+	num            = tp_cfg->num;
+	vring_align    = tp_cfg->vring_align;
+	weak_barriers  = tp_cfg->weak_barriers;
+	may_reduce_num = tp_cfg->may_reduce_num;
+	notify         = tp_cfg->notify;
 
-struct virtqueue *vring_create_virtqueue_dma(
-	unsigned int index,
-	unsigned int num,
-	unsigned int vring_align,
-	struct virtio_device *vdev,
-	bool weak_barriers,
-	bool may_reduce_num,
-	bool context,
-	bool (*notify)(struct virtqueue *),
-	void (*callback)(struct virtqueue *),
-	const char *name,
-	struct device *dma_dev)
-{
+	name     = cfg->names[cfg->cfg_idx];
+	callback = cfg->callbacks[cfg->cfg_idx];
+	context  = cfg->ctx ? cfg->ctx[cfg->cfg_idx] : false;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return vring_create_virtqueue_packed(index, num, vring_align,
@@ -2776,7 +2765,7 @@ struct virtqueue *vring_create_virtqueue_dma(
 			vdev, weak_barriers, may_reduce_num,
 			context, notify, callback, name, dma_dev);
 }
-EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
+EXPORT_SYMBOL_GPL(vring_create_virtqueue);
 
 /**
  * virtqueue_resize - resize the vring of vq
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 7f3e173f669c..1ab219fce653 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -146,8 +146,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 {
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
-	struct device *dma_dev;
 	const struct vdpa_config_ops *ops = vdpa->config;
+	struct vq_transport_config tp_cfg = {};
 	struct virtio_vdpa_vq_info *info;
 	bool (*notify)(struct virtqueue *vq) = virtio_vdpa_notify;
 	struct vdpa_callback cb;
@@ -201,16 +201,17 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	align = ops->get_vq_align(vdpa);
 
 	if (ops->get_vq_dma_dev)
-		dma_dev = ops->get_vq_dma_dev(vdpa, index);
+		tp_cfg.dma_dev = ops->get_vq_dma_dev(vdpa, index);
 	else
-		dma_dev = vdpa_get_dma_dev(vdpa);
-	vq = vring_create_virtqueue_dma(index, max_num, align, vdev,
-					true, may_reduce_num,
-					cfg->ctx ? cfg->ctx[cfg->cfg_idx] : false,
-					notify,
-					cfg->callbacks[cfg->cfg_idx],
-					cfg->names[cfg->cfg_idx],
-					dma_dev);
+		tp_cfg.dma_dev = vdpa_get_dma_dev(vdpa);
+
+	tp_cfg.num = max_num;
+	tp_cfg.vring_align = align;
+	tp_cfg.weak_barriers = true;
+	tp_cfg.may_reduce_num = may_reduce_num;
+	tp_cfg.notify = notify;
+
+	vq = vring_create_virtqueue(vdev, index, &tp_cfg, cfg);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 1df8634d1258..d47188303d34 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -105,7 +105,7 @@ struct virtio_vq_config {
 
 	struct virtqueue **vqs;
 	vq_callback_t **callbacks;
-	const char *const *names;
+	const char **names;
 	const bool *ctx;
 	struct irq_affinity *desc;
 };
@@ -252,7 +252,7 @@ int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	cfg.nvqs = nvqs;
 	cfg.vqs = vqs;
 	cfg.callbacks = callbacks;
-	cfg.names = names;
+	cfg.names = (const char **)names;
 	cfg.desc = desc;
 
 	return vdev->config->find_vqs(vdev, &cfg);
@@ -269,7 +269,7 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 	cfg.nvqs = nvqs;
 	cfg.vqs = vqs;
 	cfg.callbacks = callbacks;
-	cfg.names = names;
+	cfg.names = (const char **)names;
 	cfg.ctx = ctx;
 	cfg.desc = desc;
 
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 9b33df741b63..cd8042c79814 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -5,6 +5,7 @@
 #include <asm/barrier.h>
 #include <linux/irqreturn.h>
 #include <uapi/linux/virtio_ring.h>
+#include <linux/virtio_config.h>
 
 /*
  * Barriers in virtio are tricky.  Non-SMP virtio guests can't assume
@@ -60,38 +61,25 @@ struct virtio_device;
 struct virtqueue;
 struct device;
 
+struct vq_transport_config {
+	unsigned int num;
+	unsigned int vring_align;
+	bool weak_barriers;
+	bool may_reduce_num;
+	bool (*notify)(struct virtqueue *vq);
+	struct device *dma_dev;
+};
+
 /*
  * Creates a virtqueue and allocates the descriptor ring.  If
  * may_reduce_num is set, then this may allocate a smaller ring than
  * expected.  The caller should query virtqueue_get_vring_size to learn
  * the actual size of the ring.
  */
-struct virtqueue *vring_create_virtqueue(unsigned int index,
-					 unsigned int num,
-					 unsigned int vring_align,
-					 struct virtio_device *vdev,
-					 bool weak_barriers,
-					 bool may_reduce_num,
-					 bool ctx,
-					 bool (*notify)(struct virtqueue *vq),
-					 void (*callback)(struct virtqueue *vq),
-					 const char *name);
-
-/*
- * Creates a virtqueue and allocates the descriptor ring with per
- * virtqueue DMA device.
- */
-struct virtqueue *vring_create_virtqueue_dma(unsigned int index,
-					     unsigned int num,
-					     unsigned int vring_align,
-					     struct virtio_device *vdev,
-					     bool weak_barriers,
-					     bool may_reduce_num,
-					     bool ctx,
-					     bool (*notify)(struct virtqueue *vq),
-					     void (*callback)(struct virtqueue *vq),
-					     const char *name,
-					     struct device *dma_dev);
+struct virtqueue *vring_create_virtqueue(struct virtio_device *vdev,
+					 unsigned int index,
+					 struct vq_transport_config *tp_cfg,
+					 struct virtio_vq_config *cfg);
 
 /*
  * Creates a virtqueue with a standard layout but a caller-allocated
-- 
2.32.0.3.g01195cf9f


