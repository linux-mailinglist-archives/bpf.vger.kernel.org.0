Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2429E393433
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhE0QnC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 12:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbhE0QnC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 12:43:02 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18A6C061574;
        Thu, 27 May 2021 09:41:27 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y2so1499764ybq.13;
        Thu, 27 May 2021 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+l4a65SFfahsGPe4r1E9ADTfkqEZTK+KAtWlOZb/3NU=;
        b=q7xCi4kx6BzY3h/W5ZHyfao57L0zxJqJzX2A/T/IELSwM8dqEY95sW//0R+hzz9Jit
         SLZuHBQEqvwH6HMtNmb3uNV22TBJJq+e7KkDkgas42uuNU84n8FDocJZhmSjDeBY+O0U
         bAs71ccpZ7S0nReVn6zNR95pQ2Pdx3qLNb0hHFrAkJHtsiaiYloMBU4YmV9pWSyUHym/
         UvjDehY78Fe8JaJkDnz7FplaMZ6JuOlhHD+3OmvJ9TG3FCQQHqdjOKQkY4aTu4qW0LXe
         958z4ikn7zJSe2cYWqOe6klqxHJYlwmMVIR4VSJMQlKQPzmCduhQ5QXk6nDIQtUeQfse
         wU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+l4a65SFfahsGPe4r1E9ADTfkqEZTK+KAtWlOZb/3NU=;
        b=uHo2vx1Mz03/iVjZr0Pf6BSyPgrVeVRMocHEbko6FBoXE1YoTEldkDVbWytcDKfdCH
         nXtqmhwnUdn/OIImLBrbtwOPVf9ZnSl+tXKQAKaRszD9hFC6oOQ5piej3fr+ZfFZuAs8
         bQ/e+YRzBezmEk2uTUM+4I+lnG/PefSULA/ZrPIWjTSmYH1Ip+qC8cz+y1k8f3xHo7TU
         hPag5OpKjPeyDt9pJG4xx2nMvlLlogSJmH+7WpYHZijoF+uVT22LsWqvTbE4lOpo1XOO
         HEwqQhE9lU5zlukNkHjudKa8kXyc8Kq9fBNK+W0biYEHPCQotSoJMH0VaC99/DDZhozi
         sITg==
X-Gm-Message-State: AOAM532njzyG4ssYtdh9dJsEqnyL0WmfxkT+UKacu+Q5eMYK5we5IGc3
        jKz0Lx7KFt7PAJATUt+pf9uCodQ5svAdjgkw4nc=
X-Google-Smtp-Source: ABdhPJw4r3p90tt/mwxh1t6xLrMX5Hq4iefF/RfM7bl+2bAHNjliN/2WZVATvcik5GjUtq1ZgFfSXSBoL/CVyRqZm30=
X-Received: by 2002:a25:7246:: with SMTP id n67mr6172067ybc.510.1622133687136;
 Thu, 27 May 2021 09:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
In-Reply-To: <162209754288.436794.3904335049560916855.stgit@devnote2>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 May 2021 09:41:16 -0700
Message-ID: <CAEf4BzYEUTquwjL2Ea+cjU4ipYVtoA2kdg74+u_hzHUKr39iKQ@mail.gmail.com>
Subject: Re: [PATCH -tip v7 00/13] kprobes: Fix stacktrace with kretprobes on x86
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 11:39 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hello,
>
> Here is the 7th version of the series to fix the stacktrace with kretprobe on x86.
>
> The previous version is;
>
>  https://lore.kernel.org/bpf/162201612941.278331.5293566981784464165.stgit@devnote2/
>
> This version is adding Tested-by from Andrii and do minor cleanups to solve some
> warnings from kernel test bots.
>
> Changes from v6:
> For x86 and generic patch:
>   - Add Andrii's Tested-by. (Andrii, I think you have tested only x86, is it OK?)

right, only tested x86-64

