Return-Path: <bpf+bounces-2973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CE473793B
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 04:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2E81C20DF1
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 02:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC578F41;
	Wed, 21 Jun 2023 02:33:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DE2905;
	Wed, 21 Jun 2023 02:33:12 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEDEF1;
	Tue, 20 Jun 2023 19:33:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51452556acdso2459732a12.2;
        Tue, 20 Jun 2023 19:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687314790; x=1689906790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqFaYoyk0/PHSh1SuXkk3tJoz+IsVkP3nG7jQGkvH4c=;
        b=ewnhZpp6X3uUhOrp5DXjxBEmu+lI/+oBmYaLNnkktQZk1nLX7NKHuD6hihZdEi5xGK
         ArTzFDuJEWbOt/TbmmKKGONu0uirCErAJadhMNK2r0GWk2EEjU39h580ScR53RLNeA8E
         zKAujfk3PRItECUY311ndjMFvC+W4SArwPE00f/GTqNwCaSPIHvPfXR9OqF2QOTvbwQJ
         d3CuGAvzmO/Yrj/8o4DoJI+zT+tw+mCP9wqpDBeyQaLKLNbR3PDWjIZ4Goe7a8uu2n2A
         bQznQ/4XmaVHZHD0uirL+kirmnluvSz0+ll0YIOVU7BdsBdpIHT/X6o2x9GikCu+5lgN
         nyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314790; x=1689906790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqFaYoyk0/PHSh1SuXkk3tJoz+IsVkP3nG7jQGkvH4c=;
        b=UjGoPsO9g/509xhI5UFJkyqDVjSbdNWnCzTwK08bqjKfp1Z3WyHfdAoJAs+oHidCLh
         BS5v2lX3/htiM8jD3TJZNvAVO3IEMoIGYwB8p7CEbJdCQSIsx1X1+R1Q3YzoxLoG7wfx
         NXMm6yVr4xYDmsf3P6em1Xjq0DHGfSvg+9aMPlxm1TVMOWrALWgw7XBhoDPWTuZkf/1b
         dPLjxqFVQhr8xP3mGXKkAX3gy75r1hoMSWWnHEchzPl9x5eRT+9PFKSHpjVdOnsZrtPH
         xft0u1Gj6ZUIuIaQJGYB3Nk27pPQH5BHHxk3EnPcCyjbPUmSmQzjNqVenqEsTDH75LPC
         mhdA==
X-Gm-Message-State: AC+VfDwdx+Y55z12qwTEJ9XTWJewHotusdQr69NKmRr1IgBajazBhwEW
	SWL5nR0WBV9Cnkk/9wsclWM=
X-Google-Smtp-Source: ACHHUZ4sCQNuGWkAYmDAYa0ZZxbIn/Dp+5wu55Sy4bP65uDB+nH1Ocgy6Ae+gvepe061zJuiyT0fcA==
X-Received: by 2002:a05:6a20:a11c:b0:106:c9b7:c92f with SMTP id q28-20020a056a20a11c00b00106c9b7c92fmr10893867pzk.49.1687314790363;
        Tue, 20 Jun 2023 19:33:10 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902ecc300b001b03a1a3151sm2244329plh.70.2023.06.20.19.33.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jun 2023 19:33:09 -0700 (PDT)
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
Subject: [PATCH bpf-next 07/12] bpf: Add a hint to allocated objects.
Date: Tue, 20 Jun 2023 19:32:33 -0700
Message-Id: <20230621023238.87079-8-alexei.starovoitov@gmail.com>
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

