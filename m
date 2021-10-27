Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD52E43C5D4
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 10:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbhJ0JBD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 05:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbhJ0JA5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 05:00:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77107C061243
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AhJwxdEMRSqMVIBlZnGMsFJhBe8SHKeA6ROfCpOnGyw=; b=gR/phaPmdi2gVjXMn1mH4QTHXd
        Zh4OCL5bxvH1voxWfeqRoeExuNlewXwBNCp/dpSN5wqtZzqa3hLYUSx3KcuYQ2mpAVkjzev4Oerpk
        s+ENiWsJgIJm4lTnH4MklUWjCNQvXjlkit8Owvqvj/6zsEjILSfAGpoisy+hmybPRF92ylXY2ZyWB
        jZbTzVVOlnALldlqSFZ20oMmKU0f3++K1PqlBYol8nhtVICGTXSBbXyWJ5cMz/xFxx71By6Dj1gBR
        Gs5MAeNdCerlzNBns2Lq88b7A2+OgEYpwgUuOGw9K42VOB+iJddVf1W0w5roZBGj2p1rLdFaowYlL
        f7bL136w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfelQ-00CWVz-2U
        for bpf@vger.kernel.org; Wed, 27 Oct 2021 08:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A34D30087D
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 76F96236E43DD; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Message-ID: <20211027085520.358726252@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 10:52:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 05/17] objtool,x86: Replace alternatives with .retpoline_sites
References: <20211027085243.008677168@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of writing complete alternatives, simply provide a list of all
the retpoline thunk calls. Then the kernel is free to do with them as
it pleases. Simpler code all-round.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/vmlinux.lds.S       |   14 +++
 tools/objtool/arch/x86/decode.c     |  120 --------------------------------
 tools/objtool/check.c               |  132 +++++++++++++++++++++++++-----------
 tools/objtool/elf.c                 |   84 ----------------------
 tools/objtool/include/objtool/elf.h |    1 
 tools/objtool/special.c             |    8 --
 6 files changed, 107 insertions(+), 252 deletions(-)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -272,6 +272,20 @@ SECTIONS
 		__parainstructions_end = .;
 	}
 
