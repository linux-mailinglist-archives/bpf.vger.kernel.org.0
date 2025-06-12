Return-Path: <bpf+bounces-60498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA54AD77DD
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 18:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D12189AE0B
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0E52D3236;
	Thu, 12 Jun 2025 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCRORGsm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABB2D321D;
	Thu, 12 Jun 2025 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744620; cv=none; b=JLBUj8n3hwq0Qn4LOwAuJpRrbYAijZarhkomggo28Ocobm51i/6dm7KkKseWl25TvkRr/w8vV10O/t8KgtclNwE844mYqyqIsnd+mtFJOMkqrkcRV7Ady/KBRpiEyogMpontiuHchYY+kdtw/94lOXKT7djUKVn/felGDZ5FmYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744620; c=relaxed/simple;
	bh=YFJLa6ogOz39Ye7azlCujQ7EKqgDtlkYXfArTxbxrEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzZfHs2Rh2CGk2ZWwMN2bIBaXlKDg1kk6OACNOPChh1DikpYh2u/5kKK8bLTrzWx4MjIWH88L4M1+AKKI0bnV5yCATfZr88GdYPVQBbpy+HKyxDY+sRPZ5WlZBVlFTtIlUZgm8cfHLfFvxLwvwHxeqzcRlghFQzduAp/UVr8K/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCRORGsm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749744619; x=1781280619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YFJLa6ogOz39Ye7azlCujQ7EKqgDtlkYXfArTxbxrEs=;
  b=PCRORGsmAxfBsGYt581T5PT1aTt4PtZH0FcTtCz7pSDwGjTjyOQot0o7
   IAr58bB7zNnG7l7JjhOzufAky+20xpSYQXFZDmJzYpCFCUYDH/L9rADLc
   GexNVQxb+AgygSLy9edn16ZWsRQh7XKZ7sfZRhNnQFMScCgSXOyNot0u7
   nTHri2VVSkyOi8sCg20lPj4qDCoXad7+ZcBhy4hDQUvF3UkCSvtTrUMSr
   CQ7xTMul4f92Fj3rL1v0ZuaOpluxdXhPr2w31Ss/bWBV6PMrMlu1x3J/V
   3uRNMl6FImeThYNBFcwsQmV6xeE7B0pfp9obyTYSTkOLWnfa+U0yd7k4e
   g==;
X-CSE-ConnectionGUID: /DNdZL+JTyu3oxE/gVwwbQ==
X-CSE-MsgGUID: QnkhQP0bS76CbkfT9Uv9eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55739043"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55739043"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:10:19 -0700
X-CSE-ConnectionGUID: fOlGAM1XRj21BGP/Pv3k8A==
X-CSE-MsgGUID: q4237JgUQKqTnJwBV4uOJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148468605"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2025 09:10:14 -0700
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
Subject: [PATCH iwl-next v2 11/17] libeth: xdp: add templates for building driver-side callbacks
Date: Thu, 12 Jun 2025 18:02:28 +0200
Message-ID: <20250612160234.68682-12-aleksander.lobakin@intel.com>
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

Defining driver-specific functions to pass to libeth_xdp functions can
induce boilerplates and/or look a bit cryptic with all those layers of
indirection. On the other hand, this indirection is needed to allow
compilers to uninline big functions even when passed to __always_inline
helpers (too much inlining also hurts performance in some cases), plus
to reuse some XDP helpers in XSk code.
Add macros to quickly build them, with the detailed kdoc. They take
names of the actual callbacks for filling a Tx descriptor and other
purely HW-specific things and wrap them appropriately.

