Return-Path: <bpf+bounces-42983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E25C9AD907
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 02:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E031F229DF
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 00:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5D6C8F0;
	Thu, 24 Oct 2024 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYZ16apQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800B749A;
	Thu, 24 Oct 2024 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729731283; cv=none; b=Ezr1i6Z/lhA88bYBUL6UMeqXEo8NSbiNgRVc9tsZ5T8yC8g/jn6+4a73Cs55XLZAAXUfHoRRCVny+UP+xk8iNVI3Ctu+sQJQMJTKjVIc+NyvXRw1L0U0MXkaS8uKaYFFBhK1Kq102UQJTKuyhq56/BOHVmheXOXZZGhCOWg32x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729731283; c=relaxed/simple;
	bh=ng8ajisjLJlmK1ASYXguTfOr7f/Tx1yLYoZdsZn/c1c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RUyPyUN+TgZeKTFIswWTlYGC2m1xThxsmUiTulRY7zCi9sQp443QCurHoledqy80XY3YQkadHECKNJ9w14mXiJeD2sXuf7RrXd/LWDGvZcSB+2BJLIS4BnuJZzKVuJK6JLcRomuK5bpEoG3E1Srkg3blOZbsDPHJHB6DFa8UzJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYZ16apQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8277BC4CEC6;
	Thu, 24 Oct 2024 00:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729731282;
	bh=ng8ajisjLJlmK1ASYXguTfOr7f/Tx1yLYoZdsZn/c1c=;
	h=Date:From:To:Cc:Subject:From;
	b=DYZ16apQoLPoWIIKdSbDGQHZ4x7IlTMhFYAa+RLrQ9RDavYJzWSNAJhkGR7365oSI
	 oAGIb3opX3EHTvVDBMAz4SJORuVbkoZ+SDu4VQzrRBrbjYc5/ZIsbyBFniv5WOEniH
	 pqfWxboC/o9RPNhnxQfoN4gVUoHaJ9GKpMBRsMufyAMTKeMVin0K5MmCo/WhABbl3D
	 Ls1vx0J181w49qYKkOJO4QQYrsuNc+09iDJbKWDU07o4u5rEAVnlz4hGcEuXVtEqoR
	 5Rcf8t0IAuekPZodShnGa7OXfxgygFAoNl6FY+2zQeSXIG0v2hSCe+T1YZD7IQrfIr
	 RmZfGd3hZJY8A==
Date: Wed, 23 Oct 2024 14:54:41 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, kernel-team@meta.com,
	sched-ext@meta.com, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.13 1/2] sched_ext: Rename CFI stubs to names
 that are recognized by BPF
Message-ID: <Zxma0Vt6kwWFe1hx@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

CFI stubs can be used to tag arguments with __nullable (and possibly other
tags in the future) but for that to work the CFI stubs must have names that
are recognized by BPF. Rename them.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 kernel/sched/ext.c |  132 ++++++++++++++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 66 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5634,78 +5634,78 @@ static int bpf_scx_validate(void *kdata)
 	return 0;
 }
 
