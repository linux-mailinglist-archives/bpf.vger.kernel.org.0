Return-Path: <bpf+bounces-2977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2D4737945
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 04:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D242814E6
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 02:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969C3C8C1;
	Wed, 21 Jun 2023 02:33:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D7C2EE;
	Wed, 21 Jun 2023 02:33:28 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EECF1;
	Tue, 20 Jun 2023 19:33:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b51780c1b3so41890255ad.1;
        Tue, 20 Jun 2023 19:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687314806; x=1689906806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEKquVMkw51/BvAklYxg11PTcdb/zRr+O2bwkd8xPgw=;
        b=sbrad6lCF37udQKtgyCg+BM1cG/tKGtnbuEay3vW/LkmkYDeDWHbklrVZcvLj8/h3v
         9zo0kwc4nE0OAh3tNeqrRuQFBVrsLzyucWXrWAhIB90b+r9YtA5EQAs+YIViuIJncbol
         AdHOzMALqCL9p47NAqMSehYg+1Cqt5uCgTFH0kEH5s3QYnc4Uvpfp04DleoAQmieLnzQ
         eoVhv1HJYeoVG9xHXrfh5NAg1id1MDCA3gnS61pN7A/wo2zegqjzz5FZdAUTiqfx+/Pq
         9imSrh2xr0xBVvlQMIcqme3U/y6vBV+EbtXUhsshHdYkddrrLbDvk6hxbvUpYS6MMbgS
         ZdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314806; x=1689906806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEKquVMkw51/BvAklYxg11PTcdb/zRr+O2bwkd8xPgw=;
        b=lcAY71k4nEUtawqeDsMb+LBHkvceS8gTlw/2LSVl4oV2Jn2aR+spGQrpj5oP/Xe5hO
         CD51D6X9mK/8xWi+2FBdLPMWsRQSmTbrwfx+fxykelafsfEEtdqiXp1hRQxAlxqXD+Y8
         NnR2HIU8DpNoJWy8fFY5yvjluRsKmdesy8CvITSGmtIt+tIa2UTYs63YTaAF7U//w9Tq
         jM55W8tfAKRlHFwWyO8LNn5eTInswqp5TILVB3O7t8xEKFZV19Ei8/SmCrJin4fza8HO
         +z0nN3jZ/B+rgIzDgZ3cbMxZ5N3a4yHpff7qUKk5c9LwfyY4GfG9N2IKtzqYzFlkSu0K
         U4OA==
X-Gm-Message-State: AC+VfDxZpTY0pfz8Zc8GF8iiNMyHOKBcNU2E7UWHHPtx9nujRnvTsJZA
	BSn3cGb2NMRwKGc4BMRKL5E=
X-Google-Smtp-Source: ACHHUZ4rOzdXKHH8jnoO6fXDWe3Q5our3D6E2BReA1a5A3k/IRWl0QUM4gZeuQU3NDEivGJqUJls8g==
X-Received: by 2002:a17:902:d485:b0:1b6:79fe:3832 with SMTP id c5-20020a170902d48500b001b679fe3832mr4745005plg.69.1687314806194;
        Tue, 20 Jun 2023 19:33:26 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902b28500b001b672af624esm2231473plr.164.2023.06.20.19.33.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jun 2023 19:33:25 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	void@manifault.com,
	houtao@huaweicloud.com,
	paulmck@kernel.org
Cc: tj@kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 11/12] bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().
Date: Tue, 20 Jun 2023 19:32:37 -0700
Message-Id: <20230621023238.87079-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexei Starovoitov <ast@kernel.org>

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
---
 include/linux/bpf_mem_alloc.h |   2 +
 kernel/bpf/memalloc.c         | 118 ++++++++++++++++++++++++++++++++--
 2 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 3929be5743f4..d644bbb298af 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -27,10 +27,12 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
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
index 10d027674743..4d1002e7b4b5 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -100,6 +100,15 @@ struct bpf_mem_cache {
 	int percpu_size;
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
 	struct llist_node *free_by_rcu_ttrace_tail;
@@ -340,6 +349,56 @@ static void free_bulk(struct bpf_mem_cache *c)
 	do_call_rcu_ttrace(tgt);
 }
 
