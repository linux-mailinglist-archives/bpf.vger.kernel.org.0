Return-Path: <bpf+bounces-45114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D498D9D187D
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 19:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55AA5B23869
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333F1E1311;
	Mon, 18 Nov 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="D2/BizOc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3B1E0E19
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731956031; cv=none; b=AJeSJ3+v6kpXaawO3BaRGsLThs61JI9dqthStUQZ9RfvCw1OS5CkFnFQpZe0k1d3TgdC7hSo8pQZ97joZ7lboHbJ0BpuQl+55bbVYZ7Nry0hfvpkilYSNschNfoiKxBJhOZ7xQVsHKnZlj+VSvGYwd51tou7+/jl99+hNHceZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731956031; c=relaxed/simple;
	bh=dR3gRFy1pCdxrci0ieII9FXEVbTAvDioyTyxKntX4+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQpKas4yX/Z9Y5CLPfSnZ1tTBEfeL4XZcIyyks/NewttVTFmudhZ2/YUOOwUeLGh+Cf2uzcOKOpO0X9tJ4be1XhVUdKOiA1UWPcvUwbHZJ6LdtQHcsobVnxu9p/ehPWlJ90d3rSB1QEfJKADVGQchnGqPm1oNFFN/hvNdzkeELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=D2/BizOc; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIH1TB7020741;
	Mon, 18 Nov 2024 10:53:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=5JtxXvDuVsroSImpsTNLuGXxBq8wrR7rbIZWZbzK9bo=; b=D2/BizOcnSeR
	BgJBJX9oOCON2xq7cipUyR88aiQWKFiC6CqgftqR/SKJDQeNBVBRHhR2CKzAWtGK
	s8O/CkNAm/hNe3s9cLr/wEkxtB62B+cGNO8SENQ/frG0Brx2Hq2nCE+qPTeiZHdt
	XFOdZ0mvIGLUAq4utRGv9eT6YEXFeYzgho6gRuKtsshJxomcPEa8Nyj/JKTh7oSg
	KFWuN23jikQxtfCij8c1oJHuooe3I3lw8+AskT/HfViaN1VQ1vzBh5J374xv4Un2
	1U4ukUhs8nBMzmiMehfFegwt57HrQMqGewwRKWreHvqrShdfkCRqtTVWkYBkA7x4
	frXplzvw8Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4309m2gv4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Nov 2024 10:53:05 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 18 Nov 2024 18:53:03 +0000
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
        Vadim Fedorenko
	<vadfed@meta.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v7 2/4] bpf: add bpf_cpu_cycles_to_ns helper
Date: Mon, 18 Nov 2024 10:52:43 -0800
Message-ID: <20241118185245.1065000-3-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241118185245.1065000-1-vadfed@meta.com>
References: <20241118185245.1065000-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: foC6uzxXeqA1NINtX0wsW3QsxSlBrQ-7
X-Proofpoint-GUID: foC6uzxXeqA1NINtX0wsW3QsxSlBrQ-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

The new helper should be used to convert cycles received by
bpf_get_cpu_cycle() into nanoseconds.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v6 -> v7:
* change boot_cpu_has() -> cpu_feature_enabled() (Borislav)
v4 -> v6:
* add comment about simplified implementation (Eduard)
v4:
* change helper name to bpf_cpu_cycles_to_ns.
* hide it behind CONFIG_GENERIC_GETTIMEOFDAY to avoid exposing on
  unsupported architectures.
---
 arch/x86/net/bpf_jit_comp.c   | 22 ++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp32.c | 19 +++++++++++++++++++
 include/linux/bpf.h           |  1 +
 kernel/bpf/helpers.c          | 14 +++++++++++++-
 4 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5e0c16d8bba3..2a3f7d5fdf26 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -11,6 +11,7 @@
 #include <linux/bpf.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
