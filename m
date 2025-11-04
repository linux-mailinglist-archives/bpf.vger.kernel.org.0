Return-Path: <bpf+bounces-73462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00638C32227
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 17:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C91842022A
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 16:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3649337108;
	Tue,  4 Nov 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvU66LQN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542173346A3
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274998; cv=none; b=T4M3wLgszq9uHP7AzzvlzMmkkb/9eGyQz26z/j/cW9E9SM3mFxTBHLm9n9Ok5oeoSuLtdJfqUz8qJCaQ7a65STQ59OTRFnsEI1znPc/urNP07V+jKN3ygTo0YNH1XERW4sT4kvyV9S8cljEbX0CACsrGcjUPhMPqDEdLfPX5PAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274998; c=relaxed/simple;
	bh=hw0fGcyr/8IW+aMb3knmXu5Ik5Y0apMyv2yThr+knfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P75DfBfaaX6U2TFmMKlDsiu5QXs0junanUCyZe5NxlUiOxGxdNXKaQahJZMlRD4cj3+VBqtT46PySdKzoAXLWhHyp4hwypGjvEQ8RvPL6tYj5AM1RBsaubsKZaZphlCtPvBJU/4rTVaJieBYvZpHSLf5tXRtuM+YL/iad68WGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvU66LQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DC1C4CEF7;
	Tue,  4 Nov 2025 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762274998;
	bh=hw0fGcyr/8IW+aMb3knmXu5Ik5Y0apMyv2yThr+knfk=;
	h=From:To:Cc:Subject:Date:From;
	b=DvU66LQNQDQl1C2woBHquWLy7uJS0Sya7N4QLwdHKXoHZaC46esNbV+FIEiJLot2c
	 khx2JwS2kNHHmq3rtmMvB5xMyZFnYsScfYkPbpxk4Q6zwhoVZgYqcMG5fG/zknkwJv
	 c5kQKrVyVp93uPUKSS5TGvMN/cO2kdsHQotc3nd7/DUlNmFiEtZSGffbDVHowH6P+X
	 etyZ4A+UiNdI4L0J4/VFDAOsC1UGGXFhp6PhAZZCfJvqSXezW0KEVmq0cYpRYVlach
	 fri5YUp/krBuTheWQ8fZmWoR7VQZhHH38SkB5Ma4z4j2EXqbYf5a97E9mHDb54xYY+
	 CHUE6CrUuYo3A==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: Optimize recursion detection for arm64
Date: Tue,  4 Nov 2025 16:49:47 +0000
Message-ID: <20251104164948.33408-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BPF programs detect recursion by a per-cpu active flag in struct
bpf_prog. This flag is set/unset in the trampoline using atomic
operations to prevent inter-context recursion.

Some arm64 platforms have slow per-CPU atomic operations, for example,
the Neoverse V2.  This commit therefore changes the recursion detection
mechanism to allow four levels of recursion (normal -> softirq -> hardirq
-> NMI). With allowing limited recursion, we can now stop using atomic
operations. This approach is similar to get_recursion_context() in perf.

Change active to a per-cpu array of four u8 values, one for each context
and use non-atomic increment/decrement on them.

This improves the performance on ARM64 (64-CPU Neoverse-N1):

 +----------------+-------------------+-------------------+---------+
 |    Benchmark   |     Base run      |   Patched run     |  Δ (%)  |
 +----------------+-------------------+-------------------+---------+
 | fentry         |  3.694 ± 0.003M/s |  3.828 ± 0.007M/s | +3.63%  |
 | fexit          |  1.389 ± 0.006M/s |  1.406 ± 0.003M/s | +1.22%  |
 | fmodret        |  1.366 ± 0.011M/s |  1.398 ± 0.002M/s | +2.34%  |
 | rawtp          |  3.453 ± 0.026M/s |  3.714 ± 0.003M/s | +7.56%  |
 | tp             |  2.596 ± 0.005M/s |  2.699 ± 0.006M/s | +3.97%  |
 +----------------+-------------------+-------------------+---------+

 Benchmarked using: tools/testing/selftests/bpf/benchs/run_bench_trigger.sh

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf.h      |  4 +++-
 kernel/bpf/core.c        |  3 ++-
 kernel/bpf/trampoline.c  | 22 ++++++++++++++++++----
 kernel/trace/bpf_trace.c | 11 +++++++----
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a47d67db3be5..920902e0f384 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1728,6 +1728,8 @@ struct bpf_prog_aux {
 	struct bpf_stream stream[2];
 };
 
