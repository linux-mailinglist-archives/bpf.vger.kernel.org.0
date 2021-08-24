Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCEE3F5784
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 07:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhHXFNC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Aug 2021 01:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhHXFNB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Aug 2021 01:13:01 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE96EC061575;
        Mon, 23 Aug 2021 22:12:17 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id k65so38517124yba.13;
        Mon, 23 Aug 2021 22:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrYRhpX8V2RxHliFgyoGiQz1nrfS1cZ96W8NbTEFTXA=;
        b=O3Hy0rGn0D/+9OlMmdod9ck0A1fu6zAHqpaf2Nq4mpXt5TvHelm3OyKSrv989Z4bnq
         42MuPy7uN8aC1+Hvl/WFPT/MQvGusaeD12r1dDCFhhwzzBaOEQAmCF43lviPDBxNKbKf
         c18komufG6iRNJrHxv90dhY88N8lxAuvPLac5745qw0GNFOTAQ6T0Wq0McL0zmySg1fD
         A93O3b28P+eeycy7SsaBHu+LdtmJmib8geFUXxDceXv/dmNvohsR8In/F7jRE+Djov4p
         xqTzLCzVYGqKgt4MU/ISJyzjETCCOWQwE4jMLVzoLcFvH3CkOd8ABVJTUOjqHMie1Gvq
         oetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrYRhpX8V2RxHliFgyoGiQz1nrfS1cZ96W8NbTEFTXA=;
        b=iQgtfv/VVMhu/bTdPeg6EWoWNyVyhVgTi9RCOG0v5FFT7cdl7u7BU/iT4+CE0rmTi9
         7bBUHznnn93czKxyIFOXsajsxZjd5xYKEJBAWkWAOP2FWuTNZWm9c3/0LeCI2PFcX9+z
         ywQhnZInnqegD0dfFFWq4Hp+XoMgzhH+I9vKn87oqo1IcaJE+BCgy/6KXtY1EnhBvRKY
         fqKjmwVRtKBeciSaA866WGxmrykV9QhEiPbOlchHRlfsPllkVsCFc012EG54U0LOlr+6
         ZBcRpmWIP/tSw+5pek6zH/zQ3T7nUASCIG+orZjdHydVeQJKfmIJbeXWIDK53rKMB8sS
         ZAkw==
X-Gm-Message-State: AOAM532jTNwpyrZhdr4bkDj9XWh1xPCHIvRpoYrhf7r4ApamqnKDi68U
        Q8sxXJOoXQoEfYxhZon9UbXIqysAiEop09pYoJE=
X-Google-Smtp-Source: ABdhPJy0Wx5/xOSiDxelaPuOpL34/4i2trBSGWHIlo/Heur7Lhrot/4g6kCCOg/uyGjN/ZNFBC433k5lcnHBXBE0A+s=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr50337899ybg.347.1629781937178;
 Mon, 23 Aug 2021 22:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <162756755600.301564.4957591913842010341.stgit@devnote2> <20210730083549.4e36df1cba88e408dc60b031@kernel.org>
In-Reply-To: <20210730083549.4e36df1cba88e408dc60b031@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Aug 2021 22:12:06 -0700
Message-ID: <CAEf4Bzb2i4Z9kUWU+L-HF3k+XQ0V3hLH1Er7U2_oCdv1BTvaBw@mail.gmail.com>
Subject: Re: [PATCH -tip v10 00/16] kprobes: Fix stacktrace with kretprobes on x86
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 29, 2021 at 4:35 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Thu, 29 Jul 2021 23:05:56 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > Hello,
> >
> > This is the 10th version of the series to fix the stacktrace with kretprobe on x86.
> >
> > The previous version is here;
> >
> >  https://lore.kernel.org/bpf/162601048053.1318837.1550594515476777588.stgit@devnote2/
> >
> > This version is rebased on top of new kprobes cleanup series(*1) and merging
> > Josh's objtool update series (*2)(*3) as [6/16] and [7/16].
> >
> > (*1) https://lore.kernel.org/bpf/162748615977.59465.13262421617578791515.stgit@devnote2/
> > (*2) https://lore.kernel.org/bpf/20210710192433.x5cgjsq2ksvaqnss@treble/
> > (*3) https://lore.kernel.org/bpf/20210710192514.ghvksi3ozhez4lvb@treble/
> >
> > Changes from v9:
> >  - Add Josh's objtool update patches with a build error fix as [6/16] and [7/16].
> >  - Add a API document for kretprobe_find_ret_addr() and check cur != NULL in [5/16].
> >
> > With this series, unwinder can unwind stack correctly from ftrace as below;
> >
> >   # cd /sys/kernel/debug/tracing
> >   # echo > trace
> >   # echo 1 > options/sym-offset
> >   # echo r vfs_read >> kprobe_events
> >   # echo r full_proxy_read >> kprobe_events
> >   # echo traceoff:1 > events/kprobes/r_vfs_read_0/trigger
> >   # echo stacktrace:1 > events/kprobes/r_full_proxy_read_0/trigger
> >   # echo 1 > events/kprobes/enable
> >   # cat /sys/kernel/debug/kprobes/list
> > ffffffff8133b740  r  full_proxy_read+0x0    [FTRACE]
> > ffffffff812560b0  r  vfs_read+0x0    [FTRACE]
> >   # echo 0 > events/kprobes/enable
> >   # cat trace
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 3/3   #P:8
> > #
> > #                                _-----=> irqs-off
> > #                               / _----=> need-resched
> > #                              | / _---=> hardirq/softirq
> > #                              || / _--=> preempt-depth
> > #                              ||| /     delay
> > #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> > #              | |         |   ||||      |         |
> >            <...>-134     [007] ...1    16.185877: r_full_proxy_read_0: (vfs_read+0x98/0x180 <- full_proxy_read)
> >            <...>-134     [007] ...1    16.185901: <stack trace>
> >  => kretprobe_trace_func+0x209/0x300
> >  => kretprobe_dispatcher+0x4a/0x70
> >  => __kretprobe_trampoline_handler+0xd4/0x170
> >  => trampoline_handler+0x43/0x60
> >  => kretprobe_trampoline+0x2a/0x50
> >  => vfs_read+0x98/0x180
> >  => ksys_read+0x5f/0xe0
> >  => do_syscall_64+0x37/0x90
> >  => entry_SYSCALL_64_after_hwframe+0x44/0xae
> >            <...>-134     [007] ...1    16.185902: r_vfs_read_0: (ksys_read+0x5f/0xe0 <- vfs_read)
> >
> > This shows the double return probes (vfs_read() and full_proxy_read()) on the stack
> > correctly unwinded. (vfs_read() returns to 'ksys_read+0x5f' and full_proxy_read()
> > returns to 'vfs_read+0x98')
> >
> > This also changes the kretprobe behavisor a bit, now the instraction pointer in
> > the 'pt_regs' passed to kretprobe user handler is correctly set the real return
> > address. So user handlers can get it via instruction_pointer() API, and can use
> > stack_trace_save_regs().
> >
> > You can also get this series from
> >  git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/kretprobe-stackfix-v9
>
> Oops, this is of course 'kprobes/kretprobe-stackfix-v10'. And this branch includes above (*1) series.

Hi Masami,

Was this ever merged/applied? This is a very important functionality
for BPF kretprobes, so I hope this won't slip through the cracks.
Thanks!

>
> Thank you,
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
