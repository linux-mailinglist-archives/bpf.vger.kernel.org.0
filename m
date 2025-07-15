Return-Path: <bpf+bounces-63383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC249B0697C
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 00:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0167B567654
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 22:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104822D3EDC;
	Tue, 15 Jul 2025 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7WGLG5V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC8F2C325F
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620267; cv=none; b=oH1+2KMz78lOJ3EzkLyMrdo2MTpYcOTjvqPnC2jfZxq7TkIlaiVSRn+81JnHF9BmIYm7OhUfIA3CLNQcXUvypxsKwJG9vCiAbKolCXIK2kqV9WkVcVntqW90Ocpw8YspVxRLeirSsQ6d+K48HpgrDeAJ7cE2sf2+wIMJAtc97mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620267; c=relaxed/simple;
	bh=gER9ScMtOtwC9xpclIhEAteq0OGt+Y3IoBSJHGzYfCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PVfilZotErSfGmosJJlHUSld+cSZ61455mJs1p0YXZt7GYuDhQ1qn/etp5i5m/xPH8wZyoEUIhX38+Ew1ZhLPSMPW9RSNXfSPqpUwO6m6ey4QgRYiRuL8kR7bAAvjBuYTjbNYt8/saoxuGkAowTqx/5SwBE2H66/Xly2Ku0ANSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N7WGLG5V; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso297082a91.0
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752620265; x=1753225065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5AK/1PeqQC+sa8XwDnM8NGzttuQcxnY7sFwTeAuNhw=;
        b=N7WGLG5VXtZxhb0b3DJQ43WbkHcs54n6udzwT6FaynY2KlSfEZCEn8w3pKUXvBHgtN
         AlKI42hRztyrCyXaZlaEJNBQPnT5y3HI14H7HsXwcRzY1++pZ4CdwIZ8S6wl56RMZed7
         E2be85hprhQs+lZOhf9g5DxtNgIOq9cKZwbng5hYjl6sMhAt9oB3JENeJC0Kim1Jojtv
         HWizTgfSKFm9i9sQODKPScnxtQ2oWnWmLF67SnmfyU2enJggxKJx2CquvUayo/XFL/5U
         rwywBSyt/SDJNFMEaeciNwocW3s28I6ElWNPrP//Fs91ZYt46sgROjX9wgXpWVyeY0b3
         12hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620265; x=1753225065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5AK/1PeqQC+sa8XwDnM8NGzttuQcxnY7sFwTeAuNhw=;
        b=UUq9mslOSKY2PPTjcboqTsR+OhAH9B0Ilhsw/uOxWxSmKoEBBFS0rSnWeH+mvJAqNT
         jVsa63gywmyavuk432HAmMV9TADjVoASn3bomOIQmfVOJzJ4PlxeozUgBkyKNCHjX/MP
         hMQ91/ToN1ywWpec4cUOKra8LGJuq5j+2a8poubyzu61daJACWJwGt1z2AunmOrlh7lZ
         yaruNhBOdiL/VxpOQa3O4HN7qZc7ixb+58r4Kyr2ItkuSVojldQZxt6MbxzFO0tSJv8J
         SZB179FO4+HFiulgs5OpfswVrVOIhPsTQzaK4H3PpcVBJFQJsQByAZl1QLK1HguRSxm+
         7meA==
X-Gm-Message-State: AOJu0YyfZ883/p8PP6sggXMVzB99JVNTFnaKRZHFNWEI+Z9noo8jmRP4
	fwAgDzpfMvvG7g0UXu8wN8lErX6L7Zg2nCq2lp1YQNDPx7M0YhywwBWvSu5TiJ7nIBzMVCZdVIt
	PeEZaeoIIAUdw+TwscuftoaT0tPQqCMs7zqG1XS63Bi5l9ahzSTeMtnJxOE2acbepvXfijaB+KA
	z7oVQbUptVTjj7MYgr+2rhyD17iIQHTrN0axa6lgIHJLOrEfCtSkqZmgrL16S3IYsI
X-Google-Smtp-Source: AGHT+IFRJnQuf3ZfTFNheXhqqmEyyVMwsn+nHtXsPsgY0nnTYfz2CvtHbU+B8gUhLr16qjC7a3OLa11W0DsbaBWGlp0=
X-Received: from pjwx13.prod.google.com ([2002:a17:90a:c2cd:b0:313:230:89ed])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b4d:b0:2ff:4a8d:74f9 with SMTP id 98e67ed59e1d1-31c9e73efe6mr1347174a91.10.1752620265306;
 Tue, 15 Jul 2025 15:57:45 -0700 (PDT)
Date: Tue, 15 Jul 2025 22:57:35 +0000
In-Reply-To: <20250715225733.3921432-5-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715225733.3921432-5-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5258; i=samitolvanen@google.com;
 h=from:subject; bh=fmHbTT6n3AcyMrdoZaFttPRZqXRsHYHqk54PFgD4xF8=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBlld+4dcv66/MPU6FXsLAsCTrLUa5wV/ZDUqjj/UHHN/
 Lot76ukO0pZGMS4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBEVEIY/vBdZ+ipVq/R0pQ9
 tOfUjd1iHpZX99WWGoSlML2v6ku//5/hn9K0Umljzpvnz/78GHw3sNjAfoFfaTj36uMJC18yXFs fywsA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715225733.3921432-6-samitolvanen@google.com>
Subject: [PATCH bpf-next v10 1/3] cfi: add C CFI type macro
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
index 6b8713675765..e5567c0fd0b3 100644
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
2.50.0.727.gbf7dc18ff4-goog


