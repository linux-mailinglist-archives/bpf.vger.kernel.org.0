Return-Path: <bpf+bounces-65902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E570B2AED4
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 19:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E753B4123
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AA234AAE3;
	Mon, 18 Aug 2025 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HmVndicI"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76434AAE5
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536526; cv=none; b=fsNh9t3ECUtrLazD9FsAdoMZG8i+lQYeuN/yDxxNlSkOPER92ePlyOPztkTn2MOW8TyPH7rDIA72fqcbo1v9vkum6YzMOPhx3PtuN8wtWX6GJhNwcosZhMWl/tL/P5PoNY5wXBhArQW5d70AClNeK5CNUGB5t11Mn313kKmjQb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536526; c=relaxed/simple;
	bh=XkDc9xaRsCenjnAav3LSkzM9k5QAYW2F9B7ruvWnRkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMwhp9AIkZEb8wtEHvO9Rxa4WZz9RB2MBD+RpaHdEiG4py0WbcHy9yjEX7ln0IkZpvuHP1/BOW2ouBZSH2IABYAhdfW6lPZgONGwErzyGYlXt9MctB4Jr0rrqqAKEzFr0UgyLQ0xpFKsmV00f8VeztIBDCIq6j1F+F/OMh3CQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HmVndicI; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755536522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbLFrydxxFltKx71yS/4EU7bCQFvXwfOv838sVEINzk=;
	b=HmVndicIgd1MOovjGT3tuk+Clf7w9gQt/J5iV244rD8BMDMagEbXceif4wnMg6wqi0thEx
	x0uvly97MaJ68GXg7+UWvj8c2K0A8gkSJwQyXDQ+uu87+gxH8naiO3OA/PGJl5XwAEq2uz
	tHBa73obbnXn3rKHcxgCrsAdsE6xpQ8=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 04/14] mm: introduce bpf kfuncs to deal with memcg pointers
Date: Mon, 18 Aug 2025 10:01:26 -0700
Message-ID: <20250818170136.209169-5-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-1-roman.gushchin@linux.dev>
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To effectively operate with memory cgroups in bpf there is a need
to convert css pointers to memcg pointers. A simple container_of
cast which is used in the kernel code can't be used in bpf because
from the verifier's point of view that's a out-of-bounds memory access.

Introduce helper get/put kfuncs which can be used to get
a refcounted memcg pointer from the css pointer:
  - bpf_get_mem_cgroup,
  - bpf_put_mem_cgroup.

bpf_get_mem_cgroup() can take both memcg's css and the corresponding
cgroup's "self" css. It allows it to be used with the existing cgroup
iterator which iterates over cgroup tree, not memcg tree.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h |   2 +
 mm/Makefile                |   1 +
 mm/bpf_memcontrol.c        | 151 +++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 mm/bpf_memcontrol.c

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 87b6688f124a..785a064000cd 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -932,6 +932,8 @@ static inline void mod_memcg_page_state(struct page *page,
 	rcu_read_unlock();
 }
 
