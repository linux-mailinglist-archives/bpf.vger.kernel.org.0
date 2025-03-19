Return-Path: <bpf+bounces-54389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38ABA69527
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 17:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC0D3B6059
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9108F1DEFD9;
	Wed, 19 Mar 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bqHifISL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B8A1D6199
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402282; cv=none; b=XZcdax/wH3YDxzCt0/sEMvyRH7nupAAga79fOrF6f7gOCX5cSu817Hw4BcdlEKcTNBhJa8E+9+8wz5vQbchoZ71KtClKl9IXwU3mjuFdd4DYQusIzPB2WliU5BB1bMWzHUEGhpPDBO3Z0GRuGecte8nVtRUW32intleO8drCpnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402282; c=relaxed/simple;
	bh=mlTDwHmmJnMg4iCz9K/a247Md3tPFmnlIYCjC4LQi9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ioLiXOMFkLrhHLRXtBrpTBelYH+j9XeYumtsbBZ6dXIberC303ksUuboAjx5SBX1s3MNJ92hZN16Aq5JqHojIfCYl1A9zkOg6VgFOrnFP4uaPQudPbsNSRGCCDCNmBHTsRMroIMd517+mRtJCt6HEoyi0mTWEJlF0gHmxI4FKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bqHifISL; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 52JGCVYu020382;
	Wed, 19 Mar 2025 09:37:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=EJVaTwP3z/Rvmexq9wQ5AzI8bVrkToYk1Ty/ElEbfGg=; b=bqHifISLZu5w
	B+AJr2vBgWWlzgI2OCi+R3bOmpviN1rWiEb5bX1n8ZK7mrkfB3i69h6n/+JOT4VK
	3Vay7QnQt0ub4KsfJikIJXs8reet5edltAn2I+gy0wp4cKz8vNoioiLQC0xW9AFO
	lf1TYISNZwVT/dRyzr2NDO082Zxjv1WwtrsK9ywOfELgMcRZ9SSjj1e9WHVrhaZT
	1DpB7MGBKNVR16moqsL/wYHALuRH5hXt0mG+WqBrTqxaplBXoe9qOvADzTIWS3DY
	ekKcuTHkqXEHPURrmOzNLceUYqwWz20aPDUfEpJYXfMSflVjmNSHzVh3d8O2MP4r
	I28pOBzc0A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 45fn4mmb9n-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 19 Mar 2025 09:37:19 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.14; Wed, 19 Mar 2025 16:36:49 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yonghong.song@linux.dev>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>
CC: <x86@kernel.org>, <bpf@vger.kernel.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Vadim Fedorenko <vadfed@meta.com>,
        Martin KaFai Lau
	<martin.lau@linux.dev>
Subject: [PATCH bpf-next v12 2/5] bpf: add bpf_get_cpu_time_counter kfunc
Date: Wed, 19 Mar 2025 09:36:35 -0700
Message-ID: <20250319163638.3607043-3-vadfed@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319163638.3607043-1-vadfed@meta.com>
References: <20250319163638.3607043-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2BCr5dZ8MtejBR4onWVEKgp2w1O_EHGE
X-Proofpoint-GUID: 2BCr5dZ8MtejBR4onWVEKgp2w1O_EHGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01

New kfunc to return ARCH-specific timecounter. The main reason to
implement this kfunc is to avoid extra overhead of benchmark
measurements, which are usually done by a pair of bpf_ktime_get_ns()
at the beginnig and at the end of the code block under benchmark.
When fully JITed this function doesn't implement conversion to the
monotonic clock and saves some CPU cycles by receiving timecounter
values in single-digit amount of instructions. The delta values can be
translated into nanoseconds using kfunc introduced in the next patch.
For x86_64 BPF JIT converts this kfunc into rdtsc ordered call. Other
architectures will get JIT implementation too if supported. The fallback
is to get CLOCK_MONOTONIC_RAW value in ns.

JIT version of the function uses "LFENCE; RDTSC" variant because it
doesn't care about cookie value returned by "RDTSCP" and it doesn't want
to trash RCX value. LFENCE option provides the same ordering guarantee as
RDTSCP variant.

The simplest use-case is added in 5th patch, where we calculate the time
spent by bpf_get_ns_current_pid_tgid() kfunc. More complex example is to
use session cookie to store timecounter value at kprobe/uprobe using
kprobe.session/uprobe.session, and calculate the difference at
kretprobe/uretprobe.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 arch/x86/net/bpf_jit_comp.c   | 43 +++++++++++++++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp32.c |  1 +
 include/linux/bpf.h           |  3 +++
 include/linux/filter.h        |  1 +
 kernel/bpf/core.c             | 11 +++++++++
 kernel/bpf/helpers.c          | 11 +++++++++
 kernel/bpf/verifier.c         |  4 +++-
 7 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d3491cc0898b..284696d69df4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -15,6 +15,7 @@
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
+#include <asm/timer.h>
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
 #include <asm/cfi.h>
