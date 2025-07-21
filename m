Return-Path: <bpf+bounces-63938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7685B0CBB4
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 22:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA223AB492
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E210E23DEAD;
	Mon, 21 Jul 2025 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5UPIvgu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003023C4FE
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129230; cv=none; b=mGgy9921qXZNEALswuwznkelH+Tz4MPV9snzNxP8gS691bbH5/0K69CgjsMBlPyTdbXnfRSOUDScPSpsQSzqNoGWjQWkC4DTJxKahdZ1J0CAVGHAwTYx1QoUWgDdhy6xVFouCADhCkVjvdc2W5TMXHu5iODqYubGqkUxpFZ19ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129230; c=relaxed/simple;
	bh=8sqyVESEJUMNiJl/uCjzhPfl9OVRxgVUJjpXrAl5Bgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MtNrtNxUvz3X6B4QlsaVUpJGJlgzW4i5mlSHkXvsVVweIdqbpPVnMxtuuruKrTaHA0Hv273unBGLIyO9is6SvTiImgy25GAJbBkkYanej/Ft2wsbqgctdzHbrs6CR79MBeM5azgrUo71Q+hXuxV3XRnDVObTF7s6r6RYNAy19IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h5UPIvgu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235e3f93687so68056925ad.2
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753129228; x=1753734028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FfCLGywMG5rCOsx3g823MlhxRQ/vXUvg0nXF69NJcN8=;
        b=h5UPIvgu6tgiAZRh1o9lV5y6qcifmRdz8mT6VrRHPOJ4ViWuPFi7WdbB91m6MWFWzQ
         yvGuM6dpIrc6LF0jcqD7kOkvYFaxPdh1SKwc4GZod/bhRXXMWeSFB6u4r6/r+lTIk9M4
         psIblFYFj6qNuOawe03FhXfdJ2wP8+dJS/Cm8QOpJ4+B7+ms7OmKHtE9p6wcSD80S8cf
         U229xDSdJG5eEzywWtAzsdLoda0DfZp/ViEnYPzhWPa++FQG8ojtLSZ1W1zOrwENbewB
         GQN7w/dCAbpx9L9mcf8IxPhkwMA7Wzq8l9fb0K+wrt7plre0k62ymcTKhUDke4rJpGAb
         DDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129228; x=1753734028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfCLGywMG5rCOsx3g823MlhxRQ/vXUvg0nXF69NJcN8=;
        b=hI55+ssjJYD+ddvwMiVvSy1SLQyZLVekuTfbctjEa7MZc5vzZqeVKI2JGsCtLtQVsh
         O9qd88mP6lspvLZ+cdWDy2DoO52NMgd1xwvk2Z33vuYXX1eUyWszhoqkgQseiWR0OanZ
         6lZKFp46qiO4+TwI+urD/36twAM83XH8tH2MQso/ZjJCQl1lNFSK3/GFiCyvFWxSfBPP
         8mTSMcF1FrpNWpVfxD7eNO0TUIurhB8EpSWbGRCzqt/UGhWnJD3FmOb2FLm7IqslW8yX
         L657d8pHE2rmKFQQQdMSXlFCXPZ8BCyJwn4Ix7G84m0Jfy3L9LJcun6js/NKFPUSDpPV
         9z0A==
X-Gm-Message-State: AOJu0YwRL8golP/xb6nCZR12eQ1ot/M0yDSxVzcwQxZlHPUT3dLxAe9v
	k5LDSCpYNoJ1smRQJ0h/TTfG600pwzYRBJhprOyMaUw8eaR7oA/FUQyfUHEbP2LKxwNat2omjW0
	EQIE92NB184kZUHbf/cS5PG0NwbHtfW28li4RDajG6F/sROiGMqpRYaMRYFea1pOBhfSNOnzc46
	S4d8Gp+AcHvMQJnxXts0ZOxOhjuQpgMUx4C+Ngw4gSvZQONCLv4oSG3/0EnGLb9fWs
X-Google-Smtp-Source: AGHT+IF9TN23l4Ltc5Ne0W9DXoqr4LrShXyYJ09L4HPKeDWk0WXzGvv99/JjdmYIPAHjl12wDtMdJ0tsHdbTsMDzT4M=
X-Received: from pjbph15.prod.google.com ([2002:a17:90b:3bcf:b0:313:285a:5547])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:228a:b0:235:e942:cb9c with SMTP id d9443c01a7336-23e2566aa35mr324880815ad.5.1753129228021;
 Mon, 21 Jul 2025 13:20:28 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:20:18 +0000
