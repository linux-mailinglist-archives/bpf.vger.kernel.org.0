Return-Path: <bpf+bounces-52999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B44A4B4A3
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 21:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5097A5FE7
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C2D1EDA0B;
	Sun,  2 Mar 2025 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpBijcBk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE51FC0E
	for <bpf@vger.kernel.org>; Sun,  2 Mar 2025 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740946439; cv=none; b=pPcOji5ZFPNVf+SBZ8XUt2Plut7aToEx/HBtGI5tlNw00557LKYAON9ST7tUgHzu/edBi64nLSQNFoqfUKJcjH1A5hiSYuhquzIaaTcdcV56is/TtOZHtiu056of5a9ApAjjvm8ktL/uxvPHbiksWSBQ5fRKgWNe5rDlrlhsUaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740946439; c=relaxed/simple;
	bh=gsK26vUkifuDYo7clrLXLQExH/TS/FyKlHScGPRSAWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3TI16vka8TWIyNT89MzNcqTr5jWQ/cW9+gDf4++hmAsrRc4u0aHg7hpLAECtdAQOI2EF6kVwIfZUskY4UDzA8raQD1+mIDVmI1wW+HzZWVBV+5puWwf+EqfO+BTU0msGQe23qCCv3x4qlAXZnR/iKKlGRMrMIfoZNGSfPsRg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpBijcBk; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-390e6ac844fso3341507f8f.3
        for <bpf@vger.kernel.org>; Sun, 02 Mar 2025 12:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740946435; x=1741551235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sadJdTy41RWbz6HTttqvIc+q2VC9ST+YLa62Y+t9bk=;
        b=BpBijcBkoSnw7sJ2LEUyBCQLzAYLlPQIoPSRjUAN+LWWQ0Zs6bSIkX2IpY1CxIXFuh
         YE8WPu+K2xVSY/TVTC9m0q+4nB3j8B+1IVtGqdlo7u7jtlcG3PKMYmtjevhqEPwVtVmV
         nTeZJfc/7PSlxxKl/ZQXsYo12hAeE+PUU2sA/+EFJZfeLqlTJJ3B9+XoDjUD1o9KmpzV
         RwAJe6eS4JfJmYg4JYUgG773jyopUXx8isbkco1VaM6uaQoYQsazOKmIBMM0CrdCl7g6
         mHpOef9Qv4pihsErP4SauxRBbF+doIzZnZmAg0q5W1p9EdrEz840Q9ki/QimjpA2vcTN
         +Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740946435; x=1741551235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sadJdTy41RWbz6HTttqvIc+q2VC9ST+YLa62Y+t9bk=;
        b=MpgnY0N2cnkK5yZgniVTnTL3kn+deniBMBXrJ+jpzZz/bIY3iJiVa7uC6taKwd0hcL
         CySxeNuf6XW75gbE47h5RWIlHjg2sWO2BNow9e6mWTRUh2ouye8160fzrygYOdexTQvg
         l//SB7abuJKyVFW8gLjnmJ+cY1mf44swURt5qSuieJCaH/7WDUwmQtDD6JQrEEH5kGAp
         ByNaFPefk+wMLgDdrU2uud7U5GfwPDYDWGycdcYSncfqj+jA8gP4rUT02vjeiE+D7bRU
         WYR5GH6U1qVR79f2oZD4YUm+Vv3Vt9vycfUI8k0aZSHdzkilkBJXmpOUqWJV4StWm4AB
         8ucw==
X-Gm-Message-State: AOJu0Yw4M0IFh6Z9F3c1tdoYqmOuSaIuCnLD4Y9IMkkNue6i4D3di3qn
	VZA3LY1Tp1xsSw6SY6PG3vlVFnF4A8olUfqtlnMNMWYWbEXv+JCujNvBHuzNisw=
