Return-Path: <bpf+bounces-45492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15D09D66EC
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 02:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF99FB215BB
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 01:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8DD18641;
	Sat, 23 Nov 2024 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lGo7AgwW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FEC29A1
	for <bpf@vger.kernel.org>; Sat, 23 Nov 2024 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732323617; cv=none; b=Md7cE7uZt8Cd/sGrnVsUgCRiKUoaX7PUjnHgdgzYXh6SN0yA8cZ/LwFihZBfXlS0EF7UgzHK5MwW8OQhR4IyOmf+nmlbAKaYd2eCTy0fQXD2jGtykxqQ4df16coq2JrKUs6hDuhO3Gj88jUR1LFqQzfYOVVb74XghjnAAy8ItqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732323617; c=relaxed/simple;
	bh=3Uqd2JyZGMh20zcK7rfRlgZBgt3xIEkSudMa8c5iXFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpiLHtHxZdCmOc+3L6QcfM7pwisPHNmjGF5zfKR3loRr0TuvKUfJrlHDloHujUr2eZsTCU8cNyyzDj8/Jvw+kOb29Lj+ShABT/lxPipr+9nlXGmGJaKZMsV3ArOybtA9p2XrZyfMpCzRE64HZ1xJDUIVmcJI6hng4sOSawk813k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lGo7AgwW; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMLTlnI011576;
	Fri, 22 Nov 2024 16:59:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=GKWzCi9LxsxXvqCjvZ6DIH5Z9e5NWU8nsi8/QhxgrTQ=; b=lGo7AgwWlmRZ
	+Y5qWJlCECBOozlBeNSzT0y/wURZ9bLFqGSE6N9PxiW9rC86hiUJyFmR+7aUqvyq
	iMbnuiE/sQeCUodU83rpIXrotj6DwB01TxWWj6u3gW1hwOfnBIe3c5ibYc2g0GBN
	Qf1y908q9A2oA9Yko9Y7R9wzwlpmGWTtkQf/aOn/8VooVUp0bKCz8gkVM2t7IeRZ
	TZbs9rOVUd/NROiV5FDOqUtHzSm7Rk8WuMV5peqwtuXujs6anW/g9NzIIE9oWTWF
	U2uyGqMvReUE/5vIB0OR6Qq3FESdfY3eadU97eldaXW7fIvxFXjzFanUUH4VU76l
	5x+A45JPvQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4331wrh333-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 22 Nov 2024 16:59:30 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Sat, 23 Nov 2024 00:58:58 +0000
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
Subject: [PATCH bpf-next v9 1/4] bpf: add bpf_get_cpu_time_counter kfunc
Date: Fri, 22 Nov 2024 16:58:30 -0800
Message-ID: <20241123005833.810044-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241123005833.810044-1-vadfed@meta.com>
References: <20241123005833.810044-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sjp8GEK9DqI_Ke_hsZOWWFGDIgHJYkDE
X-Proofpoint-ORIG-GUID: sjp8GEK9DqI_Ke_hsZOWWFGDIgHJYkDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

New kfunc to return ARCH-specific timecounter. The main reason to
implement this kfunc is to avoid extra overhead of benchmark
measurements, which are usually done by a pair of bpf_ktime_get_ns()
at the beginnig and at the end of the code block under benchmark.
This function doesn't implement conversion to the monotonic clock and
saves some CPU cycles because of it. Another point is when it's properly
JITed, it saves extra hundreds of cycles by receiving timecounter values
in single-digit amount of instructions. The delta values can be
translated into nanoseconds using kfunc introduced in the next patch.
For x86 BPF JIT converts this kfunc into rdtsc ordered call. Other
architectures will get JIT implementation too if supported. The fallback
is to call __arch_get_hw_counter().

The simplest use-case is added in 4th patch, where we calculate the time
spent by bpf_get_ns_current_pid_tgid() kfunc. More complex example is to
use session cookie to store timecounter value at kprobe/uprobe using
kprobe.session/uprobe.session, and calculate the difference at
kretprobe/uretprobe.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 arch/x86/net/bpf_jit_comp.c   | 39 +++++++++++++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp32.c | 14 ++++++++++++
 include/linux/bpf.h           |  5 +++++
 include/linux/filter.h        |  1 +
 kernel/bpf/core.c             | 11 ++++++++++
 kernel/bpf/helpers.c          | 27 +++++++++++++++++++++++
 kernel/bpf/verifier.c         | 41 ++++++++++++++++++++++++++++++-----
 7 files changed, 132 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a43fc5af973d..92431ab1a21e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2185,6 +2185,37 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			u8 *ip = image + addrs[i - 1];
 
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+			    imm32 == BPF_CALL_IMM(bpf_get_cpu_time_counter)) {
+				/* The default implementation of this kfunc uses
+				 * __arch_get_hw_counter() which is implemented as
+				 * `(u64)rdtsc_ordered() & S64_MAX`. We skip masking
+				 * part because we assume it's not needed in BPF
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
@@ -3791,3 +3822,11 @@ u64 bpf_arch_uaddress_limit(void)
 {
 	return 0;
 }
+
+/* x86-64 JIT can inline kfunc */
+bool bpf_jit_inlines_kfunc_call(s32 imm)
+{
+	if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter))
+		return true;
+	return false;
+}
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index de0f9e5f9f73..a549aea25f5f 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2094,6 +2094,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 				int err;
 
