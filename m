Return-Path: <bpf+bounces-69045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AC6B8BBBA
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DD91C219FD
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6E6257453;
	Sat, 20 Sep 2025 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcA0YTOL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFA0257444;
	Sat, 20 Sep 2025 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329986; cv=none; b=pFbwaRe0SvkW7+GYuV1/XPmH0EF5fNEyrl8bX2FMIaXN3hZM2idFEzkHG1GGhgGks9/NXfXgy0vjH5aXxWqxO0aek4tz0bXx0e2OVFukJp/cNH0+RVHmKLQ+bK/iJpjXeeeKDRAp68n0tNMQqEmDJc2GQdkQlB9Vr1ycdiLwBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329986; c=relaxed/simple;
	bh=mgQQ+IUl7NiiL7dQwjSJsrD1B091MyDgy6vpzLjygy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKHxo9DNWs4Jb3rpr4BbwmMiO5qJt9fu3fy8nEuKzj3gKHqn4IC2RA1cqOVsPg1sLWJKQuQ9CA8ZKaG32R9M0VQT5eIFWoUlkNTOGjvUEc3WB3XpSmfmuhT+eJj/GeFKtJBGJL7HIuW6pE3yeslS/B9QWrTnKL9m5ejjZezMPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcA0YTOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837ACC4CEF0;
	Sat, 20 Sep 2025 00:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329985;
	bh=mgQQ+IUl7NiiL7dQwjSJsrD1B091MyDgy6vpzLjygy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcA0YTOLlHaXKcoCkzCn8u5L8cXiD3lXfHidxbFleUfSt2+r4poUTES7g2Cp5v2y/
	 Xa37bNY0VsCdhQoL7pMxbTIEqhBFcMpqJOUL1lxb6l5GeZoN+MdOoeHTfEOvB4hSg0
	 tyg5ljU2BasFs1JBZTxezsC9/uSTw/wLMS39QK/FMIaNymsRkZ8Pu3I2fdIN9gMR3N
	 IK/23DRk/a38VFGHFrS+/cvjRjs0bJO3G961HAaiy1BPbGQwxU0oQtt7kPtGazjUFB
	 w87EIXaypSl//MYkG3FFWI4tBqIOJHfCu42X+Hh91orGdPmxpNZo26OsvZYPj+lZZE
	 iX3TbHWn5UN+A==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/46] sched_ext: Drop kf_cpu_valid()
Date: Fri, 19 Sep 2025 14:58:34 -1000
Message-ID: <20250920005931.2753828-12-tj@kernel.org>
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

The intention behind kf_cpu_valid() was that when called from kfuncs,
kf_cpu_valid() would be able to implicitly determine the scx_sched instance
being operated on and thus wouldn't need @sch passed in explicitly. This
turned out to be unnecessarily complicated to implement and not have
justifiable practical benefits. Replace kf_cpu_valid() usages with
ops_cpu_valid() which takes explicit @sch.

Callers which don't have $sch available in the context are updated to read
$scx_root under RCU read lock, verify that it's not NULL and pass it in.

scx_bpf_cpu_rq() is restructured to use guard(rcu)() instead of explicit
rcu_read_[un]lock().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c      | 67 ++++++++++++++++++++++++-----------------
 kernel/sched/ext_idle.c | 12 +++++---
 2 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 373146154829..56ca09f46d1e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -736,23 +736,6 @@ static bool ops_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where)
 	}
 }
 
