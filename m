Return-Path: <bpf+bounces-55990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4494BA8A59D
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3CB4402BC
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36D238146;
	Tue, 15 Apr 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXlFshM4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1D1237700;
	Tue, 15 Apr 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738194; cv=none; b=huiAcs1fFs1uIYxBRFd5D7NdGCZty7g9QKpnQMyR+78Q32CAgvyzcaXrLbSn+p59uRrmjvzUoVJoxznjzO2RqhgLHXLDZsRv3b0HHmHf10zHbTxEYUXZfZkVc58SNmbveWwnCN5SQVkVa4PbWNSegb6Yab+DSZXQjZARxk9Tj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738194; c=relaxed/simple;
	bh=NcFwBVdNZryCcoAETtoFYTV4parcEiZwMklgO3sKgzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZcm+8sXiz4+aqmhbprit0vWDLAow+6i7yWGjha7TrkH9IV8E8vH85fGmddd+uTIa9u0uq6OiS00wA7PDUXIw+hph0SkXH3IH/OmdrkCXKNtu9D2aMVgAe+fYVUmVIJbu+Et/zChv5WK3OqenkHmeLv/BDAPUQO1+dhDPcoqRy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXlFshM4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744738193; x=1776274193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NcFwBVdNZryCcoAETtoFYTV4parcEiZwMklgO3sKgzE=;
  b=WXlFshM45mdXE0B+FTidomUcVP97toaFtm6Y58s9QRAWQSSNN7HbukeT
   o3acRjkMNROFXuD4P1+isVenXGOn4LeV0ZWUmFUhKH3LbDEJcYlRSL67h
   MRwZrFsQZjH9c8BVmHMHVSIV9Nrhobp76EwaLmrfN9xPFuK7gsOD4LrPn
   O3VSg/Ea6eEsutwHxwoI4z19iuqmNJnRwog7zgtJWIkm8opz6B+HM9I7h
   Pew1njvmywb0pIgoiIHd4jBVzOzTNUd0gLwsYgLTXEx1jLQEisAaXmMlP
   Ilk+RCTfDjxGnKOTiWnnZ9JQ5U5IHUl2Up58P5NQkbxnz15a1qN2iW3xN
   g==;
X-CSE-ConnectionGUID: nSYRmrgLRzqYIoIc9H60tw==
X-CSE-MsgGUID: OOyV3aByTAm/3/2vpYeqKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46275804"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46275804"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:29:53 -0700
X-CSE-ConnectionGUID: ADSukQRUSFO3//k8/WK9YA==
X-CSE-MsgGUID: W/PxcA5eTDWWMAH3LOXyTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130729879"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 15 Apr 2025 10:29:48 -0700
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
Subject: [PATCH iwl-next 14/16] libeth: xsk: add XSk Rx processing support
Date: Tue, 15 Apr 2025 19:28:23 +0200
Message-ID: <20250415172825.3731091-15-aleksander.lobakin@intel.com>
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

Add XSk counterparts for preparing XSk &libeth_xdp_buff (adding head and
frags), running the program, and handling the verdict, inc. XDP_PASS.
Shortcuts in comparison with regular Rx: frags and all verdicts except
XDP_REDIRECT are under unlikely() and out of line; no checks for XDP
program presence as it's always true for XSk.

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # optimizations
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/libeth/priv.h |   3 +
 include/net/libeth/xdp.h                 |  17 +-
 include/net/libeth/xsk.h                 | 273 +++++++++++++++++++++++
 drivers/net/ethernet/intel/libeth/xdp.c  |   6 +-
 drivers/net/ethernet/intel/libeth/xsk.c  | 107 +++++++++
 5 files changed, 398 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/libeth/priv.h b/drivers/net/ethernet/intel/libeth/priv.h
index 03e74382b2cb..9b811d31015c 100644
--- a/drivers/net/ethernet/intel/libeth/priv.h
+++ b/drivers/net/ethernet/intel/libeth/priv.h
@@ -8,6 +8,7 @@
 
 /* XDP */
 
+enum xdp_action;
 struct libeth_xdp_buff;
 struct libeth_xdp_tx_frame;
 struct skb_shared_info;
@@ -17,6 +18,8 @@ extern const struct xsk_tx_metadata_ops libeth_xsktmo_slow;
 
 void libeth_xsk_tx_return_bulk(const struct libeth_xdp_tx_frame *bq,
 			       u32 count);
