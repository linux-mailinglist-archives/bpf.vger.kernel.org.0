Return-Path: <bpf+bounces-52551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1BA44814
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1576F18886F1
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FD52040AF;
	Tue, 25 Feb 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNcOXi6d"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1A1EA7DF;
	Tue, 25 Feb 2025 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504300; cv=none; b=j59lRMCYV8y79oXcWMoJlHYbU3MmYac4Ez3kyNk/nmOjqnCawXzNmsUAJ6M1rXiCAYg3hFiyzRZiko+A4uvxxeW/DTGV0TO137b3TbInneGcPATBbcERHG5P2IdyPFpPNTmWqsq5axc59+iyrh+rnR6QVRIDmJ2uRT0cbgrmpLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504300; c=relaxed/simple;
	bh=WsQDKQL1yVZGxz9j/MJ297q+BCLvJbuCmPc5AY/pbu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXgfbX4LsP0qrVPTsRQz6mflva31wAwNj7RecmmSp2E7sSWDKBTWUO/R9kM1D4PBGsjyB66ZDYiaWSTm0vvQbonViGHkgT8xTi+AT2e1GUGOYeOgfjawG97l6kr27iJDV27OD2gYSMgTOxn40oHvX9s21JKvbw6ZYYURbaaocsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNcOXi6d; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740504299; x=1772040299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WsQDKQL1yVZGxz9j/MJ297q+BCLvJbuCmPc5AY/pbu4=;
  b=KNcOXi6dgw5VVDcfCji9IZ3vzRLocsSBHmLR3lnZCUR3ezWTN8VO2pSC
   nWiXjbpFexjCamOPKwbTKqh2Ro6x0gQ6IobttMp2niXPx8sIQwniL0ezV
   AaGM6lqJo1a6OB2Kn5O4ZlDeI3eGu83+vpFbDF/Pg/l8DQS54ErEnGmnY
   +5dsO0sHcLaCIpLCWqmPUk26ijSzJquVvVnx6koOcvkN4JV+J2QlKCrFS
   a+w8DXxZk9IGpubBNyhqMTV70CKSnoC6IJvB2pG6isRjOZyVIOdwYtKjm
   89ay+0LKP4J68QS/DdhtvGplda5Ci1WaVERxVD/jrxhnsZLownU4YmaE/
   A==;
X-CSE-ConnectionGUID: waLvHvdrS5mtirFt05svNw==
X-CSE-MsgGUID: tZoMKS5qS26Km7G8mZkpWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="44974158"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="44974158"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:24:58 -0800
X-CSE-ConnectionGUID: uDrcqFtFR12cJZxm1JFS3g==
X-CSE-MsgGUID: 37Y8eIMtQCWwMQG0rZgrHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116256938"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa006.fm.intel.com with ESMTP; 25 Feb 2025 09:24:54 -0800
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
Subject: [PATCH net-next v5 6/8] bpf: cpumap: switch to napi_skb_cache_get_bulk()
Date: Tue, 25 Feb 2025 18:17:48 +0100
Message-ID: <20250225171751.2268401-7-aleksander.lobakin@intel.com>
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

Now that cpumap uses GRO, which drops unused skb heads to the NAPI
cache, use napi_skb_cache_get_bulk() to try to reuse cached entries
and lower MM layer pressure. Always disable the BH before checking and
running the cpumap-pinned XDP prog and don't re-enable it in between
that and allocating an skb bulk, as we can access the NAPI caches only
from the BH context.
The better GRO aggregates packets, the less new skbs will be allocated.
If an aggregated skb contains 16 frags, this means 15 skbs were returned
to the cache, so next 15 skbs will be built without allocating anything.

The same trafficgen UDP GRO test now shows:

                GRO off   GRO on
threaded GRO    2.3       4         Mpps
thr bulk GRO    2.4       4.7       Mpps
diff            +4        +17       %

Comparing to the baseline cpumap:

baseline        2.7       N/A       Mpps
thr bulk GRO    2.4       4.7       Mpps
diff            -11       +74       %

Tested-by: Daniel Xu <dxu@dxuuu.xyz>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 kernel/bpf/cpumap.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 85936f09d8d7..67e8a2fc1a99 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -253,7 +253,7 @@ static void cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 	if (!rcpu->prog)
 		goto out;
 
-	rcu_read_lock_bh();
+	rcu_read_lock();
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	ret->xdp_n = cpu_map_bpf_prog_run_xdp(rcpu, frames, ret->xdp_n, stats);
@@ -265,7 +265,7 @@ static void cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 		xdp_do_flush();
 
 	bpf_net_ctx_clear(bpf_net_ctx);
-	rcu_read_unlock_bh(); /* resched point, may call do_softirq() */
+	rcu_read_unlock();
 
 out:
 	if (unlikely(ret->skb_n) && ret->xdp_n)
@@ -303,7 +303,6 @@ static int cpu_map_kthread_run(void *data)
 	while (!kthread_should_stop() || !__ptr_ring_empty(rcpu->queue)) {
 		struct xdp_cpumap_stats stats = {}; /* zero stats */
 		unsigned int kmem_alloc_drops = 0, sched = 0;
-		gfp_t gfp = __GFP_ZERO | GFP_ATOMIC;
 		struct cpu_map_ret ret = { };
 		void *frames[CPUMAP_BATCH];
 		void *skbs[CPUMAP_BATCH];
@@ -355,15 +354,14 @@ static int cpu_map_kthread_run(void *data)
 			prefetchw(page);
 		}
 
+		local_bh_disable();
+
 		/* Support running another XDP prog on this CPU */
 		cpu_map_bpf_prog_run(rcpu, frames, skbs, &ret, &stats);
-		if (!ret.xdp_n) {
-			local_bh_disable();
+		if (!ret.xdp_n)
 			goto stats;
-		}
 
-		m = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache, gfp,
-					  ret.xdp_n, skbs);
+		m = napi_skb_cache_get_bulk(skbs, ret.xdp_n);
 		if (unlikely(m < ret.xdp_n)) {
 			for (i = m; i < ret.xdp_n; i++)
 				xdp_return_frame(frames[i]);
@@ -376,7 +374,6 @@ static int cpu_map_kthread_run(void *data)
 			ret.xdp_n = m;
 		}
 
-		local_bh_disable();
 		for (i = 0; i < ret.xdp_n; i++) {
 			struct xdp_frame *xdpf = frames[i];
 
-- 
2.48.1


