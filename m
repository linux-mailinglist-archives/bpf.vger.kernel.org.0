Return-Path: <bpf+bounces-60764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECD8ADBB0A
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 22:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B143B9AC0
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 20:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC722957DE;
	Mon, 16 Jun 2025 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfAYq1if"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F8293C60;
	Mon, 16 Jun 2025 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105044; cv=none; b=Rhp6q8OaCIux0a4Gc1gklF1od8Dfe2iQkxJDXGve3w/Br2UQNQzFUt+IxCydw2WjCQ5nmr9n8ta8+3/iVJSoeDKPtZql2knRZnHwrRNay6mUcXfz9H7SRzO5+LBFJ1RYd1hbtujUCt/eobeW1iNERHbrR3BF0IVItvYGOzJ17ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105044; c=relaxed/simple;
	bh=E4jRQ62efQ6xWEdSq8JxsscLxbIe3+mzejWPPoPbQn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKQ/agL2ckWXfPDB7afh8I3rABTESKE0FTH8qPX56q7XSqBzGYyo1ylaCwHWPqYc2rVJqayHggFx2AcUwogXXr7Zcc4no2fRHCbDP9hNkoHd6ofsDAI6LlwTPvN3kFoA2hpwfgUW1iPIRyYclo99FZ3ApLkIc6PhOVk85rYDOPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfAYq1if; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750105041; x=1781641041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E4jRQ62efQ6xWEdSq8JxsscLxbIe3+mzejWPPoPbQn0=;
  b=mfAYq1ifJWkMujq+jtWLpD0tyey3yzapWLwoBAd5+FtnyOLNpQ02hxuA
   w6kNVFLJXVXH9EXOmd4th2qGOmrGMbQmYCXdRhZzY7lHzI7QAgFgKNgSP
   dKbbTamIJ1eZixsJB4IODKhllScwysFkoEEiqlW2i3j52yv7QoWOk9eiP
   7Nwd4UVq+6gBZumJY9XqA8P3lvtl9KQ+fWWuYFrrSrdR0RZlJsRii+lq+
   AWRDVKpItbaInyA9km70PXfW2QCq2p4F7zq8gH+4cvWT03YgfRoo6/GSY
   WmduNZV03xW/DgoAtD2fEQX7W4FA+byOJHFR0MFe5Y6XDZkeq8MOvCIlf
   g==;
X-CSE-ConnectionGUID: 5fh5ZEDbTvyD7tilf6uiqA==
X-CSE-MsgGUID: HNkowkHoThmKyjoAGHi3mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62533555"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="62533555"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 13:17:12 -0700
X-CSE-ConnectionGUID: +nGQ1d+lQ962fbHtENbkBg==
X-CSE-MsgGUID: Zrz2JGS7QtO6PNVCgin8vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="153531011"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 16 Jun 2025 13:17:13 -0700
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
Subject: [PATCH net-next v2 14/17] libeth: xsk: add XSk xmit functions
Date: Mon, 16 Jun 2025 13:16:35 -0700
Message-ID: <20250616201639.710420-15-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250616201639.710420-1-anthony.l.nguyen@intel.com>
References: <20250616201639.710420-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Reuse core sending functions to send XSk xmit frames.
Both metadata and no metadata pools/driver are supported. libeth_xdp
also provides generic XSk metadata ops, currently with the checksum
offload only and for cases when HW doesn't require supplying L3/L4
checksum offsets. Drivers are free to pass their own ops.
&libeth_xdp_tx_bulk is not used here as it would be redundant;
pool->tx_descs are accessed directly.
Fake "libeth_xsktmo" is needed to hide implementation details from the
drivers when they want to use the generic ops: the original struct is
defined in the same file where dev->xsk_tx_metadata_ops gets set to
avoid duplication of slowpath; at the same time; XSk xmit functions
use local "fast" copy to inline XMO callbacks.
Tx descriptor filling loop is unrolled by 8.

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # optimizations
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libeth/priv.h |   2 +
 drivers/net/ethernet/intel/libeth/xdp.c  |  14 +-
 drivers/net/ethernet/intel/libeth/xsk.c  |   6 +
 include/net/libeth/tx.h                  |   4 +-
 include/net/libeth/xdp.h                 |  73 ++++++++--
 include/net/libeth/xsk.h                 | 166 +++++++++++++++++++++++
 6 files changed, 248 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/libeth/priv.h b/drivers/net/ethernet/intel/libeth/priv.h
