Return-Path: <bpf+bounces-27394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21AC8AC9C1
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 11:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59BA4B21790
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F56142E9E;
	Mon, 22 Apr 2024 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyfPrgZi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D3524A0;
	Mon, 22 Apr 2024 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779250; cv=none; b=Bj5NlVEeFkLZ7/SQK0KmNrxrBNkvSuxlZPvgIu5SbJUQa9d5im9SmCQE9Q8UZubT4VDBQzIHyqJqlItbGbYqNFRl2o6tbGaRw7uMC35WhtPDwvPiYQ/FqyhWnNOu7ZVdv7qIoxLfzI5GlXpkbRdoJz/GX+WkOa53VaKkSlUTWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779250; c=relaxed/simple;
	bh=dj8Jeem56mTOW4r4fQ6hbW3YTYti2N5hSv58QgNFPjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTWVh6We41VIV6ikJdTbErOtiY+T3/aheDDhbqtV2RuRGx+EhhugadAcchydKQ4ZFNLQ9OZa3v0nRXPDwFOSjeH7sEpkOQwfYS8/i5qR7CEGDN/1JiaFEQAocl4k334yYEFDvKNlBUAOoq6a28+GVuqPd93mN0m2Y1vWEis1Tx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyfPrgZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A4BC4AF12;
	Mon, 22 Apr 2024 09:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713779250;
	bh=dj8Jeem56mTOW4r4fQ6hbW3YTYti2N5hSv58QgNFPjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyfPrgZiDWc4RkUjrZlx545lnRLFdbeC61xDsyK+e6MatRYTvVBCg9/2SoxfuUH6Z
	 gVkeJ5AubNGZabonmRRFpfMz3ZeEIz9tZt9ifefl2p63gw+xxsLSko/AynhJxuTrfR
	 yMtOeJbNbWX4Lp0H9EhGsYFkFRP7v5FHr577C2+2DLEolVO1kzSA+f1TEME9MDmMZm
	 wxgjX57g5pjxmhJNvboOJbNbz0EwYzzlPKwpzZBS27md9j7SanSG0VtybVpu/LDnlp
	 bzG32QBlwNathK1Z2Mg/HpJsrwbzbEOU9MjgiIdIfkbyt/pC9x+yxzCkHozNkv+03T
	 HuD00Xt1BjuFQ==
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
Subject: [PATCH v5 13/15] powerpc: use CONFIG_EXECMEM instead of CONFIG_MODULES where appropriate
Date: Mon, 22 Apr 2024 12:44:34 +0300
Message-ID: <20240422094436.3625171-14-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422094436.3625171-1-rppt@kernel.org>
References: <20240422094436.3625171-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

There are places where CONFIG_MODULES guards the code that depends on
memory allocation being done with module_alloc().

Replace CONFIG_MODULES with CONFIG_EXECMEM in such places.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/powerpc/Kconfig                 | 2 +-
 arch/powerpc/include/asm/kasan.h     | 2 +-
 arch/powerpc/kernel/head_8xx.S       | 4 ++--
 arch/powerpc/kernel/head_book3s_32.S | 6 +++---
 arch/powerpc/lib/code-patching.c     | 2 +-
 arch/powerpc/mm/book3s32/mmu.c       | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1c4be3373686..2e586733a464 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -285,7 +285,7 @@ config PPC
 	select IOMMU_HELPER			if PPC64
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
-	select KASAN_VMALLOC			if KASAN && MODULES
+	select KASAN_VMALLOC			if KASAN && EXECMEM
 	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_PAGE_SIZE
 	select MMU_GATHER_RCU_TABLE_FREE
diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index 365d2720097c..b5bbb94c51f6 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -19,7 +19,7 @@
 
 #define KASAN_SHADOW_SCALE_SHIFT	3
 
-#if defined(CONFIG_MODULES) && defined(CONFIG_PPC32)
+#if defined(CONFIG_EXECMEM) && defined(CONFIG_PPC32)
 #define KASAN_KERN_START	ALIGN_DOWN(PAGE_OFFSET - SZ_256M, SZ_256M)
 #else
 #define KASAN_KERN_START	PAGE_OFFSET
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 647b0b445e89..edc479a7c2bc 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -199,12 +199,12 @@ instruction_counter:
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
 	INVALIDATE_ADJACENT_PAGES_CPU15(r10, r11)
 	mtspr	SPRN_MD_EPN, r10
-#ifdef CONFIG_MODULES
+#ifdef CONFIG_EXECMEM
 	mfcr	r11
 	compare_to_kernel_boundary r10, r10
 #endif
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
-#ifdef CONFIG_MODULES
+#ifdef CONFIG_EXECMEM
 	blt+	3f
 	rlwinm	r10, r10, 0, 20, 31
 	oris	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@ha
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index c1d89764dd22..57196883a00e 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -419,14 +419,14 @@ InstructionTLBMiss:
  */
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_IMISS
-#ifdef CONFIG_MODULES
+#ifdef CONFIG_EXECMEM
 	lis	r1, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r1,r3
 #endif
 	mfspr	r2, SPRN_SDR1
 	li	r1,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
 	rlwinm	r2, r2, 28, 0xfffff000
-#ifdef CONFIG_MODULES
+#ifdef CONFIG_EXECMEM
 	li	r0, 3
 	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
@@ -442,7 +442,7 @@ InstructionTLBMiss:
 	andc.	r1,r1,r2		/* check access & ~permission */
 	bne-	InstructionAddressInvalid /* return if access not permitted */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-#ifdef CONFIG_MODULES
+#ifdef CONFIG_EXECMEM
 	rlwimi	r2, r0, 0, 31, 31	/* userspace ? -> PP lsb */
 #endif
 	ori	r1, r1, 0xe06		/* clear out reserved bits */
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index c6ab46156cda..7af791446ddf 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -225,7 +225,7 @@ void __init poking_init(void)
 
 static unsigned long get_patch_pfn(void *addr)
 {
-	if (IS_ENABLED(CONFIG_MODULES) && is_vmalloc_or_module_addr(addr))
+	if (IS_ENABLED(CONFIG_EXECMEM) && is_vmalloc_or_module_addr(addr))
 		return vmalloc_to_pfn(addr);
 	else
 		return __pa_symbol(addr) >> PAGE_SHIFT;
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 100f999871bc..625fe7d08e06 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -184,7 +184,7 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 
 static bool is_module_segment(unsigned long addr)
 {
-	if (!IS_ENABLED(CONFIG_MODULES))
+	if (!IS_ENABLED(CONFIG_EXECMEM))
 		return false;
 	if (addr < ALIGN_DOWN(MODULES_VADDR, SZ_256M))
 		return false;
-- 
2.43.0


