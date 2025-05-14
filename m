Return-Path: <bpf+bounces-58227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2926CAB749A
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 20:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4A68C2960
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0D728980F;
	Wed, 14 May 2025 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HPtxLwPj"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB384289364
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248166; cv=none; b=L3IuxYeuXayHI6CQ2cyEGspiDdZSfxs187OfACoWkND5/flPrTTQgzCU4zpnlZ5kjHv4yHGw8HsTDo67J6bK/eJVRgYqG7VLhU7xq9dVZGvI3ujJ0aMAVBCiyBaVvTU91JStUoeGLCdkW/0/cGGvmRWW5bwqDVosHf/b0UAt+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248166; c=relaxed/simple;
	bh=9a9EAI7HjHhqk+KWb+uIby+4wcCto83ZQTHrDewpE5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoLyd7r3YObKH12aAyx2tlvQIPHrT0OcqgqIX3Ok3xkji959Pgt+7YKI4KJKi26QDGEC3l45TV5dosfoGExDuC+2mA+17/cUwatOy7H/Ck5OwxDGNVDHOc7BynlscYxfcxXFbJGXV5j3XD74DqXJGaKO05qlQatk3DjtuA7P1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HPtxLwPj; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747248160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUZYKygsw0cKUEN+JGdm3r/cNIBlAjnoiVTSGdy45nM=;
	b=HPtxLwPjDj5tqjCFtwX92LOzUI2qCAAx7nVFvpOlYx50xbs4s/Fy13Y9s9Qvw+8xVxiY8H
	V2WCjEYTPudskCJM673GcxuVhRiR162USn+/2ztfctd5+lkECGf8FDLJSGd2TjK79GGOBf
	cCXBYez5Bq6M6ZySrPh5GHB1M/dPDqc=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 4/7] memcg: make count_memcg_events re-entrant safe against irqs
Date: Wed, 14 May 2025 11:41:55 -0700
Message-ID: <20250514184158.3471331-5-shakeel.butt@linux.dev>
In-Reply-To: <20250514184158.3471331-1-shakeel.butt@linux.dev>
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Let's make count_memcg_events re-entrant safe against irqs. The only
thing needed is to convert the usage of __this_cpu_add() to
this_cpu_add(). In addition, with re-entrant safety, there is no need
to disable irqs. Also add warnings for in_nmi() as it is not safe
against nmi context.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h | 21 ++-------------------
 mm/memcontrol-v1.c         |  6 +++---
 mm/memcontrol.c            |  6 +++---
 mm/swap.c                  |  8 ++++----
 mm/vmscan.c                | 14 +++++++-------
 5 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 92861ff3c43f..f7848f73f41c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -942,19 +942,8 @@ static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
 	local_irq_restore(flags);
 }
 
-void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
-			  unsigned long count);
-
-static inline void count_memcg_events(struct mem_cgroup *memcg,
-				      enum vm_event_item idx,
-				      unsigned long count)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__count_memcg_events(memcg, idx, count);
-	local_irq_restore(flags);
-}
+void count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
+			unsigned long count);
 
 static inline void count_memcg_folio_events(struct folio *folio,
 		enum vm_event_item idx, unsigned long nr)
@@ -1418,12 +1407,6 @@ static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
 }
 
 static inline void count_memcg_events(struct mem_cgroup *memcg,
-				      enum vm_event_item idx,
-				      unsigned long count)
-{
-}
-
-static inline void __count_memcg_events(struct mem_cgroup *memcg,
 					enum vm_event_item idx,
 					unsigned long count)
 {
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 54c49cbfc968..4b94731305b9 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -512,9 +512,9 @@ static void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages)
 {
 	/* pagein of a big page is an event. So, ignore page size */
 	if (nr_pages > 0)
-		__count_memcg_events(memcg, PGPGIN, 1);
+		count_memcg_events(memcg, PGPGIN, 1);
 	else {
-		__count_memcg_events(memcg, PGPGOUT, 1);
+		count_memcg_events(memcg, PGPGOUT, 1);
 		nr_pages = -nr_pages; /* for event */
 	}
 
@@ -689,7 +689,7 @@ void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
 	unsigned long flags;
 
 	local_irq_save(flags);
-	__count_memcg_events(memcg, PGPGOUT, pgpgout);
+	count_memcg_events(memcg, PGPGOUT, pgpgout);
 	__this_cpu_add(memcg->events_percpu->nr_page_events, nr_memory);
 	memcg1_check_events(memcg, nid);
 	local_irq_restore(flags);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c5a835071610..0923072386c2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -825,12 +825,12 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 }
 
 /**
- * __count_memcg_events - account VM events in a cgroup
+ * count_memcg_events - account VM events in a cgroup
  * @memcg: the memory cgroup
  * @idx: the event item
  * @count: the number of events that occurred
  */
