Return-Path: <bpf+bounces-14850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B39197E88A3
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFD41F20F78
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10855258;
	Sat, 11 Nov 2023 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5VnCXzx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C87615B8
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:51:44 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5C64C27;
	Fri, 10 Nov 2023 18:49:27 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1f055438492so1511563fac.3;
        Fri, 10 Nov 2023 18:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670966; x=1700275766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbJyk8Se0g0ZLIJL7NAOIYPUw+pRNH8PHA5+GCmAHCE=;
        b=E5VnCXzx2NCfxv4HWLmpbD5HKSwTD5SzruFj5ceFdrVQt76Wer8tapXJw8p1hiaGWI
         gYeGcWWAsC75SPXeloNReamEelw9j+UUgWTgcI5KLc4JLexOLGILEBugs9TgKAly5e6y
         60fhY4tcBmKZJZH41E7KuO2YBrKX8qhBZgi7UtMVoMZvs68NVjucQbdmoN6sylA84RXM
         OeGqL5fpOtCf7EVY7hbw5aInZAtegq7MB1IqZQ1tPhxRMxdyBTbtLXlsVav6hbjtW39L
         89shFCYAB2qTa1igCflJb2n6KcTh6xroL6FYVbhmC0a8GhYQ2iOw+AGCgxjISiNM6d8o
         cyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670966; x=1700275766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VbJyk8Se0g0ZLIJL7NAOIYPUw+pRNH8PHA5+GCmAHCE=;
        b=ToSpup2dQgcd2N+lwnwp7G2lB2TXACybpul/noLHIbEHg7m95Q+EJF61CsJbN16LvW
         uNPlEebr4ODkjiQ734KvG7ExXAW++QkL9Xlm0AQpygvHbjsaq+ufPuZpjBG/JO4vA+Qz
         A38Q0jEw3iIE8QgYGj52ZrvwikfKgnVZ3r2QrTVjm07LvIeD5NLA7JpCV+0zy6TMVVRd
         4IqfYb9qDVx2N+HsvvnFnKUo6803IpzFBi4bvqQgJ7XO34r6w/uaUcVvQLOmPiNaCQ32
         28cQKG3bDO3rO3e1THjl7oLoI0ybDSZJlkdZiGhUvERd5SaZQUZVFtZRTMhFUboVDMyD
         7RUA==
X-Gm-Message-State: AOJu0Yyf9/AEmTYWvUWfrhoveUDVlmslb01GLBcOJXpynKQCPurMKRhq
	aL7dVW4v4erpFeuzfCIUI8E=
X-Google-Smtp-Source: AGHT+IGKykYwZ5Y2H8QB+C93WxjNufePRhpo0JvnLzoUlprAjCqO9FiU0OTvJBY7y2Sliv3dfr85jA==
X-Received: by 2002:a05:6871:4509:b0:1ea:137:7dba with SMTP id nj9-20020a056871450900b001ea01377dbamr1444135oab.10.1699670966128;
        Fri, 10 Nov 2023 18:49:26 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id s20-20020a62e714000000b006bc3e8f58besm396702pfh.56.2023.11.10.18.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:25 -0800 (PST)
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
Subject: [PATCH 16/36] sched_ext: Allow BPF schedulers to disallow specific tasks from joining SCHED_EXT
Date: Fri, 10 Nov 2023 16:47:42 -1000
Message-ID: <20231111024835.2164816-17-tj@kernel.org>
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

BPF schedulers might not want to schedule certain tasks - e.g. kernel
threads. This patch adds p->scx.disallow which can be set by BPF schedulers
in such cases. The field can be changed anytime and setting it in
ops.prep_enable() guarantees that the task can never be scheduled by
sched_ext.

scx_qmap is updated with the -d option to disallow a specific PID:

  # echo $$
  1092
  # egrep '(policy)|(ext\.enabled)' /proc/self/sched
  policy                                       :                    0
  ext.enabled                                  :                    0
  # ./set-scx 1092
  # egrep '(policy)|(ext\.enabled)' /proc/self/sched
  policy                                       :                    7
  ext.enabled                                  :                    0

Run "scx_qmap -d 1092" in another terminal.

  # grep rejected /sys/kernel/debug/sched/ext
  nr_rejected                   : 1
  # egrep '(policy)|(ext\.enabled)' /proc/self/sched
  policy                                       :                    0
  ext.enabled                                  :                    0
  # ./set-scx 1092
  setparam failed for 1092 (Permission denied)

