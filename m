Return-Path: <bpf+bounces-14852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3377E88A5
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816901C20A0E
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AEE5673;
	Sat, 11 Nov 2023 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMAn25/E"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFC53B5
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:51:49 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56784EC3;
	Fri, 10 Nov 2023 18:49:28 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b566ee5f1dso1441821b6e.0;
        Fri, 10 Nov 2023 18:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670968; x=1700275768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCDpGBaTShbaonGJEwLXrDohmcOtEf6xm+ibDWlEcqg=;
        b=dMAn25/ErODxdg8H+KlW7dm3xbrLyI/yVih1RwxAStbrUhQj1tk8GCNbSvzw/3hWSZ
         226OLqZ/FGFDlMWGNPvJLhhyWgd10b+s3ACf9J39oCmMBfbXzlPw8LaUeFon3AJsWaft
         FPflM92lUn4s8q+2O8LeMkpxvNri8KqmQ4Ev8mCHr7/1DGeDBfFqjTgrVj8J177Cyf3K
         YsH8o+nG0ZdmkZA5powmjHbka0ZJPF81OgzzFSycspE3W0+jvxPv0Xn53Vs7SOQJuN8d
         VEOYYTW07jCCdAEdNi/BJQuBtI79VpVxpF4NmNIPA1KHiaL5dc1e0YWzGvBPci8sH8oz
         m8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670968; x=1700275768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cCDpGBaTShbaonGJEwLXrDohmcOtEf6xm+ibDWlEcqg=;
        b=FagklpE7UWFz2T/6RxbkpU9n0c/Fk2YLFkYLBrLhPXm4MC7WfKRNKGJUFPthQA0cjj
         V/2df11htXMsLYJWe8ywvgh0mj4nqU4G/+mv0jYTsLxtzOHQX0N/bDvGGq7WBQHu39Dv
         AA2kalU7bNR+17PNa64lripHCJHc5xA8hn2/4GHrEXBzVc+7JIE1ZJB5YwP76JWR6Z7u
         D0IWXwJKPNv7ZyFn1sBe2dBwvPt+lbU6KyXqz4ymROt8nPm79TL/ZtBHkl6q/9YV34HD
         GUT8ekQFhTBnXAGG/Z7TR59tI/zknDgw4OWSAJLNs61cj+ROGP3RvjDiefG4cNmkKDDJ
         DTuw==
X-Gm-Message-State: AOJu0YxECiEMU34SohePA8c2Uxysogk7G8ZrZBWtTtocUZuyJVwihS4i
	iw/t4cD4w3LpRv7tEuIrUKM=
X-Google-Smtp-Source: AGHT+IHoHobf+lpvQG/wBuXZRSpnU/WQ48NOwBPiPujSI6PcZmXqlKo9xxH4ZLEQcwgnmZX7V9CMeA==
X-Received: by 2002:aca:1909:0:b0:3af:b6d3:cda0 with SMTP id l9-20020aca1909000000b003afb6d3cda0mr1199936oii.40.1699670967980;
        Fri, 10 Nov 2023 18:49:27 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id v8-20020aa78088000000b006c31c239345sm405260pff.177.2023.11.10.18.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 17/36] sched_ext: Allow BPF schedulers to switch all eligible tasks into sched_ext
Date: Fri, 10 Nov 2023 16:47:43 -1000
Message-ID: <20231111024835.2164816-18-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, to use sched_ext, each task has to be put into sched_ext using
sched_setscheduler(2). However, some BPF schedulers and use cases might
prefer to service all eligible tasks.

This patch adds a new kfunc helper, scx_bpf_switch_all(), that BPF
schedulers can call from ops.init() to switch all SCHED_NORMAL, SCHED_BATCH
and SCHED_IDLE tasks into sched_ext. This has the benefit that the scheduler
swaps are transparent to the users and applications. As we know that CFS is
not being used when scx_bpf_switch_all() is used, we can also disable hot
path entry points with static_branches.

Both the simple and qmap example schedulers are updated to switch all tasks
by default to ease testing. '-p' option is added which enables the original
behavior of switching only tasks which are explicitly on SCHED_EXT.

v2: In the example schedulers, switch all tasks by default.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Barret Rhoden <brho@google.com>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c              |  8 +++---
 kernel/sched/ext.c               | 43 ++++++++++++++++++++++++++++++++
 kernel/sched/ext.h               |  5 ++++
 tools/sched_ext/scx_common.bpf.h |  1 +
 tools/sched_ext/scx_qmap.bpf.c   |  9 +++++++
 tools/sched_ext/scx_qmap.c       |  8 ++++--
 tools/sched_ext/scx_simple.bpf.c | 10 ++++++++
 tools/sched_ext/scx_simple.c     |  8 ++++--
 8 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6b8883fedf33..1906f8397c28 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1236,7 +1236,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	 * if there's more than one we need the tick for involuntary
 	 * preemption.
 	 */