-void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
+void count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 			  unsigned long count)
 {
 	int i = memcg_events_index(idx);
@@ -844,7 +844,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 
 	cpu = get_cpu();
 
-	__this_cpu_add(memcg->vmstats_percpu->events[i], count);
+	this_cpu_add(memcg->vmstats_percpu->events[i], count);
 	memcg_rstat_updated(memcg, count, cpu);
 	trace_count_memcg_events(memcg, idx, count);
 
diff --git a/mm/swap.c b/mm/swap.c
index 77b2d5997873..4fc322f7111a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -309,7 +309,7 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
 	trace_mm_lru_activate(folio);
 
 	__count_vm_events(PGACTIVATE, nr_pages);
-	__count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE, nr_pages);
+	count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE, nr_pages);
 }
 
 #ifdef CONFIG_SMP
@@ -581,7 +581,7 @@ static void lru_deactivate_file(struct lruvec *lruvec, struct folio *folio)
 
 	if (active) {
 		__count_vm_events(PGDEACTIVATE, nr_pages);
-		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
+		count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
 				     nr_pages);
 	}
 }
@@ -599,7 +599,7 @@ static void lru_deactivate(struct lruvec *lruvec, struct folio *folio)
 	lruvec_add_folio(lruvec, folio);
 
 	__count_vm_events(PGDEACTIVATE, nr_pages);
-	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_pages);
+	count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_pages);
 }
 
 static void lru_lazyfree(struct lruvec *lruvec, struct folio *folio)
@@ -625,7 +625,7 @@ static void lru_lazyfree(struct lruvec *lruvec, struct folio *folio)
 	lruvec_add_folio(lruvec, folio);
 
 	__count_vm_events(PGLAZYFREE, nr_pages);
-	__count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE, nr_pages);
+	count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE, nr_pages);
 }
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5efd939d8c76..f86d264558f5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2028,7 +2028,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	item = PGSCAN_KSWAPD + reclaimer_offset(sc);
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_scanned);
-	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
+	count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
 	__count_vm_events(PGSCAN_ANON + file, nr_scanned);
 
 	spin_unlock_irq(&lruvec->lru_lock);
@@ -2048,7 +2048,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_reclaimed);
-	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
+	count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
 	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
 	spin_unlock_irq(&lruvec->lru_lock);
 
@@ -2138,7 +2138,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(PGREFILL, nr_scanned);
-	__count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
+	count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
 
 	spin_unlock_irq(&lruvec->lru_lock);
 
@@ -2195,7 +2195,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	nr_deactivate = move_folios_to_lru(lruvec, &l_inactive);
 
 	__count_vm_events(PGDEACTIVATE, nr_deactivate);
-	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
+	count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	spin_unlock_irq(&lruvec->lru_lock);
@@ -4616,8 +4616,8 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 		__count_vm_events(item, isolated);
 		__count_vm_events(PGREFILL, sorted);
 	}
-	__count_memcg_events(memcg, item, isolated);
-	__count_memcg_events(memcg, PGREFILL, sorted);
+	count_memcg_events(memcg, item, isolated);
+	count_memcg_events(memcg, PGREFILL, sorted);
 	__count_vm_events(PGSCAN_ANON + type, isolated);
 	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
 				scanned, skipped, isolated,
@@ -4769,7 +4769,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, reclaimed);
-	__count_memcg_events(memcg, item, reclaimed);
+	count_memcg_events(memcg, item, reclaimed);
 	__count_vm_events(PGSTEAL_ANON + type, reclaimed);
 
 	spin_unlock_irq(&lruvec->lru_lock);
-- 
2.47.1


