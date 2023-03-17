Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D981D6BF471
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjCQViY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjCQVhV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:37:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB5B66D01;
        Fri, 17 Mar 2023 14:36:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so10550868pjv.5;
        Fri, 17 Mar 2023 14:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eoGGlzywStMiYbVMcBjMDTNFvxz4K+Jg2JHrfcCjW0=;
        b=UjNKU/f2J8N3ifxLlrYmdFdbzq7XZBHYfs9mFRkSXDvsoRakA7tI58rig1WQXFUYdq
         L0jHLrneNSqmryneQwVQF6ipWGkNr7rMc/0YAb0l2RMBc8zFiYtvtQRg4fyzK2lJEs1n
         9/lVggDZVYMDgWjBdNvpzBRXke2jcJk60HVjoULdbTy1bCEnHLidFnDWYsISVvHF9y5A
         9Au466uluvLuqEXTNIQpHvgO7bfpWqeLWyA3WICW4ez3u//f86kGvufh5Yf87oG9KX5N
         DdOzHJFL+kwnLwoCVgzCziCyfAURdCQBG+jH8wOBBRQsGR9vF0y85YFZN69Lc+xHqbbz
         oDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/eoGGlzywStMiYbVMcBjMDTNFvxz4K+Jg2JHrfcCjW0=;
        b=h8gidpAcbNkiGlH5K4tN9UNX8DNIoLf/TwxOWyL5rMoYLnWwDIBkpUPor+4PQ86fcI
         9NOdjzsOJV2e7pPTS791rY0Px3a0Rn/48GRP8WJl7DT8MRTwq/w9+lzwCxQgx7Ef6oX9
         6wE3AhRe111jL6HP0cJUdzb8o20SiDaGMLfLbXlFvPuEpa5KkuXSyNM+AGqhIaIjqM+G
         kUgO9i0n5aBrKwkbW1hdV/gvrVr4i2li9g2CMalNdPNENErhQVhy6TiOVYdd/COPZqSa
         c+JPWu8myxT/pHO4OuqYuZMaJ84oCcnaAIsZIt8RgIo4p0NF42F4XyrxVOebN5QWDMNI
         N5qA==
X-Gm-Message-State: AO0yUKXU0f3g5eNe+vvO5PFcHpPHA4xaygJ3cd8tKSOgMlx1PM6gVg/4
        kh/WDxpNTrYG10BjZHPkVsU=
X-Google-Smtp-Source: AK7set+m7GRsaoPzkfAfbjlauBjRfolG+naN1e5cxMP/j+XlkiBIf5dODzQCsCUqQMFbmIkC/jX9TA==
X-Received: by 2002:a17:902:f685:b0:1a0:67fb:445c with SMTP id l5-20020a170902f68500b001a067fb445cmr4637107plg.28.1679088868688;
        Fri, 17 Mar 2023 14:34:28 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b0019b089bc8d7sm1997428pll.78.2023.03.17.14.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:34:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 25/32] sched_ext: Implement SCX_KICK_WAIT
Date:   Fri, 17 Mar 2023 11:33:26 -1000
Message-Id: <20230317213333.2174969-26-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: David Vernet <dvernet@meta.com>

If set when calling scx_bpf_kick_cpu(), the invoking CPU will busy wait for
the kicked cpu to enter the scheduler. This will be used to improve the
exclusion guarantees in scx_example_pair.

Signed-off-by: David Vernet <dvernet@meta.com>
Reviewed-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  |  4 +++-
 kernel/sched/ext.c   | 33 ++++++++++++++++++++++++++++++++-
 kernel/sched/ext.h   | 20 ++++++++++++++++++++
 kernel/sched/sched.h |  2 ++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0780414f3c15..ff51977968fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6019,8 +6019,10 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	for_each_active_class(class) {
 		p = class->pick_next_task(rq);
-		if (p)
+		if (p) {
+			scx_notify_pick_next_task(rq, p, class);
 			return p;
+		}
 	}
 
 	BUG(); /* The idle class should always have a runnable task. */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 736f764d0f62..fbdbe4603853 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -126,6 +126,9 @@ static struct {
 static bool __cacheline_aligned_in_smp scx_has_idle_cpus;
 #endif	/* CONFIG_SMP */
 
+/* for %SCX_KICK_WAIT */
+static u64 __percpu *scx_kick_cpus_pnt_seqs;
+
 /*
  * Direct dispatch marker.
  *
@@ -3215,6 +3218,7 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
 static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 {
 	struct rq *this_rq = this_rq();
+	u64 *pseqs = this_cpu_ptr(scx_kick_cpus_pnt_seqs);
 	int this_cpu = cpu_of(this_rq);
 	int cpu;
 
@@ -3228,14 +3232,32 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 			if (cpumask_test_cpu(cpu, this_rq->scx.cpus_to_preempt) &&
 			    rq->curr->sched_class == &ext_sched_class)
 				rq->curr->scx.slice = 0;
+			pseqs[cpu] = rq->scx.pnt_seq;
 			resched_curr(rq);
+		} else {
+			cpumask_clear_cpu(cpu, this_rq->scx.cpus_to_wait);
 		}
 
 		raw_spin_rq_unlock_irqrestore(rq, flags);
 	}
 
+	for_each_cpu_andnot(cpu, this_rq->scx.cpus_to_wait,
+			    cpumask_of(this_cpu)) {
+		/*
+		 * Pairs with smp_store_release() issued by this CPU in
+		 * scx_notify_pick_next_task() on the resched path.
+		 *
+		 * We busy-wait here to guarantee that no other task can be
+		 * scheduled on our core before the target CPU has entered the
+		 * resched path.
+		 */
+		while (smp_load_acquire(&cpu_rq(cpu)->scx.pnt_seq) == pseqs[cpu])
+			cpu_relax();
+	}
+
 	cpumask_clear(this_rq->scx.cpus_to_kick);
 	cpumask_clear(this_rq->scx.cpus_to_preempt);
