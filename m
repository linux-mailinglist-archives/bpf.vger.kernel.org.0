Return-Path: <bpf+bounces-10259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B8F7A42EA
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 09:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D051281EA2
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8E915485;
	Mon, 18 Sep 2023 07:31:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3A79C1;
	Mon, 18 Sep 2023 07:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D35BC433CD;
	Mon, 18 Sep 2023 07:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695022312;
	bh=/lkcmGgfZ0h40rnIgrlGtkFY3fqKKa7LS9K2y40s078=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpYN3pG2mJV/rqYXUts/nj29qV9EPMjt0zx/SMPu/4jisp6o2O8xaHc0tuU0dozmC
	 EkX/reooL7FObsZ0D9hJ8qVr3s0jxZwQDniBogZP502PMqTzmb9zf8IC8v48ADq9JJ
	 vhZzaS3bIiYR4KpLC0gQ9XGiX8Sg8U3ZgIlfxPbUxlyBunRPZGtKxFV4rwutmG1U2Q
	 xNiJqoyc2QgzMbsZ7fvm26WevVyonKdQpLbr248krCbEnUGRO38cNr6hKTgmskgkoC
	 M+BAIpPXGnu21jR6jiTi0lpov13TwKfc4fKKAJMozA7dQLpxyNDE6MCIa6xWY0rBPk
	 BD29RoWukxl2Q==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
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
Subject: [PATCH v3 10/13] arch: make execmem setup available regardless of CONFIG_MODULES
Date: Mon, 18 Sep 2023 10:29:52 +0300
Message-Id: <20230918072955.2507221-11-rppt@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230918072955.2507221-1-rppt@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

execmem does not depend on modules, on the contrary modules use
execmem.

To make execmem available when CONFIG_MODULES=n, for instance for
kprobes, split execmem_params initialization out from
arch/kernel/module.c and compile it when CONFIG_EXECMEM=y

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/arm/kernel/module.c       |  38 ----------
 arch/arm/mm/init.c             |  38 ++++++++++
 arch/arm64/kernel/module.c     | 130 --------------------------------
 arch/arm64/mm/init.c           | 132 +++++++++++++++++++++++++++++++++
 arch/loongarch/kernel/module.c |  18 -----
 arch/loongarch/mm/init.c       |  20 +++++
 arch/mips/kernel/module.c      |  19 -----
 arch/mips/mm/init.c            |  20 +++++
 arch/parisc/kernel/module.c    |  17 -----
 arch/parisc/mm/init.c          |  22 +++++-
 arch/powerpc/kernel/module.c   |  60 ---------------
 arch/powerpc/mm/mem.c          |  62 ++++++++++++++++
 arch/riscv/kernel/module.c     |  39 ----------
 arch/riscv/mm/init.c           |  39 ++++++++++
 arch/s390/kernel/module.c      |  25 -------
 arch/s390/mm/init.c            |  28 +++++++
 arch/sparc/kernel/module.c     |  23 ------
 arch/sparc/mm/Makefile         |   2 +
 arch/sparc/mm/execmem.c        |  25 +++++++
 arch/x86/kernel/module.c       |  27 -------
 arch/x86/mm/init.c             |  29 ++++++++
 21 files changed, 416 insertions(+), 397 deletions(-)
 create mode 100644 arch/sparc/mm/execmem.c

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 2c7651a2d84c..3282f304f6b1 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -16,50 +16,12 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/gfp.h>
-#include <linux/execmem.h>
 
 #include <asm/sections.h>
 #include <asm/smp_plat.h>
 #include <asm/unwind.h>
 #include <asm/opcodes.h>
 
-#ifdef CONFIG_XIP_KERNEL
-/*
- * The XIP kernel text is mapped in the module area for modules and
- * some other stuff to work without any indirect relocations.
- * MODULES_VADDR is redefined here and not in asm/memory.h to avoid
- * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
- */
-#undef MODULES_VADDR
-#define MODULES_VADDR	(((unsigned long)_exiprom + ~PMD_MASK) & PMD_MASK)
-#endif
-
-#ifdef CONFIG_MMU
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.start = MODULES_VADDR,
-			.end = MODULES_END,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	struct execmem_range *r = &execmem_params.ranges[EXECMEM_DEFAULT];
-
-	r->pgprot = PAGE_KERNEL_EXEC;
-
-	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS)) {
-		r->fallback_start = VMALLOC_START;
-		r->fallback_end = VMALLOC_END;
-	}
-
-	return &execmem_params;
-}
-#endif
-
 bool module_init_section(const char *name)
 {
 	return strstarts(name, ".init") ||
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index a42e4cd11db2..c0b536e398b4 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -22,6 +22,7 @@
 #include <linux/sizes.h>
 #include <linux/stop_machine.h>
 #include <linux/swiotlb.h>
+#include <linux/execmem.h>
 
 #include <asm/cp15.h>
 #include <asm/mach-types.h>
@@ -486,3 +487,40 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 	free_reserved_area((void *)start, (void *)end, -1, "initrd");
 }
 #endif
