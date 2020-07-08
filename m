Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3302181BF
	for <lists+bpf@lfdr.de>; Wed,  8 Jul 2020 09:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgGHHue (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jul 2020 03:50:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:63202 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGHHud (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jul 2020 03:50:33 -0400
IronPort-SDR: 2JflgwXrEdC0ybiapYKuLBbcWPpPcZ36rXcQq5SsFjC2kmoYIC7bOaGcxxk8HAPBt0oPoeyoiN
 GjzdGNqE0udA==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="149266804"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="149266804"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:50:33 -0700
IronPort-SDR: MqmE6mUOyeASU1wSWvDVsgLtLFs59JYmbx1lOtwSF9x8Wl+niBb0I+sTfBaQy0JZ0y9rEe30gz
 QDiVQgfBBwmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="358030323"
Received: from silpixa00399839.ir.intel.com (HELO localhost.localdomain) ([10.237.222.116])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2020 00:50:31 -0700
From:   Ciara Loftus <ciara.loftus@intel.com>
To:     bpf@vger.kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com
Cc:     Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH bpf-next 1/3] xsk: add new statistics
Date:   Wed,  8 Jul 2020 07:28:33 +0000
Message-Id: <20200708072835.4427-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708072835.4427-1-ciara.loftus@intel.com>
References: <20200708072835.4427-1-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It can be useful for the user to know the reason behind a dropped packet.
Introduce new counters which track drops on the receive path caused by:
1. rx ring being full
2. fill ring being empty

Also, on the tx path introduce a counter which tracks the number of times
we attempt pull from the tx ring when it is empty.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 include/net/xdp_sock.h            |  4 ++++
 include/uapi/linux/if_xdp.h       |  5 ++++-
 net/xdp/xsk.c                     | 36 ++++++++++++++++++++++++++-----
 net/xdp/xsk_buff_pool.c           |  1 +
 net/xdp/xsk_queue.h               |  6 ++++++
 tools/include/uapi/linux/if_xdp.h |  5 ++++-
 6 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 96bfc5f5f24e..c9d87cc40c11 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -69,7 +69,11 @@ struct xdp_sock {
 	spinlock_t tx_completion_lock;
 	/* Protects generic receive. */
 	spinlock_t rx_lock;
+
+	/* Statistics */
 	u64 rx_dropped;
+	u64 rx_queue_full;
+
 	struct list_head map_list;
 	/* Protects map_list */
 	spinlock_t map_list_lock;
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index be328c59389d..a78a8096f4ce 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -73,9 +73,12 @@ struct xdp_umem_reg {
 };
 
 struct xdp_statistics {
-	__u64 rx_dropped; /* Dropped for reasons other than invalid desc */
+	__u64 rx_dropped; /* Dropped for other reasons */
 	__u64 rx_invalid_descs; /* Dropped due to invalid descriptor */
 	__u64 tx_invalid_descs; /* Dropped due to invalid descriptor */
+	__u64 rx_ring_full; /* Dropped due to rx ring being full */
+	__u64 rx_fill_ring_empty_descs; /* Failed to retrieve item from fill ring */
+	__u64 tx_ring_empty_descs; /* Failed to retrieve item from tx ring */
 };
 
 struct xdp_options {
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 3700266229f6..26e3bba8c204 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -123,7 +123,7 @@ static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	addr = xp_get_handle(xskb);
 	err = xskq_prod_reserve_desc(xs->rx, addr, len);
 	if (err) {
-		xs->rx_dropped++;
+		xs->rx_queue_full++;
 		return err;
 	}
 
@@ -274,8 +274,10 @@ bool xsk_umem_consume_tx(struct xdp_umem *umem, struct xdp_desc *desc)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(xs, &umem->xsk_tx_list, list) {
-		if (!xskq_cons_peek_desc(xs->tx, desc, umem))
+		if (!xskq_cons_peek_desc(xs->tx, desc, umem)) {
+			xs->tx->queue_empty_descs++;
 			continue;
+		}
 
 		/* This is the backpressure mechanism for the Tx path.
 		 * Reserve space in the completion queue and only proceed
@@ -387,6 +389,8 @@ static int xsk_generic_xmit(struct sock *sk)
 		sent_frame = true;
 	}
 
+	xs->tx->queue_empty_descs++;
+
 out:
 	if (sent_frame)
 		sk->sk_write_space(sk);
@@ -812,6 +816,12 @@ static void xsk_enter_umem_offsets(struct xdp_ring_offset_v1 *ring)
 	ring->desc = offsetof(struct xdp_umem_ring, desc);
 }
 
+struct xdp_statistics_v1 {
+	__u64 rx_dropped;
+	__u64 rx_invalid_descs;
+	__u64 tx_invalid_descs;
+};
+
 static int xsk_getsockopt(struct socket *sock, int level, int optname,
 			  char __user *optval, int __user *optlen)
 {
@@ -831,19 +841,35 @@ static int xsk_getsockopt(struct socket *sock, int level, int optname,
 	case XDP_STATISTICS:
 	{
 		struct xdp_statistics stats;
+		bool extra_stats = true;
+		size_t stats_size;
 
-		if (len < sizeof(stats))
+		if (len < sizeof(struct xdp_statistics_v1)) {
 			return -EINVAL;
+		} else if (len < sizeof(stats)) {
+			extra_stats = false;
+			stats_size = sizeof(struct xdp_statistics_v1);
+		} else {
+			stats_size = sizeof(stats);
+		}
 
 		mutex_lock(&xs->mutex);
 		stats.rx_dropped = xs->rx_dropped;
+		if (extra_stats) {
+			stats.rx_ring_full = xs->rx_queue_full;
+			stats.rx_fill_ring_empty_descs =
+				xs->umem ? xskq_nb_queue_empty_descs(xs->umem->fq) : 0;
+			stats.tx_ring_empty_descs = xskq_nb_queue_empty_descs(xs->tx);
+		} else {
+			stats.rx_dropped += xs->rx_queue_full;
+		}
 		stats.rx_invalid_descs = xskq_nb_invalid_descs(xs->rx);
 		stats.tx_invalid_descs = xskq_nb_invalid_descs(xs->tx);
 		mutex_unlock(&xs->mutex);
 
-		if (copy_to_user(optval, &stats, sizeof(stats)))
+		if (copy_to_user(optval, &stats, stats_size))
 			return -EFAULT;
-		if (put_user(sizeof(stats), optlen))
+		if (put_user(stats_size, optlen))
 			return -EFAULT;
 
 		return 0;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 540ed75e4482..89cf3551d3e9 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -235,6 +235,7 @@ static struct xdp_buff_xsk *__xp_alloc(struct xsk_buff_pool *pool)
 
 	for (;;) {
 		if (!xskq_cons_peek_addr_unchecked(pool->fq, &addr)) {
+			pool->fq->queue_empty_descs++;
 			xp_release(xskb);
 			return NULL;
 		}
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 5b5d24d2dd37..bf42cfd74b89 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -38,6 +38,7 @@ struct xsk_queue {
 	u32 cached_cons;
 	struct xdp_ring *ring;
 	u64 invalid_descs;
+	u64 queue_empty_descs;
 };
 
 /* The structure of the shared state of the rings are the same as the
@@ -354,6 +355,11 @@ static inline u64 xskq_nb_invalid_descs(struct xsk_queue *q)
 	return q ? q->invalid_descs : 0;
 }
 
+static inline u64 xskq_nb_queue_empty_descs(struct xsk_queue *q)
+{
+	return q ? q->queue_empty_descs : 0;
+}
+
 struct xsk_queue *xskq_create(u32 nentries, bool umem_queue);
 void xskq_destroy(struct xsk_queue *q_ops);
 
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index be328c59389d..a78a8096f4ce 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -73,9 +73,12 @@ struct xdp_umem_reg {
 };
 
 struct xdp_statistics {
-	__u64 rx_dropped; /* Dropped for reasons other than invalid desc */
+	__u64 rx_dropped; /* Dropped for other reasons */
 	__u64 rx_invalid_descs; /* Dropped due to invalid descriptor */
 	__u64 tx_invalid_descs; /* Dropped due to invalid descriptor */
+	__u64 rx_ring_full; /* Dropped due to rx ring being full */
+	__u64 rx_fill_ring_empty_descs; /* Failed to retrieve item from fill ring */
+	__u64 tx_ring_empty_descs; /* Failed to retrieve item from tx ring */
 };
 
 struct xdp_options {
-- 
2.17.1

