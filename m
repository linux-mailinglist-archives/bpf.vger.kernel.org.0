Return-Path: <bpf+bounces-44774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29F49C7755
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3434F1F2945E
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651F9218D72;
	Wed, 13 Nov 2024 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHm1nVHV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC9421765C;
	Wed, 13 Nov 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511583; cv=none; b=lBUummcVNfVw07rPK98pglA4SctaQnc02L/+oWBZn9y0h/noDkap6nhX8X4u7t5s7TlkrxT4qJCL2lXpSneKmoJ4wc+HD0IJ71u7JL708N6ZEfCdd21s0Zk8BRSVtxukqu8xEB1MyX76LdEeCxdOQk2aLh9acU/I3+YjXwvhGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511583; c=relaxed/simple;
	bh=yQapM8Z6yjt5eraD6IRJE29fByu4DuXn52NNrsMvFrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFIxESapWnKbjRpTBWNjYWZKhnSY6TTEqwkk1ojIq9vuZQIJQnF6XdqUCXMPQZpoxBSOoLRIciyU2DTwB6hJUm4NdRfjX+x87SZc08pBaAEJ317bAhzLGnIhAz6xYSs4eWsFhfcXB/YyR/x50elFEht1wZ6jzvlNIHm4RsLbiy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHm1nVHV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511579; x=1763047579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQapM8Z6yjt5eraD6IRJE29fByu4DuXn52NNrsMvFrc=;
  b=eHm1nVHVmqo2j1GEkBcvi9rGFsuXB+21kG0yZHShiZ4Sdq9I45CRRtCY
   Zi5K7c8+N69cp9nWt4kDJS6EvRCsW6lEfkh71WZlQe7KtAcPs0Jfgo2wG
   FrNC2Y3w/e66BL90awX7MeusCDPDKKAPr1zOtPS7hw6ifXEMQUQg/+Ss8
   XxiYojs05SWBDHKztw1EQd0mipPGrvNc9P1g3JgVO5/hU0bT6ZOHKTVsh
   oqvTfIcPBwT3OZbIUsT9dmYwjQRYhzju+UWj3hMEcrUijepw2JG+Hj34G
   CfmU8Fh5g6JAjviGeLCiuDszsCJkwPNzItoN7YKs0TU/6DV6p0GY4iWrx
   A==;
X-CSE-ConnectionGUID: wtUfHETjSay9ki9oGgqT3g==
X-CSE-MsgGUID: foZvjWZFQz251e2Lbo+fCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799501"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799501"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:26:18 -0800
X-CSE-ConnectionGUID: kiFZVbiaTIuSjcCu5vXqqw==
X-CSE-MsgGUID: 3elDjs2lRpar9J2jZoQ6dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118727080"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:26:13 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 19/19] libeth: add a couple of XDP helpers (libeth_xdp)
Date: Wed, 13 Nov 2024 16:24:42 +0100
Message-ID: <20241113152442.4000468-20-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Couple" is a bit humbly... Add the following functionality to libeth:

* XDP shared queues managing
* XDP_TX bulk sending infra
* .ndo_xdp_xmit() infra
* adding buffers to &xdp_buff
* running XDP prog and managing its verdict
* completing XDP Tx buffers
* ^ repeat everything for XSk

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # lots of stuff
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/libeth/Kconfig  |    6 +
 drivers/net/ethernet/intel/libeth/Makefile |    6 +
 include/net/libeth/types.h                 |  102 +-
 drivers/net/ethernet/intel/libeth/priv.h   |   37 +
 include/net/libeth/tx.h                    |   34 +-
 include/net/libeth/xdp.h                   | 1861 ++++++++++++++++++++
 include/net/libeth/xsk.h                   |  684 +++++++
 drivers/net/ethernet/intel/libeth/rx.c     |    2 +-
 drivers/net/ethernet/intel/libeth/tx.c     |   39 +
 drivers/net/ethernet/intel/libeth/xdp.c    |  446 +++++
 drivers/net/ethernet/intel/libeth/xsk.c    |  264 +++
 11 files changed, 3477 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
 create mode 100644 include/net/libeth/xdp.h
 create mode 100644 include/net/libeth/xsk.h
 create mode 100644 drivers/net/ethernet/intel/libeth/tx.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xdp.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xsk.c

diff --git a/drivers/net/ethernet/intel/libeth/Kconfig b/drivers/net/ethernet/intel/libeth/Kconfig
index 480293b71dbc..80e99d044599 100644
--- a/drivers/net/ethernet/intel/libeth/Kconfig
+++ b/drivers/net/ethernet/intel/libeth/Kconfig
@@ -7,3 +7,9 @@ config LIBETH
 	help
 	  libeth is a common library containing routines shared between several
 	  drivers, but not yet promoted to the generic kernel API.
+
+config LIBETH_XDP
+	tristate
+	select LIBETH
+	help
+	  XDP and XSk helpers based on libeth hotpath management.
diff --git a/drivers/net/ethernet/intel/libeth/Makefile b/drivers/net/ethernet/intel/libeth/Makefile
index 52492b081132..8b01b2af54cf 100644
--- a/drivers/net/ethernet/intel/libeth/Makefile
+++ b/drivers/net/ethernet/intel/libeth/Makefile
@@ -4,3 +4,9 @@
 obj-$(CONFIG_LIBETH)		+= libeth.o
 
 libeth-y			:= rx.o
+libeth-y			+= tx.o
+
+obj-$(CONFIG_LIBETH_XDP)	+= libeth_xdp.o
+
+libeth_xdp-y			+= xdp.o
+libeth_xdp-y			+= xsk.o
diff --git a/include/net/libeth/types.h b/include/net/libeth/types.h
index 603825e45133..27ded729467a 100644
--- a/include/net/libeth/types.h
+++ b/include/net/libeth/types.h
@@ -4,7 +4,27 @@
 #ifndef __LIBETH_TYPES_H
 #define __LIBETH_TYPES_H
 
-#include <linux/types.h>
+#include <linux/workqueue.h>
+
+/* Stats */
+
+/**
+ * struct libeth_rq_napi_stats - "hot" counters to update in Rx polling loop
+ * @packets: received frames counter
+ * @bytes: sum of bytes of received frames above
+ * @fragments: sum of fragments of received S/G frames
+ * @raw: alias to access all the fields as an array
+ */
+struct libeth_rq_napi_stats {
+	union {
+		struct {
+							u32 packets;
+							u32 bytes;
+							u32 fragments;
+		};
+		DECLARE_FLEX_ARRAY(u32, raw);
+	};
+};
 
 /**
  * struct libeth_sq_napi_stats - "hot" counters to update in Tx completion loop
@@ -22,4 +42,84 @@ struct libeth_sq_napi_stats {
 	};
 };
 
+/**
+ * struct libeth_xdpsq_napi_stats - "hot" counters to update in XDP Tx
+ *				    completion loop
+ * @packets: completed frames counter
+ * @bytes: sum of bytes of completed frames above
+ * @fragments: sum of fragments of completed S/G frames
+ * @raw: alias to access all the fields as an array
+ */
+struct libeth_xdpsq_napi_stats {
+	union {
+		struct {
+							u32 packets;
+							u32 bytes;
+							u32 fragments;
+		};
+		DECLARE_FLEX_ARRAY(u32, raw);
+	};
+};
+
+/* XDP */
+
+/*
+ * The following structures should be embedded into driver's queue structure
+ * and passed to the libeth_xdp helpers, never used directly.
+ */
+
+/* XDPSQ sharing */
+
+/**
+ * struct libeth_xdpsq_lock - locking primitive for sharing XDPSQs
+ * @lock: spinlock for locking the queue
+ * @share: whether this particular queue is shared
+ */
+struct libeth_xdpsq_lock {
+	spinlock_t			lock;
+	bool				share;
+};
+
+/* XDPSQ clean-up timers */
+
+/**
+ * struct libeth_xdpsq_timer - timer for cleaning up XDPSQs w/o interrupts
+ * @xdpsq: queue this timer belongs to
+ * @lock: lock for the queue
+ * @dwork: work performing cleanups
+ *
+ * XDPSQs not using interrupts but lazy cleaning, i.e. only when there's no
+ * space for sending the current queued frame/bulk, must fire up timers to
+ * make sure there are no stale buffers to free.
+ */
+struct libeth_xdpsq_timer {
+	void				*xdpsq;
+	struct libeth_xdpsq_lock	*lock;
+
+	struct delayed_work		dwork;
+};
+
+/* Rx polling path */
+
+/**
+ * struct libeth_xdp_buff_stash - struct for stashing &xdp_buff onto a queue
+ * @data: pointer to the start of the frame, xdp_buff.data
+ * @headroom: frame headroom, xdp_buff.data - xdp_buff.data_hard_start
+ * @len: frame linear space length, xdp_buff.data_end - xdp_buff.data
+ * @frame_sz: truesize occupied by the frame, xdp_buff.frame_sz
+ * @flags: xdp_buff.flags
+ *
+ * &xdp_buff is 56 bytes long on x64, &libeth_xdp_buff is 64 bytes. This
+ * structure carries only necessary fields to save/restore a partially built
+ * frame on the queue structure to finish it during the next NAPI poll.
+ */
+struct libeth_xdp_buff_stash {
+	void				*data;
+	u16				headroom;
+	u16				len;
+
+	u32				frame_sz:24;
+	u32				flags:8;
+} __aligned_largest;
+
 #endif /* __LIBETH_TYPES_H */
