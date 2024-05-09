Return-Path: <bpf+bounces-29222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0128C14BE
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE56C1C21D16
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D657EEFD;
	Thu,  9 May 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="k9DViv9O"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8476029;
	Thu,  9 May 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279289; cv=none; b=Cla4ruLDZMvqtyK3W5eFCEw4vZJdE9xDv/GkgbpDsLdcyDFmFw7YJE8wbUURWA9YGhi+V0bp2f66yG5pREJsIQNT0mUmTgZzDLfjVKsSzNd9+LjnyjYGkIWQni65hfyDbcw5BjI8n5G2AQqmxC8nf8eGCySX1c4sfYiF3vIilQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279289; c=relaxed/simple;
	bh=IlWc5kzmii/OAVwq1OefdGFFy9QXmKn2WtkRPP3cYUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDN6HpG6wDTDGbjag3MAdMHPZfAE/wQs+l7BBNb8UzhWsMKDWl6VVP/YxXllcWD5dKkBxzoNMx+oZdj1sEZqLXsPxTMs8k1cW8cKYYGUkkuCLHsjaHKFGE0Niu9Pp5i6fDt1b+Nn06lacZ+CUyMYU1VL5thnJ4XmGEFa5e8PdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=k9DViv9O; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 449HUo4a004958;
	Thu, 9 May 2024 18:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=DKIM202306; bh=LL7xQG46CkOLkOPbkIzD
	btlKvVfJO8GEcQy4QcbGW6g=; b=k9DViv9OVV9lVqWGrJRDhudBD8s8FC3BxyCV
	/zYkSrKhDrNC2VDCTYSl40ET1JY1MiClf2da6ZAHgeEb3oVoZfokKakuo6tyr5qS
	y3Q8nb1x1O7WBHKn1LgCUO0AlD7rv6IEqKb285dOJmmZ0HgyujIY/Bt4KUNtRS8W
	HvrkYpNHrUhOU7dWrxT8UtCq/A72B5fVvA2vbOfmvWtVwd88QOfsvGowORigdA28
	cLHbkTvfdKSJj0EjmUrfs1U65xAAYfObHsBs5L2PkWXyhOwPMGd9Rlo10uJtZwIC
	FSP/xRTlIfr0KyMrsGc+5PqKq/Bt7CP7vQcF9F+jDuuIq4Tz8Q==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by m0355088.ppops.net (PPS) with ESMTPS id 3y12y285w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 18:27:20 +0000 (GMT)
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4Vb0qC4kkKz50cNM;
	Thu,  9 May 2024 18:27:19 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4Vb0qB5LYjz2VZRw;
	Thu,  9 May 2024 18:27:18 +0000 (UTC)
Date: Thu, 9 May 2024 13:27:17 -0500
From: Maxwell Bland <mbland@motorola.com>
To: linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Maxwell Bland <mbland@motorola.com>,
        Russell King <linux@armlinux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shaoqin Huang <shahuang@redhat.com>,
        Ryo Takakura <takakura@valinux.co.jp>,
        James Morse <james.morse@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH v5 2/2] arm64: mm: code and data allocation partitioning
Message-ID: <h4hxxozslqmqhwljg5sfold764242pmw5y77mdigaykw5ehjjs@nc4xtzw7xprm>
References: <ozcyvkcdqhxhlg3sjz3s4odt7ejiwx2cctgb7sdx6jbardui37@al6uvt4yx5nt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ozcyvkcdqhxhlg3sjz3s4odt7ejiwx2cctgb7sdx6jbardui37@al6uvt4yx5nt>
X-Proofpoint-ORIG-GUID: amt96-blFXufDRS6rUsU1cLTIYbcy2vE
X-Proofpoint-GUID: amt96-blFXufDRS6rUsU1cLTIYbcy2vE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_10,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090128

Introduce a new Kconfig ARM64_FORCE_CODE_PARTITIONING which uses new
vmalloc infrastructure to prevent interleaving code and data pages,
working to both maintain compatible management assumptions made by
non-arch-specific code and make management of these regions more
precise.

For now, it restricts the additional BPF allocations to +SZ_2G beyond
the modules region. This is assumed to be more than enough for cases
where enabling this config are acceptable.

This will allow, for example, the maintenance of PXNTable bits on
dynamically allocated memory or the immutability of certain page middle
directory and higher level descriptors.

