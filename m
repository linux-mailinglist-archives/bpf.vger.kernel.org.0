Return-Path: <bpf+bounces-55988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101D8A8A59E
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D561894284
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E512B2356CB;
	Tue, 15 Apr 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeHp0Otk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA6221DB3;
	Tue, 15 Apr 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738186; cv=none; b=g5OaoHB5WlcIf8X+VftW2hHVychuQElwGl9mecBSZ11gfRs6KkL86PV+vOsQdeKmasaED8YDgGwrnQPGbvdW6u3n0nP4NJY3u3EY6lpXMIDhMApuESYWywuINOiM+9Fb5t9qfiYO7PUXEb7HuL6qqSXW/9FFmAPWgCiDzZ+lOo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738186; c=relaxed/simple;
	bh=4gS8Oi+ud5GCCWWLiDaufXxtrWjrhStykk+LzzSul8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erx267rfuTeRSFthjXIScguIYpW+upqXZ43j5dgRvbgS2ukcijdufZ1XGJAEWJCoq3Z+qfshV8+5oammDlJlZu/kt28nw4gwj2lSw69zxWilACZQjdcuyNNHX97dkpQNMrBqFDBq4XIGcWBkevqE9W6wFia3bGJNtYOtAgAn9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeHp0Otk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744738185; x=1776274185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4gS8Oi+ud5GCCWWLiDaufXxtrWjrhStykk+LzzSul8U=;
  b=BeHp0OtkWPU//1kV2MUFB9Zk7Xvm2GRak0Xw5SJExYTkHNJ4JV6E+NuZ
   261TV3AjXJiUxaK/acj1Mzb8Kf5aWrG6M1ip5GQRVydnb6isKdqGkzJA+
   b8XRF2SFrSBP79KvVW8ktbSM2i5So1iPuaDY0qb2N4PIkKk5RLtDHPT5R
   nV2sbyig949EHEUmyAhwTyeLmh1kqjHJZBHHmisuKss5NQDb/9jDLjDp4
   8nuhZu7EdMh5DgtRb3YMCkvuFAsqTwsGs/dqWSh/SQrSbRv8P9V1837Vs
   LUe0UXnlr9RfF73WXDDTu5qjA8NWPjLHVXETHtJ94bJ/sJlknR7snifFH
   A==;
X-CSE-ConnectionGUID: S6OMYhg2QIaZrjm7b0X7Lw==
X-CSE-MsgGUID: Dm1dNdFpSCuK3FhR+j8n2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46275779"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46275779"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:29:44 -0700
X-CSE-ConnectionGUID: dycd22E5TJSIXv43BIwh+Q==
X-CSE-MsgGUID: /ohl+CDiRVmEoMP9mdFkeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130729830"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 15 Apr 2025 10:29:40 -0700
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
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 12/16] libeth: xsk: add XSk XDP_TX sending helpers
Date: Tue, 15 Apr 2025 19:28:21 +0200
Message-ID: <20250415172825.3731091-13-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
References: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Xsk counterparts for XDP_TX buffer sending and completion.
The same base structures and functions used from the libeth_xdp core,
with adjustments to that XSk Rx always operates on &xdp_buff_xsk for
both head and frags. And unlike regular Rx, here unlikely() are used
for frags, as the header split gives no benefits for XSk Rx, at
least for now.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/libeth/Kconfig  |   2 +-
 drivers/net/ethernet/intel/libeth/Makefile |   1 +
 drivers/net/ethernet/intel/libeth/priv.h   |   6 +
 include/net/libeth/tx.h                    |   6 +
 include/net/libeth/xdp.h                   |  26 +++-
 include/net/libeth/xsk.h                   | 148 +++++++++++++++++++++
 drivers/net/ethernet/intel/libeth/tx.c     |   5 +-
 drivers/net/ethernet/intel/libeth/xdp.c    |   7 +-
 drivers/net/ethernet/intel/libeth/xsk.c    |  32 +++++
 9 files changed, 224 insertions(+), 9 deletions(-)
 create mode 100644 include/net/libeth/xsk.h
 create mode 100644 drivers/net/ethernet/intel/libeth/xsk.c

