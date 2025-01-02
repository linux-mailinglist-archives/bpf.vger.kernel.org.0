Return-Path: <bpf+bounces-47763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AE69FFF13
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3285D1883CD8
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726201B87EB;
	Thu,  2 Jan 2025 18:59:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B781B6D17;
	Thu,  2 Jan 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844388; cv=none; b=e/kbxUIGy4V8syS6UKEhPXd037IQgRX/eKAosVsmlQ57XyWsh0WNe6IaEMSwyc0kQxj9apAbkb6T2MAwivPtHWHutJUglLfW8xBxvwgjy9/feXFV6nuxISU78iJM1+vsl1jC5tNgMM3AwK//P6up2Dbn9e3zc+KLMBWZejKo5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844388; c=relaxed/simple;
	bh=rpDkiZolJ8Aw8FySmRQR6P9UH1zV54Fcd5p2oSzjU24=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ag22KrW1rYcOpez5BdyvWSnYhKaM0eovZhPLYCwk3DfhInCQYHCcaCtpvL2+YaDPH191PB+TDFs+WhcfAUO6X9teifiIU7sp68mEEaH9ujVASulbOUMfP5x9w3er209wYxgxPNevwJdsiHKdT89Oc6NX8tcw5Pe1X6on4D5Km8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B77C4CEE7;
	Thu,  2 Jan 2025 18:59:47 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTQRM-00000005Mmq-2dkL;
	Thu, 02 Jan 2025 14:01:04 -0500
Message-ID: <20250102190104.479730395@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 13:58:53 -0500
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
Subject: [PATCH 08/14] scripts/sorttable: Convert Elf_Sym MACRO over to a union
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
to create duplicate functions for both, replace the Elf_Sym macro with a
union that defines both Elf64_Sym and Elf32_Sym, with field e64 for the
64bit version, and e32 for the 32bit version.

It can then use the macro etype to get the proper value.

This will eventually be replaced with just single functions that can
handle both 32bit and 64bit ELF parsing.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c |  5 +++++
 scripts/sorttable.h | 25 ++++++++++++++-----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 94497b8ab04c..57792cf2aa89 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -74,6 +74,11 @@ typedef union {
 	Elf64_Shdr	e64;
 } Elf_Shdr;
 
+typedef union {
+	Elf32_Sym	e32;
+	Elf64_Sym	e64;
+} Elf_Sym;
+
 static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 034ce8560dad..a365a8bc405a 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -23,7 +23,6 @@
 #undef sort_mcount_loc
 #undef elf_mcount_loc
 #undef do_sort
-#undef Elf_Sym
 #undef ELF_ST_TYPE
 #undef uint_t
 #undef _r
@@ -36,7 +35,6 @@
 # define sort_mcount_loc	sort_mcount_loc_64
 # define elf_mcount_loc		elf_mcount_loc_64
 # define do_sort		do_sort_64
-# define Elf_Sym		Elf64_Sym
 # define ELF_ST_TYPE		ELF64_ST_TYPE
 # define uint_t			uint64_t
 # define _r			r8
@@ -48,7 +46,6 @@
 # define sort_mcount_loc	sort_mcount_loc_32
 # define elf_mcount_loc		elf_mcount_loc_32
 # define do_sort		do_sort_32
-# define Elf_Sym		Elf32_Sym
 # define ELF_ST_TYPE		ELF32_ST_TYPE
 # define uint_t			uint32_t
 # define _r			r
@@ -227,10 +224,13 @@ static int do_sort(Elf_Ehdr *ehdr,
 	Elf_Sym *sort_needed_sym = NULL;
 	Elf_Shdr *sort_needed_sec;
 	uint32_t *sort_needed_loc;
+	void *sym_start;
+	void *sym_end;
 	const char *secstrings;
 	const char *strtab;
 	char *extab_image;
 	int sort_need_index;
+	int symentsize;
 	int shentsize;
 	int idx;
 	int i;
@@ -373,12 +373,15 @@ static int do_sort(Elf_Ehdr *ehdr,
 	}
 
 	/* find the flag main_extable_sort_needed */
-	for (sym = (void *)ehdr + _r(&symtab_sec->etype.sh_offset);
-	     sym < sym + _r(&symtab_sec->etype.sh_size) / sizeof(Elf_Sym);
-	     sym++) {
-		if (ELF_ST_TYPE(sym->st_info) != STT_OBJECT)
+	sym_start = (void *)ehdr + _r(&symtab_sec->etype.sh_offset);
+	sym_end = sym_start + _r(&symtab_sec->etype.sh_size);
+	symentsize = _r(&symtab_sec->etype.sh_entsize);
+
+	for (sym = sym_start; (void *)sym + symentsize < sym_end;
+	     sym = (void *)sym + symentsize) {
+		if (ELF_ST_TYPE(sym->etype.st_info) != STT_OBJECT)
 			continue;
-		if (!strcmp(strtab + r(&sym->st_name),
+		if (!strcmp(strtab + r(&sym->etype.st_name),
 			    "main_extable_sort_needed")) {
 			sort_needed_sym = sym;
 			break;
@@ -392,13 +395,13 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 
-	sort_need_index = get_secindex(r2(&sym->st_shndx),
-				       sort_needed_sym - symtab,
+	sort_need_index = get_secindex(r2(&sym->etype.st_shndx),
+				       ((void *)sort_needed_sym - (void *)symtab) / symentsize,
 				       symtab_shndx);
 	sort_needed_sec = get_index(shdr_start, shentsize, sort_need_index);
 	sort_needed_loc = (void *)ehdr +
 		_r(&sort_needed_sec->etype.sh_offset) +
-		_r(&sort_needed_sym->st_value) -
+		_r(&sort_needed_sym->etype.st_value) -
 		_r(&sort_needed_sec->etype.sh_addr);
 
 	/* extable has been sorted, clear the flag */
-- 
2.45.2



