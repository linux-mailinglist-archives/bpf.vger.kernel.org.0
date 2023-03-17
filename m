Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6446BF44F
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjCQVg2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjCQVgU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:36:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B9B166C7;
        Fri, 17 Mar 2023 14:35:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso10421494pjb.3;
        Fri, 17 Mar 2023 14:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mk9CUHzVKpOlxfASIcLRI047WvC8d0hSApNZ1eNw/Uk=;
        b=WPIVV69RpJIbvGcLuqXOWfUgw/sU++b6jBanC0NTrMl5BvEFoEhWCO97W/svLCF3sw
         a8fxqxuvgaFJhJ9ENr6S89RkX2X5x4wziNjoKWYWrmVvInutTHfoo07ef/6ljf0R8GeH
         3FipStChOOk7IDKotVVuwLXMqI4AyMmPcdTK1riUWuldogFr38EMFyXmhHjENEZE+Mbh
         e+O3qFqU6BWK9S+rgksSFCE4NqdcgV5K0yOazwLALnHIqHRW9FLaEBQUYZS69/rn2YXL
         sfNzdQSpUOWCyDP+lqaT72P/c2fS8wM2LDSXl0ieue+1NlwtZtPaS4x4FwGqPAPJgGBc
         fcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mk9CUHzVKpOlxfASIcLRI047WvC8d0hSApNZ1eNw/Uk=;
        b=2JyUt9MyTzaKO5U2nbD/Xy83EeUykWtJsCxDHSMCabAKTG9rpo96Aq+2MqOcPSp8oS
         gsdgEZPotWkvc/mQmquODHM9nx4/8jr6Y7d2yD4Wpw4qLiD6mgcnOTyWQ+5LUIVggoq2
         3Onq0OoBO+asgahTSF3DxMObrrCLN/vKc2kH17ozgEHYg3/tv11fit6iHZL/jJzJdluc
         oatM+oLTtBQot5H3LskRnUNnWN10PHihkUJljW0uEHyX82bILhCKWwjfla+R4gS+sekS
         k3poyC2W2+MyPA7F6saS//q1Flt1Hr8+ASRDaYeFlD0I0daZxmgALlE1a0pbopMhZVK6
         8eLg==
X-Gm-Message-State: AO0yUKVkL2iqGkTuj3v4mDu9XOBuAxH+WcW4+ggvh0Bplc4wK9A5esTs
        ewPVOY+EJlGqp/yrxXSrwB0=
X-Google-Smtp-Source: AK7set8lM50/5c9PlIEBMvHNeacJDx2qZkNXtlgQQo1yAg0K7rZVYircLpf74FlRyWWiKRzinOOrpA==
X-Received: by 2002:a17:902:c40c:b0:19f:2dff:21a4 with SMTP id k12-20020a170902c40c00b0019f2dff21a4mr9713294plk.16.1679088859713;
        Fri, 17 Mar 2023 14:34:19 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b23-20020a170902d89700b0019c912c19d3sm1710371plz.62.2023.03.17.14.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:34:19 -0700 (PDT)
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
Subject: [PATCH 20/32] sched_ext: Make watchdog handle ops.dispatch() looping stall
Date:   Fri, 17 Mar 2023 11:33:21 -1000
Message-Id: <20230317213333.2174969-21-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The dispatch path retries if the local DSQ is still empty after
ops.dispatch() either dispatched or consumed a task. This is both out of
necessity and for convenience. It has to retry because the dispatch path
might lose the tasks to dequeue while the rq lock is released while trying
to migrate tasks across CPUs, and the retry mechanism makes ops.dispatch()
implementation easier as it only needs to make some forward progress each
iteration.

However, this makes it possible for ops.dispatch() to stall CPUs by
repeatedly dispatching ineligible tasks. If all CPUs are stalled that way,
the watchdog or sysrq handler can't run and the system can't be saved. Let's
address the issue by breaking out of the dispatch loop after 32 iterations.

It is unlikely but not impossible for ops.dispatch() to legitimately go over
the iteration limit. We want to come back to the dispatch path in such cases
as not doing so risks stalling the CPU by idling with runnable tasks
pending. As the previous task is still current in balance_scx(),
resched_curr() doesn't do anything - it will just get cleared. Let's instead
use scx_kick_bpf() which will trigger reschedule after switching to the next
task which will likely be the idle task.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 kernel/sched/ext.c                     | 17 +++++++++++++++++
 tools/sched_ext/scx_example_qmap.bpf.c | 17 +++++++++++++++++
 tools/sched_ext/scx_example_qmap.c     |  8 ++++++--
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d1f09ab51c4a..56fa5eed33ac 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9,6 +9,7 @@
 enum scx_internal_consts {
 	SCX_NR_ONLINE_OPS	= SCX_OP_IDX(init),
 	SCX_DSP_DFL_MAX_BATCH	= 32,
+	SCX_DSP_MAX_LOOPS	= 32,
 	SCX_WATCHDOG_MAX_TIMEOUT = 30 * HZ,
 };
 
