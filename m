Return-Path: <bpf+bounces-4683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBC774E34E
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1871C20CD8
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63363322A;
	Tue, 11 Jul 2023 01:15:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70628EC
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:15:53 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF88CE58;
	Mon, 10 Jul 2023 18:15:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b9e8e5b12dso7514715ad.3;
        Mon, 10 Jul 2023 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038096; x=1691630096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13hxfRv8XtxpRnNvWAWpRa+TQaiIpqIrlB/2A7e8Lxw=;
        b=rrSgMSg9Kpk0ghvvYoTiNAusyGLItLZ0uyFsqFsp0drd2mM09nlHq7Bp78UrjcS2vK
         AM52gujpa0My00ZGvW7/dOkrK57uroMryP0mQLPwYt9S5ENjYZLZpwM3ruTIwbMvV+4x
         CDJW9t0HkwXXHSJyMm7xhAM1qYwT/nCvGZb5w+Vbf0uXPDksnlp5K7NQXX5AnwudXvUn
         2f9ZMCZgvpflcFiN73NVvBtcf+aytAzJFILZKMEklPC32UFAU0BXA2aVt4gitfgKNORB
         lRd8WJqcEeDwdlfXIwDi3QIv8YPBFgyIMLYExd9s6GsyXnSZOqB2PODbIVhIyMAXAyZf
         TPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038096; x=1691630096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=13hxfRv8XtxpRnNvWAWpRa+TQaiIpqIrlB/2A7e8Lxw=;
        b=CvCYUPkXfz+x4S0TwJuXye9kP01Oi5escj7OjRA8yFn/BnqLxV4mCWFmX7GjmtwZQO
         RdHpyi7Yfz1A4pt+kuGhM1QgIB35madQrAWtN4cxDDmRuFc5uTidpJmzsWLijYqZ6ZG8
         osraLg0ikzbkweNK+sAtOE4kJdkgq0/SdNiew1DTMM4QeMyi0kbX+nOL2RPlvwGkIcWM
         b0l1zrp5W57pIxiDN3rJO+TIAChItBJwsUSmkn+moG6SUcqrl9AlFQLDvhGXitBlXWTR
         qEuT2Mer7FUy39YIxp4Q8SSLZvDysW2xMR/65gPPaMnL7/q2OIEBDvqbmY10PM1147pD
         afkQ==
X-Gm-Message-State: ABy/qLZ+VshipeehBbkpjpIvRggHIRLwpmnRks9qIAO8rIh1IJDysTa1
	yxnnYNIK0/sXUtiWv/cOB1Q=
X-Google-Smtp-Source: APBJJlFt5iHiJorQmt7upQG910T0ZSR6MR1YNp7VWJdmAlmFAVcDCAJ27pqJvePLdOKC2mQaidadXw==
X-Received: by 2002:a17:902:db0a:b0:1b8:a19e:a3d3 with SMTP id m10-20020a170902db0a00b001b8a19ea3d3mr19702067plx.52.1689038096353;
        Mon, 10 Jul 2023 18:14:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902da8d00b001ac95be5081sm488891plx.307.2023.07.10.18.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:55 -0700 (PDT)
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
Subject: [PATCH 20/34] sched_ext: Make watchdog handle ops.dispatch() looping stall
Date: Mon, 10 Jul 2023 15:13:38 -1000
Message-ID: <20230711011412.100319-21-tj@kernel.org>
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
 kernel/sched/ext.c             | 17 +++++++++++++++++
 tools/sched_ext/scx_qmap.bpf.c | 17 +++++++++++++++++
 tools/sched_ext/scx_qmap.c     |  8 ++++++--
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9e8f9f9fcb3d..48e27d59e621 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9,6 +9,7 @@
 enum scx_internal_consts {
 	SCX_NR_ONLINE_OPS	= SCX_OP_IDX(init),
 	SCX_DSP_DFL_MAX_BATCH	= 32,
+	SCX_DSP_MAX_LOOPS	= 32,
 	SCX_WATCHDOG_MAX_TIMEOUT = 30 * HZ,
 };
 
@@ -167,6 +168,7 @@ static DEFINE_PER_CPU(struct scx_dsp_ctx, scx_dsp_ctx);
 
 void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
 		      u64 enq_flags);
+void scx_bpf_kick_cpu(s32 cpu, u64 flags);
 
 struct scx_task_iter {
 	struct sched_ext_entity		cursor;
@@ -1286,6 +1288,7 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 	struct scx_rq *scx_rq = &rq->scx;
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
+	int nr_loops = SCX_DSP_MAX_LOOPS;
 
 	lockdep_assert_rq_held(rq);
 
@@ -1340,6 +1343,20 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
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
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index da43f962ab4e..1c3a7d050e32 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
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
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 3444e3597b19..805ac453698f 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
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
 	skel = scx_qmap__open();
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
2.41.0


