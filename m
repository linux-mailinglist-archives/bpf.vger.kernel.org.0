Return-Path: <bpf+bounces-50283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B39A24CDB
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 08:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489DB1885820
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 07:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142411D5166;
	Sun,  2 Feb 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="fAs1ZbhM"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C511DA23
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482579; cv=none; b=kIETotIhdWLwSTiohjMCbl26o2oEz2hsgeKGW74NblU0FiOBcbqcEMWsZ8l5GP+bbaevC00ZL8EK5T1XQbYf/eBZ7qWQ4NVCk8Dov6Lrul4CqtG3EEXXpU6VU9fQ3kaZ3bjSriQfgnZ85/pZP/tnofJH+PL2CkXi3FSgmcSvoVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482579; c=relaxed/simple;
	bh=FNrQJfmODYr+p9jgoG0BB4e5t5Pza8kKQEsrndcAKp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQ8rJMscoIPQovQVcperjvBY1x9yu5qglihvEtqeorfKGuT1Up+VmGBH+BOSaAzlbgrgUdeq/O9hVqO/dtb+MtSbwOL2U/XbbQzJzlWDLfDWjfYR9Bjrx5PFiyzx7nJDCQqDJGO0+1yLPQL6h8FffTR4rAuGwNIglFNjX/0btAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=fAs1ZbhM; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id EB5061C2428
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 10:49:35 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482575; x=1739346576; bh=FNrQJfmODYr+p9jgoG0BB4e5t5P
	za8kKQEsrndcAKp0=; b=fAs1ZbhM98nAZI4nNTtD41Yl3ckBur7ZwQMDU53xGL8
	TMYUVL6SIi+7UYNo/Dd+BnYsQXcGgSYkiT1nj2EvdI6h4zay7iQ2IVotUMVSDHx6
	5r32vAlpBrgfb+CdIJGRvzEOp79iUtn7uVdsNG/gYkx2+rddD+wbSIUYvJWRI61U
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8ZvWDdXswPag for <bpf@vger.kernel.org>;
	Sun,  2 Feb 2025 10:49:35 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 987491C19B7;
	Sun,  2 Feb 2025 10:49:33 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH 6.1 01/16] bpf: Add a few bpf mem allocator functions
Date: Sun,  2 Feb 2025 07:46:38 +0000
Message-ID: <20250202074709.932174-2-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202074709.932174-1-sdl@nppct.ru>
References: <20250202074709.932174-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

commit e65a5c6edbc6ca4853e6076bd81db1a410592a09 upstream.

This patch adds a few bpf mem allocator functions which will
be used in the bpf_local_storage in a later patch.

bpf_mem_cache_alloc_flags(..., gfp_t flags) is added. When the
flags == GFP_KERNEL, it will fallback to __alloc(..., GFP_KERNEL).
bpf_local_storage knows its running context is sleepable (GFP_KERNEL)
and provides a better guarantee on memory allocation.

bpf_local_storage has some uncommon cases that its selem
cannot be reused immediately. It handles its own
rcu_head and goes through a rcu_trace gp and then free it.
bpf_mem_cache_raw_free() is added for direct free purpose
without leaking the LLIST_NODE_SZ internal knowledge.
During free time, the 'struct bpf_mem_alloc *ma' is no longer
available. However, the caller should know if it is
percpu memory or not and it can call different raw_free functions.
bpf_local_storage does not support percpu value, so only
the non-percpu 'bpf_mem_cache_raw_free()' is added in
this patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20230322215246.1675516-2-martin.lau@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 include/linux/bpf_mem_alloc.h |  2 +
 kernel/bpf/memalloc.c         | 78 ++++++++++++++++++++++++++++++-----
 2 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 3e164b8efaa9..7e7df2c473d2 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -24,5 +24,7 @@ void bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr);
 /* kmem_cache_alloc/free equivalent: */
 void *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma);
 void bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr);
