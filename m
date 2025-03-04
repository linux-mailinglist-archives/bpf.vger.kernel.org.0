Return-Path: <bpf+bounces-53141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7562EA4CFF2
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 01:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3A87A3EF5
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 00:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38771C6BE;
	Tue,  4 Mar 2025 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZbIwTup"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6E8C1E
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048366; cv=none; b=tanZkrWNB9rfduCbbquKImx/wdzoqyEv0q3XmcemosLhbLqO93FKw15FQIu9i0QpQzjPv3EVQiKTy3c4pdlGTRJLk98E3/gpxmUYr4+4axqxcwDvSIIy8/OtM3VOv3/Cf2WqHeyO1bKI+X+pBJmoQWvUqTGVHE2Ozreezm0ILYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048366; c=relaxed/simple;
	bh=7KqavasgLw/X40zeTLnhXYJhBEhXJVeT8ro5OxOPA1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oakRN+4sIofd3BoIYo2jTRMKpd2DSeJU9iNOgcQWDSKfhcBi4zx9c8odo44w88goFz+HqdzE3sMhzfSPs4+gggx3e81ajH9Dve2YHPN1+FG2Y/HKY5b0huU1SC4mdrbM1C22K2FA9jtKqeM1PrE5xIxre/ZXtzi0g0SkbiUwiys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZbIwTup; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43bbb440520so19072505e9.2
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 16:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741048362; x=1741653162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuWa5g+YuogOAsfnLcP47W0EnfQ0tjcL76LoqjUvbGA=;
        b=BZbIwTupSAwqer2BduhJydioX+nFi+NDNxG1XgcGWzOYYOlApLCLzQpwGKhsFO+UuA
         N6ZQSGKQVXwCyEMqXZ6LUJtbTocOGcfDhwuYBSQ9R9s8SW4PzlyfvJCdAE3M3rVgWLhJ
         eueIBYm/vmyvrVBHFCSRGinFRNOlcHk27DhTpEvZWYQJ2XK0tnvUl+ZMOE33eNqWV+2S
         DLDVeS3/gHtk3dShDPWMc8qbYr9AE5UD/35aOZS/S5IzfMwCWm/j3k8US8fdexg7wbZs
         jFPkjxnwcKdS9V7BBXx4lEhCggSz2zZomri5sk/HXaIVgi7iq2wAw+4THNpBAvej2MyR
         NmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048362; x=1741653162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuWa5g+YuogOAsfnLcP47W0EnfQ0tjcL76LoqjUvbGA=;
        b=nrdJZJk8aWiPFLsUUhoPODkkgmUmYr8skNhrr1oE/PR1z2mXaj4gz3FIcGns05M888
         D38AbRMCF+cJgU3GHJXPFEGRFDosGzBJ/0z7HWbHw5xX1LGbHymerrKa0Ky3Oxk13RVl
         ocnLctGyVFH+A5kHzIQ/vAMo32QaozX7harZZxVIXBxep2O0Gh8I44RMK3uRkiDS/bbY
         cMWjTI3Q2M9e/pFe51dCmgrPA/mAZF1qmOp7KfuTQqlh/Z1oPeo13UuA5vKG6pTNxwiF
         dd/jMW/Y69msbmBa8BIgipxfah75u7mx6MYWKX/oTZehaL1N7TVyXySlbOS6CQtPY57Y
         NxRw==
X-Gm-Message-State: AOJu0Yyz3KFqguMxgUgeWoioVOKCrC9fghtST1ooImWVlBG/S+v7EZf5
	6LGRrkGx3H04c0fiDRCws95Plf4KOwuhfvnGpW32s5ce0W0ydPJTGMquwmBnQPA=
X-Gm-Gg: ASbGncuVqczAgh2NgPeQihhDs2jzyzPfv8mPu/Syhfcgo3GMCPTGEje5UqhjspEuZCf
	GufI16xBe2tgHsMd1WvHH7wKGYDWQourBtt1pNOavTKLfzPHMOu8dpy8dQQ9WvYcODkFkCcLfXh
	POLo8iIi4/u/aBke6mAfjMC+s1uaoo9Tn5r0Vgdpr4uYfaGtzXim94AdB6eKOzwN2E2BJ6KCnYC
	4YPXd26EHTWkUebFbLaqoScR4Bq/bImv0w0pJVKhM2OLajLGOS84pgoI/2r84gnMZKetvPaMTuc
	5MZJZ8LYpEjLBPFo0hG036tyJzbZMVnwxw==
X-Google-Smtp-Source: AGHT+IFzAWeB8kF3jZRhHW/TFPJNQj9XcN/5+Toz//9OyHDHCs5SqJjTqysLr4dN+QvLsSjKBDOucQ==
X-Received: by 2002:a05:600c:1c19:b0:43b:c5a3:2e12 with SMTP id 5b1f17b1804b1-43bc5a32ef1mr40293035e9.2.1741048362075;
        Mon, 03 Mar 2025 16:32:42 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc48f6d6bsm41452515e9.36.2025.03.03.16.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:32:41 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/2] bpf: Add verifier support for timed may_goto