For this purpose, move module_init_limits to setup.c, a more appropriate
place since it is an initialization routine, and as a result, move
module_plt_base and module_direct_base to module.h and provide
appropriate "getter" methods.

The two existing code allocation calls for BPF and kprobes now check
the CONFIG option on whether to allocate from the modules memory region,
ensuring they no longer pollute data memory. This ensures regression
compatibility with the decision to loosen allocation restrictions for
VM support from 1636131046-5982-2-git-send-email-alan.maguire@oracle.com

This will make code ensuring the self-patching interface cannot be used
to modify data and data interfaces cannot be used to modify code more
performant.

Add in a mm/vmalloc.c file to perform the appropriate vmalloc_init
callbacks required to ensure segmentation of the virtual memory space.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/Kconfig                 | 16 ++++++
 arch/arm64/include/asm/module.h    |  7 +++
 arch/arm64/include/asm/setup.h     |  2 +
 arch/arm64/include/asm/vmalloc.h   |  3 ++
 arch/arm64/kernel/module.c         | 85 +++---------------------------
 arch/arm64/kernel/probes/kprobes.c | 13 +++--
 arch/arm64/kernel/setup.c          | 82 ++++++++++++++++++++++++++++
 arch/arm64/mm/Makefile             |  3 +-
 arch/arm64/mm/vmalloc.c            | 12 +++++
 arch/arm64/net/bpf_jit_comp.c      | 20 ++++++-
 10 files changed, 160 insertions(+), 83 deletions(-)
 create mode 100644 arch/arm64/mm/vmalloc.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..8986e3133396 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1321,6 +1321,22 @@ config ARM64_VA_BITS_52
 
 endchoice
 
+config ARM64_FORCE_CODE_PARTITIONING
+	bool "Force the partitioning of code from vmalloc space"
+	default n
+	help
+	  Restricts the allocation of BPF programs and kprobe instruction
+	  pages such that they do not overlap with vmalloc region memory
+	  and are contained within module code region defined by
+	  module_init_limits + SZ_2G. Ensures other vmalloc data pages
+	  cannot be allocated within this region.
+
+	  This configuration option is incompatible with BPF and kprobe
+	  deployments which require more than 128MB (or 2GB, depending on PLT
+	  support) of memory, such as when hosting multiple VMs. Enabling this
+	  option ensures granular segregation of code from data pages in
+	  ARM64 architecture code. If unsure say N here.
+
 config ARM64_FORCE_52BIT
 	bool "Force 52-bit virtual addresses for userspace"
 	depends on ARM64_VA_BITS_52 && EXPERT
diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 79550b22ba19..c7a6497e6d5d 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -65,4 +65,11 @@ static inline const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
 	return NULL;
 }
 
+extern u64 module_direct_base __ro_after_init;
+extern u64 module_plt_base __ro_after_init;
+
+inline u64 get_modules_base(void);
+inline u64 get_modules_end(void);
+void *module_alloc(unsigned long size);
+
 #endif /* __ASM_MODULE_H */
diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index ba269a7a3201..4d1b668effc9 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -41,4 +41,6 @@ static inline bool arch_parse_debug_rodata(char *arg)
 }
 #define arch_parse_debug_rodata arch_parse_debug_rodata
 
+int __init module_init_limits(void);
+
 #endif
diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index 38fafffe699f..7d45c7d5b758 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -31,4 +31,7 @@ static inline pgprot_t arch_vmap_pgprot_tagged(pgprot_t prot)
 	return pgprot_tagged(prot);
 }
 
+#define arch_init_checked_vmap_ranges arch_init_checked_vmap_ranges
+inline void __init arch_init_checked_vmap_ranges(void);
+
 #endif /* _ASM_ARM64_VMALLOC_H */
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 47e0be610bb6..c64695f33d09 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -25,90 +25,21 @@
 #include <asm/insn.h>
 #include <asm/scs.h>
 #include <asm/sections.h>
+#include <asm/module.h>
 
-static u64 module_direct_base __ro_after_init = 0;
-static u64 module_plt_base __ro_after_init = 0;
+u64 module_direct_base __ro_after_init;
+u64 module_plt_base __ro_after_init;
 
