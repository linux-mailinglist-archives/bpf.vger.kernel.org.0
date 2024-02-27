Return-Path: <bpf+bounces-22771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9307F869A07
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 16:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E801C220E1
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2073D14601E;
	Tue, 27 Feb 2024 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laO9OWYA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C4145FF4;
	Tue, 27 Feb 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046708; cv=none; b=V7r+1+Gfxr03h8R8tns+I40GekcCY+I6dee3v94YJxMA5iHo2c6gg/Ovcd/5dJMJjIQL1L67IAhhx5wESoNITQ37mViTzjIw1B/stJ5I+xh9aKDGlCl2ebuN+t2ywqnAWRruZEdErYvCTo4eDp59gs46L9QuCWDfVxetd7dJjCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046708; c=relaxed/simple;
	bh=uXkdZ+nGgZ8dBlwogGYG/znpIjVGxCyU2Z1+CR/AVIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lm9uZ0h4p4qYHPsEw/XJsRFpfbgq8y5QxXVeXGS1drvRNylfHV0ZaMDW9yVox+aO4HbdyvK05mQyUMsS7z5oKc1zt2SSOkhZRuz4oFwcV+pIzS7H77ilii4MTv0GYXiI8dDPAijqOFtA95M7+GRwyHxxC0hHjKjmW/dMv+67r9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laO9OWYA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d6fe64a9bso3348660f8f.0;
        Tue, 27 Feb 2024 07:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709046705; x=1709651505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgUZYYEewWOr0eZgCM/D+yRszpCU2Zn6RVKpSWiScZI=;
        b=laO9OWYAnLP2pdH5x5Zu8gfMadrLUJjXCkBtFFrZ3pqPReFmMLF1KCBY43p5dOeRX6
         QhknXVyz2Q7vj2ZaE4qzvMCuZEujGunbiLWxD/qe5Rtkl18+yPgyMhd0htdz/c87drOb
         /Yy+y5VqYHaVRxa79zH3ugUCHDqjfUqFO4l1Y+9NS8m9KjV+V18yhg8PDiuAihJqZ30X
         qLuUi0nmuflyF3owGI2Z4/+CiHUJ13sV+OA/OMlki1ecikJ4ItxxwkOvuaTi0GIPKEpv
         SMz6ZVTeQ68vXfKEgOsa+SA9Z5DChMAVnuAd6P0zvMyABtF0Hv54gCgOnG1F2iuOZl+m
         qDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046705; x=1709651505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgUZYYEewWOr0eZgCM/D+yRszpCU2Zn6RVKpSWiScZI=;
        b=XQKIauqn9BOol4IUuy9PTtROBuJzPsOmmy8w9jo+GcK6sltBSBgz+jGVh1MXLBXt/N
         lbhDiBYTIezGG7yLxbIDWuqo9pKKWxiO2PMt4cgtAKtXIP2HGmQ1wI/+nCja0c22PUHT
         RqYKJKy983GASpXQ3kEu9mgocAka1LToSLv65lV/Al+9OfzCwnZgCqc+BCAkBHQrHV7G
         mjezjJ+2a2mbOWP5/Uxw20q125Co8F36n+C+TsrzeCvigRbkC0MUxXBoPQAhROkUUBcr
         oBLEyp27wCEJZuvvhdseYCeSHNcBBHgZlVYVI7RpNaW8E6I2zwkzkjlY6+BzOs844XAR
         iC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVffLIVKjI9Mk77Nc8IV7iGKXyk8oVJLSjTa8dUGYZWygREkgJXvBBUtzws+GC6+U40+IEABIv9te4YncEembAKeQq2aOE2Oso7FYccxmRz22QUE8h+mYoicDKcZuHeSUmD
X-Gm-Message-State: AOJu0YzZrNfLxYXEhHjR+5G/PuENFXuZm9y+JJEjy8XUzNe4tgTIHJhN
	e7HPMYB6MunUx3c2xl0l+F5wNy+k5dTPANs7kJtIcGOdl2VYEkwN