+static void __free_by_rcu(struct rcu_head *head)
+{
+	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+	struct bpf_mem_cache *tgt = c->tgt;
+	struct llist_node *llnode = llist_del_all(&c->waiting_for_gp);
+
+	if (!llnode)
+		goto out;
+
+	if (llist_add_batch(llnode, c->waiting_for_gp_tail, &tgt->free_by_rcu_ttrace))
+		tgt->free_by_rcu_ttrace_tail = c->waiting_for_gp_tail;
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
+
+	if (llist_empty(&c->free_by_rcu) && llist_empty(&c->free_llist_extra_rcu))
+		return;
+
+	/* drain free_llist_extra_rcu */
+	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra_rcu))
+		if (__llist_add(llnode, &c->free_by_rcu))
+			c->free_by_rcu_tail = llnode;
+
+	if (atomic_xchg(&c->call_rcu_in_progress, 1)) {
+		/*
+		 * Instead of kmalloc-ing new rcu_head and triggering 10k
+		 * call_rcu() to hit rcutree.qhimark and force RCU to notice
+		 * the overload just ask RCU to hurry up. There could be many
+		 * objects in free_by_rcu list.
+		 * This hint reduces memory consumption for an artifical
+		 * benchmark from 2 Gbyte to 150 Mbyte.
+		 */
+		rcu_request_urgent_qs_task(current);
+		return;
+	}
+
+	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
+
+	WRITE_ONCE(c->waiting_for_gp.first, __llist_del_all(&c->free_by_rcu));
+	c->waiting_for_gp_tail = c->free_by_rcu_tail;
+	call_rcu_hurry(&c->rcu, __free_by_rcu);
+}
+
 static void bpf_mem_refill(struct irq_work *work)
 {
 	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work);
@@ -354,6 +413,8 @@ static void bpf_mem_refill(struct irq_work *work)
 		alloc_bulk(c, c->batch, NUMA_NO_NODE);
 	else if (cnt > c->high_watermark)
 		free_bulk(c);
+
+	check_free_by_rcu(c);
 }
 
 static void notrace irq_work_raise(struct bpf_mem_cache *c)
@@ -482,6 +543,9 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
+	free_all(__llist_del_all(&c->free_by_rcu), percpu);
+	free_all(__llist_del_all(&c->free_llist_extra_rcu), percpu);
+	free_all(llist_del_all(&c->waiting_for_gp), percpu);
 }
 
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
@@ -494,8 +558,8 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 
 static void free_mem_alloc(struct bpf_mem_alloc *ma)
 {
-	/* waiting_for_gp_ttrace lists was drained, but __free_rcu might
-	 * still execute. Wait for it now before we freeing percpu caches.
+	/* waiting_for_gp[_ttrace] lists were drained, but RCU callbacks
+	 * might still execute. Wait for them.
 	 *
 	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
 	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
@@ -504,9 +568,10 @@ static void free_mem_alloc(struct bpf_mem_alloc *ma)
 	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
 	 * using rcu_trace_implies_rcu_gp() as well.
 	 */
-	rcu_barrier_tasks_trace();
+	rcu_barrier(); /* wait for __free_by_rcu() */
+	rcu_barrier_tasks_trace(); /* wait for __free_rcu() via call_rcu_tasks_trace */
 	if (!rcu_trace_implies_rcu_gp())
-		rcu_barrier();
+		rcu_barrier(); /* wait for __free_rcu() via call_rcu */
 	free_mem_alloc_no_barrier(ma);
 }
 
@@ -565,6 +630,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			irq_work_sync(&c->refill_work);
 			drain_mem_cache(c);
 			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
+			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 		}
 		/* objcg is the same across cpus */
 		if (c->objcg)
@@ -580,6 +646,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				irq_work_sync(&c->refill_work);
 				drain_mem_cache(c);
 				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
+				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 			}
 		}
 		if (c->objcg)
@@ -664,6 +731,27 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
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
@@ -697,6 +785,20 @@ void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
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
@@ -713,6 +815,14 @@ void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
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
2.34.1