Date: Mon,  3 Mar 2025 16:32:38 -0800
Message-ID: <20250304003239.2390751-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250304003239.2390751-1-memxor@gmail.com>
References: <20250304003239.2390751-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10141; h=from:subject; bh=7KqavasgLw/X40zeTLnhXYJhBEhXJVeT8ro5OxOPA1U=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxklfRTYMfvxawOxpFL5eGpUxLsvcxRaw7epD1S48 h+98RkqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8ZJXwAKCRBM4MiGSL8Ryu2bD/ 0Uu4QdCUr1ldrS8NcDC3d4RNAHDlXKpvvVQLOCPNBlvXWzZPUjsmQKsTyCgB1+9sH4kGF2pevitbYq vOgkbDRwS1yEnWzxi65EqcCntzzzr+FMHiVLl354BqmGGP2xyAr4eUiSC+E63gMJom25zbNCT/M4Jr YqkCpOdF6xFdHcH8XMNLaVmudgCjA4fAkrQgsVNnWv5XSQHKuad2nX3Hzolvh+eeQ1Cs0j78xeB1fJ Q6Btqxj0bcCyuAMm7Ah9/xOKJAQt7IuKuBeO23x/CqeHjVT0khQeb8N0xyqBoQWaKdS7tS+t3qNcYV DjFGJQxKRfLcQYVos0ovW+l5MrRR/kQGbxX18xMGnPYw8LoMximIZg197zdLCKHkeBLLvG6dj7Y/bF yOAtK8CbhmkRpL/tV5CTW1S3ujGxoOp/Pf15ng0McVoU3wA2IlNxI8qG/DrQ+dvDiyaFIuVD0sMQFl 7720sWZd5J/kMakV93dYcTzNXYyzX26nyW4R1/Urlyvq6c12lpMhwmGchbAKq5BbCfIok3oFeGtMO6 3Y0vCITljmBo/Zj/AoMg5T/kZsK+3EZnsUyZlVs7HTmZdR096hD0ymKjrdr6I6sPxDbA7ynv2Lxo3Y 7G4X2z4yBry88NWWKfOk69YI/paQv7eiiOOm8sFTcRLOE0aWsrFC+ZML9gdg==
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
into the function when the count drops to 0, and the runtime chooses to
refresh it (by returning count as BPF_MAX_TIMED_LOOPS) or returning 0
and aborting the loop on next iteration.

Since the check for 0 is done right after loading the count from the
stack, all subsequent cond_break sequences should immediately break as
well, of the same loop or subsequent loops in the program.

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
hardware used for benchmarking was a Sapphire Rapids Intel server with
performance governor enabled, mitigations were enabled.

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
 include/linux/filter.h |  8 +++++
 kernel/bpf/core.c      | 32 +++++++++++++++++++
 kernel/bpf/verifier.c  | 70 +++++++++++++++++++++++++++++++++++++-----
 4 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4c4028d865ee..dae3872c301d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1987,6 +1987,7 @@ struct bpf_array {
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
index a0200fbbace9..5fae5da55a4a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3069,6 +3069,38 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp,
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
+	/*
+	 * Populate the timestamp for this stack frame, and refresh count.
+	 */
+	if (!p->timestamp) {
+		p->timestamp = time;
+		return BPF_MAX_TIMED_LOOPS;
+	}
+	/*
+	 * Check if we've exhausted our time slice, and zero count.
+	 */
+	if (time - p->timestamp >= (NSEC_PER_SEC / 4))
+		return 0;
+	/*
+	 * Refresh the count for the stack frame.
+	 */
+	return BPF_MAX_TIMED_LOOPS;
+}
+
 /* for configs without MMU or 32-bit */
 __weak const struct bpf_map_ops arena_map_ops;
 __weak u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 22c4edc8695c..f3e95d471fa3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21572,7 +21572,50 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
-		if (is_may_goto_insn(insn)) {
+		if (is_may_goto_insn(insn) && bpf_jit_supports_timed_may_goto()) {
+			int stack_off_cnt = -stack_depth - 16;
+
+			/*
+			 * Two 8 byte slots, depth-16 stores the count, and
+			 * depth-8 stores the start timestamp of the loop.
+			 *
+			 * The starting value of count is BPF_MAX_TIMED_LOOPS
+			 * (0xffff).  Every iteration loads it and subs it by 1,
+			 * until the value becomes 0 in AX (thus, 1 in stack),
+			 * after which we call arch_bpf_timed_may_goto, which
+			 * either sets AX to 0xffff to keep looping, or to 0
+			 * upon timeout. AX is then stored into the stack. In
+			 * the next iteration, we either see 0 and break out, or
+			 * continue iterating until the next time value is 0
+			 * after subtraction, rinse and repeat.
+			 */
+			stack_depth_extra = 16;
+			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off_cnt);
+			if (insn->off >= 0)
+				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 5);
+			else
+				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off - 1);
+			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
+			insn_buf[3] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
+			/*
+			 * AX is used as an argument to pass in stack_off_cnt
+			 * (to add to r10/fp), and also as the return value of
+			 * the call to arch_bpf_timed_may_goto.
+			 */
+			insn_buf[4] = BPF_MOV64_IMM(BPF_REG_AX, stack_off_cnt);
+			insn_buf[5] = BPF_EMIT_CALL(arch_bpf_timed_may_goto);
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
@@ -22113,23 +22156,34 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 	env->prog->aux->stack_depth = subprogs[0].stack_depth;
 	for (i = 0; i < env->subprog_cnt; i++) {
+		int delta = bpf_jit_supports_timed_may_goto() ? 2 : 1;
 		int subprog_start = subprogs[i].start;
 		int stack_slots = subprogs[i].stack_extra / 8;
+		int slots = delta, cnt = 0;
 
 		if (!stack_slots)
 			continue;
-		if (stack_slots > 1) {
+		/*
+		 * We need two slots in case timed may_goto is supported.
+		 */
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
@@ -22139,7 +22193,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		 * to insn after BPF_ST that inits may_goto count.
 		 * Adjustment will succeed because bpf_patch_insn_data() didn't fail.
 		 */
-		WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1));
+		WARN_ON(adjust_jmp_off(env->prog, subprog_start, delta));
 	}
 
 	/* Since poke tab is now finalized, publish aux to tracker. */
-- 
2.43.5


