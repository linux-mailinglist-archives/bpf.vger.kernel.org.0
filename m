Return-Path: <bpf+bounces-3630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFE874080D
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 04:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09260281204
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 02:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F34BBA2F;
	Wed, 28 Jun 2023 01:57:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E896AD26;
	Wed, 28 Jun 2023 01:57:28 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33CADA;
	Tue, 27 Jun 2023 18:57:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6682909acadso2837351b3a.3;
        Tue, 27 Jun 2023 18:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917446; x=1690509446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSXoca94rrs9IDSeG1xXAALoWdcRbwaU34EJa2rPJ9U=;
        b=WPB/ccQ9Tk0oMDO3ZO4wY6oiFIU3GG6Ma6/FmKHW4vw1MCJ27Cw2d6WkDjBvGVaHJH
         oM3P+UeSVDrG9iytkgr3ovkMWP8YwFAF5x5TUiw1eNwi9qJNQZP6/v3WV2PV2VNHqv35
         veLKeXHYKePkZR+KIdn3le7yT43p4AG6LxOv+MHzCafUjoE3mqVJvhGrCM50FQNBDK0p
         cTIlyLv+oaEDjUP5t2kbuXflmidELq+6VkeHtpF4C+22Vdy6OasjxsEreIgEzEXw0bWM
         XCbjkqTokNSe7Zmurp66ufggVuKt/drzDBa8BtbQKwgvJd6J2r6+kVYw4N4IeFxYqtxv
         6Gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917446; x=1690509446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSXoca94rrs9IDSeG1xXAALoWdcRbwaU34EJa2rPJ9U=;
        b=PGSq+PTRnR57oRpwMgzAI+P6iHB9LiXsQG3+cjmKVY83XEKXM7aBBxkJChZTmXkbFz
         /tebKYdUSV87hIohCaBZXq/ymXdjDJbDMMztMnLr1ELD3HFhfX3hgAjQ0RWm35USCkoF
         5kGG79KO/1Z9K9tIl1H5yjO3xloeFzaIIKA3u3Mx2/STyOlUL0/6Q4uloicDM2niX+nQ
         6vKHEP+CZ/jQplSf4b4/azmcJgJ2uHN7L1IBN/gmbLDNKsbpL4bbEl73aM7OPqtW77Bh
         BvCtnRY+poCyxQ3t0dndab3x4b0pwTLV+tqfx0jx0zSJhfN2rzRGarypFvMdHACXpHNr
         hHLw==
X-Gm-Message-State: AC+VfDzKXXd8TEvIYFxXT9imnUmQdLSnwr+EsyhEypcYrsRh+OCjqy2M
	9xwE0i0V2/CCL4hnNN7OdC8=
X-Google-Smtp-Source: ACHHUZ50BQwMER6D8+PpQKSZSLRyDdrbJJl+VP/Xqz4RNRVhgANOFF6/6r5QiE5RSj/kQsvGNm4zTg==
X-Received: by 2002:a05:6a00:1586:b0:66a:5466:25bd with SMTP id u6-20020a056a00158600b0066a546625bdmr14064448pfk.15.1687917445997;
        Tue, 27 Jun 2023 18:57:25 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id h3-20020a62b403000000b006468222af91sm5982960pfn.48.2023.06.27.18.57.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:57:25 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().
Date: Tue, 27 Jun 2023 18:56:33 -0700
Message-Id: <20230628015634.33193-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
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
index 40524d9454c7..3081d06a434c 100644
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
@@ -344,6 +353,69 @@ static void free_bulk(struct bpf_mem_cache *c)
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
+		 * This hint reduces memory consumption for an artifical
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
@@ -358,6 +430,8 @@ static void bpf_mem_refill(struct irq_work *work)
 		alloc_bulk(c, c->batch, NUMA_NO_NODE);
 	else if (cnt > c->high_watermark)
 		free_bulk(c);
+
+	check_free_by_rcu(c);
 }
 
 static void notrace irq_work_raise(struct bpf_mem_cache *c)
@@ -486,6 +560,9 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
+	free_all(__llist_del_all(&c->free_by_rcu), percpu);
+	free_all(__llist_del_all(&c->free_llist_extra_rcu), percpu);
+	free_all(llist_del_all(&c->waiting_for_gp), percpu);
 }
 
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
@@ -498,8 +575,8 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 
 static void free_mem_alloc(struct bpf_mem_alloc *ma)
 {
-	/* waiting_for_gp_ttrace lists was drained, but __free_rcu might
-	 * still execute. Wait for it now before we freeing percpu caches.
+	/* waiting_for_gp[_ttrace] lists were drained, but RCU callbacks
+	 * might still execute. Wait for them.
 	 *
 	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
 	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
@@ -508,7 +585,8 @@ static void free_mem_alloc(struct bpf_mem_alloc *ma)
 	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
 	 * using rcu_trace_implies_rcu_gp() as well.
 	 */
-	rcu_barrier_tasks_trace();
+	rcu_barrier(); /* wait for __free_by_rcu */
+	rcu_barrier_tasks_trace(); /* wait for __free_rcu */
 	if (!rcu_trace_implies_rcu_gp())
 		rcu_barrier();
 	free_mem_alloc_no_barrier(ma);
@@ -561,6 +639,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			irq_work_sync(&c->refill_work);
 			drain_mem_cache(c);
 			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
+			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 		}
 		/* objcg is the same across cpus */
 		if (c->objcg)
@@ -577,6 +656,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				irq_work_sync(&c->refill_work);
 				drain_mem_cache(c);
 				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
+				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 			}
 		}
 		if (c->objcg)
@@ -661,6 +741,27 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
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
@@ -694,6 +795,20 @@ void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
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
@@ -710,6 +825,14 @@ void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
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


