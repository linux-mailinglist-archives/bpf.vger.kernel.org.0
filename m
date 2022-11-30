Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1480E63D082
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiK3I0O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiK3IZX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:25:23 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024DD6F807;
        Wed, 30 Nov 2022 00:24:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so1194547pje.5;
        Wed, 30 Nov 2022 00:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeRxkUtMHLuUFqMgF18Iov3Mm0w03j8sOh2D0fkG7OA=;
        b=g9whwIlDXn1gAn57uP4ayQTIZ3MxO29p26WHIkTYhqXN0IbpiDCF+mEdhTWoghYZ8N
         OkxSP2pE6rvgdR/iELyZXC0pKsC6gJvixv940sey3X8shr915VlvYN1itzp6TzWEVwBY
         OHoHUn/0bPuL36ql//W3BHrB0hGaeLEQ1hD5qgVUtE8VNu20iu6LXQknEYuyGpZGF64X
         Qf+EYt5RYOgyePeftfpU9i+OmLjTkxFmq8D47KBfwzg3FQctawGt3Bm9pMD+4Kl4KJ+P
         rPC2ICIucZHJEDBGDV10EMeZhFyKssPlJ1/u5DRPr4s7h74HuEovmgSLGoBrI2ZVH5Qs
         1Trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TeRxkUtMHLuUFqMgF18Iov3Mm0w03j8sOh2D0fkG7OA=;
        b=Lz0i7nMPro+6SrOKGfjgZ9FnrLPrW6koqTip+3LCG5a4qGP6r4ltLGJa2mUwwpZ2Qc
         HA/tn7SV+2rWaHYF1Tayzs4tlgD3KyCHuECsyloiE4MXo+OneClJPfXXNJOwCJisHcNI
         HpsV+jO9Z0YvdHWv2fxBEogm7W9rHpGiH/ACSY/UG1iFyo12fwQkjg59zz4gF0JPWqjc
         DahIlQPR3NFSgVMQ3521CdiOhssjRrAST0obO5jltUwyGq76aSG90JTM783vbO6asob9
         60lnDWImfmL4wj59CNnVFkRpbHieZRQqM6cRrMmvu+DJwifCgpINFk2Lt6iiRzIQCgKe
         XvPg==
X-Gm-Message-State: ANoB5pkc53DxMTnGVOKXaDLitgYvdpmxGVIJ6iJ7D8HVPWPba1XTVLoL
        JV0Cp+RO1zc2Ux+9snSQSHg=
X-Google-Smtp-Source: AA0mqf6mefq6GpDFMq05Kn+XBObUaj8OK0h0LXJbfOCd4ac/a8nw3NHFz5iV18RMVmHoXFAtXBm/VA==
X-Received: by 2002:a17:90b:784:b0:218:fa11:5f87 with SMTP id l4-20020a17090b078400b00218fa115f87mr32105256pjz.25.1669796658265;
        Wed, 30 Nov 2022 00:24:18 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id f131-20020a623889000000b00574ebfdc721sm837329pfa.16.2022.11.30.00.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:17 -0800 (PST)
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
Subject: [PATCH 19/31] sched_ext: Allow BPF schedulers to disallow specific tasks from joining SCHED_EXT
Date:   Tue, 29 Nov 2022 22:23:01 -1000
Message-Id: <20221130082313.3241517-20-tj@kernel.org>
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

BPF schedulers might not want to schedule certain tasks - e.g. kernel
threads. This patch adds p->scx.disallow which can be set by BPF schedulers
in such cases. The field can be changed anytime and setting it in
ops.prep_enable() guarantees that the task can never be scheduled by
sched_ext.

scx_example_qmap is updated with the -d option to disallow a specific PID:

  # echo $$
  1092
  # egrep '(policy)|(ext\.enabled)' /proc/self/sched
  policy                                       :                    0
  ext.enabled                                  :                    0
  # ./set-scx 1092
  # egrep '(policy)|(ext\.enabled)' /proc/self/sched
  policy                                       :                    7
  ext.enabled                                  :                    0

