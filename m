Return-Path: <bpf+bounces-47795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D1BA00188
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 00:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7D01883D7A
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 23:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA81BE238;
	Thu,  2 Jan 2025 23:25:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DF1B6CEA;
	Thu,  2 Jan 2025 23:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860332; cv=none; b=TmJs/fNQIjseVW1WQHJhvo1ug3RSxR8zaUZOfUVcUvPzN12S/YXOtqI6VhKdwHiJJbqxGQHLyTwOfQOyuayWEsmccYUcaeAOsayhWoNRRWUXWE9IcMAOzl8JhSaURQVHgX15XyZFj8XWL1KwUX5NB5N5AboGj1Ci51hfunyqX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860332; c=relaxed/simple;
	bh=i9IzCugaFX3oQbWc5qB45e8FgC982Y10VH1y3/W9akE=;
	h=Message-ID:Date:From:To:Cc:Subject; b=nkbXbmIRKa/CPSoUvDBxnc6PduB/tKb3RLtIaIUP+CCB1sEaa5FVbQhTKKnw3fCvjjcQTFkxwSL7sV5wcRJ8UrnX743Bc+4I0FZBPb0LVfgXiTXdN+NWPBpSgJIZg6tmLxpwgM4q+B5s0t5dlK/5JRUOb79dx9IzPHA3ObqbAhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8001C4CED0;
	Thu,  2 Jan 2025 23:25:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTUaW-00000005YqS-3FUj;
	Thu, 02 Jan 2025 18:26:48 -0500
Message-ID: <20250102232609.529842248@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 18:26:09 -0500
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
Subject: [PATCH v2 00/16] scripts/sorttable: ftrace: Remove place holders for weak functions in available_filter_functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

This series removes the place holder __ftrace_invalid_address___ from
the available_filter_functions file.

The first 13 patches clean up the scripts/sorttable.c code. It was
a copy from recordmcount.c which is very hard to maintain. That's
because it uses macro helpers and places the code in a header file
sorttable.h to handle both the 64 bit and 32 bit version of  the Elf
structures. It also has _r()/r()/r2() wrappers around accessing the
data which will read the 64 bit or 32 bit version of the data as well
as handle endianess. If the wrong wrapper is used, an invalid value
will result, and this has been a cause for bugs in the past. In fact
the new ORC code doesn't even use it. That's fine because ORC is only
for 64 bit x86 which is the default parsing.

Instead of having a bunch of macros defined and then include the code
twice from a header, the Elf structures are each wrapped in a union.
The union holds the 64 bit and 32 bit version of the needed structure.
To access the values, helper function pointers are used instead of
defining a function. For example, instead of having:

In sorttable.h:

 #undef Elf_Ehdr
 #undef Elf_Shdr

 #ifdef SORTTABLE_64
 # define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
 [..]
 # define _r			r8
 #else
 # define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
 [..]
 # define _r			r
 #endif

 [..]
 Elf_Shdr *s, *shdr = (Elf_Shdr *)((char *)ehdr + _r(&ehdr->e_shoff));

In sorttable.c:

 #include "sorttable.h"
 #define SORTTABLE_64
 #include "sorttable.h"

Using the Unions we have:

 typedef union {
	Elf32_Ehdr	e32;
	Elf64_Ehdr	e64;
 } Elf_Ehdr;

 typedef union {
	Elf32_Shdr	e32;
	Elf64_Shdr	e64;
 } Elf_Shdr;

 [..]

 static uint64_t ehdr64_shoff(Elf_Ehdr *ehdr)
 {
	return r8(&ehdr->e64.e_shoff);
 }

 static uint64_t ehdr32_shoff(Elf_Ehdr *ehdr)
 {
	return r(&ehdr->e32.e_shoff);
 }

 [..]
 static uint64_t (*ehdr_shoff)(Elf_Ehdr *ehdr);
 [..]

	switch (ehdr->e32.e_ident[EI_CLASS]) {
	case ELFCLASS32:
		[..]
		ehdr_shoff	= ehdr32_shoff;
		[..]
	case ELFCLASS65:
		[..]
		ehdr_shoff	= ehdr64_shoff;
		[..]

 shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));

