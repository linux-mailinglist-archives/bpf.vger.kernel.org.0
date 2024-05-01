Return-Path: <bpf+bounces-28348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBC98B8CA1
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466931C21446
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A0C12FF62;
	Wed,  1 May 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcMN1Owc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B912132C1B;
	Wed,  1 May 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576436; cv=none; b=tVgp801WDJx6iuVNusQzrOF1OAZ2hGJ2uVG+ADcfqkcLZX37tf+/bLfRAj5LNgXmxBXL3gaYYIMZgNjzWDDxa7oGutura0G3A/aAFBh2qQvI8zDj12zPbyVZM2hAuycMbIv/ekbgPCDJ0oA2dJGIHukMexK1rlV8d9mQVH2d4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576436; c=relaxed/simple;
	bh=KnaZjB6vivTNdrN7YZRP2pKUT2PLf6GrwZ9R8YUycDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDLLpLfIfOLVoEzyCnDmGgFmC0UFztYDpMDX9Rkvo9PQeyC4IqdmTy4htefNsat6kG3KU5cNF8xLAA0BIG+6Ua20ktWIDkRGZCZE0g7o8d69QXSfT+Xo3j661A6+X+zFBMJ7f+9xk/1N/esbvG0BJ6P14IjxQwP2xqfsI9FFCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcMN1Owc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ee12766586so709308b3a.0;
        Wed, 01 May 2024 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576434; x=1715181234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kck6U8qIurWlLRuji3OdBvwDwBl3z9c71Q4SEB6EHFQ=;
        b=hcMN1OwciR5MPuYn0rk8UYuM4QnlFi1A1WLrIupM/kaX2LNMYSAxZD6zdIkrRHlo9g
         1TUhUNAco4bEu6749PGDMSfvbM+/5eEmJQ3Z2h+kkoTJ9qy23UerJGnBgsLS3WIrTFTp
         R2C8p065uS25piOLBdOF55Kwv7G3ZxKQzhRYhUpq6cWagfxIEJFG1egN5DHw0Qk9LxgT
         R4f745C43K7KNo2abtIf5x4tOJ+2HrBisNzWDMHUXZV7vk+cMwDvqaLqaFhNOmb3CUk5
         w+gTmhVUcfJ3OW8MddEN+tp20Ys7jHjTy41Owyj1Q5X0RpAN2EUVKanNdZ2FhiHDKZCQ
         hCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576434; x=1715181234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kck6U8qIurWlLRuji3OdBvwDwBl3z9c71Q4SEB6EHFQ=;
        b=a1NXPr/2z4urYd3cb3kdyjDkNCA7EJRqJ9pAZwIkAijaA/98a7CLS5ZiymVC/erjm6
         2F6UViRyfxbFlVLL1dNZ0RV+bglqLjwcTfbwRYPu11dJ9UWfwFskwW/sd6APt9/Q04DY
         Kmm1qZ1iK4ftWFBKVu6pKE70JbUe7TMalauTafswbcK56uf2A4VeiFcHmv+Hyq26aLfh
         J/feS85r45NevTj1tIy1nGDmI3E76hk6gBB5iY3K1oSnAcGY2GOfUegFnuuYOLqtp9qP
         7IBYAHldZ6QXTFgk15qZQtzPzjP1LyVCAR4XacgrM1xLHDnh+P2yHFBC8udkb2vdhG9D
         /Wpw==
X-Forwarded-Encrypted: i=1; AJvYcCWHK8iAi03Q600E+oOK9UWK1ONvaJwnaxh67ymtQBWwRs7kjKaPGdLRwI3J9s1o0fwSIN2y/dyxYQk9OSTDgNBItyQU
X-Gm-Message-State: AOJu0YxnpgA9JPr/mwYs8Og7YtuZtMVXlW6Y2HtP3tYCSxBWSMSOJ8f4
	KDqn2qOLaSP0ksHPKXxTKukdTyG+kArbViPy81v+O6tQAxXcCPmt
X-Google-Smtp-Source: AGHT+IG/W+ANmtI8mbHwJEb2TuCODuEhRxkhywnn0f7YSwGVkBXyb6/O74haa8otGWRSFBt0B7VYew==
X-Received: by 2002:a05:6a00:1889:b0:6f3:e6ac:5703 with SMTP id x9-20020a056a00188900b006f3e6ac5703mr8378212pfh.0.1714576433686;
        Wed, 01 May 2024 08:13:53 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id x37-20020a056a000be500b006edcceffcb0sm22774182pfu.161.2024.05.01.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:53 -0700 (PDT)
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
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 18/39] sched_ext: Allow BPF schedulers to disallow specific tasks from joining SCHED_EXT
Date: Wed,  1 May 2024 05:09:53 -1000
Message-ID: <20240501151312.635565-19-tj@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
References: <20240501151312.635565-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF schedulers might not want to schedule certain tasks - e.g. kernel
threads. This patch adds p->scx.disallow which can be set by BPF schedulers
in such cases. The field can be changed anytime and setting it in
ops.prep_enable() guarantees that the task can never be scheduled by
sched_ext.

