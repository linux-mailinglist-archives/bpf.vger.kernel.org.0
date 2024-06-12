Return-Path: <bpf+bounces-31937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 665109056E4
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 17:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B851F264CB
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A681802D0;
	Wed, 12 Jun 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="kgM3DdXC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23418622;
	Wed, 12 Jun 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206303; cv=none; b=NQmNB9tDjUiamcNhP4RCs02Vsr4t1L5db/QUUAt9HQnCO6+v6PgoVoOOUcP1tLAFvWgDWdKTeEnFTfSCFx2GVBMhPx6AH78+IdIzijGTg8VaK9ah+FUqd1TLnnOwAqjBJSOYJkvYn9oNoc3Y0kRRa8bWRmUZ18D/cysRZ+WBFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206303; c=relaxed/simple;
	bh=zgpApcLK4ow6FIOdw2BSl+WH4PNUGxPZ5JBKo1d84gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khvJXnPIrUZG5M9mk8h10zA7YgRhY5xC7ZWBJ0cybCr1W7KDhJ5bs4s27HnlQmSDmX5fG5F3NaEdTuWSniJwlU4Th4rbnUUV03/xE/vQyzVibSAAMo/QutrR1Tee/z3UeFzMKRRA++6juAPwfXjfhRIIm9Q7nLJyLpuibi1zQIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=kgM3DdXC; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355086.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CD9GJx021569;
	Wed, 12 Jun 2024 15:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=a4s3FH+hpDH3hFod22EhY5F
	wnbYexAKiSzqQqvZdLNE=; b=kgM3DdXCzxqrl73mAuKtr2a1MK9gSMBxLKO0n6P
	8AylSndFpVHRn8IfMr+xcvlh/E9d2zLidwG8gZCpQpQPeN1WXVXo/GVLf0tdFm4V
	rNPnlv25+j2D9SCs5J31qXgBrysBlWwya/uB1InmA7mItQ4MF9Ilr/XfKhSIAyNV
	kBBwlaRTGykFdW4zVBhlsjwYkKSLdpXAutJAQRvq+Jp7aSAdRd9+co2u532ruZPo
	8KvpCNFSWPbsraTO35tHsp5keSBz7ArjE2aMkyvKHD4Tv5wxruOtewnY5vCzy2KT
	4FC9N1w1KAMJJxqzwiRQklyNP/7NpGPtfiniEgQ0kQE1Thw==
Received: from va32lpfpp01.lenovo.com ([104.232.228.21])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3yn52m7kut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 15:31:14 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4VzqJK6Z9tzhWB7;
	Wed, 12 Jun 2024 15:31:13 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4VzqJK4lQBz3p6jp;
	Wed, 12 Jun 2024 15:31:13 +0000 (UTC)
Date: Wed, 12 Jun 2024 10:31:12 -0500
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
Subject: [PATCH bpf-next v6 2/3] arm64/cfi,bpf: Support kCFI + BPF on arm64
Message-ID: <rx7kmqhdg5kree76ujngi34hxxaoitnsrl5wcaxkwdfjx4l4hj@hpxvlmthj6ga>
References: <illfkwuxwq3adca2h4shibz2xub62kku3g2wte4sqp7xj7cwkb@ckn3qg7zxjuv>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <illfkwuxwq3adca2h4shibz2xub62kku3g2wte4sqp7xj7cwkb@ckn3qg7zxjuv>
X-Proofpoint-GUID: ba44IPis5dS1I3eljDJ0KPPH5WEXiNbI
X-Proofpoint-ORIG-GUID: ba44IPis5dS1I3eljDJ0KPPH5WEXiNbI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120111

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
 arch/arm64/include/asm/cfi.h    | 23 ++++++++++++++
 arch/arm64/kernel/alternative.c | 54 +++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c   | 21 +++++++++++--
 3 files changed, 95 insertions(+), 3 deletions(-)
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
index 8ff6610af496..1715da7df137 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -13,6 +13,7 @@
 #include <linux/elf.h>
 #include <asm/cacheflush.h>
 #include <asm/alternative.h>
+#include <asm/cfi.h>
 #include <asm/cpufeature.h>
 #include <asm/insn.h>
 #include <asm/module.h>
@@ -298,3 +299,56 @@ noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
 		updptr[i] = cpu_to_le32(aarch64_insn_gen_nop());
 }
 EXPORT_SYMBOL(alt_cb_patch_nops);
+
+#ifdef CONFIG_CFI_CLANG
+struct bpf_insn;
+
+/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
+extern unsigned int __bpf_prog_runX(const void *ctx,
+				    const struct bpf_insn *insn);
+
+/*
+ * Force a reference to the external symbol so the compiler generates
+ * __kcfi_typid.
+ */
+__ADDRESSABLE(__bpf_prog_runX);
+
+/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
+asm (
+"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
+"	.type	cfi_bpf_hash,@object				\n"
+"	.globl	cfi_bpf_hash					\n"
+"	.p2align	2, 0x0					\n"
+"cfi_bpf_hash:							\n"
+"	.word	__kcfi_typeid___bpf_prog_runX			\n"
+"	.size	cfi_bpf_hash, 4					\n"
+"	.popsection						\n"
+);
+
+/* Must match bpf_callback_t */
+extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
+
+__ADDRESSABLE(__bpf_callback_fn);
+
+/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
+asm (
+"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
+"	.type	cfi_bpf_subprog_hash,@object			\n"
+"	.globl	cfi_bpf_subprog_hash				\n"
+"	.p2align	2, 0x0					\n"
+"cfi_bpf_subprog_hash:						\n"
+"	.word	__kcfi_typeid___bpf_callback_fn			\n"
+"	.size	cfi_bpf_subprog_hash, 4				\n"
+"	.popsection						\n"
+);
+
+u32 cfi_get_func_hash(void *func)
+{
+	u32 hash;
+
+	if (get_kernel_nofault(hash, func - cfi_get_offset()))
+		return 0;
+
+	return hash;
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



