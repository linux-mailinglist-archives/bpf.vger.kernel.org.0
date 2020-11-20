Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D767E2BB6E0
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 21:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgKTUaF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 15:30:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:10348 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731002AbgKTUaD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 15:30:03 -0500
IronPort-SDR: RquLtYz69QL2sR+LQy1J2V07RRhg+c/g6UgT5wBEM3h9/ov49Lm2a9RtHkYkc1qAfaS63RUFk8
 dBh/D/e40zWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="235683276"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="235683276"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:01 -0800
IronPort-SDR: EaBQ0TDYD94uoER5AYZzfjKZEO6uazvV01eI6DqJEuSLuuSq8i5pj2CtRN5hjVHrPp9ryZCl46
 0bbdeReDqA2g==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="342163278"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.105.214])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:01 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, jeyu@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, luto@kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     elena.reshetova@intel.com, ira.weiny@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 02/10] bpf: Use perm_alloc() for BPF JIT filters
Date:   Fri, 20 Nov 2020 12:24:18 -0800
Message-Id: <20201120202426.18009-3-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

eBPF has other executable allocations besides filters, but just convert
over the filters for now.

Since struct perm_allocation has size information, no longer track this
separately.

For x86, write the JIT to the address provided by perm_writable_addr()
so that in later patches this can be directed to a separate writable
staging area.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/arm/net/bpf_jit_32.c         |  3 +-
 arch/arm64/net/bpf_jit_comp.c     |  5 ++--
 arch/mips/net/bpf_jit.c           |  2 +-
 arch/mips/net/ebpf_jit.c          |  3 +-
 arch/powerpc/net/bpf_jit_comp.c   |  2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 10 +++----
 arch/s390/net/bpf_jit_comp.c      |  5 ++--
 arch/sparc/net/bpf_jit_comp_32.c  |  2 +-
 arch/sparc/net/bpf_jit_comp_64.c  |  5 ++--
 arch/x86/net/bpf_jit_comp.c       | 15 ++++++++--
 arch/x86/net/bpf_jit_comp32.c     |  3 +-
 include/linux/filter.h            | 30 ++++++-------------
 kernel/bpf/core.c                 | 48 +++++++++++++++----------------
 13 files changed, 65 insertions(+), 68 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 0207b6ea6e8a..83b7d7a7a833 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1874,7 +1874,7 @@ bool bpf_jit_needs_zext(void)
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	struct bpf_prog *tmp, *orig_prog = prog;
-	struct bpf_binary_header *header;
+	struct perm_allocation *header;
 	bool tmp_blinded = false;
 	struct jit_ctx ctx;
 	unsigned int tmp_idx;
@@ -1971,6 +1971,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog = orig_prog;
 		goto out_imms;
 	}
+	prog->alloc = header;
 
 	/* 2.) Actual pass to generate final JIT code */
 	ctx.target = (u32 *) image_ptr;
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index ef9f1d5e989d..371a1b8a7fa3 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -970,7 +970,7 @@ static inline void bpf_flush_icache(void *start, void *end)
 }
 
 struct arm64_jit_data {
-	struct bpf_binary_header *header;
+	struct perm_allocation *header;
 	u8 *image;
 	struct jit_ctx ctx;
 };
@@ -979,7 +979,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	int image_size, prog_size, extable_size;
 	struct bpf_prog *tmp, *orig_prog = prog;
-	struct bpf_binary_header *header;
+	struct perm_allocation *header;
 	struct arm64_jit_data *jit_data;
 	bool was_classic = bpf_prog_was_classic(prog);
 	bool tmp_blinded = false;
@@ -1055,6 +1055,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog = orig_prog;
 		goto out_off;
 	}
+	prog->alloc = header;
 
 	/* 2. Now, the actual pass. */
 
diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 0af88622c619..c8ea5c00ce55 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1264,7 +1264,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
 void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited)
-		module_memfree(fp->bpf_func);
+		bpf_jit_binary_free(fp->alloc);
 
 	bpf_prog_unlock_free(fp);
 }
diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 561154cbcc40..e251d0cd33d8 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -1799,7 +1799,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	struct bpf_prog *orig_prog = prog;
 	bool tmp_blinded = false;
 	struct bpf_prog *tmp;
