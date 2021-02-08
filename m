Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E10312D6C
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 10:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhBHJiS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 04:38:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:41334 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhBHJgc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 04:36:32 -0500
IronPort-SDR: h0/PaOmzzp9nSsh8aKzf6+KRrKv2+eoFKuthhgg46F8nzi9a+QMJKJVQheUs03ksV3/eRe4JNZ
 GG/NBBCZk3VQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="266517687"
X-IronPort-AV: E=Sophos;i="5.81,161,1610438400"; 
   d="scan'208";a="266517687"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 01:35:48 -0800
IronPort-SDR: ZFC5uSxLddtFpDJRL/ieUTJNbFKORqE1qfs1OxJmVVUAeg9Hqx/kAbyUbrcEGy5zkWdemqbNYz
 pabUxMDfRiwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,161,1610438400"; 
   d="scan'208";a="358680833"
Received: from silpixa00399839.ir.intel.com (HELO localhost.localdomain) ([10.237.222.142])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 01:35:46 -0800
From:   Ciara Loftus <ciara.loftus@intel.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, bjorn@kernel.org,
        weqaar.a.janjua@intel.com
Cc:     daniel@iogearbox.net, song@kernel.org,
        Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH bpf-next v5 1/6] xsk: add tracepoints for packet drops
Date:   Mon,  8 Feb 2021 09:05:25 +0000
Message-Id: <20210208090530.5032-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210208090530.5032-1-ciara.loftus@intel.com>
References: <20210208090530.5032-1-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit introduces tracing infrastructure for AF_XDP sockets
(xsks) and a new trace event called 'xsk_packet_drop'. This trace
event is triggered when a packet cannot be processed by the socket
due to one of the following issues:
(1) packet exceeds the maximum permitted size.
(2) invalid fill descriptor address.
(3) invalid tx descriptor field.

The trace provides information about the error to the user. For
example the size vs permitted size is provided for (1). For (2)
and (3) the relevant descriptor fields are printed. This information
should help a user troubleshoot packet drops by providing this extra
level of detail which is not available through use of simple counters.

The tracepoint can be enabled/disabled by toggling
/sys/kernel/debug/tracing/events/xsk/xsk_packet_drop/enable

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 MAINTAINERS                       |  1 +
 include/linux/bpf_trace.h         |  1 +
 include/trace/events/xsk.h        | 71 +++++++++++++++++++++++++++++++
 include/uapi/linux/if_xdp.h       |  6 +++
 kernel/bpf/core.c                 |  1 +
 net/xdp/xsk.c                     |  7 ++-
 net/xdp/xsk_buff_pool.c           |  3 ++
 net/xdp/xsk_queue.h               |  4 ++
 tools/include/uapi/linux/if_xdp.h |  6 +++
 9 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/xsk.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1df56a32d2df..efe6662d4198 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19440,6 +19440,7 @@ S:	Maintained
 F:	Documentation/networking/af_xdp.rst
 F:	include/net/xdp_sock*
 F:	include/net/xsk_buff_pool.h
+F:	include/trace/events/xsk.h
 F:	include/uapi/linux/if_xdp.h
 F:	include/uapi/linux/xdp_diag.h
 F:	include/net/netns/xdp.h
diff --git a/include/linux/bpf_trace.h b/include/linux/bpf_trace.h
index ddf896abcfb6..477d29b6c2c1 100644
--- a/include/linux/bpf_trace.h
+++ b/include/linux/bpf_trace.h
@@ -3,5 +3,6 @@
 #define __LINUX_BPF_TRACE_H__
 
 #include <trace/events/xdp.h>
+#include <trace/events/xsk.h>
 
 #endif /* __LINUX_BPF_TRACE_H__ */
