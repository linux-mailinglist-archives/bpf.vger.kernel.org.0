Return-Path: <bpf+bounces-77323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B45EFCD7449
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 23:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC38B3065E53
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 22:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AF3331A4E;
	Mon, 22 Dec 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TQb8M73Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135D30B53C
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766441898; cv=none; b=dnjzBeLiyPy7q4CXMPqpkK1npmc650uVskO/2lew6sHXEV3VvVDqosI/7j/sSV4BND3YBN9CppfofAHKpb0l3OL2a/WSRHycTCN0BWHTO1XgNpCakOeCu1fvFs3ZXq32ifhOS8F5R53DHR9b5WfYyLn8hf51wowGHKfI0b6VUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766441898; c=relaxed/simple;
	bh=35bVIO0yJYzYT/Gc2lSJSFAE9kHo0AhbrY0o32pNgEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7M1zU+wg2ExNhADxp7T8t9s8calmSRyxgtqOYNpzLriyTZxmd1svWUVQKATlJyWOaB4Els1yebxHDAI2Ft+xBBOy6iwblZc1GA6eCSgC+UlAPDO2C5csrTil4FlQFWHgXR0iesVbwiuQQbwmIwNaOrOVksS0dIaIXWn8M7nSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TQb8M73Q; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766441894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZFZCyv+vpTD0CioVmAVVvbbZifAeeGjjT3wMREI9II=;
	b=TQb8M73QlVT9CWmyBzYH4viiXWskbsz1VogGfbuoF5IeUDiWSn9xYuqt1k/NjILeOWtxiN
	kwQ5CF2wzTItH8voOagOJNmMQXYAsOThVktbO+owqPQV59rHGstWZHDTh1Ue3SFhX9hyXP
	Rv35ggYTlybq5QBMCm/mQvqLboyr2NM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: JP Kobryn <inwardvessel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next v3 4/6] mm: introduce BPF kfuncs to access memcg statistics and events
Date: Mon, 22 Dec 2025 14:17:52 -0800
Message-ID: <20251222221754.186191-5-roman.gushchin@linux.dev>
In-Reply-To: <20251222221754.186191-1-roman.gushchin@linux.dev>
References: <20251222221754.186191-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce BPF kfuncs to conveniently access memcg data:
  - bpf_mem_cgroup_vm_events(),
  - bpf_mem_cgroup_memory_events(),
  - bpf_mem_cgroup_usage(),
  - bpf_mem_cgroup_page_state(),
  - bpf_mem_cgroup_flush_stats().

These functions are useful for implementing BPF OOM policies, but
also can be used to accelerate access to the memcg data. Reading
it through cgroupfs is much more expensive, roughly 5x, mostly
because of the need to convert the data into the text and back.

JP Kobryn:
An experiment was setup to compare the performance of a program that
uses the traditional method of reading memory.stat vs a program using
the new kfuncs. The control program opens up the root memory.stat file
and for 1M iterations reads, converts the string values to numeric data,
then seeks back to the beginning. The experimental program sets up the
requisite libbpf objects and for 1M iterations invokes a bpf program
which uses the kfuncs to fetch all available stats for node_stat_item,
memcg_stat_item, and vm_event_item types.

The results showed a significant perf benefit on the experimental side,
outperforming the control side by a margin of 93%. In kernel mode,
elapsed time was reduced by 80%, while in user mode, over 99% of time
was saved.

control: elapsed time
real    0m38.318s
user    0m25.131s
sys     0m13.070s

experiment: elapsed time
real    0m2.789s
user    0m0.187s
sys     0m2.512s

control: perf data
33.43% a.out libc.so.6         [.] __vfscanf_internal
 6.88% a.out [kernel.kallsyms] [k] vsnprintf
 6.33% a.out libc.so.6         [.] _IO_fgets
 5.51% a.out [kernel.kallsyms] [k] format_decode
 4.31% a.out libc.so.6         [.] __GI_____strtoull_l_internal
 3.78% a.out [kernel.kallsyms] [k] string
 3.53% a.out [kernel.kallsyms] [k] number
 2.71% a.out libc.so.6         [.] _IO_sputbackc
 2.41% a.out [kernel.kallsyms] [k] strlen
 1.98% a.out a.out             [.] main
 1.70% a.out libc.so.6         [.] _IO_getline_info
 1.51% a.out libc.so.6         [.] __isoc99_sscanf
 1.47% a.out [kernel.kallsyms] [k] memory_stat_format
 1.47% a.out [kernel.kallsyms] [k] memcpy_orig
 1.41% a.out [kernel.kallsyms] [k] seq_buf_printf