diff --git a/drivers/net/ethernet/intel/libeth/priv.h b/drivers/net/ethernet/intel/libeth/priv.h
new file mode 100644
index 000000000000..b9171461186e
--- /dev/null
+++ b/drivers/net/ethernet/intel/libeth/priv.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef __LIBETH_PRIV_H
+#define __LIBETH_PRIV_H
+
+#include <linux/types.h>
+
+/* XDP */
+
+enum xdp_action;
+struct libeth_xdp_buff;
+struct libeth_xdp_tx_frame;
+struct skb_shared_info;
+struct xdp_frame_bulk;
+
+extern const struct xsk_tx_metadata_ops libeth_xsktmo_slow;
+
+void libeth_xsk_tx_return_bulk(const struct libeth_xdp_tx_frame *bq,
+			       u32 count);
+u32 libeth_xsk_prog_exception(struct libeth_xdp_buff *xdp, enum xdp_action act,
+			      int ret);
+
+struct libeth_xdp_ops {
+	void	(*bulk)(const struct skb_shared_info *sinfo,
+			struct xdp_frame_bulk *bq, bool frags);
+	void	(*xsk)(struct libeth_xdp_buff *xdp);
+};
+
+void libeth_attach_xdp(const struct libeth_xdp_ops *ops);
+
+static inline void libeth_detach_xdp(void)
+{
+	libeth_attach_xdp(NULL);
+}
+
+#endif /* __LIBETH_PRIV_H */
diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
index 35614f9523f6..63a76ab7746d 100644
--- a/include/net/libeth/tx.h
+++ b/include/net/libeth/tx.h
@@ -12,11 +12,17 @@
 
 /**
  * enum libeth_sqe_type - type of &libeth_sqe to act on Tx completion
- * @LIBETH_SQE_EMPTY: unused/empty, no action required
+ * @LIBETH_SQE_EMPTY: unused/empty OR XDP_TX/XSk frame, no action required
  * @LIBETH_SQE_CTX: context descriptor with empty SQE, no action required
  * @LIBETH_SQE_SLAB: kmalloc-allocated buffer, unmap and kfree()
  * @LIBETH_SQE_FRAG: mapped skb frag, only unmap DMA
  * @LIBETH_SQE_SKB: &sk_buff, unmap and napi_consume_skb(), update stats
+ * @__LIBETH_SQE_XDP_START: separator between skb and XDP types
+ * @LIBETH_SQE_XDP_TX: &skb_shared_info, libeth_xdp_return_buff_bulk(), stats
+ * @LIBETH_SQE_XDP_XMIT: &xdp_frame, unmap and xdp_return_frame_bulk(), stats
+ * @LIBETH_SQE_XDP_XMIT_FRAG: &xdp_frame frag, only unmap DMA
+ * @LIBETH_SQE_XSK_TX: &libeth_xdp_buff on XSk queue, xsk_buff_free(), stats
+ * @LIBETH_SQE_XSK_TX_FRAG: &libeth_xdp_buff frag on XSk queue, xsk_buff_free()
  */
 enum libeth_sqe_type {
 	LIBETH_SQE_EMPTY		= 0U,
@@ -24,6 +30,13 @@ enum libeth_sqe_type {
 	LIBETH_SQE_SLAB,
 	LIBETH_SQE_FRAG,
 	LIBETH_SQE_SKB,
+
+	__LIBETH_SQE_XDP_START,
+	LIBETH_SQE_XDP_TX		= __LIBETH_SQE_XDP_START,
+	LIBETH_SQE_XDP_XMIT,
+	LIBETH_SQE_XDP_XMIT_FRAG,
+	LIBETH_SQE_XSK_TX,
+	LIBETH_SQE_XSK_TX_FRAG,
 };
 
 /**
@@ -32,6 +45,9 @@ enum libeth_sqe_type {
  * @rs_idx: index of the last buffer from the batch this one was sent in
  * @raw: slab buffer to free via kfree()
  * @skb: &sk_buff to consume
+ * @sinfo: skb shared info of an XDP_TX frame
+ * @xdpf: XDP frame from ::ndo_xdp_xmit()
+ * @xsk: XSk Rx frame from XDP_TX action
  * @dma: DMA address to unmap
  * @len: length of the mapped region to unmap
  * @nr_frags: number of frags in the frame this buffer belongs to
@@ -46,6 +62,9 @@ struct libeth_sqe {
 	union {
 		void				*raw;
 		struct sk_buff			*skb;
+		struct skb_shared_info		*sinfo;
+		struct xdp_frame		*xdpf;
+		struct libeth_xdp_buff		*xsk;
 	};
 
 	DEFINE_DMA_UNMAP_ADDR(dma);
@@ -71,7 +90,10 @@ struct libeth_sqe {
 /**
  * struct libeth_cq_pp - completion queue poll params
  * @dev: &device to perform DMA unmapping
+ * @bq: XDP frame bulk to combine return operations
  * @ss: onstack NAPI stats to fill
+ * @xss: onstack XDPSQ NAPI stats to fill
+ * @xdp_tx: number of XDP-not-XSk frames processed
  * @napi: whether it's called from the NAPI context
  *
  * libeth uses this structure to access objects needed for performing full
@@ -80,7 +102,13 @@ struct libeth_sqe {
  */
 struct libeth_cq_pp {
 	struct device			*dev;
-	struct libeth_sq_napi_stats	*ss;
+	struct xdp_frame_bulk		*bq;
+
+	union {
+		struct libeth_sq_napi_stats	*ss;
+		struct libeth_xdpsq_napi_stats	*xss;
+	};
+	u32				xdp_tx;
 
 	bool				napi;
 };
@@ -126,4 +154,6 @@ static inline void libeth_tx_complete(struct libeth_sqe *sqe,
 	sqe->type = LIBETH_SQE_EMPTY;
 }
 
+void libeth_tx_complete_any(struct libeth_sqe *sqe, struct libeth_cq_pp *cp);
+
 #endif /* __LIBETH_TX_H */
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
new file mode 100644
index 000000000000..fc43093f74ce
--- /dev/null
+++ b/include/net/libeth/xdp.h
@@ -0,0 +1,1861 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef __LIBETH_XDP_H
+#define __LIBETH_XDP_H
+
+#include <linux/bpf_trace.h>
+#include <linux/unroll.h>
+
+#include <net/libeth/rx.h>
+#include <net/libeth/tx.h>
+#include <net/xsk_buff_pool.h>
+
+/* Defined as bits to be able to use them as a mask */
+enum {
+	LIBETH_XDP_PASS			= 0U,
+	LIBETH_XDP_DROP			= BIT(0),
+	LIBETH_XDP_ABORTED		= BIT(1),
+	LIBETH_XDP_TX			= BIT(2),
+	LIBETH_XDP_REDIRECT		= BIT(3),
+};
+
+/*
+ * &xdp_buff_xsk is the largest structure &libeth_xdp_buff gets casted to,
+ * pick maximum pointer-compatible alignment.
+ */
+#define __LIBETH_XDP_BUFF_ALIGN						      \
+	(IS_ALIGNED(sizeof(struct xdp_buff_xsk), 16) ? 16 :		      \
+	 IS_ALIGNED(sizeof(struct xdp_buff_xsk), 8) ? 8 :		      \
+	 sizeof(long))
+
+/**
+ * struct libeth_xdp_buff - libeth extension over &xdp_buff
+ * @base: main &xdp_buff
+ * @data: shortcut for @base.data
+ * @desc: RQ descriptor containing metadata for this buffer
+ * @priv: driver-private scratchspace
+ *
+ * The main reason for this is to have a pointer to the descriptor to be able
+ * to quickly get frame metadata from xdpmo and driver buff-to-xdp callbacks
+ * (as well as bigger alignment).
+ * Pointer/layout-compatible with &xdp_buff and &xdp_buff_xsk.
+ */
+struct libeth_xdp_buff {
+	union {
+		struct xdp_buff		base;
+		void			*data;
+	};
+
+	const void			*desc;
+	unsigned long			priv[]
+					__aligned(__LIBETH_XDP_BUFF_ALIGN);
+} __aligned(__LIBETH_XDP_BUFF_ALIGN);
+static_assert(offsetof(struct libeth_xdp_buff, data) ==
+	      offsetof(struct xdp_buff_xsk, xdp.data));
+static_assert(offsetof(struct libeth_xdp_buff, desc) ==
+	      offsetof(struct xdp_buff_xsk, cb));
+static_assert(IS_ALIGNED(sizeof(struct xdp_buff_xsk),
+			 __alignof(struct libeth_xdp_buff)));
+
+/**
+ * __LIBETH_XDP_ONSTACK_BUFF - declare a &libeth_xdp_buff on the stack
+ * @name: name of the variable to declare
+ * @...: sizeof() of the driver-private data
+ */
+#define __LIBETH_XDP_ONSTACK_BUFF(name, ...)				      \
+	___LIBETH_XDP_ONSTACK_BUFF(name, ##__VA_ARGS__)
+/**
+ * LIBETH_XDP_ONSTACK_BUFF - declare a &libeth_xdp_buff on the stack
+ * @name: name of the variable to declare
+ * @...: type or variable name of the driver-private data
+ */
+#define LIBETH_XDP_ONSTACK_BUFF(name, ...)				      \
+	__LIBETH_XDP_ONSTACK_BUFF(name, __libeth_xdp_priv_sz(__VA_ARGS__))
+
+#define ___LIBETH_XDP_ONSTACK_BUFF(name, ...)				      \
+	_DEFINE_FLEX(struct libeth_xdp_buff, name, priv,		      \
+		     LIBETH_XDP_PRIV_SZ(__VA_ARGS__ + 0),		      \
+		     /* no init */);					      \
+	LIBETH_XDP_ASSERT_PRIV_SZ(__VA_ARGS__ + 0)
+
+#define __libeth_xdp_priv_sz(...)					      \
+	CONCATENATE(__libeth_xdp_psz, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
+
+#define __libeth_xdp_psz0(...)
+#define __libeth_xdp_psz1(...)		sizeof(__VA_ARGS__)
+
+#define LIBETH_XDP_PRIV_SZ(sz)						      \
+	(ALIGN(sz, __alignof(struct libeth_xdp_buff)) / sizeof(long))
+
+/* Performs XSK_CHECK_PRIV_TYPE() */
+#define LIBETH_XDP_ASSERT_PRIV_SZ(sz)					      \
+	static_assert(offsetofend(struct xdp_buff_xsk, cb) >=		      \
+		      struct_size_t(struct libeth_xdp_buff, priv,	      \
+				    LIBETH_XDP_PRIV_SZ(sz)))
+
+/* XDPSQ sharing */
+
+DECLARE_STATIC_KEY_FALSE(libeth_xdpsq_share);
+
+/**
+ * libeth_xdpsq_num - calculate optimal number of XDPSQs for this device + sys
+ * @rxq: current number of active Rx queues
+ * @txq: current number of active Tx queues
+ * @max: maximum number of Tx queues
+ *
+ * Each RQ must have its own XDPSQ for XSk pairs, each CPU must have own XDPSQ
+ * for lockless sending (``XDP_TX``, .ndo_xdp_xmit()). Cap the maximum of these
+ * two with the number of SQs the device can have (minus used ones).
+ *
+ * Return: number of XDP Tx queues the device needs to use.
+ */
+static inline u32 libeth_xdpsq_num(u32 rxq, u32 txq, u32 max)
+{
+	return min(max(nr_cpu_ids, rxq), max - txq);
+}
+
+/**
+ * libeth_xdpsq_shared - whether XDPSQs can be shared between several CPUs
+ * @num: number of active XDPSQs
+ *
+ * Return: true if there's no 1:1 XDPSQ/CPU association, false otherwise.
+ */
+static inline bool libeth_xdpsq_shared(u32 num)
+{
+	return num < nr_cpu_ids;
+}
+
+/**
+ * libeth_xdpsq_id - get XDPSQ index corresponding to this CPU
+ * @qid: number of active XDPSQs
+ *
+ * Helper for libeth_xdp routines, do not use in drivers directly.
+ *
+ * Return: XDPSQ index needs to be used on this CPU.
+ */
+static inline u32 libeth_xdpsq_id(u32 qid)
+{
+	u32 ret = raw_smp_processor_id();
+
+	if (static_branch_unlikely(&libeth_xdpsq_share) &&
+	    libeth_xdpsq_shared(qid))
+		ret %= qid;
+
+	return ret;
+}
+
+void __libeth_xdpsq_get(struct libeth_xdpsq_lock *lock,
+			const struct net_device *dev);
+void __libeth_xdpsq_put(struct libeth_xdpsq_lock *lock,
+			const struct net_device *dev);
+
+#define libeth_xdpsq_get_start		cpus_read_lock
+#define libeth_xdpsq_get_end		cpus_read_unlock
+
+/**
+ * libeth_xdpsq_get - initialize a &libeth_xdpsq_lock
+ * @lock: lock to initialize
+ * @dev: netdev which this lock belongs to
+ * @share: whether XDPSQs can be shared
+ *
+ * Must be called only inside a libeth_xdpsq_get_{start,put}() block.
+ * Tracks the current XDPSQ association and enables the static lock
+ * if needed.
+ */
+static inline void libeth_xdpsq_get(struct libeth_xdpsq_lock *lock,
+				    const struct net_device *dev,
+				    bool share)
+{
+	if (unlikely(share))
+		__libeth_xdpsq_get(lock, dev);
+}
+
+/**
+ * libeth_xdpsq_put - deinitialize a &libeth_xdpsq_lock
+ * @lock: lock to deinitialize
+ * @dev: netdev which this lock belongs to
+ *
+ * Must be called only inside a libeth_xdpsq_get_{start,put}() block.
+ * Tracks the current XDPSQ association and disables the static lock
+ * if needed.
+ */
+static inline void libeth_xdpsq_put(struct libeth_xdpsq_lock *lock,
+				    const struct net_device *dev)
+{
+	if (static_branch_unlikely(&libeth_xdpsq_share) && lock->share)
+		__libeth_xdpsq_put(lock, dev);
+}
+
+void __libeth_xdpsq_lock(struct libeth_xdpsq_lock *lock);
+void __libeth_xdpsq_unlock(struct libeth_xdpsq_lock *lock);
+
+/**
+ * libeth_xdpsq_lock - grab a &libeth_xdpsq_lock if needed
+ * @lock: lock to take
+ *
+ * Touches the underlying spinlock only if the static key is enabled
+ * and the queue itself is marked as shareable.
+ */
+static inline void libeth_xdpsq_lock(struct libeth_xdpsq_lock *lock)
+{
+	if (static_branch_unlikely(&libeth_xdpsq_share) && lock->share)
+		__libeth_xdpsq_lock(lock);
+}
+
+/**
+ * libeth_xdpsq_unlock - free a &libeth_xdpsq_lock if needed
+ * @lock: lock to free
+ *
+ * Touches the underlying spinlock only if the static key is enabled
+ * and the queue itself is marked as shareable.
+ */
+static inline void libeth_xdpsq_unlock(struct libeth_xdpsq_lock *lock)
+{
+	if (static_branch_unlikely(&libeth_xdpsq_share) && lock->share)
+		__libeth_xdpsq_unlock(lock);
+}
+
+/* XDPSQ clean-up timers */
+
+void libeth_xdpsq_init_timer(struct libeth_xdpsq_timer *timer, void *xdpsq,
+			     struct libeth_xdpsq_lock *lock,
+			     void (*poll)(struct work_struct *work));
+
+/**
+ * libeth_xdpsq_deinit_timer - deinitialize a &libeth_xdpsq_timer
+ * @timer: timer to deinitialize
+ *
+ * Flush and disable the underlying workqueue.
+ */
+static inline void libeth_xdpsq_deinit_timer(struct libeth_xdpsq_timer *timer)
+{
+	cancel_delayed_work_sync(&timer->dwork);
+}
+
+/**
+ * libeth_xdpsq_queue_timer - run a &libeth_xdpsq_timer
+ * @timer: timer to queue
+ *
+ * Should be called after the queue was filled and the transmission was run
+ * to complete the pending buffers if no further sending will be done in a
+ * second (-> lazy cleaning won't happen).
+ * If the timer was already run, it will be requeued back to one second
+ * timeout again.
+ */
+static inline void libeth_xdpsq_queue_timer(struct libeth_xdpsq_timer *timer)
+{
+	mod_delayed_work_on(raw_smp_processor_id(), system_bh_highpri_wq,
+			    &timer->dwork, HZ);
+}
+
+/**
+ * libeth_xdpsq_run_timer - wrapper to run a queue clean-up on a timer event
+ * @work: workqueue belonging to the corresponding timer
+ * @poll: driver-specific completion queue poll function
+ *
+ * Run the polling function on the locked queue and requeue the timer if
+ * there's more work to do.
+ * Designed to be used via LIBETH_XDP_DEFINE_TIMER() below.
+ */
+static __always_inline void
+libeth_xdpsq_run_timer(struct work_struct *work,
+		       u32 (*poll)(void *xdpsq, u32 budget))
+{
+	struct libeth_xdpsq_timer *timer = container_of(work, typeof(*timer),
+							dwork.work);
+
+	libeth_xdpsq_lock(timer->lock);
+
+	if (poll(timer->xdpsq, U32_MAX))
+		libeth_xdpsq_queue_timer(timer);
+
+	libeth_xdpsq_unlock(timer->lock);
+}
+
+/* Common Tx bits */
+
+/**
+ * enum - libeth_xdp internal Tx flags
+ * @LIBETH_XDP_TX_BULK: one bulk size at which it will be flushed to the queue
+ * @LIBETH_XDP_TX_BATCH: batch size for which the queue fill loop is unrolled
+ * @LIBETH_XDP_TX_DROP: indicates the send function must drop frames not sent
+ * @LIBETH_XDP_TX_NDO: whether the send function is called from .ndo_xdp_xmit()
+ * @LIBETH_XDP_TX_XSK: whether the function is called for ``XDP_TX`` for XSk
+ */
+enum {
+	LIBETH_XDP_TX_BULK		= DEV_MAP_BULK_SIZE,
+	LIBETH_XDP_TX_BATCH		= 8,
+
+	LIBETH_XDP_TX_DROP		= BIT(0),
+	LIBETH_XDP_TX_NDO		= BIT(1),
+	LIBETH_XDP_TX_XSK		= BIT(2),
+};
+
+/**
+ * enum - &libeth_xdp_tx_frame and &libeth_xdp_tx_desc flags
+ * @LIBETH_XDP_TX_LEN: only for ``XDP_TX``, [15:0] of ::len_fl is actual length
+ * @LIBETH_XDP_TX_CSUM: for XSk xmit, enable checksum offload
+ * @LIBETH_XDP_TX_XSKMD: for XSk xmit, mask of the metadata bits
+ * @LIBETH_XDP_TX_FIRST: indicates the frag is the first one of the frame
+ * @LIBETH_XDP_TX_LAST: whether the frag is the last one of the frame
+ * @LIBETH_XDP_TX_MULTI: whether the frame contains several frags
+ * @LIBETH_XDP_TX_FLAGS: only for ``XDP_TX``, [31:16] of ::len_fl is flags
+ */
+enum {
+	LIBETH_XDP_TX_LEN		= GENMASK(15, 0),
+
+	LIBETH_XDP_TX_CSUM		= XDP_TXMD_FLAGS_CHECKSUM,
+	LIBETH_XDP_TX_XSKMD		= LIBETH_XDP_TX_LEN,
+
+	LIBETH_XDP_TX_FIRST		= BIT(16),
+	LIBETH_XDP_TX_LAST		= BIT(17),
+	LIBETH_XDP_TX_MULTI		= BIT(18),
+
+	LIBETH_XDP_TX_FLAGS		= GENMASK(31, 16),
+};
+
+/**
+ * struct libeth_xdp_tx_frame - represents one XDP Tx element
+ * @data: frame start pointer for ``XDP_TX``
+ * @len_fl: ``XDP_TX``, combined flags [31:16] and len [15:0] field for speed
+ * @soff: ``XDP_TX``, offset from @data to the start of &skb_shared_info
+ * @frag: one (non-head) frag for ``XDP_TX``
+ * @xdpf: &xdp_frame for the head frag for .ndo_xdp_xmit()
+ * @dma: DMA address of the non-head frag for .ndo_xdp_xmit()
+ * @xsk: ``XDP_TX`` for XSk, XDP buffer for any frag
+ * @len: frag length for XSk ``XDP_TX`` and .ndo_xdp_xmit()
+ * @flags: Tx flags for the above
+ * @opts: combined @len + @flags for the above for speed
+ * @desc: XSk xmit descriptor for direct casting
+ */
+struct libeth_xdp_tx_frame {
+	union {
+		/* ``XDP_TX`` */
+		struct {
+			void				*data;
+			u32				len_fl;
+			u32				soff;
+		};
+
+		/* ``XDP_TX`` frag */
+		skb_frag_t			frag;
+
+		/* .ndo_xdp_xmit(), XSk ``XDP_TX`` */
+		struct {
+			union {
+				struct xdp_frame		*xdpf;
+				dma_addr_t			dma;
+
+				struct libeth_xdp_buff		*xsk;
+			};
+			union {
+				struct {
+					u32				len;
+					u32				flags;
+				};
+				aligned_u64			opts;
+			};
+		};
+
+		/* XSk xmit */
+		struct xdp_desc			desc;
+	};
+} __aligned(sizeof(struct xdp_desc));
+static_assert(offsetof(struct libeth_xdp_tx_frame, frag.len) ==
+	      offsetof(struct libeth_xdp_tx_frame, len_fl));
+static_assert(sizeof(struct libeth_xdp_tx_frame) == sizeof(struct xdp_desc));
+
+/**
+ * struct libeth_xdp_tx_bulk - XDP Tx frame bulk for bulk sending
+ * @prog: corresponding active XDP program, %NULL for .ndo_xdp_xmit()
+ * @dev: &net_device which the frames are transmitted on
+ * @xdpsq: shortcut to the corresponding driver-specific XDPSQ structure
+ * @act_mask: Rx only, mask of all the XDP prog verdicts for that NAPI session
+ * @count: current number of frames in @bulk
+ * @bulk: array of queued frames for bulk Tx
+ *
+ * All XDP Tx operations except XSk xmit queue each frame to the bulk first
+ * and flush it when @count reaches the array end. Bulk is always placed on
+ * the stack for performance. One bulk element contains all the data necessary
+ * for sending a frame and then freeing it on completion.
+ * For XSk xmit, Tx descriptor array from &xsk_buff_pool is casted directly
+ * to &libeth_xdp_tx_frame as they are compatible and the bulk structure is
+ * not used.
+ */
+struct libeth_xdp_tx_bulk {
+	const struct bpf_prog		*prog;
+	struct net_device		*dev;
+	void				*xdpsq;
+
+	u32				act_mask;
+	u32				count;
+	struct libeth_xdp_tx_frame	bulk[LIBETH_XDP_TX_BULK];
+} __aligned(sizeof(struct libeth_xdp_tx_frame));
+
+/**
+ * struct libeth_xdpsq - abstraction for an XDPSQ
+ * @pool: XSk buffer pool for XSk ``XDP_TX`` and xmit
+ * @sqes: array of Tx buffers from the actual queue struct
+ * @descs: opaque pointer to the HW descriptor array
+ * @ntu: pointer to the next free descriptor index
+ * @count: number of descriptors on that queue
+ * @pending: pointer to the number of sent-not-completed descs on that queue
+ * @xdp_tx: pointer to the above, but only for non-XSk-xmit frames
+ * @lock: corresponding XDPSQ lock
+ *
+ * Abstraction for driver-independent implementation of Tx. Placed on the stack
+ * and filled by the driver before the transmission, so that the generic
+ * functions can access and modify driver-specific resources.
+ */
+struct libeth_xdpsq {
+	struct xsk_buff_pool		*pool;
+	struct libeth_sqe		*sqes;
+	void				*descs;
+
+	u32				*ntu;
+	u32				count;
+
+	u32				*pending;
+	u32				*xdp_tx;
+	struct libeth_xdpsq_lock	*lock;
+};
+
+/**
+ * struct libeth_xdp_tx_desc - abstraction for an XDP Tx descriptor
+ * @addr: DMA address of the frame
+ * @len: length of the frame
+ * @flags: XDP Tx flags
+ * @opts: combined @len + @flags for speed
+ *
+ * Filled by the generic functions and then passed to driver-specific functions
+ * to fill a HW Tx descriptor, always placed on the [function] stack.
+ */
+struct libeth_xdp_tx_desc {
+	dma_addr_t			addr;
+	union {
+		struct {
+			u32				len;
+			u32				flags;
+		};
+		aligned_u64			opts;
+	};
+} __aligned_largest;
+
+/**
+ * libeth_xdp_ptr_to_priv - convert a pointer to a libeth_xdp u64 priv
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
+ * libeth_xdp_priv_to_ptr - convert a libeth_xdp u64 priv to a pointer
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
+/*
+ * On 64-bit systems, assigning one u64 is faster than two u32s. When ::len
+ * occupies lowest 32 bits (LE), whole ::opts can be assigned directly instead.
+ */
+#ifdef __LITTLE_ENDIAN
+#define __LIBETH_WORD_ACCESS		1
+#endif
+#ifdef __LIBETH_WORD_ACCESS
+#define __libeth_xdp_tx_len(flen, ...)					      \
+	.opts = ((flen) | FIELD_PREP(GENMASK_ULL(63, 32), (__VA_ARGS__ + 0)))
+#else
+#define __libeth_xdp_tx_len(flen, ...)					      \
+	.len = (flen), .flags = (__VA_ARGS__ + 0)
+#endif
+
+/**
+ * libeth_xdp_tx_xmit_bulk - main XDP Tx function
+ * @bulk: array of frames to send
+ * @xdpsq: pointer to the driver-specific XDPSQ struct
+ * @n: number of frames to send
+ * @unroll: whether to unroll the queue filling loop for speed
+ * @priv: driver-specific private data
+ * @prep: callback for cleaning the queue and filling abstract &libeth_xdpsq
+ * @fill: internal callback for filling &libeth_sqe and &libeth_xdp_tx_desc
+ * @xmit: callback for filling a HW descriptor with the frame info
+ *
+ * Internal abstraction for placing @n XDP Tx frames on the HW XDPSQ. Used for
+ * all types of frames: ``XDP_TX``, .ndo_xdp_xmit(), XSk ``XDP_TX`` and XSk
+ * xmit.
+ * @prep must lock the queue as this function releases it at the end. @unroll
+ * greatly increases the object code size, but also greatly increases XSk xmit
+ * performance; for other types of frames, it's not enabled.
+ * The compilers inline all those onstack abstractions to direct data accesses.
+ *
+ * Return: number of frames actually placed on the queue, <= @n. The function
+ * can't fail, but can send less frames if there's no enough free descriptors
+ * available. The actual free space is returned by @prep from the driver.
+ */
+static __always_inline u32
+libeth_xdp_tx_xmit_bulk(const struct libeth_xdp_tx_frame *bulk, void *xdpsq,
+			u32 n, bool unroll, u64 priv,
+			u32 (*prep)(void *xdpsq, struct libeth_xdpsq *sq),
+			struct libeth_xdp_tx_desc
+			(*fill)(struct libeth_xdp_tx_frame frm, u32 i,
+				const struct libeth_xdpsq *sq, u64 priv),
+			void (*xmit)(struct libeth_xdp_tx_desc desc, u32 i,
+				     const struct libeth_xdpsq *sq, u64 priv))
+{
+	u32 this, batched, off = 0;
+	struct libeth_xdpsq sq;
+	u32 ntu, i = 0;
+
+	n = min(n, prep(xdpsq, &sq));
+	if (unlikely(!n))
+		goto unlock;
+
+	ntu = *sq.ntu;
+
+	this = sq.count - ntu;
+	if (likely(this > n))
+		this = n;
+
+again:
+	if (!unroll)
+		goto linear;
+
+	batched = ALIGN_DOWN(this, LIBETH_XDP_TX_BATCH);
+
+	for ( ; i < off + batched; i += LIBETH_XDP_TX_BATCH) {
+		u32 base = ntu + i - off;
+
+		unrolled_count(LIBETH_XDP_TX_BATCH)
+		for (u32 j = 0; j < LIBETH_XDP_TX_BATCH; j++)
+			xmit(fill(bulk[i + j], base + j, &sq, priv),
+			     base + j, &sq, priv);
+	}
+
+	if (batched < this) {
+linear:
+		for ( ; i < off + this; i++)
+			xmit(fill(bulk[i], ntu + i - off, &sq, priv),
+			     ntu + i - off, &sq, priv);
+	}
+
+	ntu += this;
+	if (likely(ntu < sq.count))
+		goto out;
+
+	ntu = 0;
+
+	if (i < n) {
+		this = n - i;
+		off = i;
+
+		goto again;
+	}
+
+out:
+	*sq.ntu = ntu;
+	*sq.pending += n;
+	if (sq.xdp_tx)
+		*sq.xdp_tx += n;
+
+unlock:
+	libeth_xdpsq_unlock(sq.lock);
+
+	return n;
+}
+
+/* ``XDP_TX`` bulking */
+
+void libeth_xdp_return_buff_slow(struct libeth_xdp_buff *xdp);
+
+/**
+ * libeth_xdp_tx_queue_head - internal helper for queueing one ``XDP_TX`` head
+ * @bq: XDP Tx bulk to queue the head frag to
+ * @xdp: XDP buffer with the head to queue
+ *
+ * Return: false if it's the only frag of the frame, true if it's an S/G frame.
+ */
+static inline bool libeth_xdp_tx_queue_head(struct libeth_xdp_tx_bulk *bq,
+					    const struct libeth_xdp_buff *xdp)
+{
+	const struct xdp_buff *base = &xdp->base;
+
+	bq->bulk[bq->count++] = (typeof(*bq->bulk)){
+		.data	= xdp->data,
+		.len_fl	= (base->data_end - xdp->data) | LIBETH_XDP_TX_FIRST,
+		.soff	= xdp_data_hard_end(base) - xdp->data,
+	};
+
+	if (!xdp_buff_has_frags(base))
+		return false;
+
+	bq->bulk[bq->count - 1].len_fl |= LIBETH_XDP_TX_MULTI;
+
+	return true;
+}
+
+/**
+ * libeth_xdp_tx_queue_frag - internal helper for queueing one ``XDP_TX`` frag
+ * @bq: XDP Tx bulk to queue the frag to
+ * @frag: frag to queue
+ */
+static inline void libeth_xdp_tx_queue_frag(struct libeth_xdp_tx_bulk *bq,
+					    const skb_frag_t *frag)
+{
+	bq->bulk[bq->count++].frag = *frag;
+}
+
+/**
+ * libeth_xdp_tx_queue_bulk - internal helper for queueing one ``XDP_TX`` frame
+ * @bq: XDP Tx bulk to queue the frame to
+ * @xdp: XDP buffer to queue
+ * @flush_bulk: driver callback to flush the bulk to the HW queue
+ *
+ * Return: true on success, false on flush error.
+ */
+static __always_inline bool
+libeth_xdp_tx_queue_bulk(struct libeth_xdp_tx_bulk *bq,
+			 struct libeth_xdp_buff *xdp,
+			 bool (*flush_bulk)(struct libeth_xdp_tx_bulk *bq,
+					    u32 flags))
+{
+	const struct skb_shared_info *sinfo;
+	bool ret = true;
+	u32 nr_frags;
+
+	if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
+	    unlikely(!flush_bulk(bq, 0))) {
+		libeth_xdp_return_buff_slow(xdp);
+		return false;
+	}
+
+	if (!libeth_xdp_tx_queue_head(bq, xdp))
+		goto out;
+
+	sinfo = xdp_get_shared_info_from_buff(&xdp->base);
+	nr_frags = sinfo->nr_frags;
+
+	for (u32 i = 0; i < nr_frags; i++) {
+		if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
+		    unlikely(!flush_bulk(bq, 0))) {
+			ret = false;
+			break;
+		}
+
+		libeth_xdp_tx_queue_frag(bq, &sinfo->frags[i]);
+	}
+
+out:
+	bq->bulk[bq->count - 1].len_fl |= LIBETH_XDP_TX_LAST;
+	xdp->data = NULL;
+
+	return ret;
+}
+
+/**
+ * libeth_xdp_tx_fill_stats - fill a &libeth_sqe with ``XDP_TX`` frame stats
+ * @sqe: SQ element to fill
+ * @desc: libeth_xdp Tx descriptor
+ * @sinfo: &skb_shared_info for this frame
+ *
+ * Internal helper for filling an SQE with the frame stats, do not use in
+ * drivers. Fills the number of frags and bytes for this frame.
+ */
+#define libeth_xdp_tx_fill_stats(sqe, desc, sinfo)			      \
+	__libeth_xdp_tx_fill_stats(sqe, desc, sinfo, __UNIQUE_ID(sqe_),	      \
+				   __UNIQUE_ID(desc_), __UNIQUE_ID(sinfo_))
+
+#define __libeth_xdp_tx_fill_stats(sqe, desc, sinfo, ue, ud, us) do {	      \
+	const struct libeth_xdp_tx_desc *ud = (desc);			      \
+	const struct skb_shared_info *us;				      \
+	struct libeth_sqe *ue = (sqe);					      \
+									      \
+	ue->nr_frags = 1;						      \
+	ue->bytes = ud->len;						      \
+									      \
+	if (ud->flags & LIBETH_XDP_TX_MULTI) {				      \
+		us = (sinfo);						      \
+		ue->nr_frags += us->nr_frags;				      \
+		ue->bytes += us->xdp_frags_size;			      \
+	}								      \
+} while (0)
+
+/**
+ * libeth_xdp_tx_fill_buf - internal helper to fill one ``XDP_TX`` &libeth_sqe
+ * @frm: XDP Tx frame from the bulk
+ * @i: index on the HW queue
+ * @sq: XDPSQ abstraction for the queue
+ * @priv: private data
+ *
+ * Return: XDP Tx descriptor with the synced DMA and other info to pass to
+ * the driver callback.
+ */
+static inline struct libeth_xdp_tx_desc
+libeth_xdp_tx_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
+		       const struct libeth_xdpsq *sq, u64 priv)
+{
+	struct libeth_xdp_tx_desc desc;
+	struct skb_shared_info *sinfo;
+	skb_frag_t *frag = &frm.frag;
+	struct libeth_sqe *sqe;
+
+	if (frm.len_fl & LIBETH_XDP_TX_FIRST) {
+		sinfo = frm.data + frm.soff;
+		skb_frag_fill_page_desc(frag, virt_to_page(frm.data),
+					offset_in_page(frm.data),
+					frm.len_fl);
+	} else {
+		sinfo = NULL;
+	}
+
+	desc = (typeof(desc)){
+		.addr	= page_pool_get_dma_addr(skb_frag_page(frag)) +
+			  skb_frag_off(frag),
+		.len	= skb_frag_size(frag) & LIBETH_XDP_TX_LEN,
+		.flags	= skb_frag_size(frag) & LIBETH_XDP_TX_FLAGS,
+	};
+
+	dma_sync_single_for_device(skb_frag_page(frag)->pp->p.dev, desc.addr,
+				   desc.len, DMA_BIDIRECTIONAL);
+
+	if (!sinfo)
+		return desc;
+
+	sqe = &sq->sqes[i];
+	sqe->type = LIBETH_SQE_XDP_TX;
+	sqe->sinfo = sinfo;
+	libeth_xdp_tx_fill_stats(sqe, &desc, sinfo);
+
+	return desc;
+}
+
+void libeth_xdp_tx_exception(struct libeth_xdp_tx_bulk *bq, u32 sent,
+			     u32 flags);
+
+/**
+ * __libeth_xdp_tx_flush_bulk - internal helper to flush one XDP Tx bulk
+ * @bq: bulk to flush
+ * @flags: XDP TX flags (.ndo_xdp_xmit(), XSk etc.)
+ * @prep: driver-specific callback to prepare the queue for sending
+ * @fill: libeth_xdp callback to fill &libeth_sqe and &libeth_xdp_tx_desc
+ * @xmit: driver callback to fill a HW descriptor
+ *
+ * Internal abstraction to create bulk flush functions for drivers. Used for
+ * everything except XSk xmit.
+ *
+ * Return: true if anything was sent, false otherwise.
+ */
+static __always_inline bool
+__libeth_xdp_tx_flush_bulk(struct libeth_xdp_tx_bulk *bq, u32 flags,
+			   u32 (*prep)(void *xdpsq, struct libeth_xdpsq *sq),
+			   struct libeth_xdp_tx_desc
+			   (*fill)(struct libeth_xdp_tx_frame frm, u32 i,
+				   const struct libeth_xdpsq *sq, u64 priv),
+			   void (*xmit)(struct libeth_xdp_tx_desc desc, u32 i,
+					const struct libeth_xdpsq *sq,
+					u64 priv))
+{
+	u32 sent, drops;
+	int err = 0;
+
+	sent = libeth_xdp_tx_xmit_bulk(bq->bulk, bq->xdpsq,
+				       min(bq->count, LIBETH_XDP_TX_BULK),
+				       false, 0, prep, fill, xmit);
+	drops = bq->count - sent;
+
+	if (unlikely(drops)) {
+		libeth_xdp_tx_exception(bq, sent, flags);
+		err = -ENXIO;
+	} else {
+		bq->count = 0;
+	}
+
+	trace_xdp_bulk_tx(bq->dev, sent, drops, err);
+
+	return likely(sent);
+}
+
+/**
+ * libeth_xdp_tx_flush_bulk - wrapper to define flush of one ``XDP_TX`` bulk
+ * @bq: bulk to flush
+ * @flags: Tx flags, see above
+ * @prep: driver callback to prepare the queue
+ * @xmit: driver callback to fill a HW descriptor
+ *
+ * Use via LIBETH_XDP_DEFINE_FLUSH_TX() to define an ``XDP_TX`` driver
+ * callback.
+ */
+#define libeth_xdp_tx_flush_bulk(bq, flags, prep, xmit)			      \
+	__libeth_xdp_tx_flush_bulk(bq, flags, prep, libeth_xdp_tx_fill_buf,   \
+				   xmit)
+
+/* .ndo_xdp_xmit() implementation */
+
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
+		__libeth_xdp_tx_len(xdpf->len, LIBETH_XDP_TX_FIRST),
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
+		__libeth_xdp_tx_len(skb_frag_size(frag)),
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
+ *
+ * Use via LIBETH_XDP_DEFINE_FLUSH_XMIT() to define an XDP xmit driver
+ * callback.
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
+		struct libeth_xdp_tx_bulk ub;				      \
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
+/* Rx polling path */
+
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
+ * Do not use for XSk, it has its own optimized helper.
+ */
+#define libeth_xdp_tx_init_bulk(bq, prog, dev, xdpsqs, num)		      \
+	__libeth_xdp_tx_init_bulk(bq, prog, dev, xdpsqs, num, false,	      \
+				  __UNIQUE_ID(bq_), __UNIQUE_ID(nqs_))
+
+#define __libeth_xdp_tx_init_bulk(bq, pr, d, xdpsqs, num, xsk, ub, un) do {   \
+	typeof(bq) ub = (bq);						      \
+	u32 un = (num);							      \
+									      \
+	if (un || (xsk)) {						      \
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
+void libeth_xdp_load_stash(struct libeth_xdp_buff *dst,
+			   const struct libeth_xdp_buff_stash *src);
+void libeth_xdp_save_stash(struct libeth_xdp_buff_stash *dst,
+			   const struct libeth_xdp_buff *src);
+void __libeth_xdp_return_stash(struct libeth_xdp_buff_stash *stash);
+
+/**
+ * libeth_xdp_init_buff - initialize a &libeth_xdp_buff for Rx NAPI poll
+ * @dst: onstack buffer to initialize
+ * @src: XDP buffer stash placed on the queue
+ * @rxq: registered &xdp_rxq_info corresponding to this queue
+ *
+ * Should be called before the main NAPI polling loop. Loads the content of
+ * the previously saved stash or initializes the buffer from scratch.
+ * Do not use for XSk.
+ */
+static inline void
+libeth_xdp_init_buff(struct libeth_xdp_buff *dst,
+		     const struct libeth_xdp_buff_stash *src,
+		     struct xdp_rxq_info *rxq)
+{
+	if (likely(!src->data))
+		dst->data = NULL;
+	else
+		libeth_xdp_load_stash(dst, src);
+
+	dst->base.rxq = rxq;
+}
+
+/**
+ * libeth_xdp_save_buff - save a partially built buffer on a queue
+ * @dst: XDP buffer stash placed on the queue
+ * @src: onstack buffer to save
+ *
+ * Should be called after the main NAPI polling loop. If the loop exited before
+ * the buffer was finished, saves its content on the queue, so that it can be
+ * completed during the next poll. Otherwise, clears the stash.
+ */
+static inline void libeth_xdp_save_buff(struct libeth_xdp_buff_stash *dst,
+					const struct libeth_xdp_buff *src)
+{
+	if (likely(!src->data))
+		dst->data = NULL;
+	else
+		libeth_xdp_save_stash(dst, src);
+}
+
+/**
+ * libeth_xdp_return_stash - free an XDP buffer stash from a queue
+ * @stash: stash to free
+ *
+ * If the queue is about to be destroyed, but it still has an incompleted
+ * buffer stash, this helper should be called to free it.
+ */
+static inline void libeth_xdp_return_stash(struct libeth_xdp_buff_stash *stash)
+{
+	if (stash->data)
+		__libeth_xdp_return_stash(stash);
+}
+
+static inline void libeth_xdp_return_va(const void *data, bool napi)
+{
+	struct page *page = virt_to_page(data);
+
+	page_pool_put_full_page(page->pp, page, napi);
+}
+
+static inline void libeth_xdp_return_frags(const struct skb_shared_info *sinfo,
+					   bool napi)
+{
+	for (u32 i = 0; i < sinfo->nr_frags; i++) {
+		struct page *page = skb_frag_page(&sinfo->frags[i]);
+
+		page_pool_put_full_page(page->pp, page, napi);
+	}
+}
+
+/**
+ * libeth_xdp_return_buff - free/recycle a &libeth_xdp_buff
+ * @xdp: buffer to free
+ *
+ * Hotpath helper to free a &libeth_xdp_buff. Comparing to xdp_return_buff(),
+ * it's faster as it gets inlined and always assumes order-0 pages and safe
+ * direct recycling. Zeroes @xdp->data to avoid UAFs.
+ */
+static inline void libeth_xdp_return_buff(struct libeth_xdp_buff *xdp)
+{
+	if (!xdp_buff_has_frags(&xdp->base))
+		goto out;
+
+	libeth_xdp_return_frags(xdp_get_shared_info_from_buff(&xdp->base),
+				true);
+
+out:
+	libeth_xdp_return_va(xdp->data, true);
+	xdp->data = NULL;
+}
+
+bool libeth_xdp_buff_add_frag(struct libeth_xdp_buff *xdp,
+			      const struct libeth_fqe *fqe,
+			      u32 len);
+
+/**
+ * libeth_xdp_prepare_buff - fill a &libeth_xdp_buff with a head FQE data
+ * @xdp: XDP buffer to attach the head to
+ * @fqe: FQE containing the head buffer
+ * @len: buffer len passed from HW
+ *
+ * Internal, use libeth_xdp_process_buff() instead. Initializes XDP buffer
+ * head with the Rx buffer data: data pointer, length, headroom, and
+ * truesize/tailroom. Zeroes the flags.
+ * Uses faster single u64 write instead of per-field access.
+ */
+static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
+					   const struct libeth_fqe *fqe,
+					   u32 len)
+{
+	const struct page *page = fqe->page;
+
+#ifdef __LIBETH_WORD_ACCESS
+	static_assert(offsetofend(typeof(xdp->base), flags) -
+		      offsetof(typeof(xdp->base), frame_sz) ==
+		      sizeof(u64));
+
+	*(u64 *)&xdp->base.frame_sz = fqe->truesize;
+#else
+	xdp_init_buff(&xdp->base, fqe->truesize, xdp->base.rxq);
+#endif
+	xdp_prepare_buff(&xdp->base, page_address(page) + fqe->offset,
+			 page->pp->p.offset, len, true);
+}
+
+/**
+ * libeth_xdp_process_buff - attach an Rx buffer to a &libeth_xdp_buff
+ * @xdp: XDP buffer to attach the Rx buffer to
+ * @fqe: Rx buffer to process
+ * @len: received data length from the descriptor
+ *
+ * If the XDP buffer is empty, attaches the Rx buffer as head and initializes
+ * the required fields. Otherwise, attaches the buffer as a frag.
+ * Already performs DMA sync-for-CPU and frame start prefetch
+ * (for head buffers only).
+ *
+ * Return: true on success, false if the descriptor must be skipped (empty or
+ * no space for a new frag).
+ */
+static inline bool libeth_xdp_process_buff(struct libeth_xdp_buff *xdp,
+					   const struct libeth_fqe *fqe,
+					   u32 len)
+{
+	if (!libeth_rx_sync_for_cpu(fqe, len))
+		return false;
+
+	if (xdp->data)
+		return libeth_xdp_buff_add_frag(xdp, fqe, len);
+
+	libeth_xdp_prepare_buff(xdp, fqe, len);
+
+	prefetch(xdp->data);
+
+	return true;
+}
+
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
+ * ``XDP_TX`` verdict. Used by both XDP and XSk, hence @run and @queue.
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
+ * libeth_xdp_run_prog - run XDP program (non-XSk path) and handle all verdicts
+ * @xdp: XDP buffer to process
+ * @bq: XDP Tx bulk to queue ``XDP_TX`` buffers
+ * @fl: driver ``XDP_TX`` bulk flush callback
+ *
+ * Run the attached XDP program and handle all possible verdicts. XSk has its
+ * own version.
+ * Prefer using it via LIBETH_XDP_DEFINE_RUN{,_PASS,_PROG}().
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
+ * Inline abstraction that does the following (non-XSk path):
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
+ * libeth_xdp_finalize_rx - finalize XDPSQ after a NAPI polling loop (non-XSk)
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
+}
+
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
+/* XMO */
+
+/**
+ * libeth_xdp_buff_to_rq - get RQ pointer from an XDP buffer pointer
+ * @xdp: &libeth_xdp_buff corresponding to the queue
+ * @type: typeof() of the driver Rx queue structure
+ * @member: name of &xdp_rxq_info inside @type
+ *
+ * Often times, pointer to the RQ is needed when reading/filling metadata from
+ * HW descriptors. The helper can be used to quickly jump from an XDP buffer
+ * to the queue corresponding to its &xdp_rxq_info without introducing
+ * additional fields (&libeth_xdp_buff is precisely 1 cacheline long on x64).
+ */
+#define libeth_xdp_buff_to_rq(xdp, type, member)			      \
+	container_of_const((xdp)->base.rxq, type, member)
+
+/**
+ * libeth_xdpmo_rx_hash - convert &libeth_rx_pt to an XDP RSS hash metadata
+ * @hash: pointer to the variable to write the hash to
+ * @rss_type: pointer to the variable to write the hash type to
+ * @val: hash value from the HW descriptor
+ * @pt: libeth parsed packet type
+ *
+ * Handle zeroed/non-available hash and convert libeth parsed packet type to
+ * the corresponding XDP RSS hash type. To be called at the end of
+ * xdp_metadata_ops idpf_xdpmo::xmo_rx_hash() implementation.
+ * Note that if the driver doesn't use a constant packet type lookup table but
+ * generates it at runtime, it must call libeth_rx_pt_gen_hash_type(pt) to
+ * generate XDP RSS hash type for each packet type.
+ *
+ * Return: 0 on success, -ENODATA when the hash is not available.
+ */
+static inline int libeth_xdpmo_rx_hash(u32 *hash,
+				       enum xdp_rss_hash_type *rss_type,
+				       u32 val, struct libeth_rx_pt pt)
+{
+	if (unlikely(!val))
+		return -ENODATA;
+
+	*hash = val;
+	*rss_type = pt.hash_type;
+
+	return 0;
+}
+
+/* Tx buffer completion */
+
+void libeth_xdp_return_buff_bulk(const struct skb_shared_info *sinfo,
+				 struct xdp_frame_bulk *bq, bool frags);
+void libeth_xsk_buff_free_slow(struct libeth_xdp_buff *xdp);
+
+/**
+ * __libeth_xdp_complete_tx - complete a sent XDPSQE
+ * @sqe: SQ element / Tx buffer to complete
+ * @cp: Tx polling/completion params
+ * @bulk: internal callback to bulk-free ``XDP_TX`` buffers
+ * @xsk: internal callback to free XSk ``XDP_TX`` buffers
+ *
+ * Use the non-underscored version in drivers instead. This one is shared
+ * internally with libeth_tx_complete_any().
+ * Complete an XDPSQE of any type of XDP frame. This includes DMA unmapping
+ * when needed, buffer freeing, stats update, and SQE invalidating.
+ */
+static __always_inline void
+__libeth_xdp_complete_tx(struct libeth_sqe *sqe, struct libeth_cq_pp *cp,
+			 typeof(libeth_xdp_return_buff_bulk) bulk,
+			 typeof(libeth_xsk_buff_free_slow) xsk)
+{
+	enum libeth_sqe_type type = sqe->type;
+
+	switch (type) {
+	case LIBETH_SQE_EMPTY:
+		return;
+	case LIBETH_SQE_XDP_XMIT:
+	case LIBETH_SQE_XDP_XMIT_FRAG:
+		dma_unmap_page(cp->dev, dma_unmap_addr(sqe, dma),
+			       dma_unmap_len(sqe, len), DMA_TO_DEVICE);
+		break;
+	default:
+		break;
+	}
+
+	switch (type) {
+	case LIBETH_SQE_XDP_TX:
+		bulk(sqe->sinfo, cp->bq, sqe->nr_frags != 1);
+		break;
+	case LIBETH_SQE_XDP_XMIT:
+		xdp_return_frame_bulk(sqe->xdpf, cp->bq);
+		break;
+	case LIBETH_SQE_XSK_TX:
+	case LIBETH_SQE_XSK_TX_FRAG:
+		xsk(sqe->xsk);
+		break;
+	default:
+		break;
+	}
+
+	switch (type) {
+	case LIBETH_SQE_XDP_TX:
+	case LIBETH_SQE_XDP_XMIT:
+	case LIBETH_SQE_XSK_TX:
+		cp->xdp_tx -= sqe->nr_frags;
+
+		cp->xss->packets++;
+		cp->xss->bytes += sqe->bytes;
+		break;
+	default:
+		break;
+	}
+
+	sqe->type = LIBETH_SQE_EMPTY;
+}
+
+static inline void libeth_xdp_complete_tx(struct libeth_sqe *sqe,
+					  struct libeth_cq_pp *cp)
+{
+	__libeth_xdp_complete_tx(sqe, cp, libeth_xdp_return_buff_bulk,
+				 libeth_xsk_buff_free_slow);
+}
+
+/* Misc */
+
+u32 libeth_xdp_queue_threshold(u32 count);
+
+void __libeth_xdp_set_features(struct net_device *dev,
+			       const struct xdp_metadata_ops *xmo,
+			       u32 zc_segs,
+			       const struct xsk_tx_metadata_ops *tmo);
+void libeth_xdp_set_redirect(struct net_device *dev, bool enable);
+
+/**
+ * libeth_xdp_set_features - set XDP features for a netdev
+ * @dev: &net_device to configure
+ * @...: optional params, see __libeth_xdp_set_features()
+ *
+ * Set all the features libeth_xdp supports, including .ndo_xdp_xmit(). That
+ * said, it should be used only when XDPSQs are always available regardless
+ * of whether an XDP prog is attached to @dev.
+ */
+#define libeth_xdp_set_features(dev, ...)				      \
+	CONCATENATE(__libeth_xdp_feat,					      \
+		    COUNT_ARGS(__VA_ARGS__))(dev, ##__VA_ARGS__)
+
+#define __libeth_xdp_feat0(dev)						      \
+	__libeth_xdp_set_features(dev, NULL, 0, NULL)
+#define __libeth_xdp_feat1(dev, xmo)					      \
+	__libeth_xdp_set_features(dev, xmo, 0, NULL)
+#define __libeth_xdp_feat2(dev, xmo, zc_segs)				      \
+	__libeth_xdp_set_features(dev, xmo, zc_segs, NULL)
+#define __libeth_xdp_feat3(dev, xmo, zc_segs, tmo)			      \
+	__libeth_xdp_set_features(dev, xmo, zc_segs, tmo)
+
+/**
+ * libeth_xdp_set_features_noredir - enable all libeth_xdp features w/o redir
+ * @dev: target &net_device
+ * @...: optional params, see __libeth_xdp_set_features()
+ *
+ * Enable everything except the .ndo_xdp_xmit() feature, use when XDPSQs are
+ * not available right after netdev registration.
+ */
+#define libeth_xdp_set_features_noredir(dev, ...)			      \
+	__libeth_xdp_set_features_noredir(dev, __UNIQUE_ID(dev_),	      \
+					  ##__VA_ARGS__)
+
+#define __libeth_xdp_set_features_noredir(dev, ud, ...) do {		      \
+	struct net_device *ud = (dev);					      \
+									      \
+	libeth_xdp_set_features(ud, ##__VA_ARGS__);			      \
+	libeth_xdp_set_redirect(ud, false);				      \
+} while (0)
+
+#define libeth_xsktmo			((const void *)true)
+
+#endif /* __LIBETH_XDP_H */
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
new file mode 100644
index 000000000000..3d5d20a6bdde
--- /dev/null
+++ b/include/net/libeth/xsk.h
@@ -0,0 +1,684 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
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
+ * libeth_xsk_tx_flush_bulk - wrapper to define flush of an XSk ``XDP_TX`` bulk
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
+ * libeth_xsk_tx_init_bulk - initialize an XDP Tx bulk for XSk Rx NAPI poll
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
+ * libeth_xsk_process_buff - attach an XSk Rx buffer to a &libeth_xdp_buff
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
+ * __libeth_xsk_run_prog - run XDP program on an XSk buffer
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
+	if (unlikely(act == LIBETH_XDP_ABORTED))
+		return false;
+	else if (likely(act != LIBETH_XDP_PASS))
+		return true;
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
+ * libeth_xsk_buff_xdp_get_dma - get DMA address for an XSk &libeth_xdp_buff
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
diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 616426a2e363..1105fd0db4c3 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -215,7 +215,7 @@ EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_destroy, LIBETH);
  *
  * To be used on exceptions or rare cases not requiring fast inline recycling.
  */
-void libeth_rx_recycle_slow(struct page *page)
+void __cold libeth_rx_recycle_slow(struct page *page)
 {
 	page_pool_recycle_direct(page->pp, page);
 }
diff --git a/drivers/net/ethernet/intel/libeth/tx.c b/drivers/net/ethernet/intel/libeth/tx.c
new file mode 100644
index 000000000000..dc8df216c922
--- /dev/null
+++ b/drivers/net/ethernet/intel/libeth/tx.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Intel Corporation */
+
+#include <net/libeth/xdp.h>
+
+#include "priv.h"
+
+/* Tx buffer completion */
+
+DEFINE_STATIC_CALL_NULL(bulk, libeth_xdp_return_buff_bulk);
+DEFINE_STATIC_CALL_NULL(xsk, libeth_xsk_buff_free_slow);
+
+/**
+ * libeth_tx_complete_any - perform Tx completion for one SQE of any type
+ * @sqe: Tx buffer to complete
+ * @cp: polling params
+ *
+ * Can be used to complete both regular and XDP SQEs, for example when
+ * destroying queues.
+ * When libeth_xdp is not loaded, XDPSQEs won't be handled.
+ */
+void libeth_tx_complete_any(struct libeth_sqe *sqe, struct libeth_cq_pp *cp)
+{
+	if (sqe->type >= __LIBETH_SQE_XDP_START)
+		__libeth_xdp_complete_tx(sqe, cp, static_call(bulk),
+					 static_call(xsk));
+	else
+		libeth_tx_complete(sqe, cp);
+}
+EXPORT_SYMBOL_NS_GPL(libeth_tx_complete_any, LIBETH);
+
+/* Module */
+
+void libeth_attach_xdp(const struct libeth_xdp_ops *ops)
+{
+	static_call_update(bulk, ops ? ops->bulk : NULL);
+	static_call_update(xsk, ops ? ops->xsk : NULL);
+}
+EXPORT_SYMBOL_NS_GPL(libeth_attach_xdp, LIBETH);
diff --git a/drivers/net/ethernet/intel/libeth/xdp.c b/drivers/net/ethernet/intel/libeth/xdp.c
new file mode 100644
index 000000000000..3b1438fb9f35
--- /dev/null
+++ b/drivers/net/ethernet/intel/libeth/xdp.c
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Intel Corporation */
+
+#include <net/libeth/xdp.h>
+
+#include "priv.h"
+
+/* XDPSQ sharing */
+
+DEFINE_STATIC_KEY_FALSE(libeth_xdpsq_share);
+EXPORT_SYMBOL_NS_GPL(libeth_xdpsq_share, LIBETH_XDP);
+
+void __libeth_xdpsq_get(struct libeth_xdpsq_lock *lock,
+			const struct net_device *dev)
+{
+	bool warn;
+
+	spin_lock_init(&lock->lock);
+	lock->share = true;
+
+	warn = !static_key_enabled(&libeth_xdpsq_share);
+	static_branch_inc_cpuslocked(&libeth_xdpsq_share);
+
+	if (warn && net_ratelimit())
+		netdev_warn(dev, "XDPSQ sharing enabled, possible XDP Tx slowdown\n");
+}
+EXPORT_SYMBOL_NS_GPL(__libeth_xdpsq_get, LIBETH_XDP);
+
+void __libeth_xdpsq_put(struct libeth_xdpsq_lock *lock,
+			const struct net_device *dev)
+{
+	static_branch_dec_cpuslocked(&libeth_xdpsq_share);
+
+	if (!static_key_enabled(&libeth_xdpsq_share) && net_ratelimit())
+		netdev_notice(dev, "XDPSQ sharing disabled\n");
+
+	lock->share = false;
+}
+EXPORT_SYMBOL_NS_GPL(__libeth_xdpsq_put, LIBETH_XDP);
+
+void __acquires(&lock->lock)
+__libeth_xdpsq_lock(struct libeth_xdpsq_lock *lock)
+{
+	spin_lock(&lock->lock);
+}
+EXPORT_SYMBOL_NS_GPL(__libeth_xdpsq_lock, LIBETH_XDP);
+
+void __releases(&lock->lock)
+__libeth_xdpsq_unlock(struct libeth_xdpsq_lock *lock)
+{
+	spin_unlock(&lock->lock);
+}
+EXPORT_SYMBOL_NS_GPL(__libeth_xdpsq_unlock, LIBETH_XDP);
+
+/* XDPSQ clean-up timers */
+
+/**
+ * libeth_xdpsq_init_timer - initialize an XDPSQ clean-up timer
+ * @timer: timer to initialize
+ * @xdpsq: queue this timer belongs to
+ * @lock: corresponding XDPSQ lock
+ * @poll: queue polling/completion function
+ *
+ * XDPSQ clean-up timers must be set up before using at the queue configuration
+ * time. Set the required pointers and the cleaning callback.
+ */
+void libeth_xdpsq_init_timer(struct libeth_xdpsq_timer *timer, void *xdpsq,
+			     struct libeth_xdpsq_lock *lock,
+			     void (*poll)(struct work_struct *work))
+{
+	timer->xdpsq = xdpsq;
+	timer->lock = lock;
+
+	INIT_DELAYED_WORK(&timer->dwork, poll);
+}
+EXPORT_SYMBOL_NS_GPL(libeth_xdpsq_init_timer, LIBETH_XDP);
+
+/* ``XDP_TX`` bulking */
+
+static void __cold
+libeth_xdp_tx_return_one(const struct libeth_xdp_tx_frame *frm)
+{
+	if (frm->len_fl & LIBETH_XDP_TX_MULTI)
+		libeth_xdp_return_frags(frm->data + frm->soff, true);
+
+	libeth_xdp_return_va(frm->data, true);
+}
+
+static void __cold
+libeth_xdp_tx_return_bulk(const struct libeth_xdp_tx_frame *bq, u32 count)
+{
+	for (u32 i = 0; i < count; i++) {
+		const struct libeth_xdp_tx_frame *frm = &bq[i];
+
+		if (!(frm->len_fl & LIBETH_XDP_TX_FIRST))
+			continue;
+
+		libeth_xdp_tx_return_one(frm);
+	}
+}
+
+static void __cold libeth_trace_xdp_exception(const struct net_device *dev,
+					      const struct bpf_prog *prog,
+					      u32 act)
+{
+	trace_xdp_exception(dev, prog, act);
+}
+
+/**
+ * libeth_xdp_tx_exception - handle Tx exceptions of XDP frames
+ * @bq: XDP Tx frame bulk
+ * @sent: number of frames sent successfully (from this bulk)
+ * @flags: internal libeth_xdp flags (XSk, .ndo_xdp_xmit etc.)
+ *
+ * Cold helper used by __libeth_xdp_tx_flush_bulk(), do not call directly.
+ * Reports XDP Tx exceptions, frees the frames that won't be sent or adjust
+ * the Tx bulk to try again later.
+ */
+void __cold libeth_xdp_tx_exception(struct libeth_xdp_tx_bulk *bq, u32 sent,
+				    u32 flags)
+{
+	const struct libeth_xdp_tx_frame *pos = &bq->bulk[sent];
+	u32 left = bq->count - sent;
+
+	if (!(flags & LIBETH_XDP_TX_NDO))
+		libeth_trace_xdp_exception(bq->dev, bq->prog, XDP_TX);
+
+	if (!(flags & LIBETH_XDP_TX_DROP)) {
+		memmove(bq->bulk, pos, left * sizeof(*bq->bulk));
+		bq->count = left;
+
+		return;
+	}
+
+	if (flags & LIBETH_XDP_TX_XSK)
+		libeth_xsk_tx_return_bulk(pos, left);
+	else if (!(flags & LIBETH_XDP_TX_NDO))
+		libeth_xdp_tx_return_bulk(pos, left);
+	else
+		libeth_xdp_xmit_return_bulk(pos, left, bq->dev);
+
+	bq->count = 0;
+}
+EXPORT_SYMBOL_NS_GPL(libeth_xdp_tx_exception, LIBETH_XDP);
+
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
+EXPORT_SYMBOL_NS_GPL(libeth_xdp_xmit_return_bulk, LIBETH_XDP);
+
+/* Rx polling path */
+
+/**
+ * libeth_xdp_load_stash - recreate an &xdp_buff from a libeth_xdp buffer stash
+ * @dst: target &libeth_xdp_buff to initialize
+ * @src: source stash
+ *
+ * External helper used by libeth_xdp_init_buff(), do not call directly.
+ * Recreate an onstack &libeth_xdp_buff using the stash saved earlier.
+ * The only field untouched (rxq) is initialized later in the
+ * abovementioned function.
+ */
+void libeth_xdp_load_stash(struct libeth_xdp_buff *dst,
+			   const struct libeth_xdp_buff_stash *src)
+{
+	dst->data = src->data;
+	dst->base.data_end = src->data + src->len;
+	dst->base.data_meta = src->data;
+	dst->base.data_hard_start = src->data - src->headroom;
+
+	dst->base.frame_sz = src->frame_sz;
+	dst->base.flags = src->flags;
+}
+EXPORT_SYMBOL_NS_GPL(libeth_xdp_load_stash, LIBETH_XDP);
+
+/**
+ * libeth_xdp_save_stash - convert an &xdp_buff to a libeth_xdp buffer stash
+ * @dst: target &libeth_xdp_buff_stash to initialize
+ * @src: source XDP buffer
+ *
+ * External helper used by libeth_xdp_save_buff(), do not call directly.
+ * Use the fields from the passed XDP buffer to initialize the stash on the
+ * queue, so that a partially received frame can be finished later during
+ * the next NAPI poll.
+ */
+void libeth_xdp_save_stash(struct libeth_xdp_buff_stash *dst,
+			   const struct libeth_xdp_buff *src)
+{
+	dst->data = src->data;
+	dst->headroom = src->data - src->base.data_hard_start;
+	dst->len = src->base.data_end - src->data;
+
+	dst->frame_sz = src->base.frame_sz;
+	dst->flags = src->base.flags;
+
+	WARN_ON_ONCE(dst->flags != src->base.flags);
+}
+EXPORT_SYMBOL_NS_GPL(libeth_xdp_save_stash, LIBETH_XDP);
+
+void __libeth_xdp_return_stash(struct libeth_xdp_buff_stash *stash)
+{
+	LIBETH_XDP_ONSTACK_BUFF(xdp);
+
+	libeth_xdp_load_stash(xdp, stash);
+	libeth_xdp_return_buff_slow(xdp);
+
+	stash->data = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(__libeth_xdp_return_stash, LIBETH_XDP);
+
+/**
+ * libeth_xdp_return_buff_slow - free a &libeth_xdp_buff
+ * @xdp: buffer to free/return
+ *
+ * Slowpath version of libeth_xdp_return_buff() to be called on exceptions,
+ * queue clean-ups etc., without unwanted inlining.
+ */
+void __cold libeth_xdp_return_buff_slow(struct libeth_xdp_buff *xdp)
+{
+	libeth_xdp_return_buff(xdp);
+}
+EXPORT_SYMBOL_NS_GPL(libeth_xdp_return_buff_slow, LIBETH_XDP);
+
+/**
+ * libeth_xdp_buff_add_frag - add a frag to an XDP buffer
+ * @xdp: head XDP buffer
+ * @fqe: Rx buffer containing the frag
+ * @len: frag length reported by HW
+ *
+ * External helper used by libeth_xdp_process_buff(), do not call directly.
+ * Frees both head and frag buffers on error.
+ *
+ * Return: true success, false on error (no space for a new frag).
+ */
+bool libeth_xdp_buff_add_frag(struct libeth_xdp_buff *xdp,
+			      const struct libeth_fqe *fqe,
+			      u32 len)
+{
+	struct page *page = fqe->page;
+
+	if (!xdp_buff_add_frag(&xdp->base, page,
+			       fqe->offset + page->pp->p.offset,
+			       len, fqe->truesize))
+		goto recycle;
+
+	return true;
+
+recycle:
+	libeth_rx_recycle_slow(page);
+	libeth_xdp_return_buff_slow(xdp);
+
+	return false;
+}
+EXPORT_SYMBOL_NS_GPL(libeth_xdp_buff_add_frag, LIBETH_XDP);
+
+/**
+ * libeth_xdp_prog_exception - handle XDP prog exceptions
+ * @bq: XDP Tx bulk
+ * @xdp: buffer to process
+ * @act: original XDP prog verdict
+ * @ret: error code if redirect failed
+ *
+ * External helper used by __libeth_xdp_run_prog() and
+ * __libeth_xsk_run_prog_slow(), do not call directly.
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
+	if (xdp->base.rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		return libeth_xsk_prog_exception(xdp, act, ret);
+
+	libeth_xdp_return_buff_slow(xdp);
+
+	return LIBETH_XDP_DROP;
+}
+EXPORT_SYMBOL_NS_GPL(libeth_xdp_prog_exception, LIBETH_XDP);
+
+/* Tx buffer completion */
+
+static void libeth_xdp_put_page_bulk(struct page *page,
+				     struct xdp_frame_bulk *bq)
+{
+	if (unlikely(bq->count == XDP_BULK_QUEUE_SIZE))
+		xdp_flush_frame_bulk(bq);
+
+	bq->q[bq->count++] = page;
+}
+
+/**
+ * libeth_xdp_return_buff_bulk - free &xdp_buff as part of a bulk
+ * @sinfo: shared info corresponding to the buffer
+ * @bq: XDP frame bulk to store the buffer
+ * @frags: whether the buffer has frags
+ *
+ * Same as xdp_return_frame_bulk(), but for &libeth_xdp_buff, speeds up Tx
+ * completion of ``XDP_TX`` buffers and allows to free them in same bulks
+ * with &xdp_frame buffers.
+ */
+void libeth_xdp_return_buff_bulk(const struct skb_shared_info *sinfo,
+				 struct xdp_frame_bulk *bq, bool frags)
+{
+	if (!frags)
+		goto head;
+
+	for (u32 i = 0; i < sinfo->nr_frags; i++)
+		libeth_xdp_put_page_bulk(skb_frag_page(&sinfo->frags[i]), bq);
+
+head:
+	libeth_xdp_put_page_bulk(virt_to_page(sinfo), bq);
+}
+EXPORT_SYMBOL_NS_GPL(libeth_xdp_return_buff_bulk, LIBETH_XDP);
+
+/* Misc */
+
+/**
+ * libeth_xdp_queue_threshold - calculate XDP queue clean/refill threshold
+ * @count: number of descriptors in the queue
+ *
+ * The threshold is the limit at which RQs start to refill (when the number of
+ * empty buffers exceeds it) and SQs get cleaned up (when the number of free
+ * descriptors goes below it). To speed up hotpath processing, threshold is
+ * always pow-2, closest to 1/4 of the queue length.
+ * Don't call it on hotpath, calculate and cache the threshold during the
+ * queue initialization.
+ *
+ * Return: the calculated threshold.
+ */
+u32 libeth_xdp_queue_threshold(u32 count)
+{
+	u32 quarter, low, high;
+
+	if (likely(is_power_of_2(count)))
+		return count >> 2;
+
+	quarter = DIV_ROUND_CLOSEST(count, 4);
+	low = rounddown_pow_of_two(quarter);
+	high = roundup_pow_of_two(quarter);
+
+	return high - quarter <= quarter - low ? high : low;
+}
+EXPORT_SYMBOL_NS_GPL(libeth_xdp_queue_threshold, LIBETH_XDP);
+
+/**
+ * __libeth_xdp_set_features - set XDP features for a netdev
+ * @dev: &net_device to configure
+ * @xmo: XDP metadata ops (Rx hints)
+ * @zc_segs: maximum number of S/G frags the HW can transmit
+ * @tmo: XSk Tx metadata ops (Tx hints)
+ *
+ * Set all the features libeth_xdp supports. Only the first argument is
+ * necessary; without the third one (zero), XSk support won't be advertised.
+ * Use the non-underscored versions in drivers instead.
+ */
+void __libeth_xdp_set_features(struct net_device *dev,
+			       const struct xdp_metadata_ops *xmo,
+			       u32 zc_segs,
+			       const struct xsk_tx_metadata_ops *tmo)
+{
+	xdp_set_features_flag(dev,
+			      NETDEV_XDP_ACT_BASIC |
+			      NETDEV_XDP_ACT_REDIRECT |
+			      NETDEV_XDP_ACT_NDO_XMIT |
+			      (zc_segs ? NETDEV_XDP_ACT_XSK_ZEROCOPY : 0) |
+			      NETDEV_XDP_ACT_RX_SG |
+			      NETDEV_XDP_ACT_NDO_XMIT_SG);
+	dev->xdp_metadata_ops = xmo;
+
+	tmo = tmo == libeth_xsktmo ? &libeth_xsktmo_slow : tmo;
+
+	dev->xdp_zc_max_segs = zc_segs ? : 1;
+	dev->xsk_tx_metadata_ops = zc_segs ? tmo : NULL;
+}
+EXPORT_SYMBOL_NS_GPL(__libeth_xdp_set_features, LIBETH_XDP);
+
+/**
+ * libeth_xdp_set_redirect - toggle the XDP redirect feature
+ * @dev: &net_device to configure
+ * @enable: whether XDP is enabled
+ *
+ * Use this when XDPSQs are not always available to dynamically enable
+ * and disable redirect feature.
+ */
+void libeth_xdp_set_redirect(struct net_device *dev, bool enable)
+{
+	if (enable)
+		xdp_features_set_redirect_target(dev, true);
+	else
+		xdp_features_clear_redirect_target(dev);
+}
+EXPORT_SYMBOL_NS_GPL(libeth_xdp_set_redirect, LIBETH_XDP);
+
+/* Module */
+
+static const struct libeth_xdp_ops xdp_ops __initconst = {
+	.bulk	= libeth_xdp_return_buff_bulk,
+	.xsk	= libeth_xsk_buff_free_slow,
+};
+
+static int __init libeth_xdp_module_init(void)
+{
+	libeth_attach_xdp(&xdp_ops);
+
+	return 0;
+}
+module_init(libeth_xdp_module_init);
+
+static void __exit libeth_xdp_module_exit(void)
+{
+	libeth_detach_xdp();
+}
+module_exit(libeth_xdp_module_exit);
+
+MODULE_DESCRIPTION("Common Ethernet library - XDP infra");
+MODULE_IMPORT_NS(LIBETH);
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/intel/libeth/xsk.c b/drivers/net/ethernet/intel/libeth/xsk.c
new file mode 100644
index 000000000000..eccb66a644f0
--- /dev/null
+++ b/drivers/net/ethernet/intel/libeth/xsk.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Intel Corporation */
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
+	.tmo_request_checksum	= libeth_xsktmo_req_csum,
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
+EXPORT_SYMBOL_NS_GPL(libeth_xsk_buff_free_slow, LIBETH_XDP);
+
+/**
+ * libeth_xsk_buff_add_frag - add a frag to an XSk Rx buffer
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
+EXPORT_SYMBOL_NS_GPL(libeth_xsk_buff_add_frag, LIBETH_XDP);
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
+EXPORT_SYMBOL_NS_GPL(libeth_xsk_buff_stats_frags, LIBETH_XDP);
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
+EXPORT_SYMBOL_NS_GPL(__libeth_xsk_run_prog_slow, LIBETH_XDP);
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
+EXPORT_SYMBOL_NS_GPL(libeth_xskfq_create, LIBETH_XDP);
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
+EXPORT_SYMBOL_NS_GPL(libeth_xskfq_destroy, LIBETH_XDP);
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
+EXPORT_SYMBOL_NS_GPL(libeth_xsk_init_wakeup, LIBETH_XDP);
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
+	if (qid != raw_smp_processor_id())
+		smp_call_function_single_async(qid, csd);
+	else
+		__napi_schedule(napi);
+}
+EXPORT_SYMBOL_NS_GPL(libeth_xsk_wakeup, LIBETH_XDP);
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
+EXPORT_SYMBOL_NS_GPL(libeth_xsk_setup_pool, LIBETH_XDP);
-- 
2.47.0


