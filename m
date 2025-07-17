Return-Path: <bpf+bounces-63521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274C4B08244
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B58563D38
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5281E5705;
	Thu, 17 Jul 2025 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evvfT5K9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE9410A1F;
	Thu, 17 Jul 2025 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715756; cv=none; b=pcDa8v59kpr0MvNOHddALHEulrd/C+D2VZW8pGnNNiFnfQtlIxeyESD97B48GwXLja+JK6hl671vL4ziyvQw5hFzIjQ8UFhFQp7+Lj6ZOcXWFAiVJdlsTDLes3CR6Y0sPX78wRCrZeO/00KWScCGdpwe0N4n7TSyCdTyFz67Qho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715756; c=relaxed/simple;
	bh=mwgGXlD+YqgvJfDNd+mq4DKUszz6+Y7D+MWVgagdQ6E=;
	h=Message-ID:Date:From:To:Cc:Subject; b=MTx5SI6Uggqi1Iq66bqbx9LxF5lCFOh4slCz2KHIoJig/PcCYw+jaBWaXmLBkzyh6Wb3rSgPwVb7zDsn7rz9dr29/q/8h1sCIkuOznzE8BurBQ8bJVg4qSTcdHvfSDn8stB8j7615i6ILpFgNBBmdERCo8IXfYcDPMnSOUDDV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evvfT5K9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0AAC4CEE7;
	Thu, 17 Jul 2025 01:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752715755;
	bh=mwgGXlD+YqgvJfDNd+mq4DKUszz6+Y7D+MWVgagdQ6E=;
	h=Date:From:To:Cc:Subject:From;
	b=evvfT5K9udXSEphaHh3rXj4+mONYCJrBnsypjSlEWlaE3Gi0LC2C1CYLndiYPRDwh
	 vzLlsaheSLrui0G9BFCspXWvYHj2B5lt6uHMOCbrN/krOq6NN6KFy4BL2/tkkGZ9A/
	 gWXXwEBHaaDXwHhb8Qg1gIkdecTinN0NOR1LRGwzQhbVwabBOSt7jkI/JQiJc9jrdz
	 /t9l46mpTYP37DgvFB37k1xR5RnVXcFM2aAqxlz75Z0/4j9siPpEo5hyaAXk4ulYZC
	 NAyZB7p+nh06UYFAn+vV4G7Bfp/1mlcpTOieTEAu4v6AjtTvG04eZDHQm/fABCEHwF
	 woopkXL1qkKuQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucDRH-000000068uF-3AMR;
	Wed, 16 Jul 2025 21:29:35 -0400
Message-ID: <20250717012848.927473176@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 16 Jul 2025 21:28:48 -0400
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
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v9 00/11] unwind_deferred: Implement sframe handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

This code is based on top of:

 https://lore.kernel.org/linux-trace-kernel/20250717004910.297898999@kernel.org/
  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
   unwind/core

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

The code for this series is located here:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unwind/sframe

Head SHA1: 2e9c59950d225f260c7407a54a10ea3fb682fde3

Changes since v8: https://lore.kernel.org/linux-trace-kernel/20250708021115.894007410@kernel.org/

- Rebased on the changes by Mathieu in the kernel/unwind/user.c file
  https://lore.kernel.org/all/20250710164301.3094-2-mathieu.desnoyers@efficios.com/

- Add "safe_read_fre()" and "safe_read_fde()" to call their respective
  functions with a user_read_access_begin() wrapper around them so that
  the validator can simply use dbg_sec() directly instead of a _uaccess()
  hacked version.

- Removed the hacky patch to debug sframes in user_access areas. (Linus Torvalds) 

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
      [DO NOT APPLY] unwind_user/sframe: Add prctl() interface for registering .sframe sections

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

