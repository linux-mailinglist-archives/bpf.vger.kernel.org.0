Return-Path: <bpf+bounces-48623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D43A0A148
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 07:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D4D16B825
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 06:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3390615B980;
	Sat, 11 Jan 2025 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RHjbXQqW"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9243166;
	Sat, 11 Jan 2025 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736577102; cv=none; b=Ce133431qzPKDqBc2zoG9fUWg1C1PxKEPwXHEBXQdvtFNLFvgwr0zt8/eBVFcvH10wMERt3zO/mq9D9EqNNwpAX8/bPCj9N4BcVyUmmXosQACdez2ksBDoJtveVDSwFvZj12gawgchFrUZBRd8oahtFtcc7ycc1sLTtfdKTuP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736577102; c=relaxed/simple;
	bh=J4SuczKxfVWevjvv2EhQzbI8U1DvqGiZNPwalW4X7+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akXiA4tIlR2SKolUR86qM1D4oZGY8HhEJxSoOXh9JeglUv62c5Qq9DcTOSLpBB1D0m54YytLGK3WGO6Ii8dcnWQbYWKEar8YkD9TXakV7yJKfqvViXNuBCe33NXgj4kGn7m0jOOBBQJMYfhN4knQfVvOgZecY4lasrGOZfKvEw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RHjbXQqW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=emMUuaoYDW5h2gFaRSz6DgyjqunkUKp6WYLLT9+tKaE=; b=RHjbXQqWpa2ZKwImzhvQIrPYs4
	sceBN5c64nWVaWF7kSai78wzAG9dL7fwdXnE5hCGWwIZumBKNxLww0S8EvBafe5w8pFsIpRioteJx
	hW/kCQnHRDzvkD+JMCEIcQX4yx0MrMhlECdp+oHHxBaQgXuVVTZ9OF475unXCkTdRfmFe5acbbHUM
	y7OuTgcPoSG3WywKsQw5VTMGXuLj0CT1xlbqTnU3KZis09YMfGsukIuQj0gB3Z/6agX8QMh7TQXcz
	OhbWm7CdRimaa7NRvnS5Hni1ynAB99o8dtJR74JObL0na71mBqjpPg8yff86HF8PJZJ6VnfUgtMnx
	SYFXi08w==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tWV20-00000000HfV-3WtP;
	Sat, 11 Jan 2025 06:31:36 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH] sched_ext: fix kernel-doc warnings
Date: Fri, 10 Jan 2025 22:31:36 -0800
Message-ID: <20250111063136.910862-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct function parameter names and function names.
Use the correct kernel-doc comment format for struct sched_ext_ops
to eliminate a bunch of warnings.

ext.c:1418: warning: Excess function parameter 'include_dead' description in 'scx_task_iter_next_locked'
ext.c:7261: warning: expecting prototype for scx_bpf_dump(). Prototype was for scx_bpf_dump_bstr() instead
ext.c:7352: warning: Excess function parameter 'flags' description in 'scx_bpf_cpuperf_set'

ext.c:3150: warning: Function parameter or struct member 'in_fi' not described in 'scx_prio_less'
ext.c:4711: warning: Function parameter or struct member 'dur_s' not described in 'scx_softlockup'
ext.c:4775: warning: Function parameter or struct member 'bypass' not described in 'scx_ops_bypass'
ext.c:7453: warning: Function parameter or struct member 'idle_mask' not described in 'scx_bpf_put_idle_cpumask'

