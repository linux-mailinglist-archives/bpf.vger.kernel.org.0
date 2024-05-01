Return-Path: <bpf+bounces-28354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BEA8B8CAF
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129BA1C20510
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB03136E0C;
	Wed,  1 May 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvLUWweS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A140136995;
	Wed,  1 May 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576449; cv=none; b=REB4aRU7SHOwooFiD7RKI2xLed+ySZ6csQbSQ7NGyTjH6jhRekWqrku/bkpTabDFyqn3+g2ceS0sNzZixiaRHwyUOxnPS2G0oX3Os21vgMBeFP7dLvAYKR47ye9cjrYl228oFOl0HDfadL9cRJhFeTrSC84f0SWZoVQSx52GogQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576449; c=relaxed/simple;
	bh=bXsXquhX1FALI8g4rlZIPMltj2P8tFxY2FzpC5ElRjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYbkWHO6GxDmpk97dxAR7shUmQ6MnI6JaoGhY/YrnM8RD7mA3DBmOSXw66Hx1ePkPoZUMV2Aq39Z3hn1/ceYUrVNMEJ/tKjCDqO5bGc54nkg7k0w6Vn3UlDVp1rZGdT6ljUzNYL1qZZ3sLrd+cw3A3AKVXk7lQX8uCMDFGdCnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvLUWweS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e5c7d087e1so59300085ad.0;
        Wed, 01 May 2024 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576446; x=1715181246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEV8YZRlKBoMpYFxwH64fvKUJJVEvIqmdH0UHP3MyYo=;
        b=BvLUWweSEKv1FREywqfFWJB/GOFZ/NxM7f3J2hdkAPte+jo97QytD8nu471fnOfphp
         Qd8qn9hhwMeSBQZWZDS+r+wRaC62kiNUa2V5f1Dxa0QhF1MLlMzw2FjU55TWDOmczi2D
         TvZmbgSooHJYQAaywBjOyeP3HD+Clc8MJ6qQWYXMw/lyGGE4pnn/Z1OdRg60BJeZljmK
         73Dn0NZbKPDaTw45CrEPx9E30mDCDQJAP72b0JLt9u+PlY2HnMUYlCOPHozNMdMz2zK/
         tzvFifm3RIw9MszdY7AycudDcZvAn7Rv1Jw9xC6BiNQqkByLgaGTPPAGYa32pDbGMkXo
         pekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576446; x=1715181246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vEV8YZRlKBoMpYFxwH64fvKUJJVEvIqmdH0UHP3MyYo=;
        b=R48oUi1csLdLOlpkvwvRJvGr7teZLX14JtIAe7EDVmq9+PjnOJpDzKzpP/sl8xXZ5V
         /oM5geYFDM2tWvbV/dfQv48f0Dwqw05F50QSAT2wjy4bCX7n/99pwUosTOMBefvGr6mZ
         35b+F+oOu8vgOZS4TyJhDWFhk3S8iltMUot4lJW8PK5960FE+d83I0bb/EbUpcjU+H8b
         zPE5/96izPFjZke80XHZONLBBoiJxynvy7Uhm4x+1lOPJ/lFoso1RlYjaVNvqj4vLI7a
         uqULAexUtbgcZvE5ZZzrIaTfeVjTwHw+bOCAshiN11nXQHzkb5GrOS3IvqoSQyUEzIu6
         JyKA==
X-Forwarded-Encrypted: i=1; AJvYcCUW+PK/WP7WvVGWT4mO8YMgM3efjzfkIdO7GZ8sVswp579/2P036XNycFlkdZ8fL8OhVBD8ciFN0dsjoW0ftS/fWP/o
X-Gm-Message-State: AOJu0YyX1x+DqzqtTuSRKfBaB/nkkRAJWoZNDe3CgKJvmXiEF4dmypsN
	sjlO97zu+VuyweK5VSjt8WmR+qD87CZf1xbo5ZzHXWiH2HDA14OJ