X-Gm-Gg: ASbGnct+AuKXNjuiVMIC55htBvrmynD3wOLEPBNroo0cSErrUGlfu/jzMads5Anewbk
	3ReSyFus3jJFn3F4ObveO4K0EkFP488tP8pCYVB2z0QQRVS2dgmZmRGNYdEnpaxCuiQzy/qrTk1
	KIAuXUY8Vorsv1eXyKH4qun7n+VwdA/j3fnaTko6q2xuVAOB0qKnpFi7QxtLYn+a70iU3OK9gxI
	jvKL6zMoZfCt0dIQRQyqdURjCCOnoCe2IhY+Nz36f1GFCvcHspLiQEYG24qjsEurdWe10PzN5Nt
	mqA14rHGayiPMP4Q/bP277GXa7XfUttZBA==
X-Google-Smtp-Source: AGHT+IHYh7EwA3sEAnYpDHz0SNjAfO/nvb2HJQIoFp38P811zNPMND5Tc1azUVxWAjYg/1aniFYfpg==
X-Received: by 2002:a05:6000:2a02:b0:390:f412:dd41 with SMTP id ffacd0b85a97d-390f412e13bmr5166192f8f.53.1740946434694;
        Sun, 02 Mar 2025 12:13:54 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796051sm12446487f8f.12.2025.03.02.12.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 12:13:53 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Add verifier support for timed may_goto
Date: Sun,  2 Mar 2025 12:13:47 -0800
Message-ID: <20250302201348.940234-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250302201348.940234-1-memxor@gmail.com>
References: <20250302201348.940234-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9436; h=from:subject; bh=gsK26vUkifuDYo7clrLXLQExH/TS/FyKlHScGPRSAWo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxLhM+CDAqq0Ken5W/O8cKLwTZczKb3Zi//dq2sAY V2JQDUKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8S4TAAKCRBM4MiGSL8RylFgD/ sFEUrnM800ayQkGre8MagV97Ra7DZmVjn/LGZqY61jhgSpaM1VUodsY0qrSZbq+Cd2HJARzWLWkJiW +Bl4ChuplN4iT2yScE5vD4+cgN6M5leCpjgQDVGnAbnD3lXVSS7T7SjrEH7TGmoGOYLxVaJbEENGqL zKhv23ZCry951mOvwFShmGEdjpa23qcCuKVXmjxuQOskUsQC1BRrdHjbJVM386g21OJvTLj4IyzoT9 tDtTLTLyrj2AlxztUrcT4kiPGqS7NUjUfi6zZXYw7/VqDN91ZvkW1+AkiURJbY6BWAjGr8bA5m+oij lU5Tq5yespOsSl5b4EjXO2f0QD7F2BCZBJ/A6jB313NdQ1fZ/McYgO/knMJ/rsdwyzfPByUKkvmo9L gKpxot1vZl/aJdyyHpJQYIgygbpFCPo/Lw1tanFMXJISZHqvSmqm2Qyb9EdJsJ+xNvc3TPCuP1sFFv xYIsZVehdcU8fjL3e9GypQEOPkDQAJSdB1E8v2gCsmmzgEaW3PQYZR1JgX26FAOVJ3MlooNz2DZqPA DMZLnQK2S7GAOuYik6SH+PLIwsVzmqaqSPfixOio0e293ZB5pZQiQbSgKxjZel6JwNWMXpeMYBOIYk UcnADcVVho0Jq8KiSUvBH/v3Y4mBA9LMXDLlo0CQOGFpYGHOmwWU/QwuM6Mg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Implement support in the verifier for replacing may_goto implementation
from a counter-based approach to one which samples time on the local CPU
to have a bigger loop bound.

We implement it by maintaining 16-bytes per-stack frame, and using 8
bytes for maintaining the count for amortizing time sampling, and 8
bytes for the starting timestamp. To minimize overhead, we need to avoid
spilling and filling of registers around this sequence, so we push this
cost into the time sampling function 'arch_bpf_timed_may_goto'. This is
a JIT-specific wrapper around bpf_check_timed_may_goto which returns us
the count to store into the stack through BPF_REG_AX. All caller-saved
registers (r0-r5) are guaranteed to remain untouched.

