Return-Path: <bpf+bounces-69060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B717B8BC1D
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5B9B620BD
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF0D2D77E2;
	Sat, 20 Sep 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9MZoj+x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870B2D6621;
	Sat, 20 Sep 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330001; cv=none; b=IPkVKZCZJ8migvYTTn3GAPwbh3fcPN+S7wCqCwKpaeFa/0Hn0prsvcYrV+02YAsrF8n1I4FQqETsk8t6d5pTYOv2U1QVbNnabqGT/ltFLKZNiuWnfxl7HdzoSPZgLjn4whHqOJGsaFCm18sUTHNAjS1rIqdB6quaYnwzh+AulO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330001; c=relaxed/simple;
	bh=yMJFjlK3fngMSTSS1m/ha8Wlj4JpZmjX9ptRA+4Adgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzqgTL/s0xJaoNRuQw00ZZzfmGKM87bPmYGFDU4b6WNExZDeqGFVXRWR249I4b6CGwwPVSfkdPac6vWoXcfdjK734Qjm6cvmhA7R6k4T5Ab8XUrBvorHQLlKPw8LxWiOSL659hQWHr+hKntl20hNj7lJz5SxcxwvAmL6Xmd20Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9MZoj+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CE3C4CEF0;
	Sat, 20 Sep 2025 01:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330001;
	bh=yMJFjlK3fngMSTSS1m/ha8Wlj4JpZmjX9ptRA+4Adgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9MZoj+x6le9yua23wdQzt8M6N8/wknOKZ1wtRarav7BBvD1utzg3oQBLAp3TNBB/
	 rSMotf6+nb7EJXpYsidCv6Ngw+pZkjfv1kA+DHWu0YFTy/V2XA/W2t8QMwQz67No4k
	 0ue++giuZPU/z8nEpg4vFC1R5dps/2CU4nMH5ugEulT/3WIliWv2lNbZyIfXEiqYHH
	 2k6BeQi8SP96GPCtTHffiFE5ezvSo5k9pu7sSvdZrYHvw/Ov8n3ixRbcuLi5EsT0X7
	 tt2ReIIeP0Z++WlWdR+98mzKXIOtZfsh08obF6Ulmaxf0n8mvv+iMKfKjnwX1XV5rv
	 nddcvVSvVmiGg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 26/46] sched_ext: Introduce scx_prog_sched()
Date: Fri, 19 Sep 2025 14:58:49 -1000
Message-ID: <20250920005931.2753828-27-tj@kernel.org>
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

In preparation of multiple scheduler support, add add scx_prog_sched()
accessor which returns the assocaited scx_sched given the magic BPF
parameter @aux__prog on kfuncs.

As scx_root is still the only scheduler, this shouldn't introduce
user-visible behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 110 +++++++++++++++++++++++-------------
 kernel/sched/ext_idle.c     |  72 +++++++++++++++--------
 kernel/sched/ext_internal.h |  33 +++++++++++
 3 files changed, 154 insertions(+), 61 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e041c2f0cdc3..b5f5106ddbf8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5902,6 +5902,7 @@ __bpf_kfunc_start_defs();
  * @dsq_id: DSQ to insert into
  * @slice: duration @p can run for in nsecs, 0 to keep the current value
  * @enq_flags: SCX_ENQ_*
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Insert @p into the FIFO queue of the DSQ identified by @dsq_id. It is safe to
  * call this function spuriously. Can be called from ops.enqueue(),
@@ -5932,12 +5933,13 @@ __bpf_kfunc_start_defs();
  * scx_bpf_kick_cpu() to trigger scheduling.
  */
 __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice,
-				    u64 enq_flags)
+				    u64 enq_flags,
+				    const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return;
 
@@ -5979,7 +5981,13 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 	struct scx_sched *sch;
 
 	guard(rcu)();
-	sch = rcu_dereference(scx_root);
+	/*
+	 * FIXME - This should be scx_prog_sched() so that we can verify that
+	 * the calling scheduler has authority over @p. However, due to BPF
+	 * funcation all parameter count limit, we can't add @aux__prog to this
+	 * function. This can be fixed by packing the parameters into a struct.
+	 */
+	sch = scx_task_sched(p);
 	if (unlikely(!sch))
 		return;
 
@@ -6099,16 +6107,17 @@ __bpf_kfunc_start_defs();
 
 /**
  * scx_bpf_dispatch_nr_slots - Return the number of remaining dispatch slots
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Can only be called from ops.dispatch().
  */
