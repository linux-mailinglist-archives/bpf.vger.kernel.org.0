Return-Path: <bpf+bounces-58616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8CBABE567
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 23:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71AA1BC33CF
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 21:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBF1263C8F;
	Tue, 20 May 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J35KNs3d"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF52620E4;
	Tue, 20 May 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747774784; cv=none; b=dtRmsw+HVeVDC3x09nfxTIfo4S9Vr4nkuDoLopAQ2v1TDGSJ7Y2HKhd3LU2lzwiDJEJqfLrBaTdG2Z8hTplsKCtha6gEqT3p1h1UBFU7vST5WAY1aQ16Vq6WloQbnzl7b7xdW7JqHm4fz3943hQ2BkKTjCAFQ/UXSjqiH8mLqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747774784; c=relaxed/simple;
	bh=vgjbb+mBZCjNuvexvqCFfkbke+9Nt/ns9JcwEckYN6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GY944CczYaRP1J5m7HGEw5eyk/hbG6sOyY9ZeDUSBtED4Y0TyooIGorfR34pfeBCSrnQGUc+RPoU/KJmOroOE34pH7CmX8RtY06OYs+VMPccD/FC4qmPQntpZXKvS/z0Nvd3MYmBt4oY9s6OLINE4z5wLmfPRMQXndeBPVPEHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J35KNs3d; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747774782; x=1779310782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vgjbb+mBZCjNuvexvqCFfkbke+9Nt/ns9JcwEckYN6c=;
  b=J35KNs3dxC6uPVBMsf7iXJ1HgfhJ5XDrSRnzz6UL+sf/i5QY8YdXOjFf
   SqoMv/3cbYSc79JOo6Q3vRcdUz1IMT9npCt/JAP1eCZi26KSEq2WzxnBo
   WR4xF8g/E3wYA0HTvjSS5M+4BiomnlVWmbyuqQZik1vaEarnXqiv13Nkp
   6yHGxNOnqZpouM9YiiF8pd/gPkJNgFOl01l18Ym+o3JtDFOEpA9KsC+wL
   GGH+FqjUttCeZEuKC49qx/1WzdMP1khLYk5s9cvL2f1aGrSw3G4EoOIO1
   8XDC6VTa/kLByMipfECIOQK70f8V/5oWTCT1jWp78yUQpctojetOh5YjS
   w==;
X-CSE-ConnectionGUID: 6Dp4fngkQtO54PHyjJY4yw==
X-CSE-MsgGUID: n5GL2e8UR1a8nYBvOxt7LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="67142804"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="67142804"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 13:59:40 -0700
X-CSE-ConnectionGUID: NwpAwD5yQlS/G0MaI4CLOw==
X-CSE-MsgGUID: 7VFPDkmlTLuzUVtdN+OEmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139850955"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2025 13:59:39 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	przemyslaw.kitszel@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 15/16] libeth: xsk: add XSkFQ refill and XSk wakeup helpers
Date: Tue, 20 May 2025 13:59:16 -0700
Message-ID: <20250520205920.2134829-16-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
References: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

XSkFQ refill is pretty generic across the drivers minus FQ descriptor
filling and can easily be unified with one inline callback.
XSk wakeup is usually not, but here, instead of commonly used
"SW interrupts", I picked firing an IPI. In most tests, it showed better
performance; it also provides better control for userspace on which CPU
will handle the xmit, as SW interrupts honor IRQ affinity no matter
which core produces XSk xmit descs (while XDPSQs are associated 1:1
with cores having the same ID).

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libeth/xsk.c | 124 ++++++++++++++++++++++++
 include/net/libeth/xsk.h                |  98 +++++++++++++++++++
 2 files changed, 222 insertions(+)

diff --git a/drivers/net/ethernet/intel/libeth/xsk.c b/drivers/net/ethernet/intel/libeth/xsk.c
index ecb038f20df5..9a510a509dcd 100644
--- a/drivers/net/ethernet/intel/libeth/xsk.c
+++ b/drivers/net/ethernet/intel/libeth/xsk.c
@@ -143,3 +143,127 @@ u32 __cold libeth_xsk_prog_exception(struct libeth_xdp_buff *xdp,
 
 	return __ret;
 }