index ebcb26f24401..03e74382b2cb 100644
--- a/drivers/net/ethernet/intel/libeth/priv.h
+++ b/drivers/net/ethernet/intel/libeth/priv.h
@@ -13,6 +13,8 @@ struct libeth_xdp_tx_frame;
 struct skb_shared_info;
 struct xdp_frame_bulk;
 
+extern const struct xsk_tx_metadata_ops libeth_xsktmo_slow;
+
 void libeth_xsk_tx_return_bulk(const struct libeth_xdp_tx_frame *bq,
 			       u32 count);
 
diff --git a/drivers/net/ethernet/intel/libeth/xdp.c b/drivers/net/ethernet/intel/libeth/xdp.c
index bd334d314a1d..b5fb2ce92da8 100644
--- a/drivers/net/ethernet/intel/libeth/xdp.c
+++ b/drivers/net/ethernet/intel/libeth/xdp.c
@@ -376,21 +376,31 @@ EXPORT_SYMBOL_GPL(libeth_xdp_queue_threshold);
  * __libeth_xdp_set_features - set XDP features for netdev
  * @dev: &net_device to configure
  * @xmo: XDP metadata ops (Rx hints)
+ * @zc_segs: maximum number of S/G frags the HW can transmit
+ * @tmo: XSk Tx metadata ops (Tx hints)
  *
  * Set all the features libeth_xdp supports. Only the first argument is
- * necessary.
+ * necessary; without the third one (zero), XSk support won't be advertised.
  * Use the non-underscored versions in drivers instead.
  */
 void __libeth_xdp_set_features(struct net_device *dev,
-			       const struct xdp_metadata_ops *xmo)
+			       const struct xdp_metadata_ops *xmo,
+			       u32 zc_segs,
+			       const struct xsk_tx_metadata_ops *tmo)
 {
 	xdp_set_features_flag(dev,
 			      NETDEV_XDP_ACT_BASIC |
 			      NETDEV_XDP_ACT_REDIRECT |
 			      NETDEV_XDP_ACT_NDO_XMIT |
+			      (zc_segs ? NETDEV_XDP_ACT_XSK_ZEROCOPY : 0) |
 			      NETDEV_XDP_ACT_RX_SG |
 			      NETDEV_XDP_ACT_NDO_XMIT_SG);
 	dev->xdp_metadata_ops = xmo;
+
+	tmo = tmo == libeth_xsktmo ? &libeth_xsktmo_slow : tmo;
+
+	dev->xdp_zc_max_segs = zc_segs ? : 1;
+	dev->xsk_tx_metadata_ops = zc_segs ? tmo : NULL;
 }
 EXPORT_SYMBOL_GPL(__libeth_xdp_set_features);
 
diff --git a/drivers/net/ethernet/intel/libeth/xsk.c b/drivers/net/ethernet/intel/libeth/xsk.c
index fba6d7a025b0..f09e1940183b 100644
--- a/drivers/net/ethernet/intel/libeth/xsk.c
+++ b/drivers/net/ethernet/intel/libeth/xsk.c
@@ -18,6 +18,12 @@ void __cold libeth_xsk_tx_return_bulk(const struct libeth_xdp_tx_frame *bq,
 		libeth_xsk_buff_free_slow(bq[i].xsk);
 }
 
