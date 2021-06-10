Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE12F3A22E8
	for <lists+bpf@lfdr.de>; Thu, 10 Jun 2021 05:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFJDmz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 23:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJDmz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Jun 2021 23:42:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A34C061574;
        Wed,  9 Jun 2021 20:40:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v12so235711plo.10;
        Wed, 09 Jun 2021 20:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Xlibc6hX8kwCcZz0XQ+FE2nBQRDGeD6dPLbec7873k=;
        b=DVTYq6Mr1yqRlhqT7rDJJzuzmOmfvg9GpbBgcFCCMoS2myqdZzw4QprxJa3JuRM0bT
         fszOnj6rUU7V7rYDu0HGjJcJy1yQAUdizhaEoGkPQzR15ji4aDgk+aXSrhcsi7gqhe+G
         FbdtEAWpmeblMOYMUvr2S21hfhKKrlglWsQBqonLnxMmqrsmn/d6e7SiWMqOV3qNwCVt
         MjkE0KZvqwHcPR1gFvf6SGbPoar3A3hQy1/dss8bOCmgU9bYYqUwRNPllieVX49CDrRs
         OGKsrv8nYSQYOj9EWI/IpaiVHNGbMB2096LrKggIDabS0tZogPRN014RCOf5EOHysaLH
         EbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Xlibc6hX8kwCcZz0XQ+FE2nBQRDGeD6dPLbec7873k=;
        b=JikrwUeFQzNm4P/ORdLegpXDihJxiRbU7lFcL/JXZw0t9Uw1RFrQzZ4j5cDLZfgTZH
         nuxqqnWv1cevyo2jX+rWaHcvNqlQu/Kou6gr+7bcbz7ed2NFt79r7eSEgqf5u3h7KI8s
         t9rGBDzrHBis16KRKdBi86nyzkEf8fJHHV2xcCntj79VTLqovqC3xO5f/8+tuqLc/mQR
         Kt1H2aENUlM8nzFF+nOHs97rKHg7pO8JQaWk8fqdDL2oAZpl5ymyWMLjkZvy76EhJ7Qy
         mWJ7X1qetwjfV0otX/pQjPgK6yEi5HxibxNSXq+sFv4nR3Ejnq1H/syGe5pCnmRBEMM5
         czOQ==
X-Gm-Message-State: AOAM530kLORc+RJkQvMiaUzMadOHcK1A69lY1vKuAYyi2gtZyv6TwjLs
        aD0b4WqYDRfn2gVxmPc6sYClOQlWuFLroQ==
X-Google-Smtp-Source: ABdhPJxgl9h4/OPyjw92jNQqYTa2w/KubhZ0K6geEeXfvOoqlm7ziFyRkXCKamikxNJH3oslXBnMlQ==
X-Received: by 2002:a17:90b:881:: with SMTP id bj1mr1103306pjb.119.1623296459278;
        Wed, 09 Jun 2021 20:40:59 -0700 (PDT)
Received: from devnote2 (122x208x150x49.ap122.ftth.ucom.ne.jp. [122.208.150.49])
        by smtp.gmail.com with ESMTPSA id t14sm1059136pgm.9.2021.06.09.20.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 20:40:58 -0700 (PDT)
Date:   Thu, 10 Jun 2021 12:40:52 +0900
From:   Masami Hiramatsu <masami.hiramatsu@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v7 00/13] kprobes: Fix stacktrace with kretprobes
 on x86
Message-Id: <20210610124052.486df6a3bcc5337919e21e83@gmail.com>
In-Reply-To: <162209754288.436794.3904335049560916855.stgit@devnote2>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Josh,

Would you have any comment on this series?

Thank you,

On Thu, 27 May 2021 15:39:03 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

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


-- 
Masami Hiramatsu
