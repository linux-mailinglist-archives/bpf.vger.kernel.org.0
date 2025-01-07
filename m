Return-Path: <bpf+bounces-48128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12648A04489
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 16:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E141166960
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80E01F3D5E;
	Tue,  7 Jan 2025 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chH0CLea"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3751F37A3;
	Tue,  7 Jan 2025 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263874; cv=none; b=Nlfi2/y/We085s+wcr5uWw0IBpG001I9Za81NgLMM/2VURBOOTpb3l7K9nu1ihEd5MwUBVLnyNMIVVMqB3IidObI7Ooaf8UUGjPRcfWMjyrtCjlHPmCWiw5zY7w5e80qENxym+SoRfKwZXkep/OEnXXm7Konim4cd3cO+UJ74Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263874; c=relaxed/simple;
	bh=rIM3Q/szGq3JYko89zmvXL2uX31AmqtzZ4uUp3dx6F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFAQqAuJ2r2mJ6uPOmh24mfpnPqSIHQFig2r7FIjo6Xk+fQxuim8DlJwk33MlPjRez8uCPXJom5oMkcWLps+wsp5CEssFkzSzLLy691jtqI+NGKB9F2bnHFhXW9/NXBmrFTJ7MlDpVwVupp4wZigfWMS0grnskfedRFuBIT1JQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chH0CLea; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736263871; x=1767799871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rIM3Q/szGq3JYko89zmvXL2uX31AmqtzZ4uUp3dx6F4=;
  b=chH0CLeasR93LuLn05SwoQDOOob8jyqRnq1/ukBKIoax5r+Kf+ClscdC
   Pgz49CVZsWCnoaYifMYLTsfLwSh+HMYYuLgmwhbRUkStvGmhfoCJorgna
   j11p8HhgdjPSSk/b5An9BOd+ypAQPb0Q0ouCfEhjXWZdx0oPEcMymhgso
   KjxN4vT8OGoahet7rZJix1xUYz+JPCK6KW8ubnd5LiLhJETCzERhSsGln
   OUF5AVkCTyzftBQC9fO9ERBfnKbCki60MTYrDRgVsSUS2l4+gZ+LAEP9F
   v6XCbUJyUBgTQ9enMU3GbEjGmsBeW6wBTQTOvG2AxrezIeYcB7KBF+HjZ
   Q==;
X-CSE-ConnectionGUID: OH7Ph87uSE21ZNXVCLcUgg==
X-CSE-MsgGUID: B3yOJLm6TN6Ec7Lx4v125g==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="35685782"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="35685782"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 07:31:09 -0800
X-CSE-ConnectionGUID: dTAU8+sNQ82Nl9ofHqGw3A==
X-CSE-MsgGUID: yiXJM61fSwOs+F3Lznj/kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103646927"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 07 Jan 2025 07:31:05 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/8] net: gro: decouple GRO from the NAPI layer
Date: Tue,  7 Jan 2025 16:29:33 +0100
Message-ID: <20250107152940.26530-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107152940.26530-1-aleksander.lobakin@intel.com>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fact, these two are not tied closely to each other. The only
requirements to GRO are to use it in the BH context and have some
sane limits on the packet batches, e.g. NAPI has a limit of its
budget (64/8/etc.).
Factor out purely GRO fields into a new structure, &gro_node. Embed
it into &napi_struct and adjust all the references. One member, napi_id,
is duplicated in both &napi_struct and &gro_node for performance and
convenience reasons. Three Ethernet drivers use napi_gro_flush() not
really meant to be exported, so move it to <net/gro.h> and add that
include there. napi_gro_receive() is used in more than 100 drivers,
keep it in <linux/netdevice.h>.
This does not make GRO ready to use outside of the NAPI context
yet.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/netdevice.h                  | 35 ++++++++---
 include/net/busy_poll.h                    | 11 +++-
 include/net/gro.h                          | 35 +++++++----
 drivers/net/ethernet/brocade/bna/bnad.c    |  1 +
 drivers/net/ethernet/cortina/gemini.c      |  1 +
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c |  1 +
 net/core/dev.c                             | 62 +++++++++----------
 net/core/gro.c                             | 69 +++++++++++-----------
 8 files changed, 124 insertions(+), 91 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e84602e0226c..bab716f86686 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -339,11 +339,27 @@ struct gro_list {
 };
 
 /*
- * size of gro hash buckets, must less than bit number of
- * napi_struct::gro_bitmask
+ * size of gro hash buckets, must be <= the number of bits in
+ * gro_node::bitmask
  */
 #define GRO_HASH_BUCKETS	8
 
