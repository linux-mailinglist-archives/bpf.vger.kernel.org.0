Return-Path: <bpf+bounces-66710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54701B38AD9
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AE07C7524
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7081A2FDC5A;
	Wed, 27 Aug 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz9MU/TG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADBE2D97BF;
	Wed, 27 Aug 2025 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326262; cv=none; b=fLYkIaGEan7Pw+o66haVeYTqR1byvULLDt1jWSqd/pxygrKvgyOd5kajpXqqTrRJdxMEltV+cQCaTC4nlX3KhGZT5jeYrywLRbKkJ8V/UQo4VJv8Mlnx3tw71aoyJv9++DaIG1mZamT/k8RVFKGRiiYgZcWB+vd4/CQik5NR37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326262; c=relaxed/simple;
	bh=jFbyxsG7RwRgME4YN/e4YGrSxJ9KWnGsqcDT7QNU32Q=;
	h=Message-ID:Date:From:To:Cc:Subject; b=MQIGrslSdYxRWu2F1UyYbvs3fu08sbP+DRK0rz3DckpqxDzFEuOUCvLj8wPpFSFXK9iBetXEiFUmWsxBE2RJYxRHsjDgWDlsz0fiCmiC8/bn2db1QKEMVZzjlwTATU9dBvjbN0tR2n0shi3/XJRbqKKvCs/gdKo1CTO0N/bTwyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz9MU/TG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A01AC4CEEB;
	Wed, 27 Aug 2025 20:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756326261;
	bh=jFbyxsG7RwRgME4YN/e4YGrSxJ9KWnGsqcDT7QNU32Q=;
	h=Date:From:To:Cc:Subject:From;
	b=cz9MU/TGs9kzMJ8uOKiGwyDFxIP2YcW/EBSJfxYgt/vpBCz4JtfC1SvoACWEkoyrC
	 bLgdn16KEJY2v29Pj3hluFS1u62ZrCx8Ko3dty6U42hNdsC6/pSQTzHytdHFYykQz/
	 YmCin9WJW5hJT90Ywn/uJvNzb8wbRQuSF4r9kcBro4Nr4V922AwymzV/2VzNyT/sQ0
	 9lRpqkeOXAkMM7hwm8879UzxUvqwCfbun+7nrRfb7MgzpKfPuhtBUncVqVhVf9r1sq
	 CrbLMuWr09RzOVvSaQbvMpUgaZMMdQRMbgZQ+K+s3gPfcvdxYiIDIWFy9Pd+u3u1qx
	 yogCn6BJVuksQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urMhE-00000003kvd-0zE5;
	Wed, 27 Aug 2025 16:24:40 -0400
Message-ID: <20250827201548.448472904@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 27 Aug 2025 16:15:48 -0400
From: Steven Rostedt <rostedt@kernel.org>
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
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [PATCH v10 00/11] unwind_deferred: Implement sframe handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


[
  This version is simply a rebase of v9 on top of the v6.17-rc3.
  It needs to be updated to work with the latest SFrame specification.
  Indu said she'll be able to make those changes, but I needed to
  forward port the latest code.

  You can test this code with the x86 and perf changes applied at:
  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
     unwind/sframe-test
]

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

Changes since v9: https://lore.kernel.org/linux-trace-kernel/20250717012848.927473176@kernel.org/

- Rebased on v6.17-rc3

- Update the changes to unwind/user.c to handle passing a const
  unwind_user_frame pointer.

Josh Poimboeuf (11):
      unwind_user/sframe: Add support for reading .sframe headers
      unwind_user/sframe: Store sframe section data in per-mm maple tree
      x86/uaccess: Add unsafe_copy_from_user() implementation
      unwind_user/sframe: Add support for reading .sframe contents
      unwind_user/sframe: Detect .sframe sections in executables
      unwind_user/sframe: Wire up unwind_user to sframe
      unwind_user/sframe/x86: Enable sframe unwinding on x86
      unwind_user/sframe: Remove .sframe section on detected corruption
      unwind_user/sframe: Show file name in debug output
      unwind_user/sframe: Add .sframe validation option
      unwind_user/sframe: Add prctl() interface for registering .sframe sections

----
 MAINTAINERS                       |   1 +
 arch/Kconfig                      |  23 ++
 arch/x86/Kconfig                  |   1 +
 arch/x86/include/asm/mmu.h        |   2 +-
 arch/x86/include/asm/uaccess.h    |  39 ++-
 fs/binfmt_elf.c                   |  49 +++-
 include/linux/mm_types.h          |   3 +
 include/linux/sframe.h            |  60 ++++
 include/linux/unwind_user_types.h |   4 +-
 include/uapi/linux/elf.h          |   1 +
 include/uapi/linux/prctl.h        |   6 +-
 kernel/fork.c                     |  10 +
 kernel/sys.c                      |   9 +
 kernel/unwind/Makefile            |   3 +-
 kernel/unwind/sframe.c            | 593 ++++++++++++++++++++++++++++++++++++++
 kernel/unwind/sframe.h            |  71 +++++
 kernel/unwind/sframe_debug.h      |  68 +++++
 kernel/unwind/user.c              |  41 ++-
 mm/init-mm.c                      |   2 +
 19 files changed, 967 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/sframe.h
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h
 create mode 100644 kernel/unwind/sframe_debug.h