+
+#ifdef CONFIG_XIP_KERNEL
+/*
+ * The XIP kernel text is mapped in the module area for modules and
+ * some other stuff to work without any indirect relocations.
+ * MODULES_VADDR is redefined here and not in asm/memory.h to avoid
+ * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
+ */
+#undef MODULES_VADDR
+#define MODULES_VADDR	(((unsigned long)_exiprom + ~PMD_MASK) & PMD_MASK)
+#endif
+
+#if defined(CONFIG_MMU) && defined(CONFIG_EXECMEM)
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.start = MODULES_VADDR,
+			.end = MODULES_END,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	struct execmem_range *r = &execmem_params.ranges[EXECMEM_DEFAULT];
+
+	r->pgprot = PAGE_KERNEL_EXEC;
+
+	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS)) {
+		r->fallback_start = VMALLOC_START;
+		r->fallback_end = VMALLOC_END;
+	}
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index d27db168d2a2..eb1505128b75 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -20,142 +20,12 @@
 #include <linux/random.h>
 #include <linux/scs.h>
 #include <linux/vmalloc.h>
-#include <linux/execmem.h>
 
 #include <asm/alternative.h>
 #include <asm/insn.h>
 #include <asm/scs.h>
 #include <asm/sections.h>
 
-static u64 module_direct_base __ro_after_init = 0;
-static u64 module_plt_base __ro_after_init = 0;
-
-/*
- * Choose a random page-aligned base address for a window of 'size' bytes which
- * entirely contains the interval [start, end - 1].
- */
-static u64 __init random_bounding_box(u64 size, u64 start, u64 end)
-{
-	u64 max_pgoff, pgoff;
-
-	if ((end - start) >= size)
-		return 0;
-
-	max_pgoff = (size - (end - start)) / PAGE_SIZE;
-	pgoff = get_random_u32_inclusive(0, max_pgoff);
-
-	return start - pgoff * PAGE_SIZE;
-}
-
-/*
- * Modules may directly reference data and text anywhere within the kernel
- * image and other modules. References using PREL32 relocations have a +/-2G
- * range, and so we need to ensure that the entire kernel image and all modules
- * fall within a 2G window such that these are always within range.
- *
- * Modules may directly branch to functions and code within the kernel text,
- * and to functions and code within other modules. These branches will use
- * CALL26/JUMP26 relocations with a +/-128M range. Without PLTs, we must ensure
- * that the entire kernel text and all module text falls within a 128M window
- * such that these are always within range. With PLTs, we can expand this to a
- * 2G window.
- *
- * We chose the 128M region to surround the entire kernel image (rather than
- * just the text) as using the same bounds for the 128M and 2G regions ensures
- * by construction that we never select a 128M region that is not a subset of
- * the 2G region. For very large and unusual kernel configurations this means
- * we may fall back to PLTs where they could have been avoided, but this keeps
- * the logic significantly simpler.
- */
-static int __init module_init_limits(void)
-{
-	u64 kernel_end = (u64)_end;
-	u64 kernel_start = (u64)_text;
-	u64 kernel_size = kernel_end - kernel_start;
-
-	/*
-	 * The default modules region is placed immediately below the kernel
-	 * image, and is large enough to use the full 2G relocation range.
-	 */
-	BUILD_BUG_ON(KIMAGE_VADDR != MODULES_END);
-	BUILD_BUG_ON(MODULES_VSIZE < SZ_2G);
-
-	if (!kaslr_enabled()) {
-		if (kernel_size < SZ_128M)
-			module_direct_base = kernel_end - SZ_128M;
-		if (kernel_size < SZ_2G)
-			module_plt_base = kernel_end - SZ_2G;
-	} else {
-		u64 min = kernel_start;
-		u64 max = kernel_end;
-
-		if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
-			pr_info("2G module region forced by RANDOMIZE_MODULE_REGION_FULL\n");
-		} else {
-			module_direct_base = random_bounding_box(SZ_128M, min, max);
-			if (module_direct_base) {
-				min = module_direct_base;
-				max = module_direct_base + SZ_128M;
-			}
-		}
-
-		module_plt_base = random_bounding_box(SZ_2G, min, max);
-	}
-
-	pr_info("%llu pages in range for non-PLT usage",
-		module_direct_base ? (SZ_128M - kernel_size) / PAGE_SIZE : 0);
-	pr_info("%llu pages in range for PLT usage",
-		module_plt_base ? (SZ_2G - kernel_size) / PAGE_SIZE : 0);
-
-	return 0;
-}
-
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.flags = EXECMEM_KASAN_SHADOW,
-			.alignment = MODULE_ALIGN,
-		},
-		[EXECMEM_KPROBES] = {
-			.start = VMALLOC_START,
-			.end = VMALLOC_END,
-			.alignment = 1,
-		},
-		[EXECMEM_BPF] = {
-			.start = VMALLOC_START,
-			.end = VMALLOC_END,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	struct execmem_range *r = &execmem_params.ranges[EXECMEM_DEFAULT];
-
-	module_init_limits();
-
-	r->pgprot = PAGE_KERNEL;
-
-	if (module_direct_base) {
-		r->start = module_direct_base;
-		r->end = module_direct_base + SZ_128M;
-
-		if (module_plt_base) {
-			r->fallback_start = module_plt_base;
-			r->fallback_end = module_plt_base + SZ_2G;
-		}
-	} else if (module_plt_base) {
-		r->start = module_plt_base;
-		r->end = module_plt_base + SZ_2G;
-	}
-
-	execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
-	execmem_params.ranges[EXECMEM_BPF].pgprot = PAGE_KERNEL;
-
-	return &execmem_params;
-}
-
 enum aarch64_reloc_op {
 	RELOC_OP_NONE,
 	RELOC_OP_ABS,
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8a0f8604348b..9b7716b4d84c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -31,6 +31,7 @@
 #include <linux/hugetlb.h>
 #include <linux/acpi_iort.h>
 #include <linux/kmemleak.h>
+#include <linux/execmem.h>
 
 #include <asm/boot.h>
 #include <asm/fixmap.h>
@@ -547,3 +548,134 @@ void dump_mem_limit(void)
 		pr_emerg("Memory Limit: none\n");
 	}
 }