-__bpf_kfunc u32 scx_bpf_dispatch_nr_slots(void)
+__bpf_kfunc u32 scx_bpf_dispatch_nr_slots(const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return 0;
 
@@ -6120,18 +6129,19 @@ __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(void)
 
 /**
  * scx_bpf_dispatch_cancel - Cancel the latest dispatch
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Cancel the latest dispatch. Can be called multiple times to cancel further
  * dispatches. Can only be called from ops.dispatch().
  */
-__bpf_kfunc void scx_bpf_dispatch_cancel(void)
+__bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return;
 
@@ -6147,6 +6157,7 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(void)
 /**
  * scx_bpf_dsq_move_to_local - move a task from a DSQ to the current CPU's local DSQ
  * @dsq_id: DSQ to move task from
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Move a task from the non-local DSQ identified by @dsq_id to the current CPU's
  * local DSQ for execution. Can only be called from ops.dispatch().
@@ -6158,7 +6169,8 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(void)
  * Returns %true if a task has been moved, %false if there isn't any task to
  * move.
  */
-__bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
+__bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id,
+					   const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_dispatch_q *dsq;
@@ -6166,7 +6178,7 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return false;
 
@@ -6310,12 +6322,13 @@ __bpf_kfunc_start_defs();
 
 /**
  * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Iterate over all of the tasks currently enqueued on the local DSQ of the
  * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the number of
  * processed tasks. Can only be called from ops.cpu_release().
  */
-__bpf_kfunc u32 scx_bpf_reenqueue_local(void)
+__bpf_kfunc u32 scx_bpf_reenqueue_local(const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 	LIST_HEAD(tasks);
@@ -6324,7 +6337,7 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
 	struct task_struct *p, *n;
 
 	guard(rcu)();
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return 0;
 
@@ -6389,11 +6402,13 @@ __bpf_kfunc_start_defs();
  * scx_bpf_create_dsq - Create a custom DSQ
  * @dsq_id: DSQ to create
  * @node: NUMA node to allocate from
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Create a custom DSQ identified by @dsq_id. Can be called from any sleepable
  * scx callback, and any BPF_PROG_TYPE_SYSCALL prog.
  */
-__bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
+__bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node,
+				   const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_dispatch_q *dsq;
 	struct scx_sched *sch;
@@ -6412,7 +6427,7 @@ __bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
 
 	rcu_read_lock();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (sch) {
 		init_dsq(dsq, dsq_id, sch);
 		ret = rhashtable_lookup_insert_fast(&sch->dsq_hash, &dsq->hash_node,
@@ -6501,18 +6516,20 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
  * scx_bpf_kick_cpu - Trigger reschedule on a CPU
  * @cpu: cpu to kick
  * @flags: %SCX_KICK_* flags
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Kick @cpu into rescheduling. This can be used to wake up an idle CPU or
  * trigger rescheduling on a busy CPU. This can be called from any online
  * scx_ops operation and the actual kicking is performed asynchronously through
  * an irq work.
  */
-__bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags)
+__bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags,
+				  const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (likely(sch))
 		scx_kick_cpu(sch, cpu, flags);
 }
@@ -6592,10 +6609,11 @@ __bpf_kfunc void scx_bpf_destroy_dsq(u64 dsq_id)
  * tasks which are already queued when this function is invoked.
  */
 __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
-				     u64 flags)
+				     u64 flags,
+				     const struct bpf_prog_aux *aux__prog)
 {
 	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
-	struct scx_sched *sch;
+	struct scx_sched *sch = scx_prog_sched(aux__prog);
 
 	BUILD_BUG_ON(sizeof(struct bpf_iter_scx_dsq_kern) >
 		     sizeof(struct bpf_iter_scx_dsq));
@@ -6608,7 +6626,6 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
 	 */
 	kit->dsq = NULL;
 
-	sch = rcu_dereference_check(scx_root, rcu_read_lock_bh_held());
 	if (unlikely(!sch))
 		return -ENODEV;
 
@@ -6749,18 +6766,20 @@ __bpf_kfunc_start_defs();
  * @fmt: error message format string
  * @data: format string parameters packaged using ___bpf_fill() macro
  * @data__sz: @data len, must end in '__sz' for the verifier
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Indicate that the BPF scheduler wants to exit gracefully, and initiate ops
  * disabling.
  */
 __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
-				   unsigned long long *data, u32 data__sz)
+				   unsigned long long *data, u32 data__sz,
+				   const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
-	sch = rcu_dereference_bh(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (likely(sch) &&
 	    bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
 		scx_exit(sch, SCX_EXIT_UNREG_BPF, exit_code, "%s", scx_exit_bstr_buf.line);
@@ -6772,18 +6791,20 @@ __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
  * @fmt: error message format string
  * @data: format string parameters packaged using ___bpf_fill() macro
  * @data__sz: @data len, must end in '__sz' for the verifier
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Indicate that the BPF scheduler encountered a fatal error and initiate ops
  * disabling.
  */
 __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
-				    u32 data__sz)
+				    u32 data__sz,
+				    const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
-	sch = rcu_dereference_bh(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (likely(sch) &&
 	    bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
 		scx_exit(sch, SCX_EXIT_ERROR_BPF, 0, "%s", scx_exit_bstr_buf.line);
@@ -6795,6 +6816,7 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
  * @fmt: format string
  * @data: format string parameters packaged using ___bpf_fill() macro
  * @data__sz: @data len, must end in '__sz' for the verifier
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * To be called through scx_bpf_dump() helper from ops.dump(), dump_cpu() and
  * dump_task() to generate extra debug dump specific to the BPF scheduler.
@@ -6803,7 +6825,8 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
  * multiple calls. The last line is automatically terminated.
  */
 __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
-				   u32 data__sz)
+				   u32 data__sz,
+				   const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 	struct scx_dump_data *dd = &scx_dump_data;
@@ -6812,7 +6835,7 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return;
 
@@ -6851,18 +6874,19 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
 /**
  * scx_bpf_cpuperf_cap - Query the maximum relative capacity of a CPU
  * @cpu: CPU of interest
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Return the maximum relative capacity of @cpu in relation to the most
  * performant CPU in the system. The return value is in the range [1,
  * %SCX_CPUPERF_ONE]. See scx_bpf_cpuperf_cur().
  */
-__bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu)
+__bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu, const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (likely(sch) && ops_cpu_valid(sch, cpu, NULL))
 		return arch_scale_cpu_capacity(cpu);
 	else
@@ -6872,6 +6896,7 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu)
 /**
  * scx_bpf_cpuperf_cur - Query the current relative performance of a CPU
  * @cpu: CPU of interest
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Return the current relative performance of @cpu in relation to its maximum.
  * The return value is in the range [1, %SCX_CPUPERF_ONE].
@@ -6883,13 +6908,13 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu)
  *
  * The result is in the range [1, %SCX_CPUPERF_ONE].
  */
