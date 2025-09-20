Return-Path: <bpf+bounces-69075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E19D6B8BC9C
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3857B64E02
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBFF22156B;
	Sat, 20 Sep 2025 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slEjjO4j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3591E9B1C;
	Sat, 20 Sep 2025 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330019; cv=none; b=d2IlgD834SyFC2Owbk2G5Lrpy+DgO8D1udJZoinFtwlHdE4FtwU39OM/MdCpHfb6RpAl/DDGVbeif95wDBxdL2jgiMu4wdfRTbmlJha+k01zEEpYbov4RA5UtRTrS66CUrnEsvgpKT04L9CIBJt6aYAbSkc8mHfGQbhuKsPz4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330019; c=relaxed/simple;
	bh=RbDMAT+oNbBn4KVYlVpHc3ufuhDAkkOLCYJtZxy+hGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwjjwn7hG4xo1vdhqlD32eqUlvLKbtKTo+BuktxFHbBQuYE0Y+vwllgjbrqXEP5jwny4hs66rTt6BxbUvsQYIFku/BbuLxriCmAIztNgdzOnlaUoLO1CLhYtfrUe2T7teQDLkMaoht6Wne5Q4yvmiqDmSrpK607U9AnjhGpjy8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slEjjO4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3254C4CEF0;
	Sat, 20 Sep 2025 01:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330018;
	bh=RbDMAT+oNbBn4KVYlVpHc3ufuhDAkkOLCYJtZxy+hGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slEjjO4jTuh45kdpfj6xfqlELdoKpz1faAJNgnm7qTmu5OKmfYwOikebYdNLF3ihf
	 7Ul+ZUP8qw95dhknn55sEzQAGK9MbrrE2ScFBnDjNdOnRt4BHmnPupLzt2CPMqHylg
	 9MoUy0MYROaD6EXPxI8h3MzzAIevrttXU4ZL4ug33ZeYesh+DWFK+dlQ5AkV425mx9
	 kP0snMgdz241UnARLVyxr5/zRwOBYt7O7QtrQCjXmUXdgIOrJE6MKJLZZ85PTXsIU+
	 Xgur6tNnRS4ebkY+b4HF6aUhHuX7pIKCOr+V3YUHqVN6tFlFIaR7XPkoBX9OwkRwv9
	 kC8hQrmeOKmKg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 41/46] HACK_NOT_FOR_UPSTREAM: sched_ext: Work around @aux__prog prototype mismatch
Date: Fri, 19 Sep 2025 14:59:04 -1000
Message-ID: <20250920005931.2753828-42-tj@kernel.org>
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

Hide them using macros. This breaks binary compatibility. There should be a
better way.

NOT_SIGNED_OFF
---
 tools/sched_ext/include/scx/common.bpf.h | 88 ++++++++++++++++--------
 tools/sched_ext/include/scx/compat.bpf.h |  7 +-
 tools/sched_ext/scx_qmap.bpf.c           |  6 +-
 3 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 06e2551033cb..6bf75f970237 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -58,54 +58,86 @@ static inline void ___vmlinux_h_sanity_check___(void)
 		       "bpftool generated vmlinux.h is missing high bits for 64bit enums, upgrade clang and pahole");
 }
 
-s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
+/*
+ * XXX TEMPORARY - Each macro that has the same name as the preceding kfunc is
+ * to work around aux__prog issue. This causes a whole bunch of other problems.
+ * This is to work around just enough for testing and verification for now.
+ */
+s32 scx_bpf_create_dsq(u64 dsq_id, s32 node, const struct bpf_prog_aux *aux__prog) __ksym;
+#define scx_bpf_create_dsq(dsq_id, node) scx_bpf_create_dsq((dsq_id), (node), NULL)
 s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
 s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 			   const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
-void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
+void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags,
+			const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags) scx_bpf_dsq_insert((p), (dsq_id), (slice), (enq_flags), NULL)
 void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
