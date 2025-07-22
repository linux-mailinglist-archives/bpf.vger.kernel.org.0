Return-Path: <bpf+bounces-64105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E47B0E51C
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B931893545
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95405286409;
	Tue, 22 Jul 2025 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1m50MBX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D092285040
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217646; cv=none; b=GAfN6AqBc5SV2z3trXgVD+9efiAGevy6lNcw6pKISIu58e9fqwJFXMANZOzEzN9mJA0vDvAh8OiJ3DdtC8Grwf6D+uMBL9v44x7hKGkf8yxv/lNeZVYDiIgYO01yOlgl0r6dJf1YGIMUBYArVEVAAZEqwsb0cYRIPMQXYWsTsdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217646; c=relaxed/simple;
	bh=zd5DznBVI4sVvso/l/68ScJA/RSIQeiYIJRJ5CEjGgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KLLy/QdYDw/j6+ekJfUrUdbOvcjCF0agDSR+t/eE1sfSOzzB97FkrjBDI1wE4x4ylykHGv9C90xWcVu4eezjl4YKxhJkOR89xqahyYbiPkoiX1jQTADnVrdi4xt0oEFlh64Unrrft/QUT92iRt/ieKdRkIcC9Ewxod34pcD6/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t1m50MBX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74913385dd8so8428932b3a.0
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753217644; x=1753822444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATtT7J3eGVlX0DAsIWIni7wioYwQuHnqhrVZz3llpO4=;
        b=t1m50MBXZZaal5IVGJPr1t0vSbd5dNShxxt06B3FoyuXs6zdkCdof3r9sAl3WN/Oxx
         yZkHUfCAWmDg+Uz2QO93PDRT47gB/DAiXqZQoWGbhiIKqdTu/W2IyzBet+UlpsJL8h2t
         3r6qtnMaCbpdgluyfy27Gr6Upm4Q979JeJO+MkhtFwk2vLk6yYRwuewZ0MrKWAEGZAoW
         C9iPPDRLQGbpoEOMaRhrJuRYIpUpBNwd1CEZo1VboLkZcrpZkDMhrZTtGXlcKiTb2SqO
         1w7VpahmcbGkQYR2SXc4SzWPMah6uNCesyJck9jO7UbI4UEAgEKuZW7q4IKO3dyfmJIA
         zEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753217644; x=1753822444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATtT7J3eGVlX0DAsIWIni7wioYwQuHnqhrVZz3llpO4=;
        b=aFHgnNtc8gSSHwOq/sW5GIy+MOvx/THzqn7ZjEeMjcLH7mG81gCZcg1W4yCt7CgEot
         KYPNuCL6ZEWXqzdISrCqMXeYWpGoxA8mLrliGC7OH5AYAah5FfUZxhlG5dNbFz+Q5PtW
         LERO82v7cyWvILot7+MjvtqBFdSHv5dbUld14HtPIApQ+jWhoeNfcBYleMONYBglnjU8
         fVsSOzwrMA1p9foN8rWdjusFoiGPpjrRXR/zKprYp6Ou+Nhb3IAHM4KRWfCu1A8MU4cR
         d0xXNPoYyIXbzXaevYYpSSyZtxEPB+QFgkX+CJwPIWIfadEdDr5NJ0gRu8uyPAeVtqUa
         imJA==
X-Gm-Message-State: AOJu0Yzcz1E03Fv2ZsfugKhcN8v8LbGqDtA+WQq2ix1faOw3mZNuNKfU
	Jx+ciqG6it5B2HRc8wm77OpaDF/KbBe4gdULG3OS5y+WbePhwJ2IhnuGA64iIW9w5Oo5hHCiAMh
	hhuxSuUpn5fFCX0Lb1LidO8LaUwO2Y0yJ7esjJq5burkrOVduaenW/eLa8wn7631sYYuSXkehlX
	Fu2g9dK0pfD+SMYu19mCtU6sV6kUpq6a7mAYaz4mpTxRyo33j+6fJ7Z6bytY7ryYSn
X-Google-Smtp-Source: AGHT+IGcJ1yJH0fRzYxlDDUqZBhJPeXzC6DrCDd4ckApy9RMyQ4dsnkHLjAoOoLgwzZvQEvUMtYym8FpF7QRiypohqI=
X-Received: from pfbbe3.prod.google.com ([2002:a05:6a00:1f03:b0:748:e071:298a])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:b95:b0:220:94b1:f1b8 with SMTP id adf61e73a8af0-23d48e6859amr495572637.0.1753217643988;
 Tue, 22 Jul 2025 13:54:03 -0700 (PDT)
Date: Tue, 22 Jul 2025 20:53:59 +0000
In-Reply-To: <20250722205357.3347626-5-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722205357.3347626-5-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5301; i=samitolvanen@google.com;
 h=from:subject; bh=Dmv7MBdL2t4YlIN+ZApIs9QGn/40RNGjIGDoX876EIY=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBn1v9LqNh54s6quo15jb5tZrkxbpfL6Jv22VLWgfzd6F
 GTfOOzoKGVhEONikBVTZGn5unrr7u9Oqa8+F0nAzGFlAhnCwMUpABOZcoLhn80avWDtm/9ExOK3
 JJcwrNkVbJq/Snrm8S09a9+8MG0wZWNk+CabYXP+em13pVXuzycBPey/Km8+XfDejO2F1Ak+b8+ F3AA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722205357.3347626-6-samitolvanen@google.com>