-__bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
+__bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu, const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (likely(sch) && ops_cpu_valid(sch, cpu, NULL))
 		return arch_scale_freq_capacity(cpu);
 	else
@@ -6900,6 +6925,7 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
  * scx_bpf_cpuperf_set - Set the relative performance target of a CPU
  * @cpu: CPU of interest
  * @perf: target performance level [0, %SCX_CPUPERF_ONE]
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Set the target performance level of @cpu to @perf. @perf is in linear
  * relative scale between 0 and %SCX_CPUPERF_ONE. This determines how the
@@ -6910,13 +6936,14 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
  * use. Consult hardware and cpufreq documentation for more information. The
  * current performance level can be monitored using scx_bpf_cpuperf_cur().
  */
-__bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf)
+__bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf,
+				     const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(sch);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return;
 
@@ -7026,14 +7053,16 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
 /**
  * scx_bpf_cpu_rq - Fetch the rq of a CPU
  * @cpu: CPU of the rq
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  */
-__bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
+__bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu,
+				      const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return NULL;
 
@@ -7052,18 +7081,19 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 
 /**
  * scx_bpf_locked_rq - Return the rq currently locked by SCX
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Returns the rq if a rq lock is currently held by SCX.
  * Otherwise emits an error and returns NULL.
  */
-__bpf_kfunc struct rq *scx_bpf_locked_rq(void)
+__bpf_kfunc struct rq *scx_bpf_locked_rq(const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 	struct rq *rq;
 
 	guard(preempt)();
 
-	sch = rcu_dereference_sched(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return NULL;
 
@@ -7079,16 +7109,18 @@ __bpf_kfunc struct rq *scx_bpf_locked_rq(void)
 /**
  * scx_bpf_cpu_curr - Return remote CPU's curr task
  * @cpu: CPU of interest
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Callers must hold RCU read lock (KF_RCU).
  */
-__bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu)
+__bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu,
+						 const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return NULL;
 
@@ -7101,6 +7133,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu)
 /**
  * scx_bpf_task_cgroup - Return the sched cgroup of a task
  * @p: task of interest
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * @p->sched_task_group->css.cgroup represents the cgroup @p is associated with
  * from the scheduler's POV. SCX operations should use this function to
@@ -7110,7 +7143,8 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu)
  * operations. The restriction guarantees that @p's rq is locked by the caller.
  */
 #ifdef CONFIG_CGROUP_SCHED
