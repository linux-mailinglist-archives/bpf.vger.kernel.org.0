Return-Path: <bpf+bounces-48131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D16A04492
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 16:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A486D163D3B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289CA1F4E32;
	Tue,  7 Jan 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOTWETDd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA21F4720;
	Tue,  7 Jan 2025 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263887; cv=none; b=pzvN1sHROpcvRN/8D/k80w7sPrz/Xmwf6nmTcRk76vn9e9GI31cn9eArGCJic1eneDS0ZC0yKkXmhE9QQ0hqZG6SRMmSB/c8P2c/lEFV215e5HvR8HxYirAH6TIMoS0Rf218Z/qsvzYJBKdvjuBYYazf+ECTQth2FFXBbMoq7zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263887; c=relaxed/simple;
	bh=EJVKrzZ3U8cZ1BIoAwX4IvcYWXE+N/PdY69J6JCP71Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU2x2bteH7QEN17z45zpGXWNu4g8mEwKylht/npdHpBoad/molHPtM5cyzmIrQbOAyuXRygnbwAaGIAlb9Vs5ZeiGmtE4P/1R2+CAUXdGpM2JKwWCgcF/aB3X4esdikeFrsXDeMbzn4fTITQIudYGeAVUHyW8Q/KTkgSz1KGPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOTWETDd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736263884; x=1767799884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EJVKrzZ3U8cZ1BIoAwX4IvcYWXE+N/PdY69J6JCP71Q=;
  b=GOTWETDdHEs5Gqy/aUgW+sBL9RZTiHJ+JA6Qaq/YDmtv58ww56wZSNUQ
   3YfTxoSOf3LDyJQYeQ5PfIs+Whyq41JS2lzuQduu3A4yd0QvUUkyKx9lB
   J0eR7DYOkep2SnvQsoBlBBpYgG0ueXyGpVe+cFwK1jEcd4hmwhAEtH+u5
   R8+Z5LEOrH9jeOto46bilO291OSYmPfp+l9aFLaHJ7lMxVpYzAO+g03Y1
   FK2AbmsBcTVPxo5A+NANnxibnkjEVFmUxKe7RuM9bLnn6dK2lqQmG3xFJ
   rQVgY7LL2ARSOEpZiVLqLWv+ytj9q1Vp6Nk6AhvAn9Hng0kfLnYQoaRmQ
   g==;
X-CSE-ConnectionGUID: /+R/XmgXR7+ca3/5FIpdTQ==
X-CSE-MsgGUID: klkdy343Rtm98PaApKcqGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="35685840"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="35685840"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 07:31:22 -0800
X-CSE-ConnectionGUID: G3AdMh+/RHChJSvrudpQ9g==
X-CSE-MsgGUID: jyS6WQEnQcOhpPdMrcG9XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103646961"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 07 Jan 2025 07:31:18 -0800
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
Subject: [PATCH net-next v2 4/8] bpf: cpumap: reuse skb array instead of a linked list to chain skbs
Date: Tue,  7 Jan 2025 16:29:36 +0100
Message-ID: <20250107152940.26530-5-aleksander.lobakin@intel.com>
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

cpumap still uses linked lists to store a list of skbs to pass to the
stack. Now that we don't use listified Rx in favor of
napi_gro_receive(), linked list is now an unneeded overhead.
Inside the polling loop, we already have an array of skbs. Let's reuse
it for skbs passed to cpumap (generic XDP) and keep there in case of
XDP_PASS when a program is installed to the map itself. Don't list
regular xdp_frames after converting them to skbs as well; store them
in the mentioned array (but *before* generic skbs as the latters have
lower priority) and call gro_receive_skb() for each array element after
they're done.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/cpumap.c | 103 +++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 49 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 10d062dddb6f..4c3eeb931bff 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -134,22 +134,23 @@ static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 	}
 }
 
-static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
-				     struct list_head *listp,
-				     struct xdp_cpumap_stats *stats)
+static u32 cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
+				    void **skbs, u32 skb_n,
+				    struct xdp_cpumap_stats *stats)
 {
-	struct sk_buff *skb, *tmp;
 	struct xdp_buff xdp;
-	u32 act;
+	u32 act, pass = 0;
 	int err;
 
-	list_for_each_entry_safe(skb, tmp, listp, list) {
+	for (u32 i = 0; i < skb_n; i++) {
+		struct sk_buff *skb = skbs[i];
+
 		act = bpf_prog_run_generic_xdp(skb, &xdp, rcpu->prog);
 		switch (act) {
 		case XDP_PASS:
+			skbs[pass++] = skb;
 			break;
 		case XDP_REDIRECT:
-			skb_list_del_init(skb);
 			err = xdp_do_generic_redirect(skb->dev, skb, &xdp,
 						      rcpu->prog);
 			if (unlikely(err)) {
@@ -158,7 +159,7 @@ static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
 			} else {
 				stats->redirect++;
 			}
-			return;
+			break;
 		default:
 			bpf_warn_invalid_xdp_action(NULL, rcpu->prog, act);
 			fallthrough;
@@ -166,12 +167,15 @@ static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
 			trace_xdp_exception(skb->dev, rcpu->prog, act);
 			fallthrough;
 		case XDP_DROP:
-			skb_list_del_init(skb);
-			kfree_skb(skb);
+			napi_consume_skb(skb, true);
 			stats->drop++;
-			return;
+			break;
 		}
 	}
+
+	stats->pass += pass;
+
+	return pass;
 }
 
 static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
@@ -235,42 +239,39 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 #define CPUMAP_BATCH 8
 
-static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
-				int xdp_n, struct xdp_cpumap_stats *stats,
-				struct list_head *list)
+struct cpu_map_ret {
+	u32 xdp_n;
+	u32 skb_n;
+};
+
+static bool cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
+				 void **skbs, struct cpu_map_ret *ret,
+				 struct xdp_cpumap_stats *stats)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
-	int nframes;
 
 	if (!rcpu->prog)
