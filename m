Return-Path: <bpf+bounces-60492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7362AD77B4
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 18:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AF417AAF8
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D662BE7D5;
	Thu, 12 Jun 2025 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FN7mSIvA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4CB29B8D9;
	Thu, 12 Jun 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744591; cv=none; b=rVpca8i4YZMWtgZwD4VrA9L02N7SIP2UAyNDUiyXhgUQq4kUHRTK9NRag0RK6L22qxMNbXKX0z6pb95AIc8odS4POz0hL6d62kAqbpWrUNGguhjGH+KSlaQpu4I/7n36FtQ1Jq+Q733i//o0UcMhm++HA652X1y99wpzYmJnjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744591; c=relaxed/simple;
	bh=SH10zK6PVfFQu0FHquqfTgXieTxybi2jL2/jUtz1Ovk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvV7jAN2VoEiBJ2PSBBFgzSMxo/hMhoerLLcaRXkof1tbgRnf17dW1JtRBSIU7z5LWmrSJeq8rPbzGkEpLEwKfnhNKtGG17q9U3S/zc8OVxUSUqX30Q/rgia9YbYVoRzpyRa/IOtIoOJLqmOohStgynkULY+WfCRDVA1fL9W6ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FN7mSIvA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749744590; x=1781280590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SH10zK6PVfFQu0FHquqfTgXieTxybi2jL2/jUtz1Ovk=;
  b=FN7mSIvACYaz5An7rDHB8j8cHaK9nxFBhZH+bzgrSZlYMzz1zmfGyFq7
   t+mwcIii0peijC9m/w33pQwVxsfNMG/+cwqdWMHyP3QIi3a6kOvubu7eV
   bky+2PfG15jXiwhXXzxDKlHb4v+2ajiiO/WzfrA2+RXDgibBU+gTPSMZr
   oWhHdnR8wzgFMcXYUCXAlyl8oZ1/UAGLEHy/Yg6XjmGssa+9d+kIC4mwx
   MHd1oN0AI5wkmWhZ5Fq5aAyb7PounSwuxXv2ee0IIR/UqrLHW0oSmL7Vn
   cBXFPhUGt94RCK+7sARP5N6ZA/oH2lktf62/NeUePU4aRAjzGdrg4vPLS
   g==;
X-CSE-ConnectionGUID: YWsJIR23Rs2g87RI9ek3zw==
X-CSE-MsgGUID: Ei4boW7VSeeEdbvBFOTKFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55738897"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55738897"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:09:49 -0700
X-CSE-ConnectionGUID: cCTit0hzRSiJai1ifyDwOg==
X-CSE-MsgGUID: 9uMr1t5DR8GnMwAp+ty3Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148468570"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2025 09:09:45 -0700
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
Subject: [PATCH iwl-next v2 05/17] libeth: xdp: add .ndo_xdp_xmit() helpers
Date: Thu, 12 Jun 2025 18:02:22 +0200
Message-ID: <20250612160234.68682-6-aleksander.lobakin@intel.com>
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

Add helpers for implementing .ndo_xdp_xmit().
Same as for XDP_TX, accumulate up to 16 DMA-mapped frames on the stack,
then flush. If DMA mapping is failed for some reason, don't try mapping
further frames, but still flush what was already prepared.
DMA address of a head frame is stored in its headroom, assuming it
has enough of it for an 8 (or 4) byte value.
In addition to @prep and @xmit driver callbacks in XDP_TX, xmit also
needs @finalize to kick the XDPSQ after filling.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/tx.h                 |   6 +
 include/net/libeth/xdp.h                | 290 +++++++++++++++++++++++-
 drivers/net/ethernet/intel/libeth/xdp.c |  37 ++-
 3 files changed, 328 insertions(+), 5 deletions(-)

diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
index 3e68d11914f7..e2b62a8b4c57 100644
--- a/include/net/libeth/tx.h
+++ b/include/net/libeth/tx.h
@@ -19,6 +19,8 @@
  * @LIBETH_SQE_SKB: &sk_buff, unmap and napi_consume_skb(), update stats
  * @__LIBETH_SQE_XDP_START: separator between skb and XDP types
  * @LIBETH_SQE_XDP_TX: &skb_shared_info, libeth_xdp_return_buff_bulk(), stats
+ * @LIBETH_SQE_XDP_XMIT: &xdp_frame, unmap and xdp_return_frame_bulk(), stats
+ * @LIBETH_SQE_XDP_XMIT_FRAG: &xdp_frame frag, only unmap DMA
  */
 enum libeth_sqe_type {
 	LIBETH_SQE_EMPTY		= 0U,
@@ -29,6 +31,8 @@ enum libeth_sqe_type {
 
 	__LIBETH_SQE_XDP_START,
 	LIBETH_SQE_XDP_TX		= __LIBETH_SQE_XDP_START,
+	LIBETH_SQE_XDP_XMIT,
+	LIBETH_SQE_XDP_XMIT_FRAG,
 };
 
 /**
@@ -38,6 +42,7 @@ enum libeth_sqe_type {
  * @raw: slab buffer to free via kfree()
  * @skb: &sk_buff to consume
  * @sinfo: skb shared info of an XDP_TX frame
+ * @xdpf: XDP frame from ::ndo_xdp_xmit()
  * @dma: DMA address to unmap
  * @len: length of the mapped region to unmap
  * @nr_frags: number of frags in the frame this buffer belongs to
@@ -53,6 +58,7 @@ struct libeth_sqe {
 		void				*raw;
 		struct sk_buff			*skb;
 		struct skb_shared_info		*sinfo;
+		struct xdp_frame		*xdpf;
 	};
 
 	DEFINE_DMA_UNMAP_ADDR(dma);
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index 4988453a3d70..839001d901b2 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -11,6 +11,17 @@
 #include <net/libeth/tx.h>
 #include <net/xsk_buff_pool.h>
 
+/*
+ * Defined as bits to be able to use them as a mask on Rx.
+ * Also used as internal return values on Tx.
+ */
+enum {
+	LIBETH_XDP_PASS			= 0U,
+	LIBETH_XDP_DROP			= BIT(0),
+	LIBETH_XDP_ABORTED		= BIT(1),
+	LIBETH_XDP_TX			= BIT(2),
+};
+
 /*
  * &xdp_buff_xsk is the largest structure &libeth_xdp_buff gets casted to,
  * pick maximum pointer-compatible alignment.
@@ -56,12 +67,14 @@ static_assert(IS_ALIGNED(sizeof(struct xdp_buff_xsk),
  * @LIBETH_XDP_TX_BULK: one bulk size at which it will be flushed to the queue
  * @LIBETH_XDP_TX_BATCH: batch size for which the queue fill loop is unrolled
  * @LIBETH_XDP_TX_DROP: indicates the send function must drop frames not sent
+ * @LIBETH_XDP_TX_NDO: whether the send function is called from .ndo_xdp_xmit()
  */
 enum {
 	LIBETH_XDP_TX_BULK		= DEV_MAP_BULK_SIZE,
 	LIBETH_XDP_TX_BATCH		= 8,
 
 	LIBETH_XDP_TX_DROP		= BIT(0),
+	LIBETH_XDP_TX_NDO		= BIT(1),
 };
 
 /**
@@ -88,6 +101,11 @@ enum {
  * @len_fl: ``XDP_TX``, combined flags [31:16] and len [15:0] field for speed
  * @soff: ``XDP_TX``, offset from @data to the start of &skb_shared_info
  * @frag: one (non-head) frag for ``XDP_TX``
+ * @xdpf: &xdp_frame for the head frag for .ndo_xdp_xmit()
+ * @dma: DMA address of the non-head frag for .ndo_xdp_xmit()
+ * @len: frag length for .ndo_xdp_xmit()
+ * @flags: Tx flags for the above
+ * @opts: combined @len + @flags for the above for speed
  */
 struct libeth_xdp_tx_frame {
 	union {
@@ -100,6 +118,21 @@ struct libeth_xdp_tx_frame {
 
 		/* ``XDP_TX`` frag */
 		skb_frag_t			frag;
+
+		/* .ndo_xdp_xmit() */
+		struct {
+			union {
+				struct xdp_frame		*xdpf;
+				dma_addr_t			dma;
+			};
+			union {
+				struct {
+					u32				len;
+					u32				flags;
+				};
+				aligned_u64			opts;
+			};
+		};
 	};
 } __aligned_largest;
 static_assert(offsetof(struct libeth_xdp_tx_frame, frag.len) ==
@@ -107,7 +140,7 @@ static_assert(offsetof(struct libeth_xdp_tx_frame, frag.len) ==
 
 /**
  * struct libeth_xdp_tx_bulk - XDP Tx frame bulk for bulk sending
- * @prog: corresponding active XDP program
+ * @prog: corresponding active XDP program, %NULL for .ndo_xdp_xmit()
  * @dev: &net_device which the frames are transmitted on
  * @xdpsq: shortcut to the corresponding driver-specific XDPSQ structure
  * @count: current number of frames in @bulk
@@ -445,7 +478,7 @@ void libeth_xdp_tx_exception(struct libeth_xdp_tx_bulk *bq, u32 sent,
 /**
  * __libeth_xdp_tx_flush_bulk - internal helper to flush one XDP Tx bulk
  * @bq: bulk to flush
- * @flags: XDP TX flags
+ * @flags: XDP TX flags (.ndo_xdp_xmit() etc.)
  * @prep: driver-specific callback to prepare the queue for sending
  * @fill: libeth_xdp callback to fill &libeth_sqe and &libeth_xdp_tx_desc
  * @xmit: driver callback to fill a HW descriptor
@@ -495,6 +528,259 @@ __libeth_xdp_tx_flush_bulk(struct libeth_xdp_tx_bulk *bq, u32 flags,
 	__libeth_xdp_tx_flush_bulk(bq, flags, prep, libeth_xdp_tx_fill_buf,   \
 				   xmit)
 
+/* .ndo_xdp_xmit() implementation */
+
+/**
+ * libeth_xdp_xmit_frame_dma - internal helper to access DMA of an &xdp_frame
+ * @xf: pointer to the XDP frame
+ *
+ * There's no place in &libeth_xdp_tx_frame to store DMA address for an
+ * &xdp_frame head. The headroom is used then, the address is placed right
+ * after the frame struct, naturally aligned.
+ *
+ * Return: pointer to the DMA address to use.
+ */
+#define libeth_xdp_xmit_frame_dma(xf)					      \
+	_Generic((xf),							      \
+		 const struct xdp_frame *:				      \
+			(const dma_addr_t *)__libeth_xdp_xmit_frame_dma(xf),  \
+		 struct xdp_frame *:					      \
+			(dma_addr_t *)__libeth_xdp_xmit_frame_dma(xf)	      \
+	)
+
+static inline void *__libeth_xdp_xmit_frame_dma(const struct xdp_frame *xdpf)
+{
+	void *addr = (void *)(xdpf + 1);
+
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
+	    __alignof(*xdpf) < sizeof(dma_addr_t))
+		addr = PTR_ALIGN(addr, sizeof(dma_addr_t));
+
+	return addr;
+}
+
+/**
+ * libeth_xdp_xmit_queue_head - internal helper for queueing one XDP xmit head
+ * @bq: XDP Tx bulk to queue the head frag to
+ * @xdpf: XDP frame with the head to queue
+ * @dev: device to perform DMA mapping
+ *
+ * Return: ``LIBETH_XDP_DROP`` on DMA mapping error,
+ *	   ``LIBETH_XDP_PASS`` if it's the only frag in the frame,
+ *	   ``LIBETH_XDP_TX`` if it's an S/G frame.
+ */
+static inline u32 libeth_xdp_xmit_queue_head(struct libeth_xdp_tx_bulk *bq,
+					     struct xdp_frame *xdpf,
+					     struct device *dev)
+{
+	dma_addr_t dma;
+
+	dma = dma_map_single(dev, xdpf->data, xdpf->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, dma))
+		return LIBETH_XDP_DROP;
+
+	*libeth_xdp_xmit_frame_dma(xdpf) = dma;
+
+	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
+		.xdpf	= xdpf,
+		.len	= xdpf->len,
+		.flags	= LIBETH_XDP_TX_FIRST,
+	};
+
+	if (!xdp_frame_has_frags(xdpf))
+		return LIBETH_XDP_PASS;
+
+	bq->bulk[bq->count - 1].flags |= LIBETH_XDP_TX_MULTI;
+
+	return LIBETH_XDP_TX;
+}
+
+/**
+ * libeth_xdp_xmit_queue_frag - internal helper for queueing one XDP xmit frag
+ * @bq: XDP Tx bulk to queue the frag to
+ * @frag: frag to queue
+ * @dev: device to perform DMA mapping
+ *
+ * Return: true on success, false on DMA mapping error.
+ */
+static inline bool libeth_xdp_xmit_queue_frag(struct libeth_xdp_tx_bulk *bq,
+					      const skb_frag_t *frag,
+					      struct device *dev)
+{
+	dma_addr_t dma;
+
+	dma = skb_frag_dma_map(dev, frag);
+	if (dma_mapping_error(dev, dma))
+		return false;
+
+	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
+		.dma	= dma,
+		.len	= skb_frag_size(frag),
+	};
+
+	return true;
+}
+
+/**
+ * libeth_xdp_xmit_queue_bulk - internal helper for queueing one XDP xmit frame
+ * @bq: XDP Tx bulk to queue the frame to
+ * @xdpf: XDP frame to queue
+ * @flush_bulk: driver callback to flush the bulk to the HW queue
+ *
+ * Return: ``LIBETH_XDP_TX`` on success,
+ *	   ``LIBETH_XDP_DROP`` if the frame should be dropped by the stack,
+ *	   ``LIBETH_XDP_ABORTED`` if the frame will be dropped by libeth_xdp.
+ */
+static __always_inline u32
+libeth_xdp_xmit_queue_bulk(struct libeth_xdp_tx_bulk *bq,
+			   struct xdp_frame *xdpf,
+			   bool (*flush_bulk)(struct libeth_xdp_tx_bulk *bq,
+					      u32 flags))
+{
+	u32 head, nr_frags, i, ret = LIBETH_XDP_TX;
+	struct device *dev = bq->dev->dev.parent;
+	const struct skb_shared_info *sinfo;
+
+	if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
+	    unlikely(!flush_bulk(bq, LIBETH_XDP_TX_NDO)))
+		return LIBETH_XDP_DROP;
+
+	head = libeth_xdp_xmit_queue_head(bq, xdpf, dev);
+	if (head == LIBETH_XDP_PASS)
+		goto out;
+	else if (head == LIBETH_XDP_DROP)
+		return LIBETH_XDP_DROP;
+
+	sinfo = xdp_get_shared_info_from_frame(xdpf);
+	nr_frags = sinfo->nr_frags;
+
+	for (i = 0; i < nr_frags; i++) {
+		if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
+		    unlikely(!flush_bulk(bq, LIBETH_XDP_TX_NDO)))
+			break;
+
+		if (!libeth_xdp_xmit_queue_frag(bq, &sinfo->frags[i], dev))
+			break;
+	}
+
+	if (unlikely(i < nr_frags))
+		ret = LIBETH_XDP_ABORTED;
+
+out:
+	bq->bulk[bq->count - 1].flags |= LIBETH_XDP_TX_LAST;
+
+	return ret;
+}
+
+/**
+ * libeth_xdp_xmit_fill_buf - internal helper to fill one XDP xmit &libeth_sqe
+ * @frm: XDP Tx frame from the bulk
+ * @i: index on the HW queue
+ * @sq: XDPSQ abstraction for the queue
+ * @priv: private data
+ *
+ * Return: XDP Tx descriptor with the mapped DMA and other info to pass to
+ * the driver callback.
+ */
+static inline struct libeth_xdp_tx_desc
+libeth_xdp_xmit_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
+			 const struct libeth_xdpsq *sq, u64 priv)
+{
+	struct libeth_xdp_tx_desc desc;
+	struct libeth_sqe *sqe;
+	struct xdp_frame *xdpf;
+
+	if (frm.flags & LIBETH_XDP_TX_FIRST) {
+		xdpf = frm.xdpf;
+		desc.addr = *libeth_xdp_xmit_frame_dma(xdpf);
+	} else {
+		xdpf = NULL;
+		desc.addr = frm.dma;
+	}
+	desc.opts = frm.opts;
+
+	sqe = &sq->sqes[i];
+	dma_unmap_addr_set(sqe, dma, desc.addr);
+	dma_unmap_len_set(sqe, len, desc.len);
+
+	if (!xdpf) {
+		sqe->type = LIBETH_SQE_XDP_XMIT_FRAG;
+		return desc;
+	}
+
+	sqe->type = LIBETH_SQE_XDP_XMIT;
+	sqe->xdpf = xdpf;
+	libeth_xdp_tx_fill_stats(sqe, &desc,
+				 xdp_get_shared_info_from_frame(xdpf));
+
+	return desc;
+}
+
+/**
+ * libeth_xdp_xmit_flush_bulk - wrapper to define flush of one XDP xmit bulk
+ * @bq: bulk to flush
+ * @flags: Tx flags, see __libeth_xdp_tx_flush_bulk()
+ * @prep: driver callback to prepare the queue
+ * @xmit: driver callback to fill a HW descriptor
+ */
+#define libeth_xdp_xmit_flush_bulk(bq, flags, prep, xmit)		      \
+	__libeth_xdp_tx_flush_bulk(bq, (flags) | LIBETH_XDP_TX_NDO, prep,     \
+				   libeth_xdp_xmit_fill_buf, xmit)
+
+u32 libeth_xdp_xmit_return_bulk(const struct libeth_xdp_tx_frame *bq,
+				u32 count, const struct net_device *dev);
+
+/**
+ * __libeth_xdp_xmit_do_bulk - internal function to implement .ndo_xdp_xmit()
+ * @bq: XDP Tx bulk to queue frames to
+ * @frames: XDP frames passed by the stack
+ * @n: number of frames
+ * @flags: flags passed by the stack
+ * @flush_bulk: driver callback to flush an XDP xmit bulk
+ * @finalize: driver callback to finalize sending XDP Tx frames on the queue
+ *
+ * Perform common checks, map the frags and queue them to the bulk, then flush
+ * the bulk to the XDPSQ. If requested by the stack, finalize the queue.
+ *
+ * Return: number of frames send or -errno on error.
+ */
+static __always_inline int
+__libeth_xdp_xmit_do_bulk(struct libeth_xdp_tx_bulk *bq,
+			  struct xdp_frame **frames, u32 n, u32 flags,
+			  bool (*flush_bulk)(struct libeth_xdp_tx_bulk *bq,
+					     u32 flags),
+			  void (*finalize)(void *xdpsq, bool sent, bool flush))
+{
+	u32 nxmit = 0;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	for (u32 i = 0; likely(i < n); i++) {
+		u32 ret;
+
+		ret = libeth_xdp_xmit_queue_bulk(bq, frames[i], flush_bulk);
+		if (unlikely(ret != LIBETH_XDP_TX)) {
+			nxmit += ret == LIBETH_XDP_ABORTED;
+			break;
+		}
+
+		nxmit++;
+	}
+
+	if (bq->count) {
+		flush_bulk(bq, LIBETH_XDP_TX_NDO);
+		if (unlikely(bq->count))
+			nxmit -= libeth_xdp_xmit_return_bulk(bq->bulk,
+							     bq->count,
+							     bq->dev);
+	}
+
+	finalize(bq->xdpsq, nxmit, flags & XDP_XMIT_FLUSH);
+
+	return nxmit;
+}
+
 /* Rx polling path */
 
 static inline void libeth_xdp_return_va(const void *data, bool napi)