+/* XSk TMO */
+
+const struct xsk_tx_metadata_ops libeth_xsktmo_slow = {
+	.tmo_request_checksum		= libeth_xsktmo_req_csum,
+};
+
 /* Rx polling path */
 
 /**
diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
index 44192bec86d7..c3db5c6f1641 100644
--- a/include/net/libeth/tx.h
+++ b/include/net/libeth/tx.h
@@ -12,7 +12,7 @@
 
 /**
  * enum libeth_sqe_type - type of &libeth_sqe to act on Tx completion
- * @LIBETH_SQE_EMPTY: unused/empty OR XDP_TX frag, no action required
+ * @LIBETH_SQE_EMPTY: unused/empty OR XDP_TX/XSk frame, no action required
  * @LIBETH_SQE_CTX: context descriptor with empty SQE, no action required
  * @LIBETH_SQE_SLAB: kmalloc-allocated buffer, unmap and kfree()
  * @LIBETH_SQE_FRAG: mapped skb frag, only unmap DMA
@@ -93,7 +93,7 @@ struct libeth_sqe {
  * @bq: XDP frame bulk to combine return operations
  * @ss: onstack NAPI stats to fill
  * @xss: onstack XDPSQ NAPI stats to fill
- * @xdp_tx: number of XDP frames processed
+ * @xdp_tx: number of XDP-not-XSk frames processed
  * @napi: whether it's called from the NAPI context
  *
  * libeth uses this structure to access objects needed for performing full
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index ab907f36a35b..c3655458047d 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -293,6 +293,8 @@ enum {
 /**
  * enum - &libeth_xdp_tx_frame and &libeth_xdp_tx_desc flags
  * @LIBETH_XDP_TX_LEN: only for ``XDP_TX``, [15:0] of ::len_fl is actual length
+ * @LIBETH_XDP_TX_CSUM: for XSk xmit, enable checksum offload
+ * @LIBETH_XDP_TX_XSKMD: for XSk xmit, mask of the metadata bits
  * @LIBETH_XDP_TX_FIRST: indicates the frag is the first one of the frame
  * @LIBETH_XDP_TX_LAST: whether the frag is the last one of the frame
  * @LIBETH_XDP_TX_MULTI: whether the frame contains several frags
@@ -301,6 +303,9 @@ enum {
 enum {
 	LIBETH_XDP_TX_LEN		= GENMASK(15, 0),
 
+	LIBETH_XDP_TX_CSUM		= XDP_TXMD_FLAGS_CHECKSUM,
+	LIBETH_XDP_TX_XSKMD		= LIBETH_XDP_TX_LEN,
+
 	LIBETH_XDP_TX_FIRST		= BIT(16),
 	LIBETH_XDP_TX_LAST		= BIT(17),
 	LIBETH_XDP_TX_MULTI		= BIT(18),
@@ -320,6 +325,7 @@ enum {
  * @len: frag length for XSk ``XDP_TX`` and .ndo_xdp_xmit()
  * @flags: Tx flags for the above
  * @opts: combined @len + @flags for the above for speed
+ * @desc: XSk xmit descriptor for direct casting
  */
 struct libeth_xdp_tx_frame {
 	union {
@@ -349,10 +355,14 @@ struct libeth_xdp_tx_frame {
 				aligned_u64			opts;
 			};
 		};
+
+		/* XSk xmit */
+		struct xdp_desc			desc;
 	};
-} __aligned_largest;
+} __aligned(sizeof(struct xdp_desc));
 static_assert(offsetof(struct libeth_xdp_tx_frame, frag.len) ==
 	      offsetof(struct libeth_xdp_tx_frame, len_fl));
