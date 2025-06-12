Return-Path: <bpf+bounces-60503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 425E8AD77F2
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 18:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE3C1885416
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E83B2D6633;
	Thu, 12 Jun 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vy0qucol"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7A2D6624;
	Thu, 12 Jun 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744644; cv=none; b=H+yOOg7CED/59ywrbTq31vuL7pBcvXelvT2enZy6qQg4AUHgOnbyMhWdxpDUXR2TgFePy7tjtX9SLgWpp26I6Ta/D0yxHg3f5lVSSTE+BIv7HZnoDRUQSdPBqetDxiAUyWigLxMdxA0aGc6wSkjxxYih+F1HJeEooLFahu7v5d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744644; c=relaxed/simple;
	bh=GsrG0WBo3rncb+OujswgQSAEPpqLz3VKgUs3EyJkE3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt0kzRbEphfrCqufJK8FQdZ43bHBGVRVgSXfalcDyKySimy4sg2JyPr4EdJZujec98PDYrTyb6P1adC3LmXkdB/RoJgU9wENdFsSuaatHjD4fGd3qHFbnNRs4yTxH9rXhZYDcZI4+mri4TkNSFsmMIKg9r+51s1naAT4ATWe3iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vy0qucol; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749744643; x=1781280643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GsrG0WBo3rncb+OujswgQSAEPpqLz3VKgUs3EyJkE3k=;
  b=Vy0qucolPhEZ4HIaGh3PRn047x1An926Qxa53OEh//N/DcaIsRrUu7WB
   6QUb4HCppW7VP/JCerBiMIaaY+oSXOvZhfIEluWb4+cfPiQipwI54yiPA
   3BUwcfmlCtVQvtIKdOKzu4sntmvdRy/xp274Xq8KZkdlSrhGkC4oOx3St
   clMyKJAh7RV+a0qN+WVBs+gCm7Pwkic+JvaxjNmFXfEh6V8lcbwUHYkQ0
   yy5UpaGAtBgm2Knt7i/zdfA6G34BJyWrdlSfiK2ufoV8LCc4+FMdJchbq
   Flc8tyGP3JOApfseVwUGYVP0jVeXGdS1RmeYEIxSPD3va7BfIQC67pZZT
   w==;
X-CSE-ConnectionGUID: ru5CdWHATSGUyQDQxIAR4w==
X-CSE-MsgGUID: PhNIq+jzS+aR1YsFs6FFmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55739178"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55739178"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:10:43 -0700
X-CSE-ConnectionGUID: E6XKDa2jTQm+0TuY11SzCA==
X-CSE-MsgGUID: f1IWFw/mRlmkGvvyJ9X9wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148468671"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2025 09:10:39 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 16/17] libeth: xsk: add XSkFQ refill and XSk wakeup helpers
Date: Thu, 12 Jun 2025 18:02:33 +0200
Message-ID: <20250612160234.68682-17-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612160234.68682-1-aleksander.lobakin@intel.com>
References: <20250612160234.68682-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XSkFQ refill is pretty generic across the drivers minus FQ descriptor
filling and can easily be unified with one inline callback.
XSk wakeup is usually not, but here, instead of commonly used
"SW interrupts", I picked firing an IPI. In most tests, it showed better
performance; it also provides better control for userspace on which CPU
will handle the xmit, as SW interrupts honor IRQ affinity no matter
which core produces XSk xmit descs (while XDPSQs are associated 1:1
with cores having the same ID).

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/xsk.h                |  98 +++++++++++++++++++
 drivers/net/ethernet/intel/libeth/xsk.c | 124 ++++++++++++++++++++++++
 2 files changed, 222 insertions(+)

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
diff --git a/drivers/net/ethernet/intel/libeth/xsk.c b/drivers/net/ethernet/intel/libeth/xsk.c
index f8f4016d1b25..846e902e31b6 100644
--- a/drivers/net/ethernet/intel/libeth/xsk.c
+++ b/drivers/net/ethernet/intel/libeth/xsk.c
@@ -145,3 +145,127 @@ u32 __cold libeth_xsk_prog_exception(struct libeth_xdp_buff *xdp,
 
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
-- 
2.49.0


