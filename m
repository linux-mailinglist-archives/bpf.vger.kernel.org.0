Return-Path: <bpf+bounces-69041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E7CB8BB9F
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FFE5A5EE6
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6A823D7C4;
	Sat, 20 Sep 2025 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccCeFCgs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC757239E8B;
	Sat, 20 Sep 2025 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329981; cv=none; b=F972Ksqj+A2n1Icy8tiAEH7XO98r1qU8rGrLDYGl9glInnG+vg32t2hr8EgBjEhfIIN9DZ8jIFe8c2IqYwXlsbFv6FGi+WZoGoV6E3YpbeddqBXLRxldPko95HDZQXuqsu9KU19xVzBJ4SkeMlfQOychN/wk/wbHL/7LHmXCvOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329981; c=relaxed/simple;
	bh=beTGNSGpli69lPiThGuBvr+k/9c2AtGfSxKOEPXp9Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1URwwE+l6q6kizWeVTV/HNZcWQv9gw7cNXz0qXQfoQZqi0GWEZ9+xBW77an5KuENq25cf/4u8oABAixdadDiMfMm2y8BJLdvNMNUFGXxYxhbSszw53DNJSrTxiwMsA7e8QZIMUcmm/KRhZKWMMSk5KxWwPxbnjUA3ERZY32wNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccCeFCgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DF6C4CEF5;
	Sat, 20 Sep 2025 00:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329981;
	bh=beTGNSGpli69lPiThGuBvr+k/9c2AtGfSxKOEPXp9Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccCeFCgsfNgLD7Wz9XF/nykVx9uqQqsspYpjocKMySdzZNr63U6aX84iB1Lu/KBBM
	 1tBaQsB+IMt59Ko019dBdbc0BLH1YpVoMUjI5puiy/Gt4AULAYgYPM8dYb6C2SryPG
	 ERqiSbBslClSXZlGysEbSEqJcuSfwQO52ZwszTT0Rzaszk8sx5gLt7luK9bQIz35Cy
	 TuhQz8BtofiecNtNBa7Xc1phA+snVfYCK7wGp8TpXPtJbgNpadX+48VNR1refeSHZw
	 K9D/3QakmKYYIJn8UmuKNvVkmsHr+htP6IBNByACEokEd/pV+7T0+oMKDHVWq1pfem
	 GQhQ3eF+ecaDw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/46] tools/sched_ext: scx_qmap: Make debug output quieter by default
Date: Fri, 19 Sep 2025 14:58:30 -1000
Message-ID: <20250920005931.2753828-8-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_qmap currently outputs verbose debug messages including cgroup operations
and CPU online/offline events by default, which can be noisy during normal
operation. While the existing -P option controls DSQ dumps and event
statistics, there's no way to suppress the other debug messages.

Split the debug output controls to make scx_qmap quieter by default. The -P
option continues to control DSQ dumps and event statistics
(print_dsqs_and_events), while a new -M option controls debug messages like
cgroup operations and CPU events (print_msgs). This allows users to run
scx_qmap with minimal output and selectively enable debug information as
needed.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 80 +++++++++++++++++++---------------
 tools/sched_ext/scx_qmap.c     | 12 +++--
 2 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index cd50a94326e3..3072b593f898 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -39,7 +39,8 @@ const volatile u32 stall_kernel_nth;
 const volatile u32 dsp_inf_loop_after;
 const volatile u32 dsp_batch;
 const volatile bool highpri_boosting;
-const volatile bool print_shared_dsq;
+const volatile bool print_dsqs_and_events;
+const volatile bool print_msgs;
 const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
 
