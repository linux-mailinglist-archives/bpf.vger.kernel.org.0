Return-Path: <bpf+bounces-47971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317F7A02D8C
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 17:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A707A2944
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AB51DEFE5;
	Mon,  6 Jan 2025 16:17:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA49C1DE8A2;
	Mon,  6 Jan 2025 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736180240; cv=none; b=V6vExAAtEqaFxKq63mDeqr1BwQKhjqv1zkTH/gRqj9mHm7IdYCei++RQzZuyzvp2R+9ytGKQaXHwl+GH8cw7ufZ/YdUaDI52K5RK7nf+tFv8kJHR0dsYcomDQi27ABXXP6r1RTkrpwqY1aQhiT8Ukmdr4cTmK2g8F6KBaAaW5EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736180240; c=relaxed/simple;
	bh=1qVNaFjP2GDMvD5WosHwebRRzNLxlvK8kZmYCw4kxhc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Br53IhzMgwdxl891SG8Jht2nJl2fVDjNvD2Eage2Sj+qEz9UNn4ozTmJ53hOFhNhYRkWrNsm6dxgpN5whOZI/JfkGBPqNLUKQX6dLej3zlhvngot7iUAnk/6LvqAuszW0l3LhfqPz3O8s1R96Kr89rRXgq72BJj5fAZ+2DqjufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A60C4CED6;
	Mon,  6 Jan 2025 16:17:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tUpoV-00000009J2I-0fFP;
	Mon, 06 Jan 2025 11:18:47 -0500
Message-ID: <20250106161847.008882900@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 06 Jan 2025 11:17:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 bpf <bpf@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Martin  Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [for-next][PATCH 07/14] scripts/sorttable: Replace Elf_Shdr Macro with a union
References: <20250106161726.131794583@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to remove the double #include of sorttable.h for 64 and 32 bit
to create duplicate functions for both, replace the Elf_Shdr macro with a
union that defines both Elf64_Shdr and Elf32_Shdr, with field e64 for the
64bit version, and e32 for the 32bit version.

It can then use the macro etype to get the proper value.

This will eventually be replaced with just single functions that can
handle both 32bit and 64bit ELF parsing.

Cc: bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Cc: Martin  Kelly <martin.kelly@crowdstrike.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/20250105162345.339462681@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 10 ++++++
 scripts/sorttable.h | 74 +++++++++++++++++++++++++--------------------
 2 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 67cbbfc8214d..94497b8ab04c 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -69,6 +69,11 @@ typedef union {
 	Elf64_Ehdr	e64;
 } Elf_Ehdr;
 
+typedef union {
+	Elf32_Shdr	e32;
+	Elf64_Shdr	e64;
+} Elf_Shdr;
+
 static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
@@ -198,6 +203,11 @@ static int compare_extable_64(const void *a, const void *b)
 	return av > bv;
 }
 
+static inline void *get_index(void *start, int entsize, int index)
+{
+	return start + (entsize * index);
+}
+
 /* 32 bit and 64 bit are very similar */
 #include "sorttable.h"
 #define SORTTABLE_64
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index eff204958ffc..034ce8560dad 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -23,7 +23,6 @@
 #undef sort_mcount_loc
 #undef elf_mcount_loc
 #undef do_sort
-#undef Elf_Shdr
 #undef Elf_Sym
 #undef ELF_ST_TYPE
 #undef uint_t
@@ -37,7 +36,6 @@
 # define sort_mcount_loc	sort_mcount_loc_64
 # define elf_mcount_loc		elf_mcount_loc_64
 # define do_sort		do_sort_64
-# define Elf_Shdr		Elf64_Shdr
 # define Elf_Sym		Elf64_Sym
 # define ELF_ST_TYPE		ELF64_ST_TYPE
 # define uint_t			uint64_t
@@ -50,7 +48,6 @@
 # define sort_mcount_loc	sort_mcount_loc_32
 # define elf_mcount_loc		elf_mcount_loc_32
 # define do_sort		do_sort_32