-u32 scx_bpf_dispatch_nr_slots(void) __ksym;
-void scx_bpf_dispatch_cancel(void) __ksym;
-bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
+u32 scx_bpf_dispatch_nr_slots(const struct bpf_prog_aux *aux__prog) __ksym;
+#define scx_bpf_dispatch_nr_slots() scx_bpf_dispatch_nr_slots(NULL)
+void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux__prog) __ksym;
+#define scx_bpf_dispatch_cancel() scx_bpf_dispatch_cancel(NULL)
+bool scx_bpf_dsq_move_to_local(u64 dsq_id, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_dsq_move_to_local(dsq_id) scx_bpf_dsq_move_to_local(dsq_id, NULL)
 void scx_bpf_dsq_move_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
 void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
 bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
-u32 scx_bpf_reenqueue_local(void) __ksym;
-void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
+u32 scx_bpf_reenqueue_local(const struct bpf_prog_aux *aux__prog) __ksym;
+#define scx_bpf_reenqueue_local() scx_bpf_reenqueue_local(NULL)
+void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux__prog) __ksym;
+#define scx_bpf_kick_cpu(cpu, flags) scx_bpf_kick_cpu((cpu), (flags), NULL)
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
-int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
+int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+//#define bpf_iter_scx_dsq_new(it, dsq_id, flags) bpf_iter_scx_dsq_new((it), (dsq_id), (flags))
 struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
 void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
