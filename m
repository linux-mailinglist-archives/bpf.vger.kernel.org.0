Return-Path: <bpf+bounces-48940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0581EA1272F
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3BA18880B3
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362B719005D;
	Wed, 15 Jan 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecHW6R0U"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063118A6B2;
	Wed, 15 Jan 2025 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954398; cv=none; b=MgXZn2hqfOU/hj90mCIipBCochCT9JNtE/I8vwEjWnUWpOoCwl2UEZTIxgnuXC13A3lOw4IRtDrPExMsMwyyzn78x1KWi9ISKIn86ub7q88OtpWv6hzoqB+pG/Bs8R67hCJilaZBO/wOtJnWZmuCxiXSs9wldfVfqq5XSRGGgoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954398; c=relaxed/simple;
	bh=+ja1zWQhSNlwp6SrSbZPWtZsGgzZ5hOoajqle/IVSFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgco5vyrGie80Y3cCAvSUJc7C7fHGL5yzCjYW5ZNP43z0Cg4Yg1OEECnrYJdw5kzbNSOjw+JTqPP+jgsXs+flT44nM3HIEMXaGRiVnKgj0+uf8/1Ccq/TOD6LBZc3xPYgMHPqKGXuz3T3fI/e6V9JRKrI78TN1MCuQf0PMGw2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecHW6R0U; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736954397; x=1768490397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ja1zWQhSNlwp6SrSbZPWtZsGgzZ5hOoajqle/IVSFI=;
  b=ecHW6R0U+fTf3fYnEsJ6OPpe8N6IYLP0uCwbcrVnN/gZYg4uEr7UoSLr
   y7ULFUDvDS6imyahnL93v6StyA9PqSA6sCRaY375W1tR+bP3WGPa2J5GY
   c97sQRCIbH/ZM77NLTLy4zCy4gzIkuGUlKBPX32rHyeaSnM+X094U7BOx
   5V0nHkli+2QLKlVko0rhb7CjcyW97ShdOCM1oIvCasr8LZvfEhiP+8g70
   hfC9FtYxkWtBdB1NVddKQovonBM/duUKiLM4KoEs3cHGnWQH1mKOln/Aw
   3aHa5//jT3aNiHqDx+wsb13g6UFTq2ftTb8xSSYmiD1rc4vyGhB8irQIf
   A==;
X-CSE-ConnectionGUID: wxJm7htNQNy1QDhEQLbUlg==
X-CSE-MsgGUID: 13B7Gp+qTnSxAM2vwy6TDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37451809"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="37451809"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 07:19:57 -0800
X-CSE-ConnectionGUID: Ois2AerYTQiw264kVI0qOQ==
X-CSE-MsgGUID: VGHbF7/2R5e3l9YL9Kgr0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="105116666"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jan 2025 07:19:53 -0800
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
Subject: [PATCH net-next v3 4/8] bpf: cpumap: reuse skb array instead of a linked list to chain skbs
Date: Wed, 15 Jan 2025 16:18:57 +0100
Message-ID: <20250115151901.2063909-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
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
 kernel/bpf/cpumap.c | 119 +++++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 58 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 10d062dddb6f..4fae029c4490 100644
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
 		empty = __ptr_ring_empty(rcpu->queue);
-- 
2.48.0


