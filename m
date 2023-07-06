Return-Path: <bpf+bounces-4162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D3749467
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3CC281225
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4529C9454;
	Thu,  6 Jul 2023 03:35:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D6EA2;
	Thu,  6 Jul 2023 03:35:45 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB061BCA;
	Wed,  5 Jul 2023 20:35:39 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-54290603887so147747a12.1;
        Wed, 05 Jul 2023 20:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614539; x=1691206539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XvDiBoDjbQQa6lc4LFoLb3kfWjOt1I1H5xTwSvGnvw=;
        b=oqDB6ELAu/wo33otYPW4ZtFnT5JJc0S3Er4TRpkQKC9PJk1ZT4RINOQOR7Nk61LJ+7
         +1LU4mK0ysbgSt2/BzamQwASsdpQx+zI91nTiDGvtc+xNeJZ923lrlLuFqdOXjeIUspZ
         1qA06kw8i+b2Bxamv0KvphIXxIv7Wz2hhdl3HWkydNbpySlonPX6vVyfNCgKbdjvZ+ec
         wx9Ms6V1AIOtDbb+6rYbWpELBIwiYqC6o4n+pP7hC36SwKy+HVTKnYx6zoeUSypXUDnA
         442e9w6EknRRA5RyBPB2IyYIAL3V/Z6e+Uwvwv7ZXhxmu74OaFcZ+ijmVz8NScWw+hOA
         dneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614539; x=1691206539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XvDiBoDjbQQa6lc4LFoLb3kfWjOt1I1H5xTwSvGnvw=;
        b=NyC6Zf2mwt6ByXXh0qkjiXjUeP7qSxWXSsFapWStatoHM7vUsN6q5OrXfqse6GLdTM
         lQv2UN8xykwKpwaWcOa5+vyBLM/VtGmrfA79plc4ztRz0xoWicz2Zkmn4XYTj0OYTyw8
         7PrqZhL5iBAvfQ+1P+PkgvgHC16q7LGVnvgsvCiCpO5efdw6B90az72gqv7kbhyEYDLf
         8S51TzaAFEe/1/AZTBVh8XCx2NQ1E6EustZYw7MGcTmuBI3j76oUYxj637Phk+tvoWkN
         0jYibutobsbu2F9eg9noGlg4toREslUdth4KXP7A4oJSMi+LUdKm4lRnKA7/BS2FxtHK
         npEQ==
X-Gm-Message-State: ABy/qLYAElFswB/+Z+4kgxUNAavwe727TJnhUlbE8siO6d1+J3JpuYLa
	D/8on3lxb2c2p7/vPL2kyAk=
X-Google-Smtp-Source: APBJJlGRJysi9/fWfcAitLsK2vG63SDtfH5jwWELDSJo08dyUU9JjfS5EXqQ6EUOOLZYyjfFuD+fSA==
X-Received: by 2002:a05:6a00:1952:b0:668:73f5:dce0 with SMTP id s18-20020a056a00195200b0066873f5dce0mr559728pfk.29.1688614538620;
        Wed, 05 Jul 2023 20:35:38 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id x15-20020a62fb0f000000b00682936d04ccsm229209pfm.180.2023.07.05.20.35.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:35:38 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 12/14] bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().
Date: Wed,  5 Jul 2023 20:34:45 -0700
Message-Id: <20230706033447.54696-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/memalloc.c         | 129 +++++++++++++++++++++++++++++++++-
 2 files changed, 128 insertions(+), 3 deletions(-)

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
index e5a87f6cf2cc..17ef2e9b278a 100644
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
@@ -346,6 +355,69 @@ static void free_bulk(struct bpf_mem_cache *c)
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
@@ -360,6 +432,8 @@ static void bpf_mem_refill(struct irq_work *work)
 		alloc_bulk(c, c->batch, NUMA_NO_NODE);
 	else if (cnt > c->high_watermark)
 		free_bulk(c);
+
+	check_free_by_rcu(c);
 }
 
 static void notrace irq_work_raise(struct bpf_mem_cache *c)
@@ -488,6 +562,9 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
+	free_all(__llist_del_all(&c->free_by_rcu), percpu);
+	free_all(__llist_del_all(&c->free_llist_extra_rcu), percpu);
+	free_all(llist_del_all(&c->waiting_for_gp), percpu);
 }
 
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
@@ -500,8 +577,8 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 
 static void free_mem_alloc(struct bpf_mem_alloc *ma)
 {
-	/* waiting_for_gp_ttrace lists was drained, but __free_rcu might
-	 * still execute. Wait for it now before we freeing percpu caches.
+	/* waiting_for_gp[_ttrace] lists were drained, but RCU callbacks
+	 * might still execute. Wait for them.
 	 *
 	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
 	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
@@ -510,7 +587,8 @@ static void free_mem_alloc(struct bpf_mem_alloc *ma)
 	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
 	 * using rcu_trace_implies_rcu_gp() as well.
 	 */
-	rcu_barrier_tasks_trace();
+	rcu_barrier(); /* wait for __free_by_rcu */
+	rcu_barrier_tasks_trace(); /* wait for __free_rcu */
 	if (!rcu_trace_implies_rcu_gp())
 		rcu_barrier();
 	free_mem_alloc_no_barrier(ma);
@@ -563,6 +641,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			irq_work_sync(&c->refill_work);
 			drain_mem_cache(c);
 			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
+			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 		}
 		/* objcg is the same across cpus */
 		if (c->objcg)
@@ -579,6 +658,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				irq_work_sync(&c->refill_work);
 				drain_mem_cache(c);
 				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
+				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 			}
 		}
 		if (c->objcg)
@@ -663,6 +743,27 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
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
@@ -696,6 +797,20 @@ void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
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
@@ -712,6 +827,14 @@ void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
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


