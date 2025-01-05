Return-Path: <bpf+bounces-47899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECFFA01A7C
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 17:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A7216353F
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB31D5175;
	Sun,  5 Jan 2025 16:22:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE81CF5EA;
	Sun,  5 Jan 2025 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094142; cv=none; b=r/9szUTGiW2FFOYo/MWFFXRLO0IAbF/e1Omh4XQQk6Y/6/78kZHeTVDIswyL+1zqK/EN5sc7GtfqYkOTpeU1d3Npz/0wJR82XSivULrmr7hmhuv4dDm4FYDSt2uWoTWxwdXnMQN2JQ3tpYXlFA/bcxAz19cHIbZ8xOtHTGAVWjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094142; c=relaxed/simple;
	bh=ClP2j970xV7E8BGbbxPw4iYrRTf09dl7B9rXPmaBzNk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EQ+BWEVBspD+ul7WX2DqDJCECmpAjYPviu+X29RYxGpDX5KCLERzCs/RU9nL/9pghFc4UEhs9i9jRXNL6+OA9kzWrik0+BGnSfbB22qe2pMu0S5B9mvnfb+M20RznYVu0AVlAUCcoAF7Y4yE96zxegqcffSkcQye8vxEKKpIE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E89FC4CEF4;
	Sun,  5 Jan 2025 16:22:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tUTPm-00000008EvZ-0cZp;
	Sun, 05 Jan 2025 11:23:46 -0500
Message-ID: <20250105162345.940924221@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 05 Jan 2025 11:22:21 -0500
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
Subject: [PATCH 10/14] scripts/sorttable: Add helper functions for Elf_Shdr
References: <20250105162211.971039541@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to remove the double #include of sorttable.h for 64 and 32 bit
to create duplicate functions, add helper functions for Elf_Shdr.  This
will create a function pointer for each helper that will get assigned to
the appropriate function to handle either the 64bit or 32bit version.

This also moves the _r()/r() wrappers for the Elf_Shdr references that
handle endian and size differences between the different architectures,
into the helper function and out of the open code which is more error
prone.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 42 +++++++++++++++++++++++++++++
 scripts/sorttable.h | 66 +++++++++++++++++++++++++++++----------------
 2 files changed, 85 insertions(+), 23 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 5dfa734eff09..b2b96ff261d6 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -110,6 +110,48 @@ EHDR_HALF(shentsize)
 EHDR_HALF(shstrndx)
 EHDR_HALF(shnum)
 