In-Reply-To: <20250721202015.3530876-5-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721202015.3530876-5-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7400; i=samitolvanen@google.com;
 h=from:subject; bh=8sqyVESEJUMNiJl/uCjzhPfl9OVRxgVUJjpXrAl5Bgs=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBl1CxnubhOs9bG86TVvvUGxxO87f2/x30p4zuy/IZlJf
 ENdZCxLRykLgxgXg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZjI10BGhmtPP/KsOczfuyr6
 cPaq3d0dBsJhr6SqDrZOmfo7ucNuQQrDf5fUL8VPJE2edc5cGlTUvqzpS/Xyl8o865YopAY+Ulg bzwgA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721202015.3530876-7-samitolvanen@google.com>
Subject: [PATCH bpf-next v12 2/3] cfi: Move BPF CFI types and helpers to
 generic code
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Maxwell Bland <mbland@motorola.com>, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of duplicating the same code for each architecture, move
the CFI type hash variables for BPF function types and related
helper functions to generic CFI code, and allow architectures to
override the function definitions if needed.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/include/asm/cfi.h  | 16 ------------
 arch/riscv/kernel/cfi.c       | 24 ------------------
 arch/x86/include/asm/cfi.h    | 10 ++------
 arch/x86/kernel/alternative.c | 12 ---------
 include/linux/cfi.h           | 47 +++++++++++++++++++++++++++++------
 kernel/cfi.c                  | 15 +++++++++++
 6 files changed, 56 insertions(+), 68 deletions(-)

diff --git a/arch/riscv/include/asm/cfi.h b/arch/riscv/include/asm/cfi.h
index fb9696d7a3f2..4508aaa7a2fd 100644
--- a/arch/riscv/include/asm/cfi.h
+++ b/arch/riscv/include/asm/cfi.h
@@ -14,27 +14,11 @@ struct pt_regs;
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
 #define __bpfcall
-static inline int cfi_get_offset(void)
-{
-	return 4;
-}
-
-#define cfi_get_offset cfi_get_offset
-extern u32 cfi_bpf_hash;
-extern u32 cfi_bpf_subprog_hash;
-extern u32 cfi_get_func_hash(void *func);
 #else
 static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
 	return BUG_TRAP_TYPE_NONE;
 }
-
-#define cfi_bpf_hash 0U
-#define cfi_bpf_subprog_hash 0U
-static inline u32 cfi_get_func_hash(void *func)
-{
-	return 0;
-}
 #endif /* CONFIG_CFI_CLANG */
 
 #endif /* _ASM_RISCV_CFI_H */
diff --git a/arch/riscv/kernel/cfi.c b/arch/riscv/kernel/cfi.c
index e7aec5f36dd5..6ec9dbd7292e 100644
--- a/arch/riscv/kernel/cfi.c
+++ b/arch/riscv/kernel/cfi.c
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2023 Google LLC
  */
-#include <linux/cfi_types.h>
 #include <linux/cfi.h>
 #include <asm/insn.h>
 
@@ -76,26 +75,3 @@ enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 
 	return report_cfi_failure(regs, regs->epc, &target, type);
 }
-
-#ifdef CONFIG_CFI_CLANG
-struct bpf_insn;
-
-/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
-extern unsigned int __bpf_prog_runX(const void *ctx,
-				    const struct bpf_insn *insn);
-DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
-
-/* Must match bpf_callback_t */
-extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
-DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
-
-u32 cfi_get_func_hash(void *func)
-{
-	u32 hash;
-
-	if (get_kernel_nofault(hash, func - cfi_get_offset()))
-		return 0;
-
-	return hash;
-}
-#endif
diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 3e51ba459154..1751f1eb95ef 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -116,8 +116,6 @@ struct pt_regs;
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
 #define __bpfcall
-extern u32 cfi_bpf_hash;
-extern u32 cfi_bpf_subprog_hash;
 
 static inline int cfi_get_offset(void)
 {
@@ -135,6 +133,8 @@ static inline int cfi_get_offset(void)
 #define cfi_get_offset cfi_get_offset
 
 extern u32 cfi_get_func_hash(void *func);
+#define cfi_get_func_hash cfi_get_func_hash
+
 extern int cfi_get_func_arity(void *func);
 
 #ifdef CONFIG_FINEIBT
@@ -153,12 +153,6 @@ static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
 	return BUG_TRAP_TYPE_NONE;
 }