+static_assert(sizeof(struct libeth_xdp_tx_frame) == sizeof(struct xdp_desc));
 
 /**
  * struct libeth_xdp_tx_bulk - XDP Tx frame bulk for bulk sending
@@ -363,10 +373,13 @@ static_assert(offsetof(struct libeth_xdp_tx_frame, frag.len) ==
  * @count: current number of frames in @bulk
  * @bulk: array of queued frames for bulk Tx
  *
- * All XDP Tx operations queue each frame to the bulk first and flush it
- * when @count reaches the array end. Bulk is always placed on the stack
- * for performance. One bulk element contains all the data necessary
+ * All XDP Tx operations except XSk xmit queue each frame to the bulk first
+ * and flush it when @count reaches the array end. Bulk is always placed on
+ * the stack for performance. One bulk element contains all the data necessary
  * for sending a frame and then freeing it on completion.
+ * For XSk xmit, Tx descriptor array from &xsk_buff_pool is casted directly
+ * to &libeth_xdp_tx_frame as they are compatible and the bulk structure is
+ * not used.
  */
 struct libeth_xdp_tx_bulk {
 	const struct bpf_prog		*prog;
@@ -391,13 +404,13 @@ struct libeth_xdp_tx_bulk {
 
 /**
  * struct libeth_xdpsq - abstraction for an XDPSQ
- * @pool: XSk buffer pool for XSk ``XDP_TX``
+ * @pool: XSk buffer pool for XSk ``XDP_TX`` and xmit
  * @sqes: array of Tx buffers from the actual queue struct
  * @descs: opaque pointer to the HW descriptor array
  * @ntu: pointer to the next free descriptor index
  * @count: number of descriptors on that queue
  * @pending: pointer to the number of sent-not-completed descs on that queue
- * @xdp_tx: pointer to the above
+ * @xdp_tx: pointer to the above, but only for non-XSk-xmit frames
  * @lock: corresponding XDPSQ lock
  *
  * Abstraction for driver-independent implementation of Tx. Placed on the stack
@@ -438,6 +451,30 @@ struct libeth_xdp_tx_desc {
 	};
 } __aligned_largest;
 
+/**
+ * libeth_xdp_ptr_to_priv - convert pointer to a libeth_xdp u64 priv
+ * @ptr: pointer to convert
+ *
+ * The main sending function passes private data as the largest scalar, u64.
+ * Use this helper when you want to pass a pointer there.
+ */
+#define libeth_xdp_ptr_to_priv(ptr) ({					      \
+	typecheck_pointer(ptr);						      \
+	((u64)(uintptr_t)(ptr));					      \
+})
+/**
+ * libeth_xdp_priv_to_ptr - convert libeth_xdp u64 priv to a pointer
+ * @priv: private data to convert
+ *
+ * The main sending function passes private data as the largest scalar, u64.
+ * Use this helper when your callback takes this u64 and you want to convert
+ * it back to a pointer.
+ */
+#define libeth_xdp_priv_to_ptr(priv) ({					      \
+	static_assert(__same_type(priv, u64));				      \
+	((const void *)(uintptr_t)(priv));				      \
+})
+
 /**
  * libeth_xdp_tx_xmit_bulk - main XDP Tx function
  * @bulk: array of frames to send
@@ -450,10 +487,11 @@ struct libeth_xdp_tx_desc {
  * @xmit: callback for filling a HW descriptor with the frame info
  *
  * Internal abstraction for placing @n XDP Tx frames on the HW XDPSQ. Used for
- * all types of frames.
+ * all types of frames: ``XDP_TX``, .ndo_xdp_xmit(), XSk ``XDP_TX``, and XSk
+ * xmit.
  * @prep must lock the queue as this function releases it at the end. @unroll
- * greatly increases the object code size, but also greatly increases
- * performance.
+ * greatly increases the object code size, but also greatly increases XSk xmit
+ * performance; for other types of frames, it's not enabled.
  * The compilers inline all those onstack abstractions to direct data accesses.
  *
  * Return: number of frames actually placed on the queue, <= @n. The function
@@ -709,7 +747,8 @@ void libeth_xdp_tx_exception(struct libeth_xdp_tx_bulk *bq, u32 sent,
  * @fill: libeth_xdp callback to fill &libeth_sqe and &libeth_xdp_tx_desc
  * @xmit: driver callback to fill a HW descriptor
  *
- * Internal abstraction to create bulk flush functions for drivers.
+ * Internal abstraction to create bulk flush functions for drivers. Used for
+ * everything except XSk xmit.
  *
  * Return: true if anything was sent, false otherwise.
  */
@@ -1763,7 +1802,9 @@ static inline void libeth_xdp_complete_tx(struct libeth_sqe *sqe,
 u32 libeth_xdp_queue_threshold(u32 count);
 
 void __libeth_xdp_set_features(struct net_device *dev,
-			       const struct xdp_metadata_ops *xmo);
+			       const struct xdp_metadata_ops *xmo,
+			       u32 zc_segs,
+			       const struct xsk_tx_metadata_ops *tmo);
 void libeth_xdp_set_redirect(struct net_device *dev, bool enable);
 
 /**
@@ -1780,9 +1821,13 @@ void libeth_xdp_set_redirect(struct net_device *dev, bool enable);
 		    COUNT_ARGS(__VA_ARGS__))(dev, ##__VA_ARGS__)
 
 #define __libeth_xdp_feat0(dev)						      \
-	__libeth_xdp_set_features(dev, NULL)
+	__libeth_xdp_set_features(dev, NULL, 0, NULL)
 #define __libeth_xdp_feat1(dev, xmo)					      \
-	__libeth_xdp_set_features(dev, xmo)
+	__libeth_xdp_set_features(dev, xmo, 0, NULL)
+#define __libeth_xdp_feat2(dev, xmo, zc_segs)				      \
+	__libeth_xdp_set_features(dev, xmo, zc_segs, NULL)
+#define __libeth_xdp_feat3(dev, xmo, zc_segs, tmo)			      \
+	__libeth_xdp_set_features(dev, xmo, zc_segs, tmo)
 
 /**
  * libeth_xdp_set_features_noredir - enable all libeth_xdp features w/o redir
@@ -1803,4 +1848,6 @@ void libeth_xdp_set_redirect(struct net_device *dev, bool enable);
 	libeth_xdp_set_redirect(ud, false);				      \
 } while (0)
 
+#define libeth_xsktmo			((const void *)GOLDEN_RATIO_PRIME)
+
 #endif /* __LIBETH_XDP_H */
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index af69b46fa7e4..16ca195981fe 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -7,6 +7,11 @@
 #include <net/libeth/xdp.h>
 #include <net/xdp_sock_drv.h>
 
