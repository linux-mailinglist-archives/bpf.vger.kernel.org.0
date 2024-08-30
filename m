Return-Path: <bpf+bounces-38573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E64E9666CC
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6901C234AA
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A091BBBE7;
	Fri, 30 Aug 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXdU1Yrk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83651BBBD3;
	Fri, 30 Aug 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035158; cv=none; b=IzRodn6fB9SIZpqEJe+hUqtKA7g2Su1qOZWGi9YRtk0gcrZ1buF9/eHPOYY6l9mZ155MkVwygOGQwq/Jj0K4lVVWUwkR/TSpPe2f8L66Wv/rtq8iMlC34Ocj5iXn91VhRNOdWd9l47HzzUigHU/K9sQrsOnXwrL03P15VUbwtZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035158; c=relaxed/simple;
	bh=l89IadWlEi0jEr4luW02lPosgA0IRD2ZprKXd+x2hRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaAVifKfp/qQ4byy5VA2rxfmuOOH77UYzTZBXjRhN9YUu+jeOOpW34caGPuhSUnuhx0HEUx6jxEB7XTqHUVSUVDeqk1hEuU18SRque5QTyVbY/TxhzVDLjeaL6qLyZEeVfT45mGwLclczGkXeVG9+4L/vTkqEzxFmrr5ijlOol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXdU1Yrk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725035158; x=1756571158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l89IadWlEi0jEr4luW02lPosgA0IRD2ZprKXd+x2hRg=;
  b=VXdU1YrkxGsHnlCyW6q1uHQkIq9Vxj+/mZ+4wzaNSFz0d5fG4mR6oOwd
   Bw3iZBgtMZF9Fz2Mv+xoBTdu5eDXRFcq2+Hj1OqPTQlVR3/iNUq+E0P8c
   Hf/L/5Hr0FhPwlJgTV59RFYEVbi1+3iU+hEAKFDhDQWOMQJO+rs9qv/MP
   ZTxXGSWvat7gD/n5RNir689pd0gm/zSjfUb3nGrlnwjUV3DwDowppFjlN
   FVxKv9xXEo5x/ac8+vKcSuRaNamxH4yfjw/rww5Lnt1nV+u7+L/rlnal6
   BX0p9tVBfKeDQEL8Pw6JbD3OZjizB3hNrctdMpVmM/MAltyHJ1/82ARBF
   w==;
X-CSE-ConnectionGUID: P0ekgLvOS+2aHxou7W5o5A==
X-CSE-MsgGUID: a1he498xSOCcy+xfF98gIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="49068940"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="49068940"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:25:57 -0700
X-CSE-ConnectionGUID: nue82NPeRw6GsgiCud4Ejw==
X-CSE-MsgGUID: T8l2eGibQiintE5lAe2HuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63996455"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 30 Aug 2024 09:25:53 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 5/9] bpf: cpumap: reuse skb array instead of a linked list to chain skbs
Date: Fri, 30 Aug 2024 18:25:04 +0200
Message-ID: <20240830162508.1009458-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
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
it for skbs passed to cpumap (generic XDP) and use napi_gro_receive()
directly in case of XDP_PASS when a program is installed to the map
itself. Don't list regular xdp_frames at all and just call
napi_gro_receive() directly as well right after building an skb.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 kernel/bpf/cpumap.c | 55 +++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index d1cfa4111727..d7206f3f6e80 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -150,21 +150,23 @@ static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 }
 
 static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