X-Google-Smtp-Source: AGHT+IF5YIL+QZsHuUqTJ7/yAFIdiy5o2HlN/5LG8nA+e/+muNT+bii79m1ozrGuSxa9IW8dvInFWg==
X-Received: by 2002:a17:902:ce88:b0:1e5:3c5:55a5 with SMTP id f8-20020a170902ce8800b001e503c555a5mr3023285plg.8.1714576444557;
        Wed, 01 May 2024 08:14:04 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id mo13-20020a1709030a8d00b001eab1a1a752sm1147946plb.120.2024.05.01.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:14:04 -0700 (PDT)
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
Subject: [PATCH 24/39] sched_ext: Make watchdog handle ops.dispatch() looping stall
Date: Wed,  1 May 2024 05:09:59 -1000
Message-ID: <20240501151312.635565-25-tj@kernel.org>
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
 tools/sched_ext/scx_qmap.bpf.c | 15 +++++++++++++++
 tools/sched_ext/scx_qmap.c     |  8 ++++++--
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 26c6a0b1e909..495210cd12f9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8,6 +8,7 @@
 
 enum scx_consts {
 	SCX_DSP_DFL_MAX_BATCH		= 32,
+	SCX_DSP_MAX_LOOPS		= 32,
 	SCX_WATCHDOG_MAX_TIMEOUT	= 30 * HZ,
 
 	SCX_EXIT_BT_LEN			= 64,
@@ -598,6 +599,7 @@ static DEFINE_PER_CPU(struct scx_dsp_ctx, scx_dsp_ctx);
 static struct kset *scx_kset;
 static struct kobject *scx_root_kobj;
 
+static void scx_bpf_kick_cpu(s32 cpu, u64 flags);
 static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
 					     s64 exit_code,
 					     const char *fmt, ...);
@@ -1840,6 +1842,7 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 	struct scx_rq *scx_rq = &rq->scx;
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
+	int nr_loops = SCX_DSP_MAX_LOOPS;
 	bool has_tasks = false;
 
 	lockdep_assert_rq_held(rq);
@@ -1896,6 +1899,20 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 			goto has_tasks;
 		if (consume_dispatch_q(rq, rf, &scx_dsq_global))
 			goto has_tasks;
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
 
 	goto out;
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index e18f25017a0a..812004bf027a 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -31,6 +31,7 @@ char _license[] SEC("license") = "GPL";
 const volatile u64 slice_ns = SCX_SLICE_DFL;
 const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
+const volatile u32 dsp_inf_loop_after;
 const volatile u32 dsp_batch;
 const volatile s32 disallow_tgid;
 const volatile bool switch_partial;
@@ -198,6 +199,20 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	if (scx_bpf_consume(SHARED_DSQ))
 		return;
 
+	if (dsp_inf_loop_after && nr_dispatched > dsp_inf_loop_after) {
+		/*
+		 * PID 2 should be kthreadd which should mostly be idle and off
+		 * the scheduler. Let's keep dispatching it to force the kernel
+		 * to call this function over and over again.
+		 */
+		p = bpf_task_from_pid(2);
+		if (p) {
+			scx_bpf_dispatch(p, SCX_DSQ_LOCAL, slice_ns, 0);
+			bpf_task_release(p);
+			return;
+		}
+	}
+
 	if (!(cpuc = bpf_map_lookup_elem(&cpu_ctx_stor, &zero))) {
 		scx_bpf_error("failed to look up cpu_ctx");
 		return;
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 28fd5aa4e62c..36254631589e 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -19,13 +19,14 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-b COUNT]\n"
+"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
 "       [-d PID] [-D LEN] [-p] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
 "  -t COUNT      Stall every COUNT'th user thread\n"
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
+"  -l COUNT      Trigger dispatch infinite looping after COUNT dispatches\n"
 "  -b COUNT      Dispatch upto COUNT tasks together\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -D LEN        Set scx_exit_info.dump buffer length\n"
@@ -60,7 +61,7 @@ int main(int argc, char **argv)
 
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:b:d:D:pvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:d:D:pvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -74,6 +75,9 @@ int main(int argc, char **argv)
 		case 'T':
 			skel->rodata->stall_kernel_nth = strtoul(optarg, NULL, 0);
 			break;
+		case 'l':
+			skel->rodata->dsp_inf_loop_after = strtoul(optarg, NULL, 0);
+			break;
 		case 'b':
 			skel->rodata->dsp_batch = strtoul(optarg, NULL, 0);
 			break;
-- 
2.44.0


