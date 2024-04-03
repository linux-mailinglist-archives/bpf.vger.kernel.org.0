Return-Path: <bpf+bounces-26997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD88A7234
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 19:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422481C20FBC
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A011332A6;
	Tue, 16 Apr 2024 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="sw41Pz1c"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0ED1F956;
	Tue, 16 Apr 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288338; cv=none; b=lW3mQ1ytAgnN8Xo0f/p9qrjAA6FlJfDoFrj1rlmZUQesXdkoIqv8GhyE+38/w7iUbdCaESQspikaQinF7ikQpRFDrRIeAeDjqtW5wjSSAxz2pnGSA+r2P4rKtB2zHZiA/7n0LGMUhK8qQnnqYD5aQtUxhB8sXB4MRdyNC6r2ZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288338; c=relaxed/simple;
	bh=5A/wZwvAMjpCBh3rhO1cku9B/yboVsBZLlPIaX5Kru0=;
	h=Message-Id:In-Reply-To:References:To:Cc:From:Date:Subject; b=DPxzb5Rj0Wm5aAPgHpfib1m4n+LSozss7TCrwJQ2SSEX76bBYkj25ILnj4nf7PFPutgL7b8Z5P4C10muY4xheh4yPgG4y9GA+UIhVIgI92Tj3zoRsVvrGV59J6DJfbA95EsL/xNoR6Dck/oPio4YBW/QZvrkVwrZ8J7fLJyY4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=sw41Pz1c; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355085.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GEh0Zk006822;
	Tue, 16 Apr 2024 17:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	message-id:in-reply-to:references:to:cc:from:date:subject; s=
	DKIM202306; bh=WtpkOtfUVklTETlWsQkVzQfkRpaN5YigWXkv8+BPIYU=; b=s
	w41Pz1cA5VDn6mBbbiYwn9PX+cQjWhh9XdAvz2IOJX7TMz/0Sxn6N2jrLkdOKdYg
	/whIbQ8ivQ7viekFNKMrGyY9UqFud9GSPI7JYPrckgL+CJ26q4vezQdZVCeNROMb
	FMPWF5p9rQE7TYFBuFddPpFXAVsUEUhSIP8h2RlIYEzqSzMZ+jp38y+HHs6seeql
	aYk94e1mJinCaILLf6M4qs6ATWjPC+/2OB/qMzUD2mxOYZjRMCaSWfxu1kwHbkUM
	FC1R8PRkwUaAcDRVlRTTykk+8VlYvW8Ud/CN7bGBnURWVwBCZ5lLO9btQw/2hxjE
	qiDJ4vgvm7uZHhIhMdRRg==
Received: from va32lpfpp04.lenovo.com ([104.232.228.24])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3xhea8bv1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 17:24:58 +0000 (GMT)
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp04.lenovo.com (Postfix) with ESMTPS id 4VJrWs0vh7zj9hF;
	Tue, 16 Apr 2024 17:24:57 +0000 (UTC)