ext.c:209: warning: Incorrect use of kernel-doc format:          * select_cpu - Pick the target CPU for a task which is being woken up
ext.c:236: warning: Incorrect use of kernel-doc format:          * enqueue - Enqueue a task on the BPF scheduler
ext.c:251: warning: Incorrect use of kernel-doc format:          * dequeue - Remove a task from the BPF scheduler
ext.c:267: warning: Incorrect use of kernel-doc format:          * dispatch - Dispatch tasks from the BPF scheduler and/or user DSQs
ext.c:290: warning: Incorrect use of kernel-doc format:          * tick - Periodic tick
ext.c:300: warning: Incorrect use of kernel-doc format:          * runnable - A task is becoming runnable on its associated CPU
ext.c:327: warning: Incorrect use of kernel-doc format:          * running - A task is starting to run on its associated CPU
ext.c:335: warning: Incorrect use of kernel-doc format:          * stopping - A task is stopping execution
ext.c:346: warning: Incorrect use of kernel-doc format:          * quiescent - A task is becoming not runnable on its associated CPU
ext.c:366: warning: Incorrect use of kernel-doc format:          * yield - Yield CPU
ext.c:381: warning: Incorrect use of kernel-doc format:          * core_sched_before - Task ordering for core-sched
ext.c:399: warning: Incorrect use of kernel-doc format:          * set_weight - Set task weight
ext.c:408: warning: Incorrect use of kernel-doc format:          * set_cpumask - Set CPU affinity
ext.c:418: warning: Incorrect use of kernel-doc format:          * update_idle - Update the idle state of a CPU
ext.c:439: warning: Incorrect use of kernel-doc format:          * cpu_acquire - A CPU is becoming available to the BPF scheduler
ext.c:449: warning: Incorrect use of kernel-doc format:          * cpu_release - A CPU is taken away from the BPF scheduler
ext.c:461: warning: Incorrect use of kernel-doc format:          * init_task - Initialize a task to run in a BPF scheduler
ext.c:476: warning: Incorrect use of kernel-doc format:          * exit_task - Exit a previously-running task from the system
ext.c:485: warning: Incorrect use of kernel-doc format:          * enable - Enable BPF scheduling for a task
ext.c:494: warning: Incorrect use of kernel-doc format:          * disable - Disable BPF scheduling for a task
ext.c:504: warning: Incorrect use of kernel-doc format:          * dump - Dump BPF scheduler state on error
ext.c:512: warning: Incorrect use of kernel-doc format:          * dump_cpu - Dump BPF scheduler state for a CPU on error
ext.c:524: warning: Incorrect use of kernel-doc format:          * dump_task - Dump BPF scheduler state for a runnable task on error
ext.c:535: warning: Incorrect use of kernel-doc format:          * cgroup_init - Initialize a cgroup
ext.c:550: warning: Incorrect use of kernel-doc format:          * cgroup_exit - Exit a cgroup
ext.c:559: warning: Incorrect use of kernel-doc format:          * cgroup_prep_move - Prepare a task to be moved to a different cgroup
ext.c:574: warning: Incorrect use of kernel-doc format:          * cgroup_move - Commit cgroup move
ext.c:585: warning: Incorrect use of kernel-doc format:          * cgroup_cancel_move - Cancel cgroup move
ext.c:597: warning: Incorrect use of kernel-doc format:          * cgroup_set_weight - A cgroup's weight is being changed
ext.c:611: warning: Incorrect use of kernel-doc format:          * cpu_online - A CPU became online
ext.c:620: warning: Incorrect use of kernel-doc format:          * cpu_offline - A CPU is going offline
ext.c:633: warning: Incorrect use of kernel-doc format:          * init - Initialize the BPF scheduler
ext.c:638: warning: Incorrect use of kernel-doc format:          * exit - Clean up after the BPF scheduler
ext.c:648: warning: Incorrect use of kernel-doc format:          * dispatch_max_batch - Max nr of tasks that dispatch() can dispatch
ext.c:653: warning: Incorrect use of kernel-doc format:          * flags - %SCX_OPS_* flags
ext.c:658: warning: Incorrect use of kernel-doc format:          * timeout_ms - The maximum amount of time, in milliseconds, that a
ext.c:667: warning: Incorrect use of kernel-doc format:          * exit_dump_len - scx_exit_info.dump buffer length. If 0, the default
ext.c:673: warning: Incorrect use of kernel-doc format:          * hotplug_seq - A sequence number that may be set by the scheduler to
ext.c:682: warning: Incorrect use of kernel-doc format:          * name - BPF scheduler's name

ext.c:689: warning: Function parameter or struct member 'select_cpu' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'enqueue' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'dequeue' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'dispatch' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'tick' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'runnable' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'running' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'stopping' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'quiescent' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'yield' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'core_sched_before' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'set_weight' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'set_cpumask' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'update_idle' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'cpu_acquire' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'cpu_release' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'init_task' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'exit_task' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'enable' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'disable' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'dump' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'dump_cpu' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'dump_task' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'cgroup_init' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'cgroup_exit' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'cgroup_prep_move' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'cgroup_move' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'cgroup_cancel_move' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'cgroup_set_weight' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'cpu_online' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'cpu_offline' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'init' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'exit' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'dispatch_max_batch' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'flags' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'timeout_ms' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'exit_dump_len' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'hotplug_seq' not described in 'sched_ext_ops'
ext.c:689: warning: Function parameter or struct member 'name' not described in 'sched_ext_ops'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <changwoo@igalia.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org
---
 kernel/sched/ext.c |   87 ++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 42 deletions(-)

