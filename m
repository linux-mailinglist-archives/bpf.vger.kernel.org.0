Return-Path: <bpf+bounces-4151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957C574944B
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1CF2811B5
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B93110E;
	Thu,  6 Jul 2023 03:34:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AB10F8;
	Thu,  6 Jul 2023 03:34:57 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B31BC8;
	Wed,  5 Jul 2023 20:34:56 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-392116ae103so331073b6e.0;
        Wed, 05 Jul 2023 20:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614495; x=1691206495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hje/5uEwvmDjaVx273wRGE5gz7pxgdInq/+uIjr8Qv0=;
        b=ryyu70lnoK5mYFDNZw2EWe8ZIoTdVdhoDqJLay/AY6Yp1/IaxHKKmtmRqwTjHUUSML
         SsVVzfkYMFFQljA6eLtq9QWRK8vQtDa6VEH2cHf4+kIJynrq+LRILSpMsxN5O92rot4p
         FNlUiPIKHGePXzYv8Ua0QKOj+VbnMBdjmpTvL//4gOCcJs9Aj+GeCkXYD2OsAOSfzjXN
         e39itH3e3dqluT5lCKCui5sYe/9RktFjojrSWrLPby2G9n+9hmIFJ4n88L8qBhzg2M2x
         Jr9AsgBGmtEQ6yIxZWm1jFhQSql/HUPglxTa4EaQimr9IdEjw+Ib7QnNY8r6UQch8Vsr
         EqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614495; x=1691206495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hje/5uEwvmDjaVx273wRGE5gz7pxgdInq/+uIjr8Qv0=;
        b=JDt6fUSgNeUzFpkjRnzRBACJFvEHTRySlZUMdEElS9ecG0F2ZInxuDH1Syd3dHGfHB
         Nc1WPLckeqpsOrSL17NEIFk+Lc4+VBFPcUZ+s9HtXuIEnIeMUtQ/81FtJ6izxpccqsyF
         HLtfmCgTeuzP4uuYC/Fi2zCgSTor4C2sYlPowtvEkY/6gwyMRQOKWy5B/sI04C0hf24l
         jo+UjHD0JZTlt+R1ghsaORFBwQTNtML21kILQIqDiqyBejzvnDr7Y5F0hN1YAiCiGdPp
         p6RtTRCMA4A+9seXhXYx17eIdubalKHZmomqN+T+5owlE03HXywIBf8lDtWALgNBIZXR
         9CJg==
X-Gm-Message-State: ABy/qLZoPmHFivSrzERSkmCT5cedLHTnEB35HPQM+q+ay1uFXm0qFWkr
	1f9Ckklfo6Rz1hZG+51XeWw=
X-Google-Smtp-Source: APBJJlHlwYQwHnza+F4L21TGixzAGXQSLKFppF6WlNVcHYMwg7p/EtMZHOc7LA6ghI/RWonAYhRqZg==
X-Received: by 2002:a05:6808:1993:b0:3a1:d504:f245 with SMTP id bj19-20020a056808199300b003a1d504f245mr556761oib.37.1688614495351;
        Wed, 05 Jul 2023 20:34:55 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b001b8622c1ad2sm219596plr.130.2023.07.05.20.34.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:34:54 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 01/14] bpf: Rename few bpf_mem_alloc fields.
Date: Wed,  5 Jul 2023 20:34:34 -0700
Message-Id: <20230706033447.54696-2-alexei.starovoitov@gmail.com>
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
Acked-by: Hou Tao <houtao1@huawei.com>
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


