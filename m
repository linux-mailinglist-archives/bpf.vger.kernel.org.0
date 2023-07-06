Return-Path: <bpf+bounces-4158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4674945E
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747D51C20C92
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4D63AE;
	Thu,  6 Jul 2023 03:35:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4DBEA2;
	Thu,  6 Jul 2023 03:35:27 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98003198E;
	Wed,  5 Jul 2023 20:35:23 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76714caf466so28317285a.1;
        Wed, 05 Jul 2023 20:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614522; x=1691206522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjnD9spM/4mEE+I32gxaY1tARlurZ9ZzYpHOfvWPVew=;
        b=UpfEHrRZEgvxQjePJ0kHhss9OO6eWWjFWVnn9ROJJubIMlyNbJmNMykssfatwXupUW
         eFqi0q1C+BRH7noU8ldMd/jh1V4xNPjMKDj0tZ6G4Qm5PwqJOJ4BbMiTRJXjCGipS8cn
         SKH/rDXpXUIt7b6jhkml8fra5Ja9elr+gqDB5+WdvgDdOzHlomnyc08KqqH98lg0pFcj
         XVGPraJw5DTEX8KMzPbmsQVokrgnSqn2EO7MpJJLwUUIDUNCb8nhDJsPcwoMkzHUsnPu
         /D77QGp/em2lyQddRjpc+6ZK+7T21A6NYc68g0kYL5kgcluKq2s4foARqm7hBF5+tMgk
         1wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614522; x=1691206522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjnD9spM/4mEE+I32gxaY1tARlurZ9ZzYpHOfvWPVew=;
        b=eg2qObn7eSwMhRHJqduY1v1IZ/NDcUVAUGw8YW1FJdIehGL8+R0XrIPYsPeWIcyUtq
         f8/h9ItkdwL2vL4E5FfsFwspb9Fo/RRoilHz3a1PUTHUj5CGwBUiGZodWo9ySDk6fnGl
         Sx7Dp1EHD2o2JmnhnEG/U1gmjPeeUXSdbKFITG6u6hWnosDLmH8FuVQ9+K+LcKDsIRNJ
         fvhdIbuTJEfsiAP0xIt0L6u27T0KB4SyOSae4BbRPdYRejNdAb9JLlXsCP4j03JKku5k
         kUO+FcKb9ArVZ0TebUU03LS6X06fIyKf6EexXEgvgomSuaISDRqnBvii03eEkC7UXAjY
         DTMQ==
X-Gm-Message-State: ABy/qLZX1ywdpoyIanz7uFdLpREndm0YF3fWho1Rwxb1JBHmfGV1/9iN
	HMATYXkRmF0IxPS8PaXFAv9dsc3ADX4=
X-Google-Smtp-Source: APBJJlE44dh48hsy5XAd2kkPV5EGNMwngkhqwVIp32TNLNudGSuKzb89VHI5V0wD0aG0ps5w8bZhnw==
X-Received: by 2002:a05:620a:4248:b0:765:8204:dd64 with SMTP id w8-20020a05620a424800b007658204dd64mr730677qko.7.1688614522579;
        Wed, 05 Jul 2023 20:35:22 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id n20-20020aa79054000000b00682b299b6besm243673pfo.70.2023.07.05.20.35.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:35:22 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 08/14] bpf: Add a hint to allocated objects.
Date: Wed,  5 Jul 2023 20:34:41 -0700
Message-Id: <20230706033447.54696-9-alexei.starovoitov@gmail.com>
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

To address OOM issue when one cpu is allocating and another cpu is freeing add
a target bpf_mem_cache hint to allocated objects and when local cpu free_llist
overflows free to that bpf_mem_cache. The hint addresses the OOM while
maintaining the same performance for common case when alloc/free are done on the
same cpu.

Note that do_call_rcu_ttrace() now has to check 'draining' flag in one more case,
since do_call_rcu_ttrace() is called not only for current cpu.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 50 +++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 2615f296f052..9986c6b7df4d 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -99,6 +99,7 @@ struct bpf_mem_cache {
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
 	bool draining;
+	struct bpf_mem_cache *tgt;
 
 	/* list of objects to be freed after RCU tasks trace GP */
 	struct llist_head free_by_rcu_ttrace;
@@ -199,18 +200,11 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 
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
@@ -284,18 +278,23 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 	/* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
 	 * Nothing races to add to free_by_rcu_ttrace list.
 	 */
-	__llist_add(llnode, &c->free_by_rcu_ttrace);
+	llist_add(llnode, &c->free_by_rcu_ttrace);
 }
 
 static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode, *t;
 
-	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1))
+	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
+		if (unlikely(READ_ONCE(c->draining))) {
+			llnode = llist_del_all(&c->free_by_rcu_ttrace);
+			free_all(llnode, !!c->percpu_size);
+		}
 		return;
+	}
 
 	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu_ttrace))
+	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
 		/* There is no concurrent __llist_add(waiting_for_gp_ttrace) access.
 		 * It doesn't race with llist_del_all either.
 		 * But there could be two concurrent llist_del_all(waiting_for_gp_ttrace):
@@ -318,10 +317,13 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 
 static void free_bulk(struct bpf_mem_cache *c)
 {
+	struct bpf_mem_cache *tgt = c->tgt;
 	struct llist_node *llnode, *t;
 	unsigned long flags;
 	int cnt;
 
+	WARN_ON_ONCE(tgt->unit_size != c->unit_size);
+
 	do {
 		inc_active(c, &flags);
 		llnode = __llist_del_first(&c->free_llist);
@@ -331,13 +333,13 @@ static void free_bulk(struct bpf_mem_cache *c)
 			cnt = 0;
 		dec_active(c, flags);
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
@@ -436,6 +438,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->unit_size = unit_size;
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
+			c->tgt = c;
 			prefill_mem_cache(c, cpu);
 		}
 		ma->cache = pc;
@@ -458,6 +461,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c = &cc->cache[i];
 			c->unit_size = sizes[i];
 			c->objcg = objcg;
+			c->tgt = c;
 			prefill_mem_cache(c, cpu);
 		}
 	}
@@ -476,7 +480,7 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * Except for waiting_for_gp_ttrace list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	free_all(__llist_del_all(&c->free_by_rcu_ttrace), percpu);
+	free_all(llist_del_all(&c->free_by_rcu_ttrace), percpu);
 	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
@@ -601,8 +605,10 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
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
@@ -626,6 +632,12 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 
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