--- linux-next-20250108.orig/kernel/sched/ext.c
+++ linux-next-20250108/kernel/sched/ext.c
@@ -206,7 +206,7 @@ struct scx_dump_ctx {
  */
 struct sched_ext_ops {
 	/**
-	 * select_cpu - Pick the target CPU for a task which is being woken up
+	 * @select_cpu: Pick the target CPU for a task which is being woken up
 	 * @p: task being woken up
 	 * @prev_cpu: the cpu @p was on before sleeping
 	 * @wake_flags: SCX_WAKE_*
@@ -233,7 +233,7 @@ struct sched_ext_ops {
 	s32 (*select_cpu)(struct task_struct *p, s32 prev_cpu, u64 wake_flags);
 
 	/**
-	 * enqueue - Enqueue a task on the BPF scheduler
+	 * @enqueue: Enqueue a task on the BPF scheduler
 	 * @p: task being enqueued
 	 * @enq_flags: %SCX_ENQ_*
 	 *
@@ -248,7 +248,7 @@ struct sched_ext_ops {
 	void (*enqueue)(struct task_struct *p, u64 enq_flags);
 
 	/**
-	 * dequeue - Remove a task from the BPF scheduler
+	 * @dequeue: Remove a task from the BPF scheduler
 	 * @p: task being dequeued
 	 * @deq_flags: %SCX_DEQ_*
 	 *
@@ -264,7 +264,7 @@ struct sched_ext_ops {
 	void (*dequeue)(struct task_struct *p, u64 deq_flags);
 
 	/**
-	 * dispatch - Dispatch tasks from the BPF scheduler and/or user DSQs
+	 * @dispatch: Dispatch tasks from the BPF scheduler and/or user DSQs
 	 * @cpu: CPU to dispatch tasks for
 	 * @prev: previous task being switched out
 	 *
@@ -287,7 +287,7 @@ struct sched_ext_ops {
 	void (*dispatch)(s32 cpu, struct task_struct *prev);
 
 	/**
-	 * tick - Periodic tick
+	 * @tick: Periodic tick
 	 * @p: task running currently
 	 *
 	 * This operation is called every 1/HZ seconds on CPUs which are
@@ -297,7 +297,7 @@ struct sched_ext_ops {
 	void (*tick)(struct task_struct *p);
 
 	/**
-	 * runnable - A task is becoming runnable on its associated CPU
+	 * @runnable: A task is becoming runnable on its associated CPU
 	 * @p: task becoming runnable
 	 * @enq_flags: %SCX_ENQ_*
 	 *
@@ -324,7 +324,7 @@ struct sched_ext_ops {
 	void (*runnable)(struct task_struct *p, u64 enq_flags);
 
 	/**
-	 * running - A task is starting to run on its associated CPU
+	 * @running: A task is starting to run on its associated CPU
 	 * @p: task starting to run
 	 *
 	 * See ->runnable() for explanation on the task state notifiers.
@@ -332,7 +332,7 @@ struct sched_ext_ops {
 	void (*running)(struct task_struct *p);
 
 	/**
-	 * stopping - A task is stopping execution
+	 * @stopping: A task is stopping execution
 	 * @p: task stopping to run
 	 * @runnable: is task @p still runnable?
 	 *
@@ -343,7 +343,7 @@ struct sched_ext_ops {
 	void (*stopping)(struct task_struct *p, bool runnable);
 
 	/**
-	 * quiescent - A task is becoming not runnable on its associated CPU
+	 * @quiescent: A task is becoming not runnable on its associated CPU
 	 * @p: task becoming not runnable
 	 * @deq_flags: %SCX_DEQ_*
 	 *
@@ -363,7 +363,7 @@ struct sched_ext_ops {
 	void (*quiescent)(struct task_struct *p, u64 deq_flags);
 
 	/**
-	 * yield - Yield CPU
+	 * @yield: Yield CPU
 	 * @from: yielding task
 	 * @to: optional yield target task
 	 *
@@ -378,7 +378,7 @@ struct sched_ext_ops {
 	bool (*yield)(struct task_struct *from, struct task_struct *to);
 
 	/**
-	 * core_sched_before - Task ordering for core-sched
+	 * @core_sched_before: Task ordering for core-sched
 	 * @a: task A
 	 * @b: task B
 	 *
@@ -396,7 +396,7 @@ struct sched_ext_ops {
 	bool (*core_sched_before)(struct task_struct *a, struct task_struct *b);
 
 	/**
-	 * set_weight - Set task weight
+	 * @set_weight: Set task weight
 	 * @p: task to set weight for
 	 * @weight: new weight [1..10000]
 	 *
@@ -405,7 +405,7 @@ struct sched_ext_ops {
 	void (*set_weight)(struct task_struct *p, u32 weight);
 
 	/**
-	 * set_cpumask - Set CPU affinity
+	 * @set_cpumask: Set CPU affinity
 	 * @p: task to set CPU affinity for
 	 * @cpumask: cpumask of cpus that @p can run on
 	 *
@@ -415,7 +415,7 @@ struct sched_ext_ops {
 			    const struct cpumask *cpumask);
 
 	/**
-	 * update_idle - Update the idle state of a CPU
+	 * @update_idle: Update the idle state of a CPU
 	 * @cpu: CPU to udpate the idle state for
 	 * @idle: whether entering or exiting the idle state
 	 *
@@ -436,7 +436,7 @@ struct sched_ext_ops {
 	void (*update_idle)(s32 cpu, bool idle);
 
 	/**
-	 * cpu_acquire - A CPU is becoming available to the BPF scheduler
+	 * @cpu_acquire: A CPU is becoming available to the BPF scheduler
 	 * @cpu: The CPU being acquired by the BPF scheduler.
 	 * @args: Acquire arguments, see the struct definition.
 	 *
@@ -446,7 +446,7 @@ struct sched_ext_ops {
 	void (*cpu_acquire)(s32 cpu, struct scx_cpu_acquire_args *args);
 
 	/**
-	 * cpu_release - A CPU is taken away from the BPF scheduler
+	 * @cpu_release: A CPU is taken away from the BPF scheduler
 	 * @cpu: The CPU being released by the BPF scheduler.
 	 * @args: Release arguments, see the struct definition.
 	 *
@@ -458,7 +458,7 @@ struct sched_ext_ops {
 	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
 
 	/**
-	 * init_task - Initialize a task to run in a BPF scheduler
+	 * @init_task: Initialize a task to run in a BPF scheduler
 	 * @p: task to initialize for BPF scheduling
 	 * @args: init arguments, see the struct definition
 	 *
@@ -473,8 +473,9 @@ struct sched_ext_ops {
 	s32 (*init_task)(struct task_struct *p, struct scx_init_task_args *args);
 
 	/**
-	 * exit_task - Exit a previously-running task from the system
+	 * @exit_task: Exit a previously-running task from the system
 	 * @p: task to exit
+	 * @args: exit arguments, see the struct definition
 	 *
 	 * @p is exiting or the BPF scheduler is being unloaded. Perform any
 	 * necessary cleanup for @p.
@@ -482,7 +483,7 @@ struct sched_ext_ops {
 	void (*exit_task)(struct task_struct *p, struct scx_exit_task_args *args);
 
 	/**
-	 * enable - Enable BPF scheduling for a task
+	 * @enable: Enable BPF scheduling for a task
 	 * @p: task to enable BPF scheduling for
 	 *
 	 * Enable @p for BPF scheduling. enable() is called on @p any time it
@@ -491,7 +492,7 @@ struct sched_ext_ops {
 	void (*enable)(struct task_struct *p);
 
 	/**
-	 * disable - Disable BPF scheduling for a task
+	 * @disable: Disable BPF scheduling for a task
 	 * @p: task to disable BPF scheduling for
 	 *
 	 * @p is exiting, leaving SCX or the BPF scheduler is being unloaded.
@@ -501,7 +502,7 @@ struct sched_ext_ops {
 	void (*disable)(struct task_struct *p);
 
 	/**
-	 * dump - Dump BPF scheduler state on error
+	 * @dump: Dump BPF scheduler state on error
 	 * @ctx: debug dump context
 	 *
 	 * Use scx_bpf_dump() to generate BPF scheduler specific debug dump.
@@ -509,7 +510,7 @@ struct sched_ext_ops {
 	void (*dump)(struct scx_dump_ctx *ctx);
 
 	/**
-	 * dump_cpu - Dump BPF scheduler state for a CPU on error
+	 * @dump_cpu: Dump BPF scheduler state for a CPU on error
 	 * @ctx: debug dump context
 	 * @cpu: CPU to generate debug dump for
 	 * @idle: @cpu is currently idle without any runnable tasks
@@ -521,7 +522,7 @@ struct sched_ext_ops {
 	void (*dump_cpu)(struct scx_dump_ctx *ctx, s32 cpu, bool idle);
 
 	/**
-	 * dump_task - Dump BPF scheduler state for a runnable task on error
+	 * @dump_task: Dump BPF scheduler state for a runnable task on error
 	 * @ctx: debug dump context
 	 * @p: runnable task to generate debug dump for
 	 *
@@ -532,7 +533,7 @@ struct sched_ext_ops {
 
 #ifdef CONFIG_EXT_GROUP_SCHED
 	/**
-	 * cgroup_init - Initialize a cgroup
+	 * @cgroup_init: Initialize a cgroup
 	 * @cgrp: cgroup being initialized
 	 * @args: init arguments, see the struct definition
 	 *
@@ -547,7 +548,7 @@ struct sched_ext_ops {
 			   struct scx_cgroup_init_args *args);
 
 	/**
-	 * cgroup_exit - Exit a cgroup
+	 * @cgroup_exit: Exit a cgroup
 	 * @cgrp: cgroup being exited
 	 *
 	 * Either the BPF scheduler is being unloaded or @cgrp destroyed, exit
@@ -556,7 +557,7 @@ struct sched_ext_ops {
 	void (*cgroup_exit)(struct cgroup *cgrp);
 
 	/**
-	 * cgroup_prep_move - Prepare a task to be moved to a different cgroup
+	 * @cgroup_prep_move: Prepare a task to be moved to a different cgroup
 	 * @p: task being moved
 	 * @from: cgroup @p is being moved from
 	 * @to: cgroup @p is being moved to
@@ -571,7 +572,7 @@ struct sched_ext_ops {
 				struct cgroup *from, struct cgroup *to);
 
 	/**
-	 * cgroup_move - Commit cgroup move
+	 * @cgroup_move: Commit cgroup move
 	 * @p: task being moved
 	 * @from: cgroup @p is being moved from
 	 * @to: cgroup @p is being moved to
@@ -582,7 +583,7 @@ struct sched_ext_ops {
 			    struct cgroup *from, struct cgroup *to);
 
 	/**
-	 * cgroup_cancel_move - Cancel cgroup move
+	 * @cgroup_cancel_move: Cancel cgroup move
 	 * @p: task whose cgroup move is being canceled
 	 * @from: cgroup @p was being moved from
 	 * @to: cgroup @p was being moved to
@@ -594,7 +595,7 @@ struct sched_ext_ops {
 				   struct cgroup *from, struct cgroup *to);
 
 	/**
-	 * cgroup_set_weight - A cgroup's weight is being changed
+	 * @cgroup_set_weight: A cgroup's weight is being changed
 	 * @cgrp: cgroup whose weight is being updated
 	 * @weight: new weight [1..10000]
 	 *
@@ -608,7 +609,7 @@ struct sched_ext_ops {
 	 */
 
 	/**
-	 * cpu_online - A CPU became online
+	 * @cpu_online: A CPU became online
 	 * @cpu: CPU which just came up
 	 *
 	 * @cpu just came online. @cpu will not call ops.enqueue() or
@@ -617,7 +618,7 @@ struct sched_ext_ops {
 	void (*cpu_online)(s32 cpu);
 
 	/**
-	 * cpu_offline - A CPU is going offline
+	 * @cpu_offline: A CPU is going offline
 	 * @cpu: CPU which is going offline
 	 *
 	 * @cpu is going offline. @cpu will not call ops.enqueue() or
@@ -630,12 +631,12 @@ struct sched_ext_ops {
 	 */
 
 	/**
-	 * init - Initialize the BPF scheduler
+	 * @init: Initialize the BPF scheduler
 	 */
 	s32 (*init)(void);
 
 	/**
-	 * exit - Clean up after the BPF scheduler
+	 * @exit: Clean up after the BPF scheduler
 	 * @info: Exit info
 	 *
 	 * ops.exit() is also called on ops.init() failure, which is a bit
@@ -645,17 +646,17 @@ struct sched_ext_ops {
 	void (*exit)(struct scx_exit_info *info);
 
 	/**
-	 * dispatch_max_batch - Max nr of tasks that dispatch() can dispatch
+	 * @dispatch_max_batch: Max nr of tasks that dispatch() can dispatch
 	 */
 	u32 dispatch_max_batch;
 
 	/**
-	 * flags - %SCX_OPS_* flags
+	 * @flags: %SCX_OPS_* flags
 	 */
 	u64 flags;
 
 	/**
-	 * timeout_ms - The maximum amount of time, in milliseconds, that a
+	 * @timeout_ms: The maximum amount of time, in milliseconds, that a
 	 * runnable task should be able to wait before being scheduled. The
 	 * maximum timeout may not exceed the default timeout of 30 seconds.
 	 *
@@ -664,13 +665,13 @@ struct sched_ext_ops {
 	u32 timeout_ms;
 
 	/**
-	 * exit_dump_len - scx_exit_info.dump buffer length. If 0, the default
+	 * @exit_dump_len: scx_exit_info.dump buffer length. If 0, the default
 	 * value of 32768 is used.
 	 */
 	u32 exit_dump_len;
 
 	/**
-	 * hotplug_seq - A sequence number that may be set by the scheduler to
+	 * @hotplug_seq: A sequence number that may be set by the scheduler to
 	 * detect when a hotplug event has occurred during the loading process.
 	 * If 0, no detection occurs. Otherwise, the scheduler will fail to
 	 * load if the sequence number does not match @scx_hotplug_seq on the
@@ -679,7 +680,7 @@ struct sched_ext_ops {
 	u64 hotplug_seq;
 
 	/**
-	 * name - BPF scheduler's name
+	 * @name: BPF scheduler's name
 	 *
 	 * Must be a non-zero valid BPF object name including only isalnum(),
 	 * '_' and '.' chars. Shows up in kernel.sched_ext_ops sysctl while the
@@ -1408,7 +1409,6 @@ static struct task_struct *scx_task_iter
 /**
  * scx_task_iter_next_locked - Next non-idle task with its rq locked
  * @iter: iterator to walk
- * @include_dead: Whether we should include dead tasks in the iteration
  *
  * Visit the non-idle task with its rq lock held. Allows callers to specify
  * whether they would like to filter out dead tasks. See scx_task_iter_start()
@@ -3132,6 +3132,7 @@ static struct task_struct *pick_task_scx
  * scx_prio_less - Task ordering for core-sched
  * @a: task A
  * @b: task B
+ * @in_fi: in forced idle state
  *
  * Core-sched is implemented as an additional scheduling layer on top of the
  * usual sched_class'es and needs to find out the expected task ordering. For
@@ -4700,6 +4701,7 @@ bool task_should_scx(int policy)
 
 /**
  * scx_softlockup - sched_ext softlockup handler
+ * @dur_s: number of seconds of CPU stuck due to soft lockup
  *
  * On some multi-socket setups (e.g. 2x Intel 8480c), the BPF scheduler can
  * live-lock the system by making many CPUs target the same DSQ to the point
@@ -4743,6 +4745,7 @@ static void scx_clear_softlockup(void)
 
 /**
  * scx_ops_bypass - [Un]bypass scx_ops and guarantee forward progress
+ * @bypass: true for bypass, false for unbypass
  *
  * Bypassing guarantees that all runnable tasks make forward progress without
  * trusting the BPF scheduler. We can't grab any mutexes or rwsems as they might
@@ -7245,7 +7248,7 @@ __bpf_kfunc void scx_bpf_error_bstr(char
 }
 
 /**
- * scx_bpf_dump - Generate extra debug dump specific to the BPF scheduler
+ * scx_bpf_dump_bstr - Generate extra debug dump specific to the BPF scheduler
  * @fmt: format string
  * @data: format string parameters packaged using ___bpf_fill() macro
  * @data__sz: @data len, must end in '__sz' for the verifier
@@ -7337,7 +7340,6 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32
  * scx_bpf_cpuperf_set - Set the relative performance target of a CPU
  * @cpu: CPU of interest
  * @perf: target performance level [0, %SCX_CPUPERF_ONE]
- * @flags: %SCX_CPUPERF_* flags
  *
  * Set the target performance level of @cpu to @perf. @perf is in linear
  * relative scale between 0 and %SCX_CPUPERF_ONE. This determines how the
@@ -7449,6 +7451,7 @@ __bpf_kfunc const struct cpumask *scx_bp
 /**
  * scx_bpf_put_idle_cpumask - Release a previously acquired referenced kptr to
  * either the percpu, or SMT idle-tracking cpumask.
+ * @idle_mask: &cpumask to use
  */
 __bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
 {

