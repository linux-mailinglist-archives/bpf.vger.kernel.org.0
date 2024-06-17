Return-Path: <bpf+bounces-32315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B306190B798
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 19:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 837BFB2EE55
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2F215F316;
	Mon, 17 Jun 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="wNFiqS8u"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD9179BD;
	Mon, 17 Jun 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641945; cv=none; b=Du3KVHkxkkUUkV+Dv5EPD3txPsGu/lHYi6LbHCRfOiTXOxYCpXqpcg+j0XW8YgG8wlW4/4YVxY90jMeEW9ln6dQDh6FvSllKLUUQGZ9/gsSgYMYjdRAflkQpgXxpj2CPVkKFLYpKqa++yRHCeiq8uwTLjJxS54ZsgdvRrA3B+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641945; c=relaxed/simple;
	bh=NMuqlV81yEhMTGA+GXDug56UYmtbasUZWM77Yr9xvNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWBniu3JtIbetqvPNmngcrc5ex4fHyqXN3JDtvlRCmWctGs59zENjCbZWKW3TCWwYcJlF+Hh5l8T8Xuwc68hhVUmRJJBDvEaFrizNf/ykU7AjgNHnV8vvxHGnXAHC5HOTqa+86Q6/RHCAhs5Sov9KnhfYdtFHO6Z5KBD15Z1LCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=wNFiqS8u; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355092.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HCT0KC005637;
	Mon, 17 Jun 2024 16:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=JyFXW7AIicPfDE5WIIpiIVa
	ZETUucedPQnOCDS26UwE=; b=wNFiqS8uVqwBLjtqme90BjvTeNwhuqxwj//Avna
	BJmuGg/qDUiFrKitQWsjxj18MtEAjChrfteYNOUrbOtmIr9FEPGqNQF9zylfJW9P
	3KXZCdNes75xjOLRxrZMMKPOWnFMQSsQ3CiLLTdjKMJ1HPhMlyrgG5IoouEj14fy
	tOoHSpGJTktgepmujpQX56AqTiFnqZCH9k7RsXiWb/9mQbwMB92Pzmf7g2Zrup0k
	TtBQ7misaSkF6EvumeM+MaJGibC9XFD7NnCmENXx5P/y7cwpjPHygccW5qQcIrxD
	sLheBnAyYfMjAxJsQZOz1GgSRrxIZDA+ElNOrobtG85CQqQ==
Received: from va32lpfpp01.lenovo.com ([104.232.228.21])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3yss9d2tet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 16:32:01 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4W2wQ84tzzzldQp;
	Mon, 17 Jun 2024 16:32:00 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W2wQ81Lxdz2VZ3B;
	Mon, 17 Jun 2024 16:32:00 +0000 (UTC)
Date: Mon, 17 Jun 2024 11:31:58 -0500
From: Maxwell Bland <mbland@motorola.com>
To: "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v7 2/2] arm64/cfi,bpf: Support kCFI + BPF on arm64
Message-ID: <puj3euv5eafwcx5usqostpohmxgdeq3iout4hqnyk7yt5hcsux@gpiamodhfr54>
References: <ptrugmna4xb5o5lo4xislf4rlz7avdmd4pfho5fjwtjj7v422u@iqrwfrbwuxrq>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ptrugmna4xb5o5lo4xislf4rlz7avdmd4pfho5fjwtjj7v422u@iqrwfrbwuxrq>
X-Proofpoint-ORIG-GUID: Q-4NSrSqrLL73lhblQZq6TmH9TO5VbAw
X-Proofpoint-GUID: Q-4NSrSqrLL73lhblQZq6TmH9TO5VbAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170127

From: Puranjay Mohan <puranjay12@gmail.com>

Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
calling BPF programs from this interface doesn't cause CFI warnings.

When BPF programs are called directly from C: from BPF helpers or
struct_ops, CFI warnings are generated.

Implement proper CFI prologues for the BPF programs and callbacks and
drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
prologue when a struct_ops trampoline is being prepared.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/include/asm/cfi.h    | 23 +++++++++++++++++++++++
 arch/arm64/kernel/alternative.c | 18 ++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c   | 21 ++++++++++++++++++---
 3 files changed, 59 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h

diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
new file mode 100644
index 000000000000..670e191f8628
--- /dev/null
+++ b/arch/arm64/include/asm/cfi.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_CFI_H
+#define _ASM_ARM64_CFI_H
+
+#ifdef CONFIG_CFI_CLANG
+#define __bpfcall
+static inline int cfi_get_offset(void)
+{
+	return 4;
+}
+#define cfi_get_offset cfi_get_offset
+extern u32 cfi_bpf_hash;
+extern u32 cfi_bpf_subprog_hash;
+extern u32 cfi_get_func_hash(void *func);
+#else
+#define cfi_bpf_hash 0U
+#define cfi_bpf_subprog_hash 0U
+static inline u32 cfi_get_func_hash(void *func)
+{
+	return 0;
+}
+#endif /* CONFIG_CFI_CLANG */
+#endif /* _ASM_ARM64_CFI_H */
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 8ff6610af496..d7a58eca7665 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -8,11 +8,13 @@
 
 #define pr_fmt(fmt) "alternatives: " fmt
 
+#include <linux/cfi_types.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
 #include <linux/elf.h>
 #include <asm/cacheflush.h>
 #include <asm/alternative.h>
+#include <asm/cfi.h>
 #include <asm/cpufeature.h>
 #include <asm/insn.h>
 #include <asm/module.h>
@@ -298,3 +300,19 @@ noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
 		updptr[i] = cpu_to_le32(aarch64_insn_gen_nop());
 }
 EXPORT_SYMBOL(alt_cb_patch_nops);
+
+#ifdef CONFIG_CFI_CLANG
+struct bpf_insn;
+/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
+extern unsigned int __bpf_prog_runX(const void *ctx,
+				    const struct bpf_insn *insn);
+DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
+/* Must match bpf_callback_t */
+extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
+DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
+u32 cfi_get_func_hash(void *func)
+{
+	u32 *hashp = func - cfi_get_offset();
+	return READ_ONCE(*hashp);
+}
+#endif
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 720336d28856..211e1c29f004 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -17,6 +17,7 @@
 #include <asm/asm-extable.h>
 #include <asm/byteorder.h>
 #include <asm/cacheflush.h>
+#include <asm/cfi.h>
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
 #include <asm/patching.h>
@@ -162,6 +163,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
 		emit(insn, ctx);
 }
 
+static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
+{
+	if (IS_ENABLED(CONFIG_CFI_CLANG))
+		emit(hash, ctx);
+}
+
 /*
  * Kernel addresses in the vmalloc space use at most 48 bits, and the
  * remaining bits are guaranteed to be 0x1. So we can compose the address
@@ -311,7 +318,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 	const u8 tcc = bpf2a64[TCALL_CNT];
 	const u8 fpb = bpf2a64[FP_BOTTOM];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
-	const int idx0 = ctx->idx;
 	int cur_offset;
 
 	/*
@@ -337,6 +343,9 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 	 *
 	 */
 
+	emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
+	const int idx0 = ctx->idx;
+
 	/* bpf function may be invoked by 3 instruction types:
 	 * 1. bl, attached via freplace to bpf prog via short jump
 	 * 2. br, attached via freplace to bpf prog via long jump
@@ -1849,9 +1858,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		jit_data->ro_header = ro_header;
 	}
 
-	prog->bpf_func = (void *)ctx.ro_image;
+	prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
 	prog->jited = 1;
-	prog->jited_len = prog_size;
+	prog->jited_len = prog_size - cfi_get_offset();
 
 	if (!prog->is_func || extra_pass) {
 		int i;
@@ -2104,6 +2113,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	/* return address locates above FP */
 	retaddr_off = stack_size + 8;
 
+	if (flags & BPF_TRAMP_F_INDIRECT) {
+		/*
+		 * Indirect call for bpf_struct_ops
+		 */
+		emit_kcfi(cfi_get_func_hash(func_addr), ctx);
+	}
 	/* bpf trampoline may be invoked by 3 instruction types:
 	 * 1. bl, attached to bpf prog or kernel function via short jump
 	 * 2. br, attached to bpf prog or kernel function via long jump
-- 
2.43.0