Subject: [PATCH bpf-next v13 1/3] cfi: add C CFI type macro
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Maxwell Bland <mbland@motorola.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Dao Huang <huangdao1@oppo.com>
Content-Type: text/plain; charset="UTF-8"

From: Mark Rutland <mark.rutland@arm.com>

Currently x86 and riscv open-code 4 instances of the same logic to
define a u32 variable with the KCFI typeid of a given function.

Replace the duplicate logic with a common macro.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Co-developed-by: Maxwell Bland <mbland@motorola.com>
Signed-off-by: Maxwell Bland <mbland@motorola.com>
Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Dao Huang <huangdao1@oppo.com>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/riscv/kernel/cfi.c       | 35 +++--------------------------------
 arch/x86/kernel/alternative.c | 31 +++----------------------------
 include/linux/cfi_types.h     | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+), 60 deletions(-)

diff --git a/arch/riscv/kernel/cfi.c b/arch/riscv/kernel/cfi.c
index 64bdd3e1ab8c..e7aec5f36dd5 100644
--- a/arch/riscv/kernel/cfi.c
+++ b/arch/riscv/kernel/cfi.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2023 Google LLC
  */
+#include <linux/cfi_types.h>
 #include <linux/cfi.h>
 #include <asm/insn.h>
 
@@ -82,41 +83,11 @@ struct bpf_insn;
 /* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
 extern unsigned int __bpf_prog_runX(const void *ctx,
 				    const struct bpf_insn *insn);
-
-/*
- * Force a reference to the external symbol so the compiler generates
- * __kcfi_typid.
- */
-__ADDRESSABLE(__bpf_prog_runX);
-
-/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_hash,@object				\n"
-"	.globl	cfi_bpf_hash					\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_hash:							\n"
-"	.word	__kcfi_typeid___bpf_prog_runX			\n"
-"	.size	cfi_bpf_hash, 4					\n"
-"	.popsection						\n"
-);
+DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
 
 /* Must match bpf_callback_t */
 extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
-
-__ADDRESSABLE(__bpf_callback_fn);
-
-/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_subprog_hash,@object			\n"
-"	.globl	cfi_bpf_subprog_hash				\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_subprog_hash:						\n"
-"	.word	__kcfi_typeid___bpf_callback_fn			\n"
-"	.size	cfi_bpf_subprog_hash, 4				\n"
-"	.popsection						\n"
-);
+DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
 
 u32 cfi_get_func_hash(void *func)
 {
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ea1d984166cd..a555665b4d9c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt) "SMP alternatives: " fmt
 
 #include <linux/mmu_context.h>
+#include <linux/cfi_types.h>
 #include <linux/perf_event.h>
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
@@ -1189,37 +1190,11 @@ struct bpf_insn;
 /* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
 extern unsigned int __bpf_prog_runX(const void *ctx,
 				    const struct bpf_insn *insn);
-
-KCFI_REFERENCE(__bpf_prog_runX);
-
-/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_hash,@object				\n"
-"	.globl	cfi_bpf_hash					\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_hash:							\n"
-"	.long	__kcfi_typeid___bpf_prog_runX			\n"
-"	.size	cfi_bpf_hash, 4					\n"
-"	.popsection						\n"
-);
+DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
 
 /* Must match bpf_callback_t */
 extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
-
-KCFI_REFERENCE(__bpf_callback_fn);
-
-/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_subprog_hash,@object			\n"
-"	.globl	cfi_bpf_subprog_hash				\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_subprog_hash:						\n"
-"	.long	__kcfi_typeid___bpf_callback_fn			\n"
-"	.size	cfi_bpf_subprog_hash, 4				\n"
-"	.popsection						\n"
-);
+DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
 
 u32 cfi_get_func_hash(void *func)
 {
diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
index 6b8713675765..685f7181780f 100644
--- a/include/linux/cfi_types.h
+++ b/include/linux/cfi_types.h
@@ -41,5 +41,28 @@
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
 
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_CFI_CLANG
+#define DEFINE_CFI_TYPE(name, func)						\
+	/*									\
+	 * Force a reference to the function so the compiler generates		\
+	 * __kcfi_typeid_<func>.						\
+	 */									\
+	__ADDRESSABLE(func);							\
+	/* u32 name __ro_after_init = __kcfi_typeid_<func> */			\
+	extern u32 name;							\
+	asm (									\
+	"	.pushsection	.data..ro_after_init,\"aw\",\%progbits	\n"	\
+	"	.type	" #name ",\%object				\n"	\
+	"	.globl	" #name "					\n"	\
+	"	.p2align	2, 0x0					\n"	\
+	#name ":							\n"	\
+	"	.4byte	__kcfi_typeid_" #func "				\n"	\
+	"	.size	" #name ", 4					\n"	\
+	"	.popsection						\n"	\
+	);
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* _LINUX_CFI_TYPES_H */
-- 
2.50.0.727.gbf7dc18ff4-goog


