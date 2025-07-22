Return-Path: <bpf+bounces-64107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B94B0E51E
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D35547763
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BCF286D63;
	Tue, 22 Jul 2025 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xN5WF5sX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4008286439
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217649; cv=none; b=HimP0GEkkwo6rfazSt+stErif8d/1n4zcCMQ8cVtLhW4eYzxVMXTwXUgdstzdruLrHj7dgvkSuKlYCFJLLnWbPnkJas4ImkQsGW/ci6ir3UmyQUn0yMR4AKn1kxqUdbBOHJq5fqvIP+ZsfccQ/YMVesWkW+gzKaKgS8mrPw+JkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217649; c=relaxed/simple;
	bh=66hctsnDvcPeo4bcqizkbbYExehSgXT0Gg3yUrHXPfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OsGB20kCq+tGjeyzFyeH5ELTOnnpKYOTq2cfEWsfdtWdrQnGgc8a6mo4+yi2ilSCzcrFDSK+HiStEWWQb4kAHrMDGYHCCfu8fc2bgNiWPeqVCBJD3OzeEHlyYUHC4vDLzM9KsArZDjWQgShCSjvWRn/voDTnj8zR1s8h4jSPIC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xN5WF5sX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-740774348f6so5721779b3a.1
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 13:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753217647; x=1753822447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0xky3Tz++dR8wOWXy0XI+fGsD8WnNLUtoliWtDdioM=;
        b=xN5WF5sXn6P7AA42S3lTILffuA9N4fySl2C2qry0n7o/Qo/m11eLOOpTKgvG+mL6kL
         H9WeQhfNjcpnpcHsIx5/ewVB9GQ6HEs8oaU3kqAs/sV/h7NVnphJxuMeKJVnK0znamuA
         rCUmwq/nvO6BCsVde6aDeIFuOYxXoRGq26TaEsRBXhCLoRuVI1jYZw8N/BTO8ELBpoCn
         CI/104+7orPlKfoHJomIaQPF6PnzTnYLsFWYsY2Y9YaC5xe8qhCxFzlWx9sEJKwct+fX
         BSnlJwZCKDMPZ3y+qh78ZuhpGYX4w2kGnwLQ9ysy5vg7to0wqd8hXfPN6V7gBBaXh7kZ
         51ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753217647; x=1753822447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0xky3Tz++dR8wOWXy0XI+fGsD8WnNLUtoliWtDdioM=;
        b=Rj03hfd7XNUSx8ytP7nj35GJeI5J8djqvE5qzyU+hYHF27oaEHIlIIbWNsF8mKi4hK
         EZQm4ebuvSM8wF34Z3akw8TFY75JHpX7m436KVyYFcT1O6Bd7yFhPA5TrDU7MyKCcZRK
         eDPv7AUXhGQxCPjL/r/nSDJMGatK/7i1Psf83MWX3M9NG46vkDTeuE89Mjz9XKYMcjJn
         PHRzRN2qI8Vcgl9Q9IQXJc9NXFn907DL/j4BiBpaGPCg31F0ek/x6oA5iQaZCBIg5F/q
         t7x4Yy1+mb7pRidL+NR0rpVGdNRnd5XQWiRSKgkTsxh7lWUIc+WW7+G31i3tELU2ZbbJ
         sUcQ==
X-Gm-Message-State: AOJu0YxOyKwI8L4sTztQdYYj2OIOIQoDwIi2tV6pm/xl07NqzeNmAJc/
	LgRk76Ga8D8M6kSt68VXlCdNtb3Gev8bnSdVjjHSSLmw+eIRRN1R4um3hdloZ2UmlWFUar4C55r
	skTv+FsG/MEgcJNzDn8+sOjtvMhCLE2Zt+ERsdTtF3P7FYnv5nBB7ozoZJ9jc2J4IYskvxXy/R2
	NXEXS7mPqq6yAn7Rv795/9aKkfqCzuje3xiHi8RDwE1l2Gm+M8j95MmASCQq2XqojL