To address OOM issue when one cpu is allocating and another cpu is freeing add
a target bpf_mem_cache hint to allocated objects and when local cpu free_llist
overflows free to that bpf_mem_cache. The hint addresses the OOM while
maintaing the same performance for common case when alloc/free are done on the
same cpu.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 46 ++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 4fd79bd51f5a..8b7645bffd1a 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -98,6 +98,7 @@ struct bpf_mem_cache {
 	int free_cnt;
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
+	struct bpf_mem_cache *tgt;
 
 	/* list of objects to be freed after RCU tasks trace GP */
 	struct llist_head free_by_rcu_ttrace;
@@ -189,18 +190,11 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 
 	for (i = 0; i < cnt; i++) {
 		/*
-		 * free_by_rcu_ttrace is only manipulated by irq work refill_work().
-		 * IRQ works on the same CPU are called sequentially, so it is
-		 * safe to use __llist_del_first() here. If alloc_bulk() is
-		 * invoked by the initial prefill, there will be no running
-		 * refill_work(), so __llist_del_first() is fine as well.
-		 *
-		 * In most cases, objects on free_by_rcu_ttrace are from the same CPU.
-		 * If some objects come from other CPUs, it doesn't incur any
-		 * harm because NUMA_NO_NODE means the preference for current
-		 * numa node and it is not a guarantee.
+		 * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
+		 * done only by one CPU == current CPU. Other CPUs might
+		 * llist_add() and llist_del_all() in parallel.
 		 */
-		obj = __llist_del_first(&c->free_by_rcu_ttrace);
+		obj = llist_del_first(&c->free_by_rcu_ttrace);
 		if (!obj)
 			break;
 		add_obj_to_free_list(c, obj);
@@ -274,7 +268,7 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 	/* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
 	 * Nothing races to add to free_by_rcu_ttrace list.
 	 */
-	if (__llist_add(llnode, &c->free_by_rcu_ttrace))
+	if (llist_add(llnode, &c->free_by_rcu_ttrace))
 		c->free_by_rcu_ttrace_tail = llnode;
 }
 
@@ -286,7 +280,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 		return;
 
 	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
-	llnode = __llist_del_all(&c->free_by_rcu_ttrace);
+	llnode = llist_del_all(&c->free_by_rcu_ttrace);
 	if (llnode)
 		/* There is no concurrent __llist_add(waiting_for_gp_ttrace) access.
 		 * It doesn't race with llist_del_all either.
@@ -299,16 +293,22 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 	 * If RCU Tasks Trace grace period implies RCU grace period, free
 	 * these elements directly, else use call_rcu() to wait for normal
 	 * progs to finish and finally do free_one() on each element.
+	 *
+	 * call_rcu_tasks_trace() enqueues to a global queue, so it's ok
+	 * that current cpu bpf_mem_cache != target bpf_mem_cache.
 	 */
 	call_rcu_tasks_trace(&c->rcu_ttrace, __free_rcu_tasks_trace);
 }
 
 static void free_bulk(struct bpf_mem_cache *c)
 {
+	struct bpf_mem_cache *tgt = c->tgt;
 	struct llist_node *llnode, *t;
 	unsigned long flags;
 	int cnt;
 
+	WARN_ON_ONCE(tgt->unit_size != c->unit_size);
+
 	do {
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			local_irq_save(flags);
@@ -322,13 +322,13 @@ static void free_bulk(struct bpf_mem_cache *c)
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			local_irq_restore(flags);
 		if (llnode)
-			enque_to_free(c, llnode);
+			enque_to_free(tgt, llnode);
 	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
 
 	/* and drain free_llist_extra */
 	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
-		enque_to_free(c, llnode);
-	do_call_rcu_ttrace(c);
+		enque_to_free(tgt, llnode);
+	do_call_rcu_ttrace(tgt);
 }
 
 static void bpf_mem_refill(struct irq_work *work)
@@ -427,6 +427,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->unit_size = unit_size;
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
+			c->tgt = c;
 			prefill_mem_cache(c, cpu);
 		}
 		ma->cache = pc;
@@ -449,6 +450,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c = &cc->cache[i];
 			c->unit_size = sizes[i];
 			c->objcg = objcg;
+			c->tgt = c;
 			prefill_mem_cache(c, cpu);
 		}
 	}
@@ -467,7 +469,7 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * Except for waiting_for_gp_ttrace list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	free_all(__llist_del_all(&c->free_by_rcu_ttrace), percpu);
+	free_all(llist_del_all(&c->free_by_rcu_ttrace), percpu);
 	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
@@ -599,8 +601,10 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 	local_irq_save(flags);
 	if (local_inc_return(&c->active) == 1) {
 		llnode = __llist_del_first(&c->free_llist);
-		if (llnode)
+		if (llnode) {
 			cnt = --c->free_cnt;
+			*(struct bpf_mem_cache **)llnode = c;
+		}
 	}
 	local_dec(&c->active);
 	local_irq_restore(flags);
@@ -624,6 +628,12 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 
 	BUILD_BUG_ON(LLIST_NODE_SZ > 8);
 
+	/*
+	 * Remember bpf_mem_cache that allocated this object.
+	 * The hint is not accurate.
+	 */
+	c->tgt = *(struct bpf_mem_cache **)llnode;
+
 	local_irq_save(flags);
 	if (local_inc_return(&c->active) == 1) {
 		__llist_add(llnode, &c->free_llist);
-- 
2.34.1