-static s32 select_cpu_stub(struct task_struct *p, s32 prev_cpu, u64 wake_flags) { return -EINVAL; }
-static void enqueue_stub(struct task_struct *p, u64 enq_flags) {}
-static void dequeue_stub(struct task_struct *p, u64 enq_flags) {}
-static void dispatch_stub(s32 prev_cpu, struct task_struct *p) {}
-static void tick_stub(struct task_struct *p) {}
-static void runnable_stub(struct task_struct *p, u64 enq_flags) {}
-static void running_stub(struct task_struct *p) {}
-static void stopping_stub(struct task_struct *p, bool runnable) {}
-static void quiescent_stub(struct task_struct *p, u64 deq_flags) {}
-static bool yield_stub(struct task_struct *from, struct task_struct *to) { return false; }
-static bool core_sched_before_stub(struct task_struct *a, struct task_struct *b) { return false; }
-static void set_weight_stub(struct task_struct *p, u32 weight) {}
-static void set_cpumask_stub(struct task_struct *p, const struct cpumask *mask) {}
-static void update_idle_stub(s32 cpu, bool idle) {}
-static void cpu_acquire_stub(s32 cpu, struct scx_cpu_acquire_args *args) {}
-static void cpu_release_stub(s32 cpu, struct scx_cpu_release_args *args) {}
-static s32 init_task_stub(struct task_struct *p, struct scx_init_task_args *args) { return -EINVAL; }
-static void exit_task_stub(struct task_struct *p, struct scx_exit_task_args *args) {}
-static void enable_stub(struct task_struct *p) {}
-static void disable_stub(struct task_struct *p) {}
+static s32 sched_ext_ops__select_cpu(struct task_struct *p, s32 prev_cpu, u64 wake_flags) { return -EINVAL; }
+static void sched_ext_ops__enqueue(struct task_struct *p, u64 enq_flags) {}
+static void sched_ext_ops__dequeue(struct task_struct *p, u64 enq_flags) {}
+static void sched_ext_ops__dispatch(s32 prev_cpu, struct task_struct *p) {}
+static void sched_ext_ops__tick(struct task_struct *p) {}
+static void sched_ext_ops__runnable(struct task_struct *p, u64 enq_flags) {}
+static void sched_ext_ops__running(struct task_struct *p) {}
+static void sched_ext_ops__stopping(struct task_struct *p, bool runnable) {}
+static void sched_ext_ops__quiescent(struct task_struct *p, u64 deq_flags) {}
+static bool sched_ext_ops__yield(struct task_struct *from, struct task_struct *to) { return false; }
+static bool sched_ext_ops__core_sched_before(struct task_struct *a, struct task_struct *b) { return false; }
+static void sched_ext_ops__set_weight(struct task_struct *p, u32 weight) {}
+static void sched_ext_ops__set_cpumask(struct task_struct *p, const struct cpumask *mask) {}
+static void sched_ext_ops__update_idle(s32 cpu, bool idle) {}
+static void sched_ext_ops__cpu_acquire(s32 cpu, struct scx_cpu_acquire_args *args) {}
+static void sched_ext_ops__cpu_release(s32 cpu, struct scx_cpu_release_args *args) {}
+static s32 sched_ext_ops__init_task(struct task_struct *p, struct scx_init_task_args *args) { return -EINVAL; }
+static void sched_ext_ops__exit_task(struct task_struct *p, struct scx_exit_task_args *args) {}
+static void sched_ext_ops__enable(struct task_struct *p) {}
+static void sched_ext_ops__disable(struct task_struct *p) {}
 #ifdef CONFIG_EXT_GROUP_SCHED