+#define SHDR_WORD(fn_name)				\
+static uint32_t shdr64_##fn_name(Elf_Shdr *shdr)	\
+{							\
+	return r(&shdr->e64.sh_##fn_name);		\
+}							\
+							\
+static uint32_t shdr32_##fn_name(Elf_Shdr *shdr)	\
+{							\
+	return r(&shdr->e32.sh_##fn_name);		\
+}
+
+#define SHDR_ADDR(fn_name)				\
+static uint64_t shdr64_##fn_name(Elf_Shdr *shdr)	\
+{							\
+	return r8(&shdr->e64.sh_##fn_name);		\
+}							\
+							\
+static uint64_t shdr32_##fn_name(Elf_Shdr *shdr)	\
+{							\
+	return r(&shdr->e32.sh_##fn_name);		\
+}
+
+#define SHDR_WORD(fn_name)				\
+static uint32_t shdr64_##fn_name(Elf_Shdr *shdr)	\
+{							\
+	return r(&shdr->e64.sh_##fn_name);		\
+}							\
+							\
+static uint32_t shdr32_##fn_name(Elf_Shdr *shdr)	\
+{							\
+	return r(&shdr->e32.sh_##fn_name);		\
+}
+
+SHDR_ADDR(addr)
+SHDR_ADDR(offset)
+SHDR_ADDR(size)
+SHDR_ADDR(entsize)
+
+SHDR_WORD(link)
+SHDR_WORD(name)
+SHDR_WORD(type)
+
 /*
  * Get the whole file as a programming convenience in order to avoid
  * malloc+lseek+read+free of many pieces.  If successful, then mmap
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 3855f2ad0e73..a391757aaff0 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -31,6 +31,13 @@
 #undef ehdr_shentsize
 #undef ehdr_shstrndx
 #undef ehdr_shnum
+#undef shdr_addr
+#undef shdr_offset
+#undef shdr_link
+#undef shdr_size
+#undef shdr_name
+#undef shdr_type
+#undef shdr_entsize
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -47,6 +54,13 @@
 # define ehdr_shentsize		ehdr64_shentsize
 # define ehdr_shstrndx		ehdr64_shstrndx
 # define ehdr_shnum		ehdr64_shnum
+# define shdr_addr		shdr64_addr
+# define shdr_offset		shdr64_offset
+# define shdr_link		shdr64_link
+# define shdr_size		shdr64_size
+# define shdr_name		shdr64_name
+# define shdr_type		shdr64_type
+# define shdr_entsize		shdr64_entsize
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -62,6 +76,13 @@
 # define ehdr_shentsize		ehdr32_shentsize
 # define ehdr_shstrndx		ehdr32_shstrndx
 # define ehdr_shnum		ehdr32_shnum
+# define shdr_addr		shdr32_addr
+# define shdr_offset		shdr32_offset
+# define shdr_link		shdr32_link
+# define shdr_size		shdr32_size
+# define shdr_name		shdr32_name
+# define shdr_type		shdr32_type
+# define shdr_entsize		shdr32_entsize
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -174,8 +195,8 @@ struct elf_mcount_loc {
 static void *sort_mcount_loc(void *arg)
 {
 	struct elf_mcount_loc *emloc = (struct elf_mcount_loc *)arg;
-	uint_t offset = emloc->start_mcount_loc - _r(&(emloc->init_data_sec)->etype.sh_addr)
-					+ _r(&(emloc->init_data_sec)->etype.sh_offset);
+	uint_t offset = emloc->start_mcount_loc - shdr_addr(emloc->init_data_sec)
+					+ shdr_offset(emloc->init_data_sec);
 	uint_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
 
@@ -264,18 +285,18 @@ static int do_sort(Elf_Ehdr *ehdr,
 
 	shstrndx = ehdr_shstrndx(ehdr);
 	if (shstrndx == SHN_XINDEX)
-		shstrndx = r(&shdr_start->etype.sh_link);
+		shstrndx = shdr_link(shdr_start);
 	string_sec = get_index(shdr_start, shentsize, shstrndx);
-	secstrings = (const char *)ehdr + _r(&string_sec->etype.sh_offset);
+	secstrings = (const char *)ehdr + shdr_offset(string_sec);
 
 	shnum = ehdr_shnum(ehdr);
 	if (shnum == SHN_UNDEF)
-		shnum = _r(&shdr_start->etype.sh_size);
+		shnum = shdr_size(shdr_start);
 
 	for (i = 0; i < shnum; i++) {
 		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
 
-		idx = r(&shdr->etype.sh_name);
+		idx = shdr_name(shdr);
 		if (!strcmp(secstrings + idx, "__ex_table"))
 			extab_sec = shdr;
 		if (!strcmp(secstrings + idx, ".symtab"))
@@ -283,9 +304,9 @@ static int do_sort(Elf_Ehdr *ehdr,
 		if (!strcmp(secstrings + idx, ".strtab"))
 			strtab_sec = shdr;
 
-		if (r(&shdr->etype.sh_type) == SHT_SYMTAB_SHNDX)
+		if (shdr_type(shdr) == SHT_SYMTAB_SHNDX)
 			symtab_shndx = (Elf32_Word *)((const char *)ehdr +
-						      _r(&shdr->etype.sh_offset));
+						      shdr_offset(shdr));
 
 #ifdef MCOUNT_SORT_ENABLED
 		/* locate the .init.data section in vmlinux */
@@ -301,14 +322,14 @@ static int do_sort(Elf_Ehdr *ehdr,
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 		/* locate the ORC unwind tables */
 		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
-			orc_ip_size = _r(&shdr->etype.sh_size);
+			orc_ip_size = shdr_size(shdr);
 			g_orc_ip_table = (int *)((void *)ehdr +
-						   _r(&shdr->etype.sh_offset));
+						   shdr_offset(shdr));
 		}
 		if (!strcmp(secstrings + idx, ".orc_unwind")) {
-			orc_size = _r(&shdr->etype.sh_size);
+			orc_size = shdr_size(shdr);
 			g_orc_table = (struct orc_entry *)((void *)ehdr +
-							     _r(&shdr->etype.sh_offset));
+							     shdr_offset(shdr));
 		}
 #endif
 	} /* for loop */
@@ -371,23 +392,22 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 
-	extab_image = (void *)ehdr + _r(&extab_sec->etype.sh_offset);
-	strtab = (const char *)ehdr + _r(&strtab_sec->etype.sh_offset);
-	symtab = (const Elf_Sym *)((const char *)ehdr +
-						  _r(&symtab_sec->etype.sh_offset));
+	extab_image = (void *)ehdr + shdr_offset(extab_sec);
+	strtab = (const char *)ehdr + shdr_offset(strtab_sec);
+	symtab = (const Elf_Sym *)((const char *)ehdr + shdr_offset(symtab_sec));
 
 	if (custom_sort) {
-		custom_sort(extab_image, _r(&extab_sec->etype.sh_size));
+		custom_sort(extab_image, shdr_size(extab_sec));
 	} else {
-		int num_entries = _r(&extab_sec->etype.sh_size) / extable_ent_size;
+		int num_entries = shdr_size(extab_sec) / extable_ent_size;
 		qsort(extab_image, num_entries,
 		      extable_ent_size, compare_extable);
 	}
 
 	/* find the flag main_extable_sort_needed */
-	sym_start = (void *)ehdr + _r(&symtab_sec->etype.sh_offset);
-	sym_end = sym_start + _r(&symtab_sec->etype.sh_size);
-	symentsize = _r(&symtab_sec->etype.sh_entsize);
+	sym_start = (void *)ehdr + shdr_offset(symtab_sec);
+	sym_end = sym_start + shdr_size(symtab_sec);
+	symentsize = shdr_entsize(symtab_sec);
 
 	for (sym = sym_start; (void *)sym + symentsize < sym_end;
 	     sym = (void *)sym + symentsize) {
@@ -412,9 +432,9 @@ static int do_sort(Elf_Ehdr *ehdr,
 				       symtab_shndx);
 	sort_needed_sec = get_index(shdr_start, shentsize, sort_need_index);
 	sort_needed_loc = (void *)ehdr +
-		_r(&sort_needed_sec->etype.sh_offset) +
+		shdr_offset(sort_needed_sec) +
 		_r(&sort_needed_sym->etype.st_value) -
-		_r(&sort_needed_sec->etype.sh_addr);
+		shdr_addr(sort_needed_sec);
 
 	/* extable has been sorted, clear the flag */
 	w(0, sort_needed_loc);
-- 
2.45.2



