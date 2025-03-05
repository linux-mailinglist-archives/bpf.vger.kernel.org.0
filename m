Return-Path: <bpf+bounces-53356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A57A504A2
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BB63B163A
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8D32512E2;
	Wed,  5 Mar 2025 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROVji3r0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52B32505C2;
	Wed,  5 Mar 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191756; cv=none; b=Kd3neAIrBCJj3gThazsKjjHH49uwWS0CMHjICMO1tv5y1QyICMPOmb+CEFgGxVTd0dMzpgV+cdKzH67yFCinC9yJ4s9lo6O3NPeOwI2nBFKzdaGInzDLBPN+37R5CNpBTrHLmFqcSl6p4k7cTDWtLUC/qYAB00nYQpcrLaZshw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191756; c=relaxed/simple;
	bh=jhI+nguHnVtF7U8YIIGHAxPaZiwFZgh3O7F9iBh9uZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Frx/XspKtyvn3ANCOstsD0rKTjy+TNOR8GP89wguxyMMecJGaUVN+HLhhpBgp/4gc4I1P0ACEpuMB3s6MmtltdjE4WKfsWuUlG4rvB3oe0xMV1VWERbPVW3uuhcsJklZa0KCfNLqAnAu+s0wm3Y7mPt86AADQpmQ1juXSilLFh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROVji3r0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741191753; x=1772727753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jhI+nguHnVtF7U8YIIGHAxPaZiwFZgh3O7F9iBh9uZ8=;
  b=ROVji3r0OYNH7MiFrm13kpLLBLM3AD1LXrVNl+EoAuYdavpVVNXosb4u
   NNJqWYt/Ifu3dWV7sqr9Ycoyw25eRMqikL4DVgRFCLmDoDdpJ6CmEdL6G
   hpHjTS9FCzUWk1RL4jbyqcNaKbL1418PnHTecIRoeqP5Q+iyTDi7jrnyn
   EblB3rR0uwgVa+FVn1H8JbyuKknpoRFtksEmEMlg+4viSgFGzMuwacN+j
   rnJUcQG7NGa7mhM81YMENaO3FHb9IoToxSiEyQCwpSt2rYSAb5pcBQ2ed
   i3Z8H8FmaUEo+3uv07iURexgzsI/a/KqE3PzsGqv9H7Zdh305cNzM6sWp
   g==;
X-CSE-ConnectionGUID: IqAFjyBTTP+NEL+EZejrRg==
X-CSE-MsgGUID: Hokx8jlpQn2uDLWmrKjoCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42026431"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42026431"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:22:33 -0800
X-CSE-ConnectionGUID: Nhcf9bwRT2G0Esd/ikbF/g==
X-CSE-MsgGUID: 3+b81CotQWm1bhf81uwumQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123832881"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 05 Mar 2025 08:22:28 -0800
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
Subject: [PATCH net-next 04/16] libeth: add XSk helpers
Date: Wed,  5 Mar 2025 17:21:20 +0100
Message-ID: <20250305162132.1106080-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following counterparts of functions from libeth_xdp which need
special care on XSk path:

* building &xdp_buff (head and frags);
* running XDP prog and managing all possible verdicts;
* xmit (with S/G and metadata support);
* wakeup via CSD/IPI;
* FQ init/deinit and refilling.

Xmit by default unrolls loops by 8 when filling Tx DMA descriptors.
XDP_REDIRECT verdict is considered default/likely(). Rx frags are
considered unlikely().
It is assumed that Tx/completion queues are not mapped to any
interrupts, thus we clean them only when needed (=> 3/4 of
descriptors is busy) and keep need_wakeup set.
IPI for XSk wakeup showed better performance than triggering an SW
NIC interrupt, though it doesn't respect NIC's interrupt affinity.

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # lots of stuff
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/libeth/Kconfig  |   2 +-
 drivers/net/ethernet/intel/libeth/Makefile |   1 +
 drivers/net/ethernet/intel/libeth/priv.h   |  11 +
 include/net/libeth/tx.h                    |  10 +-
 include/net/libeth/xdp.h                   |  90 ++-
 include/net/libeth/xsk.h                   | 685 +++++++++++++++++++++
 drivers/net/ethernet/intel/libeth/tx.c     |   5 +-
 drivers/net/ethernet/intel/libeth/xdp.c    |  26 +-
 drivers/net/ethernet/intel/libeth/xsk.c    | 269 ++++++++
 9 files changed, 1067 insertions(+), 32 deletions(-)
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
index 1bd6e2d7a3e7..9b811d31015c 100644
--- a/drivers/net/ethernet/intel/libeth/priv.h
+++ b/drivers/net/ethernet/intel/libeth/priv.h
@@ -8,12 +8,23 @@
 
 /* XDP */
 
+enum xdp_action;
+struct libeth_xdp_buff;
+struct libeth_xdp_tx_frame;
 struct skb_shared_info;
 struct xdp_frame_bulk;
 
