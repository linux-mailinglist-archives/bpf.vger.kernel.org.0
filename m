Return-Path: <bpf+bounces-60861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EECADDF28
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 00:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C213BAF41
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED72C298CB3;
	Tue, 17 Jun 2025 22:51:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E501E834F;
	Tue, 17 Jun 2025 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750200679; cv=none; b=sD2a2kcAz9+jGY0h058Re2mtzRGAVcM6LUQ4MgaZ/ztkUTKwm4AgavqYY9+912zQR2HI7TduFdKtXtzRskXPM8iXcar3pxo8ZyQs/mp5vBv3jFzGOhdkaZXXzCoskIpC/1DlgNYsCXaja2fxY9ua02De6C4HTQjBYnUWrIm0L4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750200679; c=relaxed/simple;
	bh=SjN/rIiMPkLfbU6LPwVgV6/uhSYa2otNoJovf1WdRG4=;
	h=Message-ID:Date:From:To:Cc:Subject; b=AbuAgtxj/nMcpfgaAFIxJ7pB5Dj5i5gfunCcocFz2y7g0JJkGU4aPEiLtaEH3iNCHaxGVwMROxrkpZdjHieEzwfkHaf/gxi4EXVdr+hIhmrF12s/irgum3qUrTSrb2SNOcOXC0IeibFB26urip2S4n0SNYdpi4F/jS+v18YzlW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 7567A810A6;
	Tue, 17 Jun 2025 22:51:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 7ED502002B;
	Tue, 17 Jun 2025 22:51:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uRf9B-00000002L2x-0cvj;
	Tue, 17 Jun 2025 18:51:17 -0400
Message-ID: <20250617225009.233007152@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Jun 2025 18:50:09 -0400
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
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 00/12] unwind_deferred: Implement sframe handling
X-Stat-Signature: j1pb3b6xcsrwsq3xz535mg64uo91nmzw
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 7ED502002B
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/W7Fxv7wI9MpYqbUWObtM/M1U7x9QTPDs=
X-HE-Tag: 1750200670-647277
X-HE-Meta: U2FsdGVkX19es+oLwhvoqLEn0NYvhC6onBJqfLm93XomIUPkMbFt6qGpX4zFUb7W3tF53swAax/9jdpvk37MTho7MOHjpPUgLsC48Rxc7Y3fgPA4l0Ju0QTmwL1nPRosFA4WunsNcb6UGlAPMd5VINuBqeqq4CZUNNyIRTXpY7zm7zrMVBWcF0vPGcky50Xc3gJw7I05gWgvk+l0y0TTdFtcic9DQQ6dxUb3FE0LlMnP6QOaMYDfPAE3zj5kK74fM2lJEN5RLkzJt4FW9oNVHOdZeMBgdC8UkMh2LVOA8OpaTypqGeXGXhaf1TK/uo5AG0Fpr0hksqE16lJzd5UPzX7WQzADWZUzZhclO0YjDN1lG7cZnNr6b7Zxgh2bYIncrx/xUJWJFJp/0aYE1rL944ZuFWzCgA+gZRv+FnncdbCSOZDpXMq89p6yehdUwWYykixYOv4rcbE3PHALg2p0sQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

This code is based on top of:

  https://patchwork.kernel.org/project/linux-trace-kernel/cover/20250611005421.144238328@goodmis.org/

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

-- Steve

[1] https://sourceware.org/binutils/wiki/sframe

Changes since v5: https://patchwork.kernel.org/project/linux-trace-kernel/cover/20250424201511.921245242@goodmis.org/

- Added updates from Jens Remus <jremus@linux.ibm.com>
  https://lore.kernel.org/all/20250528102655.1455423-1-jremus@linux.ibm.com/

- Have sframe use initialize the frame = &_frame

  The unwind code had the on stack _frame storage removed since it wasn't
  being used. The sframe code needs it. Add it back but only assign it
  when sframe is used.

Josh Poimboeuf (12):
      unwind_user/sframe: Add support for reading .sframe headers
      unwind_user/sframe: Store sframe section data in per-mm maple tree
      x86/uaccess: Add unsafe_copy_from_user() implementation
      unwind_user/sframe: Add support for reading .sframe contents
      unwind_user/sframe: Detect .sframe sections in executables
      unwind_user/sframe: Add prctl() interface for registering .sframe sections
      unwind_user/sframe: Wire up unwind_user to sframe
      unwind_user/sframe/x86: Enable sframe unwinding on x86
      unwind_user/sframe: Remove .sframe section on detected corruption
      unwind_user/sframe: Show file name in debug output
      unwind_user/sframe: Enable debugging in uaccess regions
      unwind_user/sframe: Add .sframe validation option

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
 kernel/unwind/Makefile            |   1 +
 kernel/unwind/sframe.c            | 612 ++++++++++++++++++++++++++++++++++++++
 kernel/unwind/sframe.h            |  71 +++++
 kernel/unwind/sframe_debug.h      |  99 ++++++
 kernel/unwind/user.c              |  25 +-
 mm/init-mm.c                      |   2 +
 19 files changed, 997 insertions(+), 18 deletions(-)
 create mode 100644 include/linux/sframe.h
 create mode 100644 kernel/unwind/sframe.c
 create mode 100644 kernel/unwind/sframe.h
 create mode 100644 kernel/unwind/sframe_debug.h

