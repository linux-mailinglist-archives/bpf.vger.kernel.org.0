Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84ADF341CB2
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 13:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhCSMWV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 08:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhCSMVu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 08:21:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 973EA64F78;
        Fri, 19 Mar 2021 12:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616156509;
        bh=FTrIIc6U927CHQHSTFFu24LOI1k62Z24yFYNKhrFFkQ=;
        h=From:To:Cc:Subject:Date:From;
        b=df7qCg7DUsM7d+mywJhhnkvCeYfXepMuvvYxv/e/I8glxQdD1vJjj0kX3LNhStvw1
         d5sfjkBVL4xnzqvAqStdk7EnquVecNOl+x1BajLb1rW4kABrlPMxWmXHPDkGjZ/zUs
         Sd8e5K39WqRdMpDaFdU4vYN7kQU+PVTNq3UtpFtS3xEguURyTKkO+nLwG6TxRaLUiV
         Qy2OYIAmBTGI2CcajoGLle5RWpEJNDXfMYmaQqXCdB+hpri7eo4hTDC1QJ+VnfeTuN
         yykJNaqZKY6sFsQWNXkDJ/LywJf79bs+fEXg8ZFYpNYyyq+NTHmIm19c3JUIcGbJ7N
         tUUgHh1aWm32g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: [PATCH -tip v3 00/11] kprobes: Fix stacktrace with kretprobes on x86
Date:   Fri, 19 Mar 2021 21:21:43 +0900
Message-Id: <161615650355.306069.17260992641363840330.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Here is the 3rd version of the series to fix the stacktrace with kretprobe
on x86.

The previous version is;

https://lore.kernel.org/bpf/161553130371.1038734.7661319550287837734.stgit@devnote2/

Instead of solving generic stacktrace, this version is focusing on x86
stack unwinders. Anyway this introduces the generic APIs for the solution,
other architectures can fix their unwinder with that.

In this version, generic stacktrace fixups in [4/11] is dropped. Instead,
[4/11] is just providing kretprobe_find_ret_addr(). And previous ORC
unwinder fix patch is splitted into [9/11] and [10/11].
[9/11] fixes x86 kretprobe trampoline so that it pushes an additional
kretprobe_trampoline at the bottom of stackframe as a fake return address
according to Josh's suggestion. And [10/11] fixes all unwinders in x86
(guess, frame, and ORC). 
Finally, [11/11] is renewed to check the kretprobe_trampoline address
correctly instead of removing all indicator logic, because except for
the x86, it will see the kretprobe_trampoline in the stack trace until
it is fixed on each architecture.

With this series, unwinder can unwind stack correctly from ftrace as below;

  # cd /sys/kernel/debug/tracing
  # echo > trace
  # echo r vfs_read >> kprobe_events
  # echo r full_proxy_read >> kprobe_events
  # echo traceoff:1 > events/kprobes/r_vfs_read_0/trigger
  # echo stacktrace:1 > events/kprobes/r_full_proxy_read_0/trigger
  # echo 1 > events/kprobes/enable
  # echo 1 > options/sym-offset
  # cat /sys/kernel/debug/kprobes/list
ffffffff8133b740  r  full_proxy_read+0x0    [FTRACE]
ffffffff812560b0  r  vfs_read+0x0    [FTRACE]
  # echo 0 > events/kprobes/enable
  # cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 3/3   #P:8
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| /     delay
#           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
#              | |         |   ||||      |         |
           <...>-135     [005] ...1     9.422114: r_full_proxy_read_0: (vfs_read+0xab/0x1a0 <- full_proxy_read)
           <...>-135     [005] ...1     9.422158: <stack trace>
 => kretprobe_trace_func+0x209/0x2f0
 => kretprobe_dispatcher+0x4a/0x70
 => __kretprobe_trampoline_handler+0xca/0x150
 => trampoline_handler+0x44/0x70
 => kretprobe_trampoline+0x2a/0x50
 => vfs_read+0xab/0x1a0
 => ksys_read+0x5f/0xe0
 => do_syscall_64+0x33/0x40
 => entry_SYSCALL_64_after_hwframe+0x44/0xae
 => 0

This shows the double return probes (vfs_read and full_proxy_read) on the stack
correctly unwinded. (vfs_read was called from ksys_read+0x5f and full_proxy_read
was called from vfs_read+0xab)

This actually changes the kretprobe behavisor a bit, now the instraction pointer in
the pt_regs passed to kretprobe user handler is correctly set the real return
address. So user handlers can get it via instruction_pointer() API.

You can also get this series from 
 git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/kretprobe-stackfix-v3

Thank you,

---

Josh Poimboeuf (1):
      x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline code

Masami Hiramatsu (10):
      ia64: kprobes: Fix to pass correct trampoline address to the handler
      kprobes: treewide: Replace arch_deref_entry_point() with dereference_function_descriptor()
      kprobes: treewide: Remove trampoline_address from kretprobe_trampoline_handler()
      kprobes: Add kretprobe_find_ret_addr() for searching return address
      ARC: Add instruction_pointer_set() API
      ia64: Add instruction_pointer_set() API
      kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
      x86/kprobes: Push a fake return address at kretprobe_trampoline
      x86/unwind: Recover kretprobe trampoline entry
      tracing: Show kretprobe unknown indicator only for kretprobe_trampoline


 arch/arc/include/asm/ptrace.h       |    5 ++
 arch/arc/kernel/kprobes.c           |    2 -
 arch/arm/probes/kprobes/core.c      |    3 -
 arch/arm64/kernel/probes/kprobes.c  |    3 -
 arch/csky/kernel/probes/kprobes.c   |    2 -
 arch/ia64/include/asm/ptrace.h      |    8 ++-
 arch/ia64/kernel/kprobes.c          |   15 ++---
 arch/mips/kernel/kprobes.c          |    3 -
 arch/parisc/kernel/kprobes.c        |    4 +
 arch/powerpc/kernel/kprobes.c       |   13 -----
 arch/riscv/kernel/probes/kprobes.c  |    2 -
 arch/s390/kernel/kprobes.c          |    2 -
 arch/sh/kernel/kprobes.c            |    2 -
 arch/sparc/kernel/kprobes.c         |    2 -
 arch/x86/include/asm/kprobes.h      |    1 
 arch/x86/include/asm/unwind.h       |   17 ++++++
 arch/x86/include/asm/unwind_hints.h |    5 ++
 arch/x86/kernel/kprobes/core.c      |   30 ++++++++---
 arch/x86/kernel/unwind_frame.c      |    4 +
 arch/x86/kernel/unwind_guess.c      |    3 -
 arch/x86/kernel/unwind_orc.c        |    6 +-
 include/linux/kprobes.h             |   41 ++++++++++++--
 kernel/kprobes.c                    |   99 ++++++++++++++++++++++++-----------
 kernel/trace/trace_output.c         |   17 +-----
 lib/error-inject.c                  |    3 +
 25 files changed, 187 insertions(+), 105 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