+
+#ifdef CONFIG_EXECMEM
+static u64 module_direct_base __ro_after_init = 0;
+static u64 module_plt_base __ro_after_init = 0;
+
+/*
+ * Choose a random page-aligned base address for a window of 'size' bytes which
+ * entirely contains the interval [start, end - 1].
+ */
+static u64 __init random_bounding_box(u64 size, u64 start, u64 end)
+{
+	u64 max_pgoff, pgoff;
+
+	if ((end - start) >= size)
+		return 0;
+
+	max_pgoff = (size - (end - start)) / PAGE_SIZE;
+	pgoff = get_random_u32_inclusive(0, max_pgoff);
+
+	return start - pgoff * PAGE_SIZE;
+}
+
+/*
+ * Modules may directly reference data and text anywhere within the kernel
+ * image and other modules. References using PREL32 relocations have a +/-2G
+ * range, and so we need to ensure that the entire kernel image and all modules
+ * fall within a 2G window such that these are always within range.
+ *
+ * Modules may directly branch to functions and code within the kernel text,
+ * and to functions and code within other modules. These branches will use
+ * CALL26/JUMP26 relocations with a +/-128M range. Without PLTs, we must ensure
+ * that the entire kernel text and all module text falls within a 128M window
+ * such that these are always within range. With PLTs, we can expand this to a
+ * 2G window.
+ *
+ * We chose the 128M region to surround the entire kernel image (rather than
+ * just the text) as using the same bounds for the 128M and 2G regions ensures
+ * by construction that we never select a 128M region that is not a subset of
+ * the 2G region. For very large and unusual kernel configurations this means
+ * we may fall back to PLTs where they could have been avoided, but this keeps
+ * the logic significantly simpler.
+ */
+static int __init module_init_limits(void)
+{
+	u64 kernel_end = (u64)_end;
+	u64 kernel_start = (u64)_text;
+	u64 kernel_size = kernel_end - kernel_start;
+
+	/*
+	 * The default modules region is placed immediately below the kernel
+	 * image, and is large enough to use the full 2G relocation range.
+	 */
+	BUILD_BUG_ON(KIMAGE_VADDR != MODULES_END);
+	BUILD_BUG_ON(MODULES_VSIZE < SZ_2G);
+
+	if (!kaslr_enabled()) {
+		if (kernel_size < SZ_128M)
+			module_direct_base = kernel_end - SZ_128M;
+		if (kernel_size < SZ_2G)
+			module_plt_base = kernel_end - SZ_2G;
+	} else {
+		u64 min = kernel_start;
+		u64 max = kernel_end;
+
+		if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
+			pr_info("2G module region forced by RANDOMIZE_MODULE_REGION_FULL\n");
+		} else {
+			module_direct_base = random_bounding_box(SZ_128M, min, max);
+			if (module_direct_base) {
+				min = module_direct_base;
+				max = module_direct_base + SZ_128M;
+			}
+		}
+
+		module_plt_base = random_bounding_box(SZ_2G, min, max);
+	}
+
+	pr_info("%llu pages in range for non-PLT usage",
+		module_direct_base ? (SZ_128M - kernel_size) / PAGE_SIZE : 0);
+	pr_info("%llu pages in range for PLT usage",
+		module_plt_base ? (SZ_2G - kernel_size) / PAGE_SIZE : 0);
+
+	return 0;
+}
+
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.flags = EXECMEM_KASAN_SHADOW,
+			.alignment = MODULE_ALIGN,
+		},
+		[EXECMEM_KPROBES] = {
+			.start = VMALLOC_START,
+			.end = VMALLOC_END,
+			.alignment = 1,
+		},
+		[EXECMEM_BPF] = {
+			.start = VMALLOC_START,
+			.end = VMALLOC_END,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	struct execmem_range *r = &execmem_params.ranges[EXECMEM_DEFAULT];
+
+	module_init_limits();
+
+	r->pgprot = PAGE_KERNEL;
+
+	if (module_direct_base) {
+		r->start = module_direct_base;
+		r->end = module_direct_base + SZ_128M;
+
+		if (module_plt_base) {
+			r->fallback_start = module_plt_base;
+			r->fallback_end = module_plt_base + SZ_2G;
+		}
+	} else if (module_plt_base) {
+		r->start = module_plt_base;
+		r->end = module_plt_base + SZ_2G;
+	}
+
+	execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
+	execmem_params.ranges[EXECMEM_BPF].pgprot = PAGE_KERNEL;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index a1d8fe9796fa..181b5f8b09f1 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -18,7 +18,6 @@
 #include <linux/ftrace.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/execmem.h>
 #include <asm/alternative.h>
 #include <asm/inst.h>
 
@@ -470,23 +469,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.pgprot = PAGE_KERNEL,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	execmem_params.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
-	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
-
-	return &execmem_params;
-}
-
 static void module_init_ftrace_plt(const Elf_Ehdr *hdr,
 				   const Elf_Shdr *sechdrs, struct module *mod)
 {
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index f3fe8c06ba4d..26b10a51309c 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -24,6 +24,7 @@
 #include <linux/gfp.h>
 #include <linux/hugetlb.h>
 #include <linux/mmzone.h>
+#include <linux/execmem.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/bootinfo.h>
@@ -247,3 +248,22 @@ EXPORT_SYMBOL(invalid_pmd_table);
 #endif
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
 EXPORT_SYMBOL(invalid_pte_table);
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.pgprot = PAGE_KERNEL,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	execmem_params.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
+	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 1c959074b35f..ebf9496f5db0 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -33,25 +33,6 @@ struct mips_hi16 {
 static LIST_HEAD(dbe_list);
 static DEFINE_SPINLOCK(dbe_lock);
 
-#ifdef MODULE_START
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.start = MODULE_START,
-			.end = MODULE_END,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	execmem_params.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
-
-	return &execmem_params;
-}
-#endif
-
 static void apply_r_mips_32(u32 *location, u32 base, Elf_Addr v)
 {
 	*location = base + v;
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 5dcb525a8995..55e7869d03f2 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -31,6 +31,7 @@
 #include <linux/gfp.h>
 #include <linux/kcore.h>
 #include <linux/initrd.h>
+#include <linux/execmem.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cachectl.h>
@@ -573,3 +574,22 @@ EXPORT_SYMBOL_GPL(invalid_pmd_table);
 #endif
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
 EXPORT_SYMBOL(invalid_pte_table);
+
+#if defined(CONFIG_EXECMEM) && defined(MODULE_START)
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.start = MODULE_START,
+			.end = MODULE_END,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	execmem_params.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
index 0c6dfd1daef3..fecd2760b7a6 100644
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -174,23 +174,6 @@ static inline int reassemble_22(int as22)
 		((as22 & 0x0003ff) << 3));
 }
 
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.pgprot = PAGE_KERNEL_RWX,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	execmem_params.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
-	execmem_params.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
-
-	return &execmem_params;
-}
-
 #ifndef CONFIG_64BIT
 static inline unsigned long count_gots(const Elf_Rela *rela, unsigned long n)
 {
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index a088c243edea..c87fed38e38e 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -24,6 +24,7 @@
 #include <linux/nodemask.h>	/* for node_online_map */
 #include <linux/pagemap.h>	/* for release_pages */
 #include <linux/compat.h>
+#include <linux/execmem.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -479,7 +480,7 @@ void free_initmem(void)
 	/* finally dump all the instructions which were cached, since the
 	 * pages are no-longer executable */
 	flush_icache_range(init_begin, init_end);
-	
+
 	free_initmem_default(POISON_FREE_INITMEM);
 
 	/* set up a new led state on systems shipped LED State panel */
@@ -919,3 +920,22 @@ static const pgprot_t protection_map[16] = {
 	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_RWX
 };
 DECLARE_VM_GET_PAGE_PROT
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.pgprot = PAGE_KERNEL_RWX,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	execmem_params.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
+	execmem_params.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index bf2c62aef628..b30e00964a60 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -10,7 +10,6 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/bug.h>
-#include <linux/execmem.h>
 #include <asm/module.h>
 #include <linux/uaccess.h>
 #include <asm/firmware.h>
@@ -89,62 +88,3 @@ int module_finalize(const Elf_Ehdr *hdr,
 
 	return 0;
 }
-
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.alignment = 1,
-		},
-		[EXECMEM_KPROBES] = {
-			.alignment = 1,
-		},
-		[EXECMEM_MODULE_DATA] = {
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
-	struct execmem_range *range = &execmem_params.ranges[EXECMEM_DEFAULT];
-
-	/*
-	 * BOOK3S_32 and 8xx define MODULES_VADDR for text allocations and
-	 * allow allocating data in the entire vmalloc space
-	 */
-#ifdef MODULES_VADDR
-	struct execmem_range *data = &execmem_params.ranges[EXECMEM_MODULE_DATA];
-	unsigned long limit = (unsigned long)_etext - SZ_32M;
-
-	/* First try within 32M limit from _etext to avoid branch trampolines */
-	if (MODULES_VADDR < PAGE_OFFSET && MODULES_END > limit) {
-		range->start = limit;
-		range->end = MODULES_END;
-		range->fallback_start = MODULES_VADDR;
-		range->fallback_end = MODULES_END;
-	} else {
-		range->start = MODULES_VADDR;
-		range->end = MODULES_END;
-	}
-	data->start = VMALLOC_START;
-	data->end = VMALLOC_END;
-	data->pgprot = PAGE_KERNEL;
-	data->alignment = 1;
-#else
-	range->start = VMALLOC_START;
-	range->end = VMALLOC_END;
-#endif
-
-	range->pgprot = prot;
-
-	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
-	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_END;
-
-	if (strict_module_rwx_enabled())
-		execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
-	else
-		execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_EXEC;
-
-	return &execmem_params;
-}
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 8b121df7b08f..06f4bb6fb780 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -16,6 +16,7 @@
 #include <linux/highmem.h>
 #include <linux/suspend.h>
 #include <linux/dma-direct.h>