X-Google-Smtp-Source: AGHT+IH6x4q5kLczvA9H+m286fHAokh7HU92JRe53jNpVYETLy7h6qxVO9bNE0XMECCrfd5TA/Z0QoAyJ5vJf8ucB2k=
X-Received: from pfbha4.prod.google.com ([2002:a05:6a00:8504:b0:746:2897:67e3])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1fc3:b0:23d:35f2:4e69 with SMTP id adf61e73a8af0-23d490f6100mr432417637.23.1753217647145;
 Tue, 22 Jul 2025 13:54:07 -0700 (PDT)
Date: Tue, 22 Jul 2025 20:54:01 +0000
In-Reply-To: <20250722205357.3347626-5-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722205357.3347626-5-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=4527; i=samitolvanen@google.com;
 h=from:subject; bh=V2hbK6L5Ngvs6CaLj1XnAp6J1iiarTYTez80LhYwsI4=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBn1v9I5n4RtPnZpu4LCIsOEhytmr2wSm7Bl7r4PE5YcN
 AzVFpxh3VHKwiDGxSArpsjS8nX11t3fnVJffS6SgJnDygQyhIGLUwAmwhzCyHA8ZdFRGXGj7H3m
 hcF8nw+xrJNYb3aRyVxu/b1fSybV9aYw/Pe4pPziyteDP3gibqY7T+XMu1ZoJl5VMkO3/+uVq9t uHmIHAA==
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722205357.3347626-8-samitolvanen@google.com>
Subject: [PATCH bpf-next v13 3/3] arm64/cfi,bpf: Support kCFI + BPF on arm64
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
 arch/arm64/net/bpf_jit_comp.c | 30 +++++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 3 deletions(-)
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
index 89b1b8c248c6..993b5d6e1525 100644
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
@@ -106,6 +107,14 @@ static inline void emit(const u32 insn, struct jit_ctx *ctx)
 	ctx->idx++;
 }
 
+static inline void emit_u32_data(const u32 data, struct jit_ctx *ctx)
+{
+	if (ctx->image != NULL && ctx->write)
+		ctx->image[ctx->idx] = data;
+
+	ctx->idx++;
+}
+
 static inline void emit_a64_mov_i(const int is64, const int reg,
 				  const s32 val, struct jit_ctx *ctx)
 {
@@ -166,6 +175,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
 		emit(insn, ctx);
 }
 
+static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
+{
+	if (IS_ENABLED(CONFIG_CFI_CLANG))
+		emit_u32_data(hash, ctx);
+}
+
 /*
  * Kernel addresses in the vmalloc space use at most 48 bits, and the
  * remaining bits are guaranteed to be 0x1. So we can compose the address
@@ -476,7 +491,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	const bool is_main_prog = !bpf_is_subprog(prog);
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
-	const int idx0 = ctx->idx;
 	int cur_offset;
 
 	/*
@@ -502,6 +516,9 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	 *
 	 */
 
+	emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
+	const int idx0 = ctx->idx;
+
 	/* bpf function may be invoked by 3 instruction types:
 	 * 1. bl, attached via freplace to bpf prog via short jump
 	 * 2. br, attached via freplace to bpf prog via long jump
@@ -2055,9 +2072,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		jit_data->ro_header = ro_header;
 	}
 
-	prog->bpf_func = (void *)ctx.ro_image;
+	prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
 	prog->jited = 1;
-	prog->jited_len = prog_size;
+	prog->jited_len = prog_size - cfi_get_offset();
 
 	if (!prog->is_func || extra_pass) {
 		int i;
@@ -2426,6 +2443,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
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
@@ -2942,6 +2965,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 					   sizeof(jit_data->header->size));
 			kfree(jit_data);
 		}
+		prog->bpf_func -= cfi_get_offset();
 		hdr = bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
-- 
2.50.0.727.gbf7dc18ff4-goog