-# define Elf_Shdr		Elf32_Shdr
 # define Elf_Sym		Elf32_Sym
 # define ELF_ST_TYPE		ELF32_ST_TYPE
 # define uint_t			uint32_t
@@ -168,8 +165,8 @@ struct elf_mcount_loc {
 static void *sort_mcount_loc(void *arg)
 {
 	struct elf_mcount_loc *emloc = (struct elf_mcount_loc *)arg;
-	uint_t offset = emloc->start_mcount_loc - _r(&(emloc->init_data_sec)->sh_addr)
-					+ _r(&(emloc->init_data_sec)->sh_offset);
+	uint_t offset = emloc->start_mcount_loc - _r(&(emloc->init_data_sec)->etype.sh_addr)
+					+ _r(&(emloc->init_data_sec)->etype.sh_offset);
 	uint_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
 
@@ -219,10 +216,11 @@ static int do_sort(Elf_Ehdr *ehdr,
 		   table_sort_t custom_sort)
 {
 	int rc = -1;
-	Elf_Shdr *s, *shdr = (Elf_Shdr *)((char *)ehdr + _r(&ehdr->etype.e_shoff));
+	Elf_Shdr *shdr_start;
 	Elf_Shdr *strtab_sec = NULL;
 	Elf_Shdr *symtab_sec = NULL;
 	Elf_Shdr *extab_sec = NULL;
+	Elf_Shdr *string_sec;
 	Elf_Sym *sym;
 	const Elf_Sym *symtab;
 	Elf32_Word *symtab_shndx = NULL;
@@ -232,7 +230,10 @@ static int do_sort(Elf_Ehdr *ehdr,
 	const char *secstrings;
 	const char *strtab;
 	char *extab_image;
+	int sort_need_index;
+	int shentsize;
 	int idx;
+	int i;
 	unsigned int shnum;
 	unsigned int shstrndx;
 #ifdef MCOUNT_SORT_ENABLED
@@ -246,34 +247,40 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int orc_num_entries = 0;
 #endif
 
+	shdr_start = (Elf_Shdr *)((char *)ehdr + _r(&ehdr->etype.e_shoff));
+	shentsize = r2(&ehdr->etype.e_shentsize);
+
 	shstrndx = r2(&ehdr->etype.e_shstrndx);
 	if (shstrndx == SHN_XINDEX)
-		shstrndx = r(&shdr[0].sh_link);
-	secstrings = (const char *)ehdr + _r(&shdr[shstrndx].sh_offset);
+		shstrndx = r(&shdr_start->etype.sh_link);
+	string_sec = get_index(shdr_start, shentsize, shstrndx);
+	secstrings = (const char *)ehdr + _r(&string_sec->etype.sh_offset);
 
 	shnum = r2(&ehdr->etype.e_shnum);
 	if (shnum == SHN_UNDEF)
-		shnum = _r(&shdr[0].sh_size);
+		shnum = _r(&shdr_start->etype.sh_size);
+
+	for (i = 0; i < shnum; i++) {
+		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
 
-	for (s = shdr; s < shdr + shnum; s++) {
-		idx = r(&s->sh_name);
+		idx = r(&shdr->etype.sh_name);
 		if (!strcmp(secstrings + idx, "__ex_table"))
-			extab_sec = s;
+			extab_sec = shdr;
 		if (!strcmp(secstrings + idx, ".symtab"))
-			symtab_sec = s;
+			symtab_sec = shdr;
 		if (!strcmp(secstrings + idx, ".strtab"))
-			strtab_sec = s;
+			strtab_sec = shdr;
 
-		if (r(&s->sh_type) == SHT_SYMTAB_SHNDX)
+		if (r(&shdr->etype.sh_type) == SHT_SYMTAB_SHNDX)
 			symtab_shndx = (Elf32_Word *)((const char *)ehdr +
-						      _r(&s->sh_offset));
+						      _r(&shdr->etype.sh_offset));
 
 #ifdef MCOUNT_SORT_ENABLED
 		/* locate the .init.data section in vmlinux */
 		if (!strcmp(secstrings + idx, ".init.data")) {
 			get_mcount_loc(&_start_mcount_loc, &_stop_mcount_loc);
 			mstruct.ehdr = ehdr;
-			mstruct.init_data_sec = s;
+			mstruct.init_data_sec = shdr;
 			mstruct.start_mcount_loc = _start_mcount_loc;
 			mstruct.stop_mcount_loc = _stop_mcount_loc;
 		}
@@ -282,14 +289,14 @@ static int do_sort(Elf_Ehdr *ehdr,
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 		/* locate the ORC unwind tables */
 		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
-			orc_ip_size = _r(&s->sh_size);
+			orc_ip_size = _r(&shdr->etype.sh_size);
 			g_orc_ip_table = (int *)((void *)ehdr +
-						   _r(&s->sh_offset));
+						   _r(&shdr->etype.sh_offset));
 		}
 		if (!strcmp(secstrings + idx, ".orc_unwind")) {
-			orc_size = _r(&s->sh_size);
+			orc_size = _r(&shdr->etype.sh_size);
 			g_orc_table = (struct orc_entry *)((void *)ehdr +
-							     _r(&s->sh_offset));
+							     _r(&shdr->etype.sh_offset));
 		}
 #endif
 	} /* for loop */
@@ -352,22 +359,22 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 
-	extab_image = (void *)ehdr + _r(&extab_sec->sh_offset);
-	strtab = (const char *)ehdr + _r(&strtab_sec->sh_offset);
+	extab_image = (void *)ehdr + _r(&extab_sec->etype.sh_offset);
+	strtab = (const char *)ehdr + _r(&strtab_sec->etype.sh_offset);
 	symtab = (const Elf_Sym *)((const char *)ehdr +
-						  _r(&symtab_sec->sh_offset));
+						  _r(&symtab_sec->etype.sh_offset));
 
 	if (custom_sort) {
-		custom_sort(extab_image, _r(&extab_sec->sh_size));
+		custom_sort(extab_image, _r(&extab_sec->etype.sh_size));
 	} else {
-		int num_entries = _r(&extab_sec->sh_size) / extable_ent_size;
+		int num_entries = _r(&extab_sec->etype.sh_size) / extable_ent_size;
 		qsort(extab_image, num_entries,
 		      extable_ent_size, compare_extable);
 	}
 
 	/* find the flag main_extable_sort_needed */
-	for (sym = (void *)ehdr + _r(&symtab_sec->sh_offset);
-	     sym < sym + _r(&symtab_sec->sh_size) / sizeof(Elf_Sym);
+	for (sym = (void *)ehdr + _r(&symtab_sec->etype.sh_offset);
+	     sym < sym + _r(&symtab_sec->etype.sh_size) / sizeof(Elf_Sym);
 	     sym++) {
 		if (ELF_ST_TYPE(sym->st_info) != STT_OBJECT)
 			continue;
@@ -385,13 +392,14 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 
-	sort_needed_sec = &shdr[get_secindex(r2(&sym->st_shndx),
-					     sort_needed_sym - symtab,
-					     symtab_shndx)];
+	sort_need_index = get_secindex(r2(&sym->st_shndx),
+				       sort_needed_sym - symtab,
+				       symtab_shndx);
+	sort_needed_sec = get_index(shdr_start, shentsize, sort_need_index);
 	sort_needed_loc = (void *)ehdr +
-		_r(&sort_needed_sec->sh_offset) +
+		_r(&sort_needed_sec->etype.sh_offset) +
 		_r(&sort_needed_sym->st_value) -
-		_r(&sort_needed_sec->sh_addr);
+		_r(&sort_needed_sec->etype.sh_addr);
 
 	/* extable has been sorted, clear the flag */
 	w(0, sort_needed_loc);
-- 
2.45.2