+
+/* Refill */
+
+/**
+ * libeth_xskfq_create - create an XSkFQ
+ * @fq: fill queue to initialize
+ *
+ * Allocates the FQEs and initializes the fields used by libeth_xdp: number
+ * of buffers to refill, refill threshold and buffer len.
+ *
+ * Return: %0 on success, -errno otherwise.
+ */
+int libeth_xskfq_create(struct libeth_xskfq *fq)
+{
+	fq->fqes = kvcalloc_node(fq->count, sizeof(*fq->fqes), GFP_KERNEL,
+				 fq->nid);
+	if (!fq->fqes)
+		return -ENOMEM;
+
+	fq->pending = fq->count;
+	fq->thresh = libeth_xdp_queue_threshold(fq->count);
+	fq->buf_len = xsk_pool_get_rx_frame_size(fq->pool);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(libeth_xskfq_create);
+
+/**
+ * libeth_xskfq_destroy - destroy an XSkFQ
+ * @fq: fill queue to destroy
+ *
+ * Zeroes the used fields and frees the FQEs array.
+ */
+void libeth_xskfq_destroy(struct libeth_xskfq *fq)
+{
+	fq->buf_len = 0;
+	fq->thresh = 0;
+	fq->pending = 0;
+
+	kvfree(fq->fqes);
+}
+EXPORT_SYMBOL_GPL(libeth_xskfq_destroy);
+
+/* .ndo_xsk_wakeup */
+
+static void libeth_xsk_napi_sched(void *info)
+{
+	__napi_schedule_irqoff(info);
+}
+
+/**
+ * libeth_xsk_init_wakeup - initialize libeth XSk wakeup structure
+ * @csd: struct to initialize
+ * @napi: NAPI corresponding to this queue
+ *
+ * libeth_xdp uses inter-processor interrupts to perform XSk wakeups. In order
+ * to do that, the corresponding CSDs must be initialized when creating the
+ * queues.
+ */
+void libeth_xsk_init_wakeup(call_single_data_t *csd, struct napi_struct *napi)
+{
+	INIT_CSD(csd, libeth_xsk_napi_sched, napi);
+}
+EXPORT_SYMBOL_GPL(libeth_xsk_init_wakeup);
+
+/**
+ * libeth_xsk_wakeup - perform an XSk wakeup
+ * @csd: CSD corresponding to the queue
+ * @qid: the stack queue index
+ *
+ * Try to mark the NAPI as missed first, so that it could be rescheduled.
+ * If it's not, schedule it on the corresponding CPU using IPIs (or directly
+ * if already running on it).
+ */
+void libeth_xsk_wakeup(call_single_data_t *csd, u32 qid)
+{
+	struct napi_struct *napi = csd->info;
+
+	if (napi_if_scheduled_mark_missed(napi) ||
+	    unlikely(!napi_schedule_prep(napi)))
+		return;
+
+	if (unlikely(qid >= nr_cpu_ids))
+		qid %= nr_cpu_ids;
+
+	if (qid != raw_smp_processor_id() && cpu_online(qid))
+		smp_call_function_single_async(qid, csd);
+	else
+		__napi_schedule(napi);
+}
+EXPORT_SYMBOL_GPL(libeth_xsk_wakeup);
+
+/* Pool setup */
+
+#define LIBETH_XSK_DMA_ATTR					\
+	(DMA_ATTR_WEAK_ORDERING | DMA_ATTR_SKIP_CPU_SYNC)
+
+/**
+ * libeth_xsk_setup_pool - setup or destroy an XSk pool for a queue
+ * @dev: target &net_device
+ * @qid: stack queue index to configure
+ * @enable: whether to enable or disable the pool
+ *
+ * Check that @qid is valid and then map or unmap the pool.
+ *
+ * Return: %0 on success, -errno otherwise.
+ */
+int libeth_xsk_setup_pool(struct net_device *dev, u32 qid, bool enable)
+{
+	struct xsk_buff_pool *pool;
+
+	pool = xsk_get_pool_from_qid(dev, qid);
+	if (!pool)
+		return -EINVAL;
+
+	if (enable)
+		return xsk_pool_dma_map(pool, dev->dev.parent,
+					LIBETH_XSK_DMA_ATTR);
+	else
+		xsk_pool_dma_unmap(pool, LIBETH_XSK_DMA_ATTR);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(libeth_xsk_setup_pool);
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index f3f338e566fc..213778a68476 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -584,4 +584,102 @@ __libeth_xsk_run_pass(struct libeth_xdp_buff *xdp,
 #define LIBETH_XSK_DEFINE_FINALIZE(name, flush, finalize)		     \
 	__LIBETH_XDP_DEFINE_FINALIZE(name, flush, finalize, xsk)
 
+/* Refilling */
+
+/**
+ * struct libeth_xskfq - structure representing an XSk buffer (fill) queue
+ * @fp: hotpath part of the structure
+ * @pool: &xsk_buff_pool for buffer management
+ * @fqes: array of XSk buffer pointers
+ * @descs: opaque pointer to the HW descriptor array
+ * @ntu: index of the next buffer to poll
+ * @count: number of descriptors/buffers the queue has
+ * @pending: current number of XSkFQEs to refill
+ * @thresh: threshold below which the queue is refilled
+ * @buf_len: HW-writeable length per each buffer
+ * @nid: ID of the closest NUMA node with memory
+ */
+struct libeth_xskfq {
+	struct_group_tagged(libeth_xskfq_fp, fp,
+		struct xsk_buff_pool	*pool;
+		struct libeth_xdp_buff	**fqes;
+		void			*descs;
+
+		u32			ntu;
+		u32			count;
+	);
+
+	/* Cold fields */
+	u32			pending;
+	u32			thresh;
+
+	u32			buf_len;
+	int			nid;
+};
+
+int libeth_xskfq_create(struct libeth_xskfq *fq);
+void libeth_xskfq_destroy(struct libeth_xskfq *fq);
+
+/**
+ * libeth_xsk_buff_xdp_get_dma - get DMA address of XSk &libeth_xdp_buff
+ * @xdp: buffer to get the DMA addr for
+ */
+#define libeth_xsk_buff_xdp_get_dma(xdp)				     \
+	xsk_buff_xdp_get_dma(&(xdp)->base)
+
+/**
+ * libeth_xskfqe_alloc - allocate @n XSk Rx buffers
+ * @fq: hotpath part of the XSkFQ, usually onstack
+ * @n: number of buffers to allocate
+ * @fill: driver callback to write DMA addresses to HW descriptors
+ *
+ * Note that @fq->ntu gets updated, but ::pending must be recalculated
+ * by the caller.
+ *
+ * Return: number of buffers refilled.
+ */
+static __always_inline u32
+libeth_xskfqe_alloc(struct libeth_xskfq_fp *fq, u32 n,
+		    void (*fill)(const struct libeth_xskfq_fp *fq, u32 i))
+{
+	u32 this, ret, done = 0;
+	struct xdp_buff **xskb;
+
+	this = fq->count - fq->ntu;
+	if (likely(this > n))
+		this = n;
+
+again:
+	xskb = (typeof(xskb))&fq->fqes[fq->ntu];
+	ret = xsk_buff_alloc_batch(fq->pool, xskb, this);
+
+	for (u32 i = 0, ntu = fq->ntu; likely(i < ret); i++)
+		fill(fq, ntu + i);
+
+	done += ret;
+	fq->ntu += ret;
+
+	if (likely(fq->ntu < fq->count) || unlikely(ret < this))
+		goto out;
+
+	fq->ntu = 0;
+
+	if (this < n) {
+		this = n - this;
+		goto again;
+	}
+
+out:
+	return done;
+}
+
+/* .ndo_xsk_wakeup */
+
+void libeth_xsk_init_wakeup(call_single_data_t *csd, struct napi_struct *napi);
+void libeth_xsk_wakeup(call_single_data_t *csd, u32 qid);
+
+/* Pool setup */
+
+int libeth_xsk_setup_pool(struct net_device *dev, u32 qid, bool enable);
+
 #endif /* __LIBETH_XSK_H */
-- 
2.47.1