-	struct bpf_binary_header *header = NULL;
+	struct perm_allocation *header = NULL;
 	struct jit_ctx ctx;
 	unsigned int image_size;
 	u8 *image_ptr;
@@ -1889,6 +1889,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 				      sizeof(u32), jit_fill_hole);
 	if (header == NULL)
 		goto out_err;
+	prog->alloc = header;
 
 	ctx.target = (u32 *)image_ptr;
 
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index e809cb5a1631..7891a8920c68 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -677,7 +677,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
 void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited)
-		module_memfree(fp->bpf_func);
+		bpf_jit_binary_free(fp->alloc);
 
 	bpf_prog_unlock_free(fp);
 }
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 022103c6a201..d78e582580a5 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1062,7 +1062,7 @@ static int bpf_jit_fixup_subprog_calls(struct bpf_prog *fp, u32 *image,
 }
 
 struct powerpc64_jit_data {
-	struct bpf_binary_header *header;
+	struct perm_allocation *header;
 	u32 *addrs;
 	u8 *image;
 	u32 proglen;
@@ -1085,7 +1085,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	struct codegen_context cgctx;
 	int pass;
 	int flen;
-	struct bpf_binary_header *bpf_hdr;
+	struct perm_allocation *bpf_hdr;
 	struct bpf_prog *org_fp = fp;
 	struct bpf_prog *tmp_fp;
 	bool bpf_blinded = false;
@@ -1173,6 +1173,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		fp = org_fp;
 		goto out_addrs;
 	}
+	fp->alloc = header;
 
 skip_init_ctx:
 	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
@@ -1249,11 +1250,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 /* Overriding bpf_jit_free() as we don't set images read-only. */
 void bpf_jit_free(struct bpf_prog *fp)
 {
-	unsigned long addr = (unsigned long)fp->bpf_func & PAGE_MASK;
-	struct bpf_binary_header *bpf_hdr = (void *)addr;
-
 	if (fp->jited)
-		bpf_jit_binary_free(bpf_hdr);
+		bpf_jit_binary_free(fp->alloc);
 
 	bpf_prog_unlock_free(fp);
 }
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 0a4182792876..e0440307f539 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1686,7 +1686,7 @@ bool bpf_jit_needs_zext(void)
 }
 
 struct s390_jit_data {
-	struct bpf_binary_header *header;
+	struct perm_allocation *header;
 	struct bpf_jit ctx;
 	int pass;
 };
@@ -1721,7 +1721,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
 	u32 stack_depth = round_up(fp->aux->stack_depth, 8);
 	struct bpf_prog *tmp, *orig_fp = fp;
-	struct bpf_binary_header *header;
+	struct perm_allocation *header;
 	struct s390_jit_data *jit_data;
 	bool tmp_blinded = false;
 	bool extra_pass = false;
@@ -1785,6 +1785,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		fp = orig_fp;
 		goto free_addrs;
 	}
+	fp->alloc = header;
 skip_init_ctx:
 	if (bpf_jit_prog(&jit, fp, extra_pass, stack_depth)) {
 		bpf_jit_binary_free(header);
diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index b1dbf2fa8c0a..2a29d2523fd6 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -758,7 +758,7 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
 void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited)
-		module_memfree(fp->bpf_func);
+		bpf_jit_binary_free(fp->alloc);
 
 	bpf_prog_unlock_free(fp);
 }
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 3364e2a00989..3ad639166076 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1458,7 +1458,7 @@ bool bpf_jit_needs_zext(void)
 }
 
 struct sparc64_jit_data {
-	struct bpf_binary_header *header;
+	struct perm_allocation *header;
 	u8 *image;
 	struct jit_ctx ctx;
 };
@@ -1467,7 +1467,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	struct bpf_prog *tmp, *orig_prog = prog;
 	struct sparc64_jit_data *jit_data;
-	struct bpf_binary_header *header;
+	struct perm_allocation *header;
 	u32 prev_image_size, image_size;
 	bool tmp_blinded = false;
 	bool extra_pass = false;
@@ -1559,6 +1559,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog = orig_prog;
 		goto out_off;
 	}