@@ -2254,6 +2255,38 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			u8 *ip = image + addrs[i - 1];
 
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+			    imm32 == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
+			    bpf_jit_inlines_kfunc_call(imm32)) {
+				/* The default implementation of this kfunc uses
+				 * ktime_get_raw_ns() which effectively is implemented as
+				 * `(u64)rdtsc_ordered() & S64_MAX`. For JIT We skip
+				 * masking part because we assume it's not needed in BPF
+				 * use case (two measurements close in time).
+				 * Original code for rdtsc_ordered() uses sequence:
+				 * 'rdtsc; nop; nop; nop' to patch it into
+				 * 'lfence; rdtsc' or 'rdtscp' depending on CPU features.
+				 * JIT uses 'lfence; rdtsc' variant because BPF program
+				 * doesn't care about cookie provided by rdtscp in RCX.
+				 * Save RDX because RDTSC will use EDX:EAX to return u64
+				 */
+				emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
+				if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
+					EMIT_LFENCE();
+				EMIT2(0x0F, 0x31);
+
+				/* shl RDX, 32 */
+				maybe_emit_1mod(&prog, BPF_REG_3, true);
+				EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
+				/* or RAX, RDX */
+				maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
+				EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
+				/* restore RDX from R11 */
+				emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);
+
+				break;
+			}
+
 			func = (u8 *) __bpf_call_base + imm32;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
@@ -3865,3 +3898,13 @@ bool bpf_jit_supports_timed_may_goto(void)
 {
 	return true;
 }
+
+/* x86-64 JIT can inline kfunc */
+bool bpf_jit_inlines_kfunc_call(s32 imm)
+{
+	if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
+	    cpu_feature_enabled(X86_FEATURE_TSC) &&
+	    using_native_sched_clock() && sched_clock_stable())
+		return true;
+	return false;
+}
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index de0f9e5f9f73..68511888eb27 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -16,6 +16,7 @@
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/asm-prototypes.h>
+#include <asm/timer.h>
 #include <linux/bpf.h>
 
 /*
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 973a88d9b52b..6cf9138b2437 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3389,6 +3389,9 @@ void bpf_user_rnd_init_once(void);
 u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
+/* Inlined kfuncs */
+u64 bpf_get_cpu_time_counter(void);
+
 #if defined(CONFIG_NET)
 bool bpf_sock_common_is_valid_access(int off, int size,
 				     enum bpf_access_type type,
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 590476743f7a..2fbfa1bc3f49 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1128,6 +1128,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
+bool bpf_jit_inlines_kfunc_call(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ba6b6118cf50..6ac61b9083ce 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3040,6 +3040,17 @@ bool __weak bpf_jit_inlines_helper_call(s32 imm)
 	return false;
 }
 
+/* Return true if the JIT inlines the call to the kfunc corresponding to
+ * the imm.
+ *
+ * The verifier will not patch the insn->imm for the call to the helper if
+ * this returns true.
+ */
+bool __weak bpf_jit_inlines_kfunc_call(s32 imm)
+{
+	return false;
+}
+
 /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool __weak bpf_jit_supports_subprog_tailcalls(void)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index ddaa41a70676..26f71e2438d2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3195,6 +3195,16 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
 	local_irq_restore(*flags__irq_flag);
 }
 
+__bpf_kfunc u64 bpf_get_cpu_time_counter(void)
+{
+	/* CLOCK_MONOTONIC_RAW is the closest analogue to what is implemented
+	 * in JIT. The access time is the same as for CLOCK_MONOTONIC, but the
+	 * slope of 'raw' is not affected by NTP adjustments, and with stable
+	 * TSC it can provide less jitter in short term measurements.
+	 */
+	return ktime_get_raw_fast_ns();
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3295,6 +3305,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
+BTF_ID_FLAGS(func, bpf_get_cpu_time_counter)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9f8cbd5c61bc..aea1040b4462 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17077,7 +17077,9 @@ static bool get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call
 			/* error would be reported later */
 			return false;
 		cs->num_params = btf_type_vlen(meta.func_proto);
-		cs->fastcall = meta.kfunc_flags & KF_FASTCALL;
+		cs->fastcall = (meta.kfunc_flags & KF_FASTCALL) ||
+			       (meta.btf == btf_vmlinux &&
+				bpf_jit_inlines_kfunc_call(call->imm));
 		cs->is_void = btf_type_is_void(btf_type_by_id(meta.btf, meta.func_proto->type));
 		return true;
 	}
-- 
2.47.1