diff --git a/drivers/net/ethernet/intel/libeth/Kconfig b/drivers/net/ethernet/intel/libeth/Kconfig
index d8c4926574fb..2445b979c499 100644
--- a/drivers/net/ethernet/intel/libeth/Kconfig
+++ b/drivers/net/ethernet/intel/libeth/Kconfig
@@ -12,4 +12,4 @@ config LIBETH_XDP
 	tristate "Common XDP library (libeth_xdp)" if COMPILE_TEST
 	select LIBETH
 	help
-	  XDP helpers based on libeth hotpath management.
+	  XDP and XSk helpers based on libeth hotpath management.
diff --git a/drivers/net/ethernet/intel/libeth/Makefile b/drivers/net/ethernet/intel/libeth/Makefile
index 51669840ee06..350bc0b38bad 100644
--- a/drivers/net/ethernet/intel/libeth/Makefile
+++ b/drivers/net/ethernet/intel/libeth/Makefile
@@ -9,3 +9,4 @@ libeth-y			+= tx.o
 obj-$(CONFIG_LIBETH_XDP)	+= libeth_xdp.o
 
 libeth_xdp-y			+= xdp.o
+libeth_xdp-y			+= xsk.o
diff --git a/drivers/net/ethernet/intel/libeth/priv.h b/drivers/net/ethernet/intel/libeth/priv.h
index 1bd6e2d7a3e7..ebcb26f24401 100644
--- a/drivers/net/ethernet/intel/libeth/priv.h
+++ b/drivers/net/ethernet/intel/libeth/priv.h
@@ -8,12 +8,18 @@
 
 /* XDP */
 
+struct libeth_xdp_buff;
+struct libeth_xdp_tx_frame;
 struct skb_shared_info;
 struct xdp_frame_bulk;
 
+void libeth_xsk_tx_return_bulk(const struct libeth_xdp_tx_frame *bq,
+			       u32 count);
+
 struct libeth_xdp_ops {
 	void	(*bulk)(const struct skb_shared_info *sinfo,
 			struct xdp_frame_bulk *bq, bool frags);
+	void	(*xsk)(struct libeth_xdp_buff *xdp);
 };
 
 void libeth_attach_xdp(const struct libeth_xdp_ops *ops);
diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
index 33b9bb22f6ac..44192bec86d7 100644
--- a/include/net/libeth/tx.h
+++ b/include/net/libeth/tx.h
@@ -21,6 +21,8 @@
  * @LIBETH_SQE_XDP_TX: &skb_shared_info, libeth_xdp_return_buff_bulk(), stats
  * @LIBETH_SQE_XDP_XMIT: &xdp_frame, unmap and xdp_return_frame_bulk(), stats
  * @LIBETH_SQE_XDP_XMIT_FRAG: &xdp_frame frag, only unmap DMA
