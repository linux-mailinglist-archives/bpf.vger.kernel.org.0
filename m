Return-Path: <bpf+bounces-52549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6A9A44811
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B14516C8E2
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D741A23BB;
	Tue, 25 Feb 2025 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ednl5erx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9E619992E;
	Tue, 25 Feb 2025 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504292; cv=none; b=cLdmqflXuXyCOBtFZ+4U7sckxcYpl4J/06hhYB9xLdlmZWSRufGS96skyKKZvKS42mPGWptTY2pAp/hSHpmdXoq84K991BKYxGgneWTPMk0C4W9g0Ky/ZV5wW+20wpBI2AS4K1RGgjiPZKxtZGMWVDhdxoCLIMffcefu2HfnRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504292; c=relaxed/simple;
	bh=IvnjDQh7UZAMI+TirlbcH5qxYIQfFE7GLFGMTzd8fM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nguGlsc0v7uXHkJ6tw2NAQFwxNiBNMV3M3V5wBZBGonE5XCZrpbChCM1UDJAsvo7zrAr+/Td5zvJnHgW+0R9t7acDfcaFfKsZconPGmNFx5owtl41Av1pupr3po47pUlR5JThvTvqhaFLM8KIucgR/cyOA1NOGJi5NdhnI0Skvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ednl5erx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740504291; x=1772040291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IvnjDQh7UZAMI+TirlbcH5qxYIQfFE7GLFGMTzd8fM8=;
  b=Ednl5erxR5eZYHaDT9J1heapEWbkqYdtm0snZkis7mXH2iPeFxVWg1uJ
   vLX4M/q0fCSpLOA0qnrCDEq38pTHG8dbDqBx9Ruy0XUk1QGRTCR7mX5YF
   dOxUdclOoTdgGac4Madv4p0Uz8WyATHfG+rCmrrtQNoqFH2alzQRHR9iv
   ri2pJWMI0H6FOedhuDP3f1fMp0gKa6xC0xXHj5/49pCzt3pN4Ly5Wzye5
   klgliZhdfnq69ZdklkP1rXE62Goyx3SGI0euaTxmdqV10Q/k6aZ7T9CLd
   otRL1o3miPy41YpunQvHqLgp5o9VIF4Ccef+Wu9PbpX9I4edEUa3B5lk4
   g==;
X-CSE-ConnectionGUID: 7GuMniXqQBOGagoiGwa23Q==
X-CSE-MsgGUID: 0edAOWACS+OJtK3QSZVvng==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="44974135"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="44974135"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:24:51 -0800
X-CSE-ConnectionGUID: dof8zh5JScavLF97eYbYPA==
X-CSE-MsgGUID: ZFaEO5UvStSH4HoZOgiNnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116256905"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa006.fm.intel.com with ESMTP; 25 Feb 2025 09:24:46 -0800
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
Subject: [PATCH net-next v5 4/8] bpf: cpumap: reuse skb array instead of a linked list to chain skbs
Date: Tue, 25 Feb 2025 18:17:46 +0100
Message-ID: <20250225171751.2268401-5-aleksander.lobakin@intel.com>
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

Tested-by: Daniel Xu <dxu@dxuuu.xyz>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 kernel/bpf/cpumap.c | 119 +++++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 58 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index f0909736eaa5..85936f09d8d7 100644
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
@@ -205,7 +209,6 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 				stats->drop++;
 			} else {
 				frames[nframes++] = xdpf;
-				stats->pass++;
 			}
 			break;
 		case XDP_REDIRECT:
@@ -229,48 +232,44 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 	}
 
 	xdp_clear_return_frame_no_direct();
+	stats->pass += nframes;
 
 	return nframes;
 }
 
 #define CPUMAP_BATCH 8
 
-static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
-				int xdp_n, struct xdp_cpumap_stats *stats,
-				struct list_head *list)
+struct cpu_map_ret {
+	u32 xdp_n;
+	u32 skb_n;
+};
+
+static void cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
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
-
-	list_for_each_entry_safe(skb, tmp, list, list) {
-		skb_list_del_init(skb);
-		gro_receive_skb(&rcpu->gro, skb);
-	}
+out:
+	if (unlikely(ret->skb_n) && ret->xdp_n)
+		memmove(&skbs[ret->xdp_n], skbs, ret->skb_n * sizeof(*skbs));
 }
 
 static void cpu_map_gro_flush(struct bpf_cpu_map_entry *rcpu, bool empty)
@@ -305,10 +304,10 @@ static int cpu_map_kthread_run(void *data)
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
@@ -334,7 +333,7 @@ static int cpu_map_kthread_run(void *data)
 		 */
 		n = __ptr_ring_consume_batched(rcpu->queue, frames,
 					       CPUMAP_BATCH);
-		for (i = 0, xdp_n = 0; i < n; i++) {
+		for (i = 0; i < n; i++) {
 			void *f = frames[i];
 			struct page *page;
 
@@ -342,11 +341,11 @@ static int cpu_map_kthread_run(void *data)
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
@@ -357,39 +356,43 @@ static int cpu_map_kthread_run(void *data)
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
+		cpu_map_bpf_prog_run(rcpu, frames, skbs, &ret, &stats);
+		if (!ret.xdp_n) {
+			local_bh_disable();
+			goto stats;
+		}
+
+		m = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache, gfp,
+					  ret.xdp_n, skbs);
+		if (unlikely(m < ret.xdp_n)) {
+			for (i = m; i < ret.xdp_n; i++)
+				xdp_return_frame(frames[i]);
+
+			if (ret.skb_n)
+				memmove(&skbs[m], &skbs[ret.xdp_n],
+					ret.skb_n * sizeof(*skbs));
+
+			kmem_alloc_drops += ret.xdp_n - m;
+			ret.xdp_n = m;
 		}
 
 		local_bh_disable();
-		for (i = 0; i < nframes; i++) {
+		for (i = 0; i < ret.xdp_n; i++) {
 			struct xdp_frame *xdpf = frames[i];
-			struct sk_buff *skb = skbs[i];
-
-			skb = __xdp_build_skb_from_frame(xdpf, skb,
-							 xdpf->dev_rx);
-			if (!skb) {
-				xdp_return_frame(xdpf);
-				continue;
-			}
 
-			list_add_tail(&skb->list, &list);
+			/* Can fail only when !skb -- already handled above */
+			__xdp_build_skb_from_frame(xdpf, skbs[i], xdpf->dev_rx);
 		}
 
+stats:
 		/* Feedback loop via tracepoint.
 		 * NB: keep before recv to allow measuring enqueue/dequeue latency.
 		 */
 		trace_xdp_cpumap_kthread(rcpu->map_id, n, kmem_alloc_drops,
 					 sched, &stats);
 
-		cpu_map_gro_receive(rcpu, &list);
+		for (i = 0; i < ret.xdp_n + ret.skb_n; i++)
+			gro_receive_skb(&rcpu->gro, skbs[i]);
 
 		/* Flush either every 64 packets or in case of empty ring */
 		packets += n;
-- 
2.48.1


