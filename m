Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC7A3C3CDC
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 15:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhGKNhc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 09:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231658AbhGKNhc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 09:37:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75854611BF;
        Sun, 11 Jul 2021 13:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626010485;
        bh=gsR1MX8Qz80MkKwgDmnRKBozqKVabW5PK/06xuGJmuY=;
        h=From:To:Cc:Subject:Date:From;
        b=n9xV4U8jR2mBqnXkYx1OZwHflr140aBXdQi/27pZadegvcH/THCQ1j0+3ZgSfWy07
         1QoLAGWJL7t4PEXM2LkuRsy2NQVym6i1pq2nThUbgi81gJqDDK6QyuumFvy1A7WWy5
         kJtWJlUK9FFnpqzPHW1iVoY7rtAZD77Hg3aHOUgk+JIwaBUsY8RmgJXGNbTjVXaaqu
         gcw6Um0Bubf9XtY1LbBygRNomFFJzMtRXg+K+vlmKkpy82uaeZDT5dBh2AKgXhnUgA
         BTRuI1bfwrDPtkhm5qU+T8NBicC/VFMrvL2qno49J0V+7LP9sRnHoUaZvdIPQcrZLc
         ZgPX44kKUAkLg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v9 00/14] kprobes: Fix stacktrace with kretprobes on x86
Date:   Sun, 11 Jul 2021 22:34:40 +0900
Message-Id: <162601048053.1318837.1550594515476777588.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

This is the 9th version of the series to fix the stacktrace with kretprobe on x86.

The previous version is;

 https://lore.kernel.org/bpf/162399992186.506599.8457763707951687195.stgit@devnote2/

This version is mostly cleaning up changelogs, comments, and coding styles
accoding to Ingo's comment. This series also depends on my kprobe cleanup
series (*1) and Josh's objtool update series (*2)(*3)

(*1) https://lore.kernel.org/bpf/162598881438.1222130.11530594038964049135.stgit@devnote2/
(*2) https://lore.kernel.org/bpf/20210710192433.x5cgjsq2ksvaqnss@treble/
(*3) https://lore.kernel.org/bpf/20210710192514.ghvksi3ozhez4lvb@treble/

Changes from v8:
 [1/14]
      - Update changelog and add stable to Cc.
 [2/14]
      - Update changelog.
 [3/14]
      - Update changelog.
 [4/14]
      - Newly added accoding to Ingo's suggestion.
 [5/14]
      - Update changelog and comments.
      - Consolidate the prototypes in the header file.
      - Make __kretprobe_find_ret_addr() return 'kprobe_opcode_t *'.
 [6/14]
      - Update changelog and comments.
      - Use STACK_FRAME_NON_STANDARD_FP().
 [8/14]
      - Fix "space at the start of a line" checkpatch warnings.
 [9/14]
      - Update changelog.
 [10/14]
      - Update comments to explain why this is needed.
 [11/14]
      - Update changelog and comments.
      - Remove unneeded type casting.
 [12/14]
      - Update comments.
 [14/14]
      - Fix the changelog and add more comments.

All over this series, I fixed my typo on Andrii's name (I'm sorry).


With this series, unwinder can unwind stack correctly from ftrace as below;

  # cd /sys/kernel/debug/tracing
  # echo > trace
  # echo 1 > options/sym-offset
  # echo r vfs_read >> kprobe_events
  # echo r full_proxy_read >> kprobe_events
  # echo traceoff:1 > events/kprobes/r_vfs_read_0/trigger
  # echo stacktrace:1 > events/kprobes/r_full_proxy_read_0/trigger
  # echo 1 > events/kprobes/enable
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
           <...>-134     [007] ...1    16.185877: r_full_proxy_read_0: (vfs_read+0x98/0x180 <- full_proxy_read)
           <...>-134     [007] ...1    16.185901: <stack trace>
 => kretprobe_trace_func+0x209/0x300
 => kretprobe_dispatcher+0x4a/0x70
 => __kretprobe_trampoline_handler+0xd4/0x170
 => trampoline_handler+0x43/0x60
 => kretprobe_trampoline+0x2a/0x50
 => vfs_read+0x98/0x180
 => ksys_read+0x5f/0xe0
 => do_syscall_64+0x37/0x90
 => entry_SYSCALL_64_after_hwframe+0x44/0xae
           <...>-134     [007] ...1    16.185902: r_vfs_read_0: (ksys_read+0x5f/0xe0 <- vfs_read)

