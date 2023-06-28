Return-Path: <bpf+bounces-3619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C797407E1
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 03:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123841C20B5A
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 01:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E954C1FB7;
	Wed, 28 Jun 2023 01:56:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9438187D;
	Wed, 28 Jun 2023 01:56:44 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C319E297B;
	Tue, 27 Jun 2023 18:56:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b801e6ce85so3325215ad.1;
        Tue, 27 Jun 2023 18:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917402; x=1690509402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnvjt/gAeB7s5ArRb1iRUdzehhXE3naKGVtPVDLMicQ=;
        b=WYtjcQf8YgZ72CYD/aEhu6in5okZ+zc61H9TSvTaZMX0L40lFfNTVvpSXpAeceEfdH
         Rfr3mqrXxlOUwFTSD9potOda1dJdDbH1aALmuTlRUenjVutYzBau5UpufXxUsnyJgece
         x/W6i6r2smYYIXpezttWlVtrT9R+0PMq2dDaJhWnSJXrnt4lJGmGnv50itLYtz6ENMSB
         FfLLBQrHKm4MMloc/MdcMx1eU+mq8JHmDRGlnueStvyHzRsdl4tTTDFF2ZFUl7bZjvwl
         Hvm5ZtmCJreQn+w5RSIqEU5bAvnJhuZ1UIqImxDgW2x4B3f9ldLZyeJmLBH3HeVGy38R
         sBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917402; x=1690509402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnvjt/gAeB7s5ArRb1iRUdzehhXE3naKGVtPVDLMicQ=;
        b=FQksV1+7cuecULQE8retOBZbLBnZTgjTULTYJjuvU9IszBesL0H0+qtVPvgNrI47kF
         gx9/O7i8oqEUHz+/NTLbZBPeZ/Bvtm4MHhw8DRxsUlx+aEK0Hsfr+mvrqbN3M0bSXDTE
         pmPhw9aLJgonjUwo8DVkIgQzS+tIP9idXYzoteKRy+o1+jym0/drhVGvcjTVp74bazN6
         hbeaVEsZoG/AR9bf61VkXI/sUp4EC3QIKg5YoJfm6p4605EOPFmqVYAieVrPImoRoE9t
         9ayxDkn7NbFzq9OcXDLDl8xaJ8usz8R07vJaGTNGWf/YGYHK5zacXV6iju0ojFBsPHHP
         +xlw==
X-Gm-Message-State: AC+VfDxRdN5pwSb+8ebhHgkKIWx4p7lR6LuQxC0dk0ISvzbxZD1SGZ/c
	enCH2aE1Z05hClpm32w3WHw=
X-Google-Smtp-Source: ACHHUZ78cnzX9BDqTo0MHYJSfppOTXt+zu9AxlG/4MtV9Rmj61/WPypownx0DfOZFWllfazUPutLrw==
X-Received: by 2002:a17:902:ea0b:b0:1b2:676d:1143 with SMTP id s11-20020a170902ea0b00b001b2676d1143mr14533404plg.15.1687917401890;
        Tue, 27 Jun 2023 18:56:41 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902ba8d00b001b69303db54sm6577289pls.91.2023.06.27.18.56.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:56:41 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 01/13] bpf: Rename few bpf_mem_alloc fields.
Date: Tue, 27 Jun 2023 18:56:22 -0700
Message-Id: <20230628015634.33193-2-alexei.starovoitov@gmail.com>
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

Rename:
-       struct rcu_head rcu;
-       struct llist_head free_by_rcu;
-       struct llist_head waiting_for_gp;
-       atomic_t call_rcu_in_progress;
+       struct llist_head free_by_rcu_ttrace;
+       struct llist_head waiting_for_gp_ttrace;
+       struct rcu_head rcu_ttrace;
+       atomic_t call_rcu_ttrace_in_progress;
...
-	static void do_call_rcu(struct bpf_mem_cache *c)
+	static void do_call_rcu_ttrace(struct bpf_mem_cache *c)

to better indicate intended use.

The 'tasks trace' is shortened to 'ttrace' to reduce verbosity.
No functional changes.