-/**
- * kf_cpu_valid - Verify a CPU number, to be used on kfunc input args
- * @cpu: cpu number which came from a BPF ops
- * @where: extra information reported on error
- *
- * The same as ops_cpu_valid() but @sch is implicit.
- */
-static bool kf_cpu_valid(u32 cpu, const char *where)
-{
-	if (__cpu_valid(cpu)) {
-		return true;
-	} else {
-		scx_kf_error("invalid CPU %d%s%s", cpu, where ? " " : "", where ?: "");
-		return false;
-	}
-}
-
 /**
  * ops_sanitize_err - Sanitize a -errno value
  * @sch: scx_sched to error out on error
@@ -5815,7 +5798,7 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	struct rq *this_rq;
 	unsigned long irq_flags;
 
-	if (!kf_cpu_valid(cpu, NULL))
+	if (!ops_cpu_valid(sch, cpu, NULL))
 		return;
 
 	local_irq_save(irq_flags);
@@ -6224,7 +6207,12 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
  */
 __bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu)
 {
-	if (kf_cpu_valid(cpu, NULL))
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (likely(sch) && ops_cpu_valid(sch, cpu, NULL))
 		return arch_scale_cpu_capacity(cpu);
 	else
 		return SCX_CPUPERF_ONE;
@@ -6246,7 +6234,12 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu)
  */
 __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
 {
-	if (kf_cpu_valid(cpu, NULL))
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (likely(sch) && ops_cpu_valid(sch, cpu, NULL))
 		return arch_scale_freq_capacity(cpu);
 	else
 		return SCX_CPUPERF_ONE;
@@ -6268,12 +6261,20 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
  */
 __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(sch);
+	if (unlikely(!sch))
+		return;
+
 	if (unlikely(perf > SCX_CPUPERF_ONE)) {
 		scx_kf_error("Invalid cpuperf target %u for CPU %d", perf, cpu);
 		return;
 	}
 
-	if (kf_cpu_valid(cpu, NULL)) {
+	if (ops_cpu_valid(sch, cpu, NULL)) {
 		struct rq *rq = cpu_rq(cpu), *locked_rq = scx_locked_rq();
 		struct rq_flags rf;
 
@@ -6379,18 +6380,21 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 {
 	struct scx_sched *sch;
 
-	if (!kf_cpu_valid(cpu, NULL))
-		return NULL;
+	guard(rcu)();
 
-	rcu_read_lock();
 	sch = rcu_dereference(scx_root);
-	if (likely(sch) && !sch->warned_deprecated_rq) {
+	if (unlikely(!sch))
+		return NULL;
+
+	if (!ops_cpu_valid(sch, cpu, NULL))
+		return NULL;
+
+	if (!sch->warned_deprecated_rq) {
 		printk_deferred(KERN_WARNING "sched_ext: %s() is deprecated; "
 				"use scx_bpf_locked_rq() when holding rq lock "
 				"or scx_bpf_cpu_curr() to read remote curr safely.\n", __func__);
 		sch->warned_deprecated_rq = true;
 	}
-	rcu_read_unlock();
 
 	return cpu_rq(cpu);
 }
@@ -6425,8 +6429,17 @@ __bpf_kfunc struct rq *scx_bpf_locked_rq(void)
  */
 __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu)
 {
-	if (!kf_cpu_valid(cpu, NULL))
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
 		return NULL;
+
+	if (!ops_cpu_valid(sch, cpu, NULL))
+		return NULL;
+
 	return rcu_dereference(cpu_rq(cpu)->curr);
 }
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 6e2504ae7357..a576ec10522e 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -864,7 +864,7 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 	struct rq_flags rf;
 	s32 cpu;
 
-	if (!kf_cpu_valid(prev_cpu, NULL))
+	if (!ops_cpu_valid(sch, prev_cpu, NULL))
 		return -EINVAL;
 
 	if (!check_builtin_idle_enabled(sch))
@@ -923,9 +923,13 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
  */
 __bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
 {
-	if (!kf_cpu_valid(cpu, NULL))
-		return NUMA_NO_NODE;
+	struct scx_sched *sch;
+
+	guard(rcu)();
 
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch) || !ops_cpu_valid(sch, cpu, NULL))
+		return NUMA_NO_NODE;
 	return cpu_to_node(cpu);
 }
 
@@ -1154,7 +1158,7 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 	if (!check_builtin_idle_enabled(sch))
 		return false;
 
-	if (!kf_cpu_valid(cpu, NULL))
+	if (!ops_cpu_valid(sch, cpu, NULL))
 		return false;
 
 	return scx_idle_test_and_clear_cpu(cpu);
-- 
2.51.0


