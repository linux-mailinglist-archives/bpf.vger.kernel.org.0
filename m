Return-Path: <bpf+bounces-71872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11057BFFCC4
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 10:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321311A0618A
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 08:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF72EC09C;
	Thu, 23 Oct 2025 08:08:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FCF2EAB78
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206921; cv=none; b=aYEtSxvn6NBl90P2C3CYeSI+1mBkagKhJwp/p6O2RiPoxRWaOPWA2CtUdYHUzL157mEXr+jnrxvzvZINfTVgikFcpbJ3PJ4rOOzFqRgz1Y5ozRP/BoLdorOnf1C+gtyghNm1PJmWVyor/AYVN9rsxF2bLoVz73BuHMN7MKFljEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206921; c=relaxed/simple;
	bh=Yff+NjaurftaPmXehA6JhEjk3R44/kuE8rAhSAHJs6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bissjCrQn65hdIBU6zMwbnpJqQooTIk5IZGXDBZsXOv6VnXjorVyyyYovXuUrunr0UN5gm4nBLYt0D+kAziniGpDw8fwCRzmccG5zuTcNlqLjqujLIy4Tlhrkbh8hEGiJuRWCTd3Kv+sSgOBiFLkv9TVGoDDguV2lcpPnKTP3Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781206cce18so549464b3a.0
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 01:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206919; x=1761811719;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPdMqAaNN+qlhhgT28sC1RuE1Sie27pVKed+Lc0fHIU=;
        b=pOyAMVFlDYF5vc9RTXl7sF+6cZPhpsCkgByM4xOdD35N/L83jmujklRYdZDPqtLlxe
         XUCMO22m3axyhZtXGhJVU0hNXdBFj8s1iCFLcp2QYiOo/YKJwC6zulz8Uki2q8c2anyY
         2+A2eZU7Rtk1df1CaX2lmsdMhM1EQphoEoMthCCJZGToL1hbuCPezfGEHkmdBThanSAg
         VfINHNoXq+enepvQDyExgtAidVHChZF7HZIlllrYgLeNrpeYJ4iabzkHH92IOlQFsbcH
         U22ffieeb91UOoQU6Q2/SsNr62KeMWVZmAPPg1rJXEcPnSNd7RC2EOOltb6bmpvvbMsl
         decg==
X-Forwarded-Encrypted: i=1; AJvYcCWb9bzCR9H0gwTlFPM8Gq77PB/6btdKbW5BvtrSGngbpsjm+pydrAvCXBR86eKMDbkENwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygBRa1OjI5txLqfuxAreMIgogXl8yuxTOYzqbyaShfw0UHkX8R
	HwQsCdwXW8fCBm58cyYbHnEXAq2nKyARJqP1e85dJla8FMVTM3xUFpoL
X-Gm-Gg: ASbGncsucpBm5+uPp33C57bjWy1L+6fajJk+TOKaOM1SSMS9yXDUOm36xl2P43wPjLe
	R51LXNRSwu81tPRE0hrdQSsSGkx+lTZG5lixgtnPfXRwovv4iEEB125g7apIeCaIhDV11TT9/P5
	tfvriKC7LKytlcDg5KNVssKGblik3pxhlA+l9TSBVC+Y8H3rgmbPdERG4+bvvS1z90Vpcy0iDqu
	qrt1ro06rvrq5sbnRfXdFjejvtDDmsK+Llq4ofCjQdfcdV7aSjesHR6SyR/5sRbqjAfKAKc8dA5
	Id8L4RiUAg7L5C3e/49Bv5I1bLYWGUcb8GiGzOY8cQ3VQxHG6aGTAY7uKt/VnkWau6lQt5mAjeX
	3h8ggQi3WrhTxG0SLF3vxqUk8J8pswOPSMOnxdXi8Gowo8FtuOWRt4Z13pblEYPeXG8xY+EtNoy
	iUNMaFneEy7JzCkCtOprPkxNLozJvZ+YxkQqrblFa7vQ==
X-Google-Smtp-Source: AGHT+IGj9p7zkDVwEQi+TGhOgJntyVRui9Psn9Cj7kR8uoyW7/JfR0cnfzFv3w5Mv7bWcCLhDa5vDw==
X-Received: by 2002:a05:6a21:7e88:b0:334:b280:b12 with SMTP id adf61e73a8af0-33aa5c9b714mr6311776637.1.1761206918624;
        Thu, 23 Oct 2025 01:08:38 -0700 (PDT)