@@ -168,6 +169,7 @@ static DEFINE_PER_CPU(struct scx_dsp_ctx, scx_dsp_ctx);
 
 void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
 		      u64 enq_flags);
+void scx_bpf_kick_cpu(s32 cpu, u64 flags);
 
 struct scx_task_iter {
 	struct sched_ext_entity		cursor;
@@ -1287,6 +1289,7 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 	struct scx_rq *scx_rq = &rq->scx;
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
+	int nr_loops = SCX_DSP_MAX_LOOPS;
 
 	lockdep_assert_rq_held(rq);
 
@@ -1341,6 +1344,20 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 			return 1;
 		if (consume_dispatch_q(rq, rf, &scx_dsq_global))
 			return 1;
+
+		/*
+		 * ops.dispatch() can trap us in this loop by repeatedly
+		 * dispatching ineligible tasks. Break out once in a while to
+		 * allow the watchdog to run. As IRQ can't be enabled in
+		 * balance(), we want to complete this scheduling cycle and then
+		 * start a new one. IOW, we want to call resched_curr() on the
+		 * next, most likely idle, task, not the current one. Use
+		 * scx_bpf_kick_cpu() for deferred kicking.
+		 */
+		if (unlikely(!--nr_loops)) {
+			scx_bpf_kick_cpu(cpu_of(rq), 0);
+			break;
+		}
 	} while (dspc->nr_tasks);
 
 	return 0;
diff --git a/tools/sched_ext/scx_example_qmap.bpf.c b/tools/sched_ext/scx_example_qmap.bpf.c
index abb134fb18ce..ed704a4024c0 100644
--- a/tools/sched_ext/scx_example_qmap.bpf.c
+++ b/tools/sched_ext/scx_example_qmap.bpf.c
@@ -28,6 +28,7 @@ const volatile u64 slice_ns = SCX_SLICE_DFL;
 const volatile bool switch_partial;
 const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
+const volatile u32 dsp_inf_loop_after;
 const volatile s32 disallow_tgid;
 
 u32 test_error_cnt;
@@ -187,6 +188,22 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	s32 pid;
 	int i;
 
+	if (dsp_inf_loop_after && nr_dispatched > dsp_inf_loop_after) {
+		struct task_struct *p;
+
+		/*
+		 * PID 2 should be kthreadd which should mostly be idle and off
+		 * the scheduler. Let's keep dispatching it to force the kernel
+		 * to call this function over and over again.
+		 */
+		p = bpf_task_from_pid(2);
+		if (p) {
+			scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, slice_ns, 0);
+			bpf_task_release(p);
+			return;
+		}
+	}
+
 	if (!idx || !cnt) {
 		scx_bpf_error("failed to lookup idx[%p], cnt[%p]", idx, cnt);
 		return;
diff --git a/tools/sched_ext/scx_example_qmap.c b/tools/sched_ext/scx_example_qmap.c
index f94fd39c4ed8..3f68dae47bd0 100644
--- a/tools/sched_ext/scx_example_qmap.c
+++ b/tools/sched_ext/scx_example_qmap.c
@@ -20,12 +20,13 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-d PID] [-p]\n"
+"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-d PID] [-p]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
 "  -t COUNT      Stall every COUNT'th user thread\n"
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
+"  -l COUNT      Trigger dispatch infinite looping after COUNT dispatches\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -h            Display this help and exit\n";
@@ -51,7 +52,7 @@ int main(int argc, char **argv)
 	skel = scx_example_qmap__open();
 	assert(skel);
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:d:ph")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:d:ph")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -65,6 +66,9 @@ int main(int argc, char **argv)
 		case 'T':
 			skel->rodata->stall_kernel_nth = strtoul(optarg, NULL, 0);
 			break;
+		case 'l':
+			skel->rodata->dsp_inf_loop_after = strtoul(optarg, NULL, 0);
+			break;
 		case 'd':
 			skel->rodata->disallow_tgid = strtol(optarg, NULL, 0);
 			if (skel->rodata->disallow_tgid < 0)
-- 
2.39.2

