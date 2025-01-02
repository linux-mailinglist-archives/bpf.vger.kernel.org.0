Return-Path: <bpf+bounces-47764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A559FFF16
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7081883E46
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FCE1BAEF8;
	Thu,  2 Jan 2025 18:59:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DFE1B85E2;
	Thu,  2 Jan 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844388; cv=none; b=EleFgxZoU14UdO8h68ifFgD1/pEd39xE8Sshi4Xjb7rBqaLxBQxDL+IoLSaShYr26cayC4xQA1ryrkJFgR/mRqCxuSsTbF+GHbU/moMkHPu56VVC9vd583p6IkAZW17RPIzHqBhgH6oWk5T3qdgo8eppcGzD+sYPG/I03dEStMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844388; c=relaxed/simple;
	bh=CVOrvydFGYl67HKGAtv+3Ybs5IokbsMeYixlh2//VD4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=srSiOX6fxVS1df9E+V3HEbyxU2P4R+4z8XsLW4pCFjH+y5PP+tpugEL48fhozjst3nM8jSkCvo3YwLUK+8k/PGhruLFI8TKNpBvZHe97VO5Qx8Vbax4fnoZuUxSzKFjUEK5MitzOnOQNQZIhI1cVcLfr/5KjEjc/LQ9Ashd1O5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CF0C4CEF6;
	Thu,  2 Jan 2025 18:59:47 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTQRM-00000005MnK-3LHp;
	Thu, 02 Jan 2025 14:01:04 -0500
Message-ID: <20250102190104.651196376@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 13:58:54 -0500
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
Subject: [PATCH 09/14] scripts/sorttable: Add helper functions for Elf_Ehdr
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
to create duplicate functions, add helper functions for Elf_Ehdr.  This
will create a function pointer for each helper that will get assigned to
the appropriate function to handle either the 64bit or 32bit version.

This also moves the _r()/r() wrappers for the Elf_Ehdr references that
handle endian and size differences between the different architectures,
into the helper function and out of the open code which is more error
prone.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 25 +++++++++++++++++++++++++
 scripts/sorttable.h | 20 ++++++++++++++++----
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 57792cf2aa89..5dfa734eff09 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -85,6 +85,31 @@ static uint64_t (*r8)(const uint64_t *);
 static void (*w)(uint32_t, uint32_t *);
 typedef void (*table_sort_t)(char *, int);
 
+static uint64_t ehdr64_shoff(Elf_Ehdr *ehdr)
+{
+	return r8(&ehdr->e64.e_shoff);
+}
+
+static uint64_t ehdr32_shoff(Elf_Ehdr *ehdr)
+{
+	return r(&ehdr->e32.e_shoff);
+}
+
+#define EHDR_HALF(fn_name)				\
+static uint16_t ehdr64_##fn_name(Elf_Ehdr *ehdr)	\
+{							\
+	return r2(&ehdr->e64.e_##fn_name);		\
+}							\
+							\
+static uint16_t ehdr32_##fn_name(Elf_Ehdr *ehdr)	\
+{							\
+	return r2(&ehdr->e32.e_##fn_name);		\
+}
+
+EHDR_HALF(shentsize)
+EHDR_HALF(shstrndx)
+EHDR_HALF(shnum)
+
 /*
  * Get the whole file as a programming convenience in order to avoid
  * malloc+lseek+read+free of many pieces.  If successful, then mmap
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index a365a8bc405a..3855f2ad0e73 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -27,6 +27,10 @@
 #undef uint_t
 #undef _r
 #undef etype
+#undef ehdr_shoff
+#undef ehdr_shentsize
+#undef ehdr_shstrndx
+#undef ehdr_shnum
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -39,6 +43,10 @@
 # define uint_t			uint64_t
 # define _r			r8
 # define etype			e64
+# define ehdr_shoff		ehdr64_shoff
+# define ehdr_shentsize		ehdr64_shentsize
+# define ehdr_shstrndx		ehdr64_shstrndx
+# define ehdr_shnum		ehdr64_shnum
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -50,6 +58,10 @@
 # define uint_t			uint32_t
 # define _r			r
 # define etype			e32
+# define ehdr_shoff		ehdr32_shoff
+# define ehdr_shentsize		ehdr32_shentsize
+# define ehdr_shstrndx		ehdr32_shstrndx
+# define ehdr_shnum		ehdr32_shnum
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -247,16 +259,16 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int orc_num_entries = 0;
 #endif
 
-	shdr_start = (Elf_Shdr *)((char *)ehdr + _r(&ehdr->etype.e_shoff));
-	shentsize = r2(&ehdr->etype.e_shentsize);
+	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
+	shentsize = ehdr_shentsize(ehdr);
 
-	shstrndx = r2(&ehdr->etype.e_shstrndx);
+	shstrndx = ehdr_shstrndx(ehdr);
 	if (shstrndx == SHN_XINDEX)
 		shstrndx = r(&shdr_start->etype.sh_link);
 	string_sec = get_index(shdr_start, shentsize, shstrndx);
 	secstrings = (const char *)ehdr + _r(&string_sec->etype.sh_offset);
 
-	shnum = r2(&ehdr->etype.e_shnum);
+	shnum = ehdr_shnum(ehdr);
 	if (shnum == SHN_UNDEF)
 		shnum = _r(&shdr_start->etype.sh_size);
 
-- 
2.45.2



