Return-Path: <bpf+bounces-48133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07449A044F1
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 16:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20BB1885C4B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D289F1F667C;
	Tue,  7 Jan 2025 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHwwVdJp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D211F63DD;
	Tue,  7 Jan 2025 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263912; cv=none; b=d0Vk7y7+Nj1fLEhPiEDNN0onL/TVL16CwfoGvgmFkJ09oaHOwqDeBIe/wB1Enr/JTamCUgf+SjC9kMe47tUmyONCDAGq0d2PLBcwrgbLVokYCmQ7wTIyZL8emsxqLe+rl1GZHlEJuAvFf3ZpKtJJeMYOvpjD61JtdEU8K8/+sIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263912; c=relaxed/simple;
	bh=APB9ovMOiRFqf4aDgYNaGYAP9H+gVcACJ6unz9KISSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVInVjbM/NnTXChBM6fzGVmqnZYjaELM83EGaIVYv8W0ASOq+Rg7EvTzNkyF88AE6J/Fsq3BPfQ5se7SHhwK3lTXjyuNR436sLTo/ONyLW8mRax1UN5OULXAdq32Xoqell5q7CSSz9TuKMD4iTshuHPKkh2AuK3uNOfFGn3MQog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHwwVdJp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736263907; x=1767799907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=APB9ovMOiRFqf4aDgYNaGYAP9H+gVcACJ6unz9KISSw=;
  b=WHwwVdJpYS5URd/bpnIX4uXjou1ywSIJjUk7toXjLSJ+q0GxxxV4kgiX
   I+cCwEuvQesdgCCGXNrUY8I+fb8tcGZmtAwaksNsHPIU6byeY/Z8UDU5G
   /CZ49eqGWqOHKxvWGUVmdUKPILJ0AXP1VL39z4xwfpnjeJSavYEo5AN/G
   l4QkMK9FCB6pya/d30apgwQd4a68tYnyVeXVFuTpH3LQF+RpY9+I6td1w
   9fQb9r3pfw6fx94KUiIFpw2la+w3i5aGklpia6oWlc5eBkP+25AZYSu5d
   sXBh/TGxHPGpuaP2Qcdq0DCOPeCJJJg0n0ZPKmF+ivpCQv8KLX/rHS752
   A==;
X-CSE-ConnectionGUID: vduYB/nXRs2iV/hqNlJKDA==
X-CSE-MsgGUID: WL2HFcyITbemBFeZHt63rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="35685883"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="35685883"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 07:31:31 -0800
X-CSE-ConnectionGUID: MFTZ+INQSHCbnONsrXhxLg==
X-CSE-MsgGUID: ZyzCa752Qxior6OkS/BFzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103646969"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 07 Jan 2025 07:31:27 -0800
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
Subject: [PATCH net-next v2 6/8] bpf: cpumap: switch to napi_skb_cache_get_bulk()
Date: Tue,  7 Jan 2025 16:29:38 +0100
Message-ID: <20250107152940.26530-7-aleksander.lobakin@intel.com>
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
index 4c3eeb931bff..c6b7f0e1ba61 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -253,7 +253,7 @@ static bool cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 	if (!rcpu->prog)
 		goto out;
 
-	rcu_read_lock_bh();
+	rcu_read_lock();
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	ret->xdp_n = cpu_map_bpf_prog_run_xdp(rcpu, frames, ret->xdp_n, stats);
@@ -265,7 +265,7 @@ static bool cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 		xdp_do_flush();
 
 	bpf_net_ctx_clear(bpf_net_ctx);
-	rcu_read_unlock_bh(); /* resched point, may call do_softirq() */
+	rcu_read_unlock();
 
 out:
 	if (unlikely(ret->skb_n) && ret->xdp_n)
@@ -305,7 +305,6 @@ static int cpu_map_kthread_run(void *data)
 	while (!kthread_should_stop() || !__ptr_ring_empty(rcpu->queue)) {
 		struct xdp_cpumap_stats stats = {}; /* zero stats */
 		unsigned int kmem_alloc_drops = 0, sched = 0;
-		gfp_t gfp = __GFP_ZERO | GFP_ATOMIC;
 		struct cpu_map_ret ret = { };
 		void *frames[CPUMAP_BATCH];
 		void *skbs[CPUMAP_BATCH];
@@ -357,21 +356,19 @@ static int cpu_map_kthread_run(void *data)
 			prefetchw(page);
 		}
 
+		local_bh_disable();
+
 		/* Support running another XDP prog on this CPU */
-		if (!cpu_map_bpf_prog_run(rcpu, frames, skbs, &ret, &stats)) {
-			local_bh_disable();
+		if (!cpu_map_bpf_prog_run(rcpu, frames, skbs, &ret, &stats))
 			goto stats;
-		}
 
-		m = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache, gfp,
-					  ret.xdp_n, skbs);
+		m = napi_skb_cache_get_bulk(skbs, ret.xdp_n);
 		if (unlikely(!m)) {
 			for (i = 0; i < ret.xdp_n; i++)
 				skbs[i] = NULL; /* effect: xdp_return_frame */
 			kmem_alloc_drops += ret.xdp_n;
 		}
 
-		local_bh_disable();
 		for (i = 0; i < ret.xdp_n; i++) {
 			struct xdp_frame *xdpf = frames[i];
 			struct sk_buff *skb = skbs[i];
-- 
2.47.1


