Return-Path: <bpf+bounces-47755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8EE9FFEFB
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A5F3A3443
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 18:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31E1A2543;
	Thu,  2 Jan 2025 18:59:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3267E782;
	Thu,  2 Jan 2025 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844386; cv=none; b=VqnDZoD4fanrlwORZ2XfAeO1ag2H+7s1WPhHwJB/Xr/XFBg2UU0twoO9D0c9uwqoC75kZXtD2qizODPjE/iPk4swnWSF5nYmq13L2SLhOZJUYa+Lj/TX4B0uEle2ZzpBSLEgOcIa+BrP2IVI1a5UIUdpI/QyVdal6wxL9TijdNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844386; c=relaxed/simple;
	bh=D5qnJ35JtduVdAaZpxy3o6MrDaqhbW4dYnbMzDj1J6c=;
	h=Message-ID:Date:From:To:Cc:Subject; b=NY/Ts2SK0KlLdquBMpq5O74Fx9NqKelePQJ6dPvz09yVe6bWhnXNtRXnP3B7j/0cfBzhQIxWml7KMkApW4BKzl8VzWdAWAe4qk0cpujHpxD/z8ngjmI5jn58TQUSatdwcKzByRCYt2xL2M3zLEsnpi/zUgdc67gC0lxejQBuZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5466C4CEDC;
	Thu,  2 Jan 2025 18:59:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTQRL-00000005MiX-12Xo;
	Thu, 02 Jan 2025 14:01:03 -0500
Message-ID: <20250102185845.928488650@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 13:58:45 -0500
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
Subject: [PATCH 00/14] scripts/sorttable: ftrace: Remove place holders for weak functions in available_filter_functions
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

The last patch adds the option "-s <file>" to sorttable.c. Now this code
is called by:

  ${NM} -S vmlinux > .tmp_vmlinux.nm-sort
  ${objtree}/scripts/sorttable -s .tmp_vmlinux.nm-sort ${1}

Where the file created by "nm -S" is read, recording the address
and the associated sizes of each function. It then is sorted, and
before sorting the mcount_loc table, it is scanned to make sure
all symbols in the mcounc_loc are within the boundaries of the functions
defined by nm. If they are not, they are zeroed out, as they are most
likely weak functions (I don't know what else they would be).

Then on boot up, when creating the ftrace tables from the mcount_loc
table, it will ignore any function that matches the kaslr_offset()
value. As KASLR will still shift the values even if they are zero.
But by skipping over entries in mcount_loc that match kaslr_offset()
all weak functions are removed from the ftrace table as well as the
available_filter_functions file that is derived from it.

Before:
    
 ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
 556

After:

 ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
 0

Steven Rostedt (14):
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
      scripts/sorttable: ftrace: Do not add weak functions to available_filter_functions

----
 kernel/trace/ftrace.c   |  14 +
 scripts/link-vmlinux.sh |   4 +-
 scripts/sorttable.c     | 810 ++++++++++++++++++++++++++++++++++++++++++++----
 scripts/sorttable.h     | 497 -----------------------------
 4 files changed, 771 insertions(+), 554 deletions(-)
 delete mode 100644 scripts/sorttable.h

