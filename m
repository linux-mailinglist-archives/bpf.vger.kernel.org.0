Return-Path: <bpf+bounces-44986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C99CF544
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 20:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD821F2AC06
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 19:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C461E284F;
	Fri, 15 Nov 2024 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MHLFIh7k"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5491E2843
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700169; cv=none; b=VqK/5b6FZrwEBfXo8aQ1tIdLRG9aAM4E6L9HodTwSlPzr9ou/lTRLpdYqAdJS0awxkZ+RDLZ7obD2ufu+0ciCxYsz0o4C4pavI/8Jiq56mbao3KyYxKLIj/AUhDLykYmey7u4RiUcb5IJfcS4YSsZQfkPc3+fn76X60vnhaEdoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700169; c=relaxed/simple;
	bh=z55QMGHuyU79Lo0rgWIuj7M6h2JF0d6bWRj3SaLRuMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2YWxtn6lW3+zcC3uIXj5SgK8aDrYtRVV+yyyu21EKFnoU2HWc2E/KW+cTS076QzcOMDhwm14jxD+0l5sWCLATJwJba6nY1U6/U/QlEJlLGOqriESTnF2uPdOQc9jD+m/sxPys9DXnM4xJJqZFwrduO/0Dsr2VBu7KpqOIBS2+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MHLFIh7k; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFIVHoG001670;
	Fri, 15 Nov 2024 11:48:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=2L+peR7S2VvIoHrnyDWB/FySR1z6OXVk418UFVTrmvs=; b=MHLFIh7k7kel
	W1LtLjFP3BeP3ZG5qZqdR+u3XOalMcCBj4FbR35dG0ypVbA12kI/YC0Qe6a2Eng1
	cr0tzB4zCfLPZtXnwA+4KrXeBpnhdnfW8K8HMJKPWh5I4x+qL6OB7j4lYLDvsKeD
	6jdEe3fANo4F42z7ytJIR4i4iMuMQl0VKG1xou2PkZ0fauNNLl0tqFBnbzPWG2uI
	VdjGQedUdzPdasUiVfET5nJz+as6tmcizUh2QbdWp2nMwK7XAI+AJdHzG1HVnpTi
	QFXPyzdK4DL/F3lUFJKtCuC2vgbCo63anxe1fh3DOQfnSrVcMnDMWGIwc4HbS1GU
	XJDH9+sPPg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42x6cmk29d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 15 Nov 2024 11:48:53 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Fri, 15 Nov 2024 19:48:51 +0000
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
        Mykola Lysenko <mykolal@fb.com>
CC: <x86@kernel.org>, <bpf@vger.kernel.org>,
        Vadim Fedorenko
	<vadfed@meta.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v6 2/4] bpf: add bpf_cpu_cycles_to_ns helper
Date: Fri, 15 Nov 2024 11:48:39 -0800
Message-ID: <20241115194841.2108634-3-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241115194841.2108634-1-vadfed@meta.com>
References: <20241115194841.2108634-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7XoHtLBla1uH8yg5Uwk71iP3hZzi_H-p
X-Proofpoint-ORIG-GUID: 7XoHtLBla1uH8yg5Uwk71iP3hZzi_H-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

The new helper should be used to convert cycles received by
bpf_get_cpu_cycle() into nanoseconds.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
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
 kernel/bpf/helpers.c          | 13 ++++++++++++-
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 107bd921f104..b87233d41a75 100644
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
+			    boot_cpu_has(X86_FEATURE_CONSTANT_TSC)) {
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
index e6097a371b69..34f762f28c82 100644
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
+				    boot_cpu_has(X86_FEATURE_CONSTANT_TSC)) {
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
index 12d40537e57b..e89eff53c340 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3073,8 +3073,18 @@ __bpf_kfunc u64 bpf_get_cpu_cycles(void)
 	 */
 	return __arch_get_hw_counter(vd->clock_mode, vd);
 }
-#endif
 
+__bpf_kfunc u64 bpf_cpu_cycles_to_ns(u64 cycles)
+{
+	const struct vdso_data *vd = __arch_get_k_vdso_data();
+
+	/* kfunc implementation does less manipulations than vDSO
+	 * implementation. BPF use-case assumes two measurements are close
+	 * in time and can simplify the logic.
+	 */
+	return mul_u64_u32_shr(cycles, vd->mult, vd->shift);
+}
+#endif
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3169,6 +3179,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 #if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
 BTF_ID_FLAGS(func, bpf_get_cpu_cycles, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_cpu_cycles_to_ns, KF_FASTCALL)
 #endif
 BTF_KFUNCS_END(common_btf_ids)
 
-- 
2.43.5