-static s32 cgroup_init_stub(struct cgroup *cgrp, struct scx_cgroup_init_args *args) { return -EINVAL; }
-static void cgroup_exit_stub(struct cgroup *cgrp) {}
-static s32 cgroup_prep_move_stub(struct task_struct *p, struct cgroup *from, struct cgroup *to) { return -EINVAL; }
-static void cgroup_move_stub(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
-static void cgroup_cancel_move_stub(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
-static void cgroup_set_weight_stub(struct cgroup *cgrp, u32 weight) {}
+static s32 sched_ext_ops__cgroup_init(struct cgroup *cgrp, struct scx_cgroup_init_args *args) { return -EINVAL; }
+static void sched_ext_ops__cgroup_exit(struct cgroup *cgrp) {}
+static s32 sched_ext_ops__cgroup_prep_move(struct task_struct *p, struct cgroup *from, struct cgroup *to) { return -EINVAL; }
+static void sched_ext_ops__cgroup_move(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
+static void sched_ext_ops__cgroup_cancel_move(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
+static void sched_ext_ops__cgroup_set_weight(struct cgroup *cgrp, u32 weight) {}
 #endif
-static void cpu_online_stub(s32 cpu) {}
-static void cpu_offline_stub(s32 cpu) {}
-static s32 init_stub(void) { return -EINVAL; }
-static void exit_stub(struct scx_exit_info *info) {}
-static void dump_stub(struct scx_dump_ctx *ctx) {}
-static void dump_cpu_stub(struct scx_dump_ctx *ctx, s32 cpu, bool idle) {}
-static void dump_task_stub(struct scx_dump_ctx *ctx, struct task_struct *p) {}
+static void sched_ext_ops__cpu_online(s32 cpu) {}
+static void sched_ext_ops__cpu_offline(s32 cpu) {}
+static s32 sched_ext_ops__init(void) { return -EINVAL; }
+static void sched_ext_ops__exit(struct scx_exit_info *info) {}
+static void sched_ext_ops__dump(struct scx_dump_ctx *ctx) {}
+static void sched_ext_ops__dump_cpu(struct scx_dump_ctx *ctx, s32 cpu, bool idle) {}
+static void sched_ext_ops__dump_task(struct scx_dump_ctx *ctx, struct task_struct *p) {}
 
 static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
-	.select_cpu = select_cpu_stub,
-	.enqueue = enqueue_stub,
-	.dequeue = dequeue_stub,
-	.dispatch = dispatch_stub,
-	.tick = tick_stub,
-	.runnable = runnable_stub,
-	.running = running_stub,
-	.stopping = stopping_stub,
-	.quiescent = quiescent_stub,
-	.yield = yield_stub,
-	.core_sched_before = core_sched_before_stub,
-	.set_weight = set_weight_stub,
-	.set_cpumask = set_cpumask_stub,
-	.update_idle = update_idle_stub,
-	.cpu_acquire = cpu_acquire_stub,
-	.cpu_release = cpu_release_stub,
-	.init_task = init_task_stub,
-	.exit_task = exit_task_stub,
-	.enable = enable_stub,
-	.disable = disable_stub,
+	.select_cpu		= sched_ext_ops__select_cpu,
+	.enqueue		= sched_ext_ops__enqueue,
+	.dequeue		= sched_ext_ops__dequeue,
+	.dispatch		= sched_ext_ops__dispatch,
+	.tick			= sched_ext_ops__tick,
+	.runnable		= sched_ext_ops__runnable,
+	.running		= sched_ext_ops__running,
+	.stopping		= sched_ext_ops__stopping,
+	.quiescent		= sched_ext_ops__quiescent,
+	.yield			= sched_ext_ops__yield,
+	.core_sched_before	= sched_ext_ops__core_sched_before,
+	.set_weight		= sched_ext_ops__set_weight,
+	.set_cpumask		= sched_ext_ops__set_cpumask,
+	.update_idle		= sched_ext_ops__update_idle,
+	.cpu_acquire		= sched_ext_ops__cpu_acquire,
+	.cpu_release		= sched_ext_ops__cpu_release,
+	.init_task		= sched_ext_ops__init_task,
+	.exit_task		= sched_ext_ops__exit_task,
+	.enable			= sched_ext_ops__enable,
+	.disable		= sched_ext_ops__disable,
 #ifdef CONFIG_EXT_GROUP_SCHED
-	.cgroup_init = cgroup_init_stub,
-	.cgroup_exit = cgroup_exit_stub,
-	.cgroup_prep_move = cgroup_prep_move_stub,
-	.cgroup_move = cgroup_move_stub,
-	.cgroup_cancel_move = cgroup_cancel_move_stub,
-	.cgroup_set_weight = cgroup_set_weight_stub,
+	.cgroup_init		= sched_ext_ops__cgroup_init,
+	.cgroup_exit		= sched_ext_ops__cgroup_exit,
+	.cgroup_prep_move	= sched_ext_ops__cgroup_prep_move,
+	.cgroup_move		= sched_ext_ops__cgroup_move,
+	.cgroup_cancel_move	= sched_ext_ops__cgroup_cancel_move,
+	.cgroup_set_weight	= sched_ext_ops__cgroup_set_weight,
 #endif
-	.cpu_online = cpu_online_stub,
-	.cpu_offline = cpu_offline_stub,
-	.init = init_stub,
-	.exit = exit_stub,
-	.dump = dump_stub,
-	.dump_cpu = dump_cpu_stub,
-	.dump_task = dump_task_stub,
+	.cpu_online		= sched_ext_ops__cpu_online,
+	.cpu_offline		= sched_ext_ops__cpu_offline,
+	.init			= sched_ext_ops__init,
+	.exit			= sched_ext_ops__exit,
+	.dump			= sched_ext_ops__dump,
+	.dump_cpu		= sched_ext_ops__dump_cpu,
+	.dump_task		= sched_ext_ops__dump_task,
 };
 
 static struct bpf_struct_ops bpf_sched_ext_ops = {