Received: from ilclbld243.mot.com (ilclbld243.mot.com [100.64.22.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4VJrWs0fdFz2VZS6;
	Tue, 16 Apr 2024 17:24:57 +0000 (UTC)
Message-Id: <20240416122254.868007168-3-mbland@motorola.com>
In-Reply-To: <20240416122254.868007168-1-mbland@motorola.com>
References: <20240416122254.868007168-1-mbland@motorola.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Maxwell Bland <mbland@motorola.com>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, Maxwell Bland <mbland@motorola.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, Baoquan He <bhe@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ryo Takakura <takakura@valinux.co.jp>,
        James Morse <james.morse@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, bpf@vger.kernel.org
From: Maxwell Bland <mbland@motorola.com>
Date: Wed, 3 Apr 2024 16:08:15 -0500
Subject: [PATCH 2/5] arm64: mm: code and data partitioning for aslr
X-Proofpoint-GUID: oSkwsmd8buYDKwvkDlsObdQxE94z6XCb
X-Proofpoint-ORIG-GUID: oSkwsmd8buYDKwvkDlsObdQxE94z6XCb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_14,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160108
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Uses hooks in the vmalloc infrastructure to prevent interleaving code
and data pages, working to both maintain compatible management
assumptions made by non-arch-specific code and make management of these
regions more precise and conformant, allowing, for example, the
maintenance of PXNTable bits on dynamically allocated memory or the
immutability of certain page middle directory and higher level
descriptors.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/include/asm/module.h    | 12 +++++
 arch/arm64/include/asm/vmalloc.h   | 17 ++++++-
 arch/arm64/kernel/Makefile         |  2 +-
 arch/arm64/kernel/module.c         |  7 ++-
 arch/arm64/kernel/probes/kprobes.c |  7 +--
 arch/arm64/kernel/setup.c          |  4 ++
 arch/arm64/kernel/vmalloc.c        | 71 ++++++++++++++++++++++++++++++
 arch/arm64/mm/ptdump.c             |  4 +-
 arch/arm64/net/bpf_jit_comp.c      |  8 ++--
 9 files changed, 117 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/kernel/vmalloc.c

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 79550b22ba19..e50d7a240ad7 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -65,4 +65,16 @@ static inline const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
 	return NULL;
 }
 
+extern u64 module_direct_base __ro_after_init;
+extern u64 module_plt_base __ro_after_init;
+
+int __init module_init_limits(void);
+
+#define MODULES_ASLR_START ((module_plt_base) ? module_plt_base : \
+		module_direct_base)
+#define MODULES_ASLR_END ((module_plt_base) ? module_plt_base + SZ_2G : \
+		module_direct_base + SZ_128M)
+
+void *module_alloc(unsigned long size);
+
 #endif /* __ASM_MODULE_H */
diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index 38fafffe699f..93f8f1e2b1ce 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -4,6 +4,9 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
+struct vmap_area;
+struct kmem_cache;
+
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 
 #define arch_vmap_pud_supported arch_vmap_pud_supported
@@ -23,7 +26,7 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
 	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
 }
 
-#endif
+#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 #define arch_vmap_pgprot_tagged arch_vmap_pgprot_tagged
 static inline pgprot_t arch_vmap_pgprot_tagged(pgprot_t prot)
@@ -31,4 +34,16 @@ static inline pgprot_t arch_vmap_pgprot_tagged(pgprot_t prot)
 	return pgprot_tagged(prot);
 }
 
+#ifdef CONFIG_RANDOMIZE_BASE
+
+#define arch_skip_va arch_skip_va
+inline bool arch_skip_va(struct vmap_area *va, unsigned long vstart);
+
+#define arch_refine_vmap_space arch_refine_vmap_space
+inline void arch_refine_vmap_space(struct rb_root *root,
+					  struct list_head *head,
+					  struct kmem_cache *cachep);
+
+#endif /* CONFIG_RANDOMIZE_BASE */
+
 #endif /* _ASM_ARM64_VMALLOC_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 763824963ed1..4298a2168544 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -56,7 +56,7 @@ obj-$(CONFIG_ACPI)			+= acpi.o
 obj-$(CONFIG_ACPI_NUMA)			+= acpi_numa.o
 obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 obj-$(CONFIG_PARAVIRT)			+= paravirt.o
-obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o
+obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o vmalloc.o
 obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 obj-$(CONFIG_ELF_CORE)			+= elfcore.o
 obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 47e0be610bb6..58329b27624d 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -26,8 +26,8 @@
 #include <asm/scs.h>
 #include <asm/sections.h>
 
-static u64 module_direct_base __ro_after_init = 0;
-static u64 module_plt_base __ro_after_init = 0;
+u64 module_direct_base __ro_after_init;
+u64 module_plt_base __ro_after_init;
 
 /*
  * Choose a random page-aligned base address for a window of 'size' bytes which
@@ -66,7 +66,7 @@ static u64 __init random_bounding_box(u64 size, u64 start, u64 end)
  * we may fall back to PLTs where they could have been avoided, but this keeps
  * the logic significantly simpler.
  */
-static int __init module_init_limits(void)
+int __init module_init_limits(void)
 {
 	u64 kernel_end = (u64)_end;
 	u64 kernel_start = (u64)_text;
@@ -108,7 +108,6 @@ static int __init module_init_limits(void)
 
 	return 0;
 }