> [11/13]:
>   - Remove superfluous #include <linux/kprobes.h>.
> [13/13]:
>   - Add a prototype for arch_kretprobe_fixup_return().
>
>
> With this series, unwinder can unwind stack correctly from ftrace as below;
>
>   # cd /sys/kernel/debug/tracing
>   # echo > trace
>   # echo 1 > options/sym-offset
>   # echo r vfs_read >> kprobe_events
>   # echo r full_proxy_read >> kprobe_events
>   # echo traceoff:1 > events/kprobes/r_vfs_read_0/trigger
>   # echo stacktrace:1 > events/kprobes/r_full_proxy_read_0/trigger
>   # echo 1 > events/kprobes/enable
>   # cat /sys/kernel/debug/kprobes/list
> ffffffff8133b740  r  full_proxy_read+0x0    [FTRACE]
> ffffffff812560b0  r  vfs_read+0x0    [FTRACE]
>   # echo 0 > events/kprobes/enable
>   # cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 3/3   #P:8
> #
> #                                _-----=> irqs-off
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| /     delay
> #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> #              | |         |   ||||      |         |
>            <...>-134     [007] ...1    16.185877: r_full_proxy_read_0: (vfs_read+0x98/0x180 <- full_proxy_read)
>            <...>-134     [007] ...1    16.185901: <stack trace>
>  => kretprobe_trace_func+0x209/0x300
>  => kretprobe_dispatcher+0x4a/0x70
>  => __kretprobe_trampoline_handler+0xd4/0x170
>  => trampoline_handler+0x43/0x60
>  => kretprobe_trampoline+0x2a/0x50
>  => vfs_read+0x98/0x180
>  => ksys_read+0x5f/0xe0
>  => do_syscall_64+0x37/0x90
>  => entry_SYSCALL_64_after_hwframe+0x44/0xae
>            <...>-134     [007] ...1    16.185902: r_vfs_read_0: (ksys_read+0x5f/0xe0 <- vfs_read)
>
> This shows the double return probes (vfs_read and full_proxy_read) on the stack
> correctly unwinded. (vfs_read will return to ksys_read+0x5f and full_proxy_read
> will return to vfs_read+0x98)
>
> This actually changes the kretprobe behavisor a bit, now the instraction pointer in
> the pt_regs passed to kretprobe user handler is correctly set the real return
> address. So user handlers can get it via instruction_pointer() API.
>
> You can also get this series from
>  git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/kretprobe-stackfix-v7
>
>
> Thank you,
>
> ---
>
> Josh Poimboeuf (1):
>       x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline code
>
> Masami Hiramatsu (12):
>       ia64: kprobes: Fix to pass correct trampoline address to the handler
>       kprobes: treewide: Replace arch_deref_entry_point() with dereference_symbol_descriptor()
>       kprobes: treewide: Remove trampoline_address from kretprobe_trampoline_handler()
>       kprobes: Add kretprobe_find_ret_addr() for searching return address
>       ARC: Add instruction_pointer_set() API
>       ia64: Add instruction_pointer_set() API
>       arm: kprobes: Make a space for regs->ARM_pc at kretprobe_trampoline
>       kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
>       x86/kprobes: Push a fake return address at kretprobe_trampoline
>       x86/unwind: Recover kretprobe trampoline entry
>       tracing: Show kretprobe unknown indicator only for kretprobe_trampoline
>       x86/kprobes: Fixup return address in generic trampoline handler
>
>
>  arch/arc/include/asm/ptrace.h       |    5 ++
>  arch/arc/kernel/kprobes.c           |    2 -
>  arch/arm/probes/kprobes/core.c      |    5 +-
>  arch/arm64/kernel/probes/kprobes.c  |    3 -
>  arch/csky/kernel/probes/kprobes.c   |    2 -
>  arch/ia64/include/asm/ptrace.h      |    5 ++
>  arch/ia64/kernel/kprobes.c          |   15 ++---
>  arch/mips/kernel/kprobes.c          |    3 -
>  arch/parisc/kernel/kprobes.c        |    4 +
>  arch/powerpc/kernel/kprobes.c       |   13 ----
>  arch/riscv/kernel/probes/kprobes.c  |    2 -
>  arch/s390/kernel/kprobes.c          |    2 -
>  arch/sh/kernel/kprobes.c            |    2 -
>  arch/sparc/kernel/kprobes.c         |    2 -
>  arch/x86/include/asm/kprobes.h      |    1
>  arch/x86/include/asm/unwind.h       |   23 +++++++
>  arch/x86/include/asm/unwind_hints.h |    5 ++
>  arch/x86/kernel/kprobes/core.c      |   53 +++++++++++++++--
>  arch/x86/kernel/unwind_frame.c      |    3 -
>  arch/x86/kernel/unwind_guess.c      |    3 -
>  arch/x86/kernel/unwind_orc.c        |   18 +++++-
>  include/linux/kprobes.h             |   44 ++++++++++++--
>  kernel/kprobes.c                    |  108 +++++++++++++++++++++++++----------
>  kernel/trace/trace_output.c         |   17 +-----
>  lib/error-inject.c                  |    3 +
>  25 files changed, 238 insertions(+), 105 deletions(-)
>
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
