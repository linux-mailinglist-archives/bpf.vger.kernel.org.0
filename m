Return-Path: <bpf+bounces-53771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D18A5A733
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 23:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B22F170FEF
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 22:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888EB1F8739;
	Mon, 10 Mar 2025 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pUpA27RY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA81F0980
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645797; cv=none; b=Sn7ApnwA/tSQUL8pnK8QtS1tmkbePrTYjDQ0FeJ+vdWpvBkOSNTJCwC++j6blEhoraqnwdzjGjmxjT0agWIRvRprxrpQJEBfFSXcrJHqzPs6vpB68kndoXJeqDCSg9BqLc3aFWyj7n+cbglkVVt9PdhdB9wBXwpCs8k/mMSHMwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645797; c=relaxed/simple;
	bh=/Gh3NWygRpwRw52927YQX44nW7ohs8e0YPoiYdBskns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LrHLyjQkbTjZCHXB5h/4ibF1hIvW9sNFNgsrjD3bCVTH1hLr7vAbo6eJH7FqC0FDIhbUbWKgDFW3L83EbN9SL7TVPLdX0xSGfL2tZ4J6MZh13ItqlUK5YbTz4wRU0pscfdEvjlc2z/Nyu8LbaC+rQRjxdb+/Vve//NELFBHEto0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pUpA27RY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22412127fd7so57942385ad.0
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741645795; x=1742250595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHU8rTWgBupCD0kyXYGUHHuE6QBh+Vnbh8dhf8rC5uU=;
        b=pUpA27RYp3hY0qzNf2C6TNdWxyI27MQ32tCsShOHTE3mBPOSde+DiUPYzw/3VLR0Eh
         yqzmZr9dsRXEkSu3ay4BiRkdr1fv6qXTaUkDjJNC3G0qCuk026I8YMudGTnJYB3sPBsS
         DyVWGA/1vc01XqweN2Yp83KuMOQsS8Ld8Xnz2hdryza0UArShQAZ4wSK/0OFhPKRgJFr
         bsP6NMf6vQ6vEPn/YcSxhdfh5vT3KahAgFOJRm0YFPcol07ZFFIuSXr3sM6Fj/M6jrOH
         Ij7Eh9zzNjVcvHUF2EYmxMaoSV+XJGBOhIGTOf88kHAFhLrt+TYYWh23fWp02CziT+Fm
         XBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741645795; x=1742250595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHU8rTWgBupCD0kyXYGUHHuE6QBh+Vnbh8dhf8rC5uU=;
        b=U6WwREGIw15HWGnADVOUShUENbKfpOaZYoY7epwZb5LeP6ptqif9gSbxOgsGNxMVgw
         9CR8UfBkX4x/76czaSFb3oTS45hAzuSbbvLM5NvUWfo/yOsZGL7IibrKfC+tGcCvpvn3
         9wJg1ircunHTzqkcFXa4yltLrOKwoGfly3rGRPjDNj/55sSNo08aEC8RsriOs/sUq96w
         PDGkN7rh3V2EbnutNT1BiT8QJBa8CV9U1gvYaRPpnNrBnkav/mwPlXvoWcW2AXu5a4MV
         /o9CM5XTlKgBzxN57ZW4RVeQ3/EZuruc045pl0L8NKzdGKd8PvfBhkQtgdUoojUGhe7b
         Zb4g==
X-Gm-Message-State: AOJu0YyoKmvM6+uRs2KGzMg3A914xF5jih9jKy8cLslcBzs2P15ZQ3YK
	KwWvV678mG9bl21iXScSrXwXdMD6NoA0oZ7wBAIgz5A7AB+BOj9PbRiDgtEmGoQoUsel2646jia
	bBuDUeZsZi5v8ZOnMUjSRMbVUrVO/0BB700GLEctUHU6h8yb3qlm012bha5/fSKtMrrr0ffl6bV
	j4XPd9TsFI2voSxwjuwG+lcns9Nti3ovxjUVMPa+9HUDoPvVov8DIkZ/JebxA1
X-Google-Smtp-Source: AGHT+IHFhuWhKuHNz9Fgp9FirrVIYERb4+eQ/sNIhVDmpSExLjut7bH5NkxneyzB/GAZESXqV0qgtpdoJPMyOC/28Jo=
X-Received: from pfdr25.prod.google.com ([2002:aa7:8b99:0:b0:736:5b75:dde8])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5d2:b0:224:e33:8896 with SMTP id d9443c01a7336-22428886514mr236067925ad.11.1741645794779;
 Mon, 10 Mar 2025 15:29:54 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:29:45 +0000
In-Reply-To: <20250310222942.1988975-4-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250310222942.1988975-4-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5846; i=samitolvanen@google.com;
 h=from:subject; bh=nnEDzY0cdXNg5DInXr2mCSLGjD0bJaDeFd9RiRfzo4M=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOnn02+zmk8qvM15+eOR4itv2iUe3WHXdDmQpuh0RL2HJ
 XRC9zWzjlIWBjEOBlkxRZaWr6u37v7ulPrqc5EEzBxWJpAhDFycAjCRlrOMDKcmnAxb6p/PI9cV
 fKYpXWXrHP6PV8RC60/NC0ueoXVa4ybDP/uXoo8XlLM7M3z/3v7y6PUg117paX8rA40TnV1qmSq mMwEA
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250310222942.1988975-6-samitolvanen@google.com>
Subject: [PATCH bpf-next v8 2/2] arm64/cfi,bpf: Support kCFI + BPF on arm64
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Puranjay Mohan <puranjay12@gmail.com>, Maxwell Bland <mbland@motorola.com>, 
	Sami Tolvanen <samitolvanen@google.com>
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
Co-Developed-by: Maxwell Bland <mbland@motorola.com>
Signed-off-by: Maxwell Bland <mbland@motorola.com>
Co-Developed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
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
index 70d7c89d3ac9..8870c205f934 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -17,6 +17,7 @@
 #include <asm/asm-extable.h>
 #include <asm/byteorder.h>
 #include <asm/cacheflush.h>
+#include <asm/cfi.h>
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
 #include <asm/text-patching.h>
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
2.49.0.rc0.332.g42c0ae87b1-goog


