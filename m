Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3BF67F2FA
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjA1ATM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjA1ASP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:18:15 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328858CE11;
        Fri, 27 Jan 2023 16:17:36 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s67so4252069pgs.3;
        Fri, 27 Jan 2023 16:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQBinvOSNBUqRTgAcPFdrMmOx4mlJq+YJiGICJK5s04=;
        b=hrk6PmOAd+boS58LO0yHar4BZT/Vq04lMGrOT+WoUkHmZaEj0rYYfPNngl2apE6BoN
         /MXgGn2/IG7k/FPPkfOgBMDT3G/g7Cv1gi05DMTrXVO8kk7FcsdNosLDeuGMs5upkSVw
         oFi8WqC+vIgGQzjag+z2dIZeQ9EBQok+ShPw9zASQPcy063CRJ+irp+GzbY4Y5MFeTSv
         1Is8pAF5nqxICKq6RcGs5v2TQYgSJFVjZCkqNdNpSxheW+6O2sqDfDjy+lF/I5pRW/ha
         d3CsyEH9FN+uPjSy9XYlN1BkCzaKUEFgISn13mcvZn6bGzZdwA9+3RE+Lk2fX4kdIMV7
         AzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XQBinvOSNBUqRTgAcPFdrMmOx4mlJq+YJiGICJK5s04=;
        b=DWOaVfcYuAgMJEhn1G3YrDjpenJBDk/lxJhn5Na52x/nlBuIpjdUq3s+Ye68H/GT2a
         hIIfZnwG1KVn/lfnwXKMWBI0gDC5TiGu7PFeizyuH8oSd8hK2QL8ok78zdI+cTCFjs7C
         g8hJBY+ffG/VurwY13F6CteZ3jDQWLs7YVyVZGTdjSbCVSwH5ZiCzTOLa+J8SdoxX2qr
         A820Vq/YIc6HGSJW0olTYXIsmQ5W/feICn8WA7hF9qZiQDCbhj9HdFZSsjLs5SR4G21/
         +1EeU1ae8sN13aVqDAoqAzfmyKazW6ALuFwAQn4Hqtw914its3N2eDmj0/WWpqea3rkI
         guEw==
X-Gm-Message-State: AO0yUKU81R03TYUpq6ksyrfCdbGTyzXW2N58Uv6zfAjo6p2LS665cVaS
        w1sRY3GkhdH7tcQw6qoCPrg=
X-Google-Smtp-Source: AK7set+tOVBV6u1YucVMwXfpmAXpleL/7VSTvnPsUqG6hXh8OLaqRTJ6c8Y5AMpjU0JjzJm1QGDobQ==
X-Received: by 2002:aa7:82c5:0:b0:593:6e2f:b859 with SMTP id f5-20020aa782c5000000b005936e2fb859mr1661708pfn.4.1674865043430;
        Fri, 27 Jan 2023 16:17:23 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h28-20020a056a00001c00b0059071156016sm3170691pfk.87.2023.01.27.16.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:23 -0800 (PST)
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
Subject: [PATCH 17/30] sched_ext: Allow BPF schedulers to disallow specific tasks from joining SCHED_EXT
Date:   Fri, 27 Jan 2023 14:16:26 -1000
Message-Id: <20230128001639.3510083-18-tj@kernel.org>
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
index 474a8c0a0b12..b4c4b83a07f6 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -399,6 +399,18 @@ struct sched_ext_entity {
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
index 3f177c161c1e..9e566e72c3f2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7598,6 +7598,10 @@ static int __sched_setscheduler(struct task_struct *p,
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
index 1af74ea8ed42..b9d55c25cec9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1641,6 +1641,8 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
 
 	WARN_ON_ONCE(p->scx.flags & SCX_TASK_OPS_PREPPED);
 
+	p->scx.disallow = false;
+
 	if (SCX_HAS_OP(prep_enable)) {
 		struct scx_enable_args args = { };
 
@@ -1651,6 +1653,27 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
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
@@ -1796,6 +1819,18 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
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
@@ -2479,6 +2514,9 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 		if (off >= offsetof(struct task_struct, scx.slice) &&
 		    off + size <= offsetofend(struct task_struct, scx.slice))
 			return SCALAR_VALUE;
+		if (off >= offsetof(struct task_struct, scx.disallow) &&
+		    off + size <= offsetofend(struct task_struct, scx.disallow))
+			return SCALAR_VALUE;
 	}
 
 	if (atype == BPF_READ)
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 7dfa7b888487..76c94babd19e 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -67,6 +67,7 @@ void scx_pre_fork(struct task_struct *p);
 int scx_fork(struct task_struct *p);
 void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
+int scx_check_setscheduler(struct task_struct *p, int policy);
 void init_sched_ext_class(void);
 
 __printf(2, 3) void scx_ops_error_type(enum scx_exit_type type,
@@ -121,6 +122,8 @@ static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
+static inline int scx_check_setscheduler(struct task_struct *p,
+					 int policy) { return 0; }
 static inline void init_sched_ext_class(void) {}
 static inline void scx_notify_sched_tick(void) {}
 
diff --git a/tools/sched_ext/scx_example_qmap.bpf.c b/tools/sched_ext/scx_example_qmap.bpf.c
index b22b8d82846e..46bc16ed301f 100644
--- a/tools/sched_ext/scx_example_qmap.bpf.c
+++ b/tools/sched_ext/scx_example_qmap.bpf.c
@@ -24,6 +24,7 @@ char _license[] SEC("license") = "GPL";
 const volatile u64 slice_ns = SCX_SLICE_DFL;
 const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
+const volatile s32 disallow_tgid;
 
 u32 test_error_cnt;
 
@@ -221,6 +222,9 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
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
index dd490a146b1a..dff9323dfd20 100644
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
2.39.1

