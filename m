Return-Path: <bpf+bounces-78700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA76D18A5B
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F84B3038891
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D744138E5EB;
	Tue, 13 Jan 2026 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj2/i4F2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45938E5CA
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306381; cv=none; b=J2WbtTzlEuvpSByV4gAWeWZbiINeEE9nDFzo8zEY/eWpEdS0G6dAq3ZRX3r9NRCnqNrcsk+i8/VhBasbV7YsmwuVGVkqsetOPm8nfiUvuPfqL1u8BM5FuFgNVblS9azs+QLw9/TPf2/mF6ROdHu6LHY6+4Rq+BNcMEd1cvR9mkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306381; c=relaxed/simple;
	bh=qVqKiwO+ARDSwmibR89f45pwx/6IO1wOyMRAKWoharQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlmrossATUuokiUPmxF/J7FZJCfg8Jq68eBnpRjdkkcgz43Xw9AekYhqBJCzZN/QkCoOa/lCGNXR0kdOahYpF7mv6C7nxooxpObSvmvjGCN+lKwihuUvxyvxOLSqfbQ3/UjZtcz4NXe182n/yiisOvfYoIkfCbqmiM5sP7C2vJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj2/i4F2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso2031459b3a.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 04:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768306379; x=1768911179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CR8k0pTAI0hGNUsgPy6QCqv5Ph7dVkX9F3Lq2Xl3H0=;
        b=dj2/i4F2hkiDqcHYc33f0+MNbiZch0AjkZOKRGscWlIYB0haUckK33UgG17ocDOHRN
         2mhaDtwe4UyfaFZlYsNk8ZR9QxWSN6vg3S+YkrdJiR/iTKPS8uMJ8xZ7uiO3oCmdAjrA
         1WYr0C9PFli9l8dFi4Rg8Llr26uFKPH4SRb0JSYzN76yEdMErSNDnKU/9PFlY3b8rZE8
         MD69goBJpHqP9W9dyf2JSRRxGzSlL2IRPvwwIy7rLgN5w7K4t/0d/Gki26xUEyIx8+8i
         dBrFYZ9HlxJmFn9XBg3/Bh3WA0GhGM2K/1ZESWpN8Yc/jjJIkibOR9B6+7bVWeS1cQRl
         9weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306379; x=1768911179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0CR8k0pTAI0hGNUsgPy6QCqv5Ph7dVkX9F3Lq2Xl3H0=;
        b=eWHRE9qIKuP3JLKBchYKB3fjp2tAvCFo7Eqhne2XVOGnBUEi/2SbzVySOYBw17M6gi
         Kh5OXGwzIpwdL2NVY44JNU/BUCjdHcb/UeiyEE3c3X2CBPz2IJB35TF3AutMKHdRsDS8
         JYSBHPeQPFUiK4gn0QbiLzIUE9A6s4T/1j9RhIobtXx2GYbdslE4tYnQkAbN6u9sJXph
         NXZwfp4OiL8d/vCDGNfGK9PIz9UsXBbl4WSRNybJLE5446F7G5Xh2tfYsJxYbNi1WeOi
         uJHsWxM4ZzijBxUbY9SXQHQHjpdJwXq8ajzhCRaDYcLWFOziCQLx7pHm+qfLfBVx6TXY
         pDJw==
X-Gm-Message-State: AOJu0YwXROLQkcXfiSwCjxCYv8NpgntBHcCRTZkDYuufn94OCbLEZkgF
	jVvKLTvuAZOfFywtv1cOJh6bxdWkg1pNVTFC/YKuxDTOFNDXaOSGQKjV
X-Gm-Gg: AY/fxX4vg+hI/zHA5Wcx01FIo7VkAGHpCNc5JUP2743lWzndgK3NBUj1+/iStg3O3aw
	dAILuhAVCEQxt7Brg1lnHkyoqGHAHIe4KCPK8BimpkvEjivEVJjfTsssARY4vKle29/18lpTelx
	/rZ/6bGd+qDOA3KyhDq1QCIBBJnCQVY3ccQZRjI3C6FqkVafFypn4/T734IwL8PnuN4s3seJ9D4
	Y3W+GnbMw6RuyAzGPhPyaG71O2PNglTjwY04lovCcYDxjUFZGGscc63DYhxCfdJO9jiNSSS30AE
	6HYem8+yLM6+BF6dwomAZfhLz9oyrs/94Q5xHa3z3p4Hi7tLX3e8wBOTtCYbbwJuZIs+gwbOGde
	cFb0eERp3UqMlWEOye/yHHoZ45+ziI4lnaENeozS6LzFfGzKf9kfgWbBfO0IE/vfySEa+7w+9aI
	0Z9BeeQ1fJ7wPzsy4hKge/x80BJ54HI+jiaQAay/U86f66eNkE0jVpSSc=
