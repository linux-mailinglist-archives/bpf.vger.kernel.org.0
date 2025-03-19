Return-Path: <bpf+bounces-54394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6230FA6951F
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 17:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98C719C3C53
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 16:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3351DF987;
	Wed, 19 Mar 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="C7qQ4eKu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6F1DF996
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402287; cv=none; b=QwOmgPKno0uqEqX2/LRaPwpVl3rDqYMljLoepUlND8/3QVd3yo5Sp5dTuN8yZqNXrvMEX0TN+nAddSOHb0lifMwj0veub1B0blTd+FEnkv//gNWGKu9wcMHRhWX++JsJX50cv4UlbB5iXk3wsG7FwE5+TZ+AMGXSvcDUE/o/8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402287; c=relaxed/simple;
	bh=bg3adV5mGxy4H31FCVfcOYW7nPNrXcTa7FLWNq8+Bck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUlAy9T1nfibeDgVXt0aQXuhzuDllYUw6p+8HHB2bzp8HskmSPc4YPcf4AQkr5QZRYOwVNkzo12dYQdD3AttpP8Iopc4IxTaqZRAGC/bi3XywFAD6Iapp2Yrq4jBqy9YYVCEyMuToIe4vc7gfSFyI7U9BYcO/OGLFvzx109+hlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C7qQ4eKu; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 52JGCVYv020382;
	Wed, 19 Mar 2025 09:37:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=Dvp1jwGe2CFsu1aBCwRwMzmZ7NbvDYio+ofvr57FOqE=; b=C7qQ4eKu7qvW
	gWoU8KgHKLnlZGO4V+TdVlSnj/Gu+omNbV31+AMvYdU3kYHStmLnsIN0RfqDbpeL
	yfk9hSlz8ghGiZ2Zs+Kj8WcG88625SzC8BaxrLU8FoPUsDP2csBH7r8Kb61fLqH0
	1HGM150SMUzrIcW4EYPvNj/b0jirTxkdGdzHlgP/qjIIsIqZgtJ+d+Cv7qupnhsD
	SCaHqgYJz/Ynp/mq0LTRDzmFvkDjD1wWvcJvIX26N7NUfel9YwGd+WdpVOpPruT3
	dWisGsSaI2Wx9oymIZGfcq5Jax2uAc9dRWz06n83M0qII1FZg9dKRxQZZL7cf3e7
	wHJlKNiwUg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 45fn4mmb9n-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 19 Mar 2025 09:37:20 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.14; Wed, 19 Mar 2025 16:36:50 +0000
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
Subject: [PATCH bpf-next v12 3/5] bpf: add bpf_cpu_time_counter_to_ns helper
Date: Wed, 19 Mar 2025 09:36:36 -0700
Message-ID: <20250319163638.3607043-4-vadfed@meta.com>
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
X-Proofpoint-ORIG-GUID: 1tzwIaHPfVd_4Em2UJ7jP1yHxV8SD_2D
X-Proofpoint-GUID: 1tzwIaHPfVd_4Em2UJ7jP1yHxV8SD_2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01

The new helper should be used to convert deltas of values
received by bpf_get_cpu_time_counter() into nanoseconds. It is not
designed to do full conversion of time counter values to
CLOCK_MONOTONIC_RAW nanoseconds and cannot guarantee monotonicity of 2
independent values, but rather to convert the difference of 2 close
enough values of CPU timestamp counter into nanoseconds.

This function is JITted into just several instructions and adds as
low overhead as possible and perfectly suits benchmark use-cases.

When the kfunc is not JITted it returns the value provided as argument
because the kfunc in previous patch will return values in nanoseconds
and can be optimized by verifier.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 arch/x86/net/bpf_jit_comp.c   | 29 ++++++++++++++++++++++++++++-
 arch/x86/net/bpf_jit_comp32.c |  1 +
 include/linux/bpf.h           |  1 +
 kernel/bpf/helpers.c          |  6 ++++++
 kernel/bpf/verifier.c         |  9 ++++++++-
 5 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 284696d69df4..8ff8d7436fc9 100644
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
@@ -2287,6 +2288,31 @@ st:			if (is_imm8(insn->off))
 				break;
 			}
 
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+			    imm32 == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
+			    bpf_jit_inlines_kfunc_call(imm32)) {
+				struct cyc2ns_data data;
+				u32 mult, shift;
+
+				/* stable TSC runs with fixed frequency and
+				 * transformation coefficients are also fixed
+				 */
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
@@ -3902,7 +3928,8 @@ bool bpf_jit_supports_timed_may_goto(void)
 /* x86-64 JIT can inline kfunc */
 bool bpf_jit_inlines_kfunc_call(s32 imm)
 {
-	if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
+	if ((imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) ||
+	    imm == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns)) &&
 	    cpu_feature_enabled(X86_FEATURE_TSC) &&
 	    using_native_sched_clock() && sched_clock_stable())
 		return true;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 68511888eb27..83176a07fc08 100644
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
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6cf9138b2437..fc03a3805b36 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3391,6 +3391,7 @@ u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
 /* Inlined kfuncs */
 u64 bpf_get_cpu_time_counter(void);
+u64 bpf_cpu_time_counter_to_ns(u64 counter);
 
 #if defined(CONFIG_NET)
 bool bpf_sock_common_is_valid_access(int off, int size,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 26f71e2438d2..a176bd5a33d0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3205,6 +3205,11 @@ __bpf_kfunc u64 bpf_get_cpu_time_counter(void)
 	return ktime_get_raw_fast_ns();
 }
 
+__bpf_kfunc u64 bpf_cpu_time_counter_to_ns(u64 counter)
+{
+	return counter;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3306,6 +3311,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
 BTF_ID_FLAGS(func, bpf_get_cpu_time_counter)
+BTF_ID_FLAGS(func, bpf_cpu_time_counter_to_ns, KF_FASTCALL)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aea1040b4462..3a908cf24e45 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12007,6 +12007,7 @@ enum special_kfunc_type {
 	KF_bpf_iter_num_destroy,
 	KF_bpf_set_dentry_xattr,
 	KF_bpf_remove_dentry_xattr,
+	KF_bpf_cpu_time_counter_to_ns,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -12040,6 +12041,7 @@ BTF_ID(func, bpf_iter_css_task_new)
 BTF_ID(func, bpf_set_dentry_xattr)
 BTF_ID(func, bpf_remove_dentry_xattr)
 #endif
+BTF_ID(func, bpf_cpu_time_counter_to_ns)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12096,6 +12098,7 @@ BTF_ID(func, bpf_remove_dentry_xattr)
 BTF_ID_UNUSED
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_cpu_time_counter_to_ns)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -21246,6 +21249,9 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
+	/* if JIT will inline kfunc verifier shouldn't change the code */
+	if (bpf_jit_inlines_kfunc_call(insn->imm))
+		return 0;
 	if (insn->off)
 		return 0;
 	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
@@ -21310,7 +21316,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		__fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_meta_reg,
 						node_offset_reg, insn, insn_buf, cnt);
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
+		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast] ||
+		   desc->func_id == special_kfunc_list[KF_bpf_cpu_time_counter_to_ns]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
 	} else if (is_bpf_wq_set_callback_impl_kfunc(desc->func_id)) {
-- 
2.47.1