+#define BPF_NR_CONTEXTS	4
+
 struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
 	u16			jited:1,	/* Is our filter JIT'ed? */
@@ -1754,7 +1756,7 @@ struct bpf_prog {
 		u8 tag[BPF_TAG_SIZE];
 	};
 	struct bpf_prog_stats __percpu *stats;
-	int __percpu		*active;
+	u8 __percpu		*active;	/* u8[BPF_NR_CONTEXTS] for rerecursion protection */
 	unsigned int		(*bpf_func)(const void *ctx,
 					    const struct bpf_insn *insn);
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d595fe512498..6fe2e22385a6 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -112,7 +112,8 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 		vfree(fp);
 		return NULL;
 	}
-	fp->active = alloc_percpu_gfp(int, bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
+	fp->active = __alloc_percpu_gfp(sizeof(u8[BPF_NR_CONTEXTS]), 8,
+					bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
 	if (!fp->active) {
 		vfree(fp);
 		kfree(aux);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5949095e51c3..e6b9c7e34990 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -899,11 +899,15 @@ static __always_inline u64 notrace bpf_prog_start_time(void)
 static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
+	u8 rctx = interrupt_context_level();
+	u8 *active;
+
 	rcu_read_lock_dont_migrate();
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
-	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+	active = this_cpu_ptr(prog->active);
+	if (unlikely(++active[rctx] != 1)) {
 		bpf_prog_inc_misses_counter(prog);
 		if (prog->aux->recursion_detected)
 			prog->aux->recursion_detected(prog);
@@ -944,10 +948,13 @@ static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
 					  struct bpf_tramp_run_ctx *run_ctx)
 	__releases(RCU)
 {
+	u8 rctx = interrupt_context_level();
+	u8 *active = this_cpu_ptr(prog->active);
+
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
-	this_cpu_dec(*(prog->active));
+	active[rctx]--;
 	rcu_read_unlock_migrate();
 }
 
@@ -977,13 +984,17 @@ static void notrace __bpf_prog_exit_lsm_cgroup(struct bpf_prog *prog, u64 start,
 u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx)
 {
+	u8 rctx = interrupt_context_level();
+	u8 *active;
+
 	rcu_read_lock_trace();
 	migrate_disable();
 	might_fault();
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
-	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+	active = this_cpu_ptr(prog->active);
+	if (unlikely(++active[rctx] != 1)) {
 		bpf_prog_inc_misses_counter(prog);
 		if (prog->aux->recursion_detected)
 			prog->aux->recursion_detected(prog);
@@ -995,10 +1006,13 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 start,
 					     struct bpf_tramp_run_ctx *run_ctx)
 {
+	u8 rctx = interrupt_context_level();
+	u8 *active = this_cpu_ptr(prog->active);
+
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
-	this_cpu_dec(*(prog->active));
+	active[rctx]--;
 	migrate_enable();
 	rcu_read_unlock_trace();
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a795f7afbf3d..4c0751710cff 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2059,14 +2059,18 @@ static __always_inline
 void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 {
 	struct bpf_prog *prog = link->link.prog;
+	u8 rctx = interrupt_context_level();
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
+	u8 *active;
 
 	cant_sleep();
-	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+	active = this_cpu_ptr(prog->active);
+	if (unlikely(active[rctx])) {
 		bpf_prog_inc_misses_counter(prog);
-		goto out;
+		return;
 	}
+	active[rctx]++;
 
 	run_ctx.bpf_cookie = link->cookie;
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
@@ -2076,8 +2080,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	rcu_read_unlock();
 
 	bpf_reset_run_ctx(old_run_ctx);
-out:
-	this_cpu_dec(*(prog->active));
+	active[rctx]--;
 }
 
 #define UNPACK(...)			__VA_ARGS__
-- 
2.47.3