X-Google-Smtp-Source: AGHT+IG0J1J8i4JW8r6X8gc354XKnnX74EUP/eXr+s6KgXRsgR4zZ72avJxBpsfeA9EuyLQWDSHFfA==
X-Received: by 2002:a05:6a00:430e:b0:81f:4cf5:f252 with SMTP id d2e1a72fcca58-81f4cf605e8mr7205461b3a.24.1768306379241;
        Tue, 13 Jan 2026 04:12:59 -0800 (PST)
Received: from localhost.localdomain ([2409:891f:1d24:c3f5:8074:4004:163:94af])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81e7fd708fdsm11596703b3a.65.2026.01.13.04.12.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 04:12:58 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: roman.gushchin@linux.dev,
	inwardvessel@gmail.com,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mkoutny@suse.com,
	yu.c.chen@intel.com,
	zhao1.liu@intel.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 1/3] sched: add helpers for numa balancing
Date: Tue, 13 Jan 2026 20:12:36 +0800
Message-ID: <20260113121238.11300-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260113121238.11300-1-laoar.shao@gmail.com>
References: <20260113121238.11300-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three new helpers task_numab_enabled(), task_numab_mode_normal() and
task_numab_mode_tiering() are introduced for later use.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/sched/numa_balancing.h | 27 +++++++++++++++++++++++++++
 kernel/sched/fair.c                  | 15 +++++++--------
 kernel/sched/sched.h                 |  1 -
 mm/memory-tiers.c                    |  3 ++-
 mm/mempolicy.c                       |  3 +--
 mm/migrate.c                         |  7 ++++---
 mm/vmscan.c                          |  7 +++----
 7 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 52b22c5c396d..792b6665f476 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/sched/sysctl.h>
 
 #define TNF_MIGRATED	0x01
 #define TNF_NO_GROUP	0x02
@@ -32,6 +33,28 @@ extern void set_numabalancing_state(bool enabled);
 extern void task_numa_free(struct task_struct *p, bool final);
 bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 				int src_nid, int dst_cpu);
+
+extern struct static_key_false sched_numa_balancing;
+static inline bool task_numab_enabled(struct task_struct *p)
+{
+	if (static_branch_unlikely(&sched_numa_balancing))
+		return true;
+	return false;
+}
+
+static inline bool task_numab_mode_normal(void)
+{
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL)
+		return true;
+	return false;
+}
+
+static inline bool task_numab_mode_tiering(void)
+{
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
+		return true;
+	return false;
+}
 #else
 static inline void task_numa_fault(int last_node, int node, int pages,
 				   int flags)
@@ -52,6 +75,10 @@ static inline bool should_numa_migrate_memory(struct task_struct *p,
 {
 	return true;
 }
+static inline bool task_numab_enabled(struct task_struct *p)
+{
+	return false;
+}
 #endif
 
 #endif /* _LINUX_SCHED_NUMA_BALANCING_H */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da46c3164537..4f6583ef83b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1932,8 +1932,8 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
 	last_cpupid = folio_xchg_last_cpupid(folio, this_cpupid);
 
-	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
-	    !node_is_toptier(src_nid) && !cpupid_valid(last_cpupid))
+	if (!(task_numab_mode_tiering()) && !node_is_toptier(src_nid) &&
+	    !cpupid_valid(last_cpupid))
 		return false;
 
 	/*
@@ -3140,7 +3140,7 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	struct numa_group *ng;
 	int priv;
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!task_numab_enabled(p))
 		return;
 
 	/* for example, ksmd faulting in a user's mm */
@@ -3151,8 +3151,7 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	 * NUMA faults statistics are unnecessary for the slow memory
 	 * node for memory tiering mode.
 	 */