-void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
-void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
-void scx_bpf_dump_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym __weak;
-u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
-u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
-void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
+void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_exit_bstr(exit_code, fmt, data, data__sz) scx_bpf_exit_bstr((exit_code), (fmt), (data), (data__sz), NULL)
+void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data__sz, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_error_bstr(fmt, data, data__sz) scx_bpf_error_bstr((fmt), (data), (data__sz), NULL)
+void scx_bpf_dump_bstr(char *fmt, unsigned long long *data, u32 data__sz, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_dump_bstr(fmt, data, data__sz) scx_bpf_dump_bstr((fmt), (data), (data__sz), NULL)
+u32 scx_bpf_cpuperf_cap(s32 cpu, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_cpuperf_cap(cpu) scx_bpf_cpuperf_cap((cpu), NULL)
+u32 scx_bpf_cpuperf_cur(s32 cpu, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_cpuperf_cur(cpu) scx_bpf_cpuperf_cur((cpu), NULL)
+void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_cpuperf_set(cpu, perf) scx_bpf_cpuperf_set((cpu), (perf), NULL)
 u32 scx_bpf_nr_node_ids(void) __ksym __weak;
 u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
-int scx_bpf_cpu_node(s32 cpu) __ksym __weak;
+int scx_bpf_cpu_node(s32 cpu, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_cpu_node(cpu) scx_bpf_cpu_node((cpu), NULL)
 const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
 void scx_bpf_put_cpumask(const struct cpumask *cpumask) __ksym __weak;
-const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __ksym __weak;
-const struct cpumask *scx_bpf_get_idle_cpumask(void) __ksym;
-const struct cpumask *scx_bpf_get_idle_smtmask_node(int node) __ksym __weak;
-const struct cpumask *scx_bpf_get_idle_smtmask(void) __ksym;
-void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
-bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
-s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
-s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
-s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags) __ksym __weak;
-s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
+const struct cpumask *scx_bpf_get_idle_cpumask_node(int node, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_get_idle_cpumask_node(node) scx_bpf_get_idle_cpumask_node((node), NULL)
+const struct cpumask *scx_bpf_get_idle_cpumask(const struct bpf_prog_aux *aux__prog) __ksym;
+#define scx_bpf_get_idle_cpumask() scx_bpf_get_idle_cpumask(NULL)
+const struct cpumask *scx_bpf_get_idle_smtmask_node(int node, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_get_idle_smtmask_node(node) scx_bpf_get_idle_smtmask_node((node))
+const struct cpumask *scx_bpf_get_idle_smtmask(const struct bpf_prog_aux *aux__prog) __ksym;
+#define scx_bpf_get_idle_smtmask() scx_bpf_get_idle_smtmask(NULL)
+void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask, const struct bpf_prog_aux *aux__prog) __ksym;
+#define scx_bpf_put_idle_cpumask(cpumask) scx_bpf_put_idle_cpumask((cpumask), NULL)
+bool scx_bpf_test_and_clear_cpu_idle(s32 cpu, const struct bpf_prog_aux *aux__prog) __ksym;
+#define scx_bpf_test_and_clear_cpu_idle(cpu) scx_bpf_test_and_clear_cpu_idle((cpu), NULL)
+s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_pick_idle_cpu_node(cpus_allowed, node, flags) scx_bpf_pick_idle_cpu_node((cpus_allowed), (node), (flags), NULL)
+s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags, const struct bpf_prog_aux *aux__prog) __ksym;
+#define scx_bpf_pick_idle_cpu(cpus_allowed, flags) scx_bpf_pick_idle_cpu((cpus_allowed), (flags), NULL)
+s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags) scx_bpf_pick_any_cpu_node((cpus_allowed), (node), (flags), NULL)
+s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags, const struct bpf_prog_aux *aux__prog) __ksym;
+#define scx_bpf_pick_any_cpu(cpus_allowed, flags) scx_bpf_pick_any_cpu((cpus_allowed), (flags), NULL)
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
-struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
-struct rq *scx_bpf_locked_rq(void) __ksym;
+struct rq *scx_bpf_cpu_rq(s32 cpu, const struct bpf_prog_aux *aux__prog) __ksym;
+#define scx_bpf_cpu_rq(cpu) scx_bpf_cpu_rq((cpu), NULL)
 struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
-struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
+struct cgroup *scx_bpf_task_cgroup(struct task_struct *p, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_task_cgroup(p) scx_bpf_task_cgroup((p), NULL)
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
 
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index dd9144624dc9..b84a3d42d2aa 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -40,6 +40,11 @@ bool scx_bpf_dispatch_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struc
 bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym __weak;
 
+/*
+ * XXX TEMPORARY - The followings conflict with prog__aux wrappers. Comment them
+ * out for now.
+ */
+/*
 #define scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags)				\
 	(bpf_ksym_exists(scx_bpf_dsq_insert) ?					\
 	 scx_bpf_dsq_insert((p), (dsq_id), (slice), (enq_flags)) :		\
@@ -54,7 +59,7 @@ int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym
 	(bpf_ksym_exists(scx_bpf_dsq_move_to_local) ?				\
 	 scx_bpf_dsq_move_to_local((dsq_id)) :					\
 	 scx_bpf_consume___compat((dsq_id)))
-
+*/
 #define __COMPAT_scx_bpf_dsq_move_set_slice(it__iter, slice)			\
 	(bpf_ksym_exists(scx_bpf_dsq_move_set_slice) ?				\
 	 scx_bpf_dsq_move_set_slice((it__iter), (slice)) :			\
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 9631e4d04d88..15e15cb234dc 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -312,7 +312,7 @@ static bool dispatch_highpri(bool from_timer)
 	s32 this_cpu = bpf_get_smp_processor_id();
 
 	/* scan SHARED_DSQ and move highpri tasks to HIGHPRI_DSQ */
-	bpf_for_each(scx_dsq, p, SHARED_DSQ, 0) {
+	bpf_for_each(scx_dsq, p, SHARED_DSQ, 0, NULL) {
 		static u64 highpri_seq;
 		struct task_ctx *tctx;
 
@@ -334,7 +334,7 @@ static bool dispatch_highpri(bool from_timer)
 	 * Scan HIGHPRI_DSQ and dispatch until a task that can run on this CPU
 	 * is found.
 	 */
-	bpf_for_each(scx_dsq, p, HIGHPRI_DSQ, 0) {
+	bpf_for_each(scx_dsq, p, HIGHPRI_DSQ, 0, NULL) {
 		bool dispatched = false;
 		s32 cpu;
 
@@ -801,7 +801,7 @@ static void dump_shared_dsq(void)
 	bpf_printk("Dumping %d tasks in SHARED_DSQ in reverse order", nr);
 
 	bpf_rcu_read_lock();
-	bpf_for_each(scx_dsq, p, SHARED_DSQ, SCX_DSQ_ITER_REV)
+	bpf_for_each(scx_dsq, p, SHARED_DSQ, SCX_DSQ_ITER_REV, NULL)
 		bpf_printk("%s[%d]", p->comm, p->pid);
 	bpf_rcu_read_unlock();
 }
-- 
2.51.0


