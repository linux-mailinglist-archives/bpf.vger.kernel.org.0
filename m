Return-Path: <bpf+bounces-48942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4816EA12734
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D441888326
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151521ADC6D;
	Wed, 15 Jan 2025 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZUGmEnS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE351A00D6;
	Wed, 15 Jan 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954406; cv=none; b=f1mAakgx31WmacRjxHOKW/I5bUWrsUTywubeAT+2PJ47br/Vc8+L58sIVF6Ygz+mZhDVfoyhRcrrFTgjD2QvGux6VzLYLWLC+YtmtymBI/0ErXINmfHdkdOcOmhP1kqImwpMl3ULLTRkGOSnmg/kSUjcbvPuxdoAQS2HL4AqU3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954406; c=relaxed/simple;
	bh=VLvjyuGtrJTPn43cvE7ThAgmCuRn4A0Q+5OIeczTnMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYHvHYUqVcYB6HB6tJycHt4Mwq4Dpk2YRiSJQKud3PfCYN3tqmm3F34qt8F4eM85fy+KyuwCd8ETzrT/r7XguRx9D9dqalW72C62u4FzJ06NOBCSegCWdmgL1O0r/vaD6fVe2VFwazBaGqOtkgRdKMwHg3PoOWSTSqsaQq2d1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZUGmEnS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736954405; x=1768490405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VLvjyuGtrJTPn43cvE7ThAgmCuRn4A0Q+5OIeczTnMs=;
  b=UZUGmEnSOl61JDxTFdtYBEUTF3LbYe8sQtxKoMVR6ySi4tuAsLuWbmj1
   FfajpU9YoYWuvbQTYKAdTH+pDNx901Xd4q1PonaIGXfAvDGEAF7qVJiE5
   9jGgqyqQ3idmEAr7Va+NFPZwhS2jrN5l58G+NinUQSaVZwHMSGejSrNJJ
   j9XpbMNgPWLAEA/E1wPLncWdGLqnXk07Vm8G3P4Nme6By3zTII9A3hsM9
   THz1qADFPcYJh64rHI7XW4yfr1Fr/xAqbcgq6vvxtjPYO16tVeAJHLUHe
   9x3GP6/OCK+FmwAassO/sZpB4kz3iqJYlbMC+6RaBk573Y+CAcTb8vaRv
   Q==;
X-CSE-ConnectionGUID: DDXjLivyS5q+I+tKZJ0fOA==
X-CSE-MsgGUID: k/8MowwNQsaKdHC6SiCBPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37451832"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="37451832"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 07:20:05 -0800
X-CSE-ConnectionGUID: l/feQ1qNQBuE3Gi4UOLMhw==
X-CSE-MsgGUID: jWr/38bhSp+MI6PzEOEBEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="105116693"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jan 2025 07:20:01 -0800
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
Subject: [PATCH net-next v3 6/8] bpf: cpumap: switch to napi_skb_cache_get_bulk()
Date: Wed, 15 Jan 2025 16:18:59 +0100
Message-ID: <20250115151901.2063909-7-aleksander.lobakin@intel.com>
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

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/cpumap.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 4fae029c4490..6997b67a0104 100644
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
2.48.0


