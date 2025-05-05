Return-Path: <bpf+bounces-57408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C180AAA67C
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 02:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500A416B5E8
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 00:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194F33280BD;
	Mon,  5 May 2025 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BOEDVx7a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DFE3278E8
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484487; cv=none; b=cCZXcNHlVqbOtVhDBYV3n5+FBjEVpdStvxlXVTcZ8CVF3dP3+wukLHlFrNvt0y3kp1IALWfWyAYAr+t1dnqk6apMQl1srklfkA5LhgrUlQs7LNGBKf6lV3+abqR2yPcFwJLBCu9nu0HBItOotXqZKmCgWEHOL+xxcUhO34+NQJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484487; c=relaxed/simple;
	bh=XrFF3q8OIdWbIbgL5KEcKR7w3M0aeaM2dGRoWCTQ0Bo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EQyveE4P1IKWz1zkQgP9HfK16947omzmlPdF7HneKtEMxlYEGfutlvgMMiHkU5wvHblxBzLK+vVT5hSVevt7IYTeNHEmBZqTEvuhfMojjc0GF/40kv2GzF5TiEBXv84xYQj8RhpfgVdhJHG2q7aglrc9gSpFAUzUVXrZtn4fQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BOEDVx7a; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73dcce02a5cso2972502b3a.0
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 15:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746484485; x=1747089285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UG6GYoDYUvSTCJXNbhcTCy+rTclDma5rPa6bv6GcMw=;
        b=BOEDVx7afTopZwemKnnNK77BZmTnv4adxC7u0Bwj3DRFVvziBcuuywB/DTryIUWQMe
         5nS6r9wcCL1aD61rrj5N8nkbDje/zpR2NOYoq0fYbErxuRgxZ4Ck6Dh998PaqyC8DHUh
         1Z2akJ0yj1cGXwdm4LHjzss2dQ15xKis50tiTmfmszSbr05QsEQ+CFaO+j3IR0Wpzvil
         5HBaKcAD9RVgc0+EDkWs7Bf65ezknRiTbhEJAuVXFHLI6mHalCwj93w7rdGtdZfXyjS6
         b3JdeYSnceZxul9Xy0hKAvTR3zBDoM4YJhztKaq3xS3INsYxSKzxdtw5WaaSCsNJb1Yr
         JdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746484485; x=1747089285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UG6GYoDYUvSTCJXNbhcTCy+rTclDma5rPa6bv6GcMw=;
        b=k2qsz3TLCJqI0dOuGRO0ZCabqfbe7iRE3Hd7C13hlZUdSn+Cbngv/moqJW7mLSx1tf
         nX37mz0aENQCTdn6sohbmXmO3r7X9J5G6Z35je5iujWzFIy8826LqcrNWdTg+cpZ5Y6L
         kpubm6xf8FO1byVpinUmikDGnzpUzYVmd/flb92ERQgH5vERGyHYxBWfUEWjFrZhswnx
         ua3wacaYdfG1CS/TMDEXR2b38Jdd2l+aJMIFT5HqXehLudoYlhKwGgFAOuEb9LL8kAfO
         paQcA4Sw0NHJpyXDiNEFDsTPtiaDdoV0TbHUBENJxGqzKEDJvubWM4cyATekrLyuGh4n
         9UcQ==
X-Gm-Message-State: AOJu0Yx2sDsM65EyQtjIK1deA2vuy0jVDHx/TddneO8WK/lRh6sQWxrW
	zPyM65dETxBmg4PHYuVE6LRRvv5W2Ld5W8aUwREP3hQMLTKZaSIB3RxixqKiW4r6RPQ+ICkVSnT
	SVAssAGjQj5PhY92oo5K3lsOsYGECtsFALGw+1iEeighpJ9JxD7vQ0EZgM1Gn4uJabrKVgTwcjk
	1KiCnPYbA6eamt1CmGfQMdEPUldykfayvQ+CWXg0pbot7OF8pFWJagLcWcdX9L