The loop can be broken by returning count as 0, otherwise we dispatch
into the function when the count becomes 1, and the runtime chooses to
refresh it (by returning count as BPF_MAX_TIMED_LOOPS) or returning 0
and aborting it.

Since the check for 0 is done right after loading the count from the
stack, all subsequent cond_break sequences should immediately break as
well.

We pass in the stack_depth of the count (and thus the timestamp, by
adding 8 to it) to the arch_bpf_timed_may_goto call so that it can be
passed in to bpf_check_timed_may_goto as an argument after r1 is saved,
by adding the offset to r10/fp. This adjustment will be arch specific,
and the next patch will introduce support for x86.

Note that depending on loop complexity, time spent in the loop can be
more than the current limit (250 ms), but imposing an upper bound on
program runtime is an orthogonal problem which will be addressed when
program cancellations are supported.

The current time afforded by cond_break may not be enough for cases
where BPF programs want to implement locking algorithms inline, and use
cond_break as a promise to the verifier that they will eventually
terminate.

Below are some benchmarking numbers on the time taken per-iteration for
an empty loop that counts the number of iterations until cond_break
fires. For comparison, we compare it against bpf_for/bpf_repeat which is
another way to achieve the same number of spins (BPF_MAX_LOOPS).  The
hardware used for benchmarking was a Saphire Rapids Intel server with
performance governor enabled.

+-----------------------------+--------------+--------------+------------------+
| Loop type                   | Iterations   |  Time (ms)   |   Time/iter (ns) |
+-----------------------------|--------------+--------------+------------------+
| may_goto                    | 8388608      |  3           |   0.36           |
| timed_may_goto (count=65535)| 589674932    |  250         |   0.42           |
| bpf_for                     | 8388608      |  10          |   1.19           |
+-----------------------------+--------------+--------------+------------------+

This gives a good approximation at low overhead while staying close to
the current implementation.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h    |  1 +
 include/linux/filter.h |  8 +++++++
 kernel/bpf/core.c      | 31 +++++++++++++++++++++++++
 kernel/bpf/verifier.c  | 52 +++++++++++++++++++++++++++++++++++-------
 4 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index aec102868b93..788f6ca374e9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1986,6 +1986,7 @@ struct bpf_array {
  */
 enum {
 	BPF_MAX_LOOPS = 8 * 1024 * 1024,
+	BPF_MAX_TIMED_LOOPS = 0xffff,
 };
 
 #define BPF_F_ACCESS_MASK	(BPF_F_RDONLY |		\
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 3ed6eb9e7c73..02dda5c53d91 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -669,6 +669,11 @@ struct bpf_prog_stats {
 	struct u64_stats_sync syncp;
 } __aligned(2 * sizeof(u64));
 
+struct bpf_timed_may_goto {
+	u64 count;
+	u64 timestamp;
+};
+
 struct sk_filter {
 	refcount_t	refcnt;
 	struct rcu_head	rcu;
@@ -1130,8 +1135,11 @@ bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 bool bpf_jit_supports_private_stack(void);
+bool bpf_jit_supports_timed_may_goto(void);
 u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
+u64 arch_bpf_timed_may_goto(void);
+u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *);
 bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id);
 
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a0200fbbace9..b3f7c7bd08d3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3069,6 +3069,37 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp,
 {
 }
 