+	cpumask_clear(this_rq->scx.cpus_to_wait);
 }
 
 void __init init_sched_ext_class(void)
@@ -3249,7 +3271,7 @@ void __init init_sched_ext_class(void)
 	 * through the generated vmlinux.h.
 	 */
 	WRITE_ONCE(v, SCX_WAKE_EXEC | SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP |
-		   SCX_TG_ONLINE);
+		   SCX_TG_ONLINE | SCX_KICK_PREEMPT);
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 	init_dsq(&scx_dsq_global, SCX_DSQ_GLOBAL);
@@ -3257,6 +3279,12 @@ void __init init_sched_ext_class(void)
 	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
 #endif
+	scx_kick_cpus_pnt_seqs =
+		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) *
+			       num_possible_cpus(),
+			       __alignof__(scx_kick_cpus_pnt_seqs[0]));
+	BUG_ON(!scx_kick_cpus_pnt_seqs);
+
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
 
@@ -3265,6 +3293,7 @@ void __init init_sched_ext_class(void)
 
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_preempt, GFP_KERNEL));
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_wait, GFP_KERNEL));
 		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 	}
 
@@ -3533,6 +3562,8 @@ void scx_bpf_kick_cpu(s32 cpu, u64 flags)
 	cpumask_set_cpu(cpu, rq->scx.cpus_to_kick);
 	if (flags & SCX_KICK_PREEMPT)
 		cpumask_set_cpu(cpu, rq->scx.cpus_to_preempt);
+	if (flags & SCX_KICK_WAIT)
+		cpumask_set_cpu(cpu, rq->scx.cpus_to_wait);
 
 	irq_work_queue(&rq->scx.kick_cpus_irq_work);
 	preempt_enable();
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 0c5a109e7e6d..fc27b28acfde 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -66,6 +66,7 @@ enum scx_tg_flags {
 
 enum scx_kick_flags {
 	SCX_KICK_PREEMPT	= 1LLU << 0,	/* force scheduling on the CPU */
+	SCX_KICK_WAIT		= 1LLU << 1,	/* wait for the CPU to be rescheduled */
 };
 
 #ifdef CONFIG_SCHED_CLASS_EXT
@@ -95,6 +96,22 @@ __printf(2, 3) void scx_ops_error_type(enum scx_exit_type type,
 #define scx_ops_error(fmt, args...)						\
 	scx_ops_error_type(SCX_EXIT_ERROR, fmt, ##args)
 
+static inline void scx_notify_pick_next_task(struct rq *rq,
+					     const struct task_struct *p,
+					     const struct sched_class *active)
+{
+#ifdef CONFIG_SMP
+	if (!scx_enabled())
+		return;
+	/*
+	 * Pairs with the smp_load_acquire() issued by a CPU in
+	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
+	 * resched.
+	 */
+	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+#endif
+}
+
 static inline void scx_notify_sched_tick(void)
 {
 	unsigned long last_check;
@@ -149,6 +166,9 @@ static inline int scx_check_setscheduler(struct task_struct *p,
 					 int policy) { return 0; }
 static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
 static inline void init_sched_ext_class(void) {}
+static inline void scx_notify_pick_next_task(struct rq *rq,
+					     const struct task_struct *p,
+					     const struct sched_class *active) {}
 static inline void scx_notify_sched_tick(void) {}
 
 #define for_each_active_class		for_each_class
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3571cfda62a3..4b7f48239248 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -710,6 +710,8 @@ struct scx_rq {
 	u32			flags;
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_preempt;
+	cpumask_var_t		cpus_to_wait;
+	u64			pnt_seq;
 	struct irq_work		kick_cpus_irq_work;
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
-- 
2.39.2

