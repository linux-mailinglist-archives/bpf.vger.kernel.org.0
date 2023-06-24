Return-Path: <bpf+bounces-3349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4A073C67D
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 05:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF131C2143F
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BADE3FDF;
	Sat, 24 Jun 2023 03:14:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4847F;
	Sat, 24 Jun 2023 03:14:10 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65270E47;
	Fri, 23 Jun 2023 20:14:09 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b711c3ad1fso1189667a34.0;
        Fri, 23 Jun 2023 20:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576448; x=1690168448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rMpHCpyAwYur1+foqQGqDjqSKhTON8KzkS42uHp7Vs=;
        b=CUcGfrhmhl9NtZX7D/yOa94cfvd4Zw53ZvXOnTyfAhAeOB57jlu2hzsPIa+3tB7qGI
         F99RQiGMR0oEQpNRtdRaxh/azMNpSXFv5F0E9mHfrY/Dj3auFwpjlIQHThGlUDwFNhlJ
         WK7fYf65apVL6WhXq7DP7wT1aTfd5dof5urV5MQurCQFuOXoC2BGkQC465OvJbpEbTmE
         MZMKDnvLaJBoGqf2wgAXXcfE6azRuQBKyPRfOz7SnLmkq0VKLvfqpHUUxDMiVbH/z2xL
         fCo/EiyGiQM2Bval/7d1fbXEQIl6AH0QiZ1am+e1b3P45srsDN7q1FBh7vEiEIRBWm3e
         l+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576448; x=1690168448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rMpHCpyAwYur1+foqQGqDjqSKhTON8KzkS42uHp7Vs=;
        b=BBAlnWSONq0SS/aZHFVYK0OhhyE74VbTTnVSacSJnmx6RWPWykrJYT2XVNwI9jPHcp
         x9WxqtpFP2tdNQmvClFtJ/f9l95jThSLS5EbVmvR/sjD1jSaQH2SBA1L60eBwUGBpnJH
         9XqJ+pk6xRn/SKQpgI7rZ1QW+HstQtldsi3D1sRqvUAZUBDUrEc9zXZdZJ0dZRCGu6PK
         644D01QBClxCBx4z1bMoO89eBdvSZZXkR+Q8k6FM04+9Ls6rG9/nsYX0UvMvixQu2UCZ
         kn7Vokri4OQ+s9Fp4rWTm+GOIeY7M+dbR7/TX2fg6/22abBXufCvN28HwhOkhCli0zep
         68kA==
X-Gm-Message-State: AC+VfDxRxc2+vEoIfyx61vVVl6cnb6LCw/Lw+03LXwLicz0RZSWSoTK1
	SLa8Qul0KQeGZZGHL2HG4GH0EM3UVsU=
X-Google-Smtp-Source: ACHHUZ7HSDtqcXLFJV7RPojw+TX3/T2Q3dBKp2lXq+wxtsx2dl1JPFqiBaHy6zo2cOGLThId3/SQNw==
X-Received: by 2002:a05:6358:5118:b0:132:d796:5c6f with SMTP id 24-20020a056358511800b00132d7965c6fmr4648198rwi.20.1687576448468;
        Fri, 23 Jun 2023 20:14:08 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001b3d8ac1b6bsm232231plr.212.2023.06.23.20.14.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:14:08 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 08/13] bpf: Add a hint to allocated objects.
Date: Fri, 23 Jun 2023 20:13:28 -0700
Message-Id: <20230624031333.96597-9-alexei.starovoitov@gmail.com>
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
index d68a854f45ee..692a9a30c1dc 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -99,6 +99,7 @@ struct bpf_mem_cache {
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
 	bool draining;
+	struct bpf_mem_cache *tgt;
 
 	/* list of objects to be freed after RCU tasks trace GP */
 	struct llist_head free_by_rcu_ttrace;
@@ -190,18 +191,11 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 
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
@@ -278,7 +272,7 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 	/* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
 	 * Nothing races to add to free_by_rcu_ttrace list.
 	 */
-	if (__llist_add(llnode, &c->free_by_rcu_ttrace))
+	if (llist_add(llnode, &c->free_by_rcu_ttrace))
 		c->free_by_rcu_ttrace_tail = llnode;
 }
 
@@ -290,7 +284,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 		return;
 
 	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
-	llnode = __llist_del_all(&c->free_by_rcu_ttrace);
+	llnode = llist_del_all(&c->free_by_rcu_ttrace);
 	if (llnode)
 		/* There is no concurrent __llist_add(waiting_for_gp_ttrace) access.
 		 * It doesn't race with llist_del_all either.
@@ -303,16 +297,22 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
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
@@ -326,13 +326,13 @@ static void free_bulk(struct bpf_mem_cache *c)
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
@@ -431,6 +431,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->unit_size = unit_size;
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
+			c->tgt = c;
 			prefill_mem_cache(c, cpu);
 		}
 		ma->cache = pc;
@@ -453,6 +454,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c = &cc->cache[i];
 			c->unit_size = sizes[i];
 			c->objcg = objcg;
+			c->tgt = c;
 			prefill_mem_cache(c, cpu);
 		}
 	}
@@ -471,7 +473,7 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * Except for waiting_for_gp_ttrace list, there are no concurrent operations
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
-	free_all(__llist_del_all(&c->free_by_rcu_ttrace), percpu);
+	free_all(llist_del_all(&c->free_by_rcu_ttrace), percpu);
 	free_all(llist_del_all(&c->waiting_for_gp_ttrace), percpu);
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
@@ -605,8 +607,10 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
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
@@ -630,6 +634,12 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 
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


