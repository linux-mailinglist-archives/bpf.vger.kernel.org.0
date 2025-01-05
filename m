Return-Path: <bpf+bounces-47890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55205A01A65
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22800162B1D
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393B017108A;
	Sun,  5 Jan 2025 16:22:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D01DA4E;
	Sun,  5 Jan 2025 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094140; cv=none; b=XUyJeig5mDAW3+cIid0gkGAJM+eh2sd7YU1tBWuZPoyOM2+vndh685vkTleYWbIiKF7S1UwPbD9k7dcko/UoMVVvpssA8FoPjkQl3srEcfehmKHL/68zknqxlXtEYongGHS8vvmz+13RDJ8O6SoGgwbdH4zcZV07zUx267fvCKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094140; c=relaxed/simple;
	bh=29UOMsvhvxWUG9Ns0MDq/rK22y+w9nzb3Bqr1M/V/Ao=;
	h=Message-ID:Date:From:To:Cc:Subject; b=cO6ywQ3TD8h2MAaKNVnQh54ojoafwNjdl/LMqJwm89Q+VHYIcPYoLhST98PXe/ZslMZcUqTajA+LV+NaDCp78fFgWw86I47cblWew6RBnMbMupbVHQjbro4c6p/k1Qi+Y3ZDok3LoPuxYYiiLN+6OCgruAJerIqYov6kStLF8vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F6DC4CED0;
	Sun,  5 Jan 2025 16:22:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tUTPk-00000008EqH-0MGm;
	Sun, 05 Jan 2025 11:23:44 -0500
Message-ID: <20250105162211.971039541@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 05 Jan 2025 11:22:11 -0500
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
Subject: [PATCH 00/14] scripts/sorttable: Rewrite the accessing of the Elf data fields
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


While looking at getting rid of the place holder __ftrace_invalid_address___
from the available_filter_functions file[1], I noticed that the sorttable.[ch]
code could use a major clean up!

This series is that clean up of the scripts/sorttable.c code. The sorttable.c
was a copy from recordmcount.c which is very hard to maintain. That's because
it uses macro helpers and places the code in a header file sorttable.h to
handle both the 64 bit and 32 bit version of  the Elf structures. It also uses
_r()/r()/r2() wrappers around accessing the data which will read the 64 bit or
32 bit version of the data as well as handle endianess. If the wrong wrapper is
used, an invalid value will result, and this has been a cause for bugs in the
past. In fact the new ORC code doesn't even use it. That's fine because ORC is
only for 64 bit x86 which is the default parsing.

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

Using the Unions we have just sorttable.c:

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
it easier to have the fields read the proper way, and not worry how to
read the fields within the code that accesses them.

This makes the code less error prone and easier to maintain. This also
makes it easier to extend and update the sorttable code.

[1] https://lore.kernel.org/all/20250102232609.529842248@goodmis.org/

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
      scripts/sorttable: Get start/stop_mcount_loc from ELF file directly

----
 scripts/sorttable.c | 674 +++++++++++++++++++++++++++++++++++++++++++++++-----
 scripts/sorttable.h | 497 --------------------------------------
 2 files changed, 620 insertions(+), 551 deletions(-)
 delete mode 100644 scripts/sorttable.h

