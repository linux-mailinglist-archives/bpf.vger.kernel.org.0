Return-Path: <bpf+bounces-77223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C291CD26D1
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 05:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A563F301397D
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12462DE70B;
	Sat, 20 Dec 2025 04:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RruRHd+a"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1A028851E
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 04:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766204009; cv=none; b=fZBk6Nl5O4dMG6lD7kMV8dfo2R2rjaSwHF+U+OGqJcKSZYFHTlYFmJ1dPQgCRwqFhUg6AXCnpl4VKzt9usZMB2MEVK8S4+O0X2vRXPNI7cz8gdHy+GiXoD1VCH4iu6hduql853opaoUvqtNIUccZSmrk4O6EaZ/uiH1Z1JjmUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766204009; c=relaxed/simple;
	bh=M4f0axU2ABV7zQOgbhN3DTS3KOmbKOtxWSqPZETgH0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpDh8UNxKueUBjN1Yp5aTQ5Yho12cHAJJLK46bpcaCIuCG13J5+LBSbYdIA3FdEvsuXTHEF3UzWQRKrHIKC+L2a1slD/X0vsMdawtNDkzH/yEjgrSHepbz8OdbGU+4fd9yPtbu+UyHU/NEPWJP16m6yjABFTBjs8CBkj9nnadf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RruRHd+a; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766204000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAmHdQut5bmy5tCpMldk44XLF0pjcC9APBv9xG6KR/c=;
	b=RruRHd+atc2p1QdNvLwrdQEUiCQWNyfHbiNelmPzEz8nMp6fUAaBQpvS3zIZszSKHVOW0d
	Yu/IFGRE1UBKVg6Du3HbI42yWC17q4jiGw+H0T29019J7a0jbbH0kX5g5E0TSJageutwA5
	PDMmgH5XsQPpOF623z/H+ShPfVeWEgE=
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
	Roman Gushchin <roman.gushchin@linux.dev>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH bpf-next v2 4/7] mm: introduce BPF kfuncs to access memcg statistics and events
Date: Fri, 19 Dec 2025 20:12:47 -0800
Message-ID: <20251220041250.372179-5-roman.gushchin@linux.dev>
In-Reply-To: <20251220041250.372179-1-roman.gushchin@linux.dev>
References: <20251220041250.372179-1-roman.gushchin@linux.dev>
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
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memcontrol.h |  2 ++
 mm/bpf_memcontrol.c        | 56 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b309d13110af..8c1ba4477d36 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -949,6 +949,8 @@ static inline void mod_memcg_page_state(struct page *page,
 	rcu_read_unlock();
 }
 
+unsigned long memcg_events(struct mem_cgroup *memcg, int event);
+unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
 unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 2d518ad2ad3f..d84fe6f3ed43 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -78,6 +78,57 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
 	css_put(&memcg->css);
 }
 
+/**
+ * bpf_mem_cgroup_vm_events - Read memory cgroup's vm event counter
+ * @memcg: memory cgroup
+ * @event: event id
+ *
+ * Allows to read memory cgroup event counters.
+ */
+__bpf_kfunc unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *memcg,
+						enum vm_event_item event)
+{
+	return memcg_events(memcg, event);
+}
+
+/**
+ * bpf_mem_cgroup_usage - Read memory cgroup's usage
+ * @memcg: memory cgroup
+ *
+ * Returns current memory cgroup size in bytes.
+ * For the root memory cgroup it returns an approximate value.
+ */
+__bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
+{
+	return mem_cgroup_usage(memcg, false) * PAGE_SIZE;
+}
+
+/**
+ * bpf_mem_cgroup_page_state - Read memory cgroup's page state counter
+ * @memcg: memory cgroup
+ * @idx: counter idx
+ *
+ * Allows to read memory cgroup statistics. The output is in bytes.
+ */
+__bpf_kfunc unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int idx)
+{
+	if (idx < 0 || idx >= MEMCG_NR_STAT)
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
@@ -85,6 +136,11 @@ BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL | KF_RCU)
 BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_TRUSTED_ARGS | KF_RELEASE)
 
+BTF_ID_FLAGS(func, bpf_mem_cgroup_vm_events, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_usage, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+
 BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
 
 static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
-- 
2.52.0