+/**
+ * struct gro_node - structure to implement Generic Receive Offload
+ * @bitmask: mask of used @hash buckets
+ * @hash: lists of pending GRO skbs sorted by flows
+ * @rx_list: list of pending ``GRO_NORMAL`` skbs
+ * @rx_count: length of rx_list
+ * @napi_id: ID of the NAPI owning this node (0 if outside of NAPI)
+ */
+struct gro_node {
+	unsigned long		bitmask;
+	struct gro_list		hash[GRO_HASH_BUCKETS];
+	struct list_head	rx_list;
+	int			rx_count;
+	u32			napi_id;
+};
+
 /*
  * Structure for per-NAPI config
  */
@@ -369,7 +385,6 @@ struct napi_struct {
 	unsigned long		state;
 	int			weight;
 	u32			defer_hard_irqs_count;
-	unsigned long		gro_bitmask;
 	int			(*poll)(struct napi_struct *, int);
 #ifdef CONFIG_NETPOLL
 	/* CPU actively polling if netpoll is configured */
@@ -378,10 +393,8 @@ struct napi_struct {
 	/* CPU on which NAPI has been scheduled for processing */
 	int			list_owner;
 	struct net_device	*dev;
-	struct gro_list		gro_hash[GRO_HASH_BUCKETS];
+	struct gro_node		gro;
 	struct sk_buff		*skb;
-	struct list_head	rx_list; /* Pending GRO_NORMAL skbs */
-	int			rx_count; /* length of rx_list */
 	unsigned int		napi_id;
 	struct hrtimer		timer;
 	struct task_struct	*thread;
@@ -4015,8 +4028,14 @@ int netif_receive_skb(struct sk_buff *skb);
 int netif_receive_skb_core(struct sk_buff *skb);
 void netif_receive_skb_list_internal(struct list_head *head);
 void netif_receive_skb_list(struct list_head *head);
-gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb);
-void napi_gro_flush(struct napi_struct *napi, bool flush_old);
+gro_result_t gro_receive_skb(struct gro_node *gro, struct sk_buff *skb);
+
+static inline gro_result_t napi_gro_receive(struct napi_struct *napi,
+					    struct sk_buff *skb)
+{
+	return gro_receive_skb(&napi->gro, skb);
+}
+
 struct sk_buff *napi_get_frags(struct napi_struct *napi);
 void napi_get_frags_check(struct napi_struct *napi);
 gro_result_t napi_gro_frags(struct napi_struct *napi);
diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index c858270141bc..d31c8cb9e578 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -122,18 +122,23 @@ static inline void sk_busy_loop(struct sock *sk, int nonblock)
 }
 
 /* used in the NIC receive handler to mark the skb */
-static inline void skb_mark_napi_id(struct sk_buff *skb,
-				    struct napi_struct *napi)
+static inline void __skb_mark_napi_id(struct sk_buff *skb, u32 napi_id)
 {
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	/* If the skb was already marked with a valid NAPI ID, avoid overwriting
 	 * it.
 	 */
 	if (skb->napi_id < MIN_NAPI_ID)
-		skb->napi_id = napi->napi_id;
+		skb->napi_id = napi_id;
 #endif
 }
 
+static inline void skb_mark_napi_id(struct sk_buff *skb,
+				    struct napi_struct *napi)
+{
+	__skb_mark_napi_id(skb, napi->napi_id);
+}
+
 /* used in the protocol handler to propagate the napi_id to the socket */
 static inline void sk_mark_napi_id(struct sock *sk, const struct sk_buff *skb)
 {
diff --git a/include/net/gro.h b/include/net/gro.h
index b9b58c1f8d19..7aad366452d6 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -506,26 +506,41 @@ static inline int gro_receive_network_flush(const void *th, const void *th2,
 
 int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb);
 int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb);
