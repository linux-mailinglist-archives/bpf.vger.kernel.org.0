Return-Path: <bpf+bounces-44277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6B69C0D45
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 18:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62893284AF6
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE02217306;
	Thu,  7 Nov 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhiZ5gSo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04EF216E1A
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001879; cv=none; b=K4Imp5s8yGolMd9WUSLQjktdPA/e5lBbh112xI36bxGavX5dc9w6bGr87+oxOsy6IvpNVGHdBMIPZR3eZ/vdstt3IlUaIDPkVIuBd+xMADSrZqx1x1coQhaMduV3b3FxjpgSVUHGcfbIJr/F44ApdYV/7IYnPS3mPpVqrZqixLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001879; c=relaxed/simple;
	bh=HKP722y3UlzToRrKt7vNJ0mbyH0wNwWzGtBUFT/hlmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWiworZ2X7HXblTDF44l+DS/D1oO4fYYFOUGkiBZzidZPxWnmQ3n1lugsF6pPYn9ObsbIxzOpJ7lLWL9I0VgGfdDjVU92VaJF/tvn4dtRAqdvu6qrtHvJEvqEs07upC8nEkRiMSY0N5EO7wwFjXwbeMeH44ocBf8VMp/zVlMa6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhiZ5gSo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e34a089cd3so1011142a91.3
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 09:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001876; x=1731606676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8z+yVsQdMKe3YZZHieHDshuKpUhbi+m40Bmzv6ZXYI=;
        b=OhiZ5gSoID8ggIuDapsTR/46/AF5PIOEopdAad7cL5JG3TWh1jaOsjAJPXi9ptglyh
         7dRnXrZQxZzyP1AWo5wA2oHVBATRGfJK13WUx1NHLOeBUHtULdyr0a8Uuom6rMPtcErU
         qNIfzI5+DIz5qzxxtkcZA7LBzoB99mVaPgOFMzCPmG9aDq98gV5qcbzz8JSWrK1F6vDt
         LxgtK8vS1kK9jERHCKnrYrz7HaQOzf6tmIVsLivp6NQcOo0eD9oqgVIHD82GeJfUWADp
         IUAzojYYBtD1PxxUBuFpp8GotRLwoT4UJ4Lg1kTpw7xeNRuRcmNGgiyU1fF5kLPeF8Mw
         RYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001876; x=1731606676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8z+yVsQdMKe3YZZHieHDshuKpUhbi+m40Bmzv6ZXYI=;
        b=jOACCM+VQ4tuqmvC23rfvuilMCUsE6xHK0lREmkYeHRHaq92pBEBLqvRWwnq3bQppF
         ROG1H1AzYatQrh8ERkF8clypXyfph1i1fhlaNgv02KxkaY554gopaSKpZM6ji0jLw8ch
         yU5rjWD+e1teVk3waSqhtkkQu8ZTHvkMnm1g/2jlurTAMrT50D9isOnnoQTLi38PlPEE
         PVDYTgo079CWALc8AgDrvLwkBz+FjeTIYOQHkl2L/Ws8OT0XiqOCkoWEq+FOtzHrgaEu
         dI8bl2sr4Y9DI1IxDDR2m7jZ5j1kemyWqFgoW+USD591P+VrXiuzqUOvaJbGsVvoDMwA
         /S0A==
X-Gm-Message-State: AOJu0YxmZ0HBVAIhCvwe81Sqme89+BFTu1IhIDmntZfKmTPZxHwqhLy4
	gn00mmnlNXY0Z5xYozKhu3ka5poYD65BDI7rINA1TGmYHeO2y/lWY/7lNTyK
X-Google-Smtp-Source: AGHT+IEke0v0k6hAprmdWXFXlhtXValeccgMk5dqBkfDg5BhUwE3sETU9d3jobdYLP1+2SyLDvcMZw==
X-Received: by 2002:a17:90b:3811:b0:2e9:2329:8d98 with SMTP id 98e67ed59e1d1-2e9b16ef07amr49972a91.8.1731001875574;
        Thu, 07 Nov 2024 09:51:15 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52b32sm1730686a91.5.2024.11.07.09.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:51:14 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 03/11] bpf: shared BPF/native kfuncs
Date: Thu,  7 Nov 2024 09:50:32 -0800
Message-ID: <20241107175040.1659341-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107175040.1659341-1-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a notion of inlinable kfuncs, compiled both to native
code and BPF. BPF-compiled version is embedded in kernel data section
and is available to verifier. Verifier uses it to replace calls to
such kfuncs with inlined function bodies.

Inlinable kfuncs are available only if CLANG is used for kernel
compilation.

