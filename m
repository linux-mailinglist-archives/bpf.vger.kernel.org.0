Return-Path: <bpf+bounces-27897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF508B3266
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 10:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BA21F2337C
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D294313DBBB;
	Fri, 26 Apr 2024 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ85BCEt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37513C9D1;
	Fri, 26 Apr 2024 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120177; cv=none; b=dig9/oKuvY8kmloBGVYU94mb9YI7mYxmMY+I2I1UscDr910hyqDFzzcBmZFcMgx6JQjX8kQ4FBBd07RXE1dTq66jGpIpsfQ+oYqRZNWxrQ6fkfJPaAkKeGDuBGjMRb6wi7TmEP3QI7HGAk9E/UqkjkAjXfBknjcv/4CvudZWSe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120177; c=relaxed/simple;
	bh=DCxnhfiOCuZ1vbHkz6N1kzg5vD2Mqvj8bCN8VHj/6O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3lYeVTGm3ailgOg9C83R8EJJTnl4Pgf/jvwdp6YHNa5eju5BoK1fukjUUqvxyH+PSqrvmwdPwtsKSUQmfzubhNVZ551oS+sHwHzBykkbseGJ3C90169itG8gBmsTEqurhIs7K0j4b1EPcR/vYS7TvttB/ISptIDREYZbO7EV3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ85BCEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2679DC113CD;
	Fri, 26 Apr 2024 08:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714120176;
	bh=DCxnhfiOCuZ1vbHkz6N1kzg5vD2Mqvj8bCN8VHj/6O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJ85BCEtXn9eC/rmnQOAFLqtOnqZnrIZhj7bfmRPi7oxShQXrtP4Uo5HR8nSbD8vo
	 gPsy+y4atIh2HMiSUwxm9ruLsRzgF8GKd0SQITa9LSTNZ3s1l6VFdUmjWVa18XNtDm
	 wmndfdYM2HWsi1NxgEkL3Yi/2Wd3TbOQELwu5rL+6f7WiXzzXzTM2B5ch4q1YZRsjH
	 iSzijG4ahNzTFxxFNb1voatba0/dKnlSX0rJtmZQwKsejOJeAysUtuMBrUvR1kI8G2
	 77cQ1XEqmgjSmkLajSNAy9YWclmvvuVxCBhH0De74z5sFFxkmJLPXuTC6q2ljZFp/S
	 FiiZiNa8VahbQ==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v6 02/16] mips: module: rename MODULE_START to MODULES_VADDR
Date: Fri, 26 Apr 2024 11:28:40 +0300
Message-ID: <20240426082854.7355-3-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426082854.7355-1-rppt@kernel.org>
References: <20240426082854.7355-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

and MODULE_END to MODULES_END to match other architectures that define
custom address space for modules.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/mips/include/asm/pgtable-64.h | 4 ++--
 arch/mips/kernel/module.c          | 4 ++--
 arch/mips/mm/fault.c               | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 20ca48c1b606..c0109aff223b 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -147,8 +147,8 @@
 #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
 	VMALLOC_START != CKSSEG
 /* Load modules into 32bit-compatible segment. */
-#define MODULE_START	CKSSEG
-#define MODULE_END	(FIXADDR_START-2*PAGE_SIZE)
+#define MODULES_VADDR	CKSSEG
+#define MODULES_END	(FIXADDR_START-2*PAGE_SIZE)
 #endif
 
 #define pte_ERROR(e) \
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 7b2fbaa9cac5..9a6c96014904 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -31,10 +31,10 @@ struct mips_hi16 {
 static LIST_HEAD(dbe_list);
 static DEFINE_SPINLOCK(dbe_lock);
 
-#ifdef MODULE_START
+#ifdef MODULES_VADDR
 void *module_alloc(unsigned long size)
 {
-	return __vmalloc_node_range(size, 1, MODULE_START, MODULE_END,
+	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
 				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index aaa9a242ebba..37fedeaca2e9 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -83,8 +83,8 @@ static void __do_page_fault(struct pt_regs *regs, unsigned long write,
 
 	if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
 		goto VMALLOC_FAULT_TARGET;
-#ifdef MODULE_START
-	if (unlikely(address >= MODULE_START && address < MODULE_END))
+#ifdef MODULES_VADDR
+	if (unlikely(address >= MODULES_VADDR && address < MODULES_END))
 		goto VMALLOC_FAULT_TARGET;
 #endif
 
-- 
2.43.0