This shows the double return probes (vfs_read() and full_proxy_read()) on the stack
correctly unwinded. (vfs_read() returns to 'ksys_read+0x5f' and full_proxy_read()
returns to 'vfs_read+0x98')

This also changes the kretprobe behavisor a bit, now the instraction pointer in
the 'pt_regs' passed to kretprobe user handler is correctly set the real return
address. So user handlers can get it via instruction_pointer() API, and can use
stack_trace_save_regs().

You can also get this series from 
 git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/kretprobe-stackfix-v9


Thank you,

---

Josh Poimboeuf (1):
      x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline()

Masami Hiramatsu (13):
      ia64: kprobes: Fix to pass correct trampoline address to the handler
      kprobes: treewide: Replace arch_deref_entry_point() with dereference_symbol_descriptor()
      kprobes: treewide: Remove trampoline_address from kretprobe_trampoline_handler()
      kprobes: treewide: Make it harder to refer kretprobe_trampoline directly
      kprobes: Add kretprobe_find_ret_addr() for searching return address
      ARC: Add instruction_pointer_set() API
      ia64: Add instruction_pointer_set() API
      arm: kprobes: Make space for instruction pointer on stack
      kprobes: Enable stacktrace from pt_regs in kretprobe handler
      x86/kprobes: Push a fake return address at kretprobe_trampoline
      x86/unwind: Recover kretprobe trampoline entry
      tracing: Show kretprobe unknown indicator only for kretprobe_trampoline
      x86/kprobes: Fixup return address in generic trampoline handler


 arch/arc/include/asm/kprobes.h                |    2 
 arch/arc/include/asm/ptrace.h                 |    5 +
 arch/arc/kernel/kprobes.c                     |   13 ++-
 arch/arm/probes/kprobes/core.c                |   11 +-
 arch/arm64/include/asm/kprobes.h              |    2 
 arch/arm64/kernel/probes/kprobes.c            |    5 -
 arch/arm64/kernel/probes/kprobes_trampoline.S |    4 -
 arch/csky/include/asm/kprobes.h               |    2 
 arch/csky/kernel/probes/kprobes.c             |    4 -
 arch/csky/kernel/probes/kprobes_trampoline.S  |    4 -
 arch/ia64/include/asm/ptrace.h                |    5 +
 arch/ia64/kernel/kprobes.c                    |   15 +--
 arch/mips/kernel/kprobes.c                    |   15 ++-
 arch/parisc/kernel/kprobes.c                  |    6 +
 arch/powerpc/include/asm/kprobes.h            |    2 
 arch/powerpc/kernel/kprobes.c                 |   29 ++----
 arch/powerpc/kernel/optprobes.c               |    2 
 arch/powerpc/kernel/stacktrace.c              |    2 
 arch/riscv/include/asm/kprobes.h              |    2 
 arch/riscv/kernel/probes/kprobes.c            |    4 -
 arch/riscv/kernel/probes/kprobes_trampoline.S |    4 -
 arch/s390/include/asm/kprobes.h               |    2 
 arch/s390/kernel/kprobes.c                    |   12 +--
 arch/s390/kernel/stacktrace.c                 |    2 
 arch/sh/include/asm/kprobes.h                 |    2 
 arch/sh/kernel/kprobes.c                      |   12 +--
 arch/sparc/include/asm/kprobes.h              |    2 
 arch/sparc/kernel/kprobes.c                   |   12 +--
 arch/x86/include/asm/kprobes.h                |    1 
 arch/x86/include/asm/unwind.h                 |   23 +++++
 arch/x86/include/asm/unwind_hints.h           |    5 +
 arch/x86/kernel/kprobes/core.c                |   71 ++++++++++++---
 arch/x86/kernel/unwind_frame.c                |    3 -
 arch/x86/kernel/unwind_guess.c                |    3 -
 arch/x86/kernel/unwind_orc.c                  |   21 ++++-
 include/linux/kprobes.h                       |   44 ++++++++--
 kernel/kprobes.c                              |  115 ++++++++++++++++++-------
 kernel/trace/trace_output.c                   |   17 +---
 lib/error-inject.c                            |    3 -
 39 files changed, 317 insertions(+), 171 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