+void __gro_flush(struct gro_node *gro, bool flush_old);
+
+static inline void gro_flush(struct gro_node *gro, bool flush_old)
+{
+	if (!gro->bitmask)
+		return;
+
+	__gro_flush(gro, flush_old);
+}
+
+static inline void napi_gro_flush(struct napi_struct *napi, bool flush_old)
+{
+	gro_flush(&napi->gro, flush_old);
+}
 
 /* Pass the currently batched GRO_NORMAL SKBs up to the stack. */
-static inline void gro_normal_list(struct napi_struct *napi)
+static inline void gro_normal_list(struct gro_node *gro)
 {
-	if (!napi->rx_count)
+	if (!gro->rx_count)
 		return;
-	netif_receive_skb_list_internal(&napi->rx_list);
-	INIT_LIST_HEAD(&napi->rx_list);
-	napi->rx_count = 0;
+	netif_receive_skb_list_internal(&gro->rx_list);
+	INIT_LIST_HEAD(&gro->rx_list);
+	gro->rx_count = 0;
 }
 
 /* Queue one GRO_NORMAL SKB up for list processing. If batch size exceeded,
  * pass the whole batch up to the stack.
  */
-static inline void gro_normal_one(struct napi_struct *napi, struct sk_buff *skb, int segs)
+static inline void gro_normal_one(struct gro_node *gro, struct sk_buff *skb,
+				  int segs)
 {
-	list_add_tail(&skb->list, &napi->rx_list);
-	napi->rx_count += segs;
-	if (napi->rx_count >= READ_ONCE(net_hotdata.gro_normal_batch))
-		gro_normal_list(napi);
+	list_add_tail(&skb->list, &gro->rx_list);
+	gro->rx_count += segs;
+	if (gro->rx_count >= READ_ONCE(net_hotdata.gro_normal_batch))
+		gro_normal_list(gro);
 }
 
 /* This function is the alternative of 'inet_iif' and 'inet_sdif'
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index ece6f3b48327..3b9107003b00 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -19,6 +19,7 @@
 #include <linux/ip.h>
 #include <linux/prefetch.h>
 #include <linux/module.h>
+#include <net/gro.h>
 
 #include "bnad.h"
 #include "bna.h"
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 991e3839858b..1f8067bdd61a 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -40,6 +40,7 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <net/gro.h>
 
 #include "gemini.h"
 
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index 7a9c09cd4fdc..6a7a26085fc7 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -41,6 +41,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <net/gro.h>
 
 #include "t7xx_dpmaif.h"
 #include "t7xx_hif_dpmaif.h"
diff --git a/net/core/dev.c b/net/core/dev.c
index e7223972b9aa..1f4e2a0ef1da 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6237,7 +6237,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 		return false;
 
 	if (work_done) {
-		if (n->gro_bitmask)
+		if (n->gro.bitmask)
 			timeout = napi_get_gro_flush_timeout(n);
 		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
 	}
@@ -6247,15 +6247,14 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 		if (timeout)
 			ret = false;
 	}
-	if (n->gro_bitmask) {
-		/* When the NAPI instance uses a timeout and keeps postponing
-		 * it, we need to bound somehow the time packets are kept in
-		 * the GRO layer
-		 */
-		napi_gro_flush(n, !!timeout);
-	}
 
