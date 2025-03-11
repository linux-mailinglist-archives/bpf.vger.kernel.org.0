Return-Path: <bpf+bounces-53838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547EEA5C8CD
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B28188C710
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6D425F785;
	Tue, 11 Mar 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RfWk/6qR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BB25EFBA
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708200; cv=none; b=eYYoTzI5M2pZzLEFwPDIgKHdUQhnEyH0lBhMv00QDytngi8eWSvxJZ6Yo7jbfabklrrYQaS9kRH4OH4RTmpejwyQqoPn3MxjIz4Lbr7DnsY7w6W8Yljvr3qnljagpdINAnOJbrfpWbanRnMcaKnDuX8J34/zK9deXthuYVXfio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708200; c=relaxed/simple;
	bh=fLKkkBXfBYpe2I7wvhJIWoPKOgMYDyTHaY2UoU0fpwc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hC5Q3no8MinZKGVVsOwGGQW9hZu0Q46SOlYqQg9qj548xDOZ59LxA1pC2CtZ0AZGyP9APysxgU1gAzzCAppGRJSsfaypVqZozFDw+lwX0mV1HTWEbDLYgpMdTbCOZVd57AD156876FiPdv+8m5pa8GTVC4pwJ7fmXfROU+OmyQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RfWk/6qR; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BBd2so022081;
	Tue, 11 Mar 2025 08:49:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=FGiRvDu5qMJvnFytUpRoQ6NMlmlPRC3o8wZMDSrWBx4=; b=RfWk/6qRyLYi
	teT95MHNYka8Q8FAjzt8bR4QcON2h2MdURAHYS9/jhTZFpF+KYT0yS8URO2sbo1w
	S1JJPiZKV0lsOfXJGB8xx01+6fyDnN5H3sxYDWKIdaHrFeD7xEDoLoaOPzjw5Vfs
	0nnX2eak6smzziste+OSEi2xQotmCGKOxLi5IlLnKum94gd4chpLx4L6+qAknVZ2
	guNZ5gNrKIJPOWRzqDx9ppVFVDsLQz0en+MnTbgUnLL2DMFrgqVzI7K9duTwGs0u
	gT4Iqa9JC5cNesVqiYqW7h8ezc+Js9N8gt0mjI0mktR4m0rz8EK5MHZz4HY+/oRY
	2F/Iy0hBfQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45amfx1ndy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Mar 2025 08:49:10 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.14; Tue, 11 Mar 2025 15:49:07 +0000
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
Subject: [PATCH bpf-next v10 2/4] bpf: add bpf_cpu_time_counter_to_ns helper
Date: Tue, 11 Mar 2025 08:48:48 -0700
Message-ID: <20250311154850.3616840-3-vadfed@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311154850.3616840-1-vadfed@meta.com>
References: <20250311154850.3616840-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1YjwnSh2eikBmS1fyzaT71TybA-XnTNL
X-Proofpoint-ORIG-GUID: 1YjwnSh2eikBmS1fyzaT71TybA-XnTNL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01

The new helper should be used to convert deltas of values
received by bpf_get_cpu_time_counter() into nanoseconds. It is not
designed to do full conversion of time counter values to
CLOCK_MONOTONIC_RAW nanoseconds and cannot guarantee monotonicity of 2
independent values, but rather to convert the difference of 2 close
enough values of CPU timestamp counter into nanoseconds.

This function is JITted into just several instructions and adds as
low overhead as possible and perfectly suits benchmark use-cases.

When the kfunc is not JITted it returns the value provided as argument
because the kfunc in previous patch will return values in nanoseconds.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 arch/x86/net/bpf_jit_comp.c   | 27 ++++++++++++++++++++++++++-
 arch/x86/net/bpf_jit_comp32.c | 27 ++++++++++++++++++++++++++-
 include/linux/bpf.h           |  1 +
 kernel/bpf/helpers.c          |  6 ++++++
 4 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 92cd5945d630..56f7557048d1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -9,6 +9,7 @@
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
 #include <linux/bpf.h>
+#include <linux/clocksource.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
 #include <asm/extable.h>
@@ -2289,6 +2290,29 @@ st:			if (is_imm8(insn->off))
 				break;
 			}
 
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+			    imm32 == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
+			    cpu_feature_enabled(X86_FEATURE_TSC) &&
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
@@ -3906,7 +3930,8 @@ bool bpf_jit_inlines_kfunc_call(s32 imm)
 {
 	if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
 		return false;
-	if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
+	if ((imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) ||
+	    imm == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns)) &&
 	    cpu_feature_enabled(X86_FEATURE_TSC) &&
 	    using_native_sched_clock() && sched_clock_stable())
 		return true;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 7f13509c66db..9791a3fb9d69 100644
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
@@ -2115,6 +2116,29 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 					EMIT2(0x0F, 0x31);
 					break;
 				}
+				if (IS_ENABLED(CONFIG_BPF_SYSCALL) &&
+				    imm32 == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
+				    cpu_feature_enabled(X86_FEATURE_TSC) &&
+				    using_native_sched_clock() && sched_clock_stable()) {
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
@@ -2648,7 +2672,8 @@ bool bpf_jit_inlines_kfunc_call(s32 imm)
 {
 	if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
 		return false;
-	if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
+	if ((imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) ||
+	    imm == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns)) &&
 	    cpu_feature_enabled(X86_FEATURE_TSC) &&
 	    using_native_sched_clock() && sched_clock_stable())
 		return true;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 599aaa854e4c..5c4d35019b22 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3389,6 +3389,7 @@ u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
 /* Inlined kfuncs */
 u64 bpf_get_cpu_time_counter(void);
+u64 bpf_cpu_time_counter_to_ns(u64 cycles);
 
 #if defined(CONFIG_NET)
 bool bpf_sock_common_is_valid_access(int off, int size,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 43bf35a15f78..cc986d2048db 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3198,6 +3198,11 @@ __bpf_kfunc u64 bpf_get_cpu_time_counter(void)
 	return ktime_get_raw_fast_ns();
 }
 
+__bpf_kfunc u64 bpf_cpu_time_counter_to_ns(u64 cycles)
+{
+	return cycles;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3299,6 +3304,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
 BTF_ID_FLAGS(func, bpf_get_cpu_time_counter, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_cpu_time_counter_to_ns, KF_FASTCALL)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.47.1


