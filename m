Return-Path: <bpf+bounces-63775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C0B0AC31
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 00:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557665A5C10
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 22:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA7D224AF2;
	Fri, 18 Jul 2025 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWkVRzTs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A6223324
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878037; cv=none; b=qN2tCNpQwC5TrRNDyrRLpyvPB7fAbmymjBXnmTyCROHduuJu7F2Czc7HBX0sYECqNEu5vGc9bp38g3wmLJAvxKHjIAmojEfXWxAp2aIYMUomQNCkC6wvVk0w/QoXmS6hh/ei2tuXVqoCRh+Vg9DMxsFPemhQ94xO+FI8UAipDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878037; c=relaxed/simple;
	bh=/Pp84iiKhYqnoXcwmrfh0wQnxZW4ZWvLGB2ZBYipHSs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sUF0nAMezTAHfjqWTPuoYHKk5qBCyWHAD4a1LWYcBRCLcPDRJ88VEqn6FQvT7/4saUBEapQKR4N17jm6RNuY+J8IhcIMKF06pajg2fgKVklZ4WWTkr3YIZzjocWd7wTAiQDgUE4eCp0C5Ezi09xpqlbJwRSbqIfJMcXgQlxgRKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nWkVRzTs; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748e6457567so2262860b3a.1
        for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752878035; x=1753482835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/LI2mE7zqMo++9mb9IpCNbm5MsNfp6DXDgfkTWDvxI=;
        b=nWkVRzTs+meIv5XnzoyMpwZTKEFihxsYLI3e+IrsntgMWwFPO05tDejXnE2Fvu7lct
         LKtDJ3YvTuB41krq2CQz0koNxZ5WtHbHHqXtBgRfbG7Xh1cfauPYm5OU1MV73o2j5ex/
         ubWyWP1xCv0XCU7JKdlIsWM+Be7Lyrx9BG7pVdIhCS2dISMOaNfQhmNBIemS6FmyzsQG
         Un42gR+OgJ6VarD8Q8Trj+tkyJEFgEdzL7GmOFdCafmIQTcEaxuQod4i0A5L+cUDeyd5
         aCxAjcFfTCFtcwPB9ouHXSM1W4fq2oD7Wl+TNBXJ1eGLpLadpCThQilTyKEVfQnqRtTX
         v03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752878035; x=1753482835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/LI2mE7zqMo++9mb9IpCNbm5MsNfp6DXDgfkTWDvxI=;
        b=lbqKDB7QUEIGPS/XEcqogXO5rFcHYKuQsS/8+cMqObq07fjEqIpa6KuS7O9/1R/arg
         luFDFWFMmOpDDxIKq6lrY6uZZxgaL8OhCBiwM3vZGFOYDbsnlv/7SvZ5RjJ1HgSFb0S4
         1dWySQ+vlvjOs3lr8zX4KBP49jz2Wl9b2As4daST1rqUyY03v7nf/0bal+OTxx76UA0L
         GXE71JYVWecUOf/Z7JWsC6cLnu1TeGphnO8IvM33n6nTs/r6ihHXAUn54sI7TJKyiNAM
         yOcp0kUcQHPH65CM4ofhzBY9x6A1EsjsJBL4r8m0qhX7eOlLmVpeO+HrMAPrnOAldUHG
         sg1w==
X-Gm-Message-State: AOJu0YzWvosYaFllyV/BzNF5XKKLm+v50H1FPPiIcuEpT0OebUFZ3GHE
	8122ihYg+sL0qL1BYSKNa4ShC/88DdR/0HTvfXG1cALiwNq9x0p0NQTvPQOfWr4A33AJOnNjRjQ
	QkV/M9F7i6sSKgZez7xet2pJPdMZbtJUVVuZEeNtAWfR1C3l2zXC21Z1xVeQr1B5d0fFoYGD0IN
	C1RwaU9GN1w6S1eAecHcS1jzCMTUzA9Oc2zdpQneFZ5N9H0Gd1C9krBS7NYmbabhbF
X-Google-Smtp-Source: AGHT+IGYsweP5RXtaeuhANIUviNkKF+PZe6ZB7Pqx3lnfK43GlSHJqBo4bHYLGMK7KP63CQvnlaCF3uNDtst5fF4o6w=
X-Received: from pgcv16.prod.google.com ([2002:a05:6a02:5310:b0:b3f:3770:71fb])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:2d07:b0:1f3:3547:f21b with SMTP id adf61e73a8af0-2390c744ecemr15750188637.5.1752878034816;
 Fri, 18 Jul 2025 15:33:54 -0700 (PDT)
Date: Fri, 18 Jul 2025 22:33:48 +0000
In-Reply-To: <20250718223345.1075521-5-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250718223345.1075521-5-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7386; i=samitolvanen@google.com;
 h=from:subject; bh=/Pp84iiKhYqnoXcwmrfh0wQnxZW4ZWvLGB2ZBYipHSs=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBlVp09t3PuwUN59x0cx7ymzuQ9IBU09K9HkH2HSw3y0S
 9SLcbN0RykLgxgXg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZjITC9Ghsvsm60+LeS1n1dQ
 HXN/+4Lr109XTms41qso6r2CQbXg9wWG/xGrEqsk6k5a/Xf8ebK0pcXenefHw6Klab2X5m25/cB enh8A
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250718223345.1075521-7-samitolvanen@google.com>
Subject: [PATCH bpf-next v11 2/3] cfi: Move BPF CFI types and helpers to
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
index 422fa4f958ae..6f1e74ccc6b3 100644
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