+unsigned long memcg_events(struct mem_cgroup *memcg, int event);
+unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
 unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
 unsigned long lruvec_page_state_local(struct lruvec *lruvec,
diff --git a/mm/Makefile b/mm/Makefile
index a714aba03759..c397af904a87 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
 ifdef CONFIG_BPF_SYSCALL
 obj-y += bpf_oom.o
+obj-$(CONFIG_MEMCG) += bpf_memcontrol.o
 endif
 obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
 obj-$(CONFIG_GUP_TEST) += gup_test.o
diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
new file mode 100644
index 000000000000..66f2a359af7e
--- /dev/null
+++ b/mm/bpf_memcontrol.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Memory Controller-related BPF kfuncs and auxiliary code
+ *
+ * Author: Roman Gushchin <roman.gushchin@linux.dev>
+ */
+
+#include <linux/memcontrol.h>
+#include <linux/bpf.h>
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_get_mem_cgroup - Get a reference to a memory cgroup
+ * @css: pointer to the css structure
+ *
+ * Returns a pointer to a mem_cgroup structure after bumping
+ * the corresponding css's reference counter.
+ *
+ * It's fine to pass a css which belongs to any cgroup controller,
+ * e.g. unified hierarchy's main css.
+ *
+ * Implements KF_ACQUIRE semantics.
+ */
+__bpf_kfunc struct mem_cgroup *
+bpf_get_mem_cgroup(struct cgroup_subsys_state *css)
+{
+	struct mem_cgroup *memcg = NULL;
+	bool rcu_unlock = false;
+
+	if (!root_mem_cgroup)
+		return NULL;
+
+	if (root_mem_cgroup->css.ss != css->ss) {
+		struct cgroup *cgroup = css->cgroup;
+		int ssid = root_mem_cgroup->css.ss->id;
+
+		rcu_read_lock();
+		rcu_unlock = true;
+		css = rcu_dereference_raw(cgroup->subsys[ssid]);
+	}
+
+	if (css && css_tryget(css))
+		memcg = container_of(css, struct mem_cgroup, css);
+
+	if (rcu_unlock)
+		rcu_read_unlock();
+
+	return memcg;
+}
+
+/**
+ * bpf_put_mem_cgroup - Put a reference to a memory cgroup
+ * @memcg: memory cgroup to release
+ *
+ * Releases a previously acquired memcg reference.
+ * Implements KF_RELEASE semantics.
+ */
+__bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
+{
+	css_put(&memcg->css);
+}
+
+/**
+ * bpf_mem_cgroup_events - Read memory cgroup's event counter
+ * @memcg: memory cgroup
+ * @event: event idx
+ *
+ * Allows to read memory cgroup event counters.
+ */
+__bpf_kfunc unsigned long bpf_mem_cgroup_events(struct mem_cgroup *memcg, int event)
+{
+
+	if (event < 0 || event >= NR_VM_EVENT_ITEMS)
+		return (unsigned long)-1;
+
+	return memcg_events(memcg, event);
+}
+
+/**
+ * bpf_mem_cgroup_usage - Read memory cgroup's usage
+ * @memcg: memory cgroup
+ *
+ * Returns current memory cgroup size in bytes.
+ */
+__bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
+{
+	return page_counter_read(&memcg->memory);
+}
+
+/**
+ * bpf_mem_cgroup_events - Read memory cgroup's page state counter
+ * @memcg: memory cgroup
+ * @event: event idx
+ *
+ * Allows to read memory cgroup statistics.
+ */
+__bpf_kfunc unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int idx)
+{
+	if (idx < 0 || idx >= MEMCG_NR_STAT)
+		return (unsigned long)-1;
+
+	return memcg_page_state(memcg, idx);
+}
+
+/**
+ * bpf_mem_cgroup_flush_stats - Flush memory cgroup's statistics
+ * @memcg: memory cgroup
+ *
+ * Propagate memory cgroup's statistics up the cgroup tree.
+ *
+ * Note, that this function uses the rate-limited version of
+ * mem_cgroup_flush_stats() to avoid hurting the system-wide
+ * performance. So bpf_mem_cgroup_flush_stats() guarantees only
+ * that statistics is not stale beyond 2*FLUSH_TIME.
+ */
+__bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
+{
+	mem_cgroup_flush_stats_ratelimited(memcg);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
+BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
+
+BTF_ID_FLAGS(func, bpf_mem_cgroup_events, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_usage, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_TRUSTED_ARGS)
+
+BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
+
+static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_memcontrol_kfuncs,
+};
+
+static int __init bpf_memcontrol_init(void)
+{
+	int err;
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&bpf_memcontrol_kfunc_set);
+	if (err)
+		pr_warn("error while registering bpf memcontrol kfuncs: %d", err);
+
+	return err;
+}
+late_initcall(bpf_memcontrol_init);
-- 
2.50.1


