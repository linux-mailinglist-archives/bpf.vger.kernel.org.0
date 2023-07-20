Return-Path: <bpf+bounces-5537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DE475B8E2
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB06282000
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 20:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBC616417;
	Thu, 20 Jul 2023 20:45:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2C0156FE
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 20:45:33 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F181737
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 13:45:32 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b8b2a2e720so6558275ad.3
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689885932; x=1690490732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hiNIXe4QJqB6cgmbKcTShPc3I8DMUP0iGrpks2RgrSM=;
        b=6eLnf4jJ3RbQLKa2ilqJdKtUndfShEO6j4izWqORU+5NWplcU6PZkNOjK/RsmbWNJ+
         MPMUINs+cXQbHj8FPyv5zo+e8iDI6hmvRpg8+WD3I1OLg5cN+vmLGdVYlsFMmGVT4TMX
         FaMIGwZx3zyTi3dO7VuzMo8/6xbPVpmeT6Kg4drwgFA7Kz3+5LYLbV88Yna1dDyXKtbx
         PJqDQGneyUvS804o80WYd5z0q8CAHky7E+P3gByqUxlJhpR74rCgWsj3TGxhcDXUo8X8
         NBGO+RwW5Fqoi1zEKHuRCBfTkWZY+FudyYPv6Wm9kgyMZbjQ74bqQiekZCA2uwKc8RWn
         PkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689885932; x=1690490732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiNIXe4QJqB6cgmbKcTShPc3I8DMUP0iGrpks2RgrSM=;
        b=XSUHVTlHNqScnnqb+enWXbuxVJ0C1SoN2g86nWpLF4EpaTKfJJBtMrr+qziOR8i4jL
         fzBldNB992MtUq9cOVmBHSqKxA7g3xG4l6DKXjKFESJnNwtFRYH6tDYS6RioOaXWlzbi
         ZRzqfr3B76fKbp+OUP2AU8i65T+qBJVnZMmp+R+zCtTzg0l4DqMwoxl+qIXPbTzBU2n5
         rDxUH6r42sihuwGJSUwKDca7+IU+tgeX96IaEFfIQIbWep5Ybyn/JEZHagX5LAWQiw9w
         wtpIFpxlBqZvTo8luXV+D+bMx/N5uq+w9O0Y6WjwEk1EpwnNfwYGIPrnUNbT4RRAFNTI
         l+dg==
X-Gm-Message-State: ABy/qLZIA4FVWBU36CD01GhfjZKXdOm6elXCsRbPJ0nptEuN4z3FFoa9
	NdPaTThShJRBQPjOpvHBk8wZcqBD/QbbKZQczf5xRXL5gBynkjKRyaVUZ01mRX6PB5aqcPA6fqI
	lP/aKTVJj9Rnwj6NyV7YXeua6RdS9b7x1c0DdwK/kR9RvjDoFivIEp+9U0CUBNcQ=
X-Google-Smtp-Source: APBJJlF1afbuI2WmWBAMTSlsc/8FKTJnrXFdHMpWo0llsuOiEWtd0iE1cvllKPiZAUS+5zYVth8DzhMyJFVkRw==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:903:228d:b0:1b3:c62d:71b5 with SMTP
 id b13-20020a170903228d00b001b3c62d71b5mr655plh.0.1689885931163; Thu, 20 Jul
 2023 13:45:31 -0700 (PDT)
Date: Thu, 20 Jul 2023 20:44:55 +0000
In-Reply-To: <cover.1689885610.git.zhuyifei@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1689885610.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <3516fa9cc4bdbaeb90f208f5c970e622ba76be3e.1689885610.git.zhuyifei@google.com>
Subject: [PATCH bpf 2/2] bpf/memalloc: Schedule highprio wq for non-atomic
 alloc when atomic fails
From: YiFei Zhu <zhuyifei@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Stanislav Fomichev <sdf@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Atomic refill can fail, such as when all percpu chunks are full,
and when that happens there's no guarantee when more space will be
available for atomic allocations.

Instead of having the caller wait for memory to be available by
retrying until the related BPF API no longer gives -ENOMEM, we can
kick off a non-atomic GFP_KERNEL allocation with highprio workqueue.
This should make it much less likely for those APIs to return
-ENOMEM.

Because alloc_bulk can now be called from the workqueue,
non-atomic calls now also calls local_irq_save/restore to reduce
the chance of races.

Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory allocator.")
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 kernel/bpf/memalloc.c | 47 ++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 016249672b43..2915639a5e16 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -84,14 +84,15 @@ struct bpf_mem_cache {
 	struct llist_head free_llist;
 	local_t active;
 
-	/* Operations on the free_list from unit_alloc/unit_free/bpf_mem_refill
+	/* Operations on the free_list from unit_alloc/unit_free/bpf_mem_refill_*
 	 * are sequenced by per-cpu 'active' counter. But unit_free() cannot
 	 * fail. When 'active' is busy the unit_free() will add an object to
 	 * free_llist_extra.
 	 */
 	struct llist_head free_llist_extra;
 
-	struct irq_work refill_work;
+	struct irq_work refill_work_irq;
+	struct work_struct refill_work_wq;
 	struct obj_cgroup *objcg;
 	int unit_size;
 	/* count of objects in free_llist */
@@ -153,7 +154,7 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 #endif
 }
 
