Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40723338611
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 07:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCLGlx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Mar 2021 01:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231951AbhCLGlu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Mar 2021 01:41:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FDA964EB6;
        Fri, 12 Mar 2021 06:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615531309;
        bh=s1CzigneOTNdXWYGbXQYwOV1UDRtWQXrBfUfSKWZlGY=;
        h=From:To:Cc:Subject:Date:From;
        b=qTlqid81pJ+WQsoWPiFDbysfXi3vBRXVJev9qGyvc6Lv88Dau8Eg09Ct97kj1VV8y
         h3Sk7JRq1Z6lOVQyRi6krl44vifzDRuSYoxRArKC+pCjuajnIF82MmjXhWoT9OIPrE
         RAnF+0W1yeayIeKx77wxkSRTEVFvJ78OOcX4ob/5XPkctTgp1szVX0BNQAdBpOYDX4
         EXSl5p7AvhjlMkq7cseVBv+5zLDk6hjrd6kglr977Uk+Qt0cU3FE58Vkau/HC4Hp5f
         k1bn20ffs0E3HCpVCsCsCjU/tuRU7FMTQwYkRF3OAhwJP/2XyUd8EKD8oK1RT65Qjo
         wmuJJMWCHU+rA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH -tip v2 00/10] kprobes: Fix stacktrace with kretprobes
Date:   Fri, 12 Mar 2021 15:41:44 +0900
Message-Id: <161553130371.1038734.7661319550287837734.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Here is the 2nd version of the series to fix the stacktrace with kretprobe.

The 1st series is here;

https://lore.kernel.org/bpf/161495873696.346821.10161501768906432924.stgit@devnote2/

In this version I merged the ORC unwinder fix for kretprobe which discussed in the
previous thread. [3/10] is updated according to the Miroslav's comment. [4/10] is
updated for simplify the code. [5/10]-[9/10] are discussed in the previsous tread
and are introduced to the series.

Daniel, can you also test this again? I and Josh discussed a bit different
method and I've implemented it on this version.

This actually changes the kretprobe behavisor a bit, now the instraction pointer in
the pt_regs passed to kretprobe user handler is correctly set the real return
address. So user handlers can get it via instruction_pointer() API.

Thank you,

---

Josh Poimboeuf (1):
      x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline code

Masami Hiramatsu (9):
      ia64: kprobes: Fix to pass correct trampoline address to the handler
      kprobes: treewide: Replace arch_deref_entry_point() with dereference_function_descriptor()
      kprobes: treewide: Remove trampoline_address from kretprobe_trampoline_handler()
      kprobes: stacktrace: Recover the address changed by kretprobe
      ARC: Add instruction_pointer_set() API
      ia64: Add instruction_pointer_set() API
      kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
      x86/unwind/orc: Fixup kretprobe trampoline entry
      tracing: Remove kretprobe unknown indicator from stacktrace


 arch/arc/include/asm/ptrace.h       |    5 ++
 arch/arc/kernel/kprobes.c           |    2 -
 arch/arm/probes/kprobes/core.c      |    3 -
 arch/arm64/kernel/probes/kprobes.c  |    3 -
 arch/csky/kernel/probes/kprobes.c   |    2 -
 arch/ia64/include/asm/ptrace.h      |    6 +++
 arch/ia64/kernel/kprobes.c          |   15 ++----
 arch/mips/kernel/kprobes.c          |    3 -
 arch/parisc/kernel/kprobes.c        |    4 +-
 arch/powerpc/kernel/kprobes.c       |   13 -----
 arch/riscv/kernel/probes/kprobes.c  |    2 -
 arch/s390/kernel/kprobes.c          |    2 -
 arch/sh/kernel/kprobes.c            |    2 -
 arch/sparc/kernel/kprobes.c         |    2 -
 arch/x86/include/asm/unwind.h       |    4 ++
 arch/x86/include/asm/unwind_hints.h |    5 ++
 arch/x86/kernel/kprobes/core.c      |    5 +-
 arch/x86/kernel/unwind_orc.c        |   16 +++++++
 include/linux/kprobes.h             |   41 +++++++++++++++--
 kernel/kprobes.c                    |   84 +++++++++++++++++++++--------------
 kernel/stacktrace.c                 |   22 +++++++++
 kernel/trace/trace_output.c         |   27 ++---------
 lib/error-inject.c                  |    3 +
 23 files changed, 170 insertions(+), 101 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
