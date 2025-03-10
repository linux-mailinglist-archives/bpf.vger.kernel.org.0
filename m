Return-Path: <bpf+bounces-53770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0059BA5A731
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 23:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3118B16FE3D
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 22:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FC91F4C96;
	Mon, 10 Mar 2025 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w8fJDBPQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF41E834D
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645795; cv=none; b=qicb7RJqtE9KsZZsOCc/4jrZjsx/T/smTimFSoZ/ddbwOuSrdWStFG38rWMk5mgpKTMkQ/2KIEd5L0/rKYYpxln+JVxxJnQu4si+3sMSYHeHaRDuuPPnucZ1VsmJAWqT7RxkV9RJJsTAxcZRgtl47o7gaN/vRjj7PUWttrDacyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645795; c=relaxed/simple;
	bh=I+Ajp8iKFoD3DjByffG1Vwxzr4OY6xTLF62xUyu0N7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sPUyH5NKBXLcmLOka+t9/+qHxAYj7B2iU1sd+XGaBTTrrrHcIz8Kq/Rg8ubNg9lCHbv4GH3Q4zh8BMOVgLSEprb3Jz6WKDWfZonCsXfTrrJh6cm5TU9KXZ8amXcrdbfh4HX+hzstbZc/paiuGIOzIdqng5xXeUaz5K1ZgEpLaAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w8fJDBPQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-223477ba158so125366545ad.0
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741645793; x=1742250593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AjPf2shQRLMRmBXrAUCw8IKmWn8Iwh7animLlBVPN6M=;
        b=w8fJDBPQzmNLInDUTdvaoJEtHga51uyG16PBWCl/Ez0GK6QIFsHGVBJFBk9Dk581kj
         AF2pvCqijZkSmfFQLNFzxPUeGPmFR8ot/Wwp3P3ddUt7p3kW0aCoEwQb0xhRTkm+c+QD
         GkIaQzSUfsgAqU+Nt+jLwAPMnbb4wAabpCuXsaAu9eUn/ig2eAOZz8xJroG+3WKGOjZl
         9D6libkET0D25K3MPus4MHP+sM25GH+FKVH+OwHlk9VmwMpHTpi86/FSYQnDg63zC2d2
         d1wpelrfscnAL9LsYclwaQ0uF+AyE0Z0Ibo8mItIhGRMeRVqF2TPJCuK1/7IyrUmWFEU
         m/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741645793; x=1742250593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjPf2shQRLMRmBXrAUCw8IKmWn8Iwh7animLlBVPN6M=;
        b=bHTGD3dmZwBECJMq6pJ2RlEBVIbhudli8LEsh5b7BcdyltSblNL9BetfMarZOsAM5M
         XFZj5/mmrYQ18vh9AB6lPlwNAz75GnY8GkRoC6g6ai3nNHhy0vi77bNR/y5fcsls2oj/
         hITerAIyvL3gngY2d4Euvpj40JI0n8HxC8Z8x01Nt4BHZaAfP2FSZe5gpfoBSYDCUC4L
         yd9VeRbWIBTuKaMro76TuZzV/I27i2t7QXogxTncUk1b50xD4b0oXtUFI7TqO9jVC7Zf
         1omuZ3bNOeAAjZtYt+CLMunp76DjfHTJYRwPJZ9XvhERhreNk+oANdAjzZmVM0hxvbyi
         EIOA==
X-Gm-Message-State: AOJu0Yzp+O/O6Omc3yJS3I/4FRuQ1k/k560BOnSzZrLM9TwKZUZCRqL5
	SGL7tt0IVgmHqqjfhX+s9O4CQi7Lts/q+bwuJGnZ3pDsECXofXEsRNt/d8+XAtS3YtG+PJnaqLD
	w5+mti9bhyUXLe+wxB2XZvj1BGFPxKE6DfbMX70+7+FUJGnEGEnsFPUi2PbOVs3/MK07vo2rHBA
	mDr2cPSPrcpeVpXSLGl2g1RPq21U3ZY/kGrgqS3lwrqH1GLFEdXUH069z4GVeK
X-Google-Smtp-Source: AGHT+IE81DnApalhSNa6Q+gumvBFHqSIx0AsWk7ET6yIBgX5IzlABVRR0oTugyRM8zrJx3fOpk/9aoT2bCShvufrS74=
X-Received: from pfqf15.prod.google.com ([2002:aa7:9d8f:0:b0:736:a70b:53c7])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:14d1:b0:730:8ed8:6cd0 with SMTP id d2e1a72fcca58-736aaadf579mr20796495b3a.16.1741645793503;
 Mon, 10 Mar 2025 15:29:53 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:29:44 +0000
In-Reply-To: <20250310222942.1988975-4-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250310222942.1988975-4-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5315; i=samitolvanen@google.com;
 h=from:subject; bh=W+jggK7C/5PYdHixfxJP9xMmc6GBQiiKBsu4nn5qYP4=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOnn02/Nc2Fhu8TSPOX3R9mDq+6o7lzq6Ob9/Gm3vS8n3
 8nVP7PZO0pZGMQ4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBEwiwYGTYGzLuU9evUmn3M
 2fMcwpRKIv20qtLuHGbYKmMTF6LK/ZHhf32kqsDuWKPo43c9Pc//LF//iDfzwk2TtOv1p2c83F3 9gwsA
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250310222942.1988975-5-samitolvanen@google.com>
Subject: [PATCH bpf-next v8 1/2] cfi: add C CFI type macro
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Puranjay Mohan <puranjay12@gmail.com>, Maxwell Bland <mbland@motorola.com>, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Mark Rutland <mark.rutland@arm.com>

Currently x86 and riscv open-code 4 instances of the same logic to
define a u32 variable with the KCFI typeid of a given function.

Replace the duplicate logic with a common macro.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Co-Developed-by: Maxwell Bland <mbland@motorola.com>
Signed-off-by: Maxwell Bland <mbland@motorola.com>
Co-Developed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/kernel/cfi.c       | 35 +++--------------------------------
 arch/x86/kernel/alternative.c | 35 +++--------------------------------
 include/linux/cfi_types.h     | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+), 64 deletions(-)

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
index c71b575bf229..a9f415e873dd 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #define pr_fmt(fmt) "SMP alternatives: " fmt
 
+#include <linux/cfi_types.h>
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/perf_event.h>
@@ -934,41 +935,11 @@ struct bpf_insn;
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
-"	.long	__kcfi_typeid___bpf_prog_runX			\n"
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
2.49.0.rc0.332.g42c0ae87b1-goog


