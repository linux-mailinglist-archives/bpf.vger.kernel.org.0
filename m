Return-Path: <bpf+bounces-32447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 711A990DE33
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C671F21A10
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4B18EFE5;
	Tue, 18 Jun 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk5bEBAp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E94517966F;
	Tue, 18 Jun 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745693; cv=none; b=EuZo/d/3G0Weo0M0+W4RE3cmYGJD84Kyr7wdSzlB17F5cEHx2qjO/qaxFkj/2sewd7+p+OS4yy/+F+Qd5j7OUZUwAsgrKI9BtlYK8ki/B9Gx0TecliJzalzGyYpZKmhcVWG4G77G9EpRP0bJq5Dr70WVvdeXoGFPXkKLdcIXAH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745693; c=relaxed/simple;
	bh=NVtuhmD5qkkKR8hTFNL9KWL3HrWGAH/j+eE1vG9vbUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elV2c2IAhBTzMpXL527bE0QcsOzQpNAVgPWQe3ghU5AkgVjydtu1T3bLGh1oe+q1fg8Z3gj1bX2SSbBzV0W8d820Ix6W6ULn4ST0Yjl8sYIuSc6AdbbxNy3NDGxwcFlbNnghs9zW7Qi6lH1ZoYXcgW+llOn96eyz/xyMyyxpwJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk5bEBAp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7046211e455so4271386b3a.3;
        Tue, 18 Jun 2024 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745690; x=1719350490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eheGkzhhj7NDyOhT2V44W7D5tLTQgeESmDFvuhj5/IU=;
        b=fk5bEBApi4eSfWqTh6t1hBNqZMBc5d+FYVPKPyiixuNeht+/sF2w6yKEtJ0mAABJ3C
         ovuNT4Eu82W+7z3EJdGGnb5MdB6npDPYox0cKGxdj3YgKjXmenSF5t2/fJe+ZYpQTAod
         eL3x5Tn1xQj+2bzdCrn6H0pWKawW5sRlPtXEz342vcukz6N4Z3qiKEtjZ/q/7TQOm5l+
         2G65MJMWseNGXraufEuVkK6aenWWsLzwqqJkAvt8jZcZD0k/nx0h2Jn8Ue+W6hwiZHCl
         UPTj/+ZHpRokh9KYcMQFn/inf4r+w6qvZwODzAcPnZzwlJHzYmIjJbEA1Z9dEmNqaMNd
         h5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745690; x=1719350490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eheGkzhhj7NDyOhT2V44W7D5tLTQgeESmDFvuhj5/IU=;
        b=fwAr2TqJIl0WDsZBRV78tfPz5wEwbxAhmClkwC4URva0nFZejadksVN8NS24xsdI1k
         3R1WwotxnoYD1pjKRaxjnlg7pHi7JsC8ba7/Bo/06aHN5Zx3ULzz2xSwV08fX9il1pp4
         bVsaDmqiIPuygdqHxG000yfLKWDab5zeiHSACsp+pUsWQlUWGbkxtG7L41UtxYCKQlyN
         viaXCmxHGa/Y3nlO3YntQNsdYdkDfOL3wfo0BM/6MRbk+ra0S84eqJinKSjB3uyQcPAe
         xrC8GQEgVsvvjleg3IVou8k8bAwPLiUEt6jiDHNAG1AfwGrIrQ4jDJd6DBGoguJu+WEv
         slwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDqMeZ6COrO6Rq4NltcxWXPvjp4AcD2CQSK2pjYR3cFRiIR78H0jknIHf38vdWF7Uw9Q7DZu8d3XOGCBXMnOe6mvud
X-Gm-Message-State: AOJu0YyIQ9iknIwSw0+KAbouacyP5/khSlU140rgzuJ1KzO/ikqdsOdD
	C0DP3AMI+1yF4UkC3bQwvBc8Fway64u9PVSYuqGnyQ+bKHR4ibl7
