Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5294667F305
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjA1AT2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjA1ASS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:18:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089FE7DBD4;
        Fri, 27 Jan 2023 16:17:41 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lp10so6129610pjb.4;
        Fri, 27 Jan 2023 16:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMQOIFEBcFwDp2btYCdWarnv+32LvEIs5gf0cXKu4U4=;
        b=k0feCFL4O4unl6y3z3K+xvN790aOc1J4WbsMP8/rFMHX6rXD7lYkSitIXg2IjM0IbM
         oDWOELrtkcuqYs8suWxc+fd5Hv9SlcT0YunNxepPEyycsJYERseFMOqa4YopxfV/whNj
         PpRrCb/Sfd1AEzzCxCANK6M8fOmrm4v4PfIKJ5ZBPEjuSBRxSCNWB/Tle/DLe/uqhT8z
         YSd1tYjbBYWU+te9jMwqv9e+0T7RGBlgMEgtGGoNcY67Cjl72mSduVwFve/8zqXSEpPO
         kjIqJ9QqKFkrslsqL3YstaqjOtjI6Gme7Ok5vQ8sKP6olrAik3a01FrqOCcVQVdvZoYO
         YHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rMQOIFEBcFwDp2btYCdWarnv+32LvEIs5gf0cXKu4U4=;
        b=iJKkGJoUvNXuQqJPLuBOtm2iHIHxz4VtgMiP45gWTBUxrFw4b6h2PdZ9NpvL7n5ebt
         JA7oRkVEiQukbKDuup3mJtmn6Y3uPApkXYadtbANFcWYn4ETehuiK6njifbvZuORdlUO
         BveTDOUu9aI1MtEkTDbUBfDRaZxeyJ6fe5olwI18pMpSQ6p7dinhkU6mORlPOksfeMrT
         bsSeZI2xK3/aobdwHNCD44ECnJlWbhxLyQQilYBV5PaVHXm1LoQmSIoWvoA0lN5D26DG
         5dTpcA3FgFtxnEgcX1hPDzOgv0kUuci2oXuFtHowZ3dZpimvNjYuqj925L+AMtYIO3c0
         ZgeQ==
X-Gm-Message-State: AO0yUKX5NGz2V4S7bDTDb7McyDqpvEF8euuLqgbx07+6WX9ZGHDFmOoe
        SIK7y6mRpXpxTxSBhhDgLPE=
X-Google-Smtp-Source: AK7set+zyY1sVSAjfb6ZLW0s6pCeAipZeTMNNUeuZ5MUXvW8tYPVle6S6mnqNN4saJjMDsZouZl9Cg==
X-Received: by 2002:a05:6a20:959b:b0:b8:7e6d:5b6a with SMTP id iu27-20020a056a20959b00b000b87e6d5b6amr8447222pzb.49.1674865056906;
        Fri, 27 Jan 2023 16:17:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id jm21-20020a17090304d500b00196519d8647sm2169486plb.4.2023.01.27.16.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:36 -0800 (PST)
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
Subject: [PATCH 24/30] sched_ext: Implement SCX_KICK_WAIT
Date:   Fri, 27 Jan 2023 14:16:33 -1000
Message-Id: <20230128001639.3510083-25-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index a2a241bc24e7..47334e428031 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5952,8 +5952,10 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
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
index 31e48cff9be6..d1de6a44c4f5 100644
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
@@ -3093,6 +3096,7 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
 static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 {
 	struct rq *this_rq = this_rq();
+	u64 *pseqs = this_cpu_ptr(scx_kick_cpus_pnt_seqs);
 	int this_cpu = cpu_of(this_rq);
 	int cpu;
 
@@ -3106,14 +3110,32 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
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
@@ -3127,7 +3149,7 @@ void __init init_sched_ext_class(void)
 	 * through the generated vmlinux.h.
 	 */
 	WRITE_ONCE(v, SCX_WAKE_EXEC | SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP |
-		   SCX_TG_ONLINE);
+		   SCX_TG_ONLINE | SCX_KICK_PREEMPT);
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 	init_dsq(&scx_dsq_global, SCX_DSQ_GLOBAL);
@@ -3135,6 +3157,12 @@ void __init init_sched_ext_class(void)
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
 
@@ -3143,6 +3171,7 @@ void __init init_sched_ext_class(void)
 
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_preempt, GFP_KERNEL));
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_wait, GFP_KERNEL));
 		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 	}
 
@@ -3397,6 +3426,8 @@ void scx_bpf_kick_cpu(s32 cpu, u64 flags)
 	cpumask_set_cpu(cpu, rq->scx.cpus_to_kick);
 	if (flags & SCX_KICK_PREEMPT)
 		cpumask_set_cpu(cpu, rq->scx.cpus_to_preempt);
+	if (flags & SCX_KICK_WAIT)
+		cpumask_set_cpu(cpu, rq->scx.cpus_to_wait);
 
 	irq_work_queue(&rq->scx.kick_cpus_irq_work);
 	preempt_enable();
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 9a60b81d787e..39eb1b25ec99 100644
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
index abb8ec22b6ef..d31185ecd090 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -708,6 +708,8 @@ struct scx_rq {
 	u32			flags;
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_preempt;
+	cpumask_var_t		cpus_to_wait;
+	u64			pnt_seq;
 	struct irq_work		kick_cpus_irq_work;
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
-- 
2.39.1