Run "scx_example_qmap -d 1092" in another terminal.

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
 include/linux/sched/ext.h              | 12 ++++++++
 kernel/sched/core.c                    |  4 +++
 kernel/sched/ext.c                     | 38 ++++++++++++++++++++++++++
 kernel/sched/ext.h                     |  3 ++
 tools/sched_ext/scx_example_qmap.bpf.c |  4 +++
 tools/sched_ext/scx_example_qmap.c     |  8 +++++-
 6 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 1a57945abea0..82dcbecfcfb9 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -397,6 +397,18 @@ struct sched_ext_entity {
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
index 39d9ccb64f40..3404277fed30 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7552,6 +7552,10 @@ static int __sched_setscheduler(struct task_struct *p,
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
index 030175f2b1d6..ddd5aa4a8bca 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1509,6 +1509,8 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
 
 	WARN_ON_ONCE(p->scx.flags & SCX_TASK_OPS_PREPPED);
 
+	p->scx.disallow = false;
+
 	if (SCX_HAS_OP(prep_enable)) {
 		struct scx_enable_args args = { };
 
@@ -1519,6 +1521,27 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
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
@@ -1664,6 +1687,18 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
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
@@ -2367,6 +2402,9 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 		if (off >= offsetof(struct task_struct, scx.slice) &&
 		    off + size <= offsetofend(struct task_struct, scx.slice))
 			return SCALAR_VALUE;
+		if (off >= offsetof(struct task_struct, scx.disallow) &&
+		    off + size <= offsetofend(struct task_struct, scx.disallow))
+			return SCALAR_VALUE;
 	}
 
 	if (atype == BPF_READ)
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index bda1d9c11486..0743a0536560 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -79,6 +79,7 @@ int scx_fork(struct task_struct *p);
 void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
 int balance_scx(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
+int scx_check_setscheduler(struct task_struct *p, int policy);
 void init_sched_ext_class(void);
 
 __printf(2, 3) void scx_ops_error_type(enum scx_exit_type type,
@@ -136,6 +137,8 @@ static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
 static inline int balance_scx(struct rq *rq, struct task_struct *prev,
 			      struct rq_flags *rf) { return 0; }
+static inline int scx_check_setscheduler(struct task_struct *p,
+					 int policy) { return 0; }
 static inline void init_sched_ext_class(void) {}
 static inline void scx_notify_sched_tick(void) {}
 
diff --git a/tools/sched_ext/scx_example_qmap.bpf.c b/tools/sched_ext/scx_example_qmap.bpf.c
index 9e0b6519c8a4..b6febc5dadbf 100644
--- a/tools/sched_ext/scx_example_qmap.bpf.c
+++ b/tools/sched_ext/scx_example_qmap.bpf.c
@@ -24,6 +24,7 @@ char _license[] SEC("license") = "GPL";
 const volatile u64 slice_ns = SCX_SLICE_DFL;
 const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
+const volatile s32 disallow_tgid;
 
 u32 test_error_cnt;
 
@@ -208,6 +209,9 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 s32 BPF_STRUCT_OPS(qmap_prep_enable, struct task_struct *p,
 		   struct scx_enable_args *args)
 {
+	if (p->tgid == disallow_tgid)
+		p->scx.disallow = true;
+
 	/*
 	 * @p is new. Let's ensure that its task_ctx is available. We can sleep
 	 * in this function and the following will automatically use GFP_KERNEL.
diff --git a/tools/sched_ext/scx_example_qmap.c b/tools/sched_ext/scx_example_qmap.c
index 34c764c38e19..99cc7169bd90 100644
--- a/tools/sched_ext/scx_example_qmap.c
+++ b/tools/sched_ext/scx_example_qmap.c
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
2.38.1