+u32 libeth_xsk_prog_exception(struct libeth_xdp_buff *xdp, enum xdp_action act,
+			      int ret);
 
 struct libeth_xdp_ops {
 	void	(*bulk)(const struct skb_shared_info *sinfo,
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index feb74dc36f1b..85f058482fc7 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -1115,18 +1115,19 @@ __libeth_xdp_xmit_do_bulk(struct libeth_xdp_tx_bulk *bq,
  * Should be called on an onstack XDP Tx bulk before the NAPI polling loop.
  * Initializes all the needed fields to run libeth_xdp functions. If @num == 0,
  * assumes XDP is not enabled.
+ * Do not use for XSk, it has its own optimized helper.
  */
 #define libeth_xdp_tx_init_bulk(bq, prog, dev, xdpsqs, num)		      \
 	__libeth_xdp_tx_init_bulk(bq, prog, dev, xdpsqs, num, false,	      \
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
@@ -1152,6 +1153,7 @@ void __libeth_xdp_return_stash(struct libeth_xdp_buff_stash *stash);
  *
  * Should be called before the main NAPI polling loop. Loads the content of
  * the previously saved stash or initializes the buffer from scratch.
+ * Do not use for XSk.
  */
 static inline void
 libeth_xdp_init_buff(struct libeth_xdp_buff *dst,
@@ -1371,7 +1373,7 @@ __libeth_xdp_run_prog(struct libeth_xdp_buff *xdp,
  * @flush_bulk: driver callback for flushing a bulk
  *
  * Internal inline abstraction to run XDP program and additionally handle
- * ``XDP_TX`` verdict.
+ * ``XDP_TX`` verdict. Used by both XDP and XSk, hence @run and @queue.
  * Do not use directly.
  *
  * Return: libeth_xdp prog verdict depending on the prog's verdict.
@@ -1401,12 +1403,13 @@ __libeth_xdp_run_flush(struct libeth_xdp_buff *xdp,
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
@@ -1428,7 +1431,7 @@ __libeth_xdp_run_flush(struct libeth_xdp_buff *xdp,
  * @run: driver wrapper to run XDP program
  * @populate: driver callback to populate an skb with the HW descriptor data
  *
- * Inline abstraction that does the following:
+ * Inline abstraction that does the following (non-XSk path):
  * 1) adds frame size and frag number (if needed) to the onstack stats;
  * 2) fills the descriptor metadata to the onstack &libeth_xdp_buff
  * 3) runs XDP program if present;
@@ -1511,7 +1514,7 @@ static inline void libeth_xdp_prep_desc(struct libeth_xdp_buff *xdp,
 			      run, populate)
 
 /**
- * libeth_xdp_finalize_rx - finalize XDPSQ after a NAPI polling loop
+ * libeth_xdp_finalize_rx - finalize XDPSQ after a NAPI polling loop (non-XSk)
  * @bq: ``XDP_TX`` frame bulk
  * @flush: driver callback to flush the bulk
  * @finalize: driver callback to start sending the frames and run the timer
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index 16ca195981fe..f3f338e566fc 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -311,4 +311,277 @@ libeth_xsk_xmit_do_bulk(struct xsk_buff_pool *pool, void *xdpsq, u32 budget,
 	return n < budget;
 }
 
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
 #endif /* __LIBETH_XSK_H */
diff --git a/drivers/net/ethernet/intel/libeth/xdp.c b/drivers/net/ethernet/intel/libeth/xdp.c
index df774994909a..b84b9041f02e 100644
--- a/drivers/net/ethernet/intel/libeth/xdp.c
+++ b/drivers/net/ethernet/intel/libeth/xdp.c
@@ -284,7 +284,8 @@ EXPORT_SYMBOL_GPL(libeth_xdp_buff_add_frag);
  * @act: original XDP prog verdict
  * @ret: error code if redirect failed
  *
- * External helper used by __libeth_xdp_run_prog(), do not call directly.
+ * External helper used by __libeth_xdp_run_prog() and
+ * __libeth_xsk_run_prog_slow(), do not call directly.
  * Reports invalid @act, XDP exception trace event and frees the buffer.
  *
  * Return: libeth_xdp XDP prog verdict.
@@ -298,6 +299,9 @@ u32 __cold libeth_xdp_prog_exception(const struct libeth_xdp_tx_bulk *bq,
 
 	libeth_trace_xdp_exception(bq->dev, bq->prog, act);
 
+	if (xdp->base.rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		return libeth_xsk_prog_exception(xdp, act, ret);
+
 	libeth_xdp_return_buff_slow(xdp);
 
 	return LIBETH_XDP_DROP;
diff --git a/drivers/net/ethernet/intel/libeth/xsk.c b/drivers/net/ethernet/intel/libeth/xsk.c
index c17424c52dd1..ecb038f20df5 100644
--- a/drivers/net/ethernet/intel/libeth/xsk.c
+++ b/drivers/net/ethernet/intel/libeth/xsk.c
@@ -36,3 +36,110 @@ void libeth_xsk_buff_free_slow(struct libeth_xdp_buff *xdp)
 	xsk_buff_free(&xdp->base);
 }
 EXPORT_SYMBOL_GPL(libeth_xsk_buff_free_slow);
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
-- 
2.49.0