-	if (!node_is_toptier(mem_node) &&
-	    (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING ||
+	if (!node_is_toptier(mem_node) && (task_numab_mode_tiering() ||
 	     !cpupid_valid(last_cpupid)))
 		return;
 
@@ -3611,7 +3610,7 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
 	int src_nid = cpu_to_node(task_cpu(p));
 	int dst_nid = cpu_to_node(new_cpu);
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!task_numab_enabled(p))
 		return;
 
 	if (!p->mm || !p->numa_faults || (p->flags & PF_EXITING))
@@ -9353,7 +9352,7 @@ static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 	unsigned long src_weight, dst_weight;
 	int src_nid, dst_nid, dist;
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!task_numab_enabled(p))
 		return 0;
 
 	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
@@ -13374,7 +13373,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
-	if (static_branch_unlikely(&sched_numa_balancing))
+	if (task_numab_enabled(curr))
 		task_tick_numa(rq, curr);
 
 	update_misfit_status(curr, rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d30cca6870f5..1247e4b0c2b0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2269,7 +2269,6 @@ extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
 
 #endif /* !CONFIG_JUMP_LABEL */
 
-extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
 
 static inline u64 global_rt_period(void)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 864811fff409..cb14d557a995 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -7,6 +7,7 @@
 #include <linux/memory-tiers.h>
 #include <linux/notifier.h>
 #include <linux/sched/sysctl.h>
+#include <linux/sched/numa_balancing.h>
 
 #include "internal.h"
 
@@ -64,7 +65,7 @@ static const struct bus_type memory_tier_subsys = {
  */
 bool folio_use_access_time(struct folio *folio)
 {
-	return (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+	return (task_numab_mode_tiering()) &&
 	       !node_is_toptier(folio_nid(folio));
 }
 #endif
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 68a98ba57882..589bf37bc4ee 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -863,8 +863,7 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 	 * Skip scanning top tier node if normal numa
 	 * balancing is disabled
 	 */
-	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
-	    node_is_toptier(nid))
+	if (!task_numab_mode_normal() && node_is_toptier(nid))
 		return false;
 
 	if (folio_use_access_time(folio))
diff --git a/mm/migrate.c b/mm/migrate.c
index 5169f9717f60..aa540f4d4cc8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -41,6 +41,7 @@
 #include <linux/ptrace.h>
 #include <linux/memory.h>
 #include <linux/sched/sysctl.h>
+#include <linux/sched/numa_balancing.h>
 #include <linux/memory-tiers.h>
 #include <linux/pagewalk.h>
 
@@ -802,7 +803,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 	 * memory node, reset cpupid, because that is used to record
 	 * page access time in slow memory node.
 	 */
-	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) {
+	if (task_numab_mode_tiering()) {
 		bool f_toptier = node_is_toptier(folio_nid(folio));
 		bool t_toptier = node_is_toptier(folio_nid(newfolio));
 
@@ -2685,7 +2686,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
 		int z;
 
-		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
+		if (!task_numab_mode_tiering())
 			return -EAGAIN;
 		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
 			if (managed_zone(pgdat->node_zones + z))
@@ -2737,7 +2738,7 @@ int migrate_misplaced_folio(struct folio *folio, int node)
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
 		count_memcg_events(memcg, NUMA_PAGE_MIGRATE, nr_succeeded);
-		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
+		if (task_numab_mode_tiering()
 		    && !node_is_toptier(folio_nid(folio))
 		    && node_is_toptier(node))
 			mod_lruvec_state(lruvec, PGPROMOTE_SUCCESS, nr_succeeded);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 670fe9fae5ba..7ee5695326e3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -65,6 +65,7 @@
 #include <linux/swapops.h>
 #include <linux/balloon_compaction.h>
 #include <linux/sched/sysctl.h>
+#include <linux/sched/numa_balancing.h>
 
 #include "internal.h"
 #include "swap.h"
@@ -4843,9 +4844,7 @@ static bool should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
 	if (!current_is_kswapd() || sc->order)
 		return false;
 
-	mark = sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING ?
-	       WMARK_PROMO : WMARK_HIGH;
-
+	mark = task_numab_mode_tiering() ? WMARK_PROMO : WMARK_HIGH;
 	for (i = 0; i <= sc->reclaim_idx; i++) {
 		struct zone *zone = lruvec_pgdat(lruvec)->node_zones + i;
 		unsigned long size = wmark_pages(zone, mark) + MIN_LRU_BATCH;
@@ -6774,7 +6773,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 		enum zone_stat_item item;
 		unsigned long free_pages;
 
-		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
+		if (task_numab_mode_tiering())
 			mark = promo_wmark_pages(zone);
 		else
 			mark = high_wmark_pages(zone);
-- 
2.43.5