diff --git a/include/trace/events/xsk.h b/include/trace/events/xsk.h
new file mode 100644
index 000000000000..a45d447142a3
--- /dev/null
+++ b/include/trace/events/xsk.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2021 Intel Corporation. */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM xsk
+
+#if !defined(_TRACE_XSK_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_XSK_H
+
+#include <linux/if_xdp.h>
+#include <linux/tracepoint.h>
+
+#define print_reason(reason) \
+	__print_symbolic(reason, \
+			{ XSK_TRACE_DROP_PKT_TOO_BIG, "packet too big" }, \
+			{ XSK_TRACE_DROP_INVALID_FILLADDR, "invalid fill addr" }, \
+			{ XSK_TRACE_DROP_INVALID_TXD, "invalid tx desc" })
+
+#define print_val1(reason) \
+	__print_symbolic(reason, \
+			{ XSK_TRACE_DROP_PKT_TOO_BIG, "len" }, \
+			{ XSK_TRACE_DROP_INVALID_FILLADDR, "addr" }, \
+			{ XSK_TRACE_DROP_INVALID_TXD, "addr" })
+
+#define print_val2(reason) \
+	__print_symbolic(reason, \
+			{ XSK_TRACE_DROP_PKT_TOO_BIG, "max" }, \
+			{ XSK_TRACE_DROP_INVALID_FILLADDR, "not_used" }, \
+			{ XSK_TRACE_DROP_INVALID_TXD, "len" })
+
+#define print_val3(reason) \
+	__print_symbolic(reason, \
+			{ XSK_TRACE_DROP_PKT_TOO_BIG, "not_used" }, \
+			{ XSK_TRACE_DROP_INVALID_FILLADDR, "not_used" }, \
+			{ XSK_TRACE_DROP_INVALID_TXD, "options" })
+
+TRACE_EVENT(xsk_packet_drop,
+
+	TP_PROTO(char *name, u16 queue_id, u32 reason, u64 val1, u64 val2, u64 val3),
+
+	TP_ARGS(name, queue_id, reason, val1, val2, val3),
+
+	TP_STRUCT__entry(
+		__field(char *, name)
+		__field(u16, queue_id)
+		__field(u32, reason)
+		__field(u64, val1)
+		__field(u32, val2)
+		__field(u32, val3)
+	),
+
+	TP_fast_assign(
+		__entry->name = name;
+		__entry->queue_id = queue_id;
+		__entry->reason = reason;
+		__entry->val1 = val1;
+		__entry->val2 = val2;
+		__entry->val3 = val3;
+	),
+
+	TP_printk("netdev: %s qid %u reason: %s: %s %llu %s %u %s %u",
+		  __entry->name, __entry->queue_id, print_reason(__entry->reason),
+		  print_val1(__entry->reason), __entry->val1,
+		  print_val2(__entry->reason), __entry->val2,
+		  print_val3(__entry->reason), __entry->val3
+	)
+);
+
+#endif /* _TRACE_XSK_H */
+
+#include <trace/define_trace.h>
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index a78a8096f4ce..f7b5ebc2c00d 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -108,4 +108,10 @@ struct xdp_desc {
 
 /* UMEM descriptor is __u64 */
 
+enum xsk_trace_reasons {
+	XSK_TRACE_DROP_PKT_TOO_BIG,
+	XSK_TRACE_DROP_INVALID_FILLADDR,
+	XSK_TRACE_DROP_INVALID_TXD,
+};
+
 #endif /* _LINUX_IF_XDP_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5bbd4884ff7a..442b0d7f9bf8 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2362,3 +2362,4 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
+EXPORT_TRACEPOINT_SYMBOL_GPL(xsk_packet_drop);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 4faabd1ecfd1..689da22c8e4f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt) "AF_XDP: %s: " fmt, __func__
 
+#include <linux/bpf_trace.h>
 #include <linux/if_xdp.h>
 #include <linux/init.h>
 #include <linux/sched/mm.h>
@@ -189,9 +190,13 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 	struct xdp_buff *xsk_xdp;
 	int err;
 	u32 len;
+	u32 max = xsk_pool_get_rx_frame_size(xs->pool);
 
 	len = xdp->data_end - xdp->data;
-	if (len > xsk_pool_get_rx_frame_size(xs->pool)) {
+	if (len > max) {
+		trace_xsk_packet_drop(xs->dev->name, xs->queue_id,
+				      XSK_TRACE_DROP_PKT_TOO_BIG,
+				      len, max, 0);
 		xs->rx_dropped++;
 		return -ENOSPC;
 	}
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 8de01aaac4a0..e0bd1bfd4324 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/bpf_trace.h>
 #include <net/xsk_buff_pool.h>
 #include <net/xdp_sock.h>
 #include <net/xdp_sock_drv.h>
@@ -460,6 +461,8 @@ static struct xdp_buff_xsk *__xp_alloc(struct xsk_buff_pool *pool)
 		ok = pool->unaligned ? xp_check_unaligned(pool, &addr) :
 		     xp_check_aligned(pool, &addr);
 		if (!ok) {
+			trace_xsk_packet_drop(pool->netdev->name, pool->queue_id,
+					       XSK_TRACE_DROP_INVALID_FILLADDR, addr, 0, 0);
 			pool->fq->invalid_descs++;
 			xskq_cons_release(pool->fq);
 			continue;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 2823b7c3302d..8e9ba3cfe286 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -6,6 +6,7 @@
 #ifndef _LINUX_XSK_QUEUE_H
 #define _LINUX_XSK_QUEUE_H
 
+#include <linux/bpf_trace.h>
 #include <linux/types.h>
 #include <linux/if_xdp.h>
 #include <net/xdp_sock.h>
@@ -175,6 +176,9 @@ static inline bool xskq_cons_is_valid_desc(struct xsk_queue *q,
 					   struct xsk_buff_pool *pool)
 {
 	if (!xp_validate_desc(pool, d)) {
+		trace_xsk_packet_drop(pool->netdev->name, pool->queue_id,
+				       XSK_TRACE_DROP_INVALID_TXD, d->addr,
+				       d->len, d->options);
 		q->invalid_descs++;
 		return false;
 	}
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index a78a8096f4ce..f7b5ebc2c00d 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -108,4 +108,10 @@ struct xdp_desc {
 
 /* UMEM descriptor is __u64 */
 
+enum xsk_trace_reasons {
+	XSK_TRACE_DROP_PKT_TOO_BIG,
+	XSK_TRACE_DROP_INVALID_FILLADDR,
+	XSK_TRACE_DROP_INVALID_TXD,
+};
+
 #endif /* _LINUX_IF_XDP_H */
-- 
2.17.1

