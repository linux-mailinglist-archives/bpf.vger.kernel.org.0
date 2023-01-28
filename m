Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238C267F301
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjA1AT0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjA1ASR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:18:17 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7647D6D1;
        Fri, 27 Jan 2023 16:17:38 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z13so6570664plg.6;
        Fri, 27 Jan 2023 16:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2762tv9NrSIPMrglXNQsSYNt9iMRZ5q4VM4Sve5Uoww=;
        b=offoSr/KlMcOHKkZiG+dgkDfXGpqzOLW/eZ8VnoKL0R7GTUED+4NYXCx/Q3ccsISKS
         8CQ62owuCFtjZjZibP0FQKUB99osUyH7yWT0Pn4cUcK/vrUKidTPF6zviUVOc7aNwoLz
         YaOhiIEFV/RB5JCTVaFCNKS2hQLOym3UrxX9hKJV6G1Gey2TsUiothUgtReCJ35Npqse
         6+et+ICu7/rm5GwHnzVYtFxgeULWeSNTsDN64LIIkcxZMu9NO1v/iEsXdIQqdws6+1iY
         qVai11ayvvRUjbujnLs549xfEl9hKNBUPkGAm94jgkt+f5rqjx26jp5Qpvx5wXITc2kI
         AyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2762tv9NrSIPMrglXNQsSYNt9iMRZ5q4VM4Sve5Uoww=;
        b=K1k8+PX+aKC2VaOcxBi/eI10bbm5L/tXqkRLPnli9HjpBJJk/rC8aO9JrJ4gN5NehD
         YADStv6zzwQ6xSmOe4XseuY6IhjbnEdQZWV2S7stIqh6J6/iHSnm48sbzBirMUaCKL/0
         djAnG5KgHTI4pSY2cgK6BxqohrBqzoRTXTzdujmnEkKMXTf92E6+QYUGs2gRgG6OsxwH
         7J2EmxjEFT7NJf0R3CFZ1GNi2aWdNgXjvTOCASvJ3YMEqrGf4Q9fsOV/WykvuWqb1odP
         zqRhXzUxTVEbPsLpEi3JQ0XR5nxez/Nbvvnqqo4S3xU7TRbKftPt5Mlt4QyIzUIrEDI2
         pRpA==
X-Gm-Message-State: AO0yUKW0Crcgs0iMk3bxEoBEbVuxXazSwy4GAs3JJeFGa6EWsMGDDMfp
        nSofJzDARVkowgyTE/fP6Kw=
X-Google-Smtp-Source: AK7set8qrqri+vz0M8S3KUwDIchpGMv7FcB2xyq2cdSXTETVNnCAHh4yWQARFG3OpTIQA9K9/q0zDQ==
X-Received: by 2002:a17:903:234b:b0:196:595b:2580 with SMTP id c11-20020a170903234b00b00196595b2580mr4031452plh.0.1674865045351;
        Fri, 27 Jan 2023 16:17:25 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001949ae8c275sm3405975plh.141.2023.01.27.16.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:24 -0800 (PST)
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
Subject: [PATCH 18/30] sched_ext: Allow BPF schedulers to switch all eligible tasks into sched_ext
Date:   Fri, 27 Jan 2023 14:16:27 -1000
Message-Id: <20230128001639.3510083-19-tj@kernel.org>
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

Currently, to use sched_ext, each task has to be put into sched_ext using
sched_setscheduler(2). However, some BPF schedulers and use cases might
prefer to service all eligible tasks.

This patch adds a new kfunc helper, scx_bpf_switch_all(), that BPF
schedulers can call from ops.init() to switch all SCHED_NORMAL, SCHED_BATCH
and SCHED_IDLE tasks into sched_ext. This has the benefit that the scheduler
swaps are transparent to the users and applications. As we know that CFS is
not being used when scx_bpf_switch_all() is used, we can also disable hot
path entry points with static_branches.