X-Google-Smtp-Source: AGHT+IHRwmUnVWieA+HPqeMA94SH8RdY3DxBQ+/P8duoVnXwbfUZkxqJQrJsLd2I7Qe24MwILuaeYg==
X-Received: by 2002:a17:90a:c682:b0:2c3:1937:3042 with SMTP id 98e67ed59e1d1-2c7b59fa634mr922325a91.5.1718745689797;
        Tue, 18 Jun 2024 14:21:29 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45f68e4sm11370657a91.28.2024.06.18.14.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:29 -0700 (PDT)
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
Subject: [PATCH 13/30] sched_ext: Allow BPF schedulers to disallow specific tasks from joining SCHED_EXT
Date: Tue, 18 Jun 2024 11:17:28 -1000
Message-ID: <20240618212056.2833381-14-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
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

Run "scx_qmap -p -d 1092" in another terminal.

  # cat /sys/kernel/sched_ext/nr_rejected
  1
  # grep -E '(policy)|(ext\.enabled)' /proc/self/sched
  policy                                       :                    0
  ext.enabled                                  :                    0
  # ./set-scx 1092
  setparam failed for 1092 (Permission denied)

- v4: Refreshed on top of tip:sched/core.

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
 kernel/sched/ext.c             | 50 ++++++++++++++++++++++++++++++++++
 kernel/sched/ext.h             |  2 ++
 kernel/sched/syscalls.c        |  4 +++
 tools/sched_ext/scx_qmap.bpf.c |  4 +++
 tools/sched_ext/scx_qmap.c     | 11 ++++++--
 6 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 96031252436f..ea7c501ac819 100644
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
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3dc515b3351f..8ff30b80e862 100644
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
@@ -2332,6 +2334,8 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 {
 	int ret;
 
+	p->scx.disallow = false;
+
 	if (SCX_HAS_OP(init_task)) {
 		struct scx_init_task_args args = {
 			.fork = fork,
@@ -2346,6 +2350,27 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 
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
@@ -2549,6 +2574,18 @@ static void switched_from_scx(struct rq *rq, struct task_struct *p)
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
@@ -2703,9 +2740,17 @@ static ssize_t scx_attr_switch_all_show(struct kobject *kobj,
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
 
@@ -3178,6 +3223,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	atomic_set(&scx_exit_kind, SCX_EXIT_NONE);
 	scx_warned_zero_slice = false;
 
+	atomic_long_set(&scx_nr_rejected, 0);
+
 	/*
 	 * Keep CPUs stable during enable so that the BPF scheduler can track
 	 * online CPUs by watching ->on/offline_cpu() after ->init().
@@ -3476,6 +3523,9 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 		if (off >= offsetof(struct task_struct, scx.slice) &&
 		    off + size <= offsetofend(struct task_struct, scx.slice))
 			return SCALAR_VALUE;
+		if (off >= offsetof(struct task_struct, scx.disallow) &&
+		    off + size <= offsetofend(struct task_struct, scx.disallow))
+			return SCALAR_VALUE;
 	}
 
 	return -EACCES;
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 56fcdb0b2c05..33a9f7fe5832 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -35,6 +35,7 @@ void scx_pre_fork(struct task_struct *p);
 int scx_fork(struct task_struct *p);
 void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
+int scx_check_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(struct task_struct *p);
 void init_sched_ext_class(void);
 
@@ -72,6 +73,7 @@ static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
+static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline void init_sched_ext_class(void) {}
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 18d44d180db1..4fa59c9f69ac 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -714,6 +714,10 @@ int __sched_setscheduler(struct task_struct *p,
 		goto unlock;
 	}
 
+	retval = scx_check_setscheduler(p, policy);
+	if (retval)
+		goto unlock;
+
 	/*
 	 * If not changing anything there's no need to proceed further,
 	 * but store a possible modification of reset_on_fork.
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 8beae08dfdc7..5ff217c4bfa0 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -32,6 +32,7 @@ const volatile u64 slice_ns = SCX_SLICE_DFL;
 const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
 const volatile u32 dsp_batch;
+const volatile s32 disallow_tgid;
 
 u32 test_error_cnt;
 
@@ -243,6 +244,9 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
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
index 6e9e9726cd62..a2614994cfaa 100644
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
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_SWITCH_PARTIAL;
 			break;
-- 
2.45.2