-				     struct list_head *listp,
+				     void **skbs, u32 skb_n,
 				     struct xdp_cpumap_stats *stats)
 {
-	struct sk_buff *skb, *tmp;
 	struct xdp_buff xdp;
 	u32 act;
 	int err;
 
-	list_for_each_entry_safe(skb, tmp, listp, list) {
+	for (u32 i = 0; i < skb_n; i++) {
+		struct sk_buff *skb = skbs[i];
+
 		act = bpf_prog_run_generic_xdp(skb, &xdp, rcpu->prog);
 		switch (act) {
 		case XDP_PASS:
+			napi_gro_receive(&rcpu->napi, skb);
+			stats->pass++;
 			break;
 		case XDP_REDIRECT:
-			skb_list_del_init(skb);
 			err = xdp_do_generic_redirect(skb->dev, skb, &xdp,
 						      rcpu->prog);
 			if (unlikely(err)) {
@@ -181,8 +183,7 @@ static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
 			trace_xdp_exception(skb->dev, rcpu->prog, act);
 			fallthrough;
 		case XDP_DROP:
-			skb_list_del_init(skb);
-			kfree_skb(skb);
+			napi_consume_skb(skb, true);
 			stats->drop++;
 			return;
 		}
@@ -251,8 +252,8 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 #define CPUMAP_BATCH 8
 
 static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
-				int xdp_n, struct xdp_cpumap_stats *stats,
-				struct list_head *list)
+				int xdp_n, void **skbs, u32 skb_n,
+				struct xdp_cpumap_stats *stats)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int nframes;
@@ -267,8 +268,8 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 	if (stats->redirect)
 		xdp_do_flush();
 
-	if (unlikely(!list_empty(list)))
-		cpu_map_bpf_prog_run_skb(rcpu, list, stats);
+	if (unlikely(skb_n))
+		cpu_map_bpf_prog_run_skb(rcpu, skbs, skb_n, stats);
 
 	bpf_net_ctx_clear(bpf_net_ctx);
 
@@ -288,9 +289,7 @@ static int cpu_map_napi_poll(struct napi_struct *napi, int budget)
 		gfp_t gfp = __GFP_ZERO | GFP_ATOMIC;
 		int i, n, m, nframes, xdp_n;
 		void *frames[CPUMAP_BATCH];
-		struct sk_buff *skb, *tmp;
 		void *skbs[CPUMAP_BATCH];
-		LIST_HEAD(list);
 
 		if (__ptr_ring_empty(rcpu->queue))
 			break;
@@ -304,15 +303,15 @@ static int cpu_map_napi_poll(struct napi_struct *napi, int budget)
 		n = __ptr_ring_consume_batched(rcpu->queue, frames, n);
 		done += n;
 
-		for (i = 0, xdp_n = 0; i < n; i++) {
+		for (i = 0, xdp_n = 0, m = 0; i < n; i++) {
 			void *f = frames[i];
 			struct page *page;
 
 			if (unlikely(__ptr_test_bit(0, &f))) {
-				skb = f;
+				struct sk_buff *skb = f;
 
 				__ptr_clear_bit(0, &skb);
-				list_add_tail(&skb->list, &list);
+				skbs[m++] = skb;
 				continue;
 			}
 
@@ -327,19 +326,22 @@ static int cpu_map_napi_poll(struct napi_struct *napi, int budget)
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
+		nframes = cpu_map_bpf_prog_run(rcpu, frames, xdp_n, skbs, m,
+					       &stats);
+		if (!nframes)
+			continue;
+
+		m = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache, gfp,
+					  nframes, skbs);
+		if (unlikely(!m)) {
+			for (i = 0; i < nframes; i++)
+				skbs[i] = NULL; /* effect: xdp_return_frame */
+			kmem_alloc_drops += nframes;
 		}
 
 		for (i = 0; i < nframes; i++) {
 			struct xdp_frame *xdpf = frames[i];
+			struct sk_buff *skb;
 
 			skb = __xdp_build_skb_from_frame(xdpf, skbs[i],
 							 xdpf->dev_rx);
@@ -348,11 +350,6 @@ static int cpu_map_napi_poll(struct napi_struct *napi, int budget)
 				continue;
 			}
 
-			list_add_tail(&skb->list, &list);
-		}
-
-		list_for_each_entry_safe(skb, tmp, &list, list) {
-			skb_list_del_init(skb);
 			napi_gro_receive(napi, skb);
 		}
 	}
-- 
2.46.0


