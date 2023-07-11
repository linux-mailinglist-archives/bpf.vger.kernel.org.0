Return-Path: <bpf+bounces-4679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F6E74E343
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2629280B40
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BAD23D1;
	Tue, 11 Jul 2023 01:15:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748023A5
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:15:30 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42F0199B;
	Mon, 10 Jul 2023 18:14:49 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-38e04d1b2b4so3934641b6e.3;
        Mon, 10 Jul 2023 18:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038088; x=1691630088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kSrayQ1p+/VxaFaqQwEWdvfj02IvPJmrQ1NhKcaonM=;
        b=o0m7xT+ML6pNuRNz02LHIN7YMyHT+GWHsJXcQrMAoR3bbuBncyRanhV85bqSE8dlrU
         fI+BQW1uyH2SbrQfBwf+f8DA/tfB/+NYeYzZjcZaq+FubTADxdU7/IlMDFo1Tmqidi83
         XotIeFPWEyHxDN/HpKbxEizJ6eZhkzfET3Nkuw4USqtwpE9LjyDN+UL1FVb5R2Ybem4n
         Dv20yEl/yNCAT1ljCkdmDQDb2BaHaUhtnVbRm6BjdFNp1hpYVudg6EU4biQimsozyegF
         cWaoLmTWHYEZtqCx/fWzqsRxKoUeFzwNk80UuSMBs0kIor9H/od7yW0gGK6PX4+jvx6x
         HQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038088; x=1691630088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0kSrayQ1p+/VxaFaqQwEWdvfj02IvPJmrQ1NhKcaonM=;
        b=BMuzGKageohSzgJvSqbeRZWNY3m6qxvn4ChrtFGuV1CIeUWHT7qbOvybdYQpZnbi4S
         mSHnh78qtGcGnIK5lcWMDbfL0yI46Ey+0H+2zL8N7Gu+z97ryYxeooDPwdJ8mfNN/4cB
         2gqjT//L4Z8Mp6XImm+mXJlfsSeeNUdGcTqQJSoc4Kj+ICG0qW+bRA9g1etyq3GOyPp0
         B96L/6kr1R+kDv1tlXDuCwdnRm1ucrahdpsM+sDdHaRAHPbbHxuowtONHqastAsx3cnx
         SLfdQ4xEU9egv8VSGKm6ml40Z6Azp9aJ5UfHHzJufzeuckPlKTSxrd73xQVi/4DE6rdn
         696Q==
X-Gm-Message-State: ABy/qLYOJWrehyyg/RLfc9xo1We0ij4VN+TQVQSPrxiLd+44PCPBmPb/
	jt5FkXEFqhzFDQMBY2YwjuE=
X-Google-Smtp-Source: APBJJlFODr5Ee/omcPQC6vhVts68bSnMbfEECuNpDhzc8CVeKLCGyS2ir+3UE7mCpmAL9qo+p13Wrg==
X-Received: by 2002:a05:6808:ecd:b0:3a3:47c5:1de3 with SMTP id q13-20020a0568080ecd00b003a347c51de3mr14301319oiv.49.1689038088500;
        Mon, 10 Jul 2023 18:14:48 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id 18-20020aa79212000000b0064fd4a6b306sm405629pfo.76.2023.07.10.18.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:48 -0700 (PDT)
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
	riel@surriel.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 16/34] sched_ext: Allow BPF schedulers to disallow specific tasks from joining SCHED_EXT
Date: Mon, 10 Jul 2023 15:13:34 -1000
Message-ID: <20230711011412.100319-17-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Barret Rhoden <brho@google.com>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h      | 12 +++++++++++
 kernel/sched/core.c            |  4 ++++
 kernel/sched/ext.c             | 38 ++++++++++++++++++++++++++++++++++
 kernel/sched/ext.h             |  3 +++
 tools/sched_ext/scx_qmap.bpf.c |  4 ++++
 tools/sched_ext/scx_qmap.c     |  8 ++++++-
 6 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 1588e4496afa..772d84033155 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -410,6 +410,18 @@ struct sched_ext_entity {
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
index 9d97c0e6442a..c8528cbfeb57 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7725,6 +7725,10 @@ static int __sched_setscheduler(struct task_struct *p,
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
index eca1790375b8..d5ef8809e05f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1715,6 +1715,8 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
 
 	WARN_ON_ONCE(p->scx.flags & SCX_TASK_OPS_PREPPED);
 
+	p->scx.disallow = false;
+
 	if (SCX_HAS_OP(prep_enable)) {
 		struct scx_enable_args args = { };
 
@@ -1725,6 +1727,27 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
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
+			atomic64_inc(&scx_nr_rejected);
+		}
+
+		task_rq_unlock(rq, p, &rf);
+	}
+
 	p->scx.flags |= (SCX_TASK_OPS_PREPPED | SCX_TASK_WATCHDOG_RESET);
 	return 0;
 }
@@ -1886,6 +1909,18 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 static void check_preempt_curr_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
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
@@ -2568,6 +2603,9 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 		if (off >= offsetof(struct task_struct, scx.slice) &&
 		    off + size <= offsetofend(struct task_struct, scx.slice))
 			return SCALAR_VALUE;
+		if (off >= offsetof(struct task_struct, scx.disallow) &&
+		    off + size <= offsetofend(struct task_struct, scx.disallow))
+			return SCALAR_VALUE;
 	}
 
 	return 0;
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index e6e7869c6f8d..444a917d27b1 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -87,6 +87,7 @@ void scx_pre_fork(struct task_struct *p);
 int scx_fork(struct task_struct *p);
 void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
+int scx_check_setscheduler(struct task_struct *p, int policy);
 void init_sched_ext_class(void);
 
 __printf(2, 3) void scx_ops_error_type(enum scx_exit_type type,
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
index 93add1156def..5f50f889ea18 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -20,12 +20,13 @@ const char help_fmt[] =
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
@@ -63,6 +64,11 @@ int main(int argc, char **argv)
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
2.41.0