+ * @LIBETH_SQE_XSK_TX: &libeth_xdp_buff on XSk queue, xsk_buff_free(), stats
+ * @LIBETH_SQE_XSK_TX_FRAG: &libeth_xdp_buff frag on XSk queue, xsk_buff_free()
  */
 enum libeth_sqe_type {
 	LIBETH_SQE_EMPTY		= 0U,
@@ -33,6 +35,8 @@ enum libeth_sqe_type {
 	LIBETH_SQE_XDP_TX		= __LIBETH_SQE_XDP_START,
 	LIBETH_SQE_XDP_XMIT,
 	LIBETH_SQE_XDP_XMIT_FRAG,
+	LIBETH_SQE_XSK_TX,
+	LIBETH_SQE_XSK_TX_FRAG,
 };
 
 /**
@@ -43,6 +47,7 @@ enum libeth_sqe_type {
  * @skb: &sk_buff to consume
  * @sinfo: skb shared info of an XDP_TX frame
  * @xdpf: XDP frame from ::ndo_xdp_xmit()
+ * @xsk: XSk Rx frame from XDP_TX action
  * @dma: DMA address to unmap
  * @len: length of the mapped region to unmap
  * @nr_frags: number of frags in the frame this buffer belongs to
@@ -59,6 +64,7 @@ struct libeth_sqe {
 		struct sk_buff			*skb;
 		struct skb_shared_info		*sinfo;
 		struct xdp_frame		*xdpf;
+		struct libeth_xdp_buff		*xsk;
 	};
 
 	DEFINE_DMA_UNMAP_ADDR(dma);
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index f0b1160bee51..dcda8f7decfa 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -279,6 +279,7 @@ libeth_xdpsq_run_timer(struct work_struct *work,
  * @LIBETH_XDP_TX_BATCH: batch size for which the queue fill loop is unrolled
  * @LIBETH_XDP_TX_DROP: indicates the send function must drop frames not sent
  * @LIBETH_XDP_TX_NDO: whether the send function is called from .ndo_xdp_xmit()
+ * @LIBETH_XDP_TX_XSK: whether the function is called for ``XDP_TX`` for XSk
  */
 enum {
 	LIBETH_XDP_TX_BULK		= DEV_MAP_BULK_SIZE,
@@ -286,6 +287,7 @@ enum {
 
 	LIBETH_XDP_TX_DROP		= BIT(0),
 	LIBETH_XDP_TX_NDO		= BIT(1),
+	LIBETH_XDP_TX_XSK		= BIT(2),
 };
 
 /**
@@ -314,7 +316,8 @@ enum {
  * @frag: one (non-head) frag for ``XDP_TX``
  * @xdpf: &xdp_frame for the head frag for .ndo_xdp_xmit()
  * @dma: DMA address of the non-head frag for .ndo_xdp_xmit()
- * @len: frag length for .ndo_xdp_xmit()
+ * @xsk: ``XDP_TX`` for XSk, XDP buffer for any frag
+ * @len: frag length for XSk ``XDP_TX`` and .ndo_xdp_xmit()
  * @flags: Tx flags for the above
  * @opts: combined @len + @flags for the above for speed
  */
@@ -330,11 +333,13 @@ struct libeth_xdp_tx_frame {
 		/* ``XDP_TX`` frag */
 		skb_frag_t			frag;
 
-		/* .ndo_xdp_xmit() */
+		/* .ndo_xdp_xmit(), XSk ``XDP_TX`` */
 		struct {
 			union {
 				struct xdp_frame		*xdpf;
 				dma_addr_t			dma;
+
+				struct libeth_xdp_buff		*xsk;
 			};
 			union {
 				struct {
@@ -375,6 +380,7 @@ struct libeth_xdp_tx_bulk {
 
 /**
  * struct libeth_xdpsq - abstraction for an XDPSQ
+ * @pool: XSk buffer pool for XSk ``XDP_TX``
  * @sqes: array of Tx buffers from the actual queue struct
  * @descs: opaque pointer to the HW descriptor array
  * @ntu: pointer to the next free descriptor index
@@ -388,6 +394,7 @@ struct libeth_xdp_tx_bulk {
  * functions can access and modify driver-specific resources.
  */
 struct libeth_xdpsq {
+	struct xsk_buff_pool		*pool;
 	struct libeth_sqe		*sqes;
 	void				*descs;
 
@@ -690,7 +697,7 @@ void libeth_xdp_tx_exception(struct libeth_xdp_tx_bulk *bq, u32 sent,
 /**
  * __libeth_xdp_tx_flush_bulk - internal helper to flush one XDP Tx bulk
  * @bq: bulk to flush
- * @flags: XDP TX flags (.ndo_xdp_xmit() etc.)
+ * @flags: XDP TX flags (.ndo_xdp_xmit(), XSk etc.)
  * @prep: driver-specific callback to prepare the queue for sending
  * @fill: libeth_xdp callback to fill &libeth_sqe and &libeth_xdp_tx_desc
  * @xmit: driver callback to fill a HW descriptor
@@ -1673,12 +1680,14 @@ static inline int libeth_xdpmo_rx_hash(u32 *hash,
 
 void libeth_xdp_return_buff_bulk(const struct skb_shared_info *sinfo,
 				 struct xdp_frame_bulk *bq, bool frags);
+void libeth_xsk_buff_free_slow(struct libeth_xdp_buff *xdp);
 
 /**
  * __libeth_xdp_complete_tx - complete sent XDPSQE
  * @sqe: SQ element / Tx buffer to complete
  * @cp: Tx polling/completion params
  * @bulk: internal callback to bulk-free ``XDP_TX`` buffers
+ * @xsk: internal callback to free XSk ``XDP_TX`` buffers
  *
  * Use the non-underscored version in drivers instead. This one is shared
  * internally with libeth_tx_complete_any().
@@ -1687,7 +1696,8 @@ void libeth_xdp_return_buff_bulk(const struct skb_shared_info *sinfo,
  */
 static __always_inline void
 __libeth_xdp_complete_tx(struct libeth_sqe *sqe, struct libeth_cq_pp *cp,
-			 typeof(libeth_xdp_return_buff_bulk) bulk)
+			 typeof(libeth_xdp_return_buff_bulk) bulk,
+			 typeof(libeth_xsk_buff_free_slow) xsk)
 {
 	enum libeth_sqe_type type = sqe->type;
 
@@ -1710,6 +1720,10 @@ __libeth_xdp_complete_tx(struct libeth_sqe *sqe, struct libeth_cq_pp *cp,
 	case LIBETH_SQE_XDP_XMIT:
 		xdp_return_frame_bulk(sqe->xdpf, cp->bq);
 		break;
+	case LIBETH_SQE_XSK_TX:
+	case LIBETH_SQE_XSK_TX_FRAG:
+		xsk(sqe->xsk);
+		break;
 	default:
 		break;
 	}
@@ -1717,6 +1731,7 @@ __libeth_xdp_complete_tx(struct libeth_sqe *sqe, struct libeth_cq_pp *cp,
 	switch (type) {
 	case LIBETH_SQE_XDP_TX:
 	case LIBETH_SQE_XDP_XMIT:
+	case LIBETH_SQE_XSK_TX:
 		cp->xdp_tx -= sqe->nr_frags;
 
 		cp->xss->packets++;
@@ -1732,7 +1747,8 @@ __libeth_xdp_complete_tx(struct libeth_sqe *sqe, struct libeth_cq_pp *cp,
 static inline void libeth_xdp_complete_tx(struct libeth_sqe *sqe,
 					  struct libeth_cq_pp *cp)
 {
-	__libeth_xdp_complete_tx(sqe, cp, libeth_xdp_return_buff_bulk);
+	__libeth_xdp_complete_tx(sqe, cp, libeth_xdp_return_buff_bulk,
+				 libeth_xsk_buff_free_slow);
 }
 
 /* Misc */
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
new file mode 100644
index 000000000000..af69b46fa7e4
--- /dev/null
+++ b/include/net/libeth/xsk.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef __LIBETH_XSK_H
+#define __LIBETH_XSK_H
+
+#include <net/libeth/xdp.h>
+#include <net/xdp_sock_drv.h>
+
+/* ``XDP_TX`` bulking */
+
+/**
+ * libeth_xsk_tx_queue_head - internal helper for queueing XSk ``XDP_TX`` head
+ * @bq: XDP Tx bulk to queue the head frag to
+ * @xdp: XSk buffer with the head to queue
+ *
+ * Return: false if it's the only frag of the frame, true if it's an S/G frame.
+ */
+static inline bool libeth_xsk_tx_queue_head(struct libeth_xdp_tx_bulk *bq,
+					    struct libeth_xdp_buff *xdp)
+{
+	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
+		.xsk	= xdp,
+		.len	= xdp->base.data_end - xdp->data,
+		.flags	= LIBETH_XDP_TX_FIRST,
+	};
+
+	if (likely(!xdp_buff_has_frags(&xdp->base)))
+		return false;
+
+	bq->bulk[bq->count - 1].flags |= LIBETH_XDP_TX_MULTI;
+
+	return true;
+}
+
+/**
+ * libeth_xsk_tx_queue_frag - internal helper for queueing XSk ``XDP_TX`` frag
+ * @bq: XDP Tx bulk to queue the frag to
+ * @frag: XSk frag to queue
+ */
+static inline void libeth_xsk_tx_queue_frag(struct libeth_xdp_tx_bulk *bq,
+					    struct libeth_xdp_buff *frag)
+{
+	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
+		.xsk	= frag,
+		.len	= frag->base.data_end - frag->data,
+	};
+}
+
+/**
+ * libeth_xsk_tx_queue_bulk - internal helper for queueing XSk ``XDP_TX`` frame
+ * @bq: XDP Tx bulk to queue the frame to
+ * @xdp: XSk buffer to queue
+ * @flush_bulk: driver callback to flush the bulk to the HW queue
+ *
+ * Return: true on success, false on flush error.
+ */
+static __always_inline bool
+libeth_xsk_tx_queue_bulk(struct libeth_xdp_tx_bulk *bq,
+			 struct libeth_xdp_buff *xdp,
+			 bool (*flush_bulk)(struct libeth_xdp_tx_bulk *bq,
+					    u32 flags))
+{
+	bool ret = true;
+
+	if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
+	    unlikely(!flush_bulk(bq, LIBETH_XDP_TX_XSK))) {
+		libeth_xsk_buff_free_slow(xdp);
+		return false;
+	}
+
+	if (!libeth_xsk_tx_queue_head(bq, xdp))
+		goto out;
+
+	for (const struct libeth_xdp_buff *head = xdp; ; ) {
+		xdp = container_of(xsk_buff_get_frag(&head->base),
+				   typeof(*xdp), base);
+		if (!xdp)
+			break;
+
+		if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
+		    unlikely(!flush_bulk(bq, LIBETH_XDP_TX_XSK))) {
+			ret = false;
+			break;
+		}
+
+		libeth_xsk_tx_queue_frag(bq, xdp);
+	}
+
+out:
+	bq->bulk[bq->count - 1].flags |= LIBETH_XDP_TX_LAST;
+
+	return ret;
+}
+
+/**
+ * libeth_xsk_tx_fill_buf - internal helper to fill XSk ``XDP_TX`` &libeth_sqe
+ * @frm: XDP Tx frame from the bulk
+ * @i: index on the HW queue
+ * @sq: XDPSQ abstraction for the queue
+ * @priv: private data
+ *
+ * Return: XDP Tx descriptor with the synced DMA and other info to pass to
+ * the driver callback.
+ */
+static inline struct libeth_xdp_tx_desc
+libeth_xsk_tx_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
+		       const struct libeth_xdpsq *sq, u64 priv)
+{
+	struct libeth_xdp_buff *xdp = frm.xsk;
+	struct libeth_xdp_tx_desc desc = {
+		.addr	= xsk_buff_xdp_get_dma(&xdp->base),
+		.opts	= frm.opts,
+	};
+	struct libeth_sqe *sqe;
+
+	xsk_buff_raw_dma_sync_for_device(sq->pool, desc.addr, desc.len);
+
+	sqe = &sq->sqes[i];
+	sqe->xsk = xdp;
+
+	if (!(desc.flags & LIBETH_XDP_TX_FIRST)) {
+		sqe->type = LIBETH_SQE_XSK_TX_FRAG;
+		return desc;
+	}
+
+	sqe->type = LIBETH_SQE_XSK_TX;
+	libeth_xdp_tx_fill_stats(sqe, &desc,
+				 xdp_get_shared_info_from_buff(&xdp->base));
+
+	return desc;
+}
+
+/**
+ * libeth_xsk_tx_flush_bulk - wrapper to define flush of XSk ``XDP_TX`` bulk
+ * @bq: bulk to flush
+ * @flags: Tx flags, see __libeth_xdp_tx_flush_bulk()
+ * @prep: driver callback to prepare the queue
+ * @xmit: driver callback to fill a HW descriptor
+ *
+ * Use via LIBETH_XSK_DEFINE_FLUSH_TX() to define an XSk ``XDP_TX`` driver
+ * callback.
+ */
+#define libeth_xsk_tx_flush_bulk(bq, flags, prep, xmit)			     \
+	__libeth_xdp_tx_flush_bulk(bq, (flags) | LIBETH_XDP_TX_XSK, prep,    \
+				   libeth_xsk_tx_fill_buf, xmit)
+
+#endif /* __LIBETH_XSK_H */
diff --git a/drivers/net/ethernet/intel/libeth/tx.c b/drivers/net/ethernet/intel/libeth/tx.c
index 227c841ab16a..e0167f43d2a8 100644
--- a/drivers/net/ethernet/intel/libeth/tx.c
+++ b/drivers/net/ethernet/intel/libeth/tx.c
@@ -10,6 +10,7 @@
 /* Tx buffer completion */
 
 DEFINE_STATIC_CALL_NULL(bulk, libeth_xdp_return_buff_bulk);
+DEFINE_STATIC_CALL_NULL(xsk, libeth_xsk_buff_free_slow);
 
 /**
  * libeth_tx_complete_any - perform Tx completion for one SQE of any type
@@ -23,7 +24,8 @@ DEFINE_STATIC_CALL_NULL(bulk, libeth_xdp_return_buff_bulk);
 void libeth_tx_complete_any(struct libeth_sqe *sqe, struct libeth_cq_pp *cp)
 {
 	if (sqe->type >= __LIBETH_SQE_XDP_START)
-		__libeth_xdp_complete_tx(sqe, cp, static_call(bulk));
+		__libeth_xdp_complete_tx(sqe, cp, static_call(bulk),
+					 static_call(xsk));
 	else
 		libeth_tx_complete(sqe, cp);
 }
@@ -34,5 +36,6 @@ EXPORT_SYMBOL_GPL(libeth_tx_complete_any);
 void libeth_attach_xdp(const struct libeth_xdp_ops *ops)
 {
 	static_call_update(bulk, ops ? ops->bulk : NULL);
+	static_call_update(xsk, ops ? ops->xsk : NULL);
 }
 EXPORT_SYMBOL_GPL(libeth_attach_xdp);
diff --git a/drivers/net/ethernet/intel/libeth/xdp.c b/drivers/net/ethernet/intel/libeth/xdp.c
index 975c34af2f0f..0aed2db00b28 100644
--- a/drivers/net/ethernet/intel/libeth/xdp.c
+++ b/drivers/net/ethernet/intel/libeth/xdp.c
@@ -112,7 +112,7 @@ static void __cold libeth_trace_xdp_exception(const struct net_device *dev,
  * libeth_xdp_tx_exception - handle Tx exceptions of XDP frames
  * @bq: XDP Tx frame bulk
  * @sent: number of frames sent successfully (from this bulk)
- * @flags: internal libeth_xdp flags (.ndo_xdp_xmit etc.)
+ * @flags: internal libeth_xdp flags (XSk, .ndo_xdp_xmit etc.)
  *
  * Cold helper used by __libeth_xdp_tx_flush_bulk(), do not call directly.
  * Reports XDP Tx exceptions, frees the frames that won't be sent or adjust
@@ -134,7 +134,9 @@ void __cold libeth_xdp_tx_exception(struct libeth_xdp_tx_bulk *bq, u32 sent,
 		return;
 	}
 
-	if (!(flags & LIBETH_XDP_TX_NDO))
+	if (flags & LIBETH_XDP_TX_XSK)
+		libeth_xsk_tx_return_bulk(pos, left);
+	else if (!(flags & LIBETH_XDP_TX_NDO))
 		libeth_xdp_tx_return_bulk(pos, left);
 	else
 		libeth_xdp_xmit_return_bulk(pos, left, bq->dev);
@@ -411,6 +413,7 @@ EXPORT_SYMBOL_GPL(libeth_xdp_set_redirect);
 
 static const struct libeth_xdp_ops xdp_ops __initconst = {
 	.bulk	= libeth_xdp_return_buff_bulk,
+	.xsk	= libeth_xsk_buff_free_slow,
 };
 
 static int __init libeth_xdp_module_init(void)
diff --git a/drivers/net/ethernet/intel/libeth/xsk.c b/drivers/net/ethernet/intel/libeth/xsk.c
new file mode 100644
index 000000000000..7cc47d515d45
--- /dev/null
+++ b/drivers/net/ethernet/intel/libeth/xsk.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#define DEFAULT_SYMBOL_NAMESPACE	"LIBETH_XDP"
+
+#include <net/libeth/xsk.h>
+
+#include "priv.h"
+
+/* ``XDP_TX`` bulking */
+
+void __cold libeth_xsk_tx_return_bulk(const struct libeth_xdp_tx_frame *bq,
+				      u32 count)
+{
+	for (u32 i = 0; i < count; i++)
+		libeth_xsk_buff_free_slow(bq[i].xsk);
+}
+
+/* Rx polling path */
+
+/**
+ * libeth_xsk_buff_free_slow - free an XSk Rx buffer
+ * @xdp: buffer to free
+ *
+ * Slowpath version of xsk_buff_free() to be used on exceptions, cleanups etc.
+ * to avoid unwanted inlining.
+ */
+void libeth_xsk_buff_free_slow(struct libeth_xdp_buff *xdp)
+{
+	xsk_buff_free(&xdp->base);
+}
+EXPORT_SYMBOL_GPL(libeth_xsk_buff_free_slow);
-- 
2.49.0