+				if (imm32 == BPF_CALL_IMM(bpf_get_cpu_time_counter)) {
+					if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
+						EMIT3(0x0F, 0xAE, 0xE8);
+					EMIT2(0x0F, 0x31);
+					break;
+				}
+
 				err = emit_kfunc_call(bpf_prog,
 						      image + addrs[i],
 						      insn, &prog);
@@ -2621,3 +2628,10 @@ bool bpf_jit_supports_kfunc_call(void)
 {
 	return true;
 }
+
+bool bpf_jit_inlines_kfunc_call(s32 imm)
+{
+	if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter))
+		return true;
+	return false;
+}
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3ace0d6227e3..6d540253cfb4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3333,6 +3333,11 @@ void bpf_user_rnd_init_once(void);
 u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
+/* Inlined kfuncs */
+#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
+u64 bpf_get_cpu_time_counter(void);
+#endif
+
 #if defined(CONFIG_NET)
 bool bpf_sock_common_is_valid_access(int off, int size,
 				     enum bpf_access_type type,
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 3a21947f2fd4..9cf57233874f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1111,6 +1111,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
+bool bpf_jit_inlines_kfunc_call(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a2327c4fdc8b..4f79a6ed1d3a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2965,6 +2965,17 @@ bool __weak bpf_jit_inlines_helper_call(s32 imm)
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
index 751c150f9e1c..23f1a1606f8b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -23,6 +23,10 @@
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
+#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
+#include <vdso/datapage.h>
+#include <asm/vdso/vsyscall.h>
+#endif
 
 #include "../../lib/kstrtox.h"
 
@@ -3057,6 +3061,26 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
 	return ret + 1;
 }
 
+#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
+__bpf_kfunc u64 bpf_get_cpu_time_counter(void)
+{
+	const struct vdso_data *vd = __arch_get_k_vdso_data();
+
+	vd = &vd[CS_RAW];
+
+	/* CS_RAW clock_mode translates to VDSO_CLOCKMODE_TSC on x86 and
+	 * to VDSO_CLOCKMODE_ARCHTIMER on aarch64/risc-v. We cannot use
+	 * vd->clock_mode directly because it brings possible access to
+	 * pages visible by user-space only via vDSO. But the constant value
+	 * of 1 is exactly what we need - it works for any architecture and
+	 * translates to reading of HW timecounter regardles of architecture.
+	 * We still have to provide vdso_data for some architectures to avoid
+	 * NULL pointer dereference.
+	 */
+	return __arch_get_hw_counter(1, vd);
+}
+#endif
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3149,6 +3173,9 @@ BTF_ID_FLAGS(func, bpf_get_kmem_cache)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
+#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
+BTF_ID_FLAGS(func, bpf_get_cpu_time_counter, KF_FASTCALL)
+#endif
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..dbfad4457bef 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16407,6 +16407,24 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	}
 }
 
+/* True if fixup_kfunc_call() replaces calls to kfunc number 'imm',
+ * replacement patch is presumed to follow bpf_fastcall contract
+ * (see mark_fastcall_pattern_for_call() below).
+ */
+static bool verifier_inlines_kfunc_call(struct bpf_verifier_env *env, s32 imm)
+{
+	const struct bpf_kfunc_desc *desc = find_kfunc_desc(env->prog, imm, 0);
+
+	if (!env->prog->jit_requested)
+		return false;
+
+	if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast])
+		return true;
+
+	return false;
+}
+
 /* Same as helper_fastcall_clobber_mask() but for kfuncs, see comment above */
 static u32 kfunc_fastcall_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -16534,7 +16552,10 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 			return;
 
 		clobbered_regs_mask = kfunc_fastcall_clobber_mask(&meta);
-		can_be_inlined = is_fastcall_kfunc_call(&meta);
+		can_be_inlined = is_fastcall_kfunc_call(&meta) &&
+				 (verifier_inlines_kfunc_call(env, call->imm) ||
+				 (meta.btf == btf_vmlinux &&
+				  bpf_jit_inlines_kfunc_call(call->imm)));
 	}
 
 	if (clobbered_regs_mask == ALL_CALLER_SAVED_REGS)
@@ -20541,6 +20562,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
 	const struct bpf_kfunc_desc *desc;
+	s32 imm = insn->imm;
 
 	if (!insn->imm) {
 		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
@@ -20564,7 +20586,18 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn->imm = BPF_CALL_IMM(desc->addr);
 	if (insn->off)
 		return 0;
-	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
+	if (verifier_inlines_kfunc_call(env, imm)) {
+		if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+		    desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
+			insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
+			*cnt = 1;
+		} else {
+			verbose(env, "verifier internal error: kfunc id %d has no inline code\n",
+				desc->func_id);
+			return -EFAULT;
+		}
+
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
 	    desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
 		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
@@ -20625,10 +20658,6 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 		__fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_meta_reg,
 						node_offset_reg, insn, insn_buf, cnt);
-	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
-		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
-		*cnt = 1;
 	} else if (is_bpf_wq_set_callback_impl_kfunc(desc->func_id)) {
 		struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(BPF_REG_4, (long)env->prog->aux) };
 
-- 
2.43.5