In the scope of this commit all inlining happens as last steps of
do_check(), after verification is finished. Follow up commits would
extend this mechanism to allow removal of some conditional branches
inside inlined function bodies.

The commit consists of the following changes:
- main kernel makefile:
  modified to compile a bootstrap version of the bpftool;
- kernel/bpf/Makefile:
  - a new file inlinable_kfuncs.c is added;
  - makefile is modified to compile this file as BPF elf,
    using the following steps:
    - use clang with native target to produce LLVM bitcode;
    - compile LLVM bitcode to BPF object file;
    - resolve relocations inside BPF object file using bpftool as a
      linker;
    Such arrangement allows including unmodified network related
    header files.
- verifier.c:
  - generated BPF elf is included as a part of kernel data section;
  - at kernel initialization phase:
    - the elf is parsed and each function declared within it is
      recorded as an instance of 'inlinable_kfunc' structure;
    - calls to extern functions within elf file (pointed to by
      relocation records) are replaced with kfunc call instructions;
  - do_check() is modified to replace calls to kfuncs from inlinable
    kfunc table with function bodies:
    - replacement happens after main verification pass, so the bodies
      of the kfuncs are not analyzed by verifier;
    - if kfunc uses callee saved registers r6-r9 the spill/fill pairs
      are generated for these register before/after inlined kfunc body
      at call site;
    - if kfunc uses r10 as a base pointer for load or store
      instructions, offsets of these instructions are adjusted;
    - if kfunc uses r10 in other instructions, such r10 is considered
      as escaping and kfunc is not inlined.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 Makefile                      |  22 +-
 kernel/bpf/Makefile           |  24 +-
 kernel/bpf/inlinable_kfuncs.c |   1 +
 kernel/bpf/verifier.c         | 652 +++++++++++++++++++++++++++++++++-
 4 files changed, 680 insertions(+), 19 deletions(-)
 create mode 100644 kernel/bpf/inlinable_kfuncs.c

diff --git a/Makefile b/Makefile
index a9a7d9ffaa98..4ded57f4b0c2 100644
--- a/Makefile
+++ b/Makefile
@@ -496,6 +496,7 @@ CLIPPY_DRIVER	= clippy-driver
 BINDGEN		= bindgen
 PAHOLE		= pahole
 RESOLVE_BTFIDS	= $(objtree)/tools/bpf/resolve_btfids/resolve_btfids
+BPFTOOL		= $(objtree)/tools/bpf/bpftool/bootstrap/bpftool
 LEX		= flex
 YACC		= bison
 AWK		= awk
@@ -585,7 +586,7 @@ export RUSTC_BOOTSTRAP := 1
 export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC HOSTPKG_CONFIG
 export RUSTC RUSTDOC RUSTFMT RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGEN
 export HOSTRUSTC KBUILD_HOSTRUSTFLAGS
-export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
+export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS BPFTOOL LEX YACC AWK INSTALLKERNEL
 export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
 export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
 export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
@@ -1356,6 +1357,25 @@ ifneq ($(wildcard $(resolve_btfids_O)),)
 	$(Q)$(MAKE) -sC $(srctree)/tools/bpf/resolve_btfids O=$(resolve_btfids_O) clean
 endif
 
+# TODO: cross compilation?
+# TODO: bootstrap! (to avoid vmlinux.h generation)
+PHONY += bpftool_bootstrap bpftool_clean
+bpftool_O = $(abspath $(objtree))/tools/bpf/bpftool
+
+ifdef CONFIG_BPF
+ifdef CONFIG_CC_IS_CLANG
+prepare: bpftool_bootstrap
+endif
+endif
+
+bpftool_bootstrap:
+	$(Q)$(MAKE) -sC $(srctree)/tools/bpf/bpftool O=$(bpftool_O) srctree=$(abspath $(srctree)) bootstrap
+
+bpftool_clean:
+ifneq ($(wildcard $(bpftool_O)),)
+	$(Q)$(MAKE) -sC $(srctree)/tools/bpf/bpftool O=$(bpftool_O) srctree=$(abspath $(srctree)) clean
+endif
+
 # Clear a bunch of variables before executing the submake
 ifeq ($(quiet),silent_)
 tools_silent=s
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 105328f0b9c0..3d7ee81c8e2e 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o tnum.o log.o token.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
@@ -53,3 +53,25 @@ obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
 obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
