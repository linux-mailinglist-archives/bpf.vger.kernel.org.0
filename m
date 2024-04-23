Return-Path: <bpf+bounces-27562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD2F8AEA1E
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B586128859F
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CCB13BAF6;
	Tue, 23 Apr 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="Uc/RzSzo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6005313BAC4;
	Tue, 23 Apr 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884667; cv=none; b=cpicn/j6QC+ge5qsroS9qIaHuvgccLz7zEK+v+bWRRVdHz18ynn3YUH24wSTjXb3LyJv8dV4uCbdZo27/qv6Iakh+yTexVJTKjN4UPN4hIR1L0h1XPgkMF8ZqXn+pVmg86xmqjFAbanAv6HSWWLJVh9JBaBWHRSaYhnAXAfoGf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884667; c=relaxed/simple;
	bh=l20GwSFUwRQdY2wHbcLyXqtPtBQuZWNOumpy70qsdsM=;
	h=Message-Id:In-Reply-To:References:To:Cc:From:Date:Subject; b=aseqR0e4ImwoXfxYR8wQWBL+i+potSNl4bGMWwU7PO18Vhn00C02EI43FjZHv+IpUk30FQlrLGV84Bkxn9iugRRGBTyb7Z6DfQ0C4mw9IT64SdzbqnW7ljmW2Z7VUtrb/OrXh42oMoiKBf7eE+Ej2Ng4CLuH0vcBuZg0tIKmIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=fail (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=Uc/RzSzo reason="signature verification failed"; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355091.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NCmKBZ012995;
	Tue, 23 Apr 2024 15:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	message-id:in-reply-to:references:to:cc:from:date:subject; s=
	DKIM202306; bh=GIKeanzws0uXUY8MAbjvAxsIueEiAksuJ68TlOLinGk=; b=U
	c/RzSzoLj5brix2Fi6t5TeVNcBOotlK4l9fO+DIjdkHga4nGCB5ckKwRuNbdCybJ
	IwzjIl1VLRFV+2h5w6463fRQjyqdCPAc1LmqSxfPYPqC+ZorE3j4mlDJnoUX80Wk
	BSnEJKhsJSIp/Et4pwbsxHFo9nv1osEX3P98SZKxwKGB388BN+3AGpzh5QmX+O6S
	lillH4WhO33pDNnjArANCVL1EELF6+9cZ6UfRPlEiWT20aMEfo0ONt1vx2v4dBxK
	oMHzHbjdPQcVE546hfa7gMA9HdxjYL0swkaasqpObF75fE8HSLt3Y8Xh/0F0GfPL
	UdzW+bNvRm5gKaqP/38Nw==
Received: from ilclpfpp01.lenovo.com ([144.188.128.67])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3xntmga58d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 15:03:21 +0000 (GMT)
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4VP53D6vmPzdDsy;
	Tue, 23 Apr 2024 15:03:20 +0000 (UTC)
Received: from ilclasset02.mot.com (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4VP53D6glWz3n3fs;
	Tue, 23 Apr 2024 15:03:20 +0000 (UTC)
Message-Id: <20240423095843.446565600-2-mbland@motorola.com>
In-Reply-To: <20240423095843.446565600-1-mbland@motorola.com>
References: <20240423095843.446565600-1-mbland@motorola.com>
To: linux-mm@kvack.org
Cc: "Maxwell Bland <mbland@motorola.com>
	Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
From: Maxwell Bland <mbland@motorola.com>
Date: Tue, 23 Apr 2024 09:58:43 -0500
Subject: [PATCH v4 2/2] arm64: mm: code and data allocation partitioning
X-Proofpoint-GUID: 7vcgolXa4nZUkhHiyhEHc-GzFJs35PXe
X-Proofpoint-ORIG-GUID: 7vcgolXa4nZUkhHiyhEHc-GzFJs35PXe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230036
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Use the vmalloc infrastructure to prevent interleaving code and data
pages, working to both maintain compatible management assumptions made
by non-arch-specific code and make management of these regions more
precise.

This will allow, for example, the maintenance of PXNTable bits on
dynamically allocated memory or the immutability of certain page middle
directory and higher level descriptors.

For this purpose, move module_init_limits to setup.c, a more appropriate
place since it is an initialization routine, and as a result, move
module_plt_base and module_direct_base to module.h and provide
appropriate "getter" methods.

Make the two existing code allocation calls for BPF and kprobes use the
modules memory region, ensuring they no longer pollute data memory.

This will make code ensuring the self-patching interface cannot be used
to modify data and data interfaces cannot be used to modify code more
performant.

Add in a mm/vmalloc.c file to perform the appropriate vmalloc_init
callbacks required to ensure segmentation of the virtual memory space.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
Hello,

Thanks for your review this patch. The ultimate goal, enforcement of
dynamic PXNTable, is present in v3:
v3: 20240416122254.868007168-1-mbland@motorola.com
But is not included here as we first need to make an infrastructural
change in order to address the comments given on v2/v1:
v2: 20240220203256.31153-1-mbland@motorola.com
v1: CAP5Mv+ydhk=Ob4b40ZahGMgT-5+-VEHxtmA=-LkJiEOOU+K6hw@mail.gmail.com

Regards,
Maxwell Bland

 arch/arm64/include/asm/module.h    | 16 ++++++
 arch/arm64/include/asm/setup.h     |  2 +
 arch/arm64/include/asm/vmalloc.h   |  3 ++
 arch/arm64/kernel/module.c         | 85 +-----------------------------
 arch/arm64/kernel/probes/kprobes.c |  7 +--
 arch/arm64/kernel/setup.c          | 82 ++++++++++++++++++++++++++++
 arch/arm64/mm/Makefile             |  3 +-
 arch/arm64/mm/vmalloc.c            | 10 ++++
 arch/arm64/net/bpf_jit_comp.c      |  8 +--
 9 files changed, 125 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm64/mm/vmalloc.c

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 79550b22ba19..732507896d3f 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -65,4 +65,20 @@ static inline const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
 	return NULL;
 }
 
+static u64 module_direct_base __ro_after_init;
+static u64 module_plt_base __ro_after_init;
+
+static inline u64 get_modules_base(void)
+{
+	return (module_plt_base) ? module_plt_base : module_direct_base;
+}
+
+static inline u64 get_modules_end(void)
+{
+	return (module_plt_base) ? module_plt_base + SZ_2G :
+		module_direct_base + SZ_128M;
+}
+
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
index 47e0be610bb6..5a6a8ab62046 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -25,90 +25,7 @@
 #include <asm/insn.h>
 #include <asm/scs.h>
 #include <asm/sections.h>
-
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
-subsys_initcall(module_init_limits);
+#include <asm/module.h>
 
 void *module_alloc(unsigned long size)
 {
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 327855a11df2..e1b5d509a6ab 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -131,9 +131,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 
 void *alloc_insn_page(void)
 {
-	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
-			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
-			NUMA_NO_NODE, __builtin_return_address(0));
+	return __vmalloc_node_range(PAGE_SIZE, 1, get_modules_base(),
+			get_modules_end(), GFP_KERNEL, PAGE_KERNEL_ROX,
+			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
+			__builtin_return_address(0));
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
 obj-y				:= dma-mapping.o extable.o fault.o init.o  				   cache.o copypage.o flush.o  				   ioremap.o mmap.o pgd.o mmu.o -				   context.o proc.o pageattr.o fixmap.o
+				   context.o proc.o pageattr.o fixmap.o +				   vmalloc.o
 obj-	+= contpte.o
 obj-	+= hugetlbpage.o
 obj-	+= ptdump.o
diff --git a/arch/arm64/mm/vmalloc.c b/arch/arm64/mm/vmalloc.c
new file mode 100644
index 000000000000..09f59c493fe4
--- /dev/null
+++ b/arch/arm64/mm/vmalloc.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/vmalloc.h>
+#include <linux/elf.h>
+
+#include <asm/module.h>
+
+inline void __init arch_init_checked_vmap_ranges(void)
+{
+	create_vmalloc_range_check(get_modules_base(), get_modules_end());
+}
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 122021f9bdfc..30366c4e0b1e 100644
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
@@ -1790,18 +1792,18 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 
 u64 bpf_jit_alloc_exec_limit(void)
 {
-	return VMALLOC_END - VMALLOC_START;
+	return get_modules_end() - get_modules_base();
 }
 
 void *bpf_jit_alloc_exec(unsigned long size)
 {
 	/* Memory is intended to be executable, reset the pointer tag. */
-	return kasan_reset_tag(vmalloc(size));
+	return kasan_reset_tag(module_alloc(size));
 }
 
 void bpf_jit_free_exec(void *addr)
 {
-	return vfree(addr);
+	return module_memfree(addr);
 }
 
 /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
-- 
2.34.1