Later patches will add free_by_rcu/waiting_for_gp fields to be used with normal RCU.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 57 ++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 0668bcd7c926..cc5b8adb4c83 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -99,10 +99,11 @@ struct bpf_mem_cache {
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
 
-	struct rcu_head rcu;
-	struct llist_head free_by_rcu;
-	struct llist_head waiting_for_gp;
-	atomic_t call_rcu_in_progress;
+	/* list of objects to be freed after RCU tasks trace GP */
+	struct llist_head free_by_rcu_ttrace;
+	struct llist_head waiting_for_gp_ttrace;
+	struct rcu_head rcu_ttrace;
+	atomic_t call_rcu_ttrace_in_progress;
 };
 
 struct bpf_mem_caches {
@@ -165,18 +166,18 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	old_memcg = set_active_memcg(memcg);
 	for (i = 0; i < cnt; i++) {
 		/*
-		 * free_by_rcu is only manipulated by irq work refill_work().
+		 * free_by_rcu_ttrace is only manipulated by irq work refill_work().
 		 * IRQ works on the same CPU are called sequentially, so it is
 		 * safe to use __llist_del_first() here. If alloc_bulk() is
 		 * invoked by the initial prefill, there will be no running
 		 * refill_work(), so __llist_del_first() is fine as well.
 		 *
-		 * In most cases, objects on free_by_rcu are from the same CPU.
+		 * In most cases, objects on free_by_rcu_ttrace are from the same CPU.
 		 * If some objects come from other CPUs, it doesn't incur any
 		 * harm because NUMA_NO_NODE means the preference for current
 		 * numa node and it is not a guarantee.
 		 */
-		obj = __llist_del_first(&c->free_by_rcu);
+		obj = __llist_del_first(&c->free_by_rcu_ttrace);
 		if (!obj) {
 			/* Allocate, but don't deplete atomic reserves that typical
 			 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
@@ -232,10 +233,10 @@ static void free_all(struct llist_node *llnode, bool percpu)
 
 static void __free_rcu(struct rcu_head *head)
 {
-	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
 
-	free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
-	atomic_set(&c->call_rcu_in_progress, 0);
+	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
+	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
 }
 
 static void __free_rcu_tasks_trace(struct rcu_head *head)
@@ -254,32 +255,32 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 	struct llist_node *llnode = obj;
 
 	/* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
-	 * Nothing races to add to free_by_rcu list.
+	 * Nothing races to add to free_by_rcu_ttrace list.
 	 */
-	__llist_add(llnode, &c->free_by_rcu);
+	__llist_add(llnode, &c->free_by_rcu_ttrace);
 }
 
-static void do_call_rcu(struct bpf_mem_cache *c)
+static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode, *t;
 
-	if (atomic_xchg(&c->call_rcu_in_progress, 1))
+	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1))
 		return;
 
-	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
-		/* There is no concurrent __llist_add(waiting_for_gp) access.
+	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
+	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu_ttrace))
+		/* There is no concurrent __llist_add(waiting_for_gp_ttrace) access.
 		 * It doesn't race with llist_del_all either.
-		 * But there could be two concurrent llist_del_all(waiting_for_gp):
+		 * But there could be two concurrent llist_del_all(waiting_for_gp_ttrace):
 		 * from __free_rcu() and from drain_mem_cache().
 		 */
-		__llist_add(llnode, &c->waiting_for_gp);
+		__llist_add(llnode, &c->waiting_for_gp_ttrace);
 	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
 	 * If RCU Tasks Trace grace period implies RCU grace period, free
 	 * these elements directly, else use call_rcu() to wait for normal
 	 * progs to finish and finally do free_one() on each element.
 	 */
-	call_rcu_tasks_trace(&c->rcu, __free_rcu_tasks_trace);
+	call_rcu_tasks_trace(&c->rcu_ttrace, __free_rcu_tasks_trace);
 }
 
 static void free_bulk(struct bpf_mem_cache *c)
@@ -307,7 +308,7 @@ static void free_bulk(struct bpf_mem_cache *c)
 	/* and drain free_llist_extra */
 	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
 		enque_to_free(c, llnode);
-	do_call_rcu(c);
+	do_call_rcu_ttrace(c);
 }
 
 static void bpf_mem_refill(struct irq_work *work)
@@ -441,13 +442,13 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 
 	/* No progs are using this bpf_mem_cache, but htab_map_free() called
 	 * bpf_mem_cache_free() for all remaining elements and they can be in
-	 * free_by_rcu or in waiting_for_gp lists, so drain those lists now.
+	 * free_by_rcu_ttrace or in waiting_for_gp_ttrace lists, so drain those lists now.
 	 *
-	 * Except for waiting_for_gp list, there are no concurrent operations
+	 * Except for waiting_for_gp_ttrace list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	free_all(__llist_del_all(&c->free_by_rcu), percpu);
-	free_all(llist_del_all(&c->waiting_for_gp), percpu);
+	free_all(__llist_del_all(&c->free_by_rcu_ttrace), percpu);
+	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
 }
@@ -462,7 +463,7 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 
 static void free_mem_alloc(struct bpf_mem_alloc *ma)
 {
-	/* waiting_for_gp lists was drained, but __free_rcu might
+	/* waiting_for_gp_ttrace lists was drained, but __free_rcu might
 	 * still execute. Wait for it now before we freeing percpu caches.
 	 *
 	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
@@ -535,7 +536,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			 */
 			irq_work_sync(&c->refill_work);
 			drain_mem_cache(c);
-			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
+			rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
 		}
 		/* objcg is the same across cpus */
 		if (c->objcg)
@@ -550,7 +551,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				c = &cc->cache[i];
 				irq_work_sync(&c->refill_work);
 				drain_mem_cache(c);
-				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
+				rcu_in_progress += atomic_read(&c->call_rcu_ttrace_in_progress);
 			}
 		}
 		if (c->objcg)
-- 
2.34.1


