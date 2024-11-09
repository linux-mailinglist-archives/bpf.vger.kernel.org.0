Return-Path: <bpf+bounces-44402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CEA9C28F9
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 01:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E211C2177D
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 00:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D948E610D;
	Sat,  9 Nov 2024 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QVgvVCTb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E798C07
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112959; cv=none; b=rM2aPM4uJpman0vuiWBU3OXavInPztciowj+43Nj57OTw72OfqfZXL7SWZponEGeCMnzFw9M9Dqxxb/chb8SIFBgVLBwt+TTxD/tPWRwbwnAdx+WBAV7sPNFRZMOnrM+G4YFo61H1jq9XTE4fVLLuEhZnJVxITLwz1Y9jBg5kpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112959; c=relaxed/simple;
	bh=lCA7kE8eJPbbby/OWYXwaSgudjElro42JjrwaPz8fko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpc7L5/Ef3Hr4o+pfuDM4ucWG9HwRZIWEHjRELfVFZGwqpgH/G0BHIVbcJi4xvCbqI33quelRzCYFmYdhmDAYFDqKfBEY56Nf4TWpKB5aMkF3KUtqyjVrOSUTvHyEmVFsh4/Vws6iZzRLOKLOS9KzxPPd57oesI1uAMa3qhAkEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QVgvVCTb; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4A905Rcd031770;
	Fri, 8 Nov 2024 16:42:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=KSj1dXaY4HBmCHkzSYAKNoaKkZ7HsCKIEK6LG7RtK+U=; b=QVgvVCTb/QvV
	A7YVp5WJdWUj0SpTMdnZtp/NOAp7umAE8ekwQKVgnMADiZuXzleqTC6HQMIDF6i7
	XXl3ewzVYCHdujNL+sx90TMjEywEiVBDFCl5SjWz5IaA4kbqxwqrrMPhax+zNPl0
	hjhqtOA6QVQ2YQjOTDUtoMYYVgoTov3928wV8ATX1i4ypyFJq/S2qguUxUOeC2C2
	RcsrR7a4Vsye1CIEEuNQemQVRNdrZQV9EnHmH1pCo2Tp+pzADcv5/PcEFJWRguae
	CA3SlvczStP9qXD9GcTTKA5p/M/rRSPu/lvyNsnslFH6H9hG5H4LNflZShi0CGrk
	4dn9Mv/6ig==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42svvsg65e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 08 Nov 2024 16:42:12 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Sat, 9 Nov 2024 00:42:08 +0000
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
Subject: [PATCH bpf-next v5 2/4] bpf: add bpf_cpu_cycles_to_ns helper
Date: Fri, 8 Nov 2024 16:41:55 -0800
Message-ID: <20241109004158.2259301-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109004158.2259301-1-vadfed@meta.com>
References: <20241109004158.2259301-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: X2YPAdLbcbBEVufkNP00XKR47RdL772g
X-Proofpoint-GUID: X2YPAdLbcbBEVufkNP00XKR47RdL772g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

The new helper should be used to convert cycles received by
bpf_get_cpu_cycle() into nanoseconds.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v5:
* no changes
v4:
* change helper name to bpf_cpu_cycles_to_ns.
* hide it behind CONFIG_GENERIC_GETTIMEOFDAY to avoid exposing on
  unsupported architectures.
---
 arch/x86/net/bpf_jit_comp.c   | 22 ++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp32.c | 19 +++++++++++++++++++
 include/linux/bpf.h           |  1 +
 kernel/bpf/helpers.c          | 10 +++++++++-
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 4f78ed93ee7f..ddc73d9a90f4 100644
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
@@ -2146,6 +2147,24 @@ st:			if (is_imm8(insn->off))
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
 			if (tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
@@ -3678,5 +3697,8 @@ bool bpf_jit_inlines_kfunc_call(s32 imm)
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
index fed5f36d387a..46fa662d95e4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3331,6 +3331,7 @@ u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 /* Inlined kfuncs */
 #if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
 u64 bpf_get_cpu_cycles(void);
+u64 bpf_cpu_cycles_to_ns(u64 cycles);
 #endif
 
 #if defined(CONFIG_NET)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5c6c0383ebf4..72d5819e5df2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -25,6 +25,7 @@
 #include <linux/kasan.h>
 #if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
 #include <vdso/datapage.h>
+#include <asm/vdso/vsyscall.h>
 #endif
 
 #include "../../lib/kstrtox.h"
@@ -3031,8 +3032,14 @@ __bpf_kfunc u64 bpf_get_cpu_cycles(void)
 {
 	return __arch_get_hw_counter(1, NULL);
 }
-#endif
 
+__bpf_kfunc u64 bpf_cpu_cycles_to_ns(u64 cycles)
+{
+	const struct vdso_data *vd = __arch_get_k_vdso_data();
+
+	return mul_u64_u32_shr(cycles, vd->mult, vd->shift);
+}
+#endif
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3127,6 +3134,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 #if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
 BTF_ID_FLAGS(func, bpf_get_cpu_cycles, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_cpu_cycles_to_ns, KF_FASTCALL)
 #endif
 BTF_KFUNCS_END(common_btf_ids)
 
-- 
2.43.5