+#include <linux/execmem.h>
 
 #include <asm/swiotlb.h>
 #include <asm/machdep.h>
@@ -406,3 +407,64 @@ int devmem_is_allowed(unsigned long pfn)
  * the EHEA driver. Drop this when drivers/net/ethernet/ibm/ehea is removed.
  */
 EXPORT_SYMBOL_GPL(walk_system_ram_range);
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.alignment = 1,
+		},
+		[EXECMEM_KPROBES] = {
+			.alignment = 1,
+		},
+		[EXECMEM_MODULE_DATA] = {
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
+	struct execmem_range *range = &execmem_params.ranges[EXECMEM_DEFAULT];
+
+	/*
+	 * BOOK3S_32 and 8xx define MODULES_VADDR for text allocations and
+	 * allow allocating data in the entire vmalloc space
+	 */
+#ifdef MODULES_VADDR
+	struct execmem_range *data = &execmem_params.ranges[EXECMEM_MODULE_DATA];
+	unsigned long limit = (unsigned long)_etext - SZ_32M;
+
+	/* First try within 32M limit from _etext to avoid branch trampolines */
+	if (MODULES_VADDR < PAGE_OFFSET && MODULES_END > limit) {
+		range->start = limit;
+		range->end = MODULES_END;
+		range->fallback_start = MODULES_VADDR;
+		range->fallback_end = MODULES_END;
+	} else {
+		range->start = MODULES_VADDR;
+		range->end = MODULES_END;
+	}
+	data->start = VMALLOC_START;
+	data->end = VMALLOC_END;
+	data->pgprot = PAGE_KERNEL;
+	data->alignment = 1;
+#else
+	range->start = VMALLOC_START;
+	range->end = VMALLOC_END;
+#endif
+
+	range->pgprot = prot;
+
+	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
+	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_END;
+
+	if (strict_module_rwx_enabled())
+		execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
+	else
+		execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_EXEC;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 31505ecb5c72..8af08d5449bf 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -11,7 +11,6 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/pgtable.h>
-#include <linux/execmem.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
 
@@ -436,44 +435,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
-#ifdef CONFIG_MMU
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.pgprot = PAGE_KERNEL,
-			.alignment = 1,
-		},
-		[EXECMEM_KPROBES] = {
-			.pgprot = PAGE_KERNEL_READ_EXEC,
-			.alignment = 1,
-		},
-		[EXECMEM_BPF] = {
-			.pgprot = PAGE_KERNEL,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-#ifdef CONFIG_64BIT
-	execmem_params.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
-	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
-#else
-	execmem_params.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
-	execmem_params.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
-#endif
-
-	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
-	execmem_params.ranges[EXECMEM_KPROBES].end = VMALLOC_END;
-
-	execmem_params.ranges[EXECMEM_BPF].start = BPF_JIT_REGION_START;
-	execmem_params.ranges[EXECMEM_BPF].end = BPF_JIT_REGION_END;
-
-	return &execmem_params;
-}
-#endif
-
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0798bd861dcb..b0f7848f39e3 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -24,6 +24,7 @@
 #include <linux/elf.h>
 #endif
 #include <linux/kfence.h>
