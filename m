Return-Path: <bpf+bounces-48550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A805FA0911F
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 13:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01F41690A9
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 12:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A3520C472;
	Fri, 10 Jan 2025 12:53:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E63EDF78;
	Fri, 10 Jan 2025 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513606; cv=none; b=li5JMY/GLRI14UUrfVeNvemjLLPM1yfRqDbjo+C9IN5gAYS5vmRfII/L+oi1Bc7NmgcM9V/5w6wxzQDduS5KxfTL85RrOnhsaMDpqhhxjvR/nuXLgO6f5wnunGPy+QTlgMG+Y/vf7wBZq5HGYrCobyIN/NdBeJwnlWZYujbSBBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513606; c=relaxed/simple;
	bh=SJ3TBMOoDJ40inNQuVGmFuMyCXGKQlxuna+FW+lCKEk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IyfpltZI4pW47nYQHP7DOSgAYmBFpl8x/o/gW6fhPwkh/wMCt7/I5E9euqvaWAw0+KA85SO92oGag2uyfIaO9f5y9z02yyHY9fiaDNAX3iWzN2yeakmkh6E6X9aoD5vJFzHnB72GT7/WlZqs+uI/vvapGVUJUPUXS26miubRhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FFDC4CED6;
	Fri, 10 Jan 2025 12:53:23 +0000 (UTC)
Date: Fri, 10 Jan 2025 07:54:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian
 <zhengyejian1@huawei.com>, Martin Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] scripts/sorttable: Use a structure of function pointers for
 elf helpers
Message-ID: <20250110075459.13d4b94c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

Instead of having a series of function pointers that gets assigned to the
Elf64 or Elf32 versions, put them all into a single structure and use
that. Add the helper function that chooses the structure into the macros
that build the different versions of the elf functions.

Link: https://lore.kernel.org/all/CAHk-=wiafEyX7UgOeZgvd6fvuByE5WXUPh9599kwOc_d-pdeug@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 175 +++++++++++++++++++++++++++++---------------
 1 file changed, 118 insertions(+), 57 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 656c1e9b5ad9..9f41575afd7a 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -85,6 +85,25 @@ static uint64_t (*r8)(const uint64_t *);
 static void (*w)(uint32_t, uint32_t *);
 typedef void (*table_sort_t)(char *, int);
 
+static struct elf_funcs {
+	int (*compare_extable)(const void *a, const void *b);
+	uint64_t (*ehdr_shoff)(Elf_Ehdr *ehdr);
+	uint16_t (*ehdr_shstrndx)(Elf_Ehdr *ehdr);
+	uint16_t (*ehdr_shentsize)(Elf_Ehdr *ehdr);
+	uint16_t (*ehdr_shnum)(Elf_Ehdr *ehdr);
+	uint64_t (*shdr_addr)(Elf_Shdr *shdr);
+	uint64_t (*shdr_offset)(Elf_Shdr *shdr);
+	uint64_t (*shdr_size)(Elf_Shdr *shdr);
+	uint64_t (*shdr_entsize)(Elf_Shdr *shdr);
+	uint32_t (*shdr_link)(Elf_Shdr *shdr);
+	uint32_t (*shdr_name)(Elf_Shdr *shdr);
+	uint32_t (*shdr_type)(Elf_Shdr *shdr);
+	uint8_t (*sym_type)(Elf_Sym *sym);
+	uint32_t (*sym_name)(Elf_Sym *sym);
+	uint64_t (*sym_value)(Elf_Sym *sym);
+	uint16_t (*sym_shndx)(Elf_Sym *sym);
+} e;
+
 static uint64_t ehdr64_shoff(Elf_Ehdr *ehdr)
 {
 	return r8(&ehdr->e64.e_shoff);
@@ -95,6 +114,11 @@ static uint64_t ehdr32_shoff(Elf_Ehdr *ehdr)
 	return r(&ehdr->e32.e_shoff);
 }
 
