Return-Path: <bpf+bounces-42957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4959AD64D
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB26B242F7
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 21:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F351E6DFE;
	Wed, 23 Oct 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="be3b0+nx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C814EC62
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717522; cv=none; b=D9ijFGTjW9bTkEj1M5KucJMxTiQ1EQ70wGftO0j4/lKrcGFTewO+HZnGZa5Se4LA0c1AtErfWGVV9YsbIJJwxBFHzXfKiQNK2qej+E9CcK1sCVK/3vSr3ZCNXWP/OATpQlmvy1l06QfHV7w0P6dklnuyBDsDeUxSeKmzmrPJt9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717522; c=relaxed/simple;
	bh=EjMIRAnp8MZ/Jh3katDBtmZHxAzkgQdYAhNc8jCZpQg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lTWoiWopaXGLBFugOz5Zxud4Jp5FqkQuKhcDPTZuz5Qan0P5wbQbsRBE/rkqzWpKUD6Nu4nU53wbwkLNDiHUYpmXY2q+E/IZj0y0gHkcvHSg99fueFiYf7nCy3zp4D/HLrbriQUVHV5iT4bEcA4vSF9M0r7z9nHDfIMbV695/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=be3b0+nx; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NJHqDE011835;
	Wed, 23 Oct 2024 14:04:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=oe4nUXWWzQhL7Uiww4
	T1DxCCltFQk8x0ZmuQsRLou80=; b=be3b0+nxMOweDuaFXT06KcPFlNvLlP1bmP
	rmYYxFjkuvLQMBsepdUreOCemPfo7eWDivV7vXCSlsUTOSpud8Zme47O46Q+3tyV
	PtHvgcd1Jdup8yXqX+X/70dhDAcWAljHM1+sDLx12XNdYnW9WdZY/JhqQ8+sWjt4
	3nTcwz7Q/jkOX/wsnaHNf+I9rWNZLW9cSlbk39NPtX3Bzg2RyUV1t/n9oQ5+1idD
	XnkbzpE0ln4lIYuzo1MmkW7NKPqGb0vp2wXKoE65WZB8nBqxigzvu6GFMtWzY1DZ
	ibp/EURARBW2jeZzuVB6ONciJRKFXi088AU5EesRADT01NoTZ5UQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42f302uadp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 23 Oct 2024 14:04:50 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 23 Oct 2024 21:04:47 +0000
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
Subject: [PATCH bpf-next 1/2] bpf: add bpf_get_hw_counter kfunc
Date: Wed, 23 Oct 2024 14:04:36 -0700
Message-ID: <20241023210437.2266063-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cn8cZRAqO3qpP3IVtVOMrxYcgoMKxNFD
X-Proofpoint-ORIG-GUID: cn8cZRAqO3qpP3IVtVOMrxYcgoMKxNFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
it into rdtsc ordered call. Other architectures will get JIT
implementation too if supported. The fallback is to
__arch_get_hw_counter().

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 arch/x86/net/bpf_jit_comp.c   | 23 +++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp32.c | 11 +++++++++++
 kernel/bpf/helpers.c          |  7 +++++++
 kernel/bpf/verifier.c         | 11 +++++++++++
 4 files changed, 52 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 06b080b61aa5..55595a0fa55b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2126,6 +2126,29 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			u8 *ip = image + addrs[i - 1];
 
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && !imm32) {
+				if (insn->dst_reg == 1) {
+					struct cpuinfo_x86 *c = &cpu_data(get_boot_cpu_id());
+
+					/* Save RDX because RDTSC will use EDX:EAX to return u64 */
+					emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
+					if (cpu_has(c, X86_FEATURE_LFENCE_RDTSC))
+						EMIT_LFENCE();
+					EMIT2(0x0F, 0x31);
+
+					/* shl RDX, 32 */
+					maybe_emit_1mod(&prog, BPF_REG_3, true);
+					EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
+					/* or RAX, RDX */
+					maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
+					EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
+					/* restore RDX from R11 */
+					emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);
+
+					break;
+				}
+			}
+
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index de0f9e5f9f73..c36ff18a044b 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2091,6 +2091,17 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			if (insn->src_reg == BPF_PSEUDO_CALL)
 				goto notyet;
 
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && !imm32) {
+				if (insn->dst_reg == 1) {
+					struct cpuinfo_x86 *c = &cpu_data(get_boot_cpu_id());
+
+					if (cpu_has(c, X86_FEATURE_LFENCE_RDTSC))
+						EMIT3(0x0F, 0xAE, 0xE8);
+					EMIT2(0x0F, 0x31);
+					break;
+				}
+			}
+
 			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 				int err;
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5c3fdb29c1b1..6624b2465484 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -23,6 +23,7 @@
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
+#include <asm/vdso/gettimeofday.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3023,6 +3024,11 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
 	return ret + 1;
 }
 
+__bpf_kfunc int bpf_get_hw_counter(void)
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
index f514247ba8ba..5f0e4f91ce48 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11260,6 +11260,7 @@ enum special_kfunc_type {
 	KF_bpf_iter_css_task_new,
 	KF_bpf_session_cookie,
 	KF_bpf_get_kmem_cache,
+	KF_bpf_get_hw_counter,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11326,6 +11327,7 @@ BTF_ID(func, bpf_session_cookie)
 BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_get_kmem_cache)
+BTF_ID(func, bpf_get_hw_counter)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -20396,6 +20398,15 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (IS_ENABLED(CONFIG_X86) &&
+		   desc->func_id == special_kfunc_list[KF_bpf_get_hw_counter]) {
+		insn->imm = 0;
+		insn->code = BPF_JMP | BPF_CALL;
+		insn->src_reg = BPF_PSEUDO_KFUNC_CALL;
+		insn->dst_reg = 1; /* Implement enum for inlined fast calls */
+
+		insn_buf[0] = *insn;
+		*cnt = 1;
 	} else if (is_bpf_wq_set_callback_impl_kfunc(desc->func_id)) {
 		struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(BPF_REG_4, (long)env->prog->aux) };
 
-- 
2.43.5


