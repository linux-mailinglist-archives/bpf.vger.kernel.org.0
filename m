Return-Path: <bpf+bounces-57407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97E2AAA689
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 02:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1F87A436B
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 00:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F91328081;
	Mon,  5 May 2025 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pxc8qQrf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B7332606C
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484486; cv=none; b=fPU6aWCkA5aXhUHOqJCiceAbJwnPtD+ql9ZQ/jB/AVDuKJ2F9IowQcbCrigRTBeVEMHBEvsI9jTTWhd2yJV/HuLWlUhoFOxETKdufcnQrMM3fdxNc17b0qE1IySNMvJN6sVpAAAe00T0wRqy503LiRXuw1lXSl7S59d2tJRwokM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484486; c=relaxed/simple;
	bh=7lXxkCUDjU68lKio/dxiQKRh3tGjp/pOmiVpK1S5RDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hCqSA8BLIEl74Fup4QXkYHRtz9X7+3u7j6vrnpL60e1jWNwBJ0MXWKHJRGkJmcbP3WeoMaOSymMd0pe9/yAsgBg2LRoWNb54fAZEKZFipKTm+0JWQ11TLDiGr794FnIu4AsCddfKuQv29LS1jK1OQWUh0UsA6FwP2tuvBqlz5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pxc8qQrf; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b1f8d149911so4511124a12.0
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746484484; x=1747089284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lcCv7hpJFXCgQNPjvIpQD0jIr1c2DrHVr6zfyF1t5G8=;
        b=Pxc8qQrfZfgIHoy2DbUrFk3AUb8+Ns6f6pxf3pg1IfJ2MNy7EIg3OHw0GSXePgF3Fx
         05Q+8ehKGo2/pU/yWveaOvjGkQ8mjuCiC1uzsRw3hYbgoFmGRLAo5PM/L+WFwszT82vX
         quU9fnN+Uftylv4r3Bj65Tmd7nTYlxlqBK4pwPOtOmBlquQtwbspP/FIKxcRyPJ2i1+g
         AwIr9NpmsrIILvMIWbaoOzi6x1e9F/vb+DbaTp814m+LFrwWftxowpzkZz6iIKl6jTaH
         LgUHlpY+hR+jz6e8YHt0/5doedhubfBSLUQ/iygZfP/ZZ694OAML04xp6d4dhDGpzBwr
         /uSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746484484; x=1747089284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcCv7hpJFXCgQNPjvIpQD0jIr1c2DrHVr6zfyF1t5G8=;
        b=CB+eGtiUSTsP0/Z04+VeMvKdeAvKokDVpgcmi3yOu498crol2LJdv3NZ82EuKI4DVD
         6yA+FMYpU3+Z7bFsHb0NKtAKCYYGHV1V3tiqCyTaSqsFYT9LiHRl/KEnv6flogvcRmwc
         aURb0rse89gXDse4UWYdrIeV81Lu8mvqSaD93tb32gaFZxZdSgIAMSyLcgZbnaa16FPq
         VF+WNDaBGHfp0FuoVDky51m8hPAUO4GYYo/UAS0X7SuWABdRNwhZYCrsikzXcPFmiej7
         kDVEHh67nmnuQ0QE1tgRr9WgCk1v1V4LGMowi8p9ASQywDc/KleLJmpAd6Eo7t6YQaCU
         x0Hg==
X-Gm-Message-State: AOJu0YxOpMa3/uIUsXzIraKsV/g3mFi4zg7VDND/BjhL0Fyl4Qzmzrhy
	dzJbENTN6xiHUHGWYeGmkqy8pAGmczXpWFtjXt45fUKEqyH+1GBVJ+sa7YxzLMK010PDzW9vFEm
	Phdn2ynhqxXMEeqPZbjvVN+bMDptHtsB5O9+RsRr3C0E+gSzsexrpOMjWgYeYUiH/MdBokYHKg0
	FYOc7uhwwX5euU2+MetwVokWn00Xj40oaJBUTrkYeDVO1JvKVimhzmyA7zPxh2
X-Google-Smtp-Source: AGHT+IHNzFURwBesMY2NJiCBx+5mmsp7b+O42UgI3ZoXcQ+zCwjPh8MzPQ3QOywW7NIAJbYKP3/lXbLkj6ZlWCWXibo=
X-Received: from pfoc21.prod.google.com ([2002:aa7:8815:0:b0:739:45ba:a49a])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c88f:b0:1ee:d8c8:4b7f with SMTP id adf61e73a8af0-2118259786cmr1133213637.25.1746484483566;
 Mon, 05 May 2025 15:34:43 -0700 (PDT)
Date: Mon,  5 May 2025 22:34:39 +0000
In-Reply-To: <20250505223437.3722164-4-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250505223437.3722164-4-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5250; i=samitolvanen@google.com;
 h=from:subject; bh=wKRcArm3I8YdLV7xUagIsjaFHkOg54K0GIqYgszVZFg=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDBmSNv9K1st1fkzpOPgpqm9HvJ6izx0fP3eZM7ddDm3ff
 pbr0IuOjlIWBjEOBlkxRZaWr6u37v7ulPrqc5EEzBxWJpAhDFycAjCR9YoM/2u/Vn5ymMXkPVEj
 Y5nFhVMNq0JCk3uyGX6cbNw8aYnmg2hGhm0vH91YYKerum/zl3o2sWSho2YmT7/NTtTW4F61YrZ RHQMA
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505223437.3722164-5-samitolvanen@google.com>
Subject: [PATCH bpf-next v9 1/2] cfi: add C CFI type macro
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
index bf82c6f7d690..a5147fcd8397 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #define pr_fmt(fmt) "SMP alternatives: " fmt
 
+#include <linux/cfi_types.h>
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/perf_event.h>
@@ -947,37 +948,11 @@ struct bpf_insn;
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
index 6b8713675765..209c8a16ac4e 100644
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
+	/* u32 name = __kcfi_typeid_<func> */					\
+	extern u32 name;							\
+	asm (									\
+	"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"	\
+	"	.type	" #name ",@object				\n"	\
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
2.49.0.967.g6a0df3ecc3-goog