scx_qmap is updated with the -d option to disallow a specific PID:

  # echo $$
  1092
  # grep -E '(policy)|(ext\.enabled)' /proc/self/sched
  policy                                       :                    0
  ext.enabled                                  :                    0
  # ./set-scx 1092
  # grep -E '(policy)|(ext\.enabled)' /proc/self/sched
  policy                                       :                    7
  ext.enabled                                  :                    0

Run "scx_qmap -d 1092" in another terminal.

  # cat /sys/kernel/sched_ext/nr_rejected
  1
  # grep -E '(policy)|(ext\.enabled)' /proc/self/sched
  policy                                       :                    0
  ext.enabled                                  :                    1
  # ./set-scx 1092
  setparam failed for 1092 (Permission denied)

- v3: Update description to reflect /sys/kernel/sched_ext interface change.

- v2: Use atomic_long_t instead of atomic64_t for scx_kick_cpus_pnt_seqs to
      accommodate 32bit archs.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Barret Rhoden <brho@google.com>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h      | 12 ++++++++
 kernel/sched/core.c            |  4 +++
 kernel/sched/ext.c             | 50 ++++++++++++++++++++++++++++++++++
 kernel/sched/ext.h             |  2 ++
 tools/sched_ext/scx_qmap.bpf.c |  4 +++
 tools/sched_ext/scx_qmap.c     | 11 ++++++--
 6 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 6a5a10092fb3..2608a8f548db 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -137,6 +137,18 @@ struct sched_ext_entity {
 	 */
 	u64			slice;
 
+	/*
+	 * If set, reject future sched_setscheduler(2) calls updating the policy
+	 * to %SCHED_EXT with -%EACCES.
+	 *
+	 * If set from ops.init_task() and the task's policy is already
+	 * %SCHED_EXT, which can happen while the BPF scheduler is being loaded
+	 * or by inhering the parent's policy during fork, the task's policy is
+	 * rejected and forcefully reverted to %SCHED_NORMAL. The number of
+	 * such events are reported through /sys/kernel/debug/sched_ext::nr_rejected.
+	 */
+	bool			disallow;	/* reject switching into SCX */
+
 	/* cold fields */
 	/* must be the last field, see init_scx_entity() */
 	struct list_head	tasks_node;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5b921725e6b2..aae9c1297622 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7866,6 +7866,10 @@ static int __sched_setscheduler(struct task_struct *p,
 		goto unlock;
 	}
 
+	retval = scx_check_setscheduler(p, policy);
+	if (retval)
+		goto unlock;
+
 	/*
 	 * If not changing anything there's no need to proceed further,
 	 * but store a possible modification of reset_on_fork.
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 63f47a9e1262..8d2ff81e8dd4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -483,6 +483,8 @@ struct static_key_false scx_has_op[SCX_OPI_END] =
 static atomic_t scx_exit_kind = ATOMIC_INIT(SCX_EXIT_DONE);
 static struct scx_exit_info *scx_exit_info;
 
+static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
+
 /*
  * The maximum amount of time in jiffies that a task may be runnable without
  * being scheduled on a CPU. If this timeout is exceeded, it will trigger
@@ -2324,6 +2326,8 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 {
 	int ret;
 
+	p->scx.disallow = false;
+
 	if (SCX_HAS_OP(init_task)) {
 		struct scx_init_task_args args = {
 			.fork = fork,
@@ -2338,6 +2342,27 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 
 	scx_set_task_state(p, SCX_TASK_INIT);
 
+	if (p->scx.disallow) {
+		struct rq *rq;
+		struct rq_flags rf;
+
+		rq = task_rq_lock(p, &rf);
+
+		/*
+		 * We're either in fork or load path and @p->policy will be
+		 * applied right after. Reverting @p->policy here and rejecting
+		 * %SCHED_EXT transitions from scx_check_setscheduler()
+		 * guarantees that if ops.init_task() sets @p->disallow, @p can
+		 * never be in SCX.
+		 */
+		if (p->policy == SCHED_EXT) {
+			p->policy = SCHED_NORMAL;
+			atomic_long_inc(&scx_nr_rejected);
+		}
+
+		task_rq_unlock(rq, p, &rf);
+	}
+
 	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 	return 0;
 }
