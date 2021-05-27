Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C5A3927C0
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhE0Gkk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 02:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhE0Gkj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 02:40:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0401613C9;
        Thu, 27 May 2021 06:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622097547;
        bh=XD01Y0bcd5+1m4bw+9rns9YoNtGaOH1c2xAZPCzKXog=;
        h=From:To:Cc:Subject:Date:From;
        b=j3aD/gJJjAQ7QtnhBjALtSvw7J5vCOdHLcco/6Sd6aEvlp+L/ZCPGB8DHv2SY8NDy
         J0oInk6aOmFGfCu5XgMHFOWjF/l6LfZaRI75//px+NWbYP9JZM0RgDpE9mt0gj2Bh3
         YW01UFBqO3m+37jpiqcIT/UfDPyumvkGlvCYlUf58DbEcyf3+hQ9MLZcPi4K5143Ws
         qIuHAq/4C+IFY+U2e8j5lx6s5RQE4+n//CuZ4Z2iZ2NdV+7B77Nr3jSiepe1QoTubt
         edQBkPwizkDT0cbiv4B3S8bPIv/yXJqoeyX0srjspem8nP3xjkpAGPPDdQeHOjDZxN
         XAI8V8ea1PI7w==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v7 00/13] kprobes: Fix stacktrace with kretprobes on x86
Date:   Thu, 27 May 2021 15:39:03 +0900
Message-Id: <162209754288.436794.3904335049560916855.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Here is the 7th version of the series to fix the stacktrace with kretprobe on x86.

The previous version is;

 https://lore.kernel.org/bpf/162201612941.278331.5293566981784464165.stgit@devnote2/

This version is adding Tested-by from Andrii and do minor cleanups to solve some
warnings from kernel test bots.

Changes from v6:
For x86 and generic patch:
  - Add Andrii's Tested-by. (Andrii, I think you have tested only x86, is it OK?)
[11/13]:
  - Remove superfluous #include <linux/kprobes.h>.
[13/13]:
  - Add a prototype for arch_kretprobe_fixup_return().


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

This shows the double return probes (vfs_read and full_proxy_read) on the stack
correctly unwinded. (vfs_read will return to ksys_read+0x5f and full_proxy_read
will return to vfs_read+0x98)

This actually changes the kretprobe behavisor a bit, now the instraction pointer in
the pt_regs passed to kretprobe user handler is correctly set the real return
address. So user handlers can get it via instruction_pointer() API.

You can also get this series from 
 git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/kretprobe-stackfix-v7


Thank you,

---

Josh Poimboeuf (1):
      x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline code

Masami Hiramatsu (12):
      ia64: kprobes: Fix to pass correct trampoline address to the handler
      kprobes: treewide: Replace arch_deref_entry_point() with dereference_symbol_descriptor()
      kprobes: treewide: Remove trampoline_address from kretprobe_trampoline_handler()
      kprobes: Add kretprobe_find_ret_addr() for searching return address
      ARC: Add instruction_pointer_set() API
      ia64: Add instruction_pointer_set() API
      arm: kprobes: Make a space for regs->ARM_pc at kretprobe_trampoline
      kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
      x86/kprobes: Push a fake return address at kretprobe_trampoline
      x86/unwind: Recover kretprobe trampoline entry
      tracing: Show kretprobe unknown indicator only for kretprobe_trampoline
      x86/kprobes: Fixup return address in generic trampoline handler


 arch/arc/include/asm/ptrace.h       |    5 ++
 arch/arc/kernel/kprobes.c           |    2 -
 arch/arm/probes/kprobes/core.c      |    5 +-
 arch/arm64/kernel/probes/kprobes.c  |    3 -
 arch/csky/kernel/probes/kprobes.c   |    2 -
 arch/ia64/include/asm/ptrace.h      |    5 ++
 arch/ia64/kernel/kprobes.c          |   15 ++---
 arch/mips/kernel/kprobes.c          |    3 -
 arch/parisc/kernel/kprobes.c        |    4 +
 arch/powerpc/kernel/kprobes.c       |   13 ----
 arch/riscv/kernel/probes/kprobes.c  |    2 -
 arch/s390/kernel/kprobes.c          |    2 -
 arch/sh/kernel/kprobes.c            |    2 -
 arch/sparc/kernel/kprobes.c         |    2 -
 arch/x86/include/asm/kprobes.h      |    1 
 arch/x86/include/asm/unwind.h       |   23 +++++++
 arch/x86/include/asm/unwind_hints.h |    5 ++
 arch/x86/kernel/kprobes/core.c      |   53 +++++++++++++++--
 arch/x86/kernel/unwind_frame.c      |    3 -
 arch/x86/kernel/unwind_guess.c      |    3 -
 arch/x86/kernel/unwind_orc.c        |   18 +++++-
 include/linux/kprobes.h             |   44 ++++++++++++--
 kernel/kprobes.c                    |  108 +++++++++++++++++++++++++----------
 kernel/trace/trace_output.c         |   17 +-----
 lib/error-inject.c                  |    3 +
 25 files changed, 238 insertions(+), 105 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
