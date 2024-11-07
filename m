Return-Path: <bpf+bounces-44297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26A9C10BF
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 22:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE286284798
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 21:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF1B2170B2;
	Thu,  7 Nov 2024 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="C0bvrJHW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C4322E
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013975; cv=none; b=PJZo+SFFAwBhQYuWAqPQ4jcXWNN4E6DVVdbgA4npFt9l9Qta2Qh+3u4CjHvfK2QuWebGuKr7pfkmryqGBhrMu40MXb6WFfRX9F5EcSc62qzUof1Ew+lkPJY7U7lJO2PVg0XYJUZNJeIr5+JXaYhhqH0e6cxxpxbzfWLaOxHizLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013975; c=relaxed/simple;
	bh=YdHL2MAgwmw7HoFpJWyFH39WVlEjHZBbS6Ugw7xz2b4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LJ2HtawkmSqcgxceYQM6hTTYA/d81RAsNmbFiqUijCSyw1yVw2t/IvINdWixuRZcjvZD7FjuwwePoiPvx18spRE5bt0Ym11RKp/dm/c6TFH0xdN7Eb33Qw+rnqEupeVgNL4fttaMh8JFpWIdyiOx4xTqdin7t6zWi2aH9cUh8N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C0bvrJHW; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A7KBphc000706;
	Thu, 7 Nov 2024 13:12:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=kCi/+LR58XujLLS2nV
	OyWDO5LXty6qrt5rJHjnUg/vo=; b=C0bvrJHWICvJ1CWglmh9nz9qs4t70049KF
	injhe3OhcpjZciAbYlu42uGIBadxRqn9cnQNwVadBWkRlZVFIYTkwOUGRJKRUSmP
	Gq+jKYuoyi4YwN8f3MSPX68fg1oizCA9VrPPnM/xWCIhxz2kU5TGn/3Vj9E86fIV
	5ZPJPnaeN8ULlJrGvMsJBKbsWW9QS35V86pKJm+4aE37ThoQ82qPTtIDvT9YJ4+f
	6908nfEDUUKzTvSD1wimEN+6BTfE9xeoBbh/6CV8HL9J2IaYKMuJ8c/xK2Ud/6F6
	YXk/o9gz0QVTkWc6N37R6/NPc+Jd+jXwOIvxUryndGppLz190GtQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42s12xj9b5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 07 Nov 2024 13:12:23 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 7 Nov 2024 21:12:20 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: <x86@kernel.org>, <bpf@vger.kernel.org>,
        Vadim Fedorenko
	<vadfed@meta.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v4 1/4] bpf: add bpf_get_cpu_cycles kfunc
Date: Thu, 7 Nov 2024 13:12:03 -0800
Message-ID: <20241107211206.2814069-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9dlwqfxChbl7mDI0n08pCf10BKY2BdTE
X-Proofpoint-GUID: 9dlwqfxChbl7mDI0n08pCf10BKY2BdTE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
it into rdtsc ordered call. Other architectures will get JIT
implementation too if supported. The fallback is to
__arch_get_hw_counter().

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

v3 -> v4:
* change name of the helper to bpf_get_cpu_cycles (Andrii)
* Hide the helper behind CONFIG_GENERIC_GETTIMEOFDAY to avoid exposing
  it on architectures which do not have vDSO functions and data
* reduce the scope of check of inlined functions in verifier to only 2,
  which are actually inlined.
v2 -> v3:
* change name of the helper to bpf_get_cpu_cycles_counter to explicitly
  mention what counter it provides (Andrii)
* move kfunc definition to bpf.h to use it in JIT.
* introduce another kfunc to convert cycles into nanoseconds as more
  meaningful time units for generic tracing use case (Andrii)
v1 -> v2:
* Fix incorrect function return value type to u64
* Introduce bpf_jit_inlines_kfunc_call() and use it in
  mark_fastcall_pattern_for_call() to avoid clobbering in case of
  running programs with no JIT (Eduard)
* Avoid rewriting instruction and check function pointer directly
  in JIT (Alexei)