-	if (rq->nr_running > 1)
+	if (!scx_switched_all() && rq->nr_running > 1)
 		return false;
 
 	/*
@@ -5723,8 +5723,10 @@ void scheduler_tick(void)
 		wq_worker_tick(curr);
 
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
index 025b6103b87d..4e2aa9f308fb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -80,6 +80,10 @@ static DEFINE_MUTEX(scx_ops_enable_mutex);
 DEFINE_STATIC_KEY_FALSE(__scx_ops_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_ops_enable_state_var = ATOMIC_INIT(SCX_OPS_DISABLED);
+static bool scx_switch_all_req;
+static bool scx_switching_all;
+DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
+
 static struct sched_ext_ops scx_ops;
 static bool scx_warned_zero_slice;
 
@@ -2068,6 +2072,8 @@ bool task_should_scx(struct task_struct *p)
 {
 	if (!scx_enabled() || scx_ops_disabling())
 		return false;
+	if (READ_ONCE(scx_switching_all))
+		return true;
 	return p->policy == SCHED_EXT;
 }
 
@@ -2195,6 +2201,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	 */
 	mutex_lock(&scx_ops_enable_mutex);
 
+	static_branch_disable(&__scx_switched_all);
+	WRITE_ONCE(scx_switching_all, false);
+
 	/* avoid racing against fork */
 	cpus_read_lock();
 	percpu_down_write(&scx_fork_rwsem);
@@ -2378,6 +2387,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	 */
 	cpus_read_lock();
 
+	scx_switch_all_req = false;
 	if (scx_ops.init) {
 		ret = SCX_CALL_OP_RET(SCX_KF_INIT, init);
 		if (ret) {
@@ -2493,6 +2503,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	 * transitions here are synchronized against sched_ext_free() through
 	 * scx_tasks_lock.
 	 */
+	WRITE_ONCE(scx_switching_all, scx_switch_all_req);
+
 	scx_task_iter_init(&sti);
 	while ((p = scx_task_iter_next_filtered_locked(&sti))) {
 		if (READ_ONCE(p->__state) != TASK_DEAD) {
@@ -2524,6 +2536,9 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 		goto err_disable;
 	}
 
+	if (scx_switch_all_req)
+		static_branch_enable_cpuslocked(&__scx_switched_all);
+
 	cpus_read_unlock();
 	mutex_unlock(&scx_ops_enable_mutex);
 
@@ -2558,6 +2573,9 @@ static int scx_debug_show(struct seq_file *m, void *v)
 	mutex_lock(&scx_ops_enable_mutex);
 	seq_printf(m, "%-30s: %s\n", "ops", scx_ops.name);
 	seq_printf(m, "%-30s: %ld\n", "enabled", scx_enabled());
+	seq_printf(m, "%-30s: %d\n", "switching_all",
+		   READ_ONCE(scx_switching_all));
+	seq_printf(m, "%-30s: %ld\n", "switched_all", scx_switched_all());
 	seq_printf(m, "%-30s: %s\n", "enable_state",
 		   scx_ops_enable_state_str[scx_ops_enable_state()]);
 	seq_printf(m, "%-30s: %lu\n", "nr_rejected",
@@ -2809,6 +2827,29 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
 
+/**
+ * scx_bpf_switch_all - Switch all tasks into SCX
+ *
+ * Switch all existing and future non-dl/rt tasks to SCX. This can only be
+ * called from ops.init(), and actual switching is performed asynchronously.
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
@@ -3312,6 +3353,8 @@ static int __init register_ext_kfuncs(void)
 	 * check using scx_kf_allowed().
 	 */
 	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_init)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_sleepable)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_enqueue_dispatch)) ||
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index bd283ee54da7..1cdef69a6855 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -75,7 +75,9 @@ extern unsigned long scx_watchdog_timeout;
 extern unsigned long scx_watchdog_timestamp;
 
 DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);
+DECLARE_STATIC_KEY_FALSE(__scx_switched_all);
 #define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
