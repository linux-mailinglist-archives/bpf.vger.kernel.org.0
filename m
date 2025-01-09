Return-Path: <bpf+bounces-48449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 599BBA08121
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C93188C0FC
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 20:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DE81F9428;
	Thu,  9 Jan 2025 20:05:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B2B677;
	Thu,  9 Jan 2025 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736453099; cv=none; b=c3XOmONBFqDiRe6vSB/zUvajg1nGtu76vBeq6rk5d7R9at1Q3eTdZUokSbqBEvnsvGaxXs2xygu/s7qH3cpplYFD0L6xOJrLQ0xzTUWtmfsNZHHB4OFzlbiVYZ0Ex0JtCEWRdPfcGhox/WYjhVJKcRW/rsj56sx52fBuIGsbfKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736453099; c=relaxed/simple;
	bh=T1358xyOlHjIOsDTrjSjveI8N7SNjbDfhRNUNLFFILc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=by+tFaFQ99ZjdO8U5xuN7tSCcS/C4uyTWW9ZWCDgWgtI+01k7DnRzXVRjdarb4tc1R3Am/vXGIF4PA2/OwzP01sELOJG4f+B5sEUtCtVK4jvondfdn6PdaklJDxREsl5xEBGkLc2DesCsitjWuNIGlUIOkFFFv3J2t9etnGGSEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFE9C4CED2;
	Thu,  9 Jan 2025 20:04:57 +0000 (UTC)
Date: Thu, 9 Jan 2025 15:06:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian
 <zhengyejian1@huawei.com>, Martin Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] scripts/sorttable: Move code from sorttable.h into
 sorttable.c
Message-ID: <20250109150631.2feaa55e@gandalf.local.home>
In-Reply-To: <CAHk-=wiafEyX7UgOeZgvd6fvuByE5WXUPh9599kwOc_d-pdeug@mail.gmail.com>
References: <20250107223217.6f7f96a5@gandalf.local.home>
	<CAHk-=wiafEyX7UgOeZgvd6fvuByE5WXUPh9599kwOc_d-pdeug@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 10:24:05 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 7 Jan 2025 at 19:30, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > +
> > +static int (*compare_extable)(const void *a, const void *b);
> > +static uint64_t (*ehdr_shoff)(Elf_Ehdr *ehdr);
> > +static uint16_t (*ehdr_shstrndx)(Elf_Ehdr *ehdr);  
> ...
> 
> Side note - and independently of the pure code movement - wouldn't it
> be nice to just make this a structure of function pointers, and then
> instead of this:

I do that in some of my personal code, but then all the calls to the
functions tend to be:

	e.ehdr_shoff(..); or e->ehdr_shoff(..);

instead of simply having:

	ehdr_shoff(..);

Hmm, if the structure is global, I guess then we could just have the helper
functions use the global variable. But then, instead of having:

