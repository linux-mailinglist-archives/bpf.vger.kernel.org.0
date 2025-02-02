Return-Path: <bpf+bounces-50293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8961BA24CF6
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 08:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E58B1887B3A
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 07:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0261D5178;
	Sun,  2 Feb 2025 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="hSZYVmQq"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9BB1D5175
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482646; cv=none; b=SRYH1DA4TLeY7ivrL95XJOjLMQvz50uvKB5+fQNLo2urB0CRBkjq4dzH3VGX2MmzXfpngr0HIcKhF94BfoORWk+FNh2TKWX/6Kf7B6APxoWcCDbcV0+PYEK+3YkfNCP98LzAc4pIWQP7YtivGhNRfmAXKrtaaROSYRrjoYAHDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482646; c=relaxed/simple;
	bh=tdneJNNEVJixCG8akPaghX2HSPiSJkAgF1OweEuRbtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7RWjRiW621c+KyQNFqbJZEvOq0FdZ7xq5ZYv5OmW9hTtaKENpHYrQx1f/Jc61h3/LQxS95vLfX290DgUfPBRZuLrQ2qYcFKCWRZwCm6cPjwCT9D0V6guKsOCjvU33iJmNzTzEsxw3N1lXgZkPkaH98CYOj0pEJhmO0ii5cxW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=hSZYVmQq; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 547E41C19E0
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 10:50:42 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482641; x=1739346642; bh=tdneJNNEVJixCG8akPaghX2HSPi
	SJkAgF1OweEuRbtg=; b=hSZYVmQqnR3LyN1YeNTW6Xf1LEAAB1seiLHdb4CLvTv
	8CkanRqwgxp9FMNOccQ0YRXa2URAszzVmevc0saqwfLx9mJjRAPaRNjhJXg5aByc
	ZE8ve7QFG7MBeGyezI/w+ITzqnrf3tby60W9Lf8P/+nRDd1l9ZdxrTjPmX97kVL8
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VnbaVgbwcmgA for <bpf@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:41 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 4394E1C2427;
	Sun,  2 Feb 2025 10:50:22 +0300 (MSK)
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
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH 6.1 11/16] bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().
Date: Sun,  2 Feb 2025 07:46:48 +0000
Message-ID: <20250202074709.932174-12-sdl@nppct.ru>
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

From: Alexei Starovoitov <ast@kernel.org>

commit 5af6807bdb10d1af9d412d7d6c177ba8440adffb upstream.

Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
Unlike bpf_mem_[cache_]free() that links objects for immediate reuse into
per-cpu free list the _rcu() flavor waits for RCU grace period and then moves
objects into free_by_rcu_ttrace list where they are waiting for RCU
task trace grace period to be freed into slab.

The life cycle of objects:
alloc: dequeue free_llist
free: enqeueu free_llist
free_rcu: enqueue free_by_rcu -> waiting_for_gp
free_llist above high watermark -> free_by_rcu_ttrace
after RCU GP waiting_for_gp -> free_by_rcu_ttrace
free_by_rcu_ttrace -> waiting_for_gp_ttrace -> slab

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/bpf/20230706033447.54696-13-alexei.starovoitov@gmail.com
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 include/linux/bpf_mem_alloc.h |   2 +
 kernel/bpf/memalloc.c         | 139 +++++++++++++++++++++++++++++++++-
 2 files changed, 137 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 7e7df2c473d2..a57b7fc015fc 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -20,10 +20,12 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
 /* kmalloc/kfree equivalent: */
 void *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size);
 void bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr);
+void bpf_mem_free_rcu(struct bpf_mem_alloc *ma, void *ptr);
 
 /* kmem_cache_alloc/free equivalent: */
 void *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma);
 void bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr);
+void bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr);
 void bpf_mem_cache_raw_free(void *ptr);
 void *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags);
 
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index fb390dcdbdaa..b6aaf92b5259 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -101,6 +101,15 @@ struct bpf_mem_cache {
 	bool draining;
 	struct bpf_mem_cache *tgt;
 
+	/* list of objects to be freed after RCU GP */
+	struct llist_head free_by_rcu;
+	struct llist_node *free_by_rcu_tail;
+	struct llist_head waiting_for_gp;
+	struct llist_node *waiting_for_gp_tail;
+	struct rcu_head rcu;
+	atomic_t call_rcu_in_progress;
+	struct llist_head free_llist_extra_rcu;
+
 	/* list of objects to be freed after RCU tasks trace GP */
 	struct llist_head free_by_rcu_ttrace;
 	struct llist_head waiting_for_gp_ttrace;
@@ -342,6 +351,69 @@ static void free_bulk(struct bpf_mem_cache *c)
 	do_call_rcu_ttrace(tgt);
 }
 
