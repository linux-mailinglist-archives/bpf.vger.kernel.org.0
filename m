Return-Path: <bpf+bounces-60759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39431ADBB03
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 22:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E88518878A4
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 20:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2170C293C5C;
	Mon, 16 Jun 2025 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYY6D7fq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85945292B28;
	Mon, 16 Jun 2025 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105040; cv=none; b=XjM9QCimiVtHPu7eRPN6LPMsSKYzanHwKmbA2n1FpbL7WKXFggjRQ0kGJjirRATqo1Itr8acAK5K7aWDCRDlsYA1X5l+f7V0pdaPL+hJtXvPuqvQbMtqdvm5hApuROD63uEAKkHOz8Q28roZKtbH7LUGBlx29BTV/NINkCM3V7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105040; c=relaxed/simple;
	bh=nxa+FicSTLJBa5RoAoawbDVXaHnggtLbig7n3YKrdHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObOXGK4EdLcGRIkxtGAjG8xWKDiB8Pv8rort3tAEtUdsM1pej8lkXC3MUaBs54OtlR76/wkmQo+hHGIxSyHm3TmZdnelmVbODXOcdpAUz7r7TptR3hCJxRvchc5MtpVl8kkXxZzuLuXMsMHm+55AQRkZvNE40uA6CfbchSj6OMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYY6D7fq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750105038; x=1781641038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nxa+FicSTLJBa5RoAoawbDVXaHnggtLbig7n3YKrdHc=;
  b=hYY6D7fqHEHjjhs3pIPHVKTbatWLRdPgajsYD9MVuDN2UmLfOmqGy36p
   qSLlUIUPxM+/RVTKQAmh6WplG95+416JP5OTibeaUzn6Anpp0TFXHjm8J
   qAwuCoHQn8huKkQq3Hzya8ixvpXAytpaf0u46AXwFFBKjTV3ePM8Xdqp3
   nIx+ksy13SqTc816YI+DNBucu3qieFXwaKiXFtHFG70TCmca3516P15My
   zpnDd9gsZ4YmCcd908CNrZ/FfsO+g8uG1AcTpUWCucsSs/ovzmcxHKBAX
   VGgg9Pqa9c4kOrd+hGxl5E0Ua2sz7CMCfSDOZPv+iMxVk5d/EiFvVWcOU
   w==;
X-CSE-ConnectionGUID: CsZD6HL2SQ2BBFNbqvqGhw==
X-CSE-MsgGUID: DpSsETlGSeK9kkXT4MXBJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62533523"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="62533523"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 13:17:12 -0700
X-CSE-ConnectionGUID: UtmE+QvFTYqtSGjd3YNXzQ==
X-CSE-MsgGUID: hUOxQt60TN+SY6bGr0PtxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="153530998"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 16 Jun 2025 13:17:12 -0700
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
Subject: [PATCH net-next v2 10/17] libeth: xdp: add XDP prog run and verdict result handling
Date: Mon, 16 Jun 2025 13:16:31 -0700
Message-ID: <20250616201639.710420-11-anthony.l.nguyen@intel.com>
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

Running a prog and handling the verdicts, up to napi_gro_receive()
is also pretty generic code not really differing between vendors
(except for Tx descriptor filling and Rx descriptor parsing).

Define a couple inlines to do that. The inline callbacks a driver
needs to pass is mentioned above: Tx descriptor filling for XDP_TX,
populating skb with the descriptor data for XDP_PASS, finalizing
XDPSQs after the polling loop for XDP_TX (kicking the HW to start
sending).
The populate callback passes only &libeth_xdp_buff assuming buff::desc
pointer is enough, plus you can always get the corresponding Rx queue
structure via container_of(buff::rxq). If not, a driver can extend
the buff with more fields directly on the stack without touching
libeth_xdp definitions.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libeth/xdp.c |  27 +++
 include/net/libeth/types.h              |  22 ++
 include/net/libeth/xdp.h                | 281 ++++++++++++++++++++++++
 3 files changed, 330 insertions(+)

