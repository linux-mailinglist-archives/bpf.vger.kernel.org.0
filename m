Return-Path: <bpf+bounces-43102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB739AF416
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005A72853C3
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590F3216A0C;
	Thu, 24 Oct 2024 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ePDcTd1L"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835DF1531E2
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803120; cv=none; b=MF4JxzJOAPsEjGhmWC3PhINJlfGfscs305S7OFUzEnAFodzs6Ch3meRm1m6felMcvqQRoHglgzYDqSSYo/RJt/Jm52Jm1Ot0ZIjtOr3gk5sm9Z+W7JOm0fTjT4wM5BQpwcajxK3Fi2JVMUC3vaVpwxakX51yjbjDO3RfE81P5oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803120; c=relaxed/simple;
	bh=03zJXB+jYIjJFPTIkxPU03uOp89C0IJmUsk86d73Mgo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q/E8NSvFKUhkQNuh0IBc7XJoAH5I+xnOvnH5pgJkSU6V1tWQaiNSot3SSJBB6mHBbYwd5qDxM8t+pZ8T5QXDvsG3MOlJawO0rKCgZ8ohzykaYKpOSIqn+1xmel4Pm0FgEdJLLKGoFtzQH/qQA8VTJfxLTBodQlB3iSM3GrYTmSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ePDcTd1L; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49OJxs73017583;
	Thu, 24 Oct 2024 13:51:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=GnSSBIDweE0Gqm0dJ9
	O1mn9XF9uaY6Jq/V4R/7u3OAE=; b=ePDcTd1Le1BZfmWKwFQWxJDRJNS/7tAJKP
	z8cWFkkDsX0hEiV0i9nRZFf+9zEpEOCeFCQWCqLV984wY3oS0z546nj/9qRn4ZI1
	36oTC4RBrXatyXGHFtZOnXLQQLu0ECHWlcKIQ1q4uh4QIEXswT2hBhNlhmZZ1Wv4
	sfeVPOiayagQ4ceitByiCk25oOcxzTVvP00jMULd6s03h2P3+kL4cpw5dI4QK6lt
	/0ZlnlKmzSH4d+bujsqEVC+kNKGzE5h0Ti2mLO4YEX4d5YUM7HPmIbqcw6Y20O0T
	7zgJoKvXA9E7pc99FbXsGyrd7FRoI95/bRp+0LCAncxd/XmVNMnQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42fubcs74u-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Oct 2024 13:51:30 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 24 Oct 2024 20:51:20 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
CC: <x86@kernel.org>, <bpf@vger.kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH bpf-next v2 1/2] bpf: add bpf_get_hw_counter kfunc
Date: Thu, 24 Oct 2024 13:51:12 -0700
Message-ID: <20241024205113.762622-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DBloNDjAVNII5RgYiyGob_tKHvCG8co9
X-Proofpoint-GUID: DBloNDjAVNII5RgYiyGob_tKHvCG8co9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
it into rdtsc ordered call. Other architectures will get JIT
implementation too if supported. The fallback is to
__arch_get_hw_counter().

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v1 -> v2:
* Fix incorrect function return value type to u64
* Introduce bpf_jit_inlines_kfunc_call() and use it in
  mark_fastcall_pattern_for_call() to avoid clobbering in case of
	running programs with no JIT (Eduard)
* Avoid rewriting instruction and check function pointer directly
  in JIT (Alexei)
* Change includes to fix compile issues on non x86 architectures
---
 arch/x86/net/bpf_jit_comp.c   | 30 ++++++++++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp32.c | 16 ++++++++++++++++
 include/linux/filter.h        |  1 +
 kernel/bpf/core.c             | 11 +++++++++++
 kernel/bpf/helpers.c          |  7 +++++++
 kernel/bpf/verifier.c         |  4 +++-
 6 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 06b080b61aa5..a8cffbb19cf2 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1412,6 +1412,8 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 #define LOAD_TAIL_CALL_CNT_PTR(stack)				\
 	__LOAD_TCC_PTR(BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack))
 
+u64 bpf_get_hw_counter(void);
+
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -2126,6 +2128,26 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			u8 *ip = image + addrs[i - 1];
 
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+			    imm32 == BPF_CALL_IMM(bpf_get_hw_counter)) {
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
@@ -3652,3 +3674,11 @@ u64 bpf_arch_uaddress_limit(void)
 {
 	return 0;
 }
+
+/* x86-64 JIT can inline kfunc */
+bool bpf_jit_inlines_helper_call(s32 imm)
+{
+	if (imm == BPF_CALL_IMM(bpf_get_hw_counter))
+		return true;
+	return false;
+}
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index de0f9e5f9f73..66525cb1892c 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1656,6 +1656,8 @@ static int emit_kfunc_call(const struct bpf_prog *bpf_prog, u8 *end_addr,
 	return 0;
 }
 
+u64 bpf_get_hw_counter(void);
+
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		  int oldproglen, struct jit_context *ctx)
 {
@@ -2094,6 +2096,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 				int err;
 
+				if (imm32 == BPF_CALL_IMM(bpf_get_hw_counter)) {
+					if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
+						EMIT3(0x0F, 0xAE, 0xE8);
+					EMIT2(0x0F, 0x31);
+					break;
+				}
+
 				err = emit_kfunc_call(bpf_prog,
 						      image + addrs[i],
 						      insn, &prog);
@@ -2621,3 +2630,10 @@ bool bpf_jit_supports_kfunc_call(void)
 {
 	return true;
 }
+
+bool bpf_jit_inlines_helper_call(s32 imm)
+{
+	if (imm == BPF_CALL_IMM(bpf_get_hw_counter))
+		return true;
+	return false;
+}
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
index 5c3fdb29c1b1..f7bf3debbcc4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -23,6 +23,7 @@
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
+#include <vdso/datapage.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3023,6 +3024,11 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
 	return ret + 1;
 }
 
+__bpf_kfunc u64 bpf_get_hw_counter(void)
+{
+	return __arch_get_hw_counter(1, NULL);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3112,6 +3118,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_kmem_cache)
+BTF_ID_FLAGS(func, bpf_get_hw_counter, KF_FASTCALL)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f514247ba8ba..428e7b84bb02 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11326,6 +11326,7 @@ BTF_ID(func, bpf_session_cookie)
 BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_get_kmem_cache)
+BTF_ID(func, bpf_get_hw_counter)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -16291,7 +16292,8 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 			return;
 
 		clobbered_regs_mask = kfunc_fastcall_clobber_mask(&meta);
-		can_be_inlined = is_fastcall_kfunc_call(&meta);
+		can_be_inlined = is_fastcall_kfunc_call(&meta) && !call->off &&
+				 bpf_jit_inlines_kfunc_call(call->imm);
 	}
 
 	if (clobbered_regs_mask == ALL_CALLER_SAVED_REGS)
-- 
2.43.5


