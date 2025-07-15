Return-Path: <bpf+bounces-63384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3DBB0697E
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 00:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3D3177D3B
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 22:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39752D6406;
	Tue, 15 Jul 2025 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEVvLB/H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00AB2D3752
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620269; cv=none; b=on8eGrDzIUl09AD0M43usYx0jM8c8N64Ek4cjiPNCNZTSfDrWKZY26uhPFEDrK8M27SNdwkZ0PyF97WvY07FuqpLuSW6Ai7YXxh+28s5q9EWaJWdc6AtVDZBiAHmmEhWgId5b9rsVcnhAD3KJgUAENHqgEj43vS+KRnmbnPsEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620269; c=relaxed/simple;
	bh=JYMMqOIguwvmYlpCtBUkSC4Y7ybrNECAIqn/EkjfUiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ERrWWz3n5tBQZKS7IyqeA75WCphcTxGAqyTJyoyqyOWbmWiuZOMdDXgLexNiSAzWLhiVX425++fBTd7GhJFyG16nUJ5iaP/bwRw5O2HEXXppxjG2VJStC8TpUbODh+91Kje/yNq/doNzErnZvLm5Lfb8tHYZtKwBeu+Qe/11yVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CEVvLB/H; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74d12fa4619so4967331b3a.0
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 15:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752620267; x=1753225067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bxkEzNpl+LQg8WYHJm151LdjKk0iMvXzxlrj1qGda2U=;
        b=CEVvLB/HzNwqHk5mmu3tKc+jV4Oy+1+ts9+uYwxSSCugOqlaDSXw7sVVWsAZKX/ykP
         EUCErI5TMs35GzeIu5iOVpJvYvS5peV36klYe1N3Nvulx/YxRTrL/+iWvg2OFx+JVJSm
         rnHESZ1sDNFuEbf+iLYfrUW3eGHN5ZdqYCvrlDy8q+HgoPEhaiQtCAub/J/5ydIiMyj3
         n5BgAjwT2cRpBaYOY4fE0+anHkx5Fb/GZBJuVnNGrqdjZlXx2AUySyhAJVfDkczcGjmM
         0/bl2BbyjwbdbeNlhtpVv0cauVfkkiwaXPgpSF/Hs4p3oQbHSkIEcP3ompXts+A/mQ3V
         5WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620267; x=1753225067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxkEzNpl+LQg8WYHJm151LdjKk0iMvXzxlrj1qGda2U=;
        b=RC7BB440ZEivlwXBEpaX+gfGsj395CCBkQQAklPvdIwNIZDY1/wxdvfuNl1FDxQERb
         Ynj0zJXk64xEkYFPbKZke/u82ae3m1/y86TsLOcuZcBRVJATpvLxHSS1Mpdk/l7+r5az
         NqhXspt10Io79qrBGl2jHQjLqINLiyN0LZO5HH5f0WYvX7DEhzmHhrbx6suAXiVK9XD5
         jYLIctCNcFgXYJjBukwezbsrVKPgXTHkWb3JmJzynmd1eA+Dgdp43FrSiSBcD8oao/V7
         CKqpfGvoiHfbNOLxlk85Evv4ZW/TZ3Rm34/oWT7vSt7KVnV0DLI4YtlphjEScs09vBIa
         VXiA==
X-Gm-Message-State: AOJu0YwSMSqyRkSFKmYNtEsrqM5IavJy9iHD30qFf0uCslbs3JaW3IHX
	pGNc7Xx7I0NjlEMGGnW2bIyNnPbZkPAaQUW9P02Kvl32ORZ9RjwWgSHPiIoFr0VBRn+9GgoS4fh
	2UqmZQklQyo8zy4a9uoOS5gE4FY61Yl7TIlTfTRBSHVthW3kawYZwQt/c6WOlUlwQWOoj33Gj5e
	F979NcTmmvusVS7Z9M1Een7qTSRlqRu1bo7zwaf/B09qNP/LBTw0Mo08UWZzx1317O
