Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C29363D08E
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiK3I1I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbiK3IZk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:25:40 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51E67047A;
        Wed, 30 Nov 2022 00:24:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o12so7208237pjo.4;
        Wed, 30 Nov 2022 00:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icbEL6Yyh88UwKlWIMibQXf09tYG4jVGd0Sd4NYusRk=;
        b=cwevkODSfgy/ecZgn1k9Sl3axSX97jP3z2nxUdls+f3M+9XG9jOSmyTeNQioc3Oih/
         xnhqxcRW67kGSuIu4oa/20EDH5zCBGY/CoRZLTDXxRZvatLVoqEY99RmTc0CcwmW1Z+o
         H3ucNRMQanqy8GVJv9CU7u9JohFhNWWYT1jD5UT9gsIfNScLNUw3IZB7X2CoETDsmuHY
         eL8ju2tQjY4NQmmlfR4/smloVFDKwtC1WswsrbyTN/oBtrJXyhHZyxH819kHtmbIBQGm
         frocUBnuSV/ZMRlPAJsnA6irxxhKS9FGbpOcRiZreHnMoEqMcWslMZI6kR3TqrSnFOgv
         /7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=icbEL6Yyh88UwKlWIMibQXf09tYG4jVGd0Sd4NYusRk=;
        b=lu0nj3hvLfj23dqw0xD46o9Lg2QvJXzrr/GNYjHcdZhDrYUI2HRhkqJgKVZzmSuPnP
         0IyTXDtwgSb81hDOI8DG7LVc2YjFeZ4ir8fkF7G4m8MxHD4MjKa/VaZuzbOT4Hvwlww/
         6BRe3LaH8lwkjdiyzm0MBCah+jkTW8BT7h91aq3frco5fYo8xIBh1sA0FvNU/BrgcOlx
         zC7+FkB4W/t6587MsQaJZNCoLCXnICTzPbgdGzQuvoDQC6EwcGSLTWLh+Nu11rNO0UWN
         +1IEWRWNzUF+2r65DrHxrNjtYEZ1hoea0M+wHOGnzpj5Q5IyYQjW/2b2cljvsqGsfKri
         Ga7A==
X-Gm-Message-State: ANoB5pn7VID3NFhMPA2fpyIf/Bc3rs2kOSgu+vGnxYi4npm7gwaRo4y3
        QDuDGwos6SPHMbwwwYBoa7A=
X-Google-Smtp-Source: AA0mqf4IlcoridLQ++OjRdvy1H/e5LzA5fityT9BR15abVAoR90Rh0qY8hdmHjRCpcdgu7gGeuvKMg==
X-Received: by 2002:a17:902:bf01:b0:186:8bca:1d50 with SMTP id bi1-20020a170902bf0100b001868bca1d50mr42720977plb.158.1669796670788;
        Wed, 30 Nov 2022 00:24:30 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e80600b0017849a2b56asm777944plg.46.2022.11.30.00.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:30 -0800 (PST)
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
Subject: [PATCH 25/31] sched_ext: Implement SCX_KICK_WAIT
Date:   Tue, 29 Nov 2022 22:23:07 -1000
Message-Id: <20221130082313.3241517-26-tj@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
 kernel/sched/ext.c   | 36 ++++++++++++++++++++++++++++++++++--
 kernel/sched/ext.h   | 20 ++++++++++++++++++++
 kernel/sched/sched.h |  2 ++
 4 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 79560641a61f..ea4f6edfcf32 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5886,8 +5886,10 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
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
index bd03b55fbcf5..aeaad3d8b05a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -109,8 +109,9 @@ unsigned long last_timeout_check = INITIAL_JIFFIES;
 
 static struct delayed_work check_timeout_work;
 
-/* idle tracking */
 #ifdef CONFIG_SMP
+
+/* idle tracking */
 #ifdef CONFIG_CPUMASK_OFFSTACK
 #define CL_ALIGNED_IF_ONSTACK
 #else
@@ -123,7 +124,11 @@ static struct {
 } idle_masks CL_ALIGNED_IF_ONSTACK;
 
 static bool __cacheline_aligned_in_smp has_idle_cpus;
-#endif
+
+/* for %SCX_KICK_WAIT */
+static u64 __percpu *kick_cpus_pnt_seqs;
+
+#endif	/* CONFIG_SMP */
 
 /*
  * Direct dispatch marker.
@@ -2959,6 +2964,7 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
 static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 {
 	struct rq *this_rq = this_rq();
+	u64 *pseqs = this_cpu_ptr(kick_cpus_pnt_seqs);
 	int this_cpu = cpu_of(this_rq);
 	int cpu;
 
@@ -2972,14 +2978,32 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
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
 #endif
 
@@ -2999,6 +3023,11 @@ void __init init_sched_ext_class(void)
 #ifdef CONFIG_SMP
 	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+
+	kick_cpus_pnt_seqs = __alloc_percpu(sizeof(kick_cpus_pnt_seqs[0]) *
+					    num_possible_cpus(),
+					    __alignof__(kick_cpus_pnt_seqs[0]));
+	BUG_ON(!kick_cpus_pnt_seqs);
 #endif
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
@@ -3009,6 +3038,7 @@ void __init init_sched_ext_class(void)
 #ifdef CONFIG_SMP
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_preempt, GFP_KERNEL));
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_wait, GFP_KERNEL));
 		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 #endif
 	}
@@ -3228,6 +3258,8 @@ void scx_bpf_kick_cpu(s32 cpu, u64 flags)
 		cpumask_set_cpu(cpu, rq->scx.cpus_to_kick);
 		if (flags & SCX_KICK_PREEMPT)
 			cpumask_set_cpu(cpu, rq->scx.cpus_to_preempt);
+		if (flags & SCX_KICK_WAIT)
+			cpumask_set_cpu(cpu, rq->scx.cpus_to_wait);
 
 		irq_work_queue(&rq->scx.kick_cpus_irq_work);
 		preempt_enable();
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 470b2224cdfa..8ae717c5e850 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -66,6 +66,7 @@ enum scx_tg_flags {
 
 enum scx_kick_flags {
 	SCX_KICK_PREEMPT	= 1LLU << 0,	/* force scheduling on the CPU */
+	SCX_KICK_WAIT		= 1LLU << 1,	/* wait for the CPU to be rescheduled */
 };
 
 #ifdef CONFIG_SCHED_CLASS_EXT
@@ -107,6 +108,22 @@ __printf(2, 3) void scx_ops_error_type(enum scx_exit_type type,
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
 	unsigned long last_check, timeout;
@@ -164,6 +181,9 @@ static inline int scx_check_setscheduler(struct task_struct *p,
 					 int policy) { return 0; }
 static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
 static inline void init_sched_ext_class(void) {}
+static inline void scx_notify_pick_next_task(struct rq *rq,
+					     const struct task_struct *p,
+					     const struct sched_class *active) {}
 static inline void scx_notify_sched_tick(void) {}
 
 #define for_each_active_class		for_each_class
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a2ffa94ede02..5af758cc1e38 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -714,6 +714,8 @@ struct scx_rq {
 #ifdef CONFIG_SMP
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_preempt;
+	cpumask_var_t		cpus_to_wait;
+	u64			pnt_seq;
 	struct irq_work		kick_cpus_irq_work;
 #endif
 };
-- 
2.38.1

