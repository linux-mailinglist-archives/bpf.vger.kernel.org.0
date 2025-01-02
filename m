Return-Path: <bpf+bounces-47800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7918BA0019F
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 00:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CD23A3B94
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 23:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6CA1C07EA;
	Thu,  2 Jan 2025 23:25:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0241BEF8F;
	Thu,  2 Jan 2025 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860332; cv=none; b=NFnlMhXqS2nJxy/UYpqws23UjIz3hhiJ7F/egbouKYv2eBdiWfOmU3rSUoXM+NXed9lL7fQ9bEjgOd2KbAFvfqq4TRIqOmR+PF1Pe3hjpGCDlasHIBakkKjMOpcttevhAAE+8x4fdi6WYBKMVWA+u+KZ8iSEwBAKAY6IP8W+mB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860332; c=relaxed/simple;
	bh=JIh6w+rJfbF3hMQPwOZmL0LJXaj43J+6TttiH8ZjL0Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BYW0IR84U9pGjLruZZ6EcW4i1Hi7WPzba+VbPMiaX8XrqLpdgpI2ci+DLIe8yXGN3vm9GCw6qhexs+FAJNr0MFJaSiZcmfVco8ulIRyuQR11FQX8NNwgUPuqJ0vYMKdkSEkUdeb2o9rZZu2cOmgdh/+MHpJ9byFiRjcl2U8eWUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77034C4CEE5;
	Thu,  2 Jan 2025 23:25:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTUaX-00000005Ytl-3K2J;
	Thu, 02 Jan 2025 18:26:49 -0500
Message-ID: <20250102232649.645426337@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 18:26:15 -0500
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
Subject: [PATCH v2 06/16] scripts/sorttable: Convert Elf_Ehdr to union
References: <20250102232609.529842248@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to remove the double #include of sorttable.h for 64 and 32 bit
to create duplicate functions for both, replace the Elf_Ehdr macro with a
union that defines both Elf64_Ehdr and Elf32_Ehdr, with field e64 for the
64bit version, and e32 for the 32bit version.

Then a macro etype can be used instead to get to the proper value.

This will eventually be replaced with just single functions that can
handle both 32bit and 64bit ELF parsing.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 36 ++++++++++++++++++++----------------
 scripts/sorttable.h | 12 ++++++------
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 3e2c17e91485..67cbbfc8214d 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -64,6 +64,11 @@
 #define EM_LOONGARCH	258
 #endif
 
+typedef union {
+	Elf32_Ehdr	e32;
+	Elf64_Ehdr	e64;
+} Elf_Ehdr;
+
 static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
@@ -266,10 +271,10 @@ static void sort_relative_table_with_data(char *extab_image, int image_size)
 static int do_file(char const *const fname, void *addr)
 {
 	int rc = -1;
-	Elf32_Ehdr *ehdr = addr;
+	Elf_Ehdr *ehdr = addr;
 	table_sort_t custom_sort = NULL;
 
-	switch (ehdr->e_ident[EI_DATA]) {
+	switch (ehdr->e32.e_ident[EI_DATA]) {
 	case ELFDATA2LSB:
 		r	= rle;
 		r2	= r2le;
@@ -284,18 +289,18 @@ static int do_file(char const *const fname, void *addr)
 		break;
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
-			ehdr->e_ident[EI_DATA], fname);
+			ehdr->e32.e_ident[EI_DATA], fname);
 		return -1;
 	}
 