X-Google-Smtp-Source: AGHT+IG2nwRuZU8nKSGZKv/KCQaDAPwv7UTHMunOLKPdpbGG0wYtSG/FaNgQ997rCgAEFOJqVAawtb6zF7I7itb5eWs=
X-Received: from pgac23.prod.google.com ([2002:a05:6a02:2957:b0:b2e:ce0c:b3fb])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:72a4:b0:235:2cd8:6cd1 with SMTP id adf61e73a8af0-237d754df40mr2164567637.34.1752620266993;
 Tue, 15 Jul 2025 15:57:46 -0700 (PDT)
Date: Tue, 15 Jul 2025 22:57:36 +0000
In-Reply-To: <20250715225733.3921432-5-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715225733.3921432-5-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7361; i=samitolvanen@google.com;
 h=from:subject; bh=JYMMqOIguwvmYlpCtBUkSC4Y7ybrNECAIqn/EkjfUiY=;
 b=kA0DAAoWWgclqzmhp3oByyZiAGh23N+jP/g5zdO96cF7ZHZ4RED3bDnow5av8UA0IbpUzoer8
 Yh1BAAWCgAdFiEEhPWrtbv3QmXq83IYWgclqzmhp3oFAmh23N8ACgkQWgclqzmhp3pszQEA1Eo4
 g3Xc1MqFDX6ocKGbT/3AM0t8FXnN6Zbjsw9b+BMBAJqjNShp+eL0Gptqhtbb9qzV483Nl6NngZZ WhhyOp/wJ
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715225733.3921432-7-samitolvanen@google.com>
Subject: [PATCH bpf-next v10 2/3] cfi: Move BPF CFI types and helpers to
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
 arch/riscv/include/asm/cfi.h  | 16 ---------------
 arch/riscv/kernel/cfi.c       | 24 -----------------------
 arch/x86/include/asm/cfi.h    |  9 ---------
 arch/x86/kernel/alternative.c | 12 ------------
 include/linux/cfi.h           | 37 +++++++++++++++++++++++++++--------
 kernel/cfi.c                  | 25 +++++++++++++++++++++++
 6 files changed, 54 insertions(+), 69 deletions(-)

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
index 3e51ba459154..64506a91971b 100644
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
@@ -134,7 +132,6 @@ static inline int cfi_get_offset(void)
 }
 #define cfi_get_offset cfi_get_offset
 
-extern u32 cfi_get_func_hash(void *func);
 extern int cfi_get_func_arity(void *func);
 
 #ifdef CONFIG_FINEIBT
@@ -153,12 +150,6 @@ static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
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
index 1db17ecbb86c..53ed07cb9258 100644
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
 
@@ -29,6 +22,34 @@ static inline enum bug_trap_type report_cfi_failure_noaddr(struct pt_regs *regs,
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
+u32 cfi_get_func_hash(void *func);
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
index 422fa4f958ae..68b3760c15a6 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2022 Google LLC
  */
 
+#include <linux/bpf.h>
+#include <linux/cfi_types.h>
 #include <linux/cfi.h>
 
 bool cfi_warn __ro_after_init = IS_ENABLED(CONFIG_CFI_PERMISSIVE);
@@ -27,6 +29,29 @@ enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
 	return BUG_TRAP_TYPE_BUG;
 }
 
+u32 __weak cfi_get_func_hash(void *func)
+{
+	u32 hash;
+
+	if (get_kernel_nofault(hash, func - cfi_get_offset()))
+		return 0;
+
+	return hash;
+}
+
+/*
+ * Declare two non-existent functions with types that match bpf_func_t and
+ * bpf_callback_t pointers, and use DEFINE_CFI_TYPE to define type hash
+ * variables for each function type. The cfi_bpf_* variables are used by
+ * arch-specific BPF JIT implementations to ensure indirectly callable JIT
+ * code has matching CFI type hashes.
+ */
+typeof(*(bpf_func_t)0) __bpf_prog_runX;
+DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
+
+typeof(*(bpf_callback_t)0) __bpf_callback_fn;
+DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
+
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
 static inline unsigned long trap_address(s32 *p)
 {
-- 
2.50.0.727.gbf7dc18ff4-goog


