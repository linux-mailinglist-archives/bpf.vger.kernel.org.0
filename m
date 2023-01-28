Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C761D67F2FB
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjA1ATO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjA1ASQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:18:16 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AABD8B7BB;
        Fri, 27 Jan 2023 16:17:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b10so6154269pjo.1;
        Fri, 27 Jan 2023 16:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmNUXzdAjn+8g9pw3qJZQhYrmtjI+f2F3U/9NYvg2Vw=;
        b=o5+WMPXVXRBYK7dha0ku8Xa2C+kWCx+8oqvc0ixqooUm7Z2wyzoA8S/GNck3NAWdQL
         C35MhaaafwtZxDqbH0+te9gT7FKF29NTTczTCt1azcSL7ebadbcJJ5JHyvuHjR7uTylF
         jPyVCpDpUT7SPbM/jkLKpFUjnrceBsnr0XC9Q4XgCV8pHwl+MK+tJ0VajgnE0D7wAt+C
         36E7iDeuQg+ojmPTXKwTgMpEGEkC4bVlLyXR+IFdFN37tJHGjaD4kWDYnJUH6ynL3NWP
         hfsL0dQM3ptiR6hMyefsUqNCGsjnza494/netLp5Z6p0820/CxtnF3V+cooOE+P41VI+
         nOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KmNUXzdAjn+8g9pw3qJZQhYrmtjI+f2F3U/9NYvg2Vw=;
        b=p/BLZJQQmFDY9YwxxdywETDJqV6wFiHZJ0S/trLpCKWrKZy2JT8+HAEjPmLAev+Xt0
         ql/RNM9AeL7TOvj91sh96+Xq/CdQ5/gPMWFaqZe0B/ZchE1Ol1wIHZOTh1hv4P76G+CD
         PjZMruTFKGjy0A1TFsBhd62zWLAejQCjz4qia1ytfUmpcnBFRQtPo/7rDrZKDh9kiH9S
         foPYXakHNE720S4//toPBNCxPpfEdy5+wetw6XT4iOWIb0NyMahvGI694MHC9SA/WbZm
         kAA6a3oNvgbt1oUmjmyb5CxFEJYJ+2bhYDpRjfPf690wNXojSwvcAs/ZDSroxwauZP7b
         gK7g==
X-Gm-Message-State: AFqh2krfnV8J5cKOOuGkP2FXup4j6+rZFUyJfrQ14ilGIr/vSr+kIVZ6
        9Q8dPPjTAE5fkYA1+bELQ5Y=
X-Google-Smtp-Source: AMrXdXtpa1bh/evWVHS3slEWwNN6R3g9OijVJpkUYAJO20YYK02UcmY3gwDWxa22EHeRt2A811GQJw==
X-Received: by 2002:a05:6a20:6a92:b0:b8:7ef5:4308 with SMTP id bi18-20020a056a206a9200b000b87ef54308mr39732936pzb.23.1674865048967;
        Fri, 27 Jan 2023 16:17:28 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p6-20020a056a000a0600b00581013fcbe1sm3149608pfh.159.2023.01.27.16.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:28 -0800 (PST)
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
Subject: [PATCH 20/30] sched_ext: Make watchdog handle ops.dispatch() looping stall
Date:   Fri, 27 Jan 2023 14:16:29 -1000
Message-Id: <20230128001639.3510083-21-tj@kernel.org>
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
index 098edfc56a9b..9bc625676bbc 100644
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
@@ -1243,6 +1245,7 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 	struct scx_rq *scx_rq = &rq->scx;
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
+	int nr_loops = SCX_DSP_MAX_LOOPS;
 
 	lockdep_assert_rq_held(rq);
 
@@ -1297,6 +1300,20 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
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
index ec8c4ee7ef16..e968a9b341a4 100644
--- a/tools/sched_ext/scx_example_qmap.bpf.c
+++ b/tools/sched_ext/scx_example_qmap.bpf.c
@@ -25,6 +25,7 @@ const volatile u64 slice_ns = SCX_SLICE_DFL;
 const volatile bool switch_all;
 const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
+const volatile u32 dsp_inf_loop_after;
 const volatile s32 disallow_tgid;
 
 u32 test_error_cnt;
@@ -184,6 +185,22 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
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
index 30633122e6d5..820fe50bf43c 100644
--- a/tools/sched_ext/scx_example_qmap.c
+++ b/tools/sched_ext/scx_example_qmap.c
@@ -20,12 +20,13 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-a] [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-d PID]\n"
+"Usage: %s [-a] [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-d PID]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
 "  -t COUNT      Stall every COUNT'th user thread\n"
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
+"  -l COUNT      Trigger dispatch infinite looping after COUNT dispatches\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -h            Display this help and exit\n";
 
@@ -50,7 +51,7 @@ int main(int argc, char **argv)
 	skel = scx_example_qmap__open();
 	assert(skel);
 
-	while ((opt = getopt(argc, argv, "ahs:e:t:T:d:")) != -1) {
+	while ((opt = getopt(argc, argv, "ahs:e:t:T:l:d:")) != -1) {
 		switch (opt) {
 		case 'a':
 			skel->rodata->switch_all = true;
@@ -67,6 +68,9 @@ int main(int argc, char **argv)
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
2.39.1

