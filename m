Return-Path: <bpf+bounces-32453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE6E90DE41
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A6F1C22937
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A293019AD52;
	Tue, 18 Jun 2024 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xoj56FIg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87B19A2B8;
	Tue, 18 Jun 2024 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745706; cv=none; b=UJtoe/Mg/VjmDbf1BslmwOubZD2HvzjOIV06V2uhN188MGWBQUgTMUJn3suNXjcM0eisa1L/MYqm97w8p//eimGxjpxAm1FnmpG0EZEAlQz0JfbwpwEnOCC6mISXiIrGAyQ2Ixr29RF03Y2a91BEfdfY/E1E9fO1SdG9p26cD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745706; c=relaxed/simple;
	bh=bBm0+y08kRBRVR3O64sGiSPtfVv8nr+bYlxfaSrdSok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MowXRzB9kG6s+WpVIBwwexI8KisYvyGl8rVY57zNmPPQEy5Wr38237kSgrURLC/6k45CupwuXz7dkk+aahpo16V3uUzIWd2046jgk2kxdZhVsA2VMDflPU6Ds9aZmpeSkfzhXE19oW8/ZAXBZaNOayibCl/rnl+3ObsygaCXBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xoj56FIg; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b96a78639aso2453017eaf.1;
        Tue, 18 Jun 2024 14:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745703; x=1719350503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyYSo95SiBRjFUeYrwDwaMorkzeNYM5DPWwv8Gl1vIU=;
        b=Xoj56FIgYpA0MePAjnRSQ0ug+0qeqvif6I3X/0yFWmV7X73PH/a3n9MSH0+YKoyYN9
         wRQZDTJjt4ctWrb50Q9kbeMCWTTEvWb91683qkYvKNvrRVjw0P+eX2wzogFasO6bdAPD
         JvRmAupQjR+GkckNZtX/+0NtP4EKON9Fxspr2D3C8YdxGqhSz2PBPxIm7hTVgCad17Hl
         h06ymOrDjsVixycZkO0lxNNeUlWf1TF0wWjJYvT66lq9/pykUfl0mQJULVF4PFM2tMl0
         Fk8ZjlE8ZbcEYF3gZ+wTNOhl91VVIE2/x/Wo9sT0TQ76XYVvy8OSM6lJAsIihoTogiq7
         8TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745703; x=1719350503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SyYSo95SiBRjFUeYrwDwaMorkzeNYM5DPWwv8Gl1vIU=;
        b=NJ6OBRiu9TWOWR7xD8pQFwxR/9dCB+PoMSH9SD3Pxk0v6BRKmnZQkPDjeJZt6KoNqC
         bflAJIfrVatT2P09yiTgbQgd18AMRuJVFT1z+Wr2yf6GBIteY95Qb9GkczBzbpFrNx5y
         WHg4WptWjwx7GrEA4IR3LFLnljbHjkbYJ8UJYzBwj59Uc7xBmGMScJWIItHduwUX+3hw
         R20aLf0f67ujdA38c07B4NB/w/bsPGJojFe01UMNxCj/a9+4PTCrHokuHuRvvVAYuBHb
         Cfj7TJvDz3v6GbDnZ9k3sIEj3v0K17sYC4+fWuHJqIkGE8IXm7cU0zGOajt9/qUHkbO7
         g9vA==
X-Forwarded-Encrypted: i=1; AJvYcCW1ZQY55IJbiQdZ32im+7x79xF7VUebBjNHzEblaj07fVV8HKI6afY9TpKUKNPPGR0lbs2qF8d5MnqPi9lPUnLFcTv4
X-Gm-Message-State: AOJu0YxOcOxTfh79lOt4MTaZygpeLNtR99jj974WkjZSJKSQbey8g09V
	pAzfTutTNDj5qmZsaWIJVZE0OndQxwd9ifKuSV+1e1AF5bkjlCM1
X-Google-Smtp-Source: AGHT+IHO+Edj9VOSYHCOInQa/wKAgjUZKQ69T5VQO+GYW7qcSPRcjfSpRIi8DV+069qWpde3mxDwnA==
X-Received: by 2002:a05:6358:63a4:b0:199:42c8:389b with SMTP id e5c5f4694b2df-1a1fd3b8487mr119209155d.11.1718745701331;
        Tue, 18 Jun 2024 14:21:41 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fed50da2f2sm8575759a12.0.2024.06.18.14.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:41 -0700 (PDT)
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
Subject: [PATCH 19/30] sched_ext: Make watchdog handle ops.dispatch() looping stall
Date: Tue, 18 Jun 2024 11:17:34 -1000
Message-ID: <20240618212056.2833381-20-tj@kernel.org>
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
index 213793d086d7..89bcca84d6b5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8,6 +8,7 @@
 
 enum scx_consts {
 	SCX_DSP_DFL_MAX_BATCH		= 32,
+	SCX_DSP_MAX_LOOPS		= 32,
 	SCX_WATCHDOG_MAX_TIMEOUT	= 30 * HZ,
 
 	SCX_EXIT_BT_LEN			= 64,
@@ -665,6 +666,7 @@ static struct kobject *scx_root_kobj;
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched_ext.h>
 
+static void scx_bpf_kick_cpu(s32 cpu, u64 flags);
 static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
 					     s64 exit_code,
 					     const char *fmt, ...);
@@ -1906,6 +1908,7 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
+	int nr_loops = SCX_DSP_MAX_LOOPS;
 	bool has_tasks = false;
 
 	lockdep_assert_rq_held(rq);
@@ -1962,6 +1965,20 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
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
index 5b3da28bf042..879fc9c788e5 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -31,6 +31,7 @@ char _license[] SEC("license") = "GPL";
 const volatile u64 slice_ns = SCX_SLICE_DFL;
 const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
+const volatile u32 dsp_inf_loop_after;
 const volatile u32 dsp_batch;
 const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
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
index a1123a17581b..594147a710a8 100644
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
@@ -61,7 +62,7 @@ int main(int argc, char **argv)
 
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:b:d:D:Spvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:d:D:Spvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -75,6 +76,9 @@ int main(int argc, char **argv)
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
2.45.2