+obj-$(CONFIG_BPF_SYSCALL) += helpers.o inlinable_kfuncs.o
+
+ifdef CONFIG_CC_IS_CLANG
+
+LLC ?= $(LLVM_PREFIX)llc$(LLVM_SUFFIX)
+
+# -mfentry -pg is $(CC_FLAGS_FTRACE)
+# -fpatchable-function-entry=16,16 is $(PADDING_CFLAGS)
+CFLAGS_REMOVE_inlinable_kfuncs.bpf.bc.o += $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_inlinable_kfuncs.bpf.bc.o += $(PADDING_CFLAGS)
+$(obj)/inlinable_kfuncs.bpf.bc.o: $(src)/inlinable_kfuncs.c
+	$(Q)$(CLANG) $(c_flags) -emit-llvm -c $< -o $@
+
+$(obj)/inlinable_kfuncs.bpf.o: $(obj)/inlinable_kfuncs.bpf.bc.o
+	$(Q)$(LLC) -mcpu=v3 --mtriple=bpf --filetype=obj $< -o $@
+
+$(obj)/inlinable_kfuncs.bpf.linked.o: $(obj)/inlinable_kfuncs.bpf.o
+	$(Q)$(BPFTOOL) gen object $@ $<
+
+$(obj)/verifier.o: $(obj)/inlinable_kfuncs.bpf.linked.o
+
+endif
diff --git a/kernel/bpf/inlinable_kfuncs.c b/kernel/bpf/inlinable_kfuncs.c
new file mode 100644
index 000000000000..7b7dc05fa1a4
--- /dev/null
+++ b/kernel/bpf/inlinable_kfuncs.c
@@ -0,0 +1 @@
+// SPDX-License-Identifier: GPL-2.0-only
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3bae0bbc1da9..fbf51147f319 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20509,6 +20509,622 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
+asm (
+"	.pushsection .data, \"a\"		\n"
+"	.global inlinable_kfuncs_data		\n"
+"inlinable_kfuncs_data:				\n"
+"	.incbin \"kernel/bpf/inlinable_kfuncs.bpf.linked.o\"\n"
+"	.global inlinable_kfuncs_data_end		\n"
+"inlinable_kfuncs_data_end:			\n"
+"	.popsection				\n"
+);
+
+extern void inlinable_kfuncs_data;
+extern void inlinable_kfuncs_data_end;
+
+struct blob {
+	void *mem;
+	u32 size;
+};
+
+struct inlinable_kfunc {
+	const char *name;
+	const struct bpf_insn *insns;
+	u32 insn_num;
+	u32 btf_id;
+};
+
+static struct inlinable_kfunc inlinable_kfuncs[16];
+
+static void *check_inlinable_kfuncs_ptr(struct blob *blob,
+				      void *ptr, u64 size, const char *context)
+{
+	if (ptr + size > blob->mem + blob->size) {
+		printk("malformed inlinable kfuncs data: bad offset/size 0x%lx/0x%llx: %s",
+		       ptr - blob->mem, size, context);
+		return NULL;
+	}
+	return ptr;
+}
+
+static void *get_inlinable_kfuncs_ptr(struct blob *blob,
+				    u64 off, u64 size, const char *context)
+{
+	return check_inlinable_kfuncs_ptr(blob, blob->mem + off, size, context);
+}
+
+struct inlinable_kfunc_regs_usage {
+	u32 used_regs_mask;
+	s32 lowest_stack_off;
+	bool r10_escapes;
+};
+
+static void scan_regs_usage(const struct bpf_insn *insns, u32 insn_num,
+			    struct inlinable_kfunc_regs_usage *usage)
+{
+	const struct bpf_insn *insn = insns;
+	s32 lowest_stack_off;
+	bool r10_escapes;
+	u32 i, mask;
+
+	lowest_stack_off = 0;
+	r10_escapes = false;
+	mask = 0;
+	for (i = 0; i < insn_num; ++i, ++insn) {
+		mask |= BIT(insn->src_reg);
+		mask |= BIT(insn->dst_reg);
+		switch (BPF_CLASS(insn->code)) {
+		case BPF_ST:
+		case BPF_STX:
+			if (insn->dst_reg == BPF_REG_10)
+				lowest_stack_off = min(lowest_stack_off, insn->off);
+			if (insn->src_reg == BPF_REG_10 && BPF_SRC(insn->code) == BPF_X)
+				r10_escapes = true;
+			break;
+		case BPF_LDX:
+			if (insn->src_reg == BPF_REG_10)
+				lowest_stack_off = min(lowest_stack_off, insn->off);
+			break;
+		case BPF_ALU:
+		case BPF_ALU64:
+			if (insn->src_reg == BPF_REG_10 && BPF_SRC(insn->code) == BPF_X)
+				r10_escapes = true;
+			break;
+		default:
+			break;
+		}
+	}
+	usage->used_regs_mask = mask;
+	usage->lowest_stack_off = lowest_stack_off;
+	usage->r10_escapes = r10_escapes;
+}
+
+#ifndef Elf_Rel
+#ifdef CONFIG_64BIT
+#define Elf_Rel		Elf64_Rel
+#else
+#define Elf_Rel		Elf32_Rel
+#endif
+#endif
+
+#define R_BPF_64_32 10
+
+struct sh_elf_sections {
+	Elf_Sym *sym;
+	Elf_Rel *rel;
+	void *text;
+	const char *strings;
+	u32 rel_cnt;
+	u32 sym_cnt;
+	u32 strings_sz;
+	u32 text_sz;
+	u32 symtab_idx;
+	u32 text_idx;
+};
+
+static int validate_inlinable_kfuncs_header(Elf_Ehdr *hdr)
+{
+	if (hdr->e_ident[EI_MAG0] != ELFMAG0 || hdr->e_ident[EI_MAG1] != ELFMAG1 ||
+	    hdr->e_ident[EI_MAG2] != ELFMAG2 || hdr->e_ident[EI_MAG3] != ELFMAG3 ||
+	    hdr->e_ident[EI_CLASS] != ELFCLASS64 || hdr->e_ident[EI_VERSION] != EV_CURRENT ||
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	    hdr->e_ident[EI_DATA] != ELFDATA2LSB ||
+#else
+	    hdr->e_ident[EI_DATA] != ELFDATA2MSB ||
+#endif
+	    hdr->e_type != ET_REL || hdr->e_machine != EM_BPF || hdr->e_version != EV_CURRENT) {
+		printk("malformed inlinable kfuncs data: bad ELF header\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int inlinable_kfuncs_parse_sections(struct blob *blob, struct sh_elf_sections *s)
+{
+	Elf_Shdr *sh_strings = NULL;
+	Elf_Shdr *sec_hdrs = NULL;
+	Elf_Shdr *symtab = NULL;
+	Elf_Shdr *text = NULL;
+	Elf_Shdr *text_rel = NULL;
+	Elf_Shdr *shdr;
+	Elf_Ehdr *hdr;
+	Elf_Sym *sym;
+	u32 i, symtab_idx, text_idx;
+	const char *strings, *name;
+	int err;
+
+	hdr = get_inlinable_kfuncs_ptr(blob, 0, sizeof(*hdr), "ELF header");
+	if (!hdr)
+		return -EINVAL;
+	err = validate_inlinable_kfuncs_header(hdr);
+	if (err < 0)
+		return err;
+	sec_hdrs = get_inlinable_kfuncs_ptr(blob, hdr->e_shoff, 0, "section headers table");
+	if (!sec_hdrs)
+		return -EINVAL;
+	sh_strings = check_inlinable_kfuncs_ptr(blob, &sec_hdrs[hdr->e_shstrndx], sizeof(*s),
+					      "string table header");
+	if (!sh_strings)
+		return -EINVAL;
+	strings = get_inlinable_kfuncs_ptr(blob, sh_strings->sh_offset, sh_strings->sh_size,
+					 "strings table");
+	if (!strings)
+		return -EINVAL;
+	if (strings[sh_strings->sh_size - 1] != 0) {
+		printk("malformed inlinable kfuncs data: string table is not null terminated\n");
+		return -EINVAL;
+	}
+	if (!check_inlinable_kfuncs_ptr(blob, &sec_hdrs[hdr->e_shnum - 1], sizeof(*sec_hdrs),
+				      "section table"))
+		return -EINVAL;
+
+	for (i = 1; i < hdr->e_shnum; i++) {
+		shdr = &sec_hdrs[i];
+		name = strings + shdr->sh_name;
+		if (shdr->sh_name >= sh_strings->sh_size) {
+			printk("malformed inlinable kfuncs data: bad section #%u name\n", i);
+			return -EINVAL;
+		}
+		if (!get_inlinable_kfuncs_ptr(blob, shdr->sh_offset, shdr->sh_size,
+					    "section size/offset"))
+			return -EINVAL;
+		switch (shdr->sh_type) {
+		case SHT_NULL:
+		case SHT_STRTAB:
+			continue;
+		case SHT_SYMTAB:
+			symtab = shdr;
+			symtab_idx = i;
+			if (symtab->sh_entsize != sizeof(*sym)) {
+				printk("malformed inlinable kfuncs data: unexpected symtab->sh_entsize: %llu\n",
+				       symtab->sh_entsize);
+				return -EINVAL;
+			}
+			if (symtab->sh_size % sizeof(*sym) != 0) {
+				printk("malformed inlinable kfuncs data: unexpected symtab->sh_size: %llu\n",
+				       symtab->sh_size);
+				return -EINVAL;
+			}
+			break;
+		case SHT_PROGBITS:
+			if (strcmp(name, ".text") == 0) {
+				text = shdr;
+				text_idx = i;
+			} else if (strcmp(name, ".BTF") == 0 || strcmp(name, ".BTF.ext") == 0) {
+				/* ignore BTF for now */
+				break;
+			} else {
+				printk("malformed inlinable kfuncs data: unexpected section #%u name ('%s')\n",
+				       i, name);
+				return -EINVAL;
+			}
+			break;
+		case SHT_REL:
+			if (text_rel) {
+				printk("malformed inlinable kfuncs data: unexpected relocation section #%u name ('%s')\n",
+				       i, name);
+				return -EINVAL;
+			}
+			text_rel = shdr;
+			break;
+		default:
+			printk("malformed inlinable kfuncs data: unexpected section #%u type (0x%x)\n",
+			       i, shdr->sh_type);
+			return -EINVAL;
+		}
+	}
+	if (!symtab) {
+		printk("malformed inlinable kfuncs data: SHT_SYMTAB section is missing\n");
+		return -EINVAL;
+	}
+	if (!text) {
+		printk("malformed inlinable kfuncs data: .text section is missing\n");
+		return -EINVAL;
+	}
+	if (text_rel && (text_rel->sh_info != text_idx || text_rel->sh_link != symtab_idx)) {
+		printk("malformed inlinable kfuncs data: SHT_REL section #%u '%s' unexpected sh_link %u\n",
+		       i, name, shdr->sh_link);
+		return -EINVAL;
+	}
+	s->sym = blob->mem + symtab->sh_offset;
+	s->text = blob->mem + text->sh_offset;
+	s->strings = strings;
+	s->sym_cnt = symtab->sh_size / sizeof(*s->sym);
+	s->text_sz = text->sh_size;
+	s->strings_sz = sh_strings->sh_size;
+	s->text_idx = text_idx;
+	s->symtab_idx = symtab_idx;
+	if (text_rel) {
+		s->rel = blob->mem + text_rel->sh_offset;
+		s->rel_cnt = text_rel->sh_size / sizeof(*s->rel);
+	} else {
+		s->rel = NULL;
+		s->rel_cnt = 0;
+	}
+	return 0;
+}
+
+/* Replace call instructions with function relocations by kfunc call
+ * instructions, looking up corresponding kernel functions by name.
+ * Inserted kfunc calls might refer to any kernel functions,
+ * not necessarily those marked with __bpf_kfunc.
+ * Any other relocation kinds are not supported.
+ */
+static int inlinable_kfuncs_apply_relocs(struct sh_elf_sections *s, struct btf *btf)
+{
+	Elf_Rel *rel;
+	u32 i;
+
+	if (!s->rel)
+		return 0;
+
+	if (!btf) {
+		printk("inlinable_kfuncs_init: no vmlinux btf\n");
+		return -EINVAL;
+	}
+	printk("inlinable_kfuncs_init: relocations:\n");
+	for (rel = s->rel, i = 0; i < s->rel_cnt; i++, rel++) {
+		printk("inlinable_kfuncs_init:  tp=0x%llx, sym=0x%llx, off=0x%llx\n",
+		       ELF_R_TYPE(rel->r_info), ELF_R_SYM(rel->r_info), rel->r_offset);
+	}
+	for (rel = s->rel, i = 0; i < s->rel_cnt; i++, rel++) {
+		struct bpf_insn *rinsn;
+		const char *rname;
+		Elf_Sym *rsym;
+		u32 idx;
+		s32 id;
+
+		if (ELF_R_TYPE(rel->r_info) != R_BPF_64_32) {
+			printk("relocation #%u unexpected relocation type: %llu\n", i, ELF_R_TYPE(rel->r_info));
+			return -EINVAL;
+		}
+		idx = ELF_R_SYM(rel->r_info);
+		rsym = s->sym + idx;
+		if (idx >= s->sym_cnt) {
+			printk("relocation #%u symbol index out of bounds: %u\n", i, idx);
+			return -EINVAL;
+		}
+		if (rsym->st_name >= s->strings_sz) {
+			printk("relocation #%u symbol name out of bounds: %u\n", i, rsym->st_name);
+			return -EINVAL;
+		}
+		rname = s->strings + rsym->st_name;
+		if (rel->r_offset + sizeof(struct bpf_insn) >= s->text_sz ||
+		    rel->r_offset % sizeof(struct bpf_insn) != 0) {
+			printk("relocation #%u invalid offset: %llu\n", i, rel->r_offset);
+			return -EINVAL;
+		}
+		rinsn = s->text + rel->r_offset;
+		if (rinsn->code != (BPF_JMP | BPF_CALL) ||
+		    rinsn->src_reg != BPF_PSEUDO_CALL ||
+		    rinsn->dst_reg != 0 ||
+		    rinsn->off != 0 ||
+		    rinsn->imm != -1) {
+			printk("relocation #%u invalid instruction at offset %llu\n", i, rel->r_offset);
+			return -EINVAL;
+		}
+		id = btf_find_by_name_kind(btf, rname, BTF_KIND_FUNC);
+		if (id < 0) {
+			printk("relocation #%u can't resolve function '%s'\n", i, rname);
+			return -EINVAL;
+		}
+		rinsn->src_reg = BPF_PSEUDO_KFUNC_CALL;
+		rinsn->imm = id;
+		printk("inlinable_kfuncs_init: patching insn %ld, imm=%d, off=%d\n",
+		       rinsn - (struct bpf_insn *)s->text, rinsn->imm, rinsn->off);
+	}
+	return 0;
+}
+
+/* Fill 'inlinable_kfuncs' table with STT_FUNC symbols from symbol table
+ * of the ELF file pointed to by elf_bin.
+ * Do some sanity checks for ELF data structures,
+ * (but refrain from being overly paranoid, as this ELF is a part of kernel build).
+ */
+static int bpf_register_inlinable_kfuncs(void *elf_bin, u32 size)
+{
+	struct blob blob = { .mem = elf_bin, .size = size };
+	struct sh_elf_sections s;
+	struct btf *btf;
+	Elf_Sym *sym;
+	u32 i, idx;
+	int err;
+
+	btf = bpf_get_btf_vmlinux();
+	if (!btf)
+		return -EINVAL;
+
+	err = inlinable_kfuncs_parse_sections(&blob, &s);
+	if (err < 0)
+		return err;
+
+	err = inlinable_kfuncs_apply_relocs(&s, btf);
+	if (err < 0)
+		return err;
+
+	idx = 0;
+	for (sym = s.sym, i = 0; i < s.sym_cnt; i++, sym++) {
+		struct inlinable_kfunc *sh;
+		struct bpf_insn *insns;
+		const char *name;
+		u32 insn_num;
+		int id;
+
+		if (ELF_ST_TYPE(sym->st_info) != STT_FUNC)
+			continue;
+		if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL ||
+		    sym->st_other != 0 ||
+		    sym->st_shndx != s.text_idx ||
+		    sym->st_size % sizeof(struct bpf_insn) != 0 ||
+		    sym->st_value % sizeof(struct bpf_insn) != 0 ||
+		    sym->st_name >= s.strings_sz) {
+			printk("malformed inlinable kfuncs data: bad symbol #%u\n", i);
+			return -EINVAL;
+		}
+		if (idx == ARRAY_SIZE(inlinable_kfuncs) - 1) {
+			printk("malformed inlinable kfuncs data: too many helper functions\n");
+			return -EINVAL;
+		}
+		insn_num = sym->st_size / sizeof(struct bpf_insn);
+		insns = s.text + sym->st_value;
+		name = s.strings + sym->st_name;
+		id = btf_find_by_name_kind(btf, name, BTF_KIND_FUNC);
+		if (id < 0) {
+			printk("can't add inlinable kfunc '%s': no btf_id\n", name);
+			return -EINVAL;
+		}
+		sh = &inlinable_kfuncs[idx++];
+		sh->insn_num = insn_num;
+		sh->insns = insns;
+		sh->name = name;
+		sh->btf_id = id;
+		printk("adding inlinable kfunc %s at 0x%llx, %u instructions, btf_id=%d\n",
+		       sh->name, sym->st_value, sh->insn_num, sh->btf_id);
+	}
+
+	return 0;
+}
+
+static int __init inlinable_kfuncs_init(void)
+{
+	return bpf_register_inlinable_kfuncs(&inlinable_kfuncs_data,
+					   &inlinable_kfuncs_data_end - &inlinable_kfuncs_data);
+}
+
+late_initcall(inlinable_kfuncs_init);
+
+static struct inlinable_kfunc *find_inlinable_kfunc(u32 btf_id)
+{
+	struct inlinable_kfunc *sh = inlinable_kfuncs;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(inlinable_kfuncs); ++i, ++sh)
+		if (sh->btf_id == btf_id)
+			return sh;
+	return NULL;
+}
+
+/* Given a kfunc call instruction, when kfunc is an inlinable kfunc,
+ * replace the call instruction with a body of said kfunc.
+ * Stack slots used within kfunc body become stack slots of with calling function,
+ * report extra stack used in 'stack_depth_extra'.
+ */
+static struct bpf_prog *inline_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+					  int insn_idx, int *cnt, s32 stack_base, u16 *stack_depth_extra)
+{
+	struct inlinable_kfunc_regs_usage regs_usage;
+	const struct bpf_kfunc_desc *desc;
+	struct bpf_prog *new_prog;
+	struct bpf_insn *insn_buf;
+	struct inlinable_kfunc *sh;
+	int i, j, r, off, err, exit;
+	u32 subprog_insn_cnt;
+	u16 extra_slots;
+	s16 stack_off;
+	u32 insn_num;
+
+	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
+	if (!desc || IS_ERR(desc))
+		return ERR_PTR(-EFAULT);
+	sh = find_inlinable_kfunc(desc->func_id);
+	if (!sh)
+		return NULL;
+
+	subprog_insn_cnt = sh->insn_num;
+	scan_regs_usage(sh->insns, subprog_insn_cnt, &regs_usage);
+	if (regs_usage.r10_escapes) {
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "can't inline kfunc %s at insn %d, r10 escapes\n",
+				sh->name, insn_idx);
+		return NULL;
+	}
+
+	extra_slots = 0;
+	for (i = BPF_REG_6; i <= BPF_REG_9; ++i)
+		if (regs_usage.used_regs_mask & BIT(i))
+			++extra_slots;
+	*stack_depth_extra = extra_slots * BPF_REG_SIZE + -regs_usage.lowest_stack_off;
+	insn_num = subprog_insn_cnt + extra_slots * 2;
+	insn_buf = kmalloc_array(insn_num, sizeof(*insn_buf), GFP_KERNEL);
+	if (!insn_buf)
+		return ERR_PTR(-ENOMEM);
+
+	if (env->log.level & BPF_LOG_LEVEL2)
+		verbose(env, "inlining kfunc %s at insn %d\n", sh->name, insn_idx);
+	memcpy(insn_buf + extra_slots, sh->insns, subprog_insn_cnt * sizeof(*insn_buf));
+	off = stack_base;
+	i = 0;
+	j = insn_num - 1;
+	/* Generate spill/fill pairs for callee saved registers used
+         * by kfunc before/after inlined function body.
+	 */
+	for (r = BPF_REG_6; r <= BPF_REG_9; ++r) {
+		if ((regs_usage.used_regs_mask & BIT(r)) == 0)
+			continue;
+		off -= BPF_REG_SIZE;
+		insn_buf[i++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, r, off);
+		insn_buf[j--] = BPF_LDX_MEM(BPF_DW, r, BPF_REG_10, off);
+	}
+	exit = insn_idx + subprog_insn_cnt + extra_slots;
+	new_prog = bpf_patch_insn_data(env, insn_idx, insn_buf, insn_num);
+	kfree(insn_buf);
+	if (!new_prog)
+		return ERR_PTR(-ENOMEM);
+
+	stack_off = 0;
+	if (!regs_usage.r10_escapes && (regs_usage.used_regs_mask & BIT(BPF_REG_10)))
+		stack_off = off;
+
+	for (j = 0; j < subprog_insn_cnt; ++j) {
+		i = insn_idx + extra_slots + j;
+		insn = new_prog->insnsi + i;
+
+		/* Replace 'exit' with jump to inlined body end. */
+		if (insn->code == (BPF_JMP | BPF_EXIT)) {
+			off = exit - i - 1;
+			if (off < S16_MAX)
+				*insn = BPF_JMP_A(off);
+			else
+				*insn = BPF_JMP32_A(off);
+		}
+
+		/* Adjust offsets of r10-based load and store instructions
+		 * to use slots not used by calling function.
+		 */
+		switch (BPF_CLASS(insn->code)) {
+		case BPF_ST:
+		case BPF_STX:
+			if (insn->dst_reg == BPF_REG_10)
+				insn->off += stack_off;
+			break;
+		case BPF_LDX:
+			if (insn->src_reg == BPF_REG_10)
+				insn->off += stack_off;
+			break;
+		default:
+			break;
+		}
+
+		/* Make sure kernel function calls from within kfunc body could be jitted. */
+		if (bpf_pseudo_kfunc_call(insn)) {
+			err = add_kfunc_call(env, insn->imm, insn->off);
+			if (err < 0)
+				return ERR_PTR(err);
+		}
+	}
+
+	*cnt = insn_num;
+
+	return new_prog;
+}
+
+/* Do this after all stack depth adjustments */
+static int inline_kfunc_calls(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog;
+	struct bpf_insn *insn = prog->insnsi;
+	const int insn_cnt = prog->len;
+	struct bpf_prog *new_prog;
+	int i, cnt, delta = 0, cur_subprog = 0;
+	struct bpf_subprog_info *subprogs = env->subprog_info;
+	u16 stack_depth = subprogs[cur_subprog].stack_depth;
+	u16 call_extra_stack = 0, subprog_extra_stack = 0;
+
+	for (i = 0; i < insn_cnt;) {
+		if (!bpf_pseudo_kfunc_call(insn))
+			goto next_insn;
+
+		new_prog = inline_kfunc_call(env, insn, i + delta, &cnt,
+					     -stack_depth, &call_extra_stack);
+		if (IS_ERR(new_prog))
+			return PTR_ERR(new_prog);
+		if (!new_prog)
+			goto next_insn;
+
+		subprog_extra_stack = max(subprog_extra_stack, call_extra_stack);
+		delta	 += cnt - 1;
+		env->prog = prog = new_prog;
+		insn	  = new_prog->insnsi + i + delta;
+
+next_insn:
+		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
+			subprogs[cur_subprog].stack_depth += subprog_extra_stack;
+			cur_subprog++;
+			stack_depth = subprogs[cur_subprog].stack_depth;
+			subprog_extra_stack = 0;
+		}
+		i++;
+		insn++;
+	}
+
+	env->prog->aux->stack_depth = subprogs[0].stack_depth;
+
+	return 0;
+}
+
+/* Prepare kfunc calls for jiting:
+ * - by replacing insn->imm fields with offsets to real functions;
+ * - or by replacing calls to certain kfuncs using hard-coded templates;
+ * - or by replacing calls to inlinable kfuncs by kfunc bodies.
+ */
+static int resolve_kfunc_calls(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog;
+	struct bpf_insn *insn = prog->insnsi;
+	struct bpf_insn *insn_buf = env->insn_buf;
+	const int insn_cnt = prog->len;
+	struct bpf_prog *new_prog;
+	int i, ret, cnt, delta = 0;
+
+	for (i = 0; i < insn_cnt;) {
+		if (!bpf_pseudo_kfunc_call(insn))
+			goto next_insn;
+
+		ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
+		if (ret)
+			return ret;
+		if (cnt == 0)
+			goto next_insn;
+
+		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+		if (!new_prog)
+			return -ENOMEM;
+
+		delta	 += cnt - 1;
+		env->prog = prog = new_prog;
+		insn	  = new_prog->insnsi + i + delta;
+		goto next_insn;
+
+next_insn:
+		i++;
+		insn++;
+	}
+
+	sort_kfunc_descs_by_imm_off(env->prog);
+
+	return 0;
+}
+
 /* The function requires that first instruction in 'patch' is insnsi[prog->len - 1] */
 static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
 {
@@ -20848,22 +21464,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		if (insn->src_reg == BPF_PSEUDO_CALL)
 			goto next_insn;
-		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
-			ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
-			if (ret)
-				return ret;
-			if (cnt == 0)
-				goto next_insn;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta	 += cnt - 1;
-			env->prog = prog = new_prog;
-			insn	  = new_prog->insnsi + i + delta;
+		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL)
 			goto next_insn;
-		}
 
 		/* Skip inlining the helper call if the JIT does it. */
 		if (bpf_jit_inlines_helper_call(insn->imm))
@@ -21380,6 +21982,15 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1));
 	}
 
+	return 0;
+}
+
+static int notify_map_poke_trackers(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog;
+	struct bpf_map *map_ptr;
+	int i, ret;
+
 	/* Since poke tab is now finalized, publish aux to tracker. */
 	for (i = 0; i < prog->aux->size_poke_tab; i++) {
 		map_ptr = prog->aux->poke_tab[i].tail_call.map;
@@ -21397,8 +22008,6 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 	}
 
-	sort_kfunc_descs_by_imm_off(env->prog);
-
 	return 0;
 }
 
@@ -22558,6 +23167,15 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret == 0)
 		ret = do_misc_fixups(env);
 
+	if (ret == 0)
+		ret = inline_kfunc_calls(env);
+
+	if (ret == 0)
+		ret = resolve_kfunc_calls(env);
+
+	if (ret == 0)
+		ret = notify_map_poke_trackers(env);
+
 	/* do 32-bit optimization after insn patching has done so those patched
 	 * insns could be handled correctly.
 	 */
-- 
2.47.0