+#define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
 
 static inline bool task_on_scx(const struct task_struct *p)
 {
@@ -115,6 +117,8 @@ static inline void scx_notify_sched_tick(void)
 static inline const struct sched_class *next_active_class(const struct sched_class *class)
 {
 	class++;
+	if (scx_switched_all() && class == &fair_sched_class)
+		class++;
 	if (!scx_enabled() && class == &ext_sched_class)
 		class++;
 	return class;
@@ -137,6 +141,7 @@ static inline const struct sched_class *next_active_class(const struct sched_cla
 #else	/* CONFIG_SCHED_CLASS_EXT */
 
 #define scx_enabled()		false
+#define scx_switched_all()	false
 
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline void scx_pre_fork(struct task_struct *p) {}
diff --git a/tools/sched_ext/scx_common.bpf.h b/tools/sched_ext/scx_common.bpf.h
index cfd3122244eb..81e484defd9b 100644
--- a/tools/sched_ext/scx_common.bpf.h
+++ b/tools/sched_ext/scx_common.bpf.h
@@ -53,6 +53,7 @@ void ___scx_bpf_error_format_checker(const char *fmt, ...) {}
 	___scx_bpf_error_format_checker(fmt, ##args);				\
 })
 
+void scx_bpf_switch_all(void) __ksym;
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index d0bc67095062..da43f962ab4e 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -25,6 +25,7 @@
 char _license[] SEC("license") = "GPL";
 
 const volatile u64 slice_ns = SCX_SLICE_DFL;
+const volatile bool switch_partial;
 const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
 const volatile s32 disallow_tgid;
@@ -239,6 +240,13 @@ s32 BPF_STRUCT_OPS(qmap_prep_enable, struct task_struct *p,
 		return -ENOMEM;
 }
 
+s32 BPF_STRUCT_OPS(qmap_init)
+{
+	if (!switch_partial)
+		scx_bpf_switch_all();
+	return 0;
+}
+
 void BPF_STRUCT_OPS(qmap_exit, struct scx_exit_info *ei)
 {
 	uei_record(&uei, ei);
@@ -251,6 +259,7 @@ struct sched_ext_ops qmap_ops = {
 	.dequeue		= (void *)qmap_dequeue,
 	.dispatch		= (void *)qmap_dispatch,
 	.prep_enable		= (void *)qmap_prep_enable,
+	.init			= (void *)qmap_init,
 	.exit			= (void *)qmap_exit,
 	.timeout_ms		= 5000U,
 	.name			= "qmap",
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 6002cef833ab..cac9f0780ce9 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -18,13 +18,14 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-d PID]\n"
+"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-d PID] [-p]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
 "  -t COUNT      Stall every COUNT'th user thread\n"
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
+"  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -h            Display this help and exit\n";
 
 static volatile int exit_req;
@@ -48,7 +49,7 @@ int main(int argc, char **argv)
 	skel = scx_qmap__open();
 	SCX_BUG_ON(!skel, "Failed to open skel");
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:d:h")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:d:ph")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -67,6 +68,9 @@ int main(int argc, char **argv)
 			if (skel->rodata->disallow_tgid < 0)
 				skel->rodata->disallow_tgid = getpid();
 			break;
+		case 'p':
+			skel->rodata->switch_partial = true;
+			break;
 		default:
 			fprintf(stderr, help_fmt, basename(argv[0]));
 			return opt != 'h';
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index 9326124a32fa..6302a4ea9ea5 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -15,6 +15,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+const volatile bool switch_partial;
+
 struct user_exit_info uei;
 
 struct {
@@ -43,6 +45,13 @@ void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
 	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
 
+s32 BPF_STRUCT_OPS(simple_init)
+{
+	if (!switch_partial)
+		scx_bpf_switch_all();
+	return 0;
+}
+
 void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
 {
 	uei_record(&uei, ei);
@@ -51,6 +60,7 @@ void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
 SEC(".struct_ops.link")
 struct sched_ext_ops simple_ops = {
 	.enqueue		= (void *)simple_enqueue,
+	.init			= (void *)simple_init,
 	.exit			= (void *)simple_exit,
 	.name			= "simple",
 };
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
index c282674af8c3..6116b13d8cff 100644
--- a/tools/sched_ext/scx_simple.c
+++ b/tools/sched_ext/scx_simple.c
@@ -17,8 +17,9 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s\n"
+"Usage: %s [-p]\n"
 "\n"
+"  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -h            Display this help and exit\n";
 
 static volatile int exit_req;
@@ -62,8 +63,11 @@ int main(int argc, char **argv)
 	skel = scx_simple__open();
 	SCX_BUG_ON(!skel, "Failed to open skel");
 
-	while ((opt = getopt(argc, argv, "h")) != -1) {
+	while ((opt = getopt(argc, argv, "ph")) != -1) {
 		switch (opt) {
+		case 'p':
+			skel->rodata->switch_partial = true;
+			break;
 		default:
 			fprintf(stderr, help_fmt, basename(argv[0]));
 			return opt != 'h';
-- 
2.42.0