+#ifdef CONFIG_RETPOLINE
+	/*
+	 * List of instructions that call/jmp/jcc to retpoline thunks
+	 * __x86_indirect_thunk_*(). These instructions can be patched along
+	 * with alternatives, after which the section can be freed.
+	 */
+	. = ALIGN(8);
+	.retpoline_sites : AT(ADDR(.retpoline_sites) - LOAD_OFFSET) {
+		__retpoline_sites = .;
+		*(.retpoline_sites)
+		__retpoline_sites_end = .;
+	}
+#endif
+
 	/*
 	 * struct alt_inst entries. From the header (alternative.h):
 	 * "Alternative instructions for different CPU types or capabilities"
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -679,126 +679,6 @@ const char *arch_ret_insn(int len)
 	return ret[len-1];
 }
 
-/* asm/alternative.h ? */
-
-#define ALTINSTR_FLAG_INV	(1 << 15)
-#define ALT_NOT(feat)		((feat) | ALTINSTR_FLAG_INV)
-
-struct alt_instr {
-	s32 instr_offset;	/* original instruction */
-	s32 repl_offset;	/* offset to replacement instruction */
-	u16 cpuid;		/* cpuid bit set for replacement */
-	u8  instrlen;		/* length of original instruction */
-	u8  replacementlen;	/* length of new instruction */
-} __packed;
-
-static int elf_add_alternative(struct elf *elf,
-			       struct instruction *orig, struct symbol *sym,
-			       int cpuid, u8 orig_len, u8 repl_len)
-{
-	const int size = sizeof(struct alt_instr);
-	struct alt_instr *alt;
-	struct section *sec;
-	Elf_Scn *s;
-
-	sec = find_section_by_name(elf, ".altinstructions");
-	if (!sec) {
-		sec = elf_create_section(elf, ".altinstructions",
-					 SHF_ALLOC, size, 0);
-
-		if (!sec) {
-			WARN_ELF("elf_create_section");
-			return -1;
-		}
-	}
-
-	s = elf_getscn(elf->elf, sec->idx);
-	if (!s) {
-		WARN_ELF("elf_getscn");
-		return -1;
-	}
-
-	sec->data = elf_newdata(s);
-	if (!sec->data) {
-		WARN_ELF("elf_newdata");
-		return -1;
-	}
-
-	sec->data->d_size = size;
-	sec->data->d_align = 1;
-
-	alt = sec->data->d_buf = malloc(size);
-	if (!sec->data->d_buf) {
-		perror("malloc");
-		return -1;
-	}
-	memset(sec->data->d_buf, 0, size);
-
-	if (elf_add_reloc_to_insn(elf, sec, sec->sh.sh_size,
-				  R_X86_64_PC32, orig->sec, orig->offset)) {
-		WARN("elf_create_reloc: alt_instr::instr_offset");
-		return -1;
-	}
-
-	if (elf_add_reloc(elf, sec, sec->sh.sh_size + 4,
-			  R_X86_64_PC32, sym, 0)) {
-		WARN("elf_create_reloc: alt_instr::repl_offset");
-		return -1;
-	}
-
-	alt->cpuid = bswap_if_needed(cpuid);
-	alt->instrlen = orig_len;
-	alt->replacementlen = repl_len;
-
-	sec->sh.sh_size += size;
-	sec->changed = true;
-
-	return 0;
-}
-
-#define X86_FEATURE_RETPOLINE                ( 7*32+12)
-
-int arch_rewrite_retpolines(struct objtool_file *file)
-{
-	struct instruction *insn;
-	struct reloc *reloc;
-	struct symbol *sym;
-	char name[32] = "";
-
-	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
-
-		if (insn->type != INSN_JUMP_DYNAMIC &&
-		    insn->type != INSN_CALL_DYNAMIC)
-			continue;
-
-		if (!strcmp(insn->sec->name, ".text.__x86.indirect_thunk"))
-			continue;
-
-		reloc = insn->reloc;
-
-		sprintf(name, "__x86_indirect_alt_%s_%s",
-			insn->type == INSN_JUMP_DYNAMIC ? "jmp" : "call",
-			reloc->sym->name + 21);
-
-		sym = find_symbol_by_name(file->elf, name);
-		if (!sym) {
-			sym = elf_create_undef_symbol(file->elf, name);
-			if (!sym) {
-				WARN("elf_create_undef_symbol");
-				return -1;
-			}
-		}
-
-		if (elf_add_alternative(file->elf, insn, sym,
-					ALT_NOT(X86_FEATURE_RETPOLINE), 5, 5)) {
-			WARN("elf_add_alternative");
-			return -1;
-		}
-	}
-
-	return 0;
-}
-
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 {
 	struct cfi_reg *cfa = &insn->cfi.cfa;
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -531,6 +531,52 @@ static int create_static_call_sections(s
 	return 0;
 }
 
+static int create_retpoline_sites_sections(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct section *sec;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".retpoline_sites");
+	if (sec) {
+		WARN("file already has .retpoline_sites, skipping");
+		return 0;
+	}
+
+	idx = 0;
+	list_for_each_entry(insn, &file->retpoline_call_list, call_node)
+		idx++;
+
+	if (!idx)
+		return 0;
+
+	sec = elf_create_section(file->elf, ".retpoline_sites", 0,
+				 sizeof(int), idx);
+	if (!sec) {
+		WARN("elf_create_section: .retpoline_sites");
+		return -1;
+	}
+
+	idx = 0;
+	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
+
+		int *site = (int *)sec->data->d_buf + idx;
+		*site = 0;
+
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(int),
+					  R_X86_64_PC32,
+					  insn->sec, insn->offset)) {
+			WARN("elf_add_reloc_to_insn: .retpoline_sites");
+			return -1;
+		}
+
+		idx++;
+	}
+
+	return 0;
+}
+
 static int create_mcount_loc_sections(struct objtool_file *file)
 {
 	struct section *sec;
@@ -861,6 +907,11 @@ static void annotate_call_site(struct ob
 		return;
 	}
 
+	if (sym->retpoline_thunk) {
+		list_add_tail(&insn->call_node, &file->retpoline_call_list);
+		return;
+	}
+
 	/*
 	 * Many compilers cannot disable KCOV with a function attribute
 	 * so they need a little help, NOP out any KCOV calls from noinstr
@@ -920,6 +971,39 @@ static void add_call_dest(struct objtool
 	annotate_call_site(file, insn, sibling);
 }
 
+static void add_retpoline_call(struct objtool_file *file, struct instruction *insn)
+{
+	/*
+	 * Retpoline calls/jumps are really dynamic calls/jumps in disguise,
+	 * so convert them accordingly.
+	 */
+	switch (insn->type) {
+	case INSN_CALL:
+		insn->type = INSN_CALL_DYNAMIC;
+		break;
+	case INSN_JUMP_UNCONDITIONAL:
+		insn->type = INSN_JUMP_DYNAMIC;
+		break;
+	case INSN_JUMP_CONDITIONAL:
+		insn->type = INSN_JUMP_DYNAMIC_CONDITIONAL;
+		break;
+	default:
+		return;
+	}
+
+	insn->retpoline_safe = true;
+
+	/*
+	 * Whatever stack impact regular CALLs have, should be undone
+	 * by the RETURN of the called function.
+	 *
+	 * Annotated intra-function calls retain the stack_ops but
+	 * are converted to JUMP, see read_intra_function_calls().
+	 */
+	remove_insn_ops(insn);
+
+	annotate_call_site(file, insn, false);
+}
 /*
  * Find the destination instructions for all jumps.
  */
