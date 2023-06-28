Return-Path: <bpf+bounces-3626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3909740802
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 04:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEAD2811A9
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 02:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18666FA5;
	Wed, 28 Jun 2023 01:57:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8ED1376;
	Wed, 28 Jun 2023 01:57:12 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036FB18E;
	Tue, 27 Jun 2023 18:57:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55af0a816e4so1551457a12.1;
        Tue, 27 Jun 2023 18:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917430; x=1690509430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cMb2Xsn1WRkEk4McteyxXZFaj0EbXk3G7F10zvseQU=;
        b=kqTFrdFQVhHV8JeD1nLo0WLCJbyXgm0rl724qhDnVFTvEgYh9yIWvN1kEbaF8eSB2a
         N1Y9q0uOQAjQ3wAEyMqKIV5KOzi9biG/vNoSdUGG1UTlydDCjzwoSZqhdK+kViz43Msz
         hNCTa+5v2/fSrHMWORFmBtqvLWlUldTXazk+czdgclP+W05UbZVqiz1s7rr5o6ICnC/a
         hQiKpf2ytDrv8bRz7bjMoiz8PZh5ZASPbLeRKw1D+0KwcUJSaJssxxNQwz1vQfy/MSwL
         +AkzD92KL/E/YUSbt7fZNVxPcIbU1UJ8a/sm6zgTTI+wm27uZMMAgRcRMThDGCbwh5iP
         0lIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917430; x=1690509430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cMb2Xsn1WRkEk4McteyxXZFaj0EbXk3G7F10zvseQU=;
        b=CMmjtrTVKITsQQfTE1ZMjJ8m/XVlsPXrHySWsvK/9oH5Tg/BgFytQUuv6na9JXdHnY
         3/5XCI7jtPRs3kpzIGLW1IpZ3q6u3Es86RGoT1qI+xy3VEqKIkqRYAJIjiHts5pbsa9t
         G3SiB5wNRbIAm+V30IW1FTfGLjGGzSlAoQtnL8+BbpkjfZ6QAJ1dpCQMdW/tIZgi1gcm
         2KF84rlfmTrB89ZYAHk8TPfqRxPong3E1R9CPXWlcm4jnEn30SPuaBc4tSH1tG7KCmBE
         eu+lhT9lutaZvQbgQULh3m85zx975gBOLbzaLbdcknxKJgtL87M8+qgg/L/TenZ5VQ/E
         VAEg==
X-Gm-Message-State: AC+VfDyD0ieiKHbNkugVBirx3CBXwL/GmsU4c3yIWdEAEPYxmkb2+BjE
	Kb4HHU0NYrtpxStIZFlfaxQ=
X-Google-Smtp-Source: ACHHUZ42d0P+Q7Ic2IwB3LqGcmZ/XjOMgVjQs4fG+Ju4s+eGOiY2IIn20N8FROpqepjKrzJsYlU5sQ==
X-Received: by 2002:a05:6a21:9981:b0:125:b0ec:211f with SMTP id ve1-20020a056a21998100b00125b0ec211fmr11103129pzb.7.1687917430317;
        Tue, 27 Jun 2023 18:57:10 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id iw19-20020a170903045300b001b0603829a0sm720450plb.199.2023.06.27.18.57.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:57:09 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 08/13] bpf: Add a hint to allocated objects.
Date: Tue, 27 Jun 2023 18:56:29 -0700
Message-Id: <20230628015634.33193-9-alexei.starovoitov@gmail.com>
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
index 2615f296f052..93242c4b85e0 100644
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
@@ -284,7 +278,7 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 	/* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
 	 * Nothing races to add to free_by_rcu_ttrace list.
 	 */
-	__llist_add(llnode, &c->free_by_rcu_ttrace);
+	llist_add(llnode, &c->free_by_rcu_ttrace);
 }
 
 static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
@@ -295,7 +289,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 		return;
 
 	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu_ttrace))
+	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
 		/* There is no concurrent __llist_add(waiting_for_gp_ttrace) access.
 		 * It doesn't race with llist_del_all either.
 		 * But there could be two concurrent llist_del_all(waiting_for_gp_ttrace):
@@ -312,16 +306,22 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
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
 		inc_active(c, &flags);
 		llnode = __llist_del_first(&c->free_llist);
@@ -331,13 +331,13 @@ static void free_bulk(struct bpf_mem_cache *c)
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
@@ -436,6 +436,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->unit_size = unit_size;
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
+			c->tgt = c;
 			prefill_mem_cache(c, cpu);
 		}
 		ma->cache = pc;
@@ -458,6 +459,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c = &cc->cache[i];
 			c->unit_size = sizes[i];
 			c->objcg = objcg;
+			c->tgt = c;
 			prefill_mem_cache(c, cpu);
 		}
 	}
@@ -476,7 +478,7 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * Except for waiting_for_gp_ttrace list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	free_all(__llist_del_all(&c->free_by_rcu_ttrace), percpu);
+	free_all(llist_del_all(&c->free_by_rcu_ttrace), percpu);
 	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
@@ -601,8 +603,10 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
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
@@ -626,6 +630,12 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 
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