+static uint64_t ehdr_shoff(Elf_Ehdr *ehdr)
+{
+	return e.ehdr_shoff(ehdr);
+}
+
 #define EHDR_HALF(fn_name)				\
 static uint16_t ehdr64_##fn_name(Elf_Ehdr *ehdr)	\
 {							\
@@ -104,6 +128,11 @@ static uint16_t ehdr64_##fn_name(Elf_Ehdr *ehdr)	\
 static uint16_t ehdr32_##fn_name(Elf_Ehdr *ehdr)	\
 {							\
 	return r2(&ehdr->e32.e_##fn_name);		\
+}							\
+							\
+static uint16_t ehdr_##fn_name(Elf_Ehdr *ehdr)		\
+{							\
+	return e.ehdr_##fn_name(ehdr);			\
 }
 
 EHDR_HALF(shentsize)
@@ -119,6 +148,11 @@ static uint32_t shdr64_##fn_name(Elf_Shdr *shdr)	\
 static uint32_t shdr32_##fn_name(Elf_Shdr *shdr)	\
 {							\
 	return r(&shdr->e32.sh_##fn_name);		\
+}							\
+							\
+static uint32_t shdr_##fn_name(Elf_Shdr *shdr)		\
+{							\
+	return e.shdr_##fn_name(shdr);			\
 }
 
 #define SHDR_ADDR(fn_name)				\
@@ -130,6 +164,11 @@ static uint64_t shdr64_##fn_name(Elf_Shdr *shdr)	\
 static uint64_t shdr32_##fn_name(Elf_Shdr *shdr)	\
 {							\
 	return r(&shdr->e32.sh_##fn_name);		\
+}							\
+							\
+static uint64_t shdr_##fn_name(Elf_Shdr *shdr)		\
+{							\
+	return e.shdr_##fn_name(shdr);			\
 }
 
 #define SHDR_WORD(fn_name)				\
@@ -141,6 +180,10 @@ static uint32_t shdr64_##fn_name(Elf_Shdr *shdr)	\
 static uint32_t shdr32_##fn_name(Elf_Shdr *shdr)	\
 {							\
 	return r(&shdr->e32.sh_##fn_name);		\
+}							\
+static uint32_t shdr_##fn_name(Elf_Shdr *shdr)		\
+{							\
+	return e.shdr_##fn_name(shdr);			\
 }
 
 SHDR_ADDR(addr)
@@ -161,6 +204,11 @@ static uint64_t sym64_##fn_name(Elf_Sym *sym)	\
 static uint64_t sym32_##fn_name(Elf_Sym *sym)	\
 {						\
 	return r(&sym->e32.st_##fn_name);	\
+}						\
+						\
+static uint64_t sym_##fn_name(Elf_Sym *sym)	\
+{						\
+	return e.sym_##fn_name(sym);		\
 }
 
 #define SYM_WORD(fn_name)			\
@@ -172,6 +220,11 @@ static uint32_t sym64_##fn_name(Elf_Sym *sym)	\
 static uint32_t sym32_##fn_name(Elf_Sym *sym)	\
 {						\
 	return r(&sym->e32.st_##fn_name);	\
+}						\
+						\
+static uint32_t sym_##fn_name(Elf_Sym *sym)	\
+{						\
+	return e.sym_##fn_name(sym);		\
 }
 
 #define SYM_HALF(fn_name)			\
@@ -183,6 +236,11 @@ static uint16_t sym64_##fn_name(Elf_Sym *sym)	\
 static uint16_t sym32_##fn_name(Elf_Sym *sym)	\
 {						\
 	return r2(&sym->e32.st_##fn_name);	\
+}						\
+						\
+static uint16_t sym_##fn_name(Elf_Sym *sym)	\
+{						\
+	return e.sym_##fn_name(sym);		\
 }
 
 static uint8_t sym64_type(Elf_Sym *sym)
@@ -195,6 +253,11 @@ static uint8_t sym32_type(Elf_Sym *sym)
 	return ELF32_ST_TYPE(sym->e32.st_info);
 }
 
+static uint8_t sym_type(Elf_Sym *sym)
+{
+	return e.sym_type(sym);
+}
+
 SYM_ADDR(value)
 SYM_WORD(name)
 SYM_HALF(shndx)
@@ -322,29 +385,16 @@ static int compare_extable_64(const void *a, const void *b)
 	return av > bv;
 }
 
+static int compare_extable(const void *a, const void *b)
+{
+	return e.compare_extable(a, b);
+}
+
 static inline void *get_index(void *start, int entsize, int index)
 {
 	return start + (entsize * index);
 }
 
-
-static int (*compare_extable)(const void *a, const void *b);
-static uint64_t (*ehdr_shoff)(Elf_Ehdr *ehdr);
-static uint16_t (*ehdr_shstrndx)(Elf_Ehdr *ehdr);
-static uint16_t (*ehdr_shentsize)(Elf_Ehdr *ehdr);
-static uint16_t (*ehdr_shnum)(Elf_Ehdr *ehdr);
-static uint64_t (*shdr_addr)(Elf_Shdr *shdr);
-static uint64_t (*shdr_offset)(Elf_Shdr *shdr);
-static uint64_t (*shdr_size)(Elf_Shdr *shdr);
-static uint64_t (*shdr_entsize)(Elf_Shdr *shdr);
-static uint32_t (*shdr_link)(Elf_Shdr *shdr);
-static uint32_t (*shdr_name)(Elf_Shdr *shdr);
-static uint32_t (*shdr_type)(Elf_Shdr *shdr);
-static uint8_t (*sym_type)(Elf_Sym *sym);
-static uint32_t (*sym_name)(Elf_Sym *sym);
-static uint64_t (*sym_value)(Elf_Sym *sym);
-static uint16_t (*sym_shndx)(Elf_Sym *sym);
-
 static int extable_ent_size;
 static int long_size;
 
@@ -864,7 +914,30 @@ static int do_file(char const *const fname, void *addr)
 	}
 
 	switch (ehdr->e32.e_ident[EI_CLASS]) {
-	case ELFCLASS32:
+	case ELFCLASS32: {
+		struct elf_funcs efuncs = {
+			.compare_extable	= compare_extable_32,
+			.ehdr_shoff		= ehdr32_shoff,
+			.ehdr_shentsize		= ehdr32_shentsize,
+			.ehdr_shstrndx		= ehdr32_shstrndx,
+			.ehdr_shnum		= ehdr32_shnum,
+			.shdr_addr		= shdr32_addr,
+			.shdr_offset		= shdr32_offset,
+			.shdr_link		= shdr32_link,
+			.shdr_size		= shdr32_size,
+			.shdr_name		= shdr32_name,
+			.shdr_type		= shdr32_type,
+			.shdr_entsize		= shdr32_entsize,
+			.sym_type		= sym32_type,
+			.sym_name		= sym32_name,
+			.sym_value		= sym32_value,
+			.sym_shndx		= sym32_shndx,
+		};
+
+		e = efuncs;
+		long_size		= 4;
+		extable_ent_size	= 8;
+
 		if (r2(&ehdr->e32.e_ehsize) != sizeof(Elf32_Ehdr) ||
 		    r2(&ehdr->e32.e_shentsize) != sizeof(Elf32_Shdr)) {
 			fprintf(stderr,
@@ -872,26 +945,32 @@ static int do_file(char const *const fname, void *addr)
 			return -1;
 		}
 
-		compare_extable		= compare_extable_32;
-		ehdr_shoff		= ehdr32_shoff;
-		ehdr_shentsize		= ehdr32_shentsize;
-		ehdr_shstrndx		= ehdr32_shstrndx;
-		ehdr_shnum		= ehdr32_shnum;
-		shdr_addr		= shdr32_addr;
-		shdr_offset		= shdr32_offset;
-		shdr_link		= shdr32_link;
-		shdr_size		= shdr32_size;
-		shdr_name		= shdr32_name;
-		shdr_type		= shdr32_type;
-		shdr_entsize		= shdr32_entsize;
-		sym_type		= sym32_type;
-		sym_name		= sym32_name;
-		sym_value		= sym32_value;
-		sym_shndx		= sym32_shndx;
-		long_size		= 4;
-		extable_ent_size	= 8;
+		}
 		break;
-	case ELFCLASS64:
+	case ELFCLASS64: {
+		struct elf_funcs efuncs = {
+			.compare_extable	= compare_extable_64,
+			.ehdr_shoff		= ehdr64_shoff,
+			.ehdr_shentsize		= ehdr64_shentsize,
+			.ehdr_shstrndx		= ehdr64_shstrndx,
+			.ehdr_shnum		= ehdr64_shnum,
+			.shdr_addr		= shdr64_addr,
+			.shdr_offset		= shdr64_offset,
+			.shdr_link		= shdr64_link,
+			.shdr_size		= shdr64_size,
+			.shdr_name		= shdr64_name,
+			.shdr_type		= shdr64_type,
+			.shdr_entsize		= shdr64_entsize,
+			.sym_type		= sym64_type,
+			.sym_name		= sym64_name,
+			.sym_value		= sym64_value,
+			.sym_shndx		= sym64_shndx,
+		};
+
+		e = efuncs;
+		long_size		= 8;
+		extable_ent_size	= 16;
+
 		if (r2(&ehdr->e64.e_ehsize) != sizeof(Elf64_Ehdr) ||
 		    r2(&ehdr->e64.e_shentsize) != sizeof(Elf64_Shdr)) {
 			fprintf(stderr,
@@ -900,25 +979,7 @@ static int do_file(char const *const fname, void *addr)
 			return -1;
 		}
 
-		compare_extable		= compare_extable_64;
-		ehdr_shoff		= ehdr64_shoff;
-		ehdr_shentsize		= ehdr64_shentsize;
-		ehdr_shstrndx		= ehdr64_shstrndx;
-		ehdr_shnum		= ehdr64_shnum;
-		shdr_addr		= shdr64_addr;
-		shdr_offset		= shdr64_offset;
-		shdr_link		= shdr64_link;
-		shdr_size		= shdr64_size;
-		shdr_name		= shdr64_name;
-		shdr_type		= shdr64_type;
-		shdr_entsize		= shdr64_entsize;
-		sym_type		= sym64_type;
-		sym_name		= sym64_name;
-		sym_value		= sym64_value;
-		sym_shndx		= sym64_shndx;
-		long_size		= 8;
-		extable_ent_size	= 16;
-
+		}
 		break;
 	default:
 		fprintf(stderr, "unrecognized ELF class %d %s\n",
-- 
2.45.2