* Change includes to fix compile issues on non x86 architectures
---
 arch/x86/net/bpf_jit_comp.c   | 28 ++++++++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp32.c | 14 ++++++++++++++
 include/linux/bpf.h           |  5 +++++
 include/linux/filter.h        |  1 +
 kernel/bpf/core.c             | 11 +++++++++++
 kernel/bpf/helpers.c          | 13 +++++++++++++
 kernel/bpf/verifier.c         | 30 +++++++++++++++++++++++++++++-
 7 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 06b080b61aa5..4f78ed93ee7f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2126,6 +2126,26 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			u8 *ip = image + addrs[i - 1];
 
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+			    imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
+				/* Save RDX because RDTSC will use EDX:EAX to return u64 */
+				emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
+				if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
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
 			if (tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
@@ -3652,3 +3672,11 @@ u64 bpf_arch_uaddress_limit(void)
 {
 	return 0;
 }
+
+/* x86-64 JIT can inline kfunc */
+bool bpf_jit_inlines_kfunc_call(s32 imm)
+{
+	if (imm == BPF_CALL_IMM(bpf_get_cpu_cycles))
+		return true;
+	return false;
+}
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index de0f9e5f9f73..e6097a371b69 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2094,6 +2094,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 				int err;
 
+				if (imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
+					if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
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
+	if (imm == BPF_CALL_IMM(bpf_get_cpu_cycles))
+		return true;
+	return false;
+}
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1b84613b10ac..fed5f36d387a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3328,6 +3328,11 @@ void bpf_user_rnd_init_once(void);
 u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
+/* Inlined kfuncs */
+#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
+u64 bpf_get_cpu_cycles(void);
+#endif
+
 #if defined(CONFIG_NET)
 bool bpf_sock_common_is_valid_access(int off, int size,
 				     enum bpf_access_type type,
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7d7578a8eac1..8bdd5e6b2a65 100644
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
index 233ea78f8f1b..ab6a2452ade0 100644
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
index 395221e53832..c07cb058e710 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -23,6 +23,9 @@
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
+#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
+#include <vdso/datapage.h>
+#endif
 
 #include "../../lib/kstrtox.h"
 
@@ -3023,6 +3026,13 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
 	return ret + 1;
 }
 
+#ifdef IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
+__bpf_kfunc u64 bpf_get_cpu_cycles(void)
+{
+	return __arch_get_hw_counter(1, NULL);
+}
+#endif
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3115,6 +3125,9 @@ BTF_ID_FLAGS(func, bpf_get_kmem_cache)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
+#ifdef IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
+BTF_ID_FLAGS(func, bpf_get_cpu_cycles, KF_FASTCALL)
+#endif
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7958d6ff6b73..b5220d996231 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16273,6 +16273,24 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
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
@@ -16400,7 +16418,10 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 			return;
 
 		clobbered_regs_mask = kfunc_fastcall_clobber_mask(&meta);
-		can_be_inlined = is_fastcall_kfunc_call(&meta);
+		can_be_inlined = is_fastcall_kfunc_call(&meta) &&
+				 (verifier_inlines_kfunc_call(env, call->imm) ||
+				 (meta.btf == btf_vmlinux &&
+				  bpf_jit_inlines_kfunc_call(call->imm)));
 	}
 
 	if (clobbered_regs_mask == ALL_CALLER_SAVED_REGS)
@@ -20402,6 +20423,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
 	const struct bpf_kfunc_desc *desc;
+	s32 imm = insn->imm;
 
 	if (!insn->imm) {
 		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
@@ -20488,6 +20510,12 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 						node_offset_reg, insn, insn_buf, cnt);
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
+		if (!verifier_inlines_kfunc_call(env, imm)) {
+			verbose(env, "verifier internal error: kfunc id %d is not defined in checker\n",
+				desc->func_id);
+			return -EFAULT;
+		}
+
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
 	} else if (is_bpf_wq_set_callback_impl_kfunc(desc->func_id)) {
-- 
2.43.5