-	if (memcmp(ELFMAG, ehdr->e_ident, SELFMAG) != 0 ||
-	    (r2(&ehdr->e_type) != ET_EXEC && r2(&ehdr->e_type) != ET_DYN) ||
-	    ehdr->e_ident[EI_VERSION] != EV_CURRENT) {
+	if (memcmp(ELFMAG, ehdr->e32.e_ident, SELFMAG) != 0 ||
+	    (r2(&ehdr->e32.e_type) != ET_EXEC && r2(&ehdr->e32.e_type) != ET_DYN) ||
+	    ehdr->e32.e_ident[EI_VERSION] != EV_CURRENT) {
 		fprintf(stderr, "unrecognized ET_EXEC/ET_DYN file %s\n", fname);
 		return -1;
 	}
 
-	switch (r2(&ehdr->e_machine)) {
+	switch (r2(&ehdr->e32.e_machine)) {
 	case EM_386:
 	case EM_AARCH64:
 	case EM_LOONGARCH:
@@ -318,14 +323,14 @@ static int do_file(char const *const fname, void *addr)
 		break;
 	default:
 		fprintf(stderr, "unrecognized e_machine %d %s\n",
-			r2(&ehdr->e_machine), fname);
+			r2(&ehdr->e32.e_machine), fname);
 		return -1;
 	}
 
-	switch (ehdr->e_ident[EI_CLASS]) {
+	switch (ehdr->e32.e_ident[EI_CLASS]) {
 	case ELFCLASS32:
-		if (r2(&ehdr->e_ehsize) != sizeof(Elf32_Ehdr) ||
-		    r2(&ehdr->e_shentsize) != sizeof(Elf32_Shdr)) {
+		if (r2(&ehdr->e32.e_ehsize) != sizeof(Elf32_Ehdr) ||
+		    r2(&ehdr->e32.e_shentsize) != sizeof(Elf32_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_EXEC/ET_DYN file: %s\n", fname);
 			break;
@@ -334,20 +339,19 @@ static int do_file(char const *const fname, void *addr)
 		break;
 	case ELFCLASS64:
 		{
-		Elf64_Ehdr *const ghdr = (Elf64_Ehdr *)ehdr;
-		if (r2(&ghdr->e_ehsize) != sizeof(Elf64_Ehdr) ||
-		    r2(&ghdr->e_shentsize) != sizeof(Elf64_Shdr)) {
+		if (r2(&ehdr->e64.e_ehsize) != sizeof(Elf64_Ehdr) ||
+		    r2(&ehdr->e64.e_shentsize) != sizeof(Elf64_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_EXEC/ET_DYN file: %s\n",
 				fname);
 			break;
 		}
-		rc = do_sort_64(ghdr, fname, custom_sort);
+		rc = do_sort_64(ehdr, fname, custom_sort);
 		}
 		break;
 	default:
 		fprintf(stderr, "unrecognized ELF class %d %s\n",
-			ehdr->e_ident[EI_CLASS], fname);
+			ehdr->e32.e_ident[EI_CLASS], fname);
 		break;
 	}
 
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 58e9cebe8362..eff204958ffc 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -23,12 +23,12 @@
 #undef sort_mcount_loc
 #undef elf_mcount_loc
 #undef do_sort
-#undef Elf_Ehdr
 #undef Elf_Shdr
 #undef Elf_Sym
 #undef ELF_ST_TYPE
 #undef uint_t
 #undef _r
+#undef etype
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -37,12 +37,12 @@
 # define sort_mcount_loc	sort_mcount_loc_64
 # define elf_mcount_loc		elf_mcount_loc_64
 # define do_sort		do_sort_64
-# define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
 # define Elf_Sym		Elf64_Sym
 # define ELF_ST_TYPE		ELF64_ST_TYPE
 # define uint_t			uint64_t
 # define _r			r8
+# define etype			e64
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -50,12 +50,12 @@
 # define sort_mcount_loc	sort_mcount_loc_32
 # define elf_mcount_loc		elf_mcount_loc_32
 # define do_sort		do_sort_32
-# define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
 # define Elf_Sym		Elf32_Sym
 # define ELF_ST_TYPE		ELF32_ST_TYPE
 # define uint_t			uint32_t
 # define _r			r
+# define etype			e32
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -219,7 +219,7 @@ static int do_sort(Elf_Ehdr *ehdr,
 		   table_sort_t custom_sort)
 {
 	int rc = -1;
-	Elf_Shdr *s, *shdr = (Elf_Shdr *)((char *)ehdr + _r(&ehdr->e_shoff));
+	Elf_Shdr *s, *shdr = (Elf_Shdr *)((char *)ehdr + _r(&ehdr->etype.e_shoff));
 	Elf_Shdr *strtab_sec = NULL;
 	Elf_Shdr *symtab_sec = NULL;
 	Elf_Shdr *extab_sec = NULL;
@@ -246,12 +246,12 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int orc_num_entries = 0;
 #endif
 
-	shstrndx = r2(&ehdr->e_shstrndx);
+	shstrndx = r2(&ehdr->etype.e_shstrndx);
 	if (shstrndx == SHN_XINDEX)
 		shstrndx = r(&shdr[0].sh_link);
 	secstrings = (const char *)ehdr + _r(&shdr[shstrndx].sh_offset);
 
-	shnum = r2(&ehdr->e_shnum);
+	shnum = r2(&ehdr->etype.e_shnum);
 	if (shnum == SHN_UNDEF)
 		shnum = _r(&shdr[0].sh_size);
 
-- 
2.45.2



