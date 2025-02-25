Return-Path: <bpf+bounces-52546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D49A44877
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3842E8661F3
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7E019B5A3;
	Tue, 25 Feb 2025 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJjb7lgl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1CA158520;
	Tue, 25 Feb 2025 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504279; cv=none; b=IH25TdNiKscG4w+THxGRqxc80NrOrUiXopmMpALTiUCnDUfWEOC1PMOLRhYfmOr8j6Yv2yi8X45RlOENDnDTyIAW29Ag0cTv24zUKMlJuVDL2+UT2iuCqupkYdUnF/7DPSeJ+8H49QBoeodfAVWssOY0z1YUTvgitjkNso4yB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504279; c=relaxed/simple;
	bh=ES2Ne8kzzvV8nTSmMaBEFhPnsihQ21QDwYPJkOhltvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZug1EmftFnL220XmoXeo3gUTFGZniy0SWbQpGJAqikIcf6nqUFElA1YnGjFCUNTS3C+ol5KCoViPyqRmLP8v1mKX8p5EMRpqfX75IQynKnFD5eTPinEy37LApXDuBKTzk5OexVrXX0jG6Q67asU1d/GvDpqSmVAnKEdNJj+VsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJjb7lgl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740504278; x=1772040278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ES2Ne8kzzvV8nTSmMaBEFhPnsihQ21QDwYPJkOhltvQ=;
  b=nJjb7lgleHFrBC2UMTDbdT0IiPCrFubEjjLf5B4GZUNBgYS6sUNrLiL9
   3FihIfnw+xgkgnjfsKk46gdXC3pDVRESinJuFf4cAEs5eHlnUYOSA6xPh
   UsbByU+n5l1N+F3HaWNPUMrl0EepCXuRvSJqX73lq6LYrBv50laa3+IF0
   1odhKWZv8GwznJof8fTA3VjHVe/8ziQ8Uoa87BX4qdeZ7JctUUSveCAL3
   sXmVzLBJ+RaQJBn7n1PKy78gQp1BvOwwNx52ZhWtUFOwPuSFcTgpgs6zY
   KB9gQnlscCwSL4Jx+Ef1sHVJLPXJ/4Nlx1bmBVrwu1CZGoMGk+zFUGiWP
   w==;
X-CSE-ConnectionGUID: w0c8AepwQ1qadf/si1b8hQ==
X-CSE-MsgGUID: NP/Rtp5HRC6Ahgkn9mVA6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="44974087"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="44974087"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:24:37 -0800
X-CSE-ConnectionGUID: lq6ZYj4dSa69CazjYyQ7KQ==
X-CSE-MsgGUID: uyaSZb31RC2k2w8nyfOYAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116256866"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa006.fm.intel.com with ESMTP; 25 Feb 2025 09:24:33 -0800
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
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v5 1/8] net: gro: decouple GRO from the NAPI layer
Date: Tue, 25 Feb 2025 18:17:43 +0100
Message-ID: <20250225171751.2268401-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225171751.2268401-1-aleksander.lobakin@intel.com>
References: <20250225171751.2268401-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In fact, these two are not tied closely to each other. The only
requirements to GRO are to use it in the BH context and have some
sane limits on the packet batches, e.g. NAPI has a limit of its
budget (64/8/etc.).
Move purely GRO fields into a new structure, &gro_node. Embed it
into &napi_struct and adjust all the references.
gro_node::cached_napi_id is effectively the same as
napi_struct::napi_id, but to be used on GRO hotpath to mark skbs.
napi_struct::napi_id is now a fully control path field.

Three Ethernet drivers use napi_gro_flush() not really meant to be
exported, so move it to <net/gro.h> and add that include there.
napi_gro_receive() is used in more than 100 drivers, keep it
in <linux/netdevice.h>.
This does not make GRO ready to use outside of the NAPI context
yet.

Tested-by: Daniel Xu <dxu@dxuuu.xyz>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdevice.h                  | 37 +++++++++---
 include/net/busy_poll.h                    | 12 +++-
 include/net/gro.h                          | 35 +++++++----
 drivers/net/ethernet/brocade/bna/bnad.c    |  1 +
 drivers/net/ethernet/cortina/gemini.c      |  1 +
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c |  1 +
 net/core/dev.c                             | 66 ++++++++++-----------
 net/core/gro.c                             | 69 +++++++++++-----------
 8 files changed, 130 insertions(+), 92 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9a387d456592..fe0d889960bb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -340,11 +340,27 @@ struct gro_list {
 };
 
 /*
- * size of gro hash buckets, must less than bit number of
- * napi_struct::gro_bitmask
+ * size of gro hash buckets, must be <= the number of bits in
+ * gro_node::bitmask
  */
 #define GRO_HASH_BUCKETS	8
 