+/* ``XDP_TXMD_FLAGS_VALID`` is defined only under ``CONFIG_XDP_SOCKETS`` */
+#ifdef XDP_TXMD_FLAGS_VALID
+static_assert(XDP_TXMD_FLAGS_VALID <= LIBETH_XDP_TX_XSKMD);
+#endif
+
 /* ``XDP_TX`` bulking */
 
 /**
@@ -145,4 +150,165 @@ libeth_xsk_tx_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
 	__libeth_xdp_tx_flush_bulk(bq, (flags) | LIBETH_XDP_TX_XSK, prep,    \
 				   libeth_xsk_tx_fill_buf, xmit)
 
+/* XSk TMO */
+
+/**
+ * libeth_xsktmo_req_csum - XSk Tx metadata op to request checksum offload
+ * @csum_start: unused
+ * @csum_offset: unused
+ * @priv: &libeth_xdp_tx_desc from the filling helper
+ *
+ * Generic implementation of ::tmo_request_checksum. Works only when HW doesn't
+ * require filling checksum offsets and other parameters beside the checksum
+ * request bit.
+ * Consider using within @libeth_xsktmo unless the driver requires HW-specific
+ * callbacks.
+ */
+static inline void libeth_xsktmo_req_csum(u16 csum_start, u16 csum_offset,
+					  void *priv)
+{
+	((struct libeth_xdp_tx_desc *)priv)->flags |= LIBETH_XDP_TX_CSUM;
+}
+
+/* Only to inline the callbacks below, use @libeth_xsktmo in drivers instead */
+static const struct xsk_tx_metadata_ops __libeth_xsktmo = {
+	.tmo_request_checksum	= libeth_xsktmo_req_csum,
+};
+
+/**
+ * __libeth_xsk_xmit_fill_buf_md - internal helper to prepare XSk xmit w/meta
+ * @xdesc: &xdp_desc from the XSk buffer pool
+ * @sq: XDPSQ abstraction for the queue
+ * @priv: XSk Tx metadata ops
+ *
+ * Same as __libeth_xsk_xmit_fill_buf(), but requests metadata pointer and
+ * fills additional fields in &libeth_xdp_tx_desc to ask for metadata offload.
+ *
+ * Return: XDP Tx descriptor with the DMA, metadata request bits, and other
+ * info to pass to the driver callback.
+ */
+static __always_inline struct libeth_xdp_tx_desc
+__libeth_xsk_xmit_fill_buf_md(const struct xdp_desc *xdesc,
+			      const struct libeth_xdpsq *sq,
+			      u64 priv)
+{
+	const struct xsk_tx_metadata_ops *tmo = libeth_xdp_priv_to_ptr(priv);
+	struct libeth_xdp_tx_desc desc;
+	struct xdp_desc_ctx ctx;
+
+	ctx = xsk_buff_raw_get_ctx(sq->pool, xdesc->addr);
+	desc = (typeof(desc)){
+		.addr	= ctx.dma,
+		.len	= xdesc->len,
+	};
+
+	BUILD_BUG_ON(!__builtin_constant_p(tmo == libeth_xsktmo));
+	tmo = tmo == libeth_xsktmo ? &__libeth_xsktmo : tmo;
+
+	xsk_tx_metadata_request(ctx.meta, tmo, &desc);
+
+	return desc;
+}
+
+/* XSk xmit implementation */
+
+/**
+ * __libeth_xsk_xmit_fill_buf - internal helper to prepare XSk xmit w/o meta
+ * @xdesc: &xdp_desc from the XSk buffer pool
+ * @sq: XDPSQ abstraction for the queue
+ *
+ * Return: XDP Tx descriptor with the DMA and other info to pass to
+ * the driver callback.
+ */
+static inline struct libeth_xdp_tx_desc
+__libeth_xsk_xmit_fill_buf(const struct xdp_desc *xdesc,
+			   const struct libeth_xdpsq *sq)
+{
+	return (struct libeth_xdp_tx_desc){
+		.addr	= xsk_buff_raw_get_dma(sq->pool, xdesc->addr),
+		.len	= xdesc->len,
+	};
+}
+
+/**
+ * libeth_xsk_xmit_fill_buf - internal helper to prepare an XSk xmit
+ * @frm: &xdp_desc from the XSk buffer pool
+ * @i: index on the HW queue
+ * @sq: XDPSQ abstraction for the queue
+ * @priv: XSk Tx metadata ops
+ *
+ * Depending on the metadata ops presence (determined at compile time), calls
+ * the quickest helper to build a libeth XDP Tx descriptor.
+ *
+ * Return: XDP Tx descriptor with the synced DMA, metadata request bits,
+ * and other info to pass to the driver callback.
+ */
+static __always_inline struct libeth_xdp_tx_desc
+libeth_xsk_xmit_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
+			 const struct libeth_xdpsq *sq, u64 priv)
+{
+	struct libeth_xdp_tx_desc desc;
+
+	if (priv)
+		desc = __libeth_xsk_xmit_fill_buf_md(&frm.desc, sq, priv);
+	else
+		desc = __libeth_xsk_xmit_fill_buf(&frm.desc, sq);
+
+	desc.flags |= xsk_is_eop_desc(&frm.desc) ? LIBETH_XDP_TX_LAST : 0;
+
+	xsk_buff_raw_dma_sync_for_device(sq->pool, desc.addr, desc.len);
+
+	return desc;
+}
+
+/**
+ * libeth_xsk_xmit_do_bulk - send XSk xmit frames
+ * @pool: XSk buffer pool containing the frames to send
+ * @xdpsq: opaque pointer to driver's XDPSQ struct
+ * @budget: maximum number of frames can be sent
+ * @tmo: optional XSk Tx metadata ops
+ * @prep: driver callback to build a &libeth_xdpsq
+ * @xmit: driver callback to put frames to a HW queue
+ * @finalize: driver callback to start a transmission
+ *
+ * Implements generic XSk xmit. Always turns on XSk Tx wakeup as it's assumed
+ * lazy cleaning is used and interrupts are disabled for the queue.
+ * HW descriptor filling is unrolled by ``LIBETH_XDP_TX_BATCH`` to optimize
+ * writes.
+ * Note that unlike other XDP Tx ops, the queue must be locked and cleaned
+ * prior to calling this function to already know available @budget.
+ * @prepare must only build a &libeth_xdpsq and return ``U32_MAX``.
+ *
+ * Return: false if @budget was exhausted, true otherwise.
+ */
+static __always_inline bool
+libeth_xsk_xmit_do_bulk(struct xsk_buff_pool *pool, void *xdpsq, u32 budget,
+			const struct xsk_tx_metadata_ops *tmo,
+			u32 (*prep)(void *xdpsq, struct libeth_xdpsq *sq),
+			void (*xmit)(struct libeth_xdp_tx_desc desc, u32 i,
+				     const struct libeth_xdpsq *sq, u64 priv),
+			void (*finalize)(void *xdpsq, bool sent, bool flush))
+{
+	const struct libeth_xdp_tx_frame *bulk;
+	bool wake;
+	u32 n;
+
+	wake = xsk_uses_need_wakeup(pool);
+	if (wake)
+		xsk_clear_tx_need_wakeup(pool);
+
+	n = xsk_tx_peek_release_desc_batch(pool, budget);
+	bulk = container_of(&pool->tx_descs[0], typeof(*bulk), desc);
+
+	libeth_xdp_tx_xmit_bulk(bulk, xdpsq, n, true,
+				libeth_xdp_ptr_to_priv(tmo), prep,
+				libeth_xsk_xmit_fill_buf, xmit);
+	finalize(xdpsq, n, true);
+
+	if (wake)
+		xsk_set_tx_need_wakeup(pool);
+
+	return n < budget;
+}
+
 #endif /* __LIBETH_XSK_H */
-- 
2.47.1


