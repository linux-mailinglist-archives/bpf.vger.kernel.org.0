Return-Path: <bpf+bounces-61982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9239AF0395
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7ADF1C08834
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 19:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD8F28726C;
	Tue,  1 Jul 2025 19:19:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD39287254;
	Tue,  1 Jul 2025 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397543; cv=none; b=OLL2CH9ocTh9+wfUmC2scsOyThuiQ0qKZ+v9qlabcNG9RFXZvmNVQaGp11FVnVtUqzzw9IZnbSV5Gp0TU/Zi/PJOY7qsx5MiqXFztUlqSB4ZnFuBvPL2TW3c4kPCFOv5fan2DU+A7Lfgi9gYRcA1mGJVwPJlSnd6KJ8vPob8xsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397543; c=relaxed/simple;
	bh=vLz4eRZOkx/18G2Of9b/1TTaGPM/bDTdQjRk6I5nDVU=;
	h=Message-ID:Date:From:To:Cc:Subject; b=hXLhFbgw6fPXGo7u+pWaXn6kZdTwifjPKwlneRe74HDocbAlteg8FClE6DZFolHMvWGIy3lWo9BrPPclQeq6ZqZj0v1sgCttx6r9dcANTrgYCFWJ22PEHbwje0gEEnFvL0c8pmeeCBedUvOsVm5AWMOCVddn7WiIuORtrljAtDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400FCC4CEEB;
	Tue,  1 Jul 2025 19:19:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWg3r-00000007gmh-33L4;
	Tue, 01 Jul 2025 14:50:31 -0400
Message-ID: <20250701184939.026626626@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Jul 2025 14:49:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v7 00/12] unwind_deferred: Implement sframe handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


This code is based on top of:

 https://lore.kernel.org/linux-trace-kernel/20250701005321.942306427@goodmis.org/
 git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git unwind/core

This is the implementation of parsing the SFrame section in an ELF file.
It's a continuation of Josh's last work that can be found here:

   https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/

Currently the only way to get a user space stack trace from a stack
walk (and not just copying large amount of user stack into the kernel
ring buffer) is to use frame pointers. This has a few issues. The biggest
one is that compiling frame pointers into every application and library
has been shown to cause performance overhead.

Another issue is that the format of the frames may not always be consistent
between different compilers and some architectures (s390) has no defined
format to do a reliable stack walk. The only way to perform user space
profiling on these architectures is to copy the user stack into the kernel
buffer.

SFrames[1] is now supported in gcc binutils and soon will also be supported
by LLVM. SFrames acts more like ORC, and lives in the ELF executable
file as its own section. Like ORC it has two tables where the first table
is sorted by instruction pointers (IP) and using the current IP and finding
it's entry in the first table, it will take you to the second table which
will tell you where the return address of the current function is located
and then you can use that address to look it up in the first table to find
the return address of that function, and so on. This performs a user
space stack walk.

Now because the SFrame section lives in the ELF file it needs to be faulted
into memory when it is used. This means that walking the user space stack
requires being in a faultable context. As profilers like perf request a stack
trace in interrupt or NMI context, it cannot do the walking when it is
requested. Instead it must be deferred until it is safe to fault in user
space. One place this is known to be safe is when the task is about to return
back to user space.

This series makes the deferred unwind code implement SFrames.

[1] https://sourceware.org/binutils/wiki/sframe

The code for this patch series can be found here:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git unwind/sframe

Changes since v6: https://lore.kernel.org/linux-trace-kernel/20250617225009.233007152@goodmis.org/

- Rebased on top of unwind/core

- Moved the addition of the prctl(), that allows libraries to add the elf
  sections to the kernel, to the last patch and labeled it as "DO NOT APPLY".
  This should instead be a proper system call and work to make it robust and
  flexible still needs to be done. The prctl() patch is added for debugging
  purposes only.

Head SHA1: 5d24854c7069f833449e8310bd3253624213c08d


Josh Poimboeuf (12):
      unwind_user/sframe: Add support for reading .sframe headers
      unwind_user/sframe: Store sframe section data in per-mm maple tree
      x86/uaccess: Add unsafe_copy_from_user() implementation
      unwind_user/sframe: Add support for reading .sframe contents
      unwind_user/sframe: Detect .sframe sections in executables
      unwind_user/sframe: Wire up unwind_user to sframe
      unwind_user/sframe/x86: Enable sframe unwinding on x86
      unwind_user/sframe: Remove .sframe section on detected corruption
      unwind_user/sframe: Show file name in debug output
      unwind_user/sframe: Enable debugging in uaccess regions
      unwind_user/sframe: Add .sframe validation option
      [DO NOT APPLY] unwind_user/sframe: Add prctl() interface for registering .sframe sections

----
 MAINTAINERS                       |   1 +
 arch/Kconfig                      |  23 ++
 arch/x86/Kconfig                  |   1 +
 arch/x86/include/asm/mmu.h        |   2 +-
 arch/x86/include/asm/uaccess.h    |  39 ++-
 fs/binfmt_elf.c                   |  49 ++-
 include/linux/mm_types.h          |   3 +
 include/linux/sframe.h            |  60 ++++
 include/linux/unwind_user_types.h |   1 +
 include/uapi/linux/elf.h          |   1 +
 include/uapi/linux/prctl.h        |   6 +-
 kernel/fork.c                     |  10 +
 kernel/sys.c                      |   9 +
 kernel/unwind/Makefile            |   3 +-
 kernel/unwind/sframe.c            | 612 ++++++++++++++++++++++++++++++++++++++
 kernel/unwind/sframe.h            |  71 +++++
 kernel/unwind/sframe_debug.h      |  99 ++++++
 kernel/unwind/user.c              |  25 +-
 mm/init-mm.c                      |   2 +
 19 files changed, 998 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/sframe.h
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h
 create mode 100644 kernel/unwind/sframe_debug.h