+#include <linux/execmem.h>
 
 #include <asm/fixmap.h>
 #include <asm/io.h>
@@ -1564,3 +1565,41 @@ void __init pgtable_cache_init(void)
 		preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules");
 }
 #endif
+
+#if defined(CONFIG_MMU) && defined(CONFIG_EXECMEM)
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.pgprot = PAGE_KERNEL,
+			.alignment = 1,
+		},
+		[EXECMEM_KPROBES] = {
+			.pgprot = PAGE_KERNEL_READ_EXEC,
+			.alignment = 1,
+		},
+		[EXECMEM_BPF] = {
+			.pgprot = PAGE_KERNEL,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+#ifdef CONFIG_64BIT
+	execmem_params.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
+	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+#else
+	execmem_params.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
+	execmem_params.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
+#endif
+
+	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
+	execmem_params.ranges[EXECMEM_KPROBES].end = VMALLOC_END;
+
+	execmem_params.ranges[EXECMEM_BPF].start = BPF_JIT_REGION_START;
+	execmem_params.ranges[EXECMEM_BPF].end = BPF_JIT_REGION_END;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 538d5f24af66..81a8d92ca092 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -37,31 +37,6 @@
 
 #define PLT_ENTRY_SIZE 22
 
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.flags = EXECMEM_KASAN_SHADOW,
-			.alignment = MODULE_ALIGN,
-			.pgprot = PAGE_KERNEL,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	unsigned long module_load_offset = 0;
-	unsigned long start;
-
-	if (kaslr_enabled())
-		module_load_offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
-
-	start = MODULES_VADDR + module_load_offset;
-	execmem_params.ranges[EXECMEM_DEFAULT].start = start;
-	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
-
-	return &execmem_params;
-}
-
 #ifdef CONFIG_FUNCTION_TRACER
 void module_arch_cleanup(struct module *mod)
 {
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 8b94d2212d33..2e6d6512fc5f 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -34,6 +34,7 @@
 #include <linux/percpu.h>
 #include <asm/processor.h>
 #include <linux/uaccess.h>
+#include <linux/execmem.h>
 #include <asm/pgalloc.h>
 #include <asm/kfence.h>
 #include <asm/ptdump.h>
@@ -311,3 +312,30 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 	vmem_remove_mapping(start, size);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.flags = EXECMEM_KASAN_SHADOW,
+			.alignment = MODULE_ALIGN,
+			.pgprot = PAGE_KERNEL,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	unsigned long module_load_offset = 0;
+	unsigned long start;
+
+	if (kaslr_enabled())
+		module_load_offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
+
+	start = MODULES_VADDR + module_load_offset;
+	execmem_params.ranges[EXECMEM_DEFAULT].start = start;
+	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index 1d8d1fba95b9..dff1d85ba202 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -14,7 +14,6 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/mm.h>
-#include <linux/execmem.h>
 #ifdef CONFIG_SPARC64
 #include <linux/jump_label.h>
 #endif
@@ -25,28 +24,6 @@
 
 #include "entry.h"
 
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-#ifdef CONFIG_SPARC64
-			.start = MODULES_VADDR,
-			.end = MODULES_END,
-#else
-			.start = VMALLOC_START,
-			.end = VMALLOC_END,
-#endif
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	execmem_params.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
-
-	return &execmem_params;
-}
-
 /* Make generic code ignore STT_REGISTER dummy undefined symbols.  */
 int module_frob_arch_sections(Elf_Ehdr *hdr,
 			      Elf_Shdr *sechdrs,
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index 871354aa3c00..87e2cf7efb5b 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -15,3 +15,5 @@ obj-$(CONFIG_SPARC32)   += leon_mm.o
 
 # Only used by sparc64
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
+
+obj-$(CONFIG_EXECMEM) += execmem.o
diff --git a/arch/sparc/mm/execmem.c b/arch/sparc/mm/execmem.c
new file mode 100644
index 000000000000..fb53a859869a
--- /dev/null
+++ b/arch/sparc/mm/execmem.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/execmem.h>
+
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+#ifdef CONFIG_SPARC64
+			.start = MODULES_VADDR,
+			.end = MODULES_END,
+#else
+			.start = VMALLOC_START,
+			.end = VMALLOC_END,
+#endif
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	execmem_params.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
+
+	return &execmem_params;
+}
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 9d37375e2f05..c52d591c0f3f 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -19,7 +19,6 @@
 #include <linux/jump_label.h>
 #include <linux/random.h>
 #include <linux/memory.h>