The code may be a little more verbose, but the meat of the code is easier to
read, and the conversion functions live in the helper functions to make
it easier to have the fields read the proper way.

This makes the code easier to maintain, and for this purpose easier
to extend. Which is the last patch of the series.

The last 3 patches work to remove the weak functions from the mcount_loc
section.

The first of the 3 replaces the hack to get the __start_mcount_loc and
__stop_mcount_loc values from the symbol table. It replaces calling
popen() on a grep of System.map with looking at the actual symbol
values in the elf format.

The next patch adds the option "-s <file>" to sorttable.c. Now this code
is called by:

  ${NM} -S vmlinux > .tmp_vmlinux.nm-sort
  ${objtree}/scripts/sorttable -s .tmp_vmlinux.nm-sort ${1}

Where the file created by "nm -S" is read, recording the address
and the associated sizes of each function. It then is sorted, and
before sorting the mcount_loc table, it is scanned to make sure
all symbols in the mcounc_loc are within the boundaries of the functions
defined by nm. If they are not, they are zeroed out, as they are most
likely weak functions (I don't know what else they would be).

The last patch adds a ftrace_mcount_skip initdata variable that is
updated by sorttable.c to tell ftrace to skip over the first entries
in the mcount_loc table as they are invalid.

Before:
    
 ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
 556

After:

 ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
 0

Ideally, I would have moved the __start_mcount_loc to not have to
modify the kernel, but that would require a bit more work in the
architecture dependent code, as it requires reading the Elf_Rel*
entries.

This is also independent on fixing kallsyms to be able to know the real
size of functions instead of just using the value that goes to the
next function. One solution is to add place holders for weak functions.
But this doesn't help the mcount_loc issue as these entries need to
be removed at boot up and searching kallsyms will have an non-negligible
overhead.

Changes since v1: https://lore.kernel.org/all/20250102185845.928488650@goodmis.org/

- Replaced the last patch with 3 patches.

  The first of the 3 patches removed the hack of reading System.map
  with properly reading the Elf symbol table to find start_mcount_loc
  and stop_mcount_loc.

  The second patch adds the call to "nm -S vmlinux" to get the sizes
  of each function.

  The previous last patch would just check the zeroed out values and compare
  them to kaslr_offset(). Instead, this time, the last patch adds a new
  ftrace_mcount_skip that is used to simply skip over the first entries
  that the sorttable.c moved to the beginning, as they were the weak functions
  that were found.


Steven Rostedt (16):
      scripts/sorttable: Remove unused macro defines
      scripts/sorttable: Remove unused write functions
      scripts/sorttable: Remove unneeded Elf_Rel
      scripts/sorttable: Have the ORC code use the _r() functions to read
      scripts/sorttable: Make compare_extable() into two functions
      scripts/sorttable: Convert Elf_Ehdr to union
      scripts/sorttable: Replace Elf_Shdr Macro with a union
      scripts/sorttable: Convert Elf_Sym MACRO over to a union
      scripts/sorttable: Add helper functions for Elf_Ehdr
      scripts/sorttable: Add helper functions for Elf_Shdr
      scripts/sorttable: Add helper functions for Elf_Sym
      scripts/sorttable: Use uint64_t for mcount sorting
      scripts/sorttable: Move code from sorttable.h into sorttable.c
      scripts/sorttable: Get start/stop_mcount_loc from ELF file directly
      scripts/sorttable: Zero out weak functions in mcount_loc table
      scripts/sorttable: ftrace: Do not add weak functions to available_filter_functions

----
 kernel/trace/ftrace.c   |  16 +-
 scripts/link-vmlinux.sh |   4 +-
 scripts/sorttable.c     | 834 ++++++++++++++++++++++++++++++++++++++++++++----
 scripts/sorttable.h     | 497 -----------------------------
 4 files changed, 794 insertions(+), 557 deletions(-)
 delete mode 100644 scripts/sorttable.h