experiment: perf data
10.55% memcgstat bpf_prog_..._query [k] bpf_prog_16aab2f19fa982a7_query
 6.90% memcgstat [kernel.kallsyms]  [k] memcg_page_state_output
 3.55% memcgstat [kernel.kallsyms]  [k] _raw_spin_lock
 3.12% memcgstat [kernel.kallsyms]  [k] memcg_events
 2.87% memcgstat [kernel.kallsyms]  [k] __memcg_slab_post_alloc_hook
 2.73% memcgstat [kernel.kallsyms]  [k] kmem_cache_free
 2.70% memcgstat [kernel.kallsyms]  [k] entry_SYSRETQ_unsafe_stack
 2.25% memcgstat [kernel.kallsyms]  [k] __memcg_slab_free_hook
 2.06% memcgstat [kernel.kallsyms]  [k] get_page_from_freelist

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Co-developed-by: JP Kobryn <inwardvessel@gmail.com>
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/memcontrol.h | 14 +++++++
 mm/bpf_memcontrol.c        | 85 ++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c            | 10 +++++
 3 files changed, 109 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7bef427d5a82..6a5d65487b70 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -949,8 +949,12 @@ static inline void mod_memcg_page_state(struct page *page,
 	rcu_read_unlock();
 }
 
+unsigned long memcg_events(struct mem_cgroup *memcg, int event);
+unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
 unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
+bool memcg_stat_item_valid(int idx);
+bool memcg_vm_event_item_valid(enum vm_event_item idx);
 unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
 unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 				      enum node_stat_item idx);
@@ -1379,6 +1383,16 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg, in
 	return 0;
 }
 
+static inline bool memcg_stat_item_valid(int idx)
+{
+	return false;
+}
+
+static inline bool memcg_vm_event_item_valid(enum vm_event_item idx)
+{
+	return false;
+}
+
 static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
 					      enum node_stat_item idx)
 {
diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 187919eb2fe2..d248162872d3 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -80,6 +80,85 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
 	css_put(&memcg->css);
 }
 
+/**
+ * bpf_mem_cgroup_vm_events - Read memory cgroup's vm event counter
+ * @memcg: memory cgroup
+ * @event: event id
+ *
+ * Allows to read memory cgroup event counters.
+ *
+ * Return: The current value of the corresponding events counter.
+ */
+__bpf_kfunc unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *memcg,
+						   enum vm_event_item event)
+{
+	if (event >= NR_VM_EVENT_ITEMS || !memcg_vm_event_item_valid(event))
+		return (unsigned long)-1;
+
+	return memcg_events(memcg, event);
+}
+
+/**
+ * bpf_mem_cgroup_usage - Read memory cgroup's usage
+ * @memcg: memory cgroup
+ *
+ * Please, note that the root memory cgroup it special and is exempt
+ * from the memory accounting. The returned value is a sum of sub-cgroup's
+ * usages and it not reflecting the size of the root memory cgroup itself.
+ * If you need to get an approximation, you can use root level statistics:
+ * e.g. NR_FILE_PAGES + NR_ANON_MAPPED.
+ *
+ * Return: The current memory cgroup size in bytes.
+ */
+__bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
+{
+	return page_counter_read(&memcg->memory) * PAGE_SIZE;
+}
+
+/**
+ * bpf_mem_cgroup_memory_events - Read memory cgroup's memory event value
+ * @memcg: memory cgroup
+ * @event: memory event id
+ *
+ * Return: The current value of the memory event counter.
+ */
+__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg,
+						       enum memcg_memory_event event)
+{
+	if (event >= MEMCG_NR_MEMORY_EVENTS)
+		return (unsigned long)-1;
+
+	return atomic_long_read(&memcg->memory_events[event]);
+}
+
+/**
+ * bpf_mem_cgroup_page_state - Read memory cgroup's page state counter
+ * @memcg: memory cgroup
+ * @idx: counter idx
+ *
+ * Allows to read memory cgroup statistics. The output is in bytes.
+ *
+ * Return: The value of the page state counter in bytes.
+ */
+__bpf_kfunc unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int idx)
+{
+	if (idx < 0 || idx >= MEMCG_NR_STAT || !memcg_stat_item_valid(idx))
+		return (unsigned long)-1;
+
+	return memcg_page_state_output(memcg, idx);
+}
+
+/**
+ * bpf_mem_cgroup_flush_stats - Flush memory cgroup's statistics
+ * @memcg: memory cgroup
+ *
+ * Propagate memory cgroup's statistics up the cgroup tree.
+ */
+__bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
+{
+	mem_cgroup_flush_stats(memcg);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
@@ -87,6 +166,12 @@ BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_ACQUIRE | KF_RET_NULL | KF_RCU)
 BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
 
+BTF_ID_FLAGS(func, bpf_mem_cgroup_vm_events, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_memory_events, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_usage, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+
 BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
 
 static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index be810c1fbfc3..188a4df8d7ab 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -663,6 +663,11 @@ unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 	return x;
 }
 
+bool memcg_stat_item_valid(int idx)
+{
+	return !BAD_STAT_IDX(memcg_stats_index(idx));
+}
+
 static int memcg_page_state_unit(int item);
 
 /*
@@ -860,6 +865,11 @@ unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 	return READ_ONCE(memcg->vmstats->events[i]);
 }
 
+bool memcg_vm_event_item_valid(enum vm_event_item idx)
+{
+	return !BAD_STAT_IDX(memcg_events_index(idx));
+}
+
 #ifdef CONFIG_MEMCG_V1
 unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 {
-- 
2.52.0