Received: from localhost (c-73-170-232-218.hsd1.ca.comcast.net. [73.170.232.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274ac3158sm1648393b3a.32.2025.10.23.01.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:08:38 -0700 (PDT)
Date: Thu, 23 Oct 2025 01:09:02 -0700
From: Fangrui Song <maskray@sourceware.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, 
	Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, 
	Carlos O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v11 00/15] unwind_deferred: Implement sframe handling
Message-ID: <mzqhpduikzpeczmmxh5uyfzjpvdeae3ityqyp2rno4myujzb6y@ey346eksvoyf>
References: <20251022144326.4082059-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022144326.4082059-1-jremus@linux.ibm.com>

On 2025-10-22, Jens Remus wrote:
>This is the implementation of parsing the SFrame section in an ELF file.
>It's a continuation of Josh's and Steve's last work that can be found
>here:
>
>   https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/
>   https://lore.kernel.org/all/20250827201548.448472904@kernel.org/
>
>Currently the only way to get a user space stack trace from a stack
>walk (and not just copying large amount of user stack into the kernel
>ring buffer) is to use frame pointers. This has a few issues. The biggest
>one is that compiling frame pointers into every application and library
>has been shown to cause performance overhead.
>
>Another issue is that the format of the frames may not always be consistent
>between different compilers and some architectures (s390) has no defined
>format to do a reliable stack walk. The only way to perform user space
>profiling on these architectures is to copy the user stack into the kernel
>buffer.
>
>SFrames[1] is now supported in gcc binutils and soon will also be supported
>by LLVM. 

Please consider dropping the statement, "soon will also be supported by LLVM."
Speaking as LLVM's MC, lld/ELF, and binary utilities maintainer, I have significant concerns about the v2 format, specifically its apparent disregard for standard ELF and linker conventions
(https://maskray.me/blog/2025-09-28-remarks-on-sframe#linking-and-execution-views)

To arm64 maintainers, it is critical time to revisit a unwind
information format, as I have outlined in my blog post:

A sorted address table like .eh_frame_hdr might still be needed, but the
design could be very different for arm64.

I am curious whether anyone has thought about a library that parses .eh_frame and generates SFrame.
If objtool integrates  this library, it can generate SFrame for vmlinux and modules without relying on assembler/linker.
Linker and assembler requires a level of stability that is currently concerning on the toolchain side.

(https://sourceware.org/pipermail/binutils/2025-October/144974.html
"This "linker will DTRT" assertion glosses over significant
implementation complexity. Each version needs not just a reader but
version-specific *merging* logic in every linker—fundamentally different
from simply reading a format.")

>SFrames acts more like ORC, and lives in the ELF executable
>file as its own section. Like ORC it has two tables where the first table
>is sorted by instruction pointers (IP) and using the current IP and finding
>it's entry in the first table, it will take you to the second table which
>will tell you where the return address of the current function is located
>and then you can use that address to look it up in the first table to find
>the return address of that function, and so on. This performs a user
>space stack walk.
>
>Now because the SFrame section lives in the ELF file it needs to be faulted
>into memory when it is used. This means that walking the user space stack
>requires being in a faultable context. As profilers like perf request a stack
>trace in interrupt or NMI context, it cannot do the walking when it is
>requested. Instead it must be deferred until it is safe to fault in user
>space. One place this is known to be safe is when the task is about to return
>back to user space.
>
>This series makes the deferred unwind code implement SFrames.
>
>[1] https://sourceware.org/binutils/wiki/sframe
>
>Changes since v10:
>- Rebase on v6.17-rc1 with Peter's unwind user fixes and x86 support
>  series [2] and Steve's support for the deferred unwinding infrastructure
>  series in perf [3] and perf tool [4] on top.
>- Support for SFrame V2 PC-relative FDE function start address. (Jens)
>- Support for SFrame V2 representing RA undefined as indication for
>  outermost frames. (Jens)
>
>[2]: [PATCH 00/12] Various fixes and x86 support,
>     https://lore.kernel.org/all/20250924075948.579302904@infradead.org/
>[3]: [PATCH v16 0/4] perf: Support the deferred unwinding infrastructure,
>     https://lore.kernel.org/all/20251007214008.080852573@kernel.org/
>[4]: [PATCH v16 0/4] perf tool: Support the deferred unwinding infrastructure,
>     https://lore.kernel.org/all/20250908175319.841517121@kernel.org/
>
>Patches 1 and 2 are suggested fixups to patches from Peter's unwind user
>fixes and x86 support series.  They keep the factoring out of the word
>size from the frame's CFA, FP, and RA offsets local to unwind user fp, as
>unwind user sframe does use absolute offsets.
>
>Patches 3, 6, and 14 have been updated to exclusively support the recent
>PC-relative SFrame FDE function start address encoding.  With Binutils 2.45
>the SFrame V2 FDE function start address field value is an offset from the
>field (i.e. PC-relative) instead of from the .sframe section start.  This
>is indicated by the new SFrame header flag SFRAME_F_FDE_FUNC_START_PCREL.
>Old SFrame V2 sections get rejected with dynamic debug message
>"bad/unsupported sframe header".
>
>Patches 9 and 10 add support to unwind user and unwind user sframe for
>a recent change of the SFrame V2 format to represent an undefined
>return address as an SFrame FRE without any offsets, which is used as
>indication for outermost frames.  Note that currently only a development
>build of Binutils mainline generates SFrame information including this
>new indication for outermost frames.  SFrame information without the new
>indication is still supported.  Without these patches unwind user sframe
>would identify such new SFrame FREs without any offsets as corrupted and
>remove the .sframe section, causing any any further stack tracing using
>sframe to fail.
>
>Regards,
>Jens
>
>
>Jens Remus (4):
>  fixup! unwind: Implement compat fp unwind
>  fixup! unwind_user/x86: Enable frame pointer unwinding on x86
>  unwind_user: Stop when reaching an outermost frame
>  unwind_user/sframe: Add support for outermost frame indication
>
>Josh Poimboeuf (11):
>  unwind_user/sframe: Add support for reading .sframe headers
>  unwind_user/sframe: Store sframe section data in per-mm maple tree
>  x86/uaccess: Add unsafe_copy_from_user() implementation
>  unwind_user/sframe: Add support for reading .sframe contents
>  unwind_user/sframe: Detect .sframe sections in executables
>  unwind_user/sframe: Wire up unwind_user to sframe
>  unwind_user/sframe/x86: Enable sframe unwinding on x86
>  unwind_user/sframe: Remove .sframe section on detected corruption
>  unwind_user/sframe: Show file name in debug output
>  unwind_user/sframe: Add .sframe validation option
>  unwind_user/sframe: Add prctl() interface for registering .sframe
>    sections
>
> MAINTAINERS                        |   1 +
> arch/Kconfig                       |  23 ++
> arch/x86/Kconfig                   |   1 +
> arch/x86/include/asm/mmu.h         |   2 +-
> arch/x86/include/asm/uaccess.h     |  39 +-
> arch/x86/include/asm/unwind_user.h |  11 +-
> fs/binfmt_elf.c                    |  49 ++-
> include/linux/mm_types.h           |   3 +
> include/linux/sframe.h             |  60 +++
> include/linux/unwind_user_types.h  |   5 +-
> include/uapi/linux/elf.h           |   1 +
> include/uapi/linux/prctl.h         |   6 +-
> kernel/fork.c                      |  10 +
> kernel/sys.c                       |   9 +
> kernel/unwind/Makefile             |   3 +-
> kernel/unwind/sframe.c             | 615 +++++++++++++++++++++++++++++
> kernel/unwind/sframe.h             |  72 ++++
> kernel/unwind/sframe_debug.h       |  68 ++++
> kernel/unwind/user.c               |  56 ++-
> mm/init-mm.c                       |   2 +
> 20 files changed, 1004 insertions(+), 32 deletions(-)
> create mode 100644 include/linux/sframe.h
> create mode 100644 kernel/unwind/sframe.c
> create mode 100644 kernel/unwind/sframe.h
> create mode 100644 kernel/unwind/sframe_debug.h
>
>-- 
>2.48.1
>