* v2: Use atomic_long_t instead of atomic64_t for scx_kick_cpus_pnt_seqs to
  accommodate 32bit archs.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Barret Rhoden <brho@google.com>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h      | 12 ++++++++++
 kernel/sched/core.c            |  4 ++++
 kernel/sched/ext.c             | 44 ++++++++++++++++++++++++++++++++++
 kernel/sched/ext.h             |  3 +++
 tools/sched_ext/scx_qmap.bpf.c |  4 ++++
 tools/sched_ext/scx_qmap.c     |  8 ++++++-
 6 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index ec85415431d9..9d41acaf89c0 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -411,6 +411,18 @@ struct sched_ext_entity {
 	 */
 	u64			slice;
 
+	/*
+	 * If set, reject future sched_setscheduler(2) calls updating the policy
+	 * to %SCHED_EXT with -%EACCES.
+	 *
+	 * If set from ops.prep_enable() and the task's policy is already
+	 * %SCHED_EXT, which can happen while the BPF scheduler is being loaded
+	 * or by inhering the parent's policy during fork, the task's policy is
+	 * rejected and forcefully reverted to %SCHED_NORMAL. The number of such
+	 * events are reported through /sys/kernel/debug/sched_ext::nr_rejected.
+	 */
+	bool			disallow;	/* reject switching into SCX */
+
 	/* cold fields */
 	struct list_head	tasks_node;
 };
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c2ce0e8ac407..6b8883fedf33 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7809,6 +7809,10 @@ static int __sched_setscheduler(struct task_struct *p,
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
index 37a0f9c148d9..025b6103b87d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -93,6 +93,8 @@ struct static_key_false scx_has_op[SCX_NR_ONLINE_OPS] =
 static atomic_t scx_exit_kind = ATOMIC_INIT(SCX_EXIT_DONE);
 static struct scx_exit_info scx_exit_info;
 
+static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
+
 /*
  * The maximum amount of time in jiffies that a task may be runnable without
  * being scheduled on a CPU. If this timeout is exceeded, it will trigger
@@ -1725,6 +1727,8 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
 
 	WARN_ON_ONCE(p->scx.flags & SCX_TASK_OPS_PREPPED);
 
+	p->scx.disallow = false;
+
 	if (SCX_HAS_OP(prep_enable)) {
 		struct scx_enable_args args = { };
 
@@ -1735,6 +1739,27 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
 		}
 	}
 
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
+		 * guarantees that if ops.prep_enable() sets @p->disallow, @p
+		 * can never be in SCX.
+		 */
+		if (p->policy == SCHED_EXT) {
+			p->policy = SCHED_NORMAL;
+			atomic_long_inc(&scx_nr_rejected);
+		}
+
+		task_rq_unlock(rq, p, &rf);
+	}
+
 	p->scx.flags |= (SCX_TASK_OPS_PREPPED | SCX_TASK_WATCHDOG_RESET);
 	return 0;
 }
@@ -1896,6 +1921,18 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
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
@@ -2333,6 +2370,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	atomic_set(&scx_exit_kind, SCX_EXIT_NONE);
 	scx_warned_zero_slice = false;
 
+	atomic_long_set(&scx_nr_rejected, 0);
+
 	/*
 	 * Keep CPUs stable during enable so that the BPF scheduler can track
 	 * online CPUs by watching ->on/offline_cpu() after ->init().
@@ -2521,6 +2560,8 @@ static int scx_debug_show(struct seq_file *m, void *v)
 	seq_printf(m, "%-30s: %ld\n", "enabled", scx_enabled());
 	seq_printf(m, "%-30s: %s\n", "enable_state",
 		   scx_ops_enable_state_str[scx_ops_enable_state()]);
+	seq_printf(m, "%-30s: %lu\n", "nr_rejected",
+		   atomic_long_read(&scx_nr_rejected));
 	mutex_unlock(&scx_ops_enable_mutex);
 	return 0;
 }
@@ -2574,6 +2615,9 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 		if (off >= offsetof(struct task_struct, scx.slice) &&
 		    off + size <= offsetofend(struct task_struct, scx.slice))
 			return SCALAR_VALUE;
+		if (off >= offsetof(struct task_struct, scx.disallow) &&
+		    off + size <= offsetofend(struct task_struct, scx.disallow))
+			return SCALAR_VALUE;
 	}
 
 	return -EACCES;
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index c4da4e2838fd..bd283ee54da7 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -87,6 +87,7 @@ void scx_pre_fork(struct task_struct *p);
 int scx_fork(struct task_struct *p);
 void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
+int scx_check_setscheduler(struct task_struct *p, int policy);
 void init_sched_ext_class(void);
 
 __printf(2, 3) void scx_ops_error_kind(enum scx_exit_kind kind,
@@ -142,6 +143,8 @@ static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
+static inline int scx_check_setscheduler(struct task_struct *p,
+					 int policy) { return 0; }
 static inline void init_sched_ext_class(void) {}
 static inline void scx_notify_sched_tick(void) {}
 
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index a1bdb5774a63..d0bc67095062 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -27,6 +27,7 @@ char _license[] SEC("license") = "GPL";
 const volatile u64 slice_ns = SCX_SLICE_DFL;
 const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
+const volatile s32 disallow_tgid;
 
 u32 test_error_cnt;
 
@@ -224,6 +225,9 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 s32 BPF_STRUCT_OPS(qmap_prep_enable, struct task_struct *p,
 		   struct scx_enable_args *args)
 {
+	if (p->tgid == disallow_tgid)
+		p->scx.disallow = true;
+
 	/*
 	 * @p is new. Let's ensure that its task_ctx is available. We can sleep
 	 * in this function and the following will automatically use GFP_KERNEL.
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 711827b38578..6002cef833ab 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -18,12 +18,13 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT]\n"
+"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-d PID]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
 "  -t COUNT      Stall every COUNT'th user thread\n"
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
+"  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -h            Display this help and exit\n";
 
 static volatile int exit_req;
@@ -61,6 +62,11 @@ int main(int argc, char **argv)
 		case 'T':
 			skel->rodata->stall_kernel_nth = strtoul(optarg, NULL, 0);
 			break;
+		case 'd':
+			skel->rodata->disallow_tgid = strtol(optarg, NULL, 0);
+			if (skel->rodata->disallow_tgid < 0)
+				skel->rodata->disallow_tgid = getpid();
+			break;
 		default:
 			fprintf(stderr, help_fmt, basename(argv[0]));
 			return opt != 'h';
-- 
2.42.0