-#include <linux/execmem.h>
 
 #include <asm/text-patching.h>
 #include <asm/page.h>
@@ -37,32 +36,6 @@ do {							\
 } while (0)
 #endif
 
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.flags = EXECMEM_KASAN_SHADOW,
-			.alignment = MODULE_ALIGN,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	unsigned long module_load_offset = 0;
-	unsigned long start;
-
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_enabled())
-		module_load_offset =
-			get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
-
-	start = MODULES_VADDR + module_load_offset;
-	execmem_params.ranges[EXECMEM_DEFAULT].start = start;
-	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
-	execmem_params.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
-
-	return &execmem_params;
-}
-
 #ifdef CONFIG_X86_32
 int apply_relocate(Elf32_Shdr *sechdrs,
 		   const char *strtab,
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..022af7ab50f9 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -7,6 +7,7 @@
 #include <linux/swapops.h>
 #include <linux/kmemleak.h>
 #include <linux/sched/task.h>
+#include <linux/execmem.h>
 
 #include <asm/set_memory.h>
 #include <asm/cpu_device_id.h>
@@ -1099,3 +1100,31 @@ unsigned long arch_max_swapfile_size(void)
 	return pages;
 }
 #endif
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.flags = EXECMEM_KASAN_SHADOW,
+			.alignment = MODULE_ALIGN,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	unsigned long module_load_offset = 0;
+	unsigned long start;
+
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_enabled())
+		module_load_offset =
+			get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
+
+	start = MODULES_VADDR + module_load_offset;
+	execmem_params.ranges[EXECMEM_DEFAULT].start = start;
+	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+	execmem_params.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
+
+	return &execmem_params;
+}
+#endif /* CONFIG_EXECMEM */
-- 
2.39.2


