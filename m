Return-Path: <bpf+bounces-47766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B25BB9FFF19
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6821883F1D
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53BD1BC062;
	Thu,  2 Jan 2025 18:59:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC751B87E8;
	Thu,  2 Jan 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844388; cv=none; b=HaOy8lNWKkprlxlrLSWmNCgiatMPrpCPiB6+fh2RqDRwea5vkusk1zrLH8Nk68IhcGCzVT+aGIdEYkcVznr85H5YW2vMwcSWLDhTNlpTGTlewTkIA+4eVD8CLyKcxF5q0pRKmJ7eUNm1fraQVgMTOJHk5wsYkpve6XIk0YJ1Zwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844388; c=relaxed/simple;
	bh=agh6dznuHbLGn9kHb90P3Cnz6nybGAllPizve0i6QR4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ef81bbbpYMHuiSAshy5viOWCH/WDZLmRtp/uKqK5eEz4ZAqx2SctAjjkRzbkX3hGJgME82QCtyMCqGBHT+sUlj3YnZiWJ1IhakuMCLaJrbgUrw54d4sVVM7ryt18RqttMDB0eGg25/oB/VGasYc5LvbPtmm+rdxAJgfcYgCD9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F58FC4CEDF;
	Thu,  2 Jan 2025 18:59:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTQRN-00000005MoK-0Yqg;
	Thu, 02 Jan 2025 14:01:05 -0500
Message-ID: <20250102190104.987867871@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 13:58:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Martin  Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 11/14] scripts/sorttable: Add helper functions for Elf_Sym
References: <20250102185845.928488650@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to remove the double #include of sorttable.h for 64 and 32 bit
to create duplicate functions, add helper functions for Elf_Sym.  This
will create a function pointer for each helper that will get assigned to
the appropriate function to handle either the 64bit or 32bit version.

This also removes the last references of etype and _r() macros from the
sorttable.h file as their references are now just defined in the
appropriate architecture version of the helper functions. All read
functions now exist in the helper functions which makes it easier to
maintain, as the helper functions define the necessary architecture sizes.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 scripts/sorttable.h | 30 +++++++++++++++--------------
 2 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index b2b96ff261d6..20615de18276 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -152,6 +152,53 @@ SHDR_WORD(link)
 SHDR_WORD(name)
 SHDR_WORD(type)
 