X-Google-Smtp-Source: AGHT+IGLirqfah9d4iGWTMCqewDLhnmBg8hi2Iy2nBqKNPhbA3EjAa6SiYGrHFnWv/yqvMG7UwDjxA==
X-Received: by 2002:a5d:58cd:0:b0:33d:b872:1c1b with SMTP id o13-20020a5d58cd000000b0033db8721c1bmr7385349wrf.23.1709046704756;
        Tue, 27 Feb 2024 07:11:44 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id bq7-20020a5d5a07000000b0033cddadde6esm11917259wrb.80.2024.02.27.07.11.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2024 07:11:44 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next 1/1] arm64/cfi,bpf: Support kCFI + BPF on arm64
Date: Tue, 27 Feb 2024 15:11:15 +0000
Message-Id: <20240227151115.4623-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240227151115.4623-1-puranjay12@gmail.com>
References: <20240227151115.4623-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
calling BPF programs from this interface doesn't cause CFI warnings.

When BPF programs are called directly from C: from BPF helpers or
struct_ops, CFI warnings are generated.

Implement proper CFI prologues for the BPF programs and callbacks and
drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
prologue when a struct_ops trampoline is being prepared.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/include/asm/cfi.h    | 23 ++++++++++++++
 arch/arm64/kernel/alternative.c | 54 +++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c   | 26 ++++++++++++----
 3 files changed, 97 insertions(+), 6 deletions(-)
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
index 8ff6610af496..350057a28abe 100644
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
+"	.long	__kcfi_typeid___bpf_prog_runX			\n"
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
index cfd5434de483..fb02862e1a3a 100644
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
@@ -157,6 +158,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
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
@@ -285,7 +292,7 @@ static bool is_lsi_offset(int offset, int scale)
 /* Tail call offset to jump into */
 #define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
 
-static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
+static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf, bool is_subprog)
 {
 	const struct bpf_prog *prog = ctx->prog;
 	const bool is_main_prog = !bpf_is_subprog(prog);
@@ -296,7 +303,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 tcc = bpf2a64[TCALL_CNT];
 	const u8 fpb = bpf2a64[FP_BOTTOM];
-	const int idx0 = ctx->idx;
 	int cur_offset;
 
 	/*
@@ -322,6 +328,8 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	 *
 	 */
 
+	emit_kcfi(is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash, ctx);
+	const int idx0 = ctx->idx;
 	/* bpf function may be invoked by 3 instruction types:
 	 * 1. bl, attached via freplace to bpf prog via short jump
 	 * 2. br, attached via freplace to bpf prog via long jump
@@ -1575,7 +1583,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * BPF line info needs ctx->offset[i] to be the offset of
 	 * instruction[i] in jited image, so build prologue first.
 	 */
-	if (build_prologue(&ctx, was_classic)) {
+	if (build_prologue(&ctx, was_classic, bpf_is_subprog(prog))) {
 		prog = orig_prog;
 		goto out_off;
 	}
@@ -1614,7 +1622,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.idx = 0;
 	ctx.exentry_idx = 0;
 
-	build_prologue(&ctx, was_classic);
+	build_prologue(&ctx, was_classic, bpf_is_subprog(prog));
 
 	if (build_body(&ctx, extra_pass)) {
 		bpf_jit_binary_free(header);
@@ -1654,9 +1662,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		jit_data->image = image_ptr;
 		jit_data->header = header;
 	}
-	prog->bpf_func = (void *)ctx.image;
+	prog->bpf_func = (void *)ctx.image + cfi_get_offset();
 	prog->jited = 1;
-	prog->jited_len = prog_size;
+	prog->jited_len = prog_size - cfi_get_offset();
 
 	if (!prog->is_func || extra_pass) {
 		int i;
@@ -1905,6 +1913,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
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
2.40.1