-__bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
+__bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
+					       const struct bpf_prog_aux *aux__prog)
 {
 	struct task_group *tg = p->sched_task_group;
 	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
@@ -7118,7 +7152,7 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		goto out;
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index c57779f0ad57..ce9c2f345ec5 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -920,14 +920,15 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
  * scx_bpf_cpu_node - Return the NUMA node the given @cpu belongs to, or
  *		      trigger an error if @cpu is invalid
  * @cpu: target CPU
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  */
-__bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
+__bpf_kfunc int scx_bpf_cpu_node(s32 cpu, const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch) || !ops_cpu_valid(sch, cpu, NULL))
 		return NUMA_NO_NODE;
 	return cpu_to_node(cpu);
@@ -939,6 +940,7 @@ __bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
  * @prev_cpu: CPU @p was on previously
  * @wake_flags: %SCX_WAKE_* flags
  * @is_idle: out parameter indicating whether the returned CPU is idle
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Can be called from ops.select_cpu(), ops.enqueue(), or from an unlocked
  * context such as a BPF test_run() call, as long as built-in CPU selection
@@ -949,14 +951,15 @@ __bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
  * currently idle and thus a good candidate for direct dispatching.
  */
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
-				       u64 wake_flags, bool *is_idle)
+				       u64 wake_flags, bool *is_idle,
+				       const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 	s32 cpu;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return -ENODEV;
 
@@ -996,7 +999,12 @@ __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	/*
+	 * FIXME - This should be scx_prog_sched(). However, due to BPF
+	 * funcation all parameter count limit, we can't add @aux__prog to this
+	 * function. This can be fixed by packing the parameters into a struct.
+	 */
+	sch = scx_task_sched(p);
 	if (unlikely(!sch))
 		return -ENODEV;
 
@@ -1008,18 +1016,20 @@ __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64
  * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
  * idle-tracking per-CPU cpumask of a target NUMA node.
  * @node: target NUMA node
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Returns an empty cpumask if idle tracking is not enabled, if @node is
  * not valid, or running on a UP kernel. In this case the actual error will
  * be reported to the BPF scheduler via scx_error().
  */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