@@ -633,22 +634,25 @@ void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_ctx *dctx, struct task_struc
 
 s32 BPF_STRUCT_OPS(qmap_cgroup_init, struct cgroup *cgrp, struct scx_cgroup_init_args *args)
 {
-	bpf_printk("CGRP INIT %llu weight=%u period=%lu quota=%ld burst=%lu",
-		   cgrp->kn->id, args->weight, args->bw_period_us,
-		   args->bw_quota_us, args->bw_burst_us);
+	if (print_msgs)
+		bpf_printk("CGRP INIT %llu weight=%u period=%lu quota=%ld burst=%lu",
+			   cgrp->kn->id, args->weight, args->bw_period_us,
+			   args->bw_quota_us, args->bw_burst_us);
 	return 0;
 }
 
 void BPF_STRUCT_OPS(qmap_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
 {
-	bpf_printk("CGRP SET %llu weight=%u", cgrp->kn->id, weight);
+	if (print_msgs)
+		bpf_printk("CGRP SET %llu weight=%u", cgrp->kn->id, weight);
 }
 
 void BPF_STRUCT_OPS(qmap_cgroup_set_bandwidth, struct cgroup *cgrp,
 		    u64 period_us, u64 quota_us, u64 burst_us)
 {
-	bpf_printk("CGRP SET %llu period=%lu quota=%ld burst=%lu", cgrp->kn->id,
-		   period_us, quota_us, burst_us);
+	if (print_msgs)
+		bpf_printk("CGRP SET %llu period=%lu quota=%ld burst=%lu",
+			   cgrp->kn->id, period_us, quota_us, burst_us);
 }
 
 /*
@@ -692,16 +696,20 @@ static void print_cpus(void)
 
 void BPF_STRUCT_OPS(qmap_cpu_online, s32 cpu)
 {
-	bpf_printk("CPU %d coming online", cpu);
-	/* @cpu is already online at this point */
-	print_cpus();
+	if (print_msgs) {
+		bpf_printk("CPU %d coming online", cpu);
+		/* @cpu is already online at this point */
+		print_cpus();
+	}
 }
 
 void BPF_STRUCT_OPS(qmap_cpu_offline, s32 cpu)
 {
-	bpf_printk("CPU %d going offline", cpu);
-	/* @cpu is still online at this point */
-	print_cpus();
+	if (print_msgs) {
+		bpf_printk("CPU %d going offline", cpu);
+		/* @cpu is still online at this point */
+		print_cpus();
+	}
 }
 
 struct monitor_timer {
@@ -799,35 +807,36 @@ static void dump_shared_dsq(void)
 
 static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 {
-	struct scx_event_stats events;
-
 	bpf_rcu_read_lock();
 	dispatch_highpri(true);
 	bpf_rcu_read_unlock();
 
 	monitor_cpuperf();
 
-	if (print_shared_dsq)
+	if (print_dsqs_and_events) {
+		struct scx_event_stats events;
+
 		dump_shared_dsq();
 
-	__COMPAT_scx_bpf_events(&events, sizeof(events));
-
-	bpf_printk("%35s: %lld", "SCX_EV_SELECT_CPU_FALLBACK",
-		   scx_read_event(&events, SCX_EV_SELECT_CPU_FALLBACK));
-	bpf_printk("%35s: %lld", "SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE",
-		   scx_read_event(&events, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE));
-	bpf_printk("%35s: %lld", "SCX_EV_DISPATCH_KEEP_LAST",
-		   scx_read_event(&events, SCX_EV_DISPATCH_KEEP_LAST));
-	bpf_printk("%35s: %lld", "SCX_EV_ENQ_SKIP_EXITING",
-		   scx_read_event(&events, SCX_EV_ENQ_SKIP_EXITING));
-	bpf_printk("%35s: %lld", "SCX_EV_REFILL_SLICE_DFL",
-		   scx_read_event(&events, SCX_EV_REFILL_SLICE_DFL));
-	bpf_printk("%35s: %lld", "SCX_EV_BYPASS_DURATION",
-		   scx_read_event(&events, SCX_EV_BYPASS_DURATION));
-	bpf_printk("%35s: %lld", "SCX_EV_BYPASS_DISPATCH",
-		   scx_read_event(&events, SCX_EV_BYPASS_DISPATCH));
-	bpf_printk("%35s: %lld", "SCX_EV_BYPASS_ACTIVATE",
-		   scx_read_event(&events, SCX_EV_BYPASS_ACTIVATE));
+		__COMPAT_scx_bpf_events(&events, sizeof(events));
+
+		bpf_printk("%35s: %lld", "SCX_EV_SELECT_CPU_FALLBACK",
+			   scx_read_event(&events, SCX_EV_SELECT_CPU_FALLBACK));
+		bpf_printk("%35s: %lld", "SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE",
+			   scx_read_event(&events, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE));
+		bpf_printk("%35s: %lld", "SCX_EV_DISPATCH_KEEP_LAST",
+			   scx_read_event(&events, SCX_EV_DISPATCH_KEEP_LAST));
+		bpf_printk("%35s: %lld", "SCX_EV_ENQ_SKIP_EXITING",
+			   scx_read_event(&events, SCX_EV_ENQ_SKIP_EXITING));
+		bpf_printk("%35s: %lld", "SCX_EV_REFILL_SLICE_DFL",
+			   scx_read_event(&events, SCX_EV_REFILL_SLICE_DFL));
+		bpf_printk("%35s: %lld", "SCX_EV_BYPASS_DURATION",
+			   scx_read_event(&events, SCX_EV_BYPASS_DURATION));
+		bpf_printk("%35s: %lld", "SCX_EV_BYPASS_DISPATCH",
+			   scx_read_event(&events, SCX_EV_BYPASS_DISPATCH));
+		bpf_printk("%35s: %lld", "SCX_EV_BYPASS_ACTIVATE",
+			   scx_read_event(&events, SCX_EV_BYPASS_ACTIVATE));
+	}
 
 	bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
 	return 0;
@@ -839,7 +848,8 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 	struct bpf_timer *timer;
 	s32 ret;
 
-	print_cpus();
+	if (print_msgs)
+		print_cpus();
 
 	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
 	if (ret)
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index c4912ab2e76f..ef701d45ba43 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -20,7 +20,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-P] [-d PID] [-D LEN] [-p] [-v]\n"
+"       [-P] [-M] [-d PID] [-D LEN] [-p] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
@@ -28,7 +28,8 @@ const char help_fmt[] =
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
 "  -l COUNT      Trigger dispatch infinite looping after COUNT dispatches\n"
 "  -b COUNT      Dispatch upto COUNT tasks together\n"
-"  -P            Print out DSQ content to trace_pipe every second, use with -b\n"
+"  -P            Print out DSQ content and event counters to trace_pipe every second\n"
+"  -M            Print out debug messages to trace_pipe\n"
 "  -H            Boost nice -20 tasks in SHARED_DSQ, use with -b\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -D LEN        Set scx_exit_info.dump buffer length\n"
@@ -66,7 +67,7 @@ int main(int argc, char **argv)
 
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PHd:D:Spvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PMHd:D:Spvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -87,7 +88,10 @@ int main(int argc, char **argv)
 			skel->rodata->dsp_batch = strtoul(optarg, NULL, 0);
 			break;
 		case 'P':
-			skel->rodata->print_shared_dsq = true;
+			skel->rodata->print_dsqs_and_events = true;
+			break;
+		case 'M':
+			skel->rodata->print_msgs = true;
 			break;
 		case 'H':
 			skel->rodata->highpri_boosting = true;
-- 
2.51.0