LIBETH_XDP_DEFINE_{BEGIN,END}() is needed for GCC 8+ unfortunately to
let the drivers control which functions will be static and which global
without hitting `-Wold-style-declaration`.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/libeth/xdp.h | 195 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index db99bc690eb6..46a2ec3c3037 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -742,6 +742,9 @@ __libeth_xdp_tx_flush_bulk(struct libeth_xdp_tx_bulk *bq, u32 flags,
  * @flags: Tx flags, see above
  * @prep: driver callback to prepare the queue
  * @xmit: driver callback to fill a HW descriptor
+ *
+ * Use via LIBETH_XDP_DEFINE_FLUSH_TX() to define an ``XDP_TX`` driver
+ * callback.
  */
 #define libeth_xdp_tx_flush_bulk(bq, flags, prep, xmit)			      \
 	__libeth_xdp_tx_flush_bulk(bq, flags, prep, libeth_xdp_tx_fill_buf,   \
@@ -749,6 +752,25 @@ __libeth_xdp_tx_flush_bulk(struct libeth_xdp_tx_bulk *bq, u32 flags,
 
 /* .ndo_xdp_xmit() implementation */
 
+/**
+ * libeth_xdp_xmit_init_bulk - internal helper to initialize bulk for XDP xmit
+ * @bq: bulk to initialize
+ * @dev: target &net_device
+ * @xdpsqs: array of driver-specific XDPSQ structs
+ * @num: number of active XDPSQs (the above array length)
+ */
+#define libeth_xdp_xmit_init_bulk(bq, dev, xdpsqs, num)			      \
+	__libeth_xdp_xmit_init_bulk(bq, dev, (xdpsqs)[libeth_xdpsq_id(num)])
+
+static inline void __libeth_xdp_xmit_init_bulk(struct libeth_xdp_tx_bulk *bq,
+					       struct net_device *dev,
+					       void *xdpsq)
+{
+	bq->dev = dev;
+	bq->xdpsq = xdpsq;
+	bq->count = 0;
+}
+
 /**
  * libeth_xdp_xmit_frame_dma - internal helper to access DMA of an &xdp_frame
  * @xf: pointer to the XDP frame
@@ -941,6 +963,9 @@ libeth_xdp_xmit_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
  * @flags: Tx flags, see __libeth_xdp_tx_flush_bulk()
  * @prep: driver callback to prepare the queue
  * @xmit: driver callback to fill a HW descriptor
+ *
+ * Use via LIBETH_XDP_DEFINE_FLUSH_XMIT() to define an XDP xmit driver
+ * callback.
  */
 #define libeth_xdp_xmit_flush_bulk(bq, flags, prep, xmit)		      \
 	__libeth_xdp_tx_flush_bulk(bq, (flags) | LIBETH_XDP_TX_NDO, prep,     \
@@ -1000,6 +1025,44 @@ __libeth_xdp_xmit_do_bulk(struct libeth_xdp_tx_bulk *bq,
 	return nxmit;
 }
 
+/**
+ * libeth_xdp_xmit_do_bulk - implement full .ndo_xdp_xmit() in driver
+ * @dev: target &net_device
+ * @n: number of frames to send
+ * @fr: XDP frames to send
+ * @f: flags passed by the stack
+ * @xqs: array of XDPSQs driver structs
+ * @nqs: number of active XDPSQs, the above array length
+ * @fl: driver callback to flush an XDP xmit bulk
+ * @fin: driver cabback to finalize the queue
+ *
+ * If the driver has active XDPSQs, perform common checks and send the frames.
+ * Finalize the queue, if requested.
+ *
+ * Return: number of frames sent or -errno on error.
+ */
+#define libeth_xdp_xmit_do_bulk(dev, n, fr, f, xqs, nqs, fl, fin)	      \
+	_libeth_xdp_xmit_do_bulk(dev, n, fr, f, xqs, nqs, fl, fin,	      \
+				 __UNIQUE_ID(bq_), __UNIQUE_ID(ret_),	      \
+				 __UNIQUE_ID(nqs_))
+
+#define _libeth_xdp_xmit_do_bulk(d, n, fr, f, xqs, nqs, fl, fin, ub, ur, un)  \
+({									      \
+	u32 un = (nqs);							      \
+	int ur;								      \
+									      \
+	if (likely(un)) {						      \
+		LIBETH_XDP_ONSTACK_BULK(ub);				      \
+									      \
+		libeth_xdp_xmit_init_bulk(&ub, d, xqs, un);		      \
+		ur = __libeth_xdp_xmit_do_bulk(&ub, fr, n, f, fl, fin);	      \
+	} else {							      \
+		ur = -ENXIO;						      \
+	}								      \
+									      \
+	ur;								      \
+})
+
 /* Rx polling path */
 
 /**
@@ -1305,6 +1368,7 @@ __libeth_xdp_run_flush(struct libeth_xdp_buff *xdp,
  * @fl: driver ``XDP_TX`` bulk flush callback
  *
  * Run the attached XDP program and handle all possible verdicts.
+ * Prefer using it via LIBETH_XDP_DEFINE_RUN{,_PASS,_PROG}().
  *
  * Return: true if the buffer should be passed up the stack, false if the poll
  * should go to the next buffer.
@@ -1436,6 +1500,137 @@ __libeth_xdp_finalize_rx(struct libeth_xdp_tx_bulk *bq, u32 flags,
 	rcu_read_unlock();
 }
 
+/*
+ * Helpers to reduce boilerplate code in drivers.
+ *
+ * Typical driver Rx flow would be (excl. bulk and buff init, frag attach):
+ *
+ * LIBETH_XDP_DEFINE_START();
+ * LIBETH_XDP_DEFINE_FLUSH_TX(static driver_xdp_flush_tx, driver_xdp_tx_prep,
+ *			      driver_xdp_xmit);
+ * LIBETH_XDP_DEFINE_RUN(static driver_xdp_run, driver_xdp_run_prog,
+ *			 driver_xdp_flush_tx, driver_populate_skb);
+ * LIBETH_XDP_DEFINE_FINALIZE(static driver_xdp_finalize_rx,
+ *			      driver_xdp_flush_tx, driver_xdp_finalize_sq);
+ * LIBETH_XDP_DEFINE_END();
+ *
+ * This will build a set of 4 static functions. The compiler is free to decide
+ * whether to inline them.
+ * Then, in the NAPI polling function:
+ *
+ *	while (packets < budget) {
+ *		// ...
+ *		driver_xdp_run(xdp, &bq, napi, &rs, desc);
+ *	}
+ *	driver_xdp_finalize_rx(&bq);
+ */
+
+#define LIBETH_XDP_DEFINE_START()					      \
+	__diag_push();							      \
+	__diag_ignore(GCC, 8, "-Wold-style-declaration",		      \
+		      "Allow specifying \'static\' after the return type")
+
+/**
+ * LIBETH_XDP_DEFINE_TIMER - define a driver XDPSQ cleanup timer callback
+ * @name: name of the function to define
+ * @poll: Tx polling/completion function
+ */
+#define LIBETH_XDP_DEFINE_TIMER(name, poll)				      \
+void name(struct work_struct *work)					      \
+{									      \
+	libeth_xdpsq_run_timer(work, poll);				      \
+}
+
+/**
+ * LIBETH_XDP_DEFINE_FLUSH_TX - define a driver ``XDP_TX`` bulk flush function
+ * @name: name of the function to define
+ * @prep: driver callback to clean an XDPSQ
+ * @xmit: driver callback to write a HW Tx descriptor
+ */
+#define LIBETH_XDP_DEFINE_FLUSH_TX(name, prep, xmit)			      \
+	__LIBETH_XDP_DEFINE_FLUSH_TX(name, prep, xmit, xdp)
+
+#define __LIBETH_XDP_DEFINE_FLUSH_TX(name, prep, xmit, pfx)		      \
+bool name(struct libeth_xdp_tx_bulk *bq, u32 flags)			      \
+{									      \
+	return libeth_##pfx##_tx_flush_bulk(bq, flags, prep, xmit);	      \
+}
+
+/**
+ * LIBETH_XDP_DEFINE_FLUSH_XMIT - define a driver XDP xmit bulk flush function
+ * @name: name of the function to define
+ * @prep: driver callback to clean an XDPSQ
+ * @xmit: driver callback to write a HW Tx descriptor
+ */
+#define LIBETH_XDP_DEFINE_FLUSH_XMIT(name, prep, xmit)			      \
+bool name(struct libeth_xdp_tx_bulk *bq, u32 flags)			      \
+{									      \
+	return libeth_xdp_xmit_flush_bulk(bq, flags, prep, xmit);	      \
+}
+
+/**
+ * LIBETH_XDP_DEFINE_RUN_PROG - define a driver XDP program run function
+ * @name: name of the function to define
+ * @flush: driver callback to flush an ``XDP_TX`` bulk
+ */
+#define LIBETH_XDP_DEFINE_RUN_PROG(name, flush)				      \
+	bool __LIBETH_XDP_DEFINE_RUN_PROG(name, flush, xdp)
+
+#define __LIBETH_XDP_DEFINE_RUN_PROG(name, flush, pfx)			      \
+name(struct libeth_xdp_buff *xdp, struct libeth_xdp_tx_bulk *bq)	      \
+{									      \
+	return libeth_##pfx##_run_prog(xdp, bq, flush);			      \
+}
+
+/**
+ * LIBETH_XDP_DEFINE_RUN_PASS - define a driver buffer process + pass function
+ * @name: name of the function to define
+ * @run: driver callback to run XDP program (above)
+ * @populate: driver callback to fill an skb with HW descriptor info
+ */
+#define LIBETH_XDP_DEFINE_RUN_PASS(name, run, populate)			      \
+	void __LIBETH_XDP_DEFINE_RUN_PASS(name, run, populate, xdp)
+
+#define __LIBETH_XDP_DEFINE_RUN_PASS(name, run, populate, pfx)		      \
+name(struct libeth_xdp_buff *xdp, struct libeth_xdp_tx_bulk *bq,	      \
+     struct napi_struct *napi, struct libeth_rq_napi_stats *ss,		      \
+     const void *desc)							      \
+{									      \
+	return libeth_##pfx##_run_pass(xdp, bq, napi, ss, desc, run,	      \
+				       populate);			      \
+}
+
+/**
+ * LIBETH_XDP_DEFINE_RUN - define a driver buffer process, run + pass function
+ * @name: name of the function to define
+ * @run: name of the XDP prog run function to define
+ * @flush: driver callback to flush an ``XDP_TX`` bulk
+ * @populate: driver callback to fill an skb with HW descriptor info
+ */
+#define LIBETH_XDP_DEFINE_RUN(name, run, flush, populate)		      \
+	__LIBETH_XDP_DEFINE_RUN(name, run, flush, populate, XDP)
+
+#define __LIBETH_XDP_DEFINE_RUN(name, run, flush, populate, pfx)	      \
+	LIBETH_##pfx##_DEFINE_RUN_PROG(static run, flush);		      \
+	LIBETH_##pfx##_DEFINE_RUN_PASS(name, run, populate)
+
+/**
+ * LIBETH_XDP_DEFINE_FINALIZE - define a driver Rx NAPI poll finalize function
+ * @name: name of the function to define
+ * @flush: driver callback to flush an ``XDP_TX`` bulk
+ * @finalize: driver callback to finalize an XDPSQ and run the timer
+ */
+#define LIBETH_XDP_DEFINE_FINALIZE(name, flush, finalize)		      \
+	__LIBETH_XDP_DEFINE_FINALIZE(name, flush, finalize, xdp)
+
+#define __LIBETH_XDP_DEFINE_FINALIZE(name, flush, finalize, pfx)	      \
+void name(struct libeth_xdp_tx_bulk *bq)				      \
+{									      \
+	libeth_##pfx##_finalize_rx(bq, flush, finalize);		      \
+}
+
+#define LIBETH_XDP_DEFINE_END()		__diag_pop()
+
 /* Tx buffer completion */
 
 void libeth_xdp_return_buff_bulk(const struct skb_shared_info *sinfo,
-- 
2.49.0