diff --git a/drivers/net/ethernet/intel/libeth/xdp.c b/drivers/net/ethernet/intel/libeth/xdp.c
index 444449c72221..c65ea5d2746a 100644
--- a/drivers/net/ethernet/intel/libeth/xdp.c
+++ b/drivers/net/ethernet/intel/libeth/xdp.c
@@ -42,7 +42,7 @@ static void __cold libeth_trace_xdp_exception(const struct net_device *dev,
  * libeth_xdp_tx_exception - handle Tx exceptions of XDP frames
  * @bq: XDP Tx frame bulk
  * @sent: number of frames sent successfully (from this bulk)
- * @flags: internal libeth_xdp flags
+ * @flags: internal libeth_xdp flags (.ndo_xdp_xmit etc.)
  *
  * Cold helper used by __libeth_xdp_tx_flush_bulk(), do not call directly.
  * Reports XDP Tx exceptions, frees the frames that won't be sent or adjust
@@ -54,7 +54,8 @@ void __cold libeth_xdp_tx_exception(struct libeth_xdp_tx_bulk *bq, u32 sent,
 	const struct libeth_xdp_tx_frame *pos = &bq->bulk[sent];
 	u32 left = bq->count - sent;
 
-	libeth_trace_xdp_exception(bq->dev, bq->prog, XDP_TX);
+	if (!(flags & LIBETH_XDP_TX_NDO))
+		libeth_trace_xdp_exception(bq->dev, bq->prog, XDP_TX);
 
 	if (!(flags & LIBETH_XDP_TX_DROP)) {
 		memmove(bq->bulk, pos, left * sizeof(*bq->bulk));
@@ -63,12 +64,42 @@ void __cold libeth_xdp_tx_exception(struct libeth_xdp_tx_bulk *bq, u32 sent,
 		return;
 	}
 
-	libeth_xdp_tx_return_bulk(pos, left);
+	if (!(flags & LIBETH_XDP_TX_NDO))
+		libeth_xdp_tx_return_bulk(pos, left);
+	else
+		libeth_xdp_xmit_return_bulk(pos, left, bq->dev);
 
 	bq->count = 0;
 }
 EXPORT_SYMBOL_GPL(libeth_xdp_tx_exception);
 
+/* .ndo_xdp_xmit() implementation */
+
+u32 __cold libeth_xdp_xmit_return_bulk(const struct libeth_xdp_tx_frame *bq,
+				       u32 count, const struct net_device *dev)
+{
+	u32 n = 0;
+
+	for (u32 i = 0; i < count; i++) {
+		const struct libeth_xdp_tx_frame *frm = &bq[i];
+		dma_addr_t dma;
+
+		if (frm->flags & LIBETH_XDP_TX_FIRST)
+			dma = *libeth_xdp_xmit_frame_dma(frm->xdpf);
+		else
+			dma = dma_unmap_addr(frm, dma);
+
+		dma_unmap_page(dev->dev.parent, dma, dma_unmap_len(frm, len),
+			       DMA_TO_DEVICE);
+
+		/* Actual xdp_frames are freed by the core */
+		n += !!(frm->flags & LIBETH_XDP_TX_FIRST);
+	}
+
+	return n;
+}
+EXPORT_SYMBOL_GPL(libeth_xdp_xmit_return_bulk);
+
 /* Rx polling path */
 
 /**
-- 
2.49.0