+void bpf_mem_cache_raw_free(void *ptr);
+void *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags);
 
 #endif /* _BPF_MEM_ALLOC_H */
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index ace303a220ae..6382da64459a 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -121,15 +121,8 @@ static struct llist_node notrace *__llist_del_first(struct llist_head *head)
 	return entry;
 }
 
-static void *__alloc(struct bpf_mem_cache *c, int node)
+static void *__alloc(struct bpf_mem_cache *c, int node, gfp_t flags)
 {
-	/* Allocate, but don't deplete atomic reserves that typical
-	 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
-	 * will allocate from the current numa node which is what we
-	 * want here.
-	 */
-	gfp_t flags = GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT;
-
 	if (c->percpu_size) {
 		void **obj = kmalloc_node(c->percpu_size, flags, node);
 		void *pptr = __alloc_percpu_gfp(c->unit_size, 8, flags);
@@ -171,9 +164,29 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	memcg = get_memcg(c);
 	old_memcg = set_active_memcg(memcg);
 	for (i = 0; i < cnt; i++) {
-		obj = __alloc(c, node);
-		if (!obj)
-			break;
+		/*
+		 * free_by_rcu is only manipulated by irq work refill_work().
+		 * IRQ works on the same CPU are called sequentially, so it is
+		 * safe to use __llist_del_first() here. If alloc_bulk() is
+		 * invoked by the initial prefill, there will be no running
+		 * refill_work(), so __llist_del_first() is fine as well.
+		 *
+		 * In most cases, objects on free_by_rcu are from the same CPU.
+		 * If some objects come from other CPUs, it doesn't incur any
+		 * harm because NUMA_NO_NODE means the preference for current
+		 * numa node and it is not a guarantee.
+		 */
+		obj = __llist_del_first(&c->free_by_rcu);
+		if (!obj) {
+			/* Allocate, but don't deplete atomic reserves that typical
+			 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
+			 * will allocate from the current numa node which is what we
+			 * want here.
+			 */
+			obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
+			if (!obj)
+				break;
+		}
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			/* In RT irq_work runs in per-cpu kthread, so disable
 			 * interrupts to avoid preemption and interrupts and
@@ -647,3 +660,46 @@ void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
 
 	unit_free(this_cpu_ptr(ma->cache), ptr);
 }
+
+/* Directly does a kfree() without putting 'ptr' back to the free_llist
+ * for reuse and without waiting for a rcu_tasks_trace gp.
+ * The caller must first go through the rcu_tasks_trace gp for 'ptr'
+ * before calling bpf_mem_cache_raw_free().
+ * It could be used when the rcu_tasks_trace callback does not have
+ * a hold on the original bpf_mem_alloc object that allocated the
+ * 'ptr'. This should only be used in the uncommon code path.
+ * Otherwise, the bpf_mem_alloc's free_llist cannot be refilled
+ * and may affect performance.
+ */
+void bpf_mem_cache_raw_free(void *ptr)
+{
+	if (!ptr)
+		return;
+
+	kfree(ptr - LLIST_NODE_SZ);
+}
+
+/* When flags == GFP_KERNEL, it signals that the caller will not cause
+ * deadlock when using kmalloc. bpf_mem_cache_alloc_flags() will use
+ * kmalloc if the free_llist is empty.
+ */
+void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
+{
+	struct bpf_mem_cache *c;
+	void *ret;
+
+	c = this_cpu_ptr(ma->cache);
+
+	ret = unit_alloc(c);
+	if (!ret && flags == GFP_KERNEL) {
+		struct mem_cgroup *memcg, *old_memcg;
+
+		memcg = get_memcg(c);
+		old_memcg = set_active_memcg(memcg);
+		ret = __alloc(c, NUMA_NO_NODE, GFP_KERNEL | __GFP_NOWARN | __GFP_ACCOUNT);
+		set_active_memcg(old_memcg);
+		mem_cgroup_put(memcg);
+	}
+
+	return !ret ? NULL : ret + LLIST_NODE_SZ;
+}
-- 
2.43.0