static int (*compare_extable)(const void *a, const void *b);
static uint64_t (*ehdr_shoff)(Elf_Ehdr *ehdr);
static uint16_t (*ehdr_shstrndx)(Elf_Ehdr *ehdr);
static uint16_t (*ehdr_shentsize)(Elf_Ehdr *ehdr);
static uint16_t (*ehdr_shnum)(Elf_Ehdr *ehdr);
static uint64_t (*shdr_addr)(Elf_Shdr *shdr);
static uint64_t (*shdr_offset)(Elf_Shdr *shdr);
static uint64_t (*shdr_size)(Elf_Shdr *shdr);
static uint64_t (*shdr_entsize)(Elf_Shdr *shdr);
static uint32_t (*shdr_link)(Elf_Shdr *shdr);
static uint32_t (*shdr_name)(Elf_Shdr *shdr);
static uint32_t (*shdr_type)(Elf_Shdr *shdr);
static uint8_t (*sym_type)(Elf_Sym *sym);
static uint32_t (*sym_name)(Elf_Sym *sym);
static uint64_t (*sym_value)(Elf_Sym *sym);
static uint16_t (*sym_shndx)(Elf_Sym *sym);
static uint64_t (*rela_offset)(Elf_Rela *rela);
static uint64_t (*rela_info)(Elf_Rela *rela);
static uint64_t (*rela_addend)(Elf_Rela *rela);
static void (*rela_write_addend)(Elf_Rela *rela, uint64_t val);

	case ELFCLASS32:
		compare_extable		= compare_extable_32;
		ehdr_shoff		= ehdr32_shoff;
		ehdr_shentsize		= ehdr32_shentsize;
		ehdr_shstrndx		= ehdr32_shstrndx;
		ehdr_shnum		= ehdr32_shnum;
		shdr_addr		= shdr32_addr;
		shdr_offset		= shdr32_offset;
		shdr_link		= shdr32_link;
		shdr_size		= shdr32_size;
		shdr_name		= shdr32_name;
		shdr_type		= shdr32_type;
		shdr_entsize		= shdr32_entsize;
		sym_type		= sym32_type;
		sym_name		= sym32_name;
		sym_value		= sym32_value;
		sym_shndx		= sym32_shndx;
		rela_offset		= rela32_offset;
		rela_info		= rela32_info;
		rela_addend		= rela32_addend;
		rela_write_addend	= rela32_write_addend;
		long_size		= 4;
		extable_ent_size	= 8;
		break;
	case ELFCLASS64:
		compare_extable		= compare_extable_64;
		ehdr_shoff		= ehdr64_shoff;
		ehdr_shentsize		= ehdr64_shentsize;
		ehdr_shstrndx		= ehdr64_shstrndx;
		ehdr_shnum		= ehdr64_shnum;
		shdr_addr		= shdr64_addr;
		shdr_offset		= shdr64_offset;
		shdr_link		= shdr64_link;
		shdr_size		= shdr64_size;
		shdr_name		= shdr64_name;
		shdr_type		= shdr64_type;
		shdr_entsize		= shdr64_entsize;
		sym_type		= sym64_type;
		sym_name		= sym64_name;
		sym_value		= sym64_value;
		sym_shndx		= sym64_shndx;
		rela_offset		= rela64_offset;
		rela_info		= rela64_info;
		rela_addend		= rela64_addend;
		rela_write_addend	= rela64_write_addend;
		long_size		= 8;
		extable_ent_size	= 16;

		break;


We would have:

static struct elf_funcs {
	int (*compare_extable)(const void *a, const void *b);
	uint64_t (*ehdr_shoff)(Elf_Ehdr *ehdr);
	uint16_t (*ehdr_shstrndx)(Elf_Ehdr *ehdr);
	uint16_t (*ehdr_shentsize)(Elf_Ehdr *ehdr);
	uint16_t (*ehdr_shnum)(Elf_Ehdr *ehdr);
	uint64_t (*shdr_addr)(Elf_Shdr *shdr);
	uint64_t (*shdr_offset)(Elf_Shdr *shdr);
	uint64_t (*shdr_size)(Elf_Shdr *shdr);
	uint64_t (*shdr_entsize)(Elf_Shdr *shdr);
	uint32_t (*shdr_link)(Elf_Shdr *shdr);
	uint32_t (*shdr_name)(Elf_Shdr *shdr);
	uint32_t (*shdr_type)(Elf_Shdr *shdr);
	uint8_t (*sym_type)(Elf_Sym *sym);
	uint32_t (*sym_name)(Elf_Sym *sym);
	uint64_t (*sym_value)(Elf_Sym *sym);
	uint16_t (*sym_shndx)(Elf_Sym *sym);
} e;

// Hmm, I could add the helper function into the macros:

#define EHDR_HALF(fn_name)				\
static uint16_t ehdr64_##fn_name(Elf_Ehdr *ehdr)	\
{							\
	return r2(&ehdr->e64.e_##fn_name);		\
}							\
							\
static uint16_t ehdr32_##fn_name(Elf_Ehdr *ehdr)	\
{							\
	return r2(&ehdr->e32.e_##fn_name);		\
}							\
							\
static uint16 ehdr_##fn_name(Elf_Ehdr *ehdr)		\
{							\
	return e.ehdr_##fn_name(ehdr);			\
}

[..]

	case ELFCLASS32: {
		struct elf_funcs efuncs = {
			.compare_extable	= compare_extable_32,
			.ehdr_shoff		= ehdr32_shoff,
			.ehdr_shentsize		= ehdr32_shentsize,
			[..]
		};

		e = efuncs;
		long_size		= 4;
		extable_ent_size	= 8;
		}
		break;
	case ELFCLASS64: {
		struct elf_funcs efuncs = {
			.compare_extable	= compare_extable_64,
			.ehdr_shoff		= ehdr64_shoff,
			.ehdr_shentsize		= ehdr64_shentsize,
			[..]
		};

		e = efuncs;
		long_size		= 8;
		extable_ent_size	= 16;
		}
		break;


Which would give me this patch on top of this:

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


Is that what you are thinking?

-- Steve