Both the dummy and qmap example schedulers are updated with the '-a' option
which enables the switch_all behavior.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Barret Rhoden <brho@google.com>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c                     |  8 +++--
 kernel/sched/ext.c                      | 45 +++++++++++++++++++++++++
 kernel/sched/ext.h                      |  5 +++
 tools/sched_ext/scx_common.bpf.h        |  1 +
 tools/sched_ext/scx_example_dummy.bpf.c | 11 ++++++
 tools/sched_ext/scx_example_dummy.c     |  8 +++--
 tools/sched_ext/scx_example_qmap.bpf.c  |  9 +++++
 tools/sched_ext/scx_example_qmap.c      |  7 ++--
 8 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9e566e72c3f2..5b68b822312b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1204,7 +1204,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	 * if there's more than one we need the tick for involuntary
 	 * preemption.
 	 */
-	if (rq->nr_running > 1)
+	if (!scx_switched_all() && rq->nr_running > 1)
 		return false;
 
 	return true;
@@ -5590,8 +5590,10 @@ void scheduler_tick(void)
 	perf_event_task_tick();
 
 #ifdef CONFIG_SMP
-	rq->idle_balance = idle_cpu(cpu);
-	trigger_load_balance(rq);
+	if (!scx_switched_all()) {
+		rq->idle_balance = idle_cpu(cpu);
+		trigger_load_balance(rq);
+	}
 #endif
 }
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b9d55c25cec9..63f0a3cf2d53 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -73,6 +73,10 @@ static DEFINE_MUTEX(scx_ops_enable_mutex);
 DEFINE_STATIC_KEY_FALSE(__scx_ops_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_ops_enable_state_var = ATOMIC_INIT(SCX_OPS_DISABLED);
+static bool scx_switch_all_req;
+static bool scx_switching_all;
+DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
+
 static struct sched_ext_ops scx_ops;
 static bool scx_warned_zero_slice;
 
@@ -1966,6 +1970,8 @@ bool task_on_scx(struct task_struct *p)
 {
 	if (!scx_enabled() || scx_ops_disabling())
 		return false;
+	if (READ_ONCE(scx_switching_all))
+		return true;
 	return p->policy == SCHED_EXT;
 }
 
@@ -2092,6 +2098,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	 */
 	mutex_lock(&scx_ops_enable_mutex);
 
+	static_branch_disable(&__scx_switched_all);
+	WRITE_ONCE(scx_switching_all, false);
+
 	/* avoid racing against fork */
 	cpus_read_lock();
 	percpu_down_write(&scx_fork_rwsem);
@@ -2276,6 +2285,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	 */
 	cpus_read_lock();
 
+	scx_switch_all_req = false;
 	if (scx_ops.init) {
 		ret = SCX_CALL_OP_RET(SCX_KF_INIT | SCX_KF_SLEEPABLE, init);
 		if (ret) {
@@ -2391,6 +2401,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	 * transitions here are synchronized against sched_ext_free() through
 	 * scx_tasks_lock.
 	 */
+	WRITE_ONCE(scx_switching_all, scx_switch_all_req);
+
 	scx_task_iter_init(&sti);
 	while ((p = scx_task_iter_next_filtered_locked(&sti))) {
 		if (READ_ONCE(p->__state) != TASK_DEAD) {
@@ -2422,6 +2434,9 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 		goto err_disable_unlock;
 	}
 
+	if (scx_switch_all_req)
+		static_branch_enable_cpuslocked(&__scx_switched_all);
+
 	cpus_read_unlock();
 	mutex_unlock(&scx_ops_enable_mutex);
 
@@ -2456,6 +2471,9 @@ static int scx_debug_show(struct seq_file *m, void *v)
 	mutex_lock(&scx_ops_enable_mutex);
 	seq_printf(m, "%-30s: %s\n", "ops", scx_ops.name);
 	seq_printf(m, "%-30s: %ld\n", "enabled", scx_enabled());
+	seq_printf(m, "%-30s: %d\n", "switching_all",
+		   READ_ONCE(scx_switching_all));
+	seq_printf(m, "%-30s: %ld\n", "switched_all", scx_switched_all());
 	seq_printf(m, "%-30s: %s\n", "enable_state",
 		   scx_ops_enable_state_str[scx_ops_enable_state()]);
 	seq_printf(m, "%-30s: %llu\n", "nr_rejected",
@@ -2694,6 +2712,31 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
 
+/**
+ * scx_bpf_switch_all - Switch all tasks into SCX
+ * @into_scx: switch direction
+ *
+ * If @into_scx is %true, all existing and future non-dl/rt tasks are switched
+ * to SCX. If %false, only tasks which have %SCHED_EXT explicitly set are put on
+ * SCX. The actual switching is asynchronous. Can be called from ops.init().
+ */
+void scx_bpf_switch_all(void)
+{
+	if (!scx_kf_allowed(SCX_KF_INIT))
+		return;
+
+	scx_switch_all_req = true;
+}
+
+BTF_SET8_START(scx_kfunc_ids_init)
+BTF_ID_FLAGS(func, scx_bpf_switch_all)
+BTF_SET8_END(scx_kfunc_ids_init)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_init = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_init,
+};
+
 /**
  * scx_bpf_create_dsq - Create a custom DSQ
  * @dsq_id: DSQ to create
@@ -3131,6 +3174,8 @@ static int __init register_ext_kfuncs(void)
 	 * check using scx_kf_allowed().
 	 */
 	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_init)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_sleepable)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_enqueue_dispatch)) ||
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 76c94babd19e..a4fe649e649d 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -60,7 +60,9 @@ extern unsigned long scx_watchdog_timeout;
 extern unsigned long scx_watchdog_timestamp;
 
 DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);