-/* Mostly runs from irq_work except __init phase. */
+/* Mostly runs from irq_work except workqueue and __init phase. */
 static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
 {
 	struct mem_cgroup *memcg = NULL, *old_memcg;
@@ -188,10 +189,18 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
 			 * want here.
 			 */
 			obj = __alloc(c, node, gfp);
-			if (!obj)
+			if (!obj) {
+				/* We might have exhausted the percpu chunks, schedule
+				 * non-atomic allocation so hopefully caller can get
+				 * a free unit upon next invocation.
+				 */
+				if (atomic)
+					queue_work_on(smp_processor_id(),
+						      system_highpri_wq, &c->refill_work_wq);
 				break;
+			}
 		}
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) || !atomic)
 			/* In RT irq_work runs in per-cpu kthread, so disable
 			 * interrupts to avoid preemption and interrupts and
 			 * reduce the chance of bpf prog executing on this cpu
@@ -208,7 +217,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
 		__llist_add(obj, &c->free_llist);
 		c->free_cnt++;
 		local_dec(&c->active);
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) || !atomic)
 			local_irq_restore(flags);
 	}
 	set_active_memcg(old_memcg);
@@ -314,9 +323,9 @@ static void free_bulk(struct bpf_mem_cache *c)
 	do_call_rcu(c);
 }
 
-static void bpf_mem_refill(struct irq_work *work)
+static void bpf_mem_refill_irq(struct irq_work *work)
 {
-	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work);
+	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work_irq);
 	int cnt;
 
 	/* Racy access to free_cnt. It doesn't need to be 100% accurate */
@@ -332,7 +341,14 @@ static void bpf_mem_refill(struct irq_work *work)
 
 static void notrace irq_work_raise(struct bpf_mem_cache *c)
 {
-	irq_work_queue(&c->refill_work);
+	irq_work_queue(&c->refill_work_irq);
+}
+
+static void bpf_mem_refill_wq(struct work_struct *work)
+{
+	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work_wq);
+
+	alloc_bulk(c, c->batch, NUMA_NO_NODE, false);
 }
 
 /* For typical bpf map case that uses bpf_mem_cache_alloc and single bucket
@@ -352,7 +368,8 @@ static void notrace irq_work_raise(struct bpf_mem_cache *c)
 
 static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 {
-	init_irq_work(&c->refill_work, bpf_mem_refill);
+	init_irq_work(&c->refill_work_irq, bpf_mem_refill_irq);
+	INIT_WORK(&c->refill_work_wq, bpf_mem_refill_wq);
 	if (c->unit_size <= 256) {
 		c->low_watermark = 32;
 		c->high_watermark = 96;
@@ -529,7 +546,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 		for_each_possible_cpu(cpu) {
 			c = per_cpu_ptr(ma->cache, cpu);
 			/*
-			 * refill_work may be unfinished for PREEMPT_RT kernel
+			 * refill_work_irq may be unfinished for PREEMPT_RT kernel
 			 * in which irq work is invoked in a per-CPU RT thread.
 			 * It is also possible for kernel with
 			 * arch_irq_work_has_interrupt() being false and irq
@@ -537,7 +554,8 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			 * the completion of irq work to ease the handling of
 			 * concurrency.
 			 */
-			irq_work_sync(&c->refill_work);
+			irq_work_sync(&c->refill_work_irq);
+			cancel_work_sync(&c->refill_work_wq);
 			drain_mem_cache(c);
 			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 		}
@@ -552,7 +570,8 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			cc = per_cpu_ptr(ma->caches, cpu);
 			for (i = 0; i < NUM_CACHES; i++) {
 				c = &cc->cache[i];
-				irq_work_sync(&c->refill_work);
+				irq_work_sync(&c->refill_work_irq);
+				cancel_work_sync(&c->refill_work_wq);
 				drain_mem_cache(c);
 				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 			}
@@ -580,7 +599,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 	 *
 	 * but prog_B could be a perf_event NMI prog.
 	 * Use per-cpu 'active' counter to order free_list access between
-	 * unit_alloc/unit_free/bpf_mem_refill.
+	 * unit_alloc/unit_free/bpf_mem_refill_*.
 	 */
 	local_irq_save(flags);
 	if (local_inc_return(&c->active) == 1) {
-- 
2.41.0.487.g6d72f3e995-goog


