Return-Path: <bpf+bounces-58382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C443AB963B
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 08:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE0DA03077
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 06:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4C0229B17;
	Fri, 16 May 2025 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WSR4/oQs"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766E227E80
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747378187; cv=none; b=AdrvBREL1sjUOOch9YaN7iJNR6ZtZ/FHVGWHYrtUR3b3j9H0i+PIH04FKRbw25ajw8NGm2rC9SCSeuSlDCIkqnlUPGkepmJ1TuHHTznaebpwar4xwfsdsCZRoMLFYXS6K/wFQ7soRfnEX0v/4jzTUR1PxUdoK4aryvQ+juy+vcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747378187; c=relaxed/simple;
	bh=tEf3IX+SKfryTgjjjr+5wg6/0dH9CvOVe0W0Gxmney4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvqFPv9+cNvu3jECxEGnYKWhFNu1EyS11i7FYMDkEDi9w7DdN/3T9bMLnp2He/qqppvkb7CXySkrFJ1gUogJiNpYCxBig4Ufcv9JZdmc54dCsmMmY9VePTw0mbjSLjzw+VT6d3fQ/8R76YtUu6Vabu43pBevFh9rNoFZLYRozdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WSR4/oQs; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747378183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjgeN2qjXaFT2yhGcnf6ojnEDqDgQ6jiTAUoDbWljT0=;
	b=WSR4/oQsdzkHgky5kgsfe7Q3covs1cTkeEfb8OaN46IWjcemjgSUOJOSDHT4tf9q8JeusI
	f3f8hayqZo9C32j3hvK/L+zPzmYInvz8GgshCBLLJP5qKhCIT7a0GiQI/HtJW0fGIIkigw
	dj+8morZoI+7sBShj5rXkhBOH0jZGtk=
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
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 2/5] memcg: nmi safe memcg stats for specific archs
Date: Thu, 15 May 2025 23:49:09 -0700
Message-ID: <20250516064912.1515065-3-shakeel.butt@linux.dev>
In-Reply-To: <20250516064912.1515065-1-shakeel.butt@linux.dev>
References: <20250516064912.1515065-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are archs which have NMI but does not support this_cpu_* ops
safely in the nmi context but they support safe atomic ops in nmi
context. For such archs, let's add infra to use atomic ops for the memcg
stats which can be updated in nmi.

At the moment, the memcg stats which get updated in the objcg charging
path are MEMCG_KMEM, NR_SLAB_RECLAIMABLE_B & NR_SLAB_UNRECLAIMABLE_B.
Rather than adding support for all memcg stats to be nmi safe, let's
just add infra to make these three stats nmi safe which this patch is
doing.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 20 ++++++++++++++--
 mm/memcontrol.c            | 49 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 53920528821f..b10ae2388c27 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -62,9 +62,15 @@ struct mem_cgroup_reclaim_cookie {
 
 #ifdef CONFIG_MEMCG
 
-#if defined(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS) || \
-	!defined(CONFIG_HAVE_NMI) || defined(ARCH_HAVE_NMI_SAFE_CMPXCHG)
+#if defined(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS) || !defined(CONFIG_HAVE_NMI)
+
+#define MEMCG_SUPPORTS_NMI_CHARGING
+
+#elif defined(ARCH_HAVE_NMI_SAFE_CMPXCHG)
+
 #define MEMCG_SUPPORTS_NMI_CHARGING
+#define MEMCG_NMI_NEED_ATOMIC
+
 #endif
 
 #define MEM_CGROUP_ID_SHIFT	16
@@ -118,6 +124,12 @@ struct mem_cgroup_per_node {
 	CACHELINE_PADDING(_pad2_);
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 	struct mem_cgroup_reclaim_iter	iter;
+
+#ifdef MEMCG_NMI_NEED_ATOMIC
+	/* slab stats for nmi context */
+	atomic_t		slab_reclaimable;
+	atomic_t		slab_unreclaimable;
+#endif
 };
 
 struct mem_cgroup_threshold {
@@ -241,6 +253,10 @@ struct mem_cgroup {
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
 	atomic_long_t		memory_events_local[MEMCG_NR_MEMORY_EVENTS];
 
+#ifdef MEMCG_NMI_NEED_ATOMIC
+	/* MEMCG_KMEM for nmi context */
+	atomic_t		kmem_stat;
+#endif
 	/*
 	 * Hint of reclaim pressure for socket memroy management. Note
 	 * that this indicator should NOT be used in legacy cgroup mode
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dface07f69bb..102fdec3f49e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3979,6 +3979,53 @@ static void mem_cgroup_stat_aggregate(struct aggregate_control *ac)
 	}
 }
 
+#ifdef MEMCG_NMI_NEED_ATOMIC
+static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
+			    int cpu)
+{
+	int nid;
+
+	if (atomic_read(&memcg->kmem_stat)) {
+		int kmem = atomic_xchg(&memcg->kmem_stat, 0);
+		int index = memcg_stats_index(MEMCG_KMEM);
+
+		memcg->vmstats->state[index] += kmem;
+		if (parent)
+			parent->vmstats->state_pending[index] += kmem;
+	}
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
+		struct lruvec_stats *lstats = pn->lruvec_stats;
+		struct lruvec_stats *plstats = NULL;
+
+		if (parent)
+			plstats = parent->nodeinfo[nid]->lruvec_stats;
+
+		if (atomic_read(&pn->slab_reclaimable)) {
+			int slab = atomic_xchg(&pn->slab_reclaimable, 0);
+			int index = memcg_stats_index(NR_SLAB_RECLAIMABLE_B);
+
+			lstats->state[index] += slab;
+			if (plstats)
+				plstats->state_pending[index] += slab;
+		}
+		if (atomic_read(&pn->slab_unreclaimable)) {
+			int slab = atomic_xchg(&pn->slab_unreclaimable, 0);
+			int index = memcg_stats_index(NR_SLAB_UNRECLAIMABLE_B);
+
+			lstats->state[index] += slab;
+			if (plstats)
+				plstats->state_pending[index] += slab;
+		}
+	}
+}
+#else
+static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
+			    int cpu)
+{}
+#endif
+
 static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
@@ -3987,6 +4034,8 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct aggregate_control ac;
 	int nid;
 
+	flush_nmi_stats(memcg, parent, cpu);
+
 	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
 
 	ac = (struct aggregate_control) {
-- 
2.47.1


