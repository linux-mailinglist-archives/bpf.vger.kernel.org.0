Return-Path: <bpf+bounces-63939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A09B0CBB6
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 22:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C459170D05
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 20:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C79023F271;
	Mon, 21 Jul 2025 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xfGN3y3J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788923D2AE
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129231; cv=none; b=hEXy8Z/rFfFMMg5uuDAVcQzbE4VxMKZgtC/9kwJaNrV5SujBnxOcJj/9lL0YbLDerpw/8IjjDQs2mPUw+hndSQfQnJzD9FaMf2BB796pK/e9Wbdk80+fQO6utWuna+lwy73E0Q5QvZtQrg+X5NYyUTLDxqc68p+Zd+Dq/qUhP8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129231; c=relaxed/simple;
	bh=V+dt4wW9K74uYhg92zaTld9WHEncBcnDJyhO9sfR1hk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lX2K17lFEErHwF7stwyiWt6j5vRqDl1nqom4R2EngOXpq9YqFCgxlzCiiuKytW+ZKx7uOBjJf9v7Vb+Tv6iBLM7bd08Jf3rd/vxshiIZq7Od6rSm8jY2+no8W6/q6Gdv3AHqOltRX50RM1EFgTy5vqiR3Wh6JkZuBrKmsO598/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xfGN3y3J; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74b4d2f67d5so4061002b3a.3
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753129230; x=1753734030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHownloYScgx/peEPOAu+NanD7LJponwsGoBJ5e+uKQ=;
        b=xfGN3y3JcrzMKJDIrqqSeo5flHAaPOPlYaLtLyakc2tu168y+rMcEIldMwLfxbbwQC
         KE9JMjiJOhoqZue+ZIE+KjwExlB2q7GtarIEuwG6y5rlhKVge7gnDXKal1Uprd/j5dQn
         uz3pU7S1VQsYDq3LZUi6BwDun9/OkKG4FTgn2K4eMyZn62P2FYjafQ2ojuPN5ueaUUYZ
         +nV1xBcyXx7FtNlNZpSE6F3T+oVvSGzuXzPuTQs5XIt8x/ck04VQ+JHoC+idniW60MEz
         vjby93m3Xmj6CHB67hpOq9KZ1VmeM2T8NJLgSO+ru/E/HOaLQrC422+2BQ9qAlr//EVM
         xDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129230; x=1753734030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHownloYScgx/peEPOAu+NanD7LJponwsGoBJ5e+uKQ=;
        b=SqQ+QDI7mA/zPVp5BqIc57ggzg0ob7hUXSaSIkBNaKmTO4q/vhfTkl9llaPDLmxcS3
         kAQH4VnAZ97xRz8rLH3P0s5khcWCt5DNDq7+S4k+feYp+Dzdw74tK9KmjrSazEQWkfy8
         rlt/pI39CylGrLzHIUHLjpOwfI9rh1y1PTxeEzvriA5GQVYm+BlPJNsbvU0eug3NgYSX
         ilfCCW+6TG6qwPC0ayL2Ggt9mGkauyZWsSlV5fMJsNpSr6z7U5j6DPQicpUb3oBu3ivW
         1naVDb3fO2txS3K9OmAqPeRsg4OIPPkNSYWoYBmtEH0Hku4wbLQITP4TmSSM8PT+5KK+
         aSoQ==
X-Gm-Message-State: AOJu0Yx+mfU+G4K8JAIMs+D5cqpAcSu4ESX1bXxRa8mYswjIlgrZgJ6Y
	DVri/wti/sA8c0KRBMwrRBglv+A0tfPeBvFuAXXqqxMS/KYyPGaKrxT3kg4QqkjKyAe5eevkVSS
	Sbmmc3bE0LxbhbGBLELS0VUZ+8tPufTmt+sZUs8uKzqSvaPsRVPcDFmiZMW6OcHyeOwOMLnosn3
	sol/GSImZiH4GNye8BtW9ToAvqOT3R9L7IHztwu+iCjpktYc5ZwEMGnbcDNzxOzjo+
X-Google-Smtp-Source: AGHT+IH7KB4Embbv+x/j7/TiNXBRPpel5ppAcMFteDc0+/hNDLuiR64hBw5sgTN0lkM+CXbz8tU6Wnv96FwrgIwShQg=
X-Received: from pfbca26.prod.google.com ([2002:a05:6a00:419a:b0:746:2524:8aab])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e91:b0:758:b81:603a with SMTP id d2e1a72fcca58-759ab63965bmr19047414b3a.2.1753129229517;
 Mon, 21 Jul 2025 13:20:29 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:20:19 +0000
In-Reply-To: <20250721202015.3530876-5-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721202015.3530876-5-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=4115; i=samitolvanen@google.com;
 h=from:subject; bh=Btyu244psEehuoYDLzh4LQVWud/Fy+nWITFJv1APkz4=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBl1CxlXHHOZf/X60+irp+9+N/yvsFUr1TSxkOX50n0W9
 7iOdF8v6ShlYRDjYpAVU2Rp+bp66+7vTqmvPhdJwMxhZQIZwsDFKQATqV7OyPDk61XxZz43n97W
 XXkldZeiValAjU3Lg8/xfy1qL8w9+WYfI8Pd4OSJn26/Y/iUunOV4+en2xlUi8St5SW8Z8e1Kmp P3sUNAA==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721202015.3530876-8-samitolvanen@google.com>
Subject: [PATCH bpf-next v12 3/3] arm64/cfi,bpf: Support kCFI + BPF on arm64
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
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/cfi.h  |  7 +++++++
 arch/arm64/net/bpf_jit_comp.c | 22 +++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h

diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
new file mode 100644
index 000000000000..ab90f0351b7a
--- /dev/null
+++ b/arch/arm64/include/asm/cfi.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_CFI_H
+#define _ASM_ARM64_CFI_H
+
+#define __bpfcall
+
+#endif /* _ASM_ARM64_CFI_H */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 89b1b8c248c6..f4a98c1a1583 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -10,6 +10,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
+#include <linux/cfi.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
 #include <linux/printk.h>
@@ -166,6 +167,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
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
@@ -476,7 +483,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	const bool is_main_prog = !bpf_is_subprog(prog);
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
-	const int idx0 = ctx->idx;
 	int cur_offset;
 
 	/*
@@ -502,6 +508,9 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	 *
 	 */
 
+	emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
+	const int idx0 = ctx->idx;
+
 	/* bpf function may be invoked by 3 instruction types:
 	 * 1. bl, attached via freplace to bpf prog via short jump
 	 * 2. br, attached via freplace to bpf prog via long jump
@@ -2055,9 +2064,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		jit_data->ro_header = ro_header;
 	}
 
-	prog->bpf_func = (void *)ctx.ro_image;
+	prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
 	prog->jited = 1;
-	prog->jited_len = prog_size;
+	prog->jited_len = prog_size - cfi_get_offset();
 
 	if (!prog->is_func || extra_pass) {
 		int i;
@@ -2426,6 +2435,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
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
@@ -2942,6 +2957,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 					   sizeof(jit_data->header->size));
 			kfree(jit_data);
 		}
+		prog->bpf_func -= cfi_get_offset();
 		hdr = bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
-- 
2.50.0.727.gbf7dc18ff4-goog


