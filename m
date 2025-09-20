Return-Path: <bpf+bounces-69044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A00B8BBCF
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97927BEEB7
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556DF1DE8BB;
	Sat, 20 Sep 2025 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mloAvVu/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C916624DD15;
	Sat, 20 Sep 2025 00:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329984; cv=none; b=YlP+SgeDBg6Uc+6zPkgHAQZG3qn8uFBnanDLD7pB6B1pt+WW/oHWQVhm7ufFnboG8M1pyb5kxesfi88RrAPnzbEy+XSLhMmbdMpHTteptouiLHhtSg2K0zfzlhzhJKjwkbWh6hLG29wTzBprczf7DgcS8xMTbfEsbOtf1CsUhMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329984; c=relaxed/simple;
	bh=N8NdxfmZXIcYOUKNsEt/ZUcRXN1TPpQdfGuEhvDG+QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlhnF4YJ7cokz2xgSIJATHHf/5L4+Ks3f3B3B1c+QotZbV68fXrhl9I5aBAXb7R8OP33o4xTCF4CyjIzcgSYjE+e24JSa/a5EWLkvDRMFhotMS3gLwH/Z34YZkB14OU6Dn4UCaAUJocwSmvtz4VV+qfluCtgmBQzBgJjGQBO9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mloAvVu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857D7C4CEF9;
	Sat, 20 Sep 2025 00:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329984;
	bh=N8NdxfmZXIcYOUKNsEt/ZUcRXN1TPpQdfGuEhvDG+QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mloAvVu/BBRgTfWDmpAGd/mjwWGP9/86mS7RpsDN8XKmmuTFWXX8hT+ZtwOW468IQ
	 W0M3ZyXNJiX5pJBo+vYG8iLftTJyqieHVdljdUl0HZYR1LFvHkBQ48IQizXUsuBbjN
	 YylY5dMIhcHZPXy1QGuX0++b8lRGna/mlcjbNNye/XxsWehEiG5P85CzS07Cti+PNa
	 6WN3HCX5yRJ0zeTYJy6Avo0beA7WVXVs+lJ9qhIYlH2/iVQYyH24FkbsB04YvbfcNX
	 RzFp//dT0ROcd4h7NSWcOnQxzhOi8MdEplX7dWi+D72GNTB7S9bSxEGFgkXtgAkIOS
	 nJPpzLUqvnB3w==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/46] sched_ext: Add the @sch parameter to ext_idle helpers
Date: Fri, 19 Sep 2025 14:58:33 -1000
Message-ID: <20250920005931.2753828-11-tj@kernel.org>
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

In preparation for multiple scheduler support, add the @sch parameter to
validate_node(), check_builtin_idle_enabled() and select_cpu_from_kfunc(),
and update their callers to read $scx_root, verify that it's not NULL and
pass it in. The passed in @sch parameter is not used yet.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext_idle.c | 109 ++++++++++++++++++++++++++++++++++------
 1 file changed, 94 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 7174e1c1a392..6e2504ae7357 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -819,7 +819,7 @@ void scx_idle_disable(void)
  * Helpers that can be called from the BPF scheduler.
  */
 
-static int validate_node(int node)
+static int validate_node(struct scx_sched *sch, int node)
 {
 	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
 		scx_kf_error("per-node idle tracking is disabled");
@@ -847,7 +847,7 @@ static int validate_node(int node)
 
 __bpf_kfunc_start_defs();
 
-static bool check_builtin_idle_enabled(void)
+static bool check_builtin_idle_enabled(struct scx_sched *sch)
 {
 	if (static_branch_likely(&scx_builtin_idle_enabled))
 		return true;
@@ -856,7 +856,8 @@ static bool check_builtin_idle_enabled(void)
 	return false;
 }
 
-static s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
+				 s32 prev_cpu, u64 wake_flags,
 				 const struct cpumask *allowed, u64 flags)
 {
 	struct rq *rq;
@@ -866,7 +867,7 @@ static s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_f
 	if (!kf_cpu_valid(prev_cpu, NULL))
 		return -EINVAL;
 
-	if (!check_builtin_idle_enabled())
+	if (!check_builtin_idle_enabled(sch))
 		return -EBUSY;
 
 	/*
@@ -946,15 +947,21 @@ __bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
+	struct scx_sched *sch;
 	s32 cpu;
 
-	cpu = select_cpu_from_kfunc(p, prev_cpu, wake_flags, NULL, 0);
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return -ENODEV;
+
+	cpu = select_cpu_from_kfunc(sch, p, prev_cpu, wake_flags, NULL, 0);
 	if (cpu >= 0) {
 		*is_idle = true;
 		return cpu;
 	}
 	*is_idle = false;
-
 	return prev_cpu;
 }
 
@@ -981,7 +988,16 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 				       const struct cpumask *cpus_allowed, u64 flags)
 {
-	return select_cpu_from_kfunc(p, prev_cpu, wake_flags, cpus_allowed, flags);
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return -ENODEV;
+
+	return select_cpu_from_kfunc(sch, p, prev_cpu, wake_flags,
+				     cpus_allowed, flags);
 }
 
 /**
@@ -995,7 +1011,15 @@ __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
 {
-	node = validate_node(node);
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return cpu_none_mask;
+
+	node = validate_node(sch, node);
 	if (node < 0)
 		return cpu_none_mask;
 
@@ -1011,12 +1035,20 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return cpu_none_mask;
+
 	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
 		scx_kf_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
 		return cpu_none_mask;
 	}
 
-	if (!check_builtin_idle_enabled())
+	if (!check_builtin_idle_enabled(sch))
 		return cpu_none_mask;
 
 	return idle_cpumask(NUMA_NO_NODE)->cpu;
@@ -1034,7 +1066,15 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
 {
-	node = validate_node(node);
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return cpu_none_mask;
+
+	node = validate_node(sch, node);
 	if (node < 0)
 		return cpu_none_mask;
 
@@ -1054,12 +1094,20 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return cpu_none_mask;
+
 	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
 		scx_kf_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
 		return cpu_none_mask;
 	}
 
-	if (!check_builtin_idle_enabled())
+	if (!check_builtin_idle_enabled(sch))
 		return cpu_none_mask;
 
 	if (sched_smt_active())
@@ -1095,7 +1143,15 @@ __bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
  */
 __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 {
-	if (!check_builtin_idle_enabled())
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return false;
+
+	if (!check_builtin_idle_enabled(sch))
 		return false;
 
 	if (!kf_cpu_valid(cpu, NULL))
@@ -1126,7 +1182,15 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 __bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
 					   int node, u64 flags)
 {
-	node = validate_node(node);
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return -ENODEV;
+
+	node = validate_node(sch, node);
 	if (node < 0)
 		return node;
 
@@ -1158,12 +1222,20 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
 __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 				      u64 flags)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return -ENODEV;
+
 	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
 		scx_kf_error("per-node idle tracking is enabled");
 		return -EBUSY;
 	}
 
-	if (!check_builtin_idle_enabled())
+	if (!check_builtin_idle_enabled(sch))
 		return -EBUSY;
 
 	return scx_pick_idle_cpu(cpus_allowed, NUMA_NO_NODE, flags);
@@ -1193,9 +1265,16 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 __bpf_kfunc s32 scx_bpf_pick_any_cpu_node(const struct cpumask *cpus_allowed,
 					  int node, u64 flags)
 {
+	struct scx_sched *sch;
 	s32 cpu;
 
-	node = validate_node(node);
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return -ENODEV;
+
+	node = validate_node(sch, node);
 	if (node < 0)
 		return node;
 
-- 
2.51.0