+	prog->alloc = header;
 
 	ctx.image = (u32 *)image_ptr;
 skip_init_ctx:
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 796506dcfc42..e11ee6b71d40 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1476,11 +1476,14 @@ xadd:			if (is_imm8(insn->off))
 		}
 
 		if (image) {
+			unsigned long writable = perm_writable_addr(bpf_prog->alloc,
+								       (unsigned long)image);
+
 			if (unlikely(proglen + ilen > oldproglen)) {
 				pr_err("bpf_jit: fatal error\n");
 				return -EFAULT;
 			}
-			memcpy(image + proglen, temp, ilen);
+			memcpy((void *)writable + proglen, temp, ilen);
 		}
 		proglen += ilen;
 		addrs[i] = proglen;
@@ -1965,16 +1968,21 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs)
 }
 
 struct x64_jit_data {
-	struct bpf_binary_header *header;
+	struct perm_allocation *header;
 	int *addrs;
 	u8 *image;
 	int proglen;
 	struct jit_context ctx;
 };
 
+struct perm_allocation *bpf_jit_alloc_exec(unsigned long size)
+{
+	return perm_alloc(MODULES_VADDR, MODULES_END, size >> PAGE_SHIFT, PERM_RX);
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
-	struct bpf_binary_header *header = NULL;
+	struct perm_allocation *header = NULL;
 	struct bpf_prog *tmp, *orig_prog = prog;
 	struct x64_jit_data *jit_data;
 	int proglen, oldproglen = 0;
@@ -2078,6 +2086,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 				prog = orig_prog;
 				goto out_addrs;
 			}
+			prog->alloc = header;
 			prog->aux->extable = (void *) image + roundup(proglen, align);
 		}
 		oldproglen = proglen;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 96fde03aa987..680ca859b829 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2298,7 +2298,7 @@ bool bpf_jit_needs_zext(void)
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
-	struct bpf_binary_header *header = NULL;
+	struct perm_allocation *header = NULL;
 	struct bpf_prog *tmp, *orig_prog = prog;
 	int proglen, oldproglen = 0;
 	struct jit_context ctx = {};
@@ -2370,6 +2370,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 				prog = orig_prog;
 				goto out_addrs;
 			}
+			prog->alloc = header;
 		}
 		oldproglen = proglen;
 		cond_resched();
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1b62397bd124..1ffd93e01550 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -517,11 +517,6 @@ struct sock_fprog_kern {
 /* Some arches need doubleword alignment for their instructions and/or data */
 #define BPF_IMAGE_ALIGNMENT 8
 
-struct bpf_binary_header {
-	u32 pages;
-	u8 image[] __aligned(BPF_IMAGE_ALIGNMENT);
-};
-
 struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
 	u16			jited:1,	/* Is our filter JIT'ed? */
@@ -544,6 +539,8 @@ struct bpf_prog {
 	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
 	unsigned int		(*bpf_func)(const void *ctx,
 					    const struct bpf_insn *insn);
+	struct perm_allocation *alloc;
+
 	/* Instructions for interpreter */
 	struct sock_filter	insns[0];
 	struct bpf_insn		insnsi[];
@@ -818,20 +815,9 @@ static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
 #endif
 }
 
-static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
+static inline void bpf_jit_binary_lock_ro(struct perm_allocation *alloc)
 {
-	set_vm_flush_reset_perms(hdr);
-	set_memory_ro((unsigned long)hdr, hdr->pages);
-	set_memory_x((unsigned long)hdr, hdr->pages);
-}
-
-static inline struct bpf_binary_header *
-bpf_jit_binary_hdr(const struct bpf_prog *fp)
-{
-	unsigned long real_start = (unsigned long)fp->bpf_func;
-	unsigned long addr = real_start & PAGE_MASK;
-
-	return (void *)addr;
+	perm_writable_finish(alloc);
 }
 
 int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap);
@@ -986,14 +972,14 @@ extern long bpf_jit_limit;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
-struct bpf_binary_header *
+struct perm_allocation *
 bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
 		     bpf_jit_fill_hole_t bpf_fill_ill_insns);
-void bpf_jit_binary_free(struct bpf_binary_header *hdr);
+void bpf_jit_binary_free(struct perm_allocation *hdr);
 u64 bpf_jit_alloc_exec_limit(void);
