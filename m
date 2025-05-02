Return-Path: <bpf+bounces-57179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D54AA67BF
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 02:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E011F1BC7D04
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 00:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6397464;
	Fri,  2 May 2025 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GNaYOfNm"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E30C8DC
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746145102; cv=none; b=WgwFJKPcqk0q2D3CTdi1gx2EFhoagsq7VKJYZFF7g9uQLad0vzjOyNCt8xjGu7gbclskscNrV9ua8oPbWKseMZAIfNLt6IqzAioe+m1DdwSdgtwvUr0rpwBPhOT8WHM7/l6R+kwzJ9+f/lDqUat/mqzqQVo40vjxaGpUWesfMto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746145102; c=relaxed/simple;
	bh=KMnoZ8f/Qa2zo5PS1tn0eD5Aq7wW+h5KOR12NHgF+CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBtLLmBL1iOjeMck0K7BAqDh9dVl377UNeIU0SUvn0DxwfqlEOl4TjCPWhMnIwfWOsQjyFv/1odXnZWRSqill2xbKM+FLy/U6a+29KG+enln6PTefcPDAsq/hkPw9oIJTMJ4UW9sXCiTLVH8jWTj9f8csHKOjnvjX9CufSTGwgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GNaYOfNm; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746145088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8ptQwJSFfLo2cDiqIGklIojumEAEh3QOUi7xbHY5m8=;
	b=GNaYOfNmpJl8BUzBF6IJvETURlGcX7+mT1FmFkX5jN+8dtI6ZDkgvV4isSNPLKcFIn8J3Z
	mOF846iWFKWTtdFEtu+vqTfGLylxg97fRQwXvP3QwlZ5p6lE7YONP7RLjUb1f613dMdYYK
	Z5pvu04FsO8rvWt3jdEsOZ2S8KWaJ24=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 1/3] memcg: separate local_trylock for memcg and obj
Date: Thu,  1 May 2025 17:17:40 -0700
Message-ID: <20250502001742.3087558-2-shakeel.butt@linux.dev>
In-Reply-To: <20250502001742.3087558-1-shakeel.butt@linux.dev>
References: <20250502001742.3087558-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The per-cpu stock_lock protects cached memcg and cached objcg and their
respective fields. However there is no dependency between these fields
and it is better to have fine grained separate locks for cached memcg
and cached objcg. This decoupling of locks allows us to make the memcg
charge cache and objcg charge cache to be nmi safe independently.

At the moment, memcg charge cache is already nmi safe and this
decoupling will allow to make memcg charge cache work without disabling
irqs.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes since v1:
- Drop usage of preempt_disable() as suggested by Vlastimil.

 mm/memcontrol.c | 51 ++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0d42699bb564..14714e1d36e9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1806,13 +1806,14 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
  */
 #define NR_MEMCG_STOCK 7
 struct memcg_stock_pcp {
-	local_trylock_t stock_lock;
+	local_trylock_t memcg_lock;
 	uint8_t nr_pages[NR_MEMCG_STOCK];
 	struct mem_cgroup *cached[NR_MEMCG_STOCK];
 
+	local_trylock_t obj_lock;
+	unsigned int nr_bytes;
 	struct obj_cgroup *cached_objcg;
 	struct pglist_data *cached_pgdat;
-	unsigned int nr_bytes;
 	int nr_slab_reclaimable_b;
 	int nr_slab_unreclaimable_b;
 
@@ -1821,7 +1822,8 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
-	.stock_lock = INIT_LOCAL_TRYLOCK(stock_lock),
+	.memcg_lock = INIT_LOCAL_TRYLOCK(memcg_lock),
+	.obj_lock = INIT_LOCAL_TRYLOCK(obj_lock),
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
@@ -1854,8 +1856,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 		return ret;
 
 	if (gfpflags_allow_spinning(gfp_mask))
-		local_lock_irqsave(&memcg_stock.stock_lock, flags);
-	else if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags))
+		local_lock_irqsave(&memcg_stock.memcg_lock, flags);
+	else if (!local_trylock_irqsave(&memcg_stock.memcg_lock, flags))
 		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
@@ -1872,7 +1874,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 		break;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
 
 	return ret;
 }
@@ -1918,19 +1920,19 @@ static void drain_local_stock(struct work_struct *dummy)
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
-	/*
-	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
-	 * drain_stock races is that we always operate on local CPU stock
-	 * here with IRQ disabled
-	 */
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	if (WARN_ONCE(!in_task(), "drain in non-task context"))
+		return;
 
+	local_lock_irqsave(&memcg_stock.obj_lock, flags);
 	stock = this_cpu_ptr(&memcg_stock);
 	drain_obj_stock(stock);
+	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
+
+	local_lock_irqsave(&memcg_stock.memcg_lock, flags);
+	stock = this_cpu_ptr(&memcg_stock);
 	drain_stock_fully(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
-
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
 }
 
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
@@ -1953,10 +1955,10 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
 
 	if (nr_pages > MEMCG_CHARGE_BATCH ||
-	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+	    !local_trylock_irqsave(&memcg_stock.memcg_lock, flags)) {
 		/*
 		 * In case of larger than batch refill or unlikely failure to
-		 * lock the percpu stock_lock, uncharge memcg directly.
+		 * lock the percpu memcg_lock, uncharge memcg directly.
 		 */
 		memcg_uncharge(memcg, nr_pages);
 		return;
@@ -1988,7 +1990,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		WRITE_ONCE(stock->nr_pages[i], nr_pages);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
 }
 
 static bool is_drain_needed(struct memcg_stock_pcp *stock,
@@ -2063,11 +2065,12 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 
 	stock = &per_cpu(memcg_stock, cpu);
 
-	/* drain_obj_stock requires stock_lock */
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	/* drain_obj_stock requires obj_lock */
+	local_lock_irqsave(&memcg_stock.obj_lock, flags);
 	drain_obj_stock(stock);
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
 
+	/* no need for the local lock */
 	drain_stock_fully(stock);
 
 	return 0;
@@ -2920,7 +2923,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	bool ret = false;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.obj_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
@@ -2931,7 +2934,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			__account_obj_stock(objcg, stock, nr_bytes, pgdat, idx);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
 
 	return ret;
 }
@@ -3020,7 +3023,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.obj_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
@@ -3042,7 +3045,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
-- 
2.47.1


