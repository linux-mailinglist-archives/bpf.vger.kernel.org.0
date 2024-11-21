Return-Path: <bpf+bounces-45305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2949D44CE
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707EFB20CD8
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE434A1D;
	Thu, 21 Nov 2024 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="UFBpu5Dl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722924A0F
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147762; cv=none; b=jo8hsBLCXv46Xssaq29AL45/yBlwNKRPVV/fNX7ONRNFRSqnA2i+YzaUOG80K8Ap9EkQrwQJ/ualnFX0zE2DNJqvXzCeHRq+vwKN2Se0Mvyul0hYKvMPYw+E/X3dxfzSt4asAYO6dqTAFzTVu0fOkeq7CLx/FNPi8cFxnhcLKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147762; c=relaxed/simple;
	bh=JBeJwGmRAOGBxpDFqsjGjW+qj7nV5jbz7axUIfSZMYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbyT1SYV/aDZsAWssalTnQynBLAC00JZagUFRV+EUoVUZZQx4B7Nce/26+D9esjucUbGs3wLeVT+KB+yVm1WPLqP5jcz73whrzQbP0IM4l3AG3tTiDBrW8MGV5dwglIshFPpdWrFnFtnjL4dcm0JaD9kQ1DtN93SMzkIUTKxuws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=UFBpu5Dl; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKKZ2mX001523;
	Wed, 20 Nov 2024 16:08:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=if2zdLA/u/rKNM4haD6SBpG9GUuV/HbviyQ79qjmJ7Q=; b=UFBpu5Dl/OPa
	zfEyt0cOElLXdmbPGmFW6upuX7LvqFUenJ0kzo6Ir2gZ1u5vc/V0EtRRLt7MUX38
	1JkJ7Bpvovba/sQeCyKvKYzZv2dV5ELS959FNV5UTPiFrZqhJcDiq8VzPHRSGO2X
	Sp9wWwrayu2hSBSBMgzg62JoOY41aVcFikxx5WX/NgIp4XM10ZaX0Ey09UUOpEU0
	EPZMsAvrnUUxB0amoW0BJ4GeFpgqcpPJV1AAZQPvqQSMpa/zzaHKIq9Yx7D6zl76
	/Cf1jf7pSjg4HgutxGgea/4K8qCHGn/JC0QskNC4S1xSr2+EgpfBjPMKa+Mj17Nu
	Ulrn3Cw1EA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 431pxah760-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Nov 2024 16:08:33 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 21 Nov 2024 00:08:29 +0000
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
Subject: [PATCH bpf-next v8 2/4] bpf: add bpf_cpu_time_counter_to_ns helper
Date: Wed, 20 Nov 2024 16:08:12 -0800
Message-ID: <20241121000814.3821326-3-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241121000814.3821326-1-vadfed@meta.com>
References: <20241121000814.3821326-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: m0EN0tcAvWJxpguwaxjf7kqpf071K-y6
X-Proofpoint-ORIG-GUID: m0EN0tcAvWJxpguwaxjf7kqpf071K-y6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

The new helper should be used to convert cycles received by
bpf_get_cpu_cycle() into nanoseconds.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v7 -> v8:
* rename helper to bpf_cpu_time_counter_to_ns
* use cyc2ns_read_begin()/cyc2ns_read_end() to get mult and shift
  values instead of manually recalculating them (Peter)
v6 -> v7:
* change boot_cpu_has() -> cpu_feature_enabled() (Borislav)
v4 -> v6:
* add comment about simplified implementation (Eduard)
v4:
* change helper name to bpf_cpu_cycles_to_ns.
* hide it behind CONFIG_GENERIC_GETTIMEOFDAY to avoid exposing on
  unsupported architectures.
---
 arch/x86/net/bpf_jit_comp.c   | 27 +++++++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp32.c | 27 +++++++++++++++++++++++++++
 include/linux/bpf.h           |  1 +
 kernel/bpf/helpers.c          | 14 +++++++++++++-
 4 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 92431ab1a21e..d21e0ab55c94 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -11,10 +11,12 @@
 #include <linux/bpf.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
+#include <linux/clocksource.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
+#include <asm/timer.h>
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
 #include <asm/cfi.h>
@@ -2216,6 +2218,28 @@ st:			if (is_imm8(insn->off))
 				break;
 			}
 
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+			    imm32 == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
+			    using_native_sched_clock() && sched_clock_stable()) {
+				struct cyc2ns_data data;
+				u32 mult, shift;
+
+				cyc2ns_read_begin(&data);
+				mult = data.cyc2ns_mul;
+				shift = data.cyc2ns_shift;
+				cyc2ns_read_end();
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
@@ -3828,5 +3852,8 @@ bool bpf_jit_inlines_kfunc_call(s32 imm)
 {
 	if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter))
 		return true;
+	if (imm == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
+	    using_native_sched_clock() && sched_clock_stable())
+		return true;
 	return false;
 }
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index a549aea25f5f..a2069a3ee4a3 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -12,10 +12,12 @@
 #include <linux/netdevice.h>
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
+#include <linux/clocksource.h>
 #include <asm/cacheflush.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/asm-prototypes.h>
+#include <asm/timer.h>
 #include <linux/bpf.h>
 
 /*
@@ -2100,6 +2102,27 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 					EMIT2(0x0F, 0x31);
 					break;
 				}
+				if (imm32 == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
+				    cpu_feature_enabled(X86_FEATURE_CONSTANT_TSC)) {
+					struct cyc2ns_data data;
+					u32 mult, shift;
+
+					cyc2ns_read_begin(&data);
+					mult = data.cyc2ns_mul;
+					shift = data.cyc2ns_shift;
+					cyc2ns_read_end();
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
@@ -2633,5 +2656,9 @@ bool bpf_jit_inlines_kfunc_call(s32 imm)
 {
 	if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter))
 		return true;
+	if (imm == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
+	    using_native_sched_clock() && sched_clock_stable())
+		return true;
+
 	return false;
 }
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6d540253cfb4..dd3c4ddfd60e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3336,6 +3336,7 @@ u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 /* Inlined kfuncs */
 #if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
 u64 bpf_get_cpu_time_counter(void);
+u64 bpf_cpu_time_counter_to_ns(u64 cycles);
 #endif
 
 #if defined(CONFIG_NET)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 23f1a1606f8b..e4d461f2e98f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3079,8 +3079,19 @@ __bpf_kfunc u64 bpf_get_cpu_time_counter(void)
 	 */
 	return __arch_get_hw_counter(1, vd);
 }
-#endif
 
+__bpf_kfunc u64 bpf_cpu_time_counter_to_ns(u64 cycles)
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
 BTF_ID_FLAGS(func, bpf_get_cpu_time_counter, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_cpu_time_counter_to_ns, KF_FASTCALL)
 #endif
 BTF_KFUNCS_END(common_btf_ids)
 
-- 
2.43.5