+/**
+ * struct gro_node - structure to support Generic Receive Offload
+ * @bitmask: bitmask to indicate used buckets in @hash
+ * @hash: hashtable of pending aggregated skbs, separated by flows
+ * @rx_list: list of pending ``GRO_NORMAL`` skbs
+ * @rx_count: cached current length of @rx_list
+ * @cached_napi_id: napi_struct::napi_id cached for hotpath, 0 for standalone
+ */
+struct gro_node {
+	unsigned long		bitmask;
+	struct gro_list		hash[GRO_HASH_BUCKETS];
+	struct list_head	rx_list;
+	u32			rx_count;
+	u32			cached_napi_id;
+};
+
 /*
  * Structure for per-NAPI config
  */
@@ -370,7 +386,6 @@ struct napi_struct {
 	unsigned long		state;
 	int			weight;
 	u32			defer_hard_irqs_count;
-	unsigned long		gro_bitmask;
 	int			(*poll)(struct napi_struct *, int);
 #ifdef CONFIG_NETPOLL
 	/* CPU actively polling if netpoll is configured */
@@ -379,11 +394,8 @@ struct napi_struct {
 	/* CPU on which NAPI has been scheduled for processing */
 	int			list_owner;
 	struct net_device	*dev;
-	struct gro_list		gro_hash[GRO_HASH_BUCKETS];
 	struct sk_buff		*skb;
-	struct list_head	rx_list; /* Pending GRO_NORMAL skbs */
-	int			rx_count; /* length of rx_list */
-	unsigned int		napi_id; /* protected by netdev_lock */
+	struct gro_node		gro;
 	struct hrtimer		timer;
 	/* all fields past this point are write-protected by netdev_lock */
 	struct task_struct	*thread;
@@ -391,6 +403,7 @@ struct napi_struct {
 	unsigned long		irq_suspend_timeout;
 	u32			defer_hard_irqs;
 	/* control-path-only fields follow */
+	u32			napi_id;
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
 	int			irq;
@@ -4115,8 +4128,14 @@ int netif_receive_skb(struct sk_buff *skb);
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
 gro_result_t napi_gro_frags(struct napi_struct *napi);
 
diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index cab6146a510a..6e172d0f6ef5 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -127,18 +127,24 @@ static inline void sk_busy_loop(struct sock *sk, int nonblock)
 }
 
 /* used in the NIC receive handler to mark the skb */
-static inline void skb_mark_napi_id(struct sk_buff *skb,
-				    struct napi_struct *napi)
+static inline void __skb_mark_napi_id(struct sk_buff *skb,
+				      const struct gro_node *gro)
 {
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	/* If the skb was already marked with a valid NAPI ID, avoid overwriting
 	 * it.
 	 */
 	if (!napi_id_valid(skb->napi_id))
-		skb->napi_id = napi->napi_id;
+		skb->napi_id = gro->cached_napi_id;
 #endif
 }
 
+static inline void skb_mark_napi_id(struct sk_buff *skb,
+				    const struct napi_struct *napi)
+{
+	__skb_mark_napi_id(skb, &napi->gro);
+}
+
 /* used in the protocol handler to propagate the napi_id to the socket */
 static inline void sk_mark_napi_id(struct sock *sk, const struct sk_buff *skb)
 {
diff --git a/include/net/gro.h b/include/net/gro.h
index 7b548f91754b..38d70c69ff80 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -509,26 +509,41 @@ static inline int gro_receive_network_flush(const void *th, const void *th2,
 
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
index 3f525278a871..ef66e8aaca19 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6484,7 +6484,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 		return false;
 
 	if (work_done) {
-		if (n->gro_bitmask)
+		if (n->gro.bitmask)
 			timeout = napi_get_gro_flush_timeout(n);
 		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
 	}
@@ -6494,15 +6494,14 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
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
@@ -6566,19 +6565,15 @@ static void skb_defer_free_flush(struct softnet_data *sd)
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
 
@@ -6685,7 +6680,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 		}
 		work = napi_poll(napi, budget);
 		trace_napi_poll(napi, work, budget);
-		gro_normal_list(napi);
+		gro_normal_list(&napi->gro);
 count:
 		if (work > 0)
 			__NET_ADD_STATS(dev_net(napi->dev),
@@ -6785,6 +6780,8 @@ void napi_resume_irqs(unsigned int napi_id)
 static void __napi_hash_add_with_id(struct napi_struct *napi,
 				    unsigned int napi_id)
 {
+	napi->gro.cached_napi_id = napi_id;
+
 	WRITE_ONCE(napi->napi_id, napi_id);
 	hlist_add_head_rcu(&napi->napi_hash_node,
 			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
@@ -6858,10 +6855,12 @@ static void init_gro_hash(struct napi_struct *napi)
 	int i;
 
 	for (i = 0; i < GRO_HASH_BUCKETS; i++) {
-		INIT_LIST_HEAD(&napi->gro_hash[i].list);
-		napi->gro_hash[i].count = 0;
+		INIT_LIST_HEAD(&napi->gro.hash[i].list);
+		napi->gro.hash[i].count = 0;
 	}
-	napi->gro_bitmask = 0;
+
+	napi->gro.bitmask = 0;
+	napi->gro.cached_napi_id = 0;
 }
 
 int dev_set_threaded(struct net_device *dev, bool threaded)
@@ -7029,8 +7028,8 @@ void netif_napi_add_weight_locked(struct net_device *dev,
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
@@ -7151,10 +7150,13 @@ static void flush_gro_hash(struct napi_struct *napi)
 	for (i = 0; i < GRO_HASH_BUCKETS; i++) {
 		struct sk_buff *skb, *n;
 
-		list_for_each_entry_safe(skb, n, &napi->gro_hash[i].list, list)
+		list_for_each_entry_safe(skb, n, &napi->gro.hash[i].list, list)
 			kfree_skb(skb);
-		napi->gro_hash[i].count = 0;
+		napi->gro.hash[i].count = 0;
 	}
+
+	napi->gro.bitmask = 0;
+	napi->gro.cached_napi_id = 0;
 }
 
 /* Must be called in process context */
@@ -7177,7 +7179,6 @@ void __netif_napi_del_locked(struct napi_struct *napi)
 	napi_free_frags(napi);
 
 	flush_gro_hash(napi);
-	napi->gro_bitmask = 0;
 
 	if (napi->thread) {
 		kthread_stop(napi->thread);
@@ -7236,14 +7237,9 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
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
@@ -12270,7 +12266,7 @@ static struct hlist_head * __net_init netdev_create_hash(void)
 static int __net_init netdev_init(struct net *net)
 {
 	BUILD_BUG_ON(GRO_HASH_BUCKETS >
-		     8 * sizeof_field(struct napi_struct, gro_bitmask));
+		     BITS_PER_BYTE * sizeof_field(struct gro_node, bitmask));
 
 	INIT_LIST_HEAD(&net->dev_base_head);
 
diff --git a/net/core/gro.c b/net/core/gro.c
index 78b320b63174..9e1803fdf249 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -250,8 +250,7 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	return 0;
 }
 
-
-static void napi_gro_complete(struct napi_struct *napi, struct sk_buff *skb)
+static void gro_complete(struct gro_node *gro, struct sk_buff *skb)
 {
 	struct list_head *head = &net_hotdata.offload_base;
 	struct packet_offload *ptype;
@@ -284,43 +283,43 @@ static void napi_gro_complete(struct napi_struct *napi, struct sk_buff *skb)
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
@@ -439,7 +438,7 @@ static void gro_try_pull_from_frag0(struct sk_buff *skb)
 		gro_pull_from_frag0(skb, grow);
 }
 
-static void gro_flush_oldest(struct napi_struct *napi, struct list_head *head)
+static void gro_flush_oldest(struct gro_node *gro, struct list_head *head)
 {
 	struct sk_buff *oldest;
 
@@ -455,14 +454,15 @@ static void gro_flush_oldest(struct napi_struct *napi, struct list_head *head)
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
@@ -526,7 +526,7 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 
 	if (pp) {
 		skb_list_del_init(pp);
-		napi_gro_complete(napi, pp);
+		gro_complete(gro, pp);
 		gro_list->count--;
 	}
 
@@ -537,7 +537,7 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 		goto normal;
 
 	if (unlikely(gro_list->count >= MAX_GRO_SKBS))
-		gro_flush_oldest(napi, &gro_list->list);
+		gro_flush_oldest(gro, &gro_list->list);
 	else
 		gro_list->count++;
 
@@ -551,10 +551,10 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
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
@@ -593,13 +593,12 @@ struct packet_offload *gro_find_complete_by_type(__be16 type)
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
@@ -620,21 +619,21 @@ static gro_result_t napi_skb_finish(struct napi_struct *napi,
 	return ret;
 }
 
-gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb)
+gro_result_t gro_receive_skb(struct gro_node *gro, struct sk_buff *skb)
 {
 	gro_result_t ret;
 
-	skb_mark_napi_id(skb, napi);
+	__skb_mark_napi_id(skb, gro);
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
@@ -690,7 +689,7 @@ static gro_result_t napi_frags_finish(struct napi_struct *napi,
 		__skb_push(skb, ETH_HLEN);
 		skb->protocol = eth_type_trans(skb, skb->dev);
 		if (ret == GRO_NORMAL)
-			gro_normal_one(napi, skb, 1);
+			gro_normal_one(&napi->gro, skb, 1);
 		break;
 
 	case GRO_MERGED_FREE:
@@ -759,7 +758,7 @@ gro_result_t napi_gro_frags(struct napi_struct *napi)
 
 	trace_napi_gro_frags_entry(skb);
 
-	ret = napi_frags_finish(napi, skb, dev_gro_receive(napi, skb));
+	ret = napi_frags_finish(napi, skb, dev_gro_receive(&napi->gro, skb));
 	trace_napi_gro_frags_exit(ret);
 
 	return ret;
-- 
2.48.1