+#define SYM_ADDR(fn_name)			\
+static uint64_t sym64_##fn_name(Elf_Sym *sym)	\
+{						\
+	return r8(&sym->e64.st_##fn_name);	\
+}						\
+						\
+static uint64_t sym32_##fn_name(Elf_Sym *sym)	\
+{						\
+	return r(&sym->e32.st_##fn_name);	\
+}
+
+#define SYM_WORD(fn_name)			\
+static uint32_t sym64_##fn_name(Elf_Sym *sym)	\
+{						\
+	return r(&sym->e64.st_##fn_name);	\
+}						\
+						\
+static uint32_t sym32_##fn_name(Elf_Sym *sym)	\
+{						\
+	return r(&sym->e32.st_##fn_name);	\
+}
+
+#define SYM_HALF(fn_name)			\
+static uint16_t sym64_##fn_name(Elf_Sym *sym)	\
+{						\
+	return r2(&sym->e64.st_##fn_name);	\
+}						\
+						\
+static uint16_t sym32_##fn_name(Elf_Sym *sym)	\
+{						\
+	return r2(&sym->e32.st_##fn_name);	\
+}
+
+static uint8_t sym64_type(Elf_Sym *sym)
+{
+	return ELF64_ST_TYPE(sym->e64.st_info);
+}
+
+static uint8_t sym32_type(Elf_Sym *sym)
+{
+	return ELF32_ST_TYPE(sym->e32.st_info);
+}
+
+SYM_ADDR(value)
+SYM_WORD(name)
+SYM_HALF(shndx)
+
 /*
  * Get the whole file as a programming convenience in order to avoid
  * malloc+lseek+read+free of many pieces.  If successful, then mmap
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index a391757aaff0..a1c9bdd6b5dd 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -23,10 +23,7 @@
 #undef sort_mcount_loc
 #undef elf_mcount_loc
 #undef do_sort
-#undef ELF_ST_TYPE
 #undef uint_t
-#undef _r
-#undef etype
 #undef ehdr_shoff
 #undef ehdr_shentsize
 #undef ehdr_shstrndx
@@ -38,6 +35,10 @@
 #undef shdr_name
 #undef shdr_type
 #undef shdr_entsize
+#undef sym_type
+#undef sym_name
+#undef sym_value
+#undef sym_shndx
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -46,10 +47,7 @@
 # define sort_mcount_loc	sort_mcount_loc_64
 # define elf_mcount_loc		elf_mcount_loc_64
 # define do_sort		do_sort_64
-# define ELF_ST_TYPE		ELF64_ST_TYPE
 # define uint_t			uint64_t
-# define _r			r8
-# define etype			e64
 # define ehdr_shoff		ehdr64_shoff
 # define ehdr_shentsize		ehdr64_shentsize
 # define ehdr_shstrndx		ehdr64_shstrndx
@@ -61,6 +59,10 @@
 # define shdr_name		shdr64_name
 # define shdr_type		shdr64_type
 # define shdr_entsize		shdr64_entsize
+# define sym_type		sym64_type
+# define sym_name		sym64_name
+# define sym_value		sym64_value
+# define sym_shndx		sym64_shndx
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -68,10 +70,7 @@
 # define sort_mcount_loc	sort_mcount_loc_32
 # define elf_mcount_loc		elf_mcount_loc_32
 # define do_sort		do_sort_32
-# define ELF_ST_TYPE		ELF32_ST_TYPE
 # define uint_t			uint32_t
-# define _r			r
-# define etype			e32
 # define ehdr_shoff		ehdr32_shoff
 # define ehdr_shentsize		ehdr32_shentsize
 # define ehdr_shstrndx		ehdr32_shstrndx
@@ -83,6 +82,10 @@
 # define shdr_name		shdr32_name
 # define shdr_type		shdr32_type
 # define shdr_entsize		shdr32_entsize
+# define sym_type		sym32_type
+# define sym_name		sym32_name
+# define sym_value		sym32_value
+# define sym_shndx		sym32_shndx
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -411,9 +414,9 @@ static int do_sort(Elf_Ehdr *ehdr,
 
 	for (sym = sym_start; (void *)sym + symentsize < sym_end;
 	     sym = (void *)sym + symentsize) {
-		if (ELF_ST_TYPE(sym->etype.st_info) != STT_OBJECT)
+		if (sym_type(sym) != STT_OBJECT)
 			continue;
-		if (!strcmp(strtab + r(&sym->etype.st_name),
+		if (!strcmp(strtab + sym_name(sym),
 			    "main_extable_sort_needed")) {
 			sort_needed_sym = sym;
 			break;
@@ -427,14 +430,13 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 
-	sort_need_index = get_secindex(r2(&sym->etype.st_shndx),
+	sort_need_index = get_secindex(sym_shndx(sym),
 				       ((void *)sort_needed_sym - (void *)symtab) / symentsize,
 				       symtab_shndx);
 	sort_needed_sec = get_index(shdr_start, shentsize, sort_need_index);
 	sort_needed_loc = (void *)ehdr +
 		shdr_offset(sort_needed_sec) +
-		_r(&sort_needed_sym->etype.st_value) -
-		shdr_addr(sort_needed_sec);
+		sym_value(sort_needed_sym) - shdr_addr(sort_needed_sec);
 
 	/* extable has been sorted, clear the flag */
 	w(0, sort_needed_loc);
-- 
2.45.2