+#include <linux/clocksource.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
@@ -2216,6 +2217,24 @@ st:			if (is_imm8(insn->off))
 				break;
 			}
 
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+			    imm32 == BPF_CALL_IMM(bpf_cpu_cycles_to_ns) &&
+			    cpu_feature_enabled(X86_FEATURE_CONSTANT_TSC)) {
+				u32 mult, shift;
+
+				clocks_calc_mult_shift(&mult, &shift, tsc_khz, USEC_PER_SEC, 0);
+				/* imul RAX, RDI, mult */
+				maybe_emit_mod(&prog, BPF_REG_1, BPF_REG_0, true);
+				EMIT2_off32(0x69, add_2reg(0xC0, BPF_REG_1, BPF_REG_0),
+					    mult);
+
+				/* shr RAX, shift (which is less than 64) */
+				maybe_emit_1mod(&prog, BPF_REG_0, true);
+				EMIT3(0xC1, add_1reg(0xE8, BPF_REG_0), shift);
+
+				break;
+			}
+
 			func = (u8 *) __bpf_call_base + imm32;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
@@ -3828,5 +3847,8 @@ bool bpf_jit_inlines_kfunc_call(s32 imm)
 {
 	if (imm == BPF_CALL_IMM(bpf_get_cpu_cycles))
 		return true;
+	if (imm == BPF_CALL_IMM(bpf_cpu_cycles_to_ns) &&
+	    boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
+		return true;
 	return false;
 }
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 11a5c41302a3..2bc560c47c00 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -12,6 +12,7 @@
 #include <linux/netdevice.h>
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
+#include <linux/clocksource.h>
 #include <asm/cacheflush.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
@@ -2100,6 +2101,24 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 					EMIT2(0x0F, 0x31);
 					break;
 				}
+				if (imm32 == BPF_CALL_IMM(bpf_cpu_cycles_to_ns) &&
+				    cpu_feature_enabled(X86_FEATURE_CONSTANT_TSC)) {
+					u32 mult, shift;
+
+					clocks_calc_mult_shift(&mult, &shift, tsc_khz,
+							       USEC_PER_SEC, 0);
+
+					/* move parameter to BPF_REG_0 */
+					emit_ia32_mov_r64(true, bpf2ia32[BPF_REG_0],
+							  bpf2ia32[BPF_REG_1], true, true,
+							  &prog, bpf_prog->aux);
+					/* multiply parameter by mut */
+					emit_ia32_mul_i64(bpf2ia32[BPF_REG_0],
+							  mult, true, &prog);
+					/* shift parameter by shift which is less than 64 */
+					emit_ia32_rsh_i64(bpf2ia32[BPF_REG_0],
+							  shift, true, &prog);
+				}
 
 				err = emit_kfunc_call(bpf_prog,
 						      image + addrs[i],
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 43a5207a1591..af47704afeaa 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3336,6 +3336,7 @@ u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 /* Inlined kfuncs */
 #if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
 u64 bpf_get_cpu_cycles(void);
+u64 bpf_cpu_cycles_to_ns(u64 cycles);
 #endif
 
 #if defined(CONFIG_NET)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9f1a51bdb365..ed3876aa30ad 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3079,8 +3079,19 @@ __bpf_kfunc u64 bpf_get_cpu_cycles(void)
 	 */
 	return __arch_get_hw_counter(1, vd);
 }
-#endif
 
+__bpf_kfunc u64 bpf_cpu_cycles_to_ns(u64 cycles)
+{
+	const struct vdso_data *vd = __arch_get_k_vdso_data();
+
+	vd = &vd[CS_RAW];
+	/* kfunc implementation does less manipulations than vDSO
+	 * implementation. BPF use-case assumes two measurements are close
+	 * in time and can simplify the logic.
+	 */
+	return mul_u64_u32_shr(cycles, vd->mult, vd->shift);
+}
+#endif
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3175,6 +3186,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 #if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
 BTF_ID_FLAGS(func, bpf_get_cpu_cycles, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_cpu_cycles_to_ns, KF_FASTCALL)
 #endif
 BTF_KFUNCS_END(common_btf_ids)
 
-- 
2.43.5