@@ -2541,6 +2566,18 @@ static void switched_from_scx(struct rq *rq, struct task_struct *p)
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
 static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
 
+int scx_check_setscheduler(struct task_struct *p, int policy)
+{
+	lockdep_assert_rq_held(task_rq(p));
+
+	/* if disallow, reject transitioning into SCX */
+	if (scx_enabled() && READ_ONCE(p->scx.disallow) &&
+	    p->policy != policy && policy == SCHED_EXT)
+		return -EACCES;
+
+	return 0;
+}
+
 /*
  * Omitted operations:
  *
@@ -2695,9 +2732,17 @@ static ssize_t scx_attr_switch_all_show(struct kobject *kobj,
 }
 SCX_ATTR(switch_all);
 
+static ssize_t scx_attr_nr_rejected_show(struct kobject *kobj,
+					 struct kobj_attribute *ka, char *buf)
+{
+	return sysfs_emit(buf, "%ld\n", atomic_long_read(&scx_nr_rejected));
+}
+SCX_ATTR(nr_rejected);
+
 static struct attribute *scx_global_attrs[] = {
 	&scx_attr_state.attr,
 	&scx_attr_switch_all.attr,
+	&scx_attr_nr_rejected.attr,
 	NULL,
 };
 
@@ -3157,6 +3202,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	atomic_set(&scx_exit_kind, SCX_EXIT_NONE);
 	scx_warned_zero_slice = false;
 
+	atomic_long_set(&scx_nr_rejected, 0);
+
 	/*
 	 * Keep CPUs stable during enable so that the BPF scheduler can track
 	 * online CPUs by watching ->on/offline_cpu() after ->init().
@@ -3456,6 +3503,9 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 		if (off >= offsetof(struct task_struct, scx.slice) &&
 		    off + size <= offsetofend(struct task_struct, scx.slice))
 			return SCALAR_VALUE;
+		if (off >= offsetof(struct task_struct, scx.disallow) &&
+		    off + size <= offsetofend(struct task_struct, scx.disallow))
+			return SCALAR_VALUE;
 	}
 
 	return -EACCES;
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 0a8717b306ba..2ea6c19d2462 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -35,6 +35,7 @@ void scx_pre_fork(struct task_struct *p);
 int scx_fork(struct task_struct *p);
 void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
+int scx_check_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(struct task_struct *p);
 void init_sched_ext_class(void);
 
@@ -81,6 +82,7 @@ static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
+static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline void init_sched_ext_class(void) {}
 static inline u32 scx_cpuperf_target(s32 cpu) { return 0; }
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 927c4cd8b218..e18f25017a0a 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -32,6 +32,7 @@ const volatile u64 slice_ns = SCX_SLICE_DFL;
 const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
 const volatile u32 dsp_batch;
+const volatile s32 disallow_tgid;
 const volatile bool switch_partial;
 
 u32 test_error_cnt;
@@ -244,6 +245,9 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
 		   struct scx_init_task_args *args)
 {
+	if (p->tgid == disallow_tgid)
+		p->scx.disallow = true;
+
 	/*
 	 * @p is new. Let's ensure that its task_ctx is available. We can sleep
 	 * in this function and the following will automatically use GFP_KERNEL.
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index bce3f826cd6f..d2b98ef3ead2 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -19,13 +19,15 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-b COUNT] [-p] [-v]\n"
+"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-b COUNT]\n"
+"       [-d PID] [-p] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
 "  -t COUNT      Stall every COUNT'th user thread\n"
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
 "  -b COUNT      Dispatch upto COUNT tasks together\n"
+"  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
@@ -57,7 +59,7 @@ int main(int argc, char **argv)
 
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:b:pvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:b:d:pvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -74,6 +76,11 @@ int main(int argc, char **argv)
 		case 'b':
 			skel->rodata->dsp_batch = strtoul(optarg, NULL, 0);
 			break;
+		case 'd':
+			skel->rodata->disallow_tgid = strtol(optarg, NULL, 0);
+			if (skel->rodata->disallow_tgid < 0)
+				skel->rodata->disallow_tgid = getpid();
+			break;
 		case 'p':
 			skel->rodata->switch_partial = true;
 			skel->struct_ops.qmap_ops->flags |= __COMPAT_SCX_OPS_SWITCH_PARTIAL;
-- 
2.44.0