diff --git a/drivers/net/ethernet/intel/libeth/xdp.c b/drivers/net/ethernet/intel/libeth/xdp.c
index d0669f1f02f3..1607579d65bb 100644
--- a/drivers/net/ethernet/intel/libeth/xdp.c
+++ b/drivers/net/ethernet/intel/libeth/xdp.c
@@ -277,6 +277,33 @@ bool libeth_xdp_buff_add_frag(struct libeth_xdp_buff *xdp,
 }
 EXPORT_SYMBOL_GPL(libeth_xdp_buff_add_frag);
 
+/**
+ * libeth_xdp_prog_exception - handle XDP prog exceptions
+ * @bq: XDP Tx bulk
+ * @xdp: buffer to process
+ * @act: original XDP prog verdict
+ * @ret: error code if redirect failed
+ *
+ * External helper used by __libeth_xdp_run_prog(), do not call directly.
+ * Reports invalid @act, XDP exception trace event and frees the buffer.
+ *
+ * Return: libeth_xdp XDP prog verdict.
+ */
+u32 __cold libeth_xdp_prog_exception(const struct libeth_xdp_tx_bulk *bq,
+				     struct libeth_xdp_buff *xdp,
+				     enum xdp_action act, int ret)
+{
+	if (act > XDP_REDIRECT)
+		bpf_warn_invalid_xdp_action(bq->dev, bq->prog, act);
+
+	libeth_trace_xdp_exception(bq->dev, bq->prog, act);
+
+	libeth_xdp_return_buff_slow(xdp);
+
+	return LIBETH_XDP_DROP;
+}
+EXPORT_SYMBOL_GPL(libeth_xdp_prog_exception);
+
 /* Tx buffer completion */
 
 static void libeth_xdp_put_netmem_bulk(netmem_ref netmem,
diff --git a/include/net/libeth/types.h b/include/net/libeth/types.h
index 7b27c1966d45..cf1d78a9dc38 100644
--- a/include/net/libeth/types.h
+++ b/include/net/libeth/types.h
@@ -6,6 +6,28 @@
 
 #include <linux/workqueue.h>
 
+/* Stats */
+
+/**
+ * struct libeth_rq_napi_stats - "hot" counters to update in Rx polling loop
+ * @packets: received frames counter
+ * @bytes: sum of bytes of received frames above
+ * @fragments: sum of fragments of received S/G frames
+ * @hsplit: number of frames the device performed the header split for
+ * @raw: alias to access all the fields as an array
+ */
+struct libeth_rq_napi_stats {
+	union {
+		struct {
+							u32 packets;
+							u32 bytes;
+							u32 fragments;
+							u32 hsplit;
+		};
+		DECLARE_FLEX_ARRAY(u32, raw);
+	};
+};
+
 /**
  * struct libeth_sq_napi_stats - "hot" counters to update in Tx completion loop
  * @packets: completed frames counter
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index 780447cdabc1..db99bc690eb6 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -20,6 +20,7 @@ enum {
 	LIBETH_XDP_DROP			= BIT(0),
 	LIBETH_XDP_ABORTED		= BIT(1),
 	LIBETH_XDP_TX			= BIT(2),
+	LIBETH_XDP_REDIRECT		= BIT(3),
 };
 
 /*
@@ -353,6 +354,7 @@ static_assert(offsetof(struct libeth_xdp_tx_frame, frag.len) ==
  * @prog: corresponding active XDP program, %NULL for .ndo_xdp_xmit()
  * @dev: &net_device which the frames are transmitted on
  * @xdpsq: shortcut to the corresponding driver-specific XDPSQ structure
+ * @act_mask: Rx only, mask of all the XDP prog verdicts for that NAPI session
  * @count: current number of frames in @bulk
  * @bulk: array of queued frames for bulk Tx
  *
@@ -366,6 +368,7 @@ struct libeth_xdp_tx_bulk {
 	struct net_device		*dev;
 	void				*xdpsq;
 
+	u32				act_mask;
 	u32				count;
 	struct libeth_xdp_tx_frame	bulk[LIBETH_XDP_TX_BULK];
 } __aligned(sizeof(struct libeth_xdp_tx_frame));
@@ -999,6 +1002,40 @@ __libeth_xdp_xmit_do_bulk(struct libeth_xdp_tx_bulk *bq,
 
 /* Rx polling path */
 
+/**
+ * libeth_xdp_tx_init_bulk - initialize an XDP Tx bulk for Rx NAPI poll
+ * @bq: bulk to initialize
+ * @prog: RCU pointer to the XDP program (can be %NULL)
+ * @dev: target &net_device
+ * @xdpsqs: array of driver XDPSQ structs
+ * @num: number of active XDPSQs, the above array length
+ *
+ * Should be called on an onstack XDP Tx bulk before the NAPI polling loop.
+ * Initializes all the needed fields to run libeth_xdp functions. If @num == 0,
+ * assumes XDP is not enabled.
+ */
+#define libeth_xdp_tx_init_bulk(bq, prog, dev, xdpsqs, num)		      \
+	__libeth_xdp_tx_init_bulk(bq, prog, dev, xdpsqs, num, false,	      \
+				  __UNIQUE_ID(bq_), __UNIQUE_ID(nqs_))
+
+#define __libeth_xdp_tx_init_bulk(bq, pr, d, xdpsqs, num, ub, un) do {	      \
+	typeof(bq) ub = (bq);						      \
+	u32 un = (num);							      \
+									      \
+	rcu_read_lock();						      \
+									      \
+	if (un) {							      \
+		ub->prog = rcu_dereference(pr);				      \
+		ub->dev = (d);						      \
+		ub->xdpsq = (xdpsqs)[libeth_xdpsq_id(un)];		      \
+	} else {							      \
+		ub->prog = NULL;					      \
+	}								      \
+									      \
+	ub->act_mask = 0;						      \
+	ub->count = 0;							      \
+} while (0)
+
 void libeth_xdp_load_stash(struct libeth_xdp_buff *dst,
 			   const struct libeth_xdp_buff_stash *src);
 void libeth_xdp_save_stash(struct libeth_xdp_buff_stash *dst,
@@ -1155,6 +1192,250 @@ static inline bool libeth_xdp_process_buff(struct libeth_xdp_buff *xdp,
 	return true;
 }
 
+/**
+ * libeth_xdp_buff_stats_frags - update onstack RQ stats with XDP frags info
+ * @ss: onstack stats to update
+ * @xdp: buffer to account
+ *
+ * Internal helper used by __libeth_xdp_run_pass(), do not call directly.
+ * Adds buffer's frags count and total len to the onstack stats.
+ */
+static inline void
+libeth_xdp_buff_stats_frags(struct libeth_rq_napi_stats *ss,
+			    const struct libeth_xdp_buff *xdp)
+{
+	const struct skb_shared_info *sinfo;
+
+	sinfo = xdp_get_shared_info_from_buff(&xdp->base);
+	ss->bytes += sinfo->xdp_frags_size;
+	ss->fragments += sinfo->nr_frags + 1;
+}
+
+u32 libeth_xdp_prog_exception(const struct libeth_xdp_tx_bulk *bq,
+			      struct libeth_xdp_buff *xdp,
+			      enum xdp_action act, int ret);
+
+/**
+ * __libeth_xdp_run_prog - run XDP program on an XDP buffer
+ * @xdp: XDP buffer to run the prog on
+ * @bq: buffer bulk for ``XDP_TX`` queueing
+ *
+ * Internal inline abstraction to run XDP program. Handles ``XDP_DROP``
+ * and ``XDP_REDIRECT`` only, the rest is processed levels up.
+ * Reports an XDP prog exception on errors.
+ *
+ * Return: libeth_xdp prog verdict depending on the prog's verdict.
+ */
+static __always_inline u32
+__libeth_xdp_run_prog(struct libeth_xdp_buff *xdp,
+		      const struct libeth_xdp_tx_bulk *bq)
+{
+	enum xdp_action act;
+
+	act = bpf_prog_run_xdp(bq->prog, &xdp->base);
+	if (unlikely(act < XDP_DROP || act > XDP_REDIRECT))
+		goto out;
+
+	switch (act) {
+	case XDP_PASS:
+		return LIBETH_XDP_PASS;
+	case XDP_DROP:
+		libeth_xdp_return_buff(xdp);
+
+		return LIBETH_XDP_DROP;
+	case XDP_TX:
+		return LIBETH_XDP_TX;
+	case XDP_REDIRECT:
+		if (unlikely(xdp_do_redirect(bq->dev, &xdp->base, bq->prog)))
+			break;
+
+		xdp->data = NULL;
+
+		return LIBETH_XDP_REDIRECT;
+	default:
+		break;
+	}
+
+out:
+	return libeth_xdp_prog_exception(bq, xdp, act, 0);
+}
+
+/**
+ * __libeth_xdp_run_flush - run XDP program and handle ``XDP_TX`` verdict
+ * @xdp: XDP buffer to run the prog on
+ * @bq: buffer bulk for ``XDP_TX`` queueing
+ * @run: internal callback for running XDP program
+ * @queue: internal callback for queuing ``XDP_TX`` frame
+ * @flush_bulk: driver callback for flushing a bulk
+ *
+ * Internal inline abstraction to run XDP program and additionally handle
+ * ``XDP_TX`` verdict.
+ * Do not use directly.
+ *
+ * Return: libeth_xdp prog verdict depending on the prog's verdict.
+ */
+static __always_inline u32
+__libeth_xdp_run_flush(struct libeth_xdp_buff *xdp,
+		       struct libeth_xdp_tx_bulk *bq,
+		       u32 (*run)(struct libeth_xdp_buff *xdp,
+				  const struct libeth_xdp_tx_bulk *bq),
+		       bool (*queue)(struct libeth_xdp_tx_bulk *bq,
+				     struct libeth_xdp_buff *xdp,
+				     bool (*flush_bulk)
+					  (struct libeth_xdp_tx_bulk *bq,
+					   u32 flags)),
+		       bool (*flush_bulk)(struct libeth_xdp_tx_bulk *bq,
+					  u32 flags))
+{
+	u32 act;
+
+	act = run(xdp, bq);
+	if (act == LIBETH_XDP_TX && unlikely(!queue(bq, xdp, flush_bulk)))
+		act = LIBETH_XDP_DROP;
+
+	bq->act_mask |= act;
+
+	return act;
+}
+
+/**
+ * libeth_xdp_run_prog - run XDP program and handle all verdicts
+ * @xdp: XDP buffer to process
+ * @bq: XDP Tx bulk to queue ``XDP_TX`` buffers
+ * @fl: driver ``XDP_TX`` bulk flush callback
+ *
+ * Run the attached XDP program and handle all possible verdicts.
+ *
+ * Return: true if the buffer should be passed up the stack, false if the poll
+ * should go to the next buffer.
+ */
+#define libeth_xdp_run_prog(xdp, bq, fl)				      \
+	(__libeth_xdp_run_flush(xdp, bq, __libeth_xdp_run_prog,		      \
+				libeth_xdp_tx_queue_bulk,		      \
+				fl) == LIBETH_XDP_PASS)
+
+/**
+ * __libeth_xdp_run_pass - helper to run XDP program and handle the result
+ * @xdp: XDP buffer to process
+ * @bq: XDP Tx bulk to queue ``XDP_TX`` frames
+ * @napi: NAPI to build an skb and pass it up the stack
+ * @rs: onstack libeth RQ stats
+ * @md: metadata that should be filled to the XDP buffer
+ * @prep: callback for filling the metadata
+ * @run: driver wrapper to run XDP program
+ * @populate: driver callback to populate an skb with the HW descriptor data
+ *
+ * Inline abstraction that does the following:
+ * 1) adds frame size and frag number (if needed) to the onstack stats;
+ * 2) fills the descriptor metadata to the onstack &libeth_xdp_buff
+ * 3) runs XDP program if present;
+ * 4) handles all possible verdicts;
+ * 5) on ``XDP_PASS`, builds an skb from the buffer;
+ * 6) populates it with the descriptor metadata;
+ * 7) passes it up the stack.
+ *
+ * In most cases, number 2 means just writing the pointer to the HW descriptor
+ * to the XDP buffer. If so, please use LIBETH_XDP_DEFINE_RUN{,_PASS}()
+ * wrappers to build a driver function.
+ */
+static __always_inline void
+__libeth_xdp_run_pass(struct libeth_xdp_buff *xdp,
+		      struct libeth_xdp_tx_bulk *bq, struct napi_struct *napi,
+		      struct libeth_rq_napi_stats *rs, const void *md,
+		      void (*prep)(struct libeth_xdp_buff *xdp,
+				   const void *md),
+		      bool (*run)(struct libeth_xdp_buff *xdp,
+				  struct libeth_xdp_tx_bulk *bq),
+		      bool (*populate)(struct sk_buff *skb,
+				       const struct libeth_xdp_buff *xdp,
+				       struct libeth_rq_napi_stats *rs))
+{
+	struct sk_buff *skb;
+
+	rs->bytes += xdp->base.data_end - xdp->data;
+	rs->packets++;
+
+	if (xdp_buff_has_frags(&xdp->base))
+		libeth_xdp_buff_stats_frags(rs, xdp);
+
+	if (prep && (!__builtin_constant_p(!!md) || md))
+		prep(xdp, md);
+
+	if (!bq || !run || !bq->prog)
+		goto build;
+
+	if (!run(xdp, bq))
+		return;
+
+build:
+	skb = xdp_build_skb_from_buff(&xdp->base);
+	if (unlikely(!skb)) {
+		libeth_xdp_return_buff_slow(xdp);
+		return;
+	}
+
+	xdp->data = NULL;
+
+	if (unlikely(!populate(skb, xdp, rs))) {
+		napi_consume_skb(skb, true);
+		return;
+	}
+
+	napi_gro_receive(napi, skb);
+}
+
+static inline void libeth_xdp_prep_desc(struct libeth_xdp_buff *xdp,
+					const void *desc)
+{
+	xdp->desc = desc;
+}
+
+/**
+ * libeth_xdp_run_pass - helper to run XDP program and handle the result
+ * @xdp: XDP buffer to process
+ * @bq: XDP Tx bulk to queue ``XDP_TX`` frames
+ * @napi: NAPI to build an skb and pass it up the stack
+ * @ss: onstack libeth RQ stats
+ * @desc: pointer to the HW descriptor for that frame
+ * @run: driver wrapper to run XDP program
+ * @populate: driver callback to populate an skb with the HW descriptor data
+ *
+ * Wrapper around the underscored version when "fill the descriptor metadata"
+ * means just writing the pointer to the HW descriptor as @xdp->desc.
+ */
+#define libeth_xdp_run_pass(xdp, bq, napi, ss, desc, run, populate)	      \
+	__libeth_xdp_run_pass(xdp, bq, napi, ss, desc, libeth_xdp_prep_desc,  \
+			      run, populate)
+
+/**
+ * libeth_xdp_finalize_rx - finalize XDPSQ after a NAPI polling loop
+ * @bq: ``XDP_TX`` frame bulk
+ * @flush: driver callback to flush the bulk
+ * @finalize: driver callback to start sending the frames and run the timer
+ *
+ * Flush the bulk if there are frames left to send, kick the queue and flush
+ * the XDP maps.
+ */
+#define libeth_xdp_finalize_rx(bq, flush, finalize)			      \
+	__libeth_xdp_finalize_rx(bq, 0, flush, finalize)
+
+static __always_inline void
+__libeth_xdp_finalize_rx(struct libeth_xdp_tx_bulk *bq, u32 flags,
+			 bool (*flush_bulk)(struct libeth_xdp_tx_bulk *bq,
+					    u32 flags),
+			 void (*finalize)(void *xdpsq, bool sent, bool flush))
+{
+	if (bq->act_mask & LIBETH_XDP_TX) {
+		if (bq->count)
+			flush_bulk(bq, flags | LIBETH_XDP_TX_DROP);
+		finalize(bq->xdpsq, true, true);
+	}
+	if (bq->act_mask & LIBETH_XDP_REDIRECT)
+		xdp_do_flush();
+
+	rcu_read_unlock();
+}
+
 /* Tx buffer completion */
 
 void libeth_xdp_return_buff_bulk(const struct skb_shared_info *sinfo,
-- 
2.47.1