@@ -942,19 +1026,7 @@ static int add_jump_destinations(struct
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
 		} else if (reloc->sym->retpoline_thunk) {
-			/*
-			 * Retpoline jumps are really dynamic jumps in
-			 * disguise, so convert them accordingly.
-			 */
-			if (insn->type == INSN_JUMP_UNCONDITIONAL)
-				insn->type = INSN_JUMP_DYNAMIC;
-			else
-				insn->type = INSN_JUMP_DYNAMIC_CONDITIONAL;
-
-			list_add_tail(&insn->call_node,
-				      &file->retpoline_call_list);
-
-			insn->retpoline_safe = true;
+			add_retpoline_call(file, insn);
 			continue;
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
@@ -1083,18 +1155,7 @@ static int add_call_destinations(struct
 			add_call_dest(file, insn, dest, false);
 
 		} else if (reloc->sym->retpoline_thunk) {
-			/*
-			 * Retpoline calls are really dynamic calls in
-			 * disguise, so convert them accordingly.
-			 */
-			insn->type = INSN_CALL_DYNAMIC;
-			insn->retpoline_safe = true;
-
-			list_add_tail(&insn->call_node,
-				      &file->retpoline_call_list);
-
-			remove_insn_ops(insn);
-			continue;
+			add_retpoline_call(file, insn);
 
 		} else
 			add_call_dest(file, insn, reloc->sym, false);
@@ -1820,11 +1881,6 @@ static void mark_rodata(struct objtool_f
 	file->rodata = found;
 }
 
-__weak int arch_rewrite_retpolines(struct objtool_file *file)
-{
-	return 0;
-}
-
 static int decode_sections(struct objtool_file *file)
 {
 	int ret;
@@ -1893,15 +1949,6 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	/*
-	 * Must be after add_special_section_alts(), since this will emit
-	 * alternatives. Must be after add_{jump,call}_destination(), since
-	 * those create the call insn lists.
-	 */
-	ret = arch_rewrite_retpolines(file);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
@@ -3225,6 +3272,13 @@ int check(struct objtool_file *file)
 		goto out;
 	warnings += ret;
 
+	if (retpoline) {
+		ret = create_retpoline_sites_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
 	if (mcount) {
 		ret = create_mcount_loc_sections(file);
 		if (ret < 0)
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -741,90 +741,6 @@ static int elf_add_string(struct elf *el
 	return len;
 }
 
-struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
-{
-	struct section *symtab, *symtab_shndx;
-	struct symbol *sym;
-	Elf_Data *data;
-	Elf_Scn *s;
-
-	sym = malloc(sizeof(*sym));
-	if (!sym) {
-		perror("malloc");
-		return NULL;
-	}
-	memset(sym, 0, sizeof(*sym));
-
-	sym->name = strdup(name);
-
-	sym->sym.st_name = elf_add_string(elf, NULL, sym->name);
-	if (sym->sym.st_name == -1)
-		return NULL;
-
-	sym->sym.st_info = GELF_ST_INFO(STB_GLOBAL, STT_NOTYPE);
-	// st_other 0
-	// st_shndx 0
-	// st_value 0
-	// st_size 0
-
-	symtab = find_section_by_name(elf, ".symtab");
-	if (!symtab) {
-		WARN("can't find .symtab");
-		return NULL;
-	}
-
-	s = elf_getscn(elf->elf, symtab->idx);
-	if (!s) {
-		WARN_ELF("elf_getscn");
-		return NULL;
-	}
-
-	data = elf_newdata(s);
-	if (!data) {
-		WARN_ELF("elf_newdata");
-		return NULL;
-	}
-
-	data->d_buf = &sym->sym;
-	data->d_size = sizeof(sym->sym);
-	data->d_align = 1;
-	data->d_type = ELF_T_SYM;
-
-	sym->idx = symtab->len / sizeof(sym->sym);
-
-	symtab->len += data->d_size;
-	symtab->changed = true;
-
-	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
-	if (symtab_shndx) {
-		s = elf_getscn(elf->elf, symtab_shndx->idx);
-		if (!s) {
-			WARN_ELF("elf_getscn");
-			return NULL;
-		}
-
-		data = elf_newdata(s);
-		if (!data) {
-			WARN_ELF("elf_newdata");
-			return NULL;
-		}
-
-		data->d_buf = &sym->sym.st_size; /* conveniently 0 */
-		data->d_size = sizeof(Elf32_Word);
-		data->d_align = 4;
-		data->d_type = ELF_T_WORD;
-
-		symtab_shndx->len += 4;
-		symtab_shndx->changed = true;
-	}
-
-	sym->sec = find_section_by_index(elf, 0);
-
-	elf_add_symbol(elf, sym);
-
-	return sym;
-}
-
 struct section *elf_create_section(struct elf *elf, const char *name,
 				   unsigned int sh_flags, size_t entsize, int nr)
 {
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -144,7 +144,6 @@ int elf_write_insn(struct elf *elf, stru
 		   unsigned long offset, unsigned int len,
 		   const char *insn);
 int elf_write_reloc(struct elf *elf, struct reloc *reloc);
-struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name);
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -108,14 +108,6 @@ static int get_alt_entry(struct elf *elf
 			return -1;
 		}
 
-		/*
-		 * Skip retpoline .altinstr_replacement... we already rewrite the
-		 * instructions for retpolines anyway, see arch_is_retpoline()
-		 * usage in add_{call,jump}_destinations().
-		 */
-		if (arch_is_retpoline(new_reloc->sym))
-			return 1;
-
 		alt->new_sec = new_reloc->sym->sec;
 		alt->new_off = (unsigned int)new_reloc->addend;
 