-/*
- * Choose a random page-aligned base address for a window of 'size' bytes which
- * entirely contains the interval [start, end - 1].
- */
-static u64 __init random_bounding_box(u64 size, u64 start, u64 end)
+inline u64 get_modules_base(void)
 {
-	u64 max_pgoff, pgoff;
-
-	if ((end - start) >= size)
-		return 0;
-
-	max_pgoff = (size - (end - start)) / PAGE_SIZE;
-	pgoff = get_random_u32_inclusive(0, max_pgoff);
-
-	return start - pgoff * PAGE_SIZE;
+	return (module_plt_base) ? module_plt_base : module_direct_base;
 }
 
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
+inline u64 get_modules_end(void)
 {
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
+	return (module_plt_base) ? module_plt_base + SZ_2G :
+		module_direct_base + SZ_128M;
 }
-subsys_initcall(module_init_limits);
 
 void *module_alloc(unsigned long size)
 {
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 327855a11df2..e612419f695d 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -131,9 +131,16 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 
 void *alloc_insn_page(void)
 {
-	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
-			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
-			NUMA_NO_NODE, __builtin_return_address(0));
+	if (IS_ENABLED(CONFIG_ARCH_FORCE_CODE_PARTITIONING))
+		return __vmalloc_node_range(PAGE_SIZE, 1, get_modules_base(),
+				get_modules_end() + SZ_2G, GFP_KERNEL,
+				PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
+				NUMA_NO_NODE, __builtin_return_address(0));
+	else
+		return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
+				VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
+				VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
+				__builtin_return_address(0));
 }
 
 /* arm kprobe: install breakpoint in text */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 65a052bf741f..ad0712d4d682 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -268,6 +268,86 @@ static int __init reserve_memblock_reserved_regions(void)
 }
 arch_initcall(reserve_memblock_reserved_regions);
 
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
+int __init module_init_limits(void)
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
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
 u64 cpu_logical_map(unsigned int cpu)
@@ -366,6 +446,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 			"This indicates a broken bootloader or old kernel\n",
 			boot_args[1], boot_args[2], boot_args[3]);
 	}
+
+	module_init_limits();
 }
 
 static inline bool cpu_can_disable(unsigned int cpu)
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 60454256945b..6d164f5852c1 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -2,7 +2,8 @@
 obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   cache.o copypage.o flush.o \
 				   ioremap.o mmap.o pgd.o mmu.o \
-				   context.o proc.o pageattr.o fixmap.o
+				   context.o proc.o pageattr.o fixmap.o \
+				   vmalloc.o
 obj-$(CONFIG_ARM64_CONTPTE)	+= contpte.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE)	+= ptdump.o
diff --git a/arch/arm64/mm/vmalloc.c b/arch/arm64/mm/vmalloc.c
new file mode 100644
index 000000000000..59383f0b6ab2
--- /dev/null
+++ b/arch/arm64/mm/vmalloc.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/vmalloc.h>
+#include <linux/elf.h>
+
+#include <asm/module.h>
+
+inline void __init arch_init_checked_vmap_ranges(void)
+{
+	if (IS_ENABLED(CONFIG_ARM64_FORCE_CODE_PARTITIONING))
+		create_vmalloc_range_check(get_modules_base(),
+				get_modules_end() + SZ_2G);
+}
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 13eac43c632d..6a68bb37b9ff 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -13,6 +13,8 @@
 #include <linux/memory.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/moduleloader.h>
 
 #include <asm/asm-extable.h>
 #include <asm/byteorder.h>
@@ -1790,13 +1792,27 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 
 u64 bpf_jit_alloc_exec_limit(void)
 {
-	return VMALLOC_END - VMALLOC_START;
+	if (IS_ENABLED(CONFIG_ARM64_FORCE_CODE_PARTITIONING))
+		return get_modules_end() - get_modules_base() + SZ_2G;
+	else
+		return VMALLOC_END - VMALLOC_START;
 }
 
 void *bpf_jit_alloc_exec(unsigned long size)
 {
+	void *p = NULL;
+
+	if (IS_ENABLED(CONFIG_ARM64_FORCE_CODE_PARTITIONING)) {
+		p = __vmalloc_node_range(size, MODULE_ALIGN,
+				get_modules_base(), get_modules_end() + SZ_2G,
+				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
+				__builtin_return_address(0));
+	} else {
+		p = vmalloc(size);
+	}
+
 	/* Memory is intended to be executable, reset the pointer tag. */
-	return kasan_reset_tag(vmalloc(size));
+	return kasan_reset_tag(p);
 }
 
 void bpf_jit_free_exec(void *addr)
-- 
2.34.1