-	gro_normal_list(n);
+	/*
+	 * When the NAPI instance uses a timeout and keeps postponing
+	 * it, we need to bound somehow the time packets are kept in
+	 * the GRO layer.
+	 */
+	gro_flush(&n->gro, !!timeout);
+	gro_normal_list(&n->gro);
 
 	if (unlikely(!list_empty(&n->poll_list))) {
 		/* If n->poll_list is not empty, we need to mask irqs */
@@ -6332,19 +6331,15 @@ static void skb_defer_free_flush(struct softnet_data *sd)
 static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
 {
 	if (!skip_schedule) {
-		gro_normal_list(napi);
+		gro_normal_list(&napi->gro);
 		__napi_schedule(napi);
 		return;
 	}
 
-	if (napi->gro_bitmask) {
-		/* flush too old packets
-		 * If HZ < 1000, flush all packets.
-		 */
-		napi_gro_flush(napi, HZ >= 1000);
-	}
+	/* Flush too old packets. If HZ < 1000, flush all packets */
+	gro_flush(&napi->gro, HZ >= 1000);
+	gro_normal_list(&napi->gro);
 
-	gro_normal_list(napi);
 	clear_bit(NAPI_STATE_SCHED, &napi->state);
 }
 
@@ -6451,7 +6446,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 		}
 		work = napi_poll(napi, budget);
 		trace_napi_poll(napi, work, budget);
