Return-Path: <bpf+bounces-64853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C83CB17A60
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 02:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 874CF7AC98E
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 00:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0376C1DFFC;
	Fri,  1 Aug 2025 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sMEVM6f7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0328EC148
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007016; cv=none; b=nK/HtVJLOd0SlPyRJ0s+HW/cZ+KWpta4OkPwXsVhPgUV+WUdzQ8jQ3X7iND7E0Ro1fGN5Htmu+Xoe0Rt50B4XXgIZXI+2Hda4e57koOI2ONmVD229fQAenNDmLy0ja8hghp5bJtounlDarp1S165BVht0XObTtioWM2xfe8Jkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007016; c=relaxed/simple;
	bh=PuRe2nGj0EpdYZQrojmZRs4VS2y7HRUovorqQS5Ex3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DW/99zHxcSxxAEZX934z9kHeoWsU0vuQV5G+GjPWlTgugHYHS3IiW2XzFohik8HiBKh33yY8CwJAGYRFGSzix6GZqs9YgQkPFLd89aTNS04t4bBhGTxOAoKJLQt5oYvrwtXHBE47MI+xqdXySgWxFMG+BefSJM58oufsnZBQNLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sMEVM6f7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31366819969so1775969a91.0
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 17:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754007014; x=1754611814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5uDl85wDGhTjSIRJ3MDpBVcbv+/o9QKj57RG6DGCPk=;
        b=sMEVM6f7jcWDlIiMk1LjPmnnlnQpwhkmdbsrc9F61847XP669mRqvQs8RZv0EMOA+a
         SyBl24gOTZwScae4FbmtA3b4MnZMrHJIU8juX/Q6BgGiTxhPemsVdKuPo4DQ8xY9HB8I
         shzGsssUflLOazdINXuVYnK1z5CMN2bB6JiYiutDFWGGBPMIHeygMHkiUkDIPkLc6c1w
         +t2lIhgmg7qvMBgvQb7Ly28RPC0F2yLS62n/zpDdrhDK6farJvTB2dyo9wCbeti7dhJd
         JMAYD8jkD0tGoGD3C/bytP7S5vw/wATxU0SA1Xtz6Om7Oy4oIE1XFgaSlgwKKS7D07M5
         yTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754007014; x=1754611814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5uDl85wDGhTjSIRJ3MDpBVcbv+/o9QKj57RG6DGCPk=;
        b=Mlj584M45n2v4pw3D83kYoVowxgq94V2o/kAm6wDj+ZAKWx+PQqo3uby8gVLrA9ML8
         Fhm4rAtv4PpZTPgcunCPoZsPehyS06meZLd7F5pjUR50pLDvrkif5QaXRmDp3FzvCObd
         kq6B/gQtV5IvtqqmfG2u8SSw0H3O7Jd3AfipdLa+tlJJoy5CtJjt9XcwJBFECH7T+/la
         0JVWfnX0iKq978WUVCC4U6pqGYu17dc5S9q3ouTj2ufLvQkWNg5QLq8DWOCeYBQ97e6N
         2YxYIjEpIwckJM17x5kyCMxvkAB/ZHxPArpI0iznF07BRY4YQ+D6mC0gblH28YbUFC8p
         chMg==
X-Gm-Message-State: AOJu0YzTOBTIkcDf9GYevql3LTOy9BBnbI9+lWP0vvfnAAkrT0HVKEn7
	Vvuswe/ArPjiisHwO03sJz1j/7T551CnflZ30omfvF/DcXw8IAl0q3OR+1VuQg1iNv1dweRKG6d
	VoH4ny2itQkNYIOAWS/dStQPQzF9zYxNy5Xan4PHapz6zT97bgyWlOgKr3Xwv5YY+6BRC7VaDmY
	lng28Rr8y8J7kcJDwUhSw+JNSjiahyqtbsEgSpxkVjq7XyhIdKlxs3mHkb9Ec1iSvf
X-Google-Smtp-Source: AGHT+IGe6iTItosrIYdSiu53+Ci7qA2QFXWZJ90ywhAykW0k2WhvUSTmqFJV6z+v+U/Hxqi/jtBom1ufe6Z6w654MMc=
X-Received: from pjx3.prod.google.com ([2002:a17:90b:5683:b0:311:6040:2c7a])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:35d1:b0:312:e6f1:c05d with SMTP id 98e67ed59e1d1-31f5dd891dcmr12128094a91.2.1754007014453;
 Thu, 31 Jul 2025 17:10:14 -0700 (PDT)
Date: Fri,  1 Aug 2025 00:10:08 +0000
In-Reply-To: <20250801001004.1859976-5-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250801001004.1859976-5-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=4507; i=samitolvanen@google.com;
 h=from:subject; bh=hZabVFFCxKVAeJdp4nYEgQjtD7vc/y+UZPfwjcPcYes=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBk9rPdi03WyDi2s+j2TLXrpqwQv4byFyydv75kopqocs
 DiXUWVmRykLgxgXg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZjI5U0M/+sPv9nwy1tTa8sK
 7+iJU/REprzNuvh764M2XiPGqQp7Xrsz/JVLcNrHEN/pst8r23nVypj3X66827fl0ElBj7VHOT6 /cmcHAA==
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250801001004.1859976-8-samitolvanen@google.com>
Subject: [PATCH bpf-next v14 3/3] arm64/cfi,bpf: Support kCFI + BPF on arm64
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
index 97dfd5432809..52ffe115a8c4 100644
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
@@ -114,6 +115,14 @@ static inline void emit(const u32 insn, struct jit_ctx *ctx)
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
@@ -174,6 +183,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
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
@@ -503,7 +518,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
 	const u8 priv_sp = bpf2a64[PRIVATE_SP];
 	void __percpu *priv_stack_ptr;
-	const int idx0 = ctx->idx;
 	int cur_offset;
 
 	/*
@@ -529,6 +543,9 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	 *
 	 */
 
+	emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
+	const int idx0 = ctx->idx;
+
 	/* bpf function may be invoked by 3 instruction types:
 	 * 1. bl, attached via freplace to bpf prog via short jump
 	 * 2. br, attached via freplace to bpf prog via long jump
@@ -2146,9 +2163,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		jit_data->ro_header = ro_header;
 	}
 
-	prog->bpf_func = (void *)ctx.ro_image;
+	prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
 	prog->jited = 1;
-	prog->jited_len = prog_size;
+	prog->jited_len = prog_size - cfi_get_offset();
 
 	if (!prog->is_func || extra_pass) {
 		int i;
@@ -2527,6 +2544,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
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
@@ -3045,6 +3068,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 					   sizeof(jit_data->header->size));
 			kfree(jit_data);
 		}
+		prog->bpf_func -= cfi_get_offset();
 		hdr = bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
 		priv_stack_ptr = prog->aux->priv_stack_ptr;
-- 
2.50.1.565.gc32cd1483b-goog