X-Google-Smtp-Source: AGHT+IG9/bqquqZo0+5ekAmT9vTMi2AWIW4fPAq3lK8wl6/RiTTEb6BBW0o8BycH8+xREXoGfTl4Z8+v6d38vWKGCxA=
X-Received: from pgar26.prod.google.com ([2002:a05:6a02:2e9a:b0:af0:e359:c50a])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:43a3:b0:1f5:6c7b:8920 with SMTP id adf61e73a8af0-2118076ae4dmr1028201637.9.1746484484997;
 Mon, 05 May 2025 15:34:44 -0700 (PDT)
Date: Mon,  5 May 2025 22:34:40 +0000
In-Reply-To: <20250505223437.3722164-4-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250505223437.3722164-4-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5846; i=samitolvanen@google.com;
 h=from:subject; bh=7DbjnHH5VAkImXf9y6kWO2Cpd7OKLAKDbR8A6OUcpSo=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDBmSNv+n70wW3Td999qDnluU1h/qaZRrv6XgbvBB9fe9j
 n2HrxUxdJSyMIhxMMiKKbK0fF29dfd3p9RXn4skYOawMoEMYeDiFICJ3PVg+Kcseq1CSHzW1a6c
 rZ4n9e4dPmdvfbpob7XIB/7NkjLOEkcZGdbeDuLtcTvWJBP+IZHFKOjdccWdfaFpL+7dCbLplng aygEA
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505223437.3722164-6-samitolvanen@google.com>
Subject: [PATCH bpf-next v9 2/2] arm64/cfi,bpf: Support kCFI + BPF on arm64
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Maxwell Bland <mbland@motorola.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Dao Huang <huangdao1@oppo.com>
Content-Type: text/plain; charset="UTF-8"

From: Puranjay Mohan <puranjay12@gmail.com>

Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
calling BPF programs from this interface doesn't cause CFI warnings.

When BPF programs are called directly from C: from BPF helpers or
struct_ops, CFI warnings are generated.

Implement proper CFI prologues for the BPF programs and callbacks and
drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
prologue when a struct_ops trampoline is being prepared.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Co-developed-by: Maxwell Bland <mbland@motorola.com>
Signed-off-by: Maxwell Bland <mbland@motorola.com>
Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Dao Huang <huangdao1@oppo.com>
---
 arch/arm64/include/asm/cfi.h    | 23 +++++++++++++++++++++++
 arch/arm64/kernel/alternative.c | 25 +++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c   | 22 +++++++++++++++++++---
 3 files changed, 67 insertions(+), 3 deletions(-)
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
index 8ff6610af496..71c153488dad 100644
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
@@ -298,3 +300,26 @@ noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
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
+DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
+
+/* Must match bpf_callback_t */
+extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
+DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
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
+#endif /* CONFIG_CFI_CLANG */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 70d7c89d3ac9..3b3691e88dd5 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
+#include <linux/cfi.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
 #include <linux/printk.h>
@@ -164,6 +165,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
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
@@ -474,7 +481,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	const bool is_main_prog = !bpf_is_subprog(prog);
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
-	const int idx0 = ctx->idx;
 	int cur_offset;
 
 	/*
@@ -500,6 +506,9 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	 *
 	 */
 
+	emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
+	const int idx0 = ctx->idx;
+
 	/* bpf function may be invoked by 3 instruction types:
 	 * 1. bl, attached via freplace to bpf prog via short jump
 	 * 2. br, attached via freplace to bpf prog via long jump
@@ -2009,9 +2018,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		jit_data->ro_header = ro_header;
 	}
 
-	prog->bpf_func = (void *)ctx.ro_image;
+	prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
 	prog->jited = 1;
-	prog->jited_len = prog_size;
+	prog->jited_len = prog_size - cfi_get_offset();
 
 	if (!prog->is_func || extra_pass) {
 		int i;
@@ -2271,6 +2280,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
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
@@ -2790,6 +2805,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 					   sizeof(jit_data->header->size));
 			kfree(jit_data);
 		}
+		prog->bpf_func -= cfi_get_offset();
 		hdr = bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
-- 
2.49.0.967.g6a0df3ecc3-goog


