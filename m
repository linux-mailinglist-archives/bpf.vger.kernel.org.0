Return-Path: <bpf+bounces-58089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3865AB4A00
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 05:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E99217550A
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 03:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7101DF982;
	Tue, 13 May 2025 03:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ooSsm/BG"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2301E4928
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106036; cv=none; b=m7+wPf/fzWlQgeKYlWRHDRgkN+w6/G0m2DSlNR9sZ/31FJifPhkoSZx9I/HENzf3v3G+MeHLC6KYFmn+Lb6AKDi/dbab7c1JNbleDzoIXEKd2+tGCdvK18+1VRKUgMnZMp+xgm+8/MvZ1H5DS0h0b0ZhHmysUNhJwqgjiUudXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106036; c=relaxed/simple;
	bh=e5zcqxXqQpR2JMymlF/KWPHcfisuz8s1WaeQLc69vnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLAoW5CwCSF7+3Hd4GhFZ+zcIGB1/wla1GGaiZnjRD7VTWXPnOxAiRd/Hg2nnrAJAjCjJapnoIpYkOpLeIWcj7N2wcZruT/+ln0lg/yjZAAwN4MlKSBv/tvHUka6v6zURmK2Y3sQXOI2FjO8L8ej5pah2uoH4CmFp0ikDpFPwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ooSsm/BG; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747106031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPiRuCw/bD9XYJlwvKtjg4J90L1EW0IfWXzhcocLuzg=;
	b=ooSsm/BGkm7jLt7WeCVzcIeXfSfmLTTxu3NEHROcON2zE6dLycnVCdS6+Pirr61u6vkq4u
	euHpiYkfCAx2oacQVM//UVnoD5lrLUEW6o3iX/cgHCN3dSAZ0N3CB7eKx5dyzXrhUClRXc
	QwDnQ1oHgBA0T+GBQDkE5Eg074eoGKI=
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
Subject: [RFC PATCH 3/7] memcg: make mod_memcg_state re-entrant safe against irqs
Date: Mon, 12 May 2025 20:13:12 -0700
Message-ID: <20250513031316.2147548-4-shakeel.butt@linux.dev>
In-Reply-To: <20250513031316.2147548-1-shakeel.butt@linux.dev>
References: <20250513031316.2147548-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Let's make mod_memcg_state re-entrant safe against irqs. The only thing
needed is to convert the usage of __this_cpu_add() to this_cpu_add().
In addition, with re-entrant safety, there is no need to disable irqs.

mod_memcg_state() is not safe against nmi, so let's add warning if
someone tries to call it in nmi context.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 20 ++------------------
 mm/memcontrol.c            | 12 ++++++++----
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ed9acb68652a..84e2cea7e666 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -911,19 +911,9 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 					    struct mem_cgroup *oom_domain);
 void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 
-void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
-		       int val);
-
 /* idx can be of type enum memcg_stat_item or node_stat_item */
-static inline void mod_memcg_state(struct mem_cgroup *memcg,
-				   enum memcg_stat_item idx, int val)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__mod_memcg_state(memcg, idx, val);
-	local_irq_restore(flags);
-}
+void mod_memcg_state(struct mem_cgroup *memcg,
+		     enum memcg_stat_item idx, int val);
 
 static inline void mod_memcg_page_state(struct page *page,
 					enum memcg_stat_item idx, int val)
@@ -1390,12 +1380,6 @@ static inline void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 {
 }
 
-static inline void __mod_memcg_state(struct mem_cgroup *memcg,
-				     enum memcg_stat_item idx,
-				     int nr)
-{
-}
-
 static inline void mod_memcg_state(struct mem_cgroup *memcg,
 				   enum memcg_stat_item idx,
 				   int nr)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 62450e7991d8..373d36cae069 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -681,12 +681,12 @@ static int memcg_state_val_in_pages(int idx, int val)
 }
 
 /**
- * __mod_memcg_state - update cgroup memory statistics
+ * mod_memcg_state - update cgroup memory statistics
  * @memcg: the memory cgroup
  * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
  * @val: delta to add to the counter, can be negative
  */
-void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
+void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 		       int val)
 {
 	int i = memcg_stats_index(idx);
@@ -698,9 +698,13 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
+	if (WARN_ONCE(in_nmi(), "%s: called in nmi context for stat item %d\n",
+		      __func__, idx))
+		return;
+
 	cpu = get_cpu();
 
-	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
+	this_cpu_add(memcg->vmstats_percpu->state[i], val);
 	val = memcg_state_val_in_pages(idx, val);
 	memcg_rstat_updated(memcg, val, cpu);
 	trace_mod_memcg_state(memcg, idx, val);
@@ -2969,7 +2973,7 @@ static void drain_obj_stock(struct obj_stock_pcp *stock)
 
 			memcg = get_mem_cgroup_from_objcg(old);
 
-			__mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
 			memcg1_account_kmem(memcg, -nr_pages);
 			if (!mem_cgroup_is_root(memcg))
 				memcg_uncharge(memcg, nr_pages);
-- 
2.47.1