+__bpf_kfunc const struct cpumask *
+scx_bpf_get_idle_cpumask_node(int node, const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return cpu_none_mask;
 
@@ -1033,17 +1043,19 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
 /**
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
  * per-CPU cpumask.
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Returns an empty mask if idle tracking is not enabled, or running on a
  * UP kernel.
  */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
+__bpf_kfunc const struct cpumask *
+scx_bpf_get_idle_cpumask(const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return cpu_none_mask;
 
@@ -1063,18 +1075,20 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
  * idle-tracking, per-physical-core cpumask of a target NUMA node. Can be
  * used to determine if an entire physical core is free.
  * @node: target NUMA node
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Returns an empty cpumask if idle tracking is not enabled, if @node is
  * not valid, or running on a UP kernel. In this case the actual error will
  * be reported to the BPF scheduler via scx_error().
  */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
+__bpf_kfunc const struct cpumask *
+scx_bpf_get_idle_smtmask_node(int node, const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return cpu_none_mask;
 
@@ -1092,17 +1106,19 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
  * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
  * per-physical-core cpumask. Can be used to determine if an entire physical
  * core is free.
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Returns an empty mask if idle tracking is not enabled, or running on a
  * UP kernel.
  */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
+__bpf_kfunc const struct cpumask *
+scx_bpf_get_idle_smtmask(const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return cpu_none_mask;
 
@@ -1138,6 +1154,7 @@ __bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
 /**
  * scx_bpf_test_and_clear_cpu_idle - Test and clear @cpu's idle state
  * @cpu: cpu to test and clear idle for
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Returns %true if @cpu was idle and its idle state was successfully cleared.
  * %false otherwise.
@@ -1145,13 +1162,14 @@ __bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
  * Unavailable if ops.update_idle() is implemented and
  * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
  */
-__bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
+__bpf_kfunc bool
+scx_bpf_test_and_clear_cpu_idle(s32 cpu, const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return false;
 
@@ -1169,6 +1187,7 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
  * @cpus_allowed: Allowed cpumask
  * @node: target NUMA node
  * @flags: %SCX_PICK_IDLE_* flags
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
  *
@@ -1184,13 +1203,14 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
  * %SCX_OPS_BUILTIN_IDLE_PER_NODE is not set.
  */
 __bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
-					   int node, u64 flags)
+					   int node, u64 flags,
+					   const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return -ENODEV;
 
@@ -1205,6 +1225,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
  * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
  * @cpus_allowed: Allowed cpumask
  * @flags: %SCX_PICK_IDLE_CPU_* flags
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Pick and claim an idle cpu in @cpus_allowed. Returns the picked idle cpu
  * number on success. -%EBUSY if no matching cpu was found.
@@ -1224,13 +1245,14 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
  * scx_bpf_pick_idle_cpu_node() instead.
  */
 __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
-				      u64 flags)
+				      u64 flags,
+				      const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return -ENODEV;
 
@@ -1251,6 +1273,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
  * @cpus_allowed: Allowed cpumask
  * @node: target NUMA node
  * @flags: %SCX_PICK_IDLE_CPU_* flags
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Pick and claim an idle cpu in @cpus_allowed. If none is available, pick any
  * CPU in @cpus_allowed. Guaranteed to succeed and returns the picked idle cpu
@@ -1267,14 +1290,15 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
  * CPU.
  */
 __bpf_kfunc s32 scx_bpf_pick_any_cpu_node(const struct cpumask *cpus_allowed,
-					  int node, u64 flags)
+					  int node, u64 flags,
+					  const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 	s32 cpu;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return -ENODEV;
 
@@ -1300,6 +1324,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu_node(const struct cpumask *cpus_allowed,
  * scx_bpf_pick_any_cpu - Pick and claim an idle cpu if available or pick any CPU
  * @cpus_allowed: Allowed cpumask
  * @flags: %SCX_PICK_IDLE_CPU_* flags
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Pick and claim an idle cpu in @cpus_allowed. If none is available, pick any
  * CPU in @cpus_allowed. Guaranteed to succeed and returns the picked idle cpu
@@ -1314,14 +1339,15 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu_node(const struct cpumask *cpus_allowed,
  * scx_bpf_pick_any_cpu_node() instead.
  */
 __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
-				     u64 flags)
+				     u64 flags,
+				     const struct bpf_prog_aux *aux__prog)
 {
 	struct scx_sched *sch;
 	s32 cpu;
 
 	guard(rcu)();
 
-	sch = rcu_dereference(scx_root);
+	sch = scx_prog_sched(aux__prog);
 	if (unlikely(!sch))
 		return -ENODEV;
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index aaf606e5d0de..64d0f0787c8e 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1157,6 +1157,32 @@ static inline struct scx_sched *scx_task_sched_rcu(const struct task_struct *p)
 				     rcu_read_lock_bh_held() ||
 				     rcu_read_lock_sched_held());
 }
+
+/**
+ * scx_prog_sched - Find scx_sched associated with a BPF prog
+ * @aux: aux__prog passed in from BPF to a kfunc
+ *
+ * To be called from kfuncs. Return the scheduler instance associated with the
+ * BPF program given the special kfunc argument aux__prog. The returned
+ * scx_sched is RCU protected.
+ */
+static struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+
+	sch = rcu_dereference_check(aux->priv,
+				    rcu_read_lock_bh_held() ||
+				    rcu_read_lock_sched_held());
+	if (unlikely(IS_ERR(sch)))
+		return NULL;
+
+	if (sch)
+		return sch;
+
+	return rcu_dereference_check(scx_root,
+				     rcu_read_lock_bh_held() ||
+				     rcu_read_lock_sched_held());
+}
 #else	/* CONFIG_EXT_SUB_SCHED */
 static inline struct scx_sched *scx_task_sched(const struct task_struct *p)
 {
@@ -1170,4 +1196,11 @@ static inline struct scx_sched *scx_task_sched_rcu(const struct task_struct *p)
 				     rcu_read_lock_bh_held() ||
 				     rcu_read_lock_sched_held());
 }
+
+static struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
+{
+	return rcu_dereference_check(scx_root,
+				     rcu_read_lock_bh_held() ||
+				     rcu_read_lock_sched_held());
+}
 #endif	/* CONFIG_EXT_SUB_SCHED */
-- 
2.51.0