-void *bpf_jit_alloc_exec(unsigned long size);
-void bpf_jit_free_exec(void *addr);
+struct perm_allocation *bpf_jit_alloc_exec(unsigned long size);
+void bpf_jit_free_exec(struct perm_allocation *alloc);
 void bpf_jit_free(struct bpf_prog *fp);
 
 int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 55454d2278b1..c0088014c65c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -530,13 +530,13 @@ long bpf_jit_limit   __read_mostly;
 static void
 bpf_prog_ksym_set_addr(struct bpf_prog *prog)
 {
-	const struct bpf_binary_header *hdr = bpf_jit_binary_hdr(prog);
-	unsigned long addr = (unsigned long)hdr;
+	const struct perm_allocation *alloc = prog->alloc;
+	unsigned long addr = perm_alloc_address(alloc);
 
 	WARN_ON_ONCE(!bpf_prog_ebpf_jited(prog));
 
-	prog->aux->ksym.start = (unsigned long) prog->bpf_func;
-	prog->aux->ksym.end   = addr + hdr->pages * PAGE_SIZE;
+	prog->aux->ksym.start = (unsigned long)addr;
+	prog->aux->ksym.end   = addr +  alloc->size;
 }
 
 static void
@@ -843,22 +843,23 @@ static void bpf_jit_uncharge_modmem(u32 pages)
 	atomic_long_sub(pages, &bpf_jit_current);
 }
 
-void *__weak bpf_jit_alloc_exec(unsigned long size)
+struct perm_allocation * __weak bpf_jit_alloc_exec(unsigned long size)
 {
-	return module_alloc(size);
+	/* Note: Range ignored for default perm_alloc implementation */
+	return perm_alloc(0, 0, size >> PAGE_SHIFT, PERM_RX);
 }
 
-void __weak bpf_jit_free_exec(void *addr)
+void __weak bpf_jit_free_exec(struct perm_allocation *alloc)
 {
-	module_memfree(addr);
+	perm_free(alloc);
 }
 
-struct bpf_binary_header *
+struct perm_allocation *
 bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
 		     bpf_jit_fill_hole_t bpf_fill_ill_insns)
 {
-	struct bpf_binary_header *hdr;
+	struct perm_allocation *alloc;
 	u32 size, hole, start, pages;
 
 	WARN_ON_ONCE(!is_power_of_2(alignment) ||
@@ -868,36 +869,35 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 	 * fill a page, allow at least 128 extra bytes to insert a
 	 * random section of illegal instructions.
 	 */
-	size = round_up(proglen + sizeof(*hdr) + 128, PAGE_SIZE);
+	size = round_up(proglen + 128, PAGE_SIZE);
 	pages = size / PAGE_SIZE;
 
 	if (bpf_jit_charge_modmem(pages))
 		return NULL;
-	hdr = bpf_jit_alloc_exec(size);
-	if (!hdr) {
+	alloc = bpf_jit_alloc_exec(size);
+	if (!alloc) {
 		bpf_jit_uncharge_modmem(pages);
 		return NULL;
 	}
 
 	/* Fill space with illegal/arch-dep instructions. */
-	bpf_fill_ill_insns(hdr, size);
+	bpf_fill_ill_insns((void *)perm_writable_base(alloc), size);
 
-	hdr->pages = pages;
-	hole = min_t(unsigned int, size - (proglen + sizeof(*hdr)),
-		     PAGE_SIZE - sizeof(*hdr));
+	hole = min_t(unsigned int, size - proglen,
+		     PAGE_SIZE);
 	start = (get_random_int() % hole) & ~(alignment - 1);
 
 	/* Leave a random number of instructions before BPF code. */
-	*image_ptr = &hdr->image[start];
+	*image_ptr = (void *)perm_alloc_address(alloc) + start;
 
-	return hdr;
+	return alloc;
 }
 
-void bpf_jit_binary_free(struct bpf_binary_header *hdr)
+void bpf_jit_binary_free(struct perm_allocation *alloc)
 {
-	u32 pages = hdr->pages;
+	u32 pages = alloc->size >> PAGE_SHIFT;
 
-	bpf_jit_free_exec(hdr);
+	bpf_jit_free_exec(alloc);
 	bpf_jit_uncharge_modmem(pages);
 }
 
@@ -908,9 +908,7 @@ void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 void __weak bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited) {
-		struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
-
-		bpf_jit_binary_free(hdr);
+		bpf_jit_binary_free(fp->alloc);
 
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
 	}
-- 
2.20.1