-subsys_initcall(module_init_limits);
 
 void *module_alloc(unsigned long size)
 {
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 327855a11df2..89968f05177f 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -131,9 +131,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 
 void *alloc_insn_page(void)
 {
-	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
-			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
-			NUMA_NO_NODE, __builtin_return_address(0));
+	return __vmalloc_node_range(PAGE_SIZE, 1, MODULES_ASLR_START,
+			MODULES_ASLR_END, GFP_KERNEL, PAGE_KERNEL_ROX,
+			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
+			__builtin_return_address(0));
 }
 
 /* arm kprobe: install breakpoint in text */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 65a052bf741f..908ee0ccc606 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -53,6 +53,7 @@
 #include <asm/efi.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/mmu_context.h>
+#include <asm/module.h>
 
 static int num_standard_resources;
 static struct resource *standard_resources;
@@ -321,6 +322,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 
 	arm64_memblock_init();
 
+
 	paging_init();
 
 	acpi_table_upgrade();
@@ -366,6 +368,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 			"This indicates a broken bootloader or old kernel\n",
 			boot_args[1], boot_args[2], boot_args[3]);
 	}
+
+	module_init_limits();
 }
 
 static inline bool cpu_can_disable(unsigned int cpu)
diff --git a/arch/arm64/kernel/vmalloc.c b/arch/arm64/kernel/vmalloc.c
new file mode 100644
index 000000000000..00a463f3692f
--- /dev/null
+++ b/arch/arm64/kernel/vmalloc.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AArch64 vmap area management code
+ *
+ * Author: Maxwell Bland <mbland@motorola.com>
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/elf.h>
+
+#include <asm/module.h>
+
+/*
+ * Prevents the allocation of new vmap_areas from dynamic code
+ * region if the virtual address requested is not explicitly the
+ * module region.
+ */
+inline bool arch_skip_va(struct vmap_area *va, unsigned long vstart)
+{
+	return (vstart != MODULES_ASLR_START &&
+			va->va_start >= MODULES_ASLR_START &&
+			va->va_end <= MODULES_ASLR_END);
+}
+
+/*
+ * Splits a vmap area in two and allocates a new area if needed
+ */
+inline struct vmap_area *
+try_split_alloc_vmap_area(struct rb_root *root,
+		struct list_head *head,
+		struct kmem_cache *vmap_area_cachep,
+		unsigned long addr)
+{
+	struct vmap_area *va;
+	int ret;
+	struct vmap_area *lva = NULL;
+
+	va = __find_vmap_area(addr, root);
+	if (!va) {
+		pr_err("%s: could not find vmap\n", __func__);
+		return NULL;
+	}
+
+	lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
+	if (!lva) {
+		pr_err("%s: unable to allocate va for range\n", __func__);
+		return NULL;
+	}
+	lva->va_start = addr;
+	lva->va_end = va->va_end;
+	ret = va_clip(root, head, va, addr, va->va_end - addr);
+	if (WARN_ON_ONCE(ret)) {
+		pr_err("%s: unable to clip code base region\n", __func__);
+		kmem_cache_free(vmap_area_cachep, lva);
+		return NULL;
+	}
+	insert_vmap_area_augment(lva, NULL, root, head);
+	return lva;
+}
+
+/*
+ * Run during vmalloc_init, ensures that there exist explicit rb tree
+ * node delineations between code and data
+ */
+inline void arch_refine_vmap_space(struct rb_root *root,
+		struct list_head *head,
+		struct kmem_cache *cachep)
+{
+	try_split_alloc_vmap_area(root, head, cachep, MODULES_ASLR_START);
+	try_split_alloc_vmap_area(root, head, cachep, MODULES_ASLR_END);
+}
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 6986827e0d64..796231a4fd63 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -261,9 +261,7 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 		}
 		pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
 				   pg_level[st->level].name);
-		if (st->current_prot && pg_level[st->level].bits)
-			dump_prot(st, pg_level[st->level].bits,
-				  pg_level[st->level].num);
+		dump_prot(st, pg_level[st->level].bits, pg_level[st->level].num);
 		pt_dump_seq_puts(st->seq, "\n");
 
 		if (addr >= st->marker[1].start_address) {
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 122021f9bdfc..6ed6e00b8b4a 100644
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
+	return MODULES_ASLR_END - MODULES_ASLR_START;
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
2.39.2