+extern const struct xsk_tx_metadata_ops libeth_xsktmo_slow;
+
+void libeth_xsk_tx_return_bulk(const struct libeth_xdp_tx_frame *bq,
+			       u32 count);
+u32 libeth_xsk_prog_exception(struct libeth_xdp_buff *xdp, enum xdp_action act,
+			      int ret);
+
 struct libeth_xdp_ops {
 	void	(*bulk)(const struct skb_shared_info *sinfo,
 			struct xdp_frame_bulk *bq, bool frags);
+	void	(*xsk)(struct libeth_xdp_buff *xdp);
 };
 
 void libeth_attach_xdp(const struct libeth_xdp_ops *ops);
diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
index c3459917330e..c3db5c6f1641 100644
--- a/include/net/libeth/tx.h
+++ b/include/net/libeth/tx.h
@@ -12,7 +12,7 @@
 
 /**
  * enum libeth_sqe_type - type of &libeth_sqe to act on Tx completion
- * @LIBETH_SQE_EMPTY: unused/empty OR XDP_TX, no action required
+ * @LIBETH_SQE_EMPTY: unused/empty OR XDP_TX/XSk frame, no action required
  * @LIBETH_SQE_CTX: context descriptor with empty SQE, no action required
  * @LIBETH_SQE_SLAB: kmalloc-allocated buffer, unmap and kfree()
  * @LIBETH_SQE_FRAG: mapped skb frag, only unmap DMA
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
@@ -87,7 +93,7 @@ struct libeth_sqe {
  * @bq: XDP frame bulk to combine return operations
  * @ss: onstack NAPI stats to fill
  * @xss: onstack XDPSQ NAPI stats to fill
- * @xdp_tx: number of XDP frames processed
+ * @xdp_tx: number of XDP-not-XSk frames processed
  * @napi: whether it's called from the NAPI context
  *
  * libeth uses this structure to access objects needed for performing full
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index 1039cd5d8a56..bef9dda690f0 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -276,6 +276,7 @@ libeth_xdpsq_run_timer(struct work_struct *work,
  * @LIBETH_XDP_TX_BATCH: batch size for which the queue fill loop is unrolled
  * @LIBETH_XDP_TX_DROP: indicates the send function must drop frames not sent
  * @LIBETH_XDP_TX_NDO: whether the send function is called from .ndo_xdp_xmit()
+ * @LIBETH_XDP_TX_XSK: whether the function is called for ``XDP_TX`` for XSk
  */
 enum {
 	LIBETH_XDP_TX_BULK		= DEV_MAP_BULK_SIZE,
@@ -283,11 +284,14 @@ enum {
 
 	LIBETH_XDP_TX_DROP		= BIT(0),
 	LIBETH_XDP_TX_NDO		= BIT(1),
+	LIBETH_XDP_TX_XSK		= BIT(2),
 };
 
 /**
  * enum - &libeth_xdp_tx_frame and &libeth_xdp_tx_desc flags
  * @LIBETH_XDP_TX_LEN: only for ``XDP_TX``, [15:0] of ::len_fl is actual length
+ * @LIBETH_XDP_TX_CSUM: for XSk xmit, enable checksum offload
+ * @LIBETH_XDP_TX_XSKMD: for XSk xmit, mask of the metadata bits
  * @LIBETH_XDP_TX_FIRST: indicates the frag is the first one of the frame
  * @LIBETH_XDP_TX_LAST: whether the frag is the last one of the frame
  * @LIBETH_XDP_TX_MULTI: whether the frame contains several frags
@@ -296,6 +300,9 @@ enum {
 enum {
 	LIBETH_XDP_TX_LEN		= GENMASK(15, 0),
 
+	LIBETH_XDP_TX_CSUM		= XDP_TXMD_FLAGS_CHECKSUM,
+	LIBETH_XDP_TX_XSKMD		= LIBETH_XDP_TX_LEN,
+
 	LIBETH_XDP_TX_FIRST		= BIT(16),
 	LIBETH_XDP_TX_LAST		= BIT(17),
 	LIBETH_XDP_TX_MULTI		= BIT(18),
@@ -311,9 +318,11 @@ enum {
  * @frag: one (non-head) frag for ``XDP_TX``
  * @xdpf: &xdp_frame for the head frag for .ndo_xdp_xmit()
  * @dma: DMA address of the non-head frag for .ndo_xdp_xmit()
- * @len: frag length for .ndo_xdp_xmit()
+ * @xsk: ``XDP_TX`` for XSk, XDP buffer for any frag
+ * @len: frag length for XSk ``XDP_TX`` and .ndo_xdp_xmit()
  * @flags: Tx flags for the above
  * @opts: combined @len + @flags for the above for speed
+ * @desc: XSk xmit descriptor for direct casting
  */
 struct libeth_xdp_tx_frame {
 	union {
@@ -327,11 +336,13 @@ struct libeth_xdp_tx_frame {
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
@@ -341,10 +352,14 @@ struct libeth_xdp_tx_frame {
 				aligned_u64			opts;
 			};
 		};
+
+		/* XSk xmit */
+		struct xdp_desc			desc;
 	};
 } __aligned(sizeof(struct xdp_desc));
 static_assert(offsetof(struct libeth_xdp_tx_frame, frag.len) ==
 	      offsetof(struct libeth_xdp_tx_frame, len_fl));
+static_assert(sizeof(struct libeth_xdp_tx_frame) == sizeof(struct xdp_desc));
 
 /**
  * struct libeth_xdp_tx_bulk - XDP Tx frame bulk for bulk sending
@@ -355,10 +370,13 @@ static_assert(offsetof(struct libeth_xdp_tx_frame, frag.len) ==
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
@@ -372,12 +390,13 @@ struct libeth_xdp_tx_bulk {
 
 /**
  * struct libeth_xdpsq - abstraction for an XDPSQ
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
@@ -385,6 +404,7 @@ struct libeth_xdp_tx_bulk {
  * functions can access and modify driver-specific resources.
  */
 struct libeth_xdpsq {
+	struct xsk_buff_pool		*pool;
 	struct libeth_sqe		*sqes;
 	void				*descs;
 
@@ -468,10 +488,11 @@ struct libeth_xdp_tx_desc {
  * @xmit: callback for filling a HW descriptor with the frame info
  *
  * Internal abstraction for placing @n XDP Tx frames on the HW XDPSQ. Used for
- * all types of frames: ``XDP_TX`` and .ndo_xdp_xmit().
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
@@ -726,12 +747,13 @@ void libeth_xdp_tx_exception(struct libeth_xdp_tx_bulk *bq, u32 sent,
 /**
  * __libeth_xdp_tx_flush_bulk - internal helper to flush one XDP Tx bulk
  * @bq: bulk to flush
- * @flags: XDP TX flags (.ndo_xdp_xmit(), etc.)
+ * @flags: XDP TX flags (.ndo_xdp_xmit(), XSk etc.)
  * @prep: driver-specific callback to prepare the queue for sending
  * @fill: libeth_xdp callback to fill &libeth_sqe and &libeth_xdp_tx_desc
  * @xmit: driver callback to fill a HW descriptor
  *
- * Internal abstraction to create bulk flush functions for drivers.
+ * Internal abstraction to create bulk flush functions for drivers. Used for
+ * everything except XSk xmit.
  *
  * Return: true if anything was sent, false otherwise.
  */
@@ -1104,18 +1126,19 @@ __libeth_xdp_xmit_do_bulk(struct libeth_xdp_tx_bulk *bq,
  * Should be called on an onstack XDP Tx bulk before the NAPI polling loop.
  * Initializes all the needed fields to run libeth_xdp functions. If @num == 0,
  * assumes XDP is not enabled.
+ * Do not use for XSk, it has its own optimized helper.
  */
 #define libeth_xdp_tx_init_bulk(bq, prog, dev, xdpsqs, num)		      \
-	__libeth_xdp_tx_init_bulk(bq, prog, dev, xdpsqs, num,		      \
+	__libeth_xdp_tx_init_bulk(bq, prog, dev, xdpsqs, num, false,	      \
 				  __UNIQUE_ID(bq_), __UNIQUE_ID(nqs_))
 
-#define __libeth_xdp_tx_init_bulk(bq, pr, d, xdpsqs, num, ub, un) do {	      \
+#define __libeth_xdp_tx_init_bulk(bq, pr, d, xdpsqs, num, xsk, ub, un) do {   \
 	typeof(bq) ub = (bq);						      \
 	u32 un = (num);							      \
 									      \
 	rcu_read_lock();						      \
 									      \
-	if (un) {							      \
+	if (un || (xsk)) {						      \
 		ub->prog = rcu_dereference(pr);				      \
 		ub->dev = (d);						      \
 		ub->xdpsq = (xdpsqs)[libeth_xdpsq_id(un)];		      \
@@ -1141,6 +1164,7 @@ void __libeth_xdp_return_stash(struct libeth_xdp_buff_stash *stash);
  *
  * Should be called before the main NAPI polling loop. Loads the content of
  * the previously saved stash or initializes the buffer from scratch.
+ * Do not use for XSk.
  */
 static inline void
 libeth_xdp_init_buff(struct libeth_xdp_buff *dst,
@@ -1369,7 +1393,7 @@ __libeth_xdp_run_prog(struct libeth_xdp_buff *xdp,
  * @flush_bulk: driver callback for flushing a bulk
  *
  * Internal inline abstraction to run XDP program and additionally handle
- * ``XDP_TX`` verdict.
+ * ``XDP_TX`` verdict. Used by both XDP and XSk, hence @run and @queue.
  * Do not use directly.
  *
  * Return: libeth_xdp prog verdict depending on the prog's verdict.
@@ -1399,12 +1423,13 @@ __libeth_xdp_run_flush(struct libeth_xdp_buff *xdp,
 }
 
 /**
- * libeth_xdp_run_prog - run XDP program and handle all verdicts
+ * libeth_xdp_run_prog - run XDP program (non-XSk path) and handle all verdicts
  * @xdp: XDP buffer to process
  * @bq: XDP Tx bulk to queue ``XDP_TX`` buffers
  * @fl: driver ``XDP_TX`` bulk flush callback
  *
- * Run the attached XDP program and handle all possible verdicts.
+ * Run the attached XDP program and handle all possible verdicts. XSk has its
+ * own version.
  * Prefer using it via LIBETH_XDP_DEFINE_RUN{,_PASS,_PROG}().
  *
  * Return: true if the buffer should be passed up the stack, false if the poll
@@ -1426,7 +1451,7 @@ __libeth_xdp_run_flush(struct libeth_xdp_buff *xdp,
  * @run: driver wrapper to run XDP program
  * @populate: driver callback to populate an skb with the HW descriptor data
  *
- * Inline abstraction that does the following:
+ * Inline abstraction that does the following (non-XSk path):
  * 1) adds frame size and frag number (if needed) to the onstack stats;
  * 2) fills the descriptor metadata to the onstack &libeth_xdp_buff
  * 3) runs XDP program if present;
@@ -1509,7 +1534,7 @@ static inline void libeth_xdp_prep_desc(struct libeth_xdp_buff *xdp,
 			      run, populate)
 
 /**
- * libeth_xdp_finalize_rx - finalize XDPSQ after a NAPI polling loop
+ * libeth_xdp_finalize_rx - finalize XDPSQ after a NAPI polling loop (non-XSk)
  * @bq: ``XDP_TX`` frame bulk
  * @flush: driver callback to flush the bulk
  * @finalize: driver callback to start sending the frames and run the timer
@@ -1717,12 +1742,14 @@ static inline int libeth_xdpmo_rx_hash(u32 *hash,
 
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
@@ -1731,7 +1758,8 @@ void libeth_xdp_return_buff_bulk(const struct skb_shared_info *sinfo,
  */
 static __always_inline void
 __libeth_xdp_complete_tx(struct libeth_sqe *sqe, struct libeth_cq_pp *cp,
-			 typeof(libeth_xdp_return_buff_bulk) bulk)
+			 typeof(libeth_xdp_return_buff_bulk) bulk,
+			 typeof(libeth_xsk_buff_free_slow) xsk)
 {
 	enum libeth_sqe_type type = sqe->type;
 
@@ -1754,6 +1782,10 @@ __libeth_xdp_complete_tx(struct libeth_sqe *sqe, struct libeth_cq_pp *cp,
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
@@ -1761,6 +1793,7 @@ __libeth_xdp_complete_tx(struct libeth_sqe *sqe, struct libeth_cq_pp *cp,
 	switch (type) {
 	case LIBETH_SQE_XDP_TX:
 	case LIBETH_SQE_XDP_XMIT:
+	case LIBETH_SQE_XSK_TX:
 		cp->xdp_tx -= sqe->nr_frags;
 
 		cp->xss->packets++;
@@ -1776,7 +1809,8 @@ __libeth_xdp_complete_tx(struct libeth_sqe *sqe, struct libeth_cq_pp *cp,
 static inline void libeth_xdp_complete_tx(struct libeth_sqe *sqe,
 					  struct libeth_cq_pp *cp)
 {
-	__libeth_xdp_complete_tx(sqe, cp, libeth_xdp_return_buff_bulk);
+	__libeth_xdp_complete_tx(sqe, cp, libeth_xdp_return_buff_bulk,
+				 libeth_xsk_buff_free_slow);
 }
 
 /* Misc */
@@ -1784,7 +1818,9 @@ static inline void libeth_xdp_complete_tx(struct libeth_sqe *sqe,
 u32 libeth_xdp_queue_threshold(u32 count);
 
 void __libeth_xdp_set_features(struct net_device *dev,
-			       const struct xdp_metadata_ops *xmo);
+			       const struct xdp_metadata_ops *xmo,
+			       u32 zc_segs,
+			       const struct xsk_tx_metadata_ops *tmo);
 void libeth_xdp_set_redirect(struct net_device *dev, bool enable);
 
 /**
@@ -1801,9 +1837,13 @@ void libeth_xdp_set_redirect(struct net_device *dev, bool enable);
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
@@ -1824,4 +1864,6 @@ void libeth_xdp_set_redirect(struct net_device *dev, bool enable);
 	libeth_xdp_set_redirect(ud, false);				      \
 } while (0)
 
+#define libeth_xsktmo			((const void *)GOLDEN_RATIO_PRIME)
+
 #endif /* __LIBETH_XDP_H */
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
new file mode 100644
index 000000000000..481a7b28e6f2
--- /dev/null
+++ b/include/net/libeth/xsk.h
@@ -0,0 +1,685 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef __LIBETH_XSK_H
+#define __LIBETH_XSK_H
+
+#include <net/libeth/xdp.h>
+#include <net/xdp_sock_drv.h>
+
+/* ``XDP_TXMD_FLAGS_VALID`` is defined only under ``CONFIG_XDP_SOCKETS`` */
+#ifdef XDP_TXMD_FLAGS_VALID
+static_assert(XDP_TXMD_FLAGS_VALID <= LIBETH_XDP_TX_XSKMD);
+#endif
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
+		__libeth_xdp_tx_len(xdp->base.data_end - xdp->data,
+				    LIBETH_XDP_TX_FIRST),
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
+		__libeth_xdp_tx_len(frag->base.data_end - frag->data),
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
+		__libeth_xdp_tx_len(xdesc->len),
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
+		__libeth_xdp_tx_len(xdesc->len),
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
+/* Rx polling path */
+
+/**
+ * libeth_xsk_tx_init_bulk - initialize XDP Tx bulk for an XSk Rx NAPI poll
+ * @bq: bulk to initialize
+ * @prog: RCU pointer to the XDP program (never %NULL)
+ * @dev: target &net_device
+ * @xdpsqs: array of driver XDPSQ structs
+ * @num: number of active XDPSQs, the above array length
+ *
+ * Should be called on an onstack XDP Tx bulk before the XSk NAPI polling loop.
+ * Initializes all the needed fields to run libeth_xdp functions.
+ * Never checks if @prog is %NULL or @num == 0 as XDP must always be enabled
+ * when hitting this path.
+ */
+#define libeth_xsk_tx_init_bulk(bq, prog, dev, xdpsqs, num)		     \
+	__libeth_xdp_tx_init_bulk(bq, prog, dev, xdpsqs, num, true,	     \
+				  __UNIQUE_ID(bq_), __UNIQUE_ID(nqs_))
+
+struct libeth_xdp_buff *libeth_xsk_buff_add_frag(struct libeth_xdp_buff *head,
+						 struct libeth_xdp_buff *xdp);
+
+/**
+ * libeth_xsk_process_buff - attach XSk Rx buffer to &libeth_xdp_buff
+ * @head: head XSk buffer to attach the XSk buffer to (or %NULL)
+ * @xdp: XSk buffer to process
+ * @len: received data length from the descriptor
+ *
+ * If @head == %NULL, treats the XSk buffer as head and initializes
+ * the required fields. Otherwise, attaches the buffer as a frag.
+ * Already performs DMA sync-for-CPU and frame start prefetch
+ * (for head buffers only).
+ *
+ * Return: head XSk buffer on success or if the descriptor must be skipped
+ * (empty), %NULL if there is no space for a new frag.
+ */
+static inline struct libeth_xdp_buff *
+libeth_xsk_process_buff(struct libeth_xdp_buff *head,
+			struct libeth_xdp_buff *xdp, u32 len)
+{
+	if (unlikely(!len)) {
+		libeth_xsk_buff_free_slow(xdp);
+		return head;
+	}
+
+	xsk_buff_set_size(&xdp->base, len);
+	xsk_buff_dma_sync_for_cpu(&xdp->base);
+
+	if (head)
+		return libeth_xsk_buff_add_frag(head, xdp);
+
+	prefetch(xdp->data);
+
+	return xdp;
+}
+
+void libeth_xsk_buff_stats_frags(struct libeth_rq_napi_stats *rs,
+				 const struct libeth_xdp_buff *xdp);
+
+u32 __libeth_xsk_run_prog_slow(struct libeth_xdp_buff *xdp,
+			       const struct libeth_xdp_tx_bulk *bq,
+			       enum xdp_action act, int ret);
+
+/**
+ * __libeth_xsk_run_prog - run XDP program on XSk buffer
+ * @xdp: XSk buffer to run the prog on
+ * @bq: buffer bulk for ``XDP_TX`` queueing
+ *
+ * Internal inline abstraction to run XDP program on XSk Rx path. Handles
+ * only the most common ``XDP_REDIRECT`` inline, the rest is processed
+ * externally.
+ * Reports an XDP prog exception on errors.
+ *
+ * Return: libeth_xdp prog verdict depending on the prog's verdict.
+ */
+static __always_inline u32
+__libeth_xsk_run_prog(struct libeth_xdp_buff *xdp,
+		      const struct libeth_xdp_tx_bulk *bq)
+{
+	enum xdp_action act;
+	int ret = 0;
+
+	act = bpf_prog_run_xdp(bq->prog, &xdp->base);
+	if (unlikely(act != XDP_REDIRECT))
+rest:
+		return __libeth_xsk_run_prog_slow(xdp, bq, act, ret);
+
+	ret = xdp_do_redirect(bq->dev, &xdp->base, bq->prog);
+	if (unlikely(ret))
+		goto rest;
+
+	return LIBETH_XDP_REDIRECT;
+}
+
+/**
+ * libeth_xsk_run_prog - run XDP program on XSk path and handle all verdicts
+ * @xdp: XSk buffer to process
+ * @bq: XDP Tx bulk to queue ``XDP_TX`` buffers
+ * @fl: driver ``XDP_TX`` bulk flush callback
+ *
+ * Run the attached XDP program and handle all possible verdicts.
+ * Prefer using it via LIBETH_XSK_DEFINE_RUN{,_PASS,_PROG}().
+ *
+ * Return: libeth_xdp prog verdict depending on the prog's verdict.
+ */
+#define libeth_xsk_run_prog(xdp, bq, fl)				     \
+	__libeth_xdp_run_flush(xdp, bq, __libeth_xsk_run_prog,		     \
+			       libeth_xsk_tx_queue_bulk, fl)
+
+/**
+ * __libeth_xsk_run_pass - helper to run XDP program and handle the result
+ * @xdp: XSk buffer to process
+ * @bq: XDP Tx bulk to queue ``XDP_TX`` frames
+ * @napi: NAPI to build an skb and pass it up the stack
+ * @rs: onstack libeth RQ stats
+ * @md: metadata that should be filled to the XSk buffer
+ * @prep: callback for filling the metadata
+ * @run: driver wrapper to run XDP program
+ * @populate: driver callback to populate an skb with the HW descriptor data
+ *
+ * Inline abstraction, XSk's counterpart of __libeth_xdp_run_pass(), see its
+ * doc for details.
+ *
+ * Return: false if the polling loop must be exited due to lack of free
+ * buffers, true otherwise.
+ */
+static __always_inline bool
+__libeth_xsk_run_pass(struct libeth_xdp_buff *xdp,
+		      struct libeth_xdp_tx_bulk *bq, struct napi_struct *napi,
+		      struct libeth_rq_napi_stats *rs, const void *md,
+		      void (*prep)(struct libeth_xdp_buff *xdp,
+				   const void *md),
+		      u32 (*run)(struct libeth_xdp_buff *xdp,
+				 struct libeth_xdp_tx_bulk *bq),
+		      bool (*populate)(struct sk_buff *skb,
+				       const struct libeth_xdp_buff *xdp,
+				       struct libeth_rq_napi_stats *rs))
+{
+	struct sk_buff *skb;
+	u32 act;
+
+	rs->bytes += xdp->base.data_end - xdp->data;
+	rs->packets++;
+
+	if (unlikely(xdp_buff_has_frags(&xdp->base)))
+		libeth_xsk_buff_stats_frags(rs, xdp);
+
+	if (prep && (!__builtin_constant_p(!!md) || md))
+		prep(xdp, md);
+
+	act = run(xdp, bq);
+	if (likely(act == LIBETH_XDP_REDIRECT))
+		return true;
+
+	if (act != LIBETH_XDP_PASS)
+		return act != LIBETH_XDP_ABORTED;
+
+	skb = xdp_build_skb_from_zc(&xdp->base);
+	if (unlikely(!skb)) {
+		libeth_xsk_buff_free_slow(xdp);
+		return true;
+	}
+
+	if (unlikely(!populate(skb, xdp, rs))) {
+		napi_consume_skb(skb, true);
+		return true;
+	}
+
+	napi_gro_receive(napi, skb);
+
+	return true;
+}
+
+/**
+ * libeth_xsk_run_pass - helper to run XDP program and handle the result
+ * @xdp: XSk buffer to process
+ * @bq: XDP Tx bulk to queue ``XDP_TX`` frames
+ * @napi: NAPI to build an skb and pass it up the stack
+ * @rs: onstack libeth RQ stats
+ * @desc: pointer to the HW descriptor for that frame
+ * @run: driver wrapper to run XDP program
+ * @populate: driver callback to populate an skb with the HW descriptor data
+ *
+ * Wrapper around the underscored version when "fill the descriptor metadata"
+ * means just writing the pointer to the HW descriptor as @xdp->desc.
+ */
+#define libeth_xsk_run_pass(xdp, bq, napi, rs, desc, run, populate)	     \
+	__libeth_xsk_run_pass(xdp, bq, napi, rs, desc, libeth_xdp_prep_desc, \
+			      run, populate)
+
+/**
+ * libeth_xsk_finalize_rx - finalize XDPSQ after an XSk NAPI polling loop
+ * @bq: ``XDP_TX`` frame bulk
+ * @flush: driver callback to flush the bulk
+ * @finalize: driver callback to start sending the frames and run the timer
+ *
+ * Flush the bulk if there are frames left to send, kick the queue and flush
+ * the XDP maps.
+ */
+#define libeth_xsk_finalize_rx(bq, flush, finalize)			     \
+	__libeth_xdp_finalize_rx(bq, LIBETH_XDP_TX_XSK, flush, finalize)
+
+/*
+ * Helpers to reduce boilerplate code in drivers.
+ *
+ * Typical driver XSk Rx flow would be (excl. bulk and buff init, frag attach):
+ *
+ * LIBETH_XDP_DEFINE_START();
+ * LIBETH_XSK_DEFINE_FLUSH_TX(static driver_xsk_flush_tx, driver_xsk_tx_prep,
+ *			      driver_xdp_xmit);
+ * LIBETH_XSK_DEFINE_RUN(static driver_xsk_run, driver_xsk_run_prog,
+ *			 driver_xsk_flush_tx, driver_populate_skb);
+ * LIBETH_XSK_DEFINE_FINALIZE(static driver_xsk_finalize_rx,
+ *			      driver_xsk_flush_tx, driver_xdp_finalize_sq);
+ * LIBETH_XDP_DEFINE_END();
+ *
+ * This will build a set of 4 static functions. The compiler is free to decide
+ * whether to inline them.
+ * Then, in the NAPI polling function:
+ *
+ *	while (packets < budget) {
+ *		// ...
+ *		if (!driver_xsk_run(xdp, &bq, napi, &rs, desc))
+ *			break;
+ *	}
+ *	driver_xsk_finalize_rx(&bq);
+ */
+
+/**
+ * LIBETH_XSK_DEFINE_FLUSH_TX - define a driver XSk ``XDP_TX`` flush function
+ * @name: name of the function to define
+ * @prep: driver callback to clean an XDPSQ
+ * @xmit: driver callback to write a HW Tx descriptor
+ */
+#define LIBETH_XSK_DEFINE_FLUSH_TX(name, prep, xmit)			     \
+	__LIBETH_XDP_DEFINE_FLUSH_TX(name, prep, xmit, xsk)
+
+/**
+ * LIBETH_XSK_DEFINE_RUN_PROG - define a driver XDP program run function
+ * @name: name of the function to define
+ * @flush: driver callback to flush an XSk ``XDP_TX`` bulk
+ */
+#define LIBETH_XSK_DEFINE_RUN_PROG(name, flush)				     \
+	u32 __LIBETH_XDP_DEFINE_RUN_PROG(name, flush, xsk)
+
+/**
+ * LIBETH_XSK_DEFINE_RUN_PASS - define a driver buffer process + pass function
+ * @name: name of the function to define
+ * @run: driver callback to run XDP program (above)
+ * @populate: driver callback to fill an skb with HW descriptor info
+ */
+#define LIBETH_XSK_DEFINE_RUN_PASS(name, run, populate)			     \
+	bool __LIBETH_XDP_DEFINE_RUN_PASS(name, run, populate, xsk)
+
+/**
+ * LIBETH_XSK_DEFINE_RUN - define a driver buffer process, run + pass function
+ * @name: name of the function to define
+ * @run: name of the XDP prog run function to define
+ * @flush: driver callback to flush an XSk ``XDP_TX`` bulk
+ * @populate: driver callback to fill an skb with HW descriptor info
+ */
+#define LIBETH_XSK_DEFINE_RUN(name, run, flush, populate)		     \
+	__LIBETH_XDP_DEFINE_RUN(name, run, flush, populate, XSK)
+
+/**
+ * LIBETH_XSK_DEFINE_FINALIZE - define a driver XSk NAPI poll finalize function
+ * @name: name of the function to define
+ * @flush: driver callback to flush an XSk ``XDP_TX`` bulk
+ * @finalize: driver callback to finalize an XDPSQ and run the timer
+ */
+#define LIBETH_XSK_DEFINE_FINALIZE(name, flush, finalize)		     \
+	__LIBETH_XDP_DEFINE_FINALIZE(name, flush, finalize, xsk)
+
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
index dbede9a696a7..b84b9041f02e 100644
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
@@ -282,7 +284,8 @@ EXPORT_SYMBOL_GPL(libeth_xdp_buff_add_frag);
  * @act: original XDP prog verdict
  * @ret: error code if redirect failed
  *
- * External helper used by __libeth_xdp_run_prog(), do not call directly.
+ * External helper used by __libeth_xdp_run_prog() and
+ * __libeth_xsk_run_prog_slow(), do not call directly.
  * Reports invalid @act, XDP exception trace event and frees the buffer.
  *
  * Return: libeth_xdp XDP prog verdict.
@@ -295,6 +298,10 @@ u32 __cold libeth_xdp_prog_exception(const struct libeth_xdp_tx_bulk *bq,
 		bpf_warn_invalid_xdp_action(bq->dev, bq->prog, act);
 
 	libeth_trace_xdp_exception(bq->dev, bq->prog, act);
+
+	if (xdp->base.rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		return libeth_xsk_prog_exception(xdp, act, ret);
+
 	libeth_xdp_return_buff_slow(xdp);
 
 	return LIBETH_XDP_DROP;
@@ -371,21 +378,31 @@ EXPORT_SYMBOL_GPL(libeth_xdp_queue_threshold);
  * __libeth_xdp_set_features - set XDP features for netdev
  * @dev: &net_device to configure
  * @xmo: XDP metadata ops (Rx hints)
+ * @zc_segs: maximum number of S/G frags the HW can transmit
+ * @tmo: XSk Tx metadata ops (Tx hints)
  *
  * Set all the features libeth_xdp supports. Only the first argument is
  * necessary; without the third one (zero), XSk support won't be advertised.
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
 
@@ -410,6 +427,7 @@ EXPORT_SYMBOL_GPL(libeth_xdp_set_redirect);
 
 static const struct libeth_xdp_ops xdp_ops __initconst = {
 	.bulk	= libeth_xdp_return_buff_bulk,
+	.xsk	= libeth_xsk_buff_free_slow,
 };
 
 static int __init libeth_xdp_module_init(void)
diff --git a/drivers/net/ethernet/intel/libeth/xsk.c b/drivers/net/ethernet/intel/libeth/xsk.c
new file mode 100644
index 000000000000..9a510a509dcd
--- /dev/null
+++ b/drivers/net/ethernet/intel/libeth/xsk.c
@@ -0,0 +1,269 @@
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
+/* XSk TMO */
+
+const struct xsk_tx_metadata_ops libeth_xsktmo_slow = {
+	.tmo_request_checksum		= libeth_xsktmo_req_csum,
+};
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
+
+/**
+ * libeth_xsk_buff_add_frag - add frag to XSk Rx buffer
+ * @head: head buffer
+ * @xdp: frag buffer
+ *
+ * External helper used by libeth_xsk_process_buff(), do not call directly.
+ * Frees both main and frag buffers on error.
+ *
+ * Return: main buffer with attached frag on success, %NULL on error (no space
+ * for a new frag).
+ */
+struct libeth_xdp_buff *libeth_xsk_buff_add_frag(struct libeth_xdp_buff *head,
+						 struct libeth_xdp_buff *xdp)
+{
+	if (!xsk_buff_add_frag(&head->base, &xdp->base))
+		goto free;
+
+	return head;
+
+free:
+	libeth_xsk_buff_free_slow(xdp);
+	libeth_xsk_buff_free_slow(head);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(libeth_xsk_buff_add_frag);
+
+/**
+ * libeth_xsk_buff_stats_frags - update onstack RQ stats with XSk frags info
+ * @rs: onstack stats to update
+ * @xdp: buffer to account
+ *
+ * External helper used by __libeth_xsk_run_pass(), do not call directly.
+ * Adds buffer's frags count and total len to the onstack stats.
+ */
+void libeth_xsk_buff_stats_frags(struct libeth_rq_napi_stats *rs,
+				 const struct libeth_xdp_buff *xdp)
+{
+	libeth_xdp_buff_stats_frags(rs, xdp);
+}
+EXPORT_SYMBOL_GPL(libeth_xsk_buff_stats_frags);
+
+/**
+ * __libeth_xsk_run_prog_slow - process the non-``XDP_REDIRECT`` verdicts
+ * @xdp: buffer to process
+ * @bq: Tx bulk for queueing on ``XDP_TX``
+ * @act: verdict to process
+ * @ret: error code if ``XDP_REDIRECT`` failed
+ *
+ * External helper used by __libeth_xsk_run_prog(), do not call directly.
+ * ``XDP_REDIRECT`` is the most common and hottest verdict on XSk, thus
+ * it is processed inline. The rest goes here for out-of-line processing,
+ * together with redirect errors.
+ *
+ * Return: libeth_xdp XDP prog verdict.
+ */
+u32 __libeth_xsk_run_prog_slow(struct libeth_xdp_buff *xdp,
+			       const struct libeth_xdp_tx_bulk *bq,
+			       enum xdp_action act, int ret)
+{
+	switch (act) {
+	case XDP_DROP:
+		xsk_buff_free(&xdp->base);
+
+		return LIBETH_XDP_DROP;
+	case XDP_TX:
+		return LIBETH_XDP_TX;
+	case XDP_PASS:
+		return LIBETH_XDP_PASS;
+	default:
+		break;
+	}
+
+	return libeth_xdp_prog_exception(bq, xdp, act, ret);
+}
+EXPORT_SYMBOL_GPL(__libeth_xsk_run_prog_slow);
+
+/**
+ * libeth_xsk_prog_exception - handle XDP prog exceptions on XSk
+ * @xdp: buffer to process
+ * @act: verdict returned by the prog
+ * @ret: error code if ``XDP_REDIRECT`` failed
+ *
+ * Internal. Frees the buffer and, if the queue uses XSk wakeups, stop the
+ * current NAPI poll when there are no free buffers left.
+ *
+ * Return: libeth_xdp's XDP prog verdict.
+ */
+u32 __cold libeth_xsk_prog_exception(struct libeth_xdp_buff *xdp,
+				     enum xdp_action act, int ret)
+{
+	const struct xdp_buff_xsk *xsk;
+	u32 __ret = LIBETH_XDP_DROP;
+
+	if (act != XDP_REDIRECT)
+		goto drop;
+
+	xsk = container_of(&xdp->base, typeof(*xsk), xdp);
+	if (xsk_uses_need_wakeup(xsk->pool) && ret == -ENOBUFS)
+		__ret = LIBETH_XDP_ABORTED;
+
+drop:
+	libeth_xsk_buff_free_slow(xdp);
+
+	return __ret;
+}
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
2.48.1