-		gro_normal_list(napi);
+		gro_normal_list(&napi->gro);
 count:
 		if (work > 0)
 			__NET_ADD_STATS(dev_net(napi->dev),
@@ -6554,6 +6549,8 @@ static void __napi_hash_add_with_id(struct napi_struct *napi,
 	napi->napi_id = napi_id;
 	hlist_add_head_rcu(&napi->napi_hash_node,
 			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
+
+	napi->gro.napi_id = napi_id;
 }
 
 static void napi_hash_add_with_id(struct napi_struct *napi,
@@ -6624,10 +6621,10 @@ static void init_gro_hash(struct napi_struct *napi)
 	int i;
 
 	for (i = 0; i < GRO_HASH_BUCKETS; i++) {
-		INIT_LIST_HEAD(&napi->gro_hash[i].list);
-		napi->gro_hash[i].count = 0;
+		INIT_LIST_HEAD(&napi->gro.hash[i].list);
+		napi->gro.hash[i].count = 0;
 	}
-	napi->gro_bitmask = 0;
+	napi->gro.bitmask = 0;
 }
 
 int dev_set_threaded(struct net_device *dev, bool threaded)
@@ -6743,8 +6740,8 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	napi->timer.function = napi_watchdog;
 	init_gro_hash(napi);
 	napi->skb = NULL;
-	INIT_LIST_HEAD(&napi->rx_list);
-	napi->rx_count = 0;
+	INIT_LIST_HEAD(&napi->gro.rx_list);
+	napi->gro.rx_count = 0;
 	napi->poll = poll;
 	if (weight > NAPI_POLL_WEIGHT)
 		netdev_err_once(dev, "%s() called with weight %d\n", __func__,
@@ -6838,9 +6835,9 @@ static void flush_gro_hash(struct napi_struct *napi)
 	for (i = 0; i < GRO_HASH_BUCKETS; i++) {
 		struct sk_buff *skb, *n;
 
-		list_for_each_entry_safe(skb, n, &napi->gro_hash[i].list, list)
+		list_for_each_entry_safe(skb, n, &napi->gro.hash[i].list, list)
 			kfree_skb(skb);
-		napi->gro_hash[i].count = 0;
+		napi->gro.hash[i].count = 0;
 	}
 }
 
@@ -6859,7 +6856,7 @@ void __netif_napi_del(struct napi_struct *napi)
 	napi_free_frags(napi);
 
 	flush_gro_hash(napi);
-	napi->gro_bitmask = 0;
+	napi->gro.bitmask = 0;
 
 	if (napi->thread) {
 		kthread_stop(napi->thread);
@@ -6918,14 +6915,9 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 		return work;
 	}
 
-	if (n->gro_bitmask) {
-		/* flush too old packets
-		 * If HZ < 1000, flush all packets.
-		 */
-		napi_gro_flush(n, HZ >= 1000);
-	}
-
-	gro_normal_list(n);
+	/* Flush too old packets. If HZ < 1000, flush all packets */
+	gro_flush(&n->gro, HZ >= 1000);
+	gro_normal_list(&n->gro);
 
 	/* Some drivers may have called napi_schedule
 	 * prior to exhausting their budget.
@@ -11887,7 +11879,7 @@ static struct hlist_head * __net_init netdev_create_hash(void)
 static int __net_init netdev_init(struct net *net)
 {
 	BUILD_BUG_ON(GRO_HASH_BUCKETS >
-		     8 * sizeof_field(struct napi_struct, gro_bitmask));
+		     BITS_PER_BYTE * sizeof_field(struct gro_node, bitmask));
 
 	INIT_LIST_HEAD(&net->dev_base_head);
 
diff --git a/net/core/gro.c b/net/core/gro.c
index d1f44084e978..77ec10d9cd43 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -253,8 +253,7 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	return 0;
 }
 
-
-static void napi_gro_complete(struct napi_struct *napi, struct sk_buff *skb)
+static void gro_complete(struct gro_node *gro, struct sk_buff *skb)
 {
 	struct list_head *head = &net_hotdata.offload_base;
 	struct packet_offload *ptype;
@@ -287,43 +286,43 @@ static void napi_gro_complete(struct napi_struct *napi, struct sk_buff *skb)
 	}
 
 out:
-	gro_normal_one(napi, skb, NAPI_GRO_CB(skb)->count);
+	gro_normal_one(gro, skb, NAPI_GRO_CB(skb)->count);
 }
 
-static void __napi_gro_flush_chain(struct napi_struct *napi, u32 index,
-				   bool flush_old)
+static void __gro_flush_chain(struct gro_node *gro, u32 index, bool flush_old)
 {
-	struct list_head *head = &napi->gro_hash[index].list;
+	struct list_head *head = &gro->hash[index].list;
 	struct sk_buff *skb, *p;
 
 	list_for_each_entry_safe_reverse(skb, p, head, list) {
 		if (flush_old && NAPI_GRO_CB(skb)->age == jiffies)
 			return;
 		skb_list_del_init(skb);
-		napi_gro_complete(napi, skb);
-		napi->gro_hash[index].count--;
+		gro_complete(gro, skb);
+		gro->hash[index].count--;
 	}
 
-	if (!napi->gro_hash[index].count)
-		__clear_bit(index, &napi->gro_bitmask);
+	if (!gro->hash[index].count)
+		__clear_bit(index, &gro->bitmask);
 }
 
-/* napi->gro_hash[].list contains packets ordered by age.
+/*
+ * gro->hash[].list contains packets ordered by age.
  * youngest packets at the head of it.
  * Complete skbs in reverse order to reduce latencies.
  */
-void napi_gro_flush(struct napi_struct *napi, bool flush_old)
+void __gro_flush(struct gro_node *gro, bool flush_old)
 {
-	unsigned long bitmask = napi->gro_bitmask;
+	unsigned long bitmask = gro->bitmask;
 	unsigned int i, base = ~0U;
 
 	while ((i = ffs(bitmask)) != 0) {
 		bitmask >>= i;
 		base += i;
-		__napi_gro_flush_chain(napi, base, flush_old);
+		__gro_flush_chain(gro, base, flush_old);
 	}
 }
-EXPORT_SYMBOL(napi_gro_flush);
+EXPORT_SYMBOL(__gro_flush);
 
 static unsigned long gro_list_prepare_tc_ext(const struct sk_buff *skb,
 					     const struct sk_buff *p,
@@ -442,7 +441,7 @@ static void gro_try_pull_from_frag0(struct sk_buff *skb)
 		gro_pull_from_frag0(skb, grow);
 }
 
-static void gro_flush_oldest(struct napi_struct *napi, struct list_head *head)
+static void gro_flush_oldest(struct gro_node *gro, struct list_head *head)
 {
 	struct sk_buff *oldest;
 
@@ -458,14 +457,15 @@ static void gro_flush_oldest(struct napi_struct *napi, struct list_head *head)
 	 * SKB to the chain.
 	 */
 	skb_list_del_init(oldest);
-	napi_gro_complete(napi, oldest);
+	gro_complete(gro, oldest);
 }
 
-static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff *skb)
+static enum gro_result dev_gro_receive(struct gro_node *gro,
+				       struct sk_buff *skb)
 {
 	u32 bucket = skb_get_hash_raw(skb) & (GRO_HASH_BUCKETS - 1);
-	struct gro_list *gro_list = &napi->gro_hash[bucket];
 	struct list_head *head = &net_hotdata.offload_base;
+	struct gro_list *gro_list = &gro->hash[bucket];
 	struct packet_offload *ptype;
 	__be16 type = skb->protocol;
 	struct sk_buff *pp = NULL;
@@ -529,7 +529,7 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 
 	if (pp) {
 		skb_list_del_init(pp);
-		napi_gro_complete(napi, pp);
+		gro_complete(gro, pp);
 		gro_list->count--;
 	}
 
@@ -540,7 +540,7 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 		goto normal;
 
 	if (unlikely(gro_list->count >= MAX_GRO_SKBS))
-		gro_flush_oldest(napi, &gro_list->list);
+		gro_flush_oldest(gro, &gro_list->list);
 	else
 		gro_list->count++;
 
@@ -554,10 +554,10 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 	ret = GRO_HELD;
 ok:
 	if (gro_list->count) {
-		if (!test_bit(bucket, &napi->gro_bitmask))
-			__set_bit(bucket, &napi->gro_bitmask);
-	} else if (test_bit(bucket, &napi->gro_bitmask)) {
-		__clear_bit(bucket, &napi->gro_bitmask);
+		if (!test_bit(bucket, &gro->bitmask))
+			__set_bit(bucket, &gro->bitmask);
+	} else if (test_bit(bucket, &gro->bitmask)) {
+		__clear_bit(bucket, &gro->bitmask);
 	}
 
 	return ret;
@@ -596,13 +596,12 @@ struct packet_offload *gro_find_complete_by_type(__be16 type)
 }
 EXPORT_SYMBOL(gro_find_complete_by_type);
 
-static gro_result_t napi_skb_finish(struct napi_struct *napi,
-				    struct sk_buff *skb,
-				    gro_result_t ret)
+static gro_result_t gro_skb_finish(struct gro_node *gro, struct sk_buff *skb,
+				   gro_result_t ret)
 {
 	switch (ret) {
 	case GRO_NORMAL:
-		gro_normal_one(napi, skb, 1);
+		gro_normal_one(gro, skb, 1);
 		break;
 
 	case GRO_MERGED_FREE:
@@ -623,21 +622,21 @@ static gro_result_t napi_skb_finish(struct napi_struct *napi,
 	return ret;
 }
 
-gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb)
+gro_result_t gro_receive_skb(struct gro_node *gro, struct sk_buff *skb)
 {
 	gro_result_t ret;
 
-	skb_mark_napi_id(skb, napi);
+	__skb_mark_napi_id(skb, gro->napi_id);
 	trace_napi_gro_receive_entry(skb);
 
 	skb_gro_reset_offset(skb, 0);
 
-	ret = napi_skb_finish(napi, skb, dev_gro_receive(napi, skb));
+	ret = gro_skb_finish(gro, skb, dev_gro_receive(gro, skb));
 	trace_napi_gro_receive_exit(ret);
 
 	return ret;
 }
-EXPORT_SYMBOL(napi_gro_receive);
+EXPORT_SYMBOL(gro_receive_skb);
 
 static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 {
@@ -693,7 +692,7 @@ static gro_result_t napi_frags_finish(struct napi_struct *napi,
 		__skb_push(skb, ETH_HLEN);
 		skb->protocol = eth_type_trans(skb, skb->dev);
 		if (ret == GRO_NORMAL)
-			gro_normal_one(napi, skb, 1);
+			gro_normal_one(&napi->gro, skb, 1);
 		break;
 
 	case GRO_MERGED_FREE:
@@ -762,7 +761,7 @@ gro_result_t napi_gro_frags(struct napi_struct *napi)
 
 	trace_napi_gro_frags_entry(skb);
 
-	ret = napi_frags_finish(napi, skb, dev_gro_receive(napi, skb));
+	ret = napi_frags_finish(napi, skb, dev_gro_receive(&napi->gro, skb));
 	trace_napi_gro_frags_exit(ret);
 
 	return ret;
-- 
2.47.1


