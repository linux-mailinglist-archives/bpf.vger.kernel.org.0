Return-Path: <bpf+bounces-3353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AAB73C685
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 05:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42DA1C213D5
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68955663;
	Sat, 24 Jun 2023 03:14:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1BE7F;
	Sat, 24 Jun 2023 03:14:26 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD26E47;
	Fri, 23 Jun 2023 20:14:25 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-544c0d768b9so1119019a12.0;
        Fri, 23 Jun 2023 20:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576464; x=1690168464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO3mquHsb2SLX3jh+W53s9CaZefqHX8CDJgrQ9c5OIY=;
        b=XDE3lInwGbLjgj5xeUIbBnLQ6QkcfC0ZJ0Cb2B+V3QLzrA5OEPIY2B5GW0Cvdr/9HT
         cIri37afZSVlUuDWoQM4tb+OvmEi9gPQl4dcMiYWcXdsquxVXDH6OPEw+IcOsvhC7SHA
         PJU6SbEXkYEe2KpwZm+hNXQQbmBvpPQzeh5xaSdLqcbSDuSsX44LB6t9/2sm2jWJ90RG
         wGj8yXRS/43gsUSZxCerJ39H5lHqnVwOTEC+99pscBQuQD4CjkL6rQE0Mr3gtRNcilkT
         wR1txEXb81MMncCFrX5Vp2bUtXHaoaXSMDsbr8gKwiLQAia1dirFX/rLQCtpMXgIgQSG
         RQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576464; x=1690168464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WO3mquHsb2SLX3jh+W53s9CaZefqHX8CDJgrQ9c5OIY=;
        b=HmK7Rvr3U49DJI+VXFbmUH2lsKLiWkrebw1/OPyI12OXMSvuDRKGgUlvU48sPtfUQO
         CrGetek1SPVSU47TDzs319HEJPTMKBX9ftn656LMCTxSBpIoBLN1iliOvWLQBB5cZzU5
         MIEnfRpNySuMuvoGngL+HKan/yfhepCqAV08mrI3yO5qwV2XNXz62seC3WeYNobhu6xS
         mFfwZASwSZJfujz1CvCHjg4RLvgM+Tf8UdsBk7jEHmrEu7uirOh4YZDJ8so6Ye+/ZaqD
         22xnznuJaMAGfxMppTBzp0srrnBDTAG1clcUBst4OSDxPCPI5kD5dzP/HzBAQ+k4Pybt
         a1aA==
X-Gm-Message-State: AC+VfDweu5/CqjvoeuJm2m5hWRpMM2sHEa5jZDEtOSCFObcFf1k/7YBe
	4JNWJA6E5fUtPOGGQIIOVuZnJwX+avU=
X-Google-Smtp-Source: ACHHUZ6xST1asMzWlt+08ilik6CxlRN0xPxSct9WaRObEiu6lHTFm8xtxaI6usfDtXnQM+0fKkX0OQ==
X-Received: by 2002:a17:903:2281:b0:1b3:cdfc:3e28 with SMTP id b1-20020a170903228100b001b3cdfc3e28mr1135423plh.23.1687576464482;
        Fri, 23 Jun 2023 20:14:24 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001ab0a30c895sm234961plg.202.2023.06.23.20.14.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:14:24 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().
Date: Fri, 23 Jun 2023 20:13:32 -0700
Message-Id: <20230624031333.96597-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/memalloc.c         | 117 +++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 2 deletions(-)

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
index 666917c16e87..dc144c54d502 100644
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
 	struct llist_node *free_by_rcu_ttrace_tail;
@@ -344,6 +353,60 @@ static void free_bulk(struct bpf_mem_cache *c)
 	do_call_rcu_ttrace(tgt);
 }
 
+static void __free_by_rcu(struct rcu_head *head)
+{
+	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+	struct bpf_mem_cache *tgt = c->tgt;
+	struct llist_node *llnode;
+
+	if (unlikely(READ_ONCE(c->draining)))
+		goto out;
+
+	llnode = llist_del_all(&c->waiting_for_gp);
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
@@ -358,6 +421,8 @@ static void bpf_mem_refill(struct irq_work *work)
 		alloc_bulk(c, c->batch, NUMA_NO_NODE);
 	else if (cnt > c->high_watermark)
 		free_bulk(c);
+
+	check_free_by_rcu(c);
 }
 
 static void notrace irq_work_raise(struct bpf_mem_cache *c)
@@ -486,6 +551,9 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
+	free_all(__llist_del_all(&c->free_by_rcu), percpu);
+	free_all(__llist_del_all(&c->free_llist_extra_rcu), percpu);
+	free_all(llist_del_all(&c->waiting_for_gp), percpu);
 }
 
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
@@ -498,8 +566,8 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 
 static void free_mem_alloc(struct bpf_mem_alloc *ma)
 {
-	/* waiting_for_gp_ttrace lists was drained, but __free_rcu might
-	 * still execute. Wait for it now before we freeing percpu caches.
+	/* waiting_for_gp[_ttrace] lists were drained, but RCU callbacks
+	 * might still execute. Wait for them.
 	 *
 	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
 	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
@@ -564,6 +632,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			c = per_cpu_ptr(ma->cache, cpu);
 			drain_mem_cache(c);
 			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
+			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 		}
 		/* objcg is the same across cpus */
 		if (c->objcg)
@@ -586,6 +655,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				c = &cc->cache[i];
 				drain_mem_cache(c);
 				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
+				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 			}
 		}
 		if (c->objcg)
@@ -670,6 +740,27 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
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
@@ -703,6 +794,20 @@ void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
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
@@ -719,6 +824,14 @@ void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
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