+static void __free_by_rcu(struct rcu_head *head)
+{
+	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+	struct bpf_mem_cache *tgt = c->tgt;
+	struct llist_node *llnode;
+
+	llnode = llist_del_all(&c->waiting_for_gp);
+	if (!llnode)
+		goto out;
+
+	llist_add_batch(llnode, c->waiting_for_gp_tail, &tgt->free_by_rcu_ttrace);
+
+	/* Objects went through regular RCU GP. Send them to RCU tasks trace */
+	do_call_rcu_ttrace(tgt);
+out:
+	atomic_set(&c->call_rcu_in_progress, 0);
+}
+
+static void check_free_by_rcu(struct bpf_mem_cache *c)
+{
+	struct llist_node *llnode, *t;
+	unsigned long flags;
+
+	/* drain free_llist_extra_rcu */
+	if (unlikely(!llist_empty(&c->free_llist_extra_rcu))) {
+		inc_active(c, &flags);
+		llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra_rcu))
+			if (__llist_add(llnode, &c->free_by_rcu))
+				c->free_by_rcu_tail = llnode;
+		dec_active(c, flags);
+	}
+
+	if (llist_empty(&c->free_by_rcu))
+		return;
+
+	if (atomic_xchg(&c->call_rcu_in_progress, 1)) {
+		/*
+		 * Instead of kmalloc-ing new rcu_head and triggering 10k
+		 * call_rcu() to hit rcutree.qhimark and force RCU to notice
+		 * the overload just ask RCU to hurry up. There could be many
+		 * objects in free_by_rcu list.
+		 * This hint reduces memory consumption for an artificial
+		 * benchmark from 2 Gbyte to 150 Mbyte.
+		 */
+		rcu_request_urgent_qs_task(current);
+		return;
+	}
+
+	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
+
+	inc_active(c, &flags);
+	WRITE_ONCE(c->waiting_for_gp.first, __llist_del_all(&c->free_by_rcu));
+	c->waiting_for_gp_tail = c->free_by_rcu_tail;
+	dec_active(c, flags);
+
+	if (unlikely(READ_ONCE(c->draining))) {
+		free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
+		atomic_set(&c->call_rcu_in_progress, 0);
+	} else {
+		call_rcu_hurry(&c->rcu, __free_by_rcu);
+	}
+}
+
 static void bpf_mem_refill(struct irq_work *work)
 {
 	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work);
@@ -356,6 +428,8 @@ static void bpf_mem_refill(struct irq_work *work)
 		alloc_bulk(c, c->batch, NUMA_NO_NODE);
 	else if (cnt > c->high_watermark)
 		free_bulk(c);
+
+	check_free_by_rcu(c);
 }
 
 static void notrace irq_work_raise(struct bpf_mem_cache *c)
@@ -483,6 +557,9 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
+	free_all(__llist_del_all(&c->free_by_rcu), percpu);
+	free_all(__llist_del_all(&c->free_llist_extra_rcu), percpu);
+	free_all(llist_del_all(&c->waiting_for_gp), percpu);
 }
 
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
@@ -495,11 +572,20 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 
 static void free_mem_alloc(struct bpf_mem_alloc *ma)
 {
-	/* waiting_for_gp_ttrace lists was drained, but __free_rcu might
-	 * still execute. Wait for it now before we freeing percpu caches.
+	/* waiting_for_gp[_ttrace] lists were drained, but RCU callbacks
+	 * might still execute. Wait for them.
+	 *
+	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
+	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
+	 * to wait for the pending __free_rcu_tasks_trace() and __free_rcu(),
+	 * so if call_rcu(head, __free_rcu) is skipped due to
+	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
+	 * using rcu_trace_implies_rcu_gp() as well.
 	 */
-	rcu_barrier_tasks_trace();
-	rcu_barrier();
+	rcu_barrier(); /* wait for __free_by_rcu */
+	rcu_barrier_tasks_trace(); /* wait for __free_rcu */
+	if (!rcu_trace_implies_rcu_gp())
+		rcu_barrier();
 	free_mem_alloc_no_barrier(ma);
 }
 
@@ -553,6 +639,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			irq_work_sync(&c->refill_work);
 			drain_mem_cache(c);
 			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
+			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 		}
 		/* objcg is the same across cpus */
 		if (c->objcg)
@@ -569,6 +656,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				irq_work_sync(&c->refill_work);
 				drain_mem_cache(c);
 				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
+				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 			}
 		}
 		if (c->objcg)
@@ -653,6 +741,27 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 		irq_work_raise(c);
 }
 
+static void notrace unit_free_rcu(struct bpf_mem_cache *c, void *ptr)
+{
+	struct llist_node *llnode = ptr - LLIST_NODE_SZ;
+	unsigned long flags;
+
+	c->tgt = *(struct bpf_mem_cache **)llnode;
+
+	local_irq_save(flags);
+	if (local_inc_return(&c->active) == 1) {
+		if (__llist_add(llnode, &c->free_by_rcu))
+			c->free_by_rcu_tail = llnode;
+	} else {
+		llist_add(llnode, &c->free_llist_extra_rcu);
+	}
+	local_dec(&c->active);
+	local_irq_restore(flags);
+
+	if (!atomic_read(&c->call_rcu_in_progress))
+		irq_work_raise(c);
+}
+
 /* Called from BPF program or from sys_bpf syscall.
  * In both cases migration is disabled.
  */
@@ -686,6 +795,20 @@ void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
 	unit_free(this_cpu_ptr(ma->caches)->cache + idx, ptr);
 }
 
+void notrace bpf_mem_free_rcu(struct bpf_mem_alloc *ma, void *ptr)
+{
+	int idx;
+
+	if (!ptr)
+		return;
+
+	idx = bpf_mem_cache_idx(ksize(ptr - LLIST_NODE_SZ));
+	if (idx < 0)
+		return;
+
+	unit_free_rcu(this_cpu_ptr(ma->caches)->cache + idx, ptr);
+}
+
 void notrace *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma)
 {
 	void *ret;
@@ -702,6 +825,14 @@ void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
 	unit_free(this_cpu_ptr(ma->cache), ptr);
 }
 
+void notrace bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr)
+{
+	if (!ptr)
+		return;
+
+	unit_free_rcu(this_cpu_ptr(ma->cache), ptr);
+}
+
 /* Directly does a kfree() without putting 'ptr' back to the free_llist
  * for reuse and without waiting for a rcu_tasks_trace gp.
  * The caller must first go through the rcu_tasks_trace gp for 'ptr'
-- 
2.43.0