+bool __weak bpf_jit_supports_timed_may_goto(void)
+{
+	return false;
+}
+
+u64 __weak arch_bpf_timed_may_goto(void)
+{
+	return 0;
+}
+
+u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
+{
+	u64 time = ktime_get_mono_fast_ns();
+
+	/* If the count is zero, we've already broken a prior loop in this stack
+	 * frame, let's just exit quickly.
+	 */
+	if (!p->count)
+		return 0;
+	/* Populate the timestamp for this stack frame. */
+	if (!p->timestamp) {
+		p->timestamp = time;
+		return BPF_MAX_TIMED_LOOPS;
+	}
+	/* Check if we've exhausted our time slice. */
+	if (time - p->timestamp >= (NSEC_PER_SEC / 4))
+		return 0;
+	/* Refresh the count for the stack frame. */
+	return BPF_MAX_TIMED_LOOPS;
+}
+
 /* for configs without MMU or 32-bit */
 __weak const struct bpf_map_ops arena_map_ops;
 __weak u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dcd0da4e62fc..79bfb1932f40 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21503,7 +21503,34 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
-		if (is_may_goto_insn(insn)) {
+		if (is_may_goto_insn(insn) && bpf_jit_supports_timed_may_goto()) {
+			int stack_off_cnt = -stack_depth - 16;
+
+			/* Two 8 byte slots, depth-16 stores the count, and
+			 * depth-8 stores the start timestamp of the loop.
+			 */
+			stack_depth_extra = 16;
+			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off_cnt);
+			if (insn->off >= 0)
+				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 5);
+			else
+				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off - 1);
+			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
+			insn_buf[3] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 1, 2);
+			insn_buf[4] = BPF_MOV64_IMM(BPF_REG_AX, stack_off_cnt);
+			insn_buf[5] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_CALL_IMM(arch_bpf_timed_may_goto));
+			insn_buf[6] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt);
+			cnt = 7;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta += cnt - 1;
+			env->prog = prog = new_prog;
+			insn = new_prog->insnsi + i + delta;
+			goto next_insn;
+		} else if (is_may_goto_insn(insn)) {
 			int stack_off = -stack_depth - 8;
 
 			stack_depth_extra = 8;
@@ -22044,23 +22071,32 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 	env->prog->aux->stack_depth = subprogs[0].stack_depth;
 	for (i = 0; i < env->subprog_cnt; i++) {
+		int delta = bpf_jit_supports_timed_may_goto() ? 2 : 1;
 		int subprog_start = subprogs[i].start;
 		int stack_slots = subprogs[i].stack_extra / 8;
+		int slots = delta, cnt = 0;
 
 		if (!stack_slots)
 			continue;
-		if (stack_slots > 1) {
+		/* We need two in case timed may_goto is supported. */
+		if (stack_slots > slots) {
 			verbose(env, "verifier bug: stack_slots supports may_goto only\n");
 			return -EFAULT;
 		}
 
-		/* Add ST insn to subprog prologue to init extra stack */
-		insn_buf[0] = BPF_ST_MEM(BPF_DW, BPF_REG_FP,
-					 -subprogs[i].stack_depth, BPF_MAX_LOOPS);
+		if (bpf_jit_supports_timed_may_goto()) {
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -subprogs[i].stack_depth,
+						     BPF_MAX_TIMED_LOOPS);
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -subprogs[i].stack_depth + 8, 0);
+		} else {
+			/* Add ST insn to subprog prologue to init extra stack */
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -subprogs[i].stack_depth,
+						     BPF_MAX_LOOPS);
+		}
 		/* Copy first actual insn to preserve it */
-		insn_buf[1] = env->prog->insnsi[subprog_start];
+		insn_buf[cnt++] = env->prog->insnsi[subprog_start];
 
-		new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, 2);
+		new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, cnt);
 		if (!new_prog)
 			return -ENOMEM;
 		env->prog = prog = new_prog;
@@ -22070,7 +22106,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		 * to insn after BPF_ST that inits may_goto count.
 		 * Adjustment will succeed because bpf_patch_insn_data() didn't fail.
 		 */
-		WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1));
+		WARN_ON(adjust_jmp_off(env->prog, subprog_start, delta));
 	}
 
 	/* Since poke tab is now finalized, publish aux to tracker. */
-- 
2.43.5