+DECLARE_STATIC_KEY_FALSE(__scx_switched_all);
 #define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
+#define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
 
 bool task_on_scx(struct task_struct *p);
 void scx_pre_fork(struct task_struct *p);
@@ -95,6 +97,8 @@ static inline void scx_notify_sched_tick(void)
 static inline const struct sched_class *next_active_class(const struct sched_class *class)
 {
 	class++;
+	if (scx_switched_all() && class == &fair_sched_class)
+		class++;
 	if (!scx_enabled() && class == &ext_sched_class)
 		class++;
 	return class;
@@ -117,6 +121,7 @@ static inline const struct sched_class *next_active_class(const struct sched_cla
 #else	/* CONFIG_SCHED_CLASS_EXT */
 
 #define scx_enabled()		false
+#define scx_switched_all()	false
 
 static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
diff --git a/tools/sched_ext/scx_common.bpf.h b/tools/sched_ext/scx_common.bpf.h
index b40a4fc6a159..fec19e8d0681 100644
--- a/tools/sched_ext/scx_common.bpf.h
+++ b/tools/sched_ext/scx_common.bpf.h
@@ -66,6 +66,7 @@ bool bpf_cpumask_and(struct bpf_cpumask *dst, const struct cpumask *src1,
 		     const struct cpumask *src2) __ksym;
 u32 bpf_cpumask_first(const struct cpumask *cpumask) __ksym;
 
+void scx_bpf_switch_all(void) __ksym;
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
diff --git a/tools/sched_ext/scx_example_dummy.bpf.c b/tools/sched_ext/scx_example_dummy.bpf.c
index ac7b490b5a39..28251373d1c3 100644
--- a/tools/sched_ext/scx_example_dummy.bpf.c
+++ b/tools/sched_ext/scx_example_dummy.bpf.c
@@ -7,6 +7,7 @@
  *
  * - Statistics tracking how many are queued to local and global dsq's.
  * - Termination notification for userspace.
+ * - Support for switch_all.
  *
  * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
@@ -16,6 +17,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+const volatile bool switch_all;
+
 struct user_exit_info uei;
 
 struct {
@@ -32,6 +35,13 @@ static void stat_inc(u32 idx)
 		(*cnt_p)++;
 }
 
+s32 BPF_STRUCT_OPS(dummy_init)
+{
+	if (switch_all)
+		scx_bpf_switch_all();
+	return 0;
+}
+
 void BPF_STRUCT_OPS(dummy_enqueue, struct task_struct *p, u64 enq_flags)
 {
 	if (enq_flags & SCX_ENQ_LOCAL) {
@@ -51,6 +61,7 @@ void BPF_STRUCT_OPS(dummy_exit, struct scx_exit_info *ei)
 SEC(".struct_ops")
 struct sched_ext_ops dummy_ops = {
 	.enqueue		= (void *)dummy_enqueue,
+	.init			= (void *)dummy_init,
 	.exit			= (void *)dummy_exit,
 	.name			= "dummy",
 };
diff --git a/tools/sched_ext/scx_example_dummy.c b/tools/sched_ext/scx_example_dummy.c
index 72881c881830..9229973e8698 100644
--- a/tools/sched_ext/scx_example_dummy.c
+++ b/tools/sched_ext/scx_example_dummy.c
@@ -19,8 +19,9 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s\n"
+"Usage: %s [-a]\n"
 "\n"
+"  -a            Switch all tasks\n"
 "  -h            Display this help and exit\n";
 
 static volatile int exit_req;
@@ -64,8 +65,11 @@ int main(int argc, char **argv)
 	skel = scx_example_dummy__open();
 	assert(skel);
 
-	while ((opt = getopt(argc, argv, "h")) != -1) {
+	while ((opt = getopt(argc, argv, "ah")) != -1) {
 		switch (opt) {
+		case 'a':
+			skel->rodata->switch_all = true;
+			break;
 		default:
 			fprintf(stderr, help_fmt, basename(argv[0]));
 			return opt != 'h';
diff --git a/tools/sched_ext/scx_example_qmap.bpf.c b/tools/sched_ext/scx_example_qmap.bpf.c
index 46bc16ed301f..ec8c4ee7ef16 100644
--- a/tools/sched_ext/scx_example_qmap.bpf.c
+++ b/tools/sched_ext/scx_example_qmap.bpf.c
@@ -22,6 +22,7 @@
 char _license[] SEC("license") = "GPL";
 
 const volatile u64 slice_ns = SCX_SLICE_DFL;
+const volatile bool switch_all;
 const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
 const volatile s32 disallow_tgid;
@@ -236,6 +237,13 @@ s32 BPF_STRUCT_OPS(qmap_prep_enable, struct task_struct *p,
 		return -ENOMEM;
 }
 
+s32 BPF_STRUCT_OPS(qmap_init)
+{
+	if (switch_all)
+		scx_bpf_switch_all();
+	return 0;
+}
+
 void BPF_STRUCT_OPS(qmap_exit, struct scx_exit_info *ei)
 {
 	uei_record(&uei, ei);
@@ -248,6 +256,7 @@ struct sched_ext_ops qmap_ops = {
 	.dequeue		= (void *)qmap_dequeue,
 	.dispatch		= (void *)qmap_dispatch,
 	.prep_enable		= (void *)qmap_prep_enable,
+	.init			= (void *)qmap_init,
 	.exit			= (void *)qmap_exit,
 	.timeout_ms		= 5000U,
 	.name			= "qmap",
diff --git a/tools/sched_ext/scx_example_qmap.c b/tools/sched_ext/scx_example_qmap.c
index dff9323dfd20..30633122e6d5 100644
--- a/tools/sched_ext/scx_example_qmap.c
+++ b/tools/sched_ext/scx_example_qmap.c
@@ -20,7 +20,7 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-d PID]\n"
+"Usage: %s [-a] [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-d PID]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
@@ -50,8 +50,11 @@ int main(int argc, char **argv)
 	skel = scx_example_qmap__open();
 	assert(skel);
 
-	while ((opt = getopt(argc, argv, "hs:e:t:T:d:")) != -1) {
+	while ((opt = getopt(argc, argv, "ahs:e:t:T:d:")) != -1) {
 		switch (opt) {
+		case 'a':
+			skel->rodata->switch_all = true;
+			break;
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
 			break;
-- 
2.39.1