-		return xdp_n;
+		goto out;
 
 	rcu_read_lock_bh();
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
-	nframes = cpu_map_bpf_prog_run_xdp(rcpu, frames, xdp_n, stats);
+	ret->xdp_n = cpu_map_bpf_prog_run_xdp(rcpu, frames, ret->xdp_n, stats);
+	if (unlikely(ret->skb_n))
+		ret->skb_n = cpu_map_bpf_prog_run_skb(rcpu, skbs, ret->skb_n,
+						      stats);
 
 	if (stats->redirect)
 		xdp_do_flush();
 
-	if (unlikely(!list_empty(list)))
-		cpu_map_bpf_prog_run_skb(rcpu, list, stats);
-
 	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock_bh(); /* resched point, may call do_softirq() */
 
-	return nframes;
-}
-
-static void cpu_map_gro_receive(struct bpf_cpu_map_entry *rcpu,
-				struct list_head *list)
-{
-	struct sk_buff *skb, *tmp;
+out:
+	if (unlikely(ret->skb_n) && ret->xdp_n)
+		memmove(&skbs[ret->xdp_n], skbs, ret->skb_n * sizeof(*skbs));
 
-	list_for_each_entry_safe(skb, tmp, list, list) {
-		skb_list_del_init(skb);
-		gro_receive_skb(&rcpu->gro, skb);
-	}
+	return !!*(const u64 *)ret;
 }
 
 static void cpu_map_gro_flush(struct bpf_cpu_map_entry *rcpu, bool empty)
@@ -305,10 +306,10 @@ static int cpu_map_kthread_run(void *data)
 		struct xdp_cpumap_stats stats = {}; /* zero stats */
 		unsigned int kmem_alloc_drops = 0, sched = 0;
 		gfp_t gfp = __GFP_ZERO | GFP_ATOMIC;
-		int i, n, m, nframes, xdp_n;
+		struct cpu_map_ret ret = { };
 		void *frames[CPUMAP_BATCH];
 		void *skbs[CPUMAP_BATCH];
-		LIST_HEAD(list);
+		u32 i, n, m;
 		bool empty;
 
 		/* Release CPU reschedule checks */
@@ -334,7 +335,7 @@ static int cpu_map_kthread_run(void *data)
 		 */
 		n = __ptr_ring_consume_batched(rcpu->queue, frames,
 					       CPUMAP_BATCH);
-		for (i = 0, xdp_n = 0; i < n; i++) {
+		for (i = 0; i < n; i++) {
 			void *f = frames[i];
 			struct page *page;
 
@@ -342,11 +343,11 @@ static int cpu_map_kthread_run(void *data)
 				struct sk_buff *skb = f;
 
 				__ptr_clear_bit(0, &skb);
-				list_add_tail(&skb->list, &list);
+				skbs[ret.skb_n++] = skb;
 				continue;
 			}
 
-			frames[xdp_n++] = f;
+			frames[ret.xdp_n++] = f;
 			page = virt_to_page(f);
 
 			/* Bring struct page memory area to curr CPU. Read by
@@ -357,19 +358,21 @@ static int cpu_map_kthread_run(void *data)
 		}
 
 		/* Support running another XDP prog on this CPU */
-		nframes = cpu_map_bpf_prog_run(rcpu, frames, xdp_n, &stats, &list);
-		if (nframes) {
-			m = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
-						  gfp, nframes, skbs);
-			if (unlikely(m == 0)) {
-				for (i = 0; i < nframes; i++)
-					skbs[i] = NULL; /* effect: xdp_return_frame */
-				kmem_alloc_drops += nframes;
-			}
+		if (!cpu_map_bpf_prog_run(rcpu, frames, skbs, &ret, &stats)) {
+			local_bh_disable();
+			goto stats;
+		}
+
+		m = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache, gfp,
+					  ret.xdp_n, skbs);
+		if (unlikely(!m)) {
+			for (i = 0; i < ret.xdp_n; i++)
+				skbs[i] = NULL; /* effect: xdp_return_frame */
+			kmem_alloc_drops += ret.xdp_n;
 		}
 
 		local_bh_disable();
-		for (i = 0; i < nframes; i++) {
+		for (i = 0; i < ret.xdp_n; i++) {
 			struct xdp_frame *xdpf = frames[i];
 			struct sk_buff *skb = skbs[i];
 
@@ -379,17 +382,19 @@ static int cpu_map_kthread_run(void *data)
 				xdp_return_frame(xdpf);
 				continue;
 			}
-
-			list_add_tail(&skb->list, &list);
 		}
 
+stats:
 		/* Feedback loop via tracepoint.
 		 * NB: keep before recv to allow measuring enqueue/dequeue latency.
 		 */
 		trace_xdp_cpumap_kthread(rcpu->map_id, n, kmem_alloc_drops,
 					 sched, &stats);
 
-		cpu_map_gro_receive(rcpu, &list);
+		for (i = 0; i < ret.xdp_n + ret.skb_n; i++) {
+			if (likely(skbs[i]))
+				gro_receive_skb(&rcpu->gro, skbs[i]);
+		}
 
 		/* Flush either every 64 packets or in case of empty ring */
 		empty = __ptr_ring_empty(rcpu->queue);
-- 
2.47.1


