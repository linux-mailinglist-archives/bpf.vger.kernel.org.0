Return-Path: <bpf+bounces-62620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA5CAFC097
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5553AE406
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F1E220F59;
	Tue,  8 Jul 2025 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA+CrwH3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91F8217719;
	Tue,  8 Jul 2025 02:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940718; cv=none; b=EQG1lBmyAzA6LEJyQSQSZmZ3lZf/hbJrOHwZAlE2UL+nezc9WcOHNA/RZXDyJ9pNoP/leMlBM7mOU5XO7B76i3Q7jnKqbznxRWWEGUZZ18kDLBuAuyo4uAyOuwhzvgFiHh7DvArEmMflbpjj2re5Tcpizg85dZPubkNUNvWNn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940718; c=relaxed/simple;
	bh=HUAMBVlHDy1ZZzedd5ag1omB8qFZjUS0QyoIpq9v38I=;
	h=Message-ID:Date:From:To:Cc:Subject; b=WRylJ/EmG1mEwlEuhyXApPZDNxLK7kcG14MaUJqshpAjSIaOb+QV9jZ41vI0PE1xWtH5k/trs8oQJDHzp4DHIMdKo7qJ1sGoVyozXp2hyMSMxR6AmqCYs7AzvvuuL3H47DdqVe7cVeHQSwl/Rpq6Yi4mC4ypMABzwhMtQE0No68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA+CrwH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60560C4CEF5;
	Tue,  8 Jul 2025 02:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940718;
	bh=HUAMBVlHDy1ZZzedd5ag1omB8qFZjUS0QyoIpq9v38I=;
	h=Date:From:To:Cc:Subject:From;
	b=UA+CrwH33vbHJ5WsV3jEQD9MJAUCtMna90WFO7Xk52c6yzQ3wtcNLFhbudxJi4nsy
	 NfmloDP/X9tbc712OZHILt6wC1FbnWHRindi0RAge89oaxHMKMAAkINeUrRw01bEXW
	 6qQIMCBEHbqdVyO/OSRDUrGDezpAig2YAPrym+tdglimM7MWtOuV/5MUGqGqZ5gX4+
	 FTe/ryqGq/PFcUQzrSWNUhoEPfB3yLXzvMgHzMuFqs9b/GY4fCdrtWxA3QSwkAnRk4
	 NFfc5zVQyx9TpuOB4/+BTKmw5hkzdI+ic46l1QjllZ8XJIUCMpT9Xz+mmyXESRANIl
	 0pxG3EgweO2iQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxoM-00000000DaZ-26iW;
	Mon, 07 Jul 2025 22:11:58 -0400
Message-ID: <20250708021115.894007410@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:11:15 -0400
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
Subject: [PATCH v8 00/12] unwind_deferred: Implement sframe handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


This code is based on top of:

 https://lore.kernel.org/linux-trace-kernel/20250708012239.268642741@kernel.org/ 
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

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unwind/sframe

The unwind/main branch is just unwind/sframe merged into unwind/perf
and can be used for testing with perf.

Changes since v7: https://lore.kernel.org/linux-trace-kernel/20250701184939.026626626@goodmis.org/

- Simply rebased on top of the latest unwind/core

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
      unwind_user/sframe: Add prctl() interface for registering .sframe sections

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