-#define cfi_bpf_hash 0U
-#define cfi_bpf_subprog_hash 0U
-static inline u32 cfi_get_func_hash(void *func)
-{
-	return 0;
-}
 static inline int cfi_get_func_arity(void *func)
 {
 	return 0;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a555665b4d9c..9f6b7dab2d9a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2,7 +2,6 @@
 #define pr_fmt(fmt) "SMP alternatives: " fmt
 
 #include <linux/mmu_context.h>
-#include <linux/cfi_types.h>
 #include <linux/perf_event.h>
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
@@ -1185,17 +1184,6 @@ bool cfi_bhi __ro_after_init = false;
 #endif
 
 #ifdef CONFIG_CFI_CLANG
-struct bpf_insn;
-
-/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
-extern unsigned int __bpf_prog_runX(const void *ctx,
-				    const struct bpf_insn *insn);
-DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
-
-/* Must match bpf_callback_t */
-extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
-DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
-
 u32 cfi_get_func_hash(void *func)
 {
 	u32 hash;
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 1db17ecbb86c..52a98886a455 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -11,16 +11,9 @@
 #include <linux/module.h>
 #include <asm/cfi.h>
 
+#ifdef CONFIG_CFI_CLANG
 extern bool cfi_warn;
 
-#ifndef cfi_get_offset
-static inline int cfi_get_offset(void)
-{
-	return 0;
-}
-#endif
-
-#ifdef CONFIG_CFI_CLANG
 enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
 				      unsigned long *target, u32 type);
 
@@ -29,6 +22,44 @@ static inline enum bug_trap_type report_cfi_failure_noaddr(struct pt_regs *regs,
 {
 	return report_cfi_failure(regs, addr, NULL, 0);
 }
+
+#ifndef cfi_get_offset
+/*
+ * Returns the CFI prefix offset. By default, the compiler emits only
+ * a 4-byte CFI type hash before the function. If an architecture
+ * uses -fpatchable-function-entry=N,M where M>0 to change the prefix
+ * offset, they must override this function.
+ */
+static inline int cfi_get_offset(void)
+{
+	return 4;
+}
+#endif
+
+#ifndef cfi_get_func_hash
+static inline u32 cfi_get_func_hash(void *func)
+{
+	u32 hash;
+
+	if (get_kernel_nofault(hash, func - cfi_get_offset()))
+		return 0;
+
+	return hash;
+}
+#endif
+
+/* CFI type hashes for BPF function types */
+extern u32 cfi_bpf_hash;
+extern u32 cfi_bpf_subprog_hash;
+
+#else /* CONFIG_CFI_CLANG */
+
+static inline int cfi_get_offset(void) { return 0; }
+static inline u32 cfi_get_func_hash(void *func) { return 0; }
+
+#define cfi_bpf_hash 0U
+#define cfi_bpf_subprog_hash 0U
+
 #endif /* CONFIG_CFI_CLANG */
 
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
diff --git a/kernel/cfi.c b/kernel/cfi.c
index 422fa4f958ae..4dad04ead06c 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2022 Google LLC
  */
 
+#include <linux/bpf.h>
+#include <linux/cfi_types.h>
 #include <linux/cfi.h>
 
 bool cfi_warn __ro_after_init = IS_ENABLED(CONFIG_CFI_PERMISSIVE);
@@ -27,6 +29,19 @@ enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
 	return BUG_TRAP_TYPE_BUG;
 }
 
+/*
+ * Declare two non-existent functions with types that match bpf_func_t and
+ * bpf_callback_t pointers, and use DEFINE_CFI_TYPE to define type hash
+ * variables for each function type. The cfi_bpf_* variables are used by
+ * arch-specific BPF JIT implementations to ensure indirectly callable JIT
+ * code has matching CFI type hashes.
+ */
+extern typeof(*(bpf_func_t)0) __bpf_prog_runX;
+DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
+
+extern typeof(*(bpf_callback_t)0) __bpf_callback_fn;
+DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
+
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
 static inline unsigned long trap_address(s32 *p)
 {
-- 
2.50.0.727.gbf7dc18ff4-goog


