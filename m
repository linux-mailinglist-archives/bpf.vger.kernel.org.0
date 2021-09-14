Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFC940A294
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 03:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhINBhk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 21:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhINBhj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Sep 2021 21:37:39 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADB5C061574;
        Mon, 13 Sep 2021 18:36:22 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id s16so24680142ybe.0;
        Mon, 13 Sep 2021 18:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wjXQTNKca1/7XMsCWMbLLtt+6rU6pa1rM+iwf1z4Gto=;
        b=iB/ShsGh9q5XZEOZW35HZu/GNEro5ebgviYB4QeBj6wMKghmM18XpZoKRc/Z08C3pG
         VNN+by7AHGigtIXImVyI4s9kobHQ4a2pWTSJM25l6XqOpOoVKkNBHCcZYYoFr0ysDll9
         hOOfytd27f6L1CNqdniWIAoJ73SgmL1uwSSLmpHqz09pasKFhovfN7vkzxHe43OYM5Q5
         5iBeGliTvWCErCvRs2dP1N/9bJkHQqjuTat7QDsK93l1QjkzkHXHNhnXi9dLBopoAXK/
         clunoZNdexPDsYc4/AONSUxSrgz91KGskcLd8vd7h24QVxNnG41qzo8ppIzT9F6tQ/tV
         sGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wjXQTNKca1/7XMsCWMbLLtt+6rU6pa1rM+iwf1z4Gto=;
        b=37rN4YYi3DTp3O8SjoFNSPM3W7K97oSi3F72DdoCUwQqDvhixWkmSoGYRqIiYGRMXf
         cOaOPk94dUEB44XNR/zn/q76DIm799BJL7+NBhAFisoXxym1c7Wg6BDSdfVhE/4h+9fQ
         31y3OBWVLlKQXKlHyQZalkpl70f7tJh9WsPgutq9x3Fv6A2iUYjdGXoWG/hECAUGZSjF
         AhSSdhstYqXT6oL9Oq3UPofZYbzsX7/ZwJvMGjhLFCXSlLj6Lv560/Kvq/agdSv6M/B6
         OG8h0YgElwkA/bvaYCcxeV/rPFKdvEkQBLsIMJ6BQfFJ/XH0kC0u+r+8iRuf0bx6Vf8z
         RdTg==
X-Gm-Message-State: AOAM530+zZhSSLwrI4tYVi8PqXAhf2fZcrm3+JdsJvKKpf4ftD383HlX
        Rc0NLqdCK2jMoYprTCaTHKI9eQSfk59rOtuipXA=
X-Google-Smtp-Source: ABdhPJyNP3m8wzms9F8zgvwadrxeJ9b681LUaO9wjANQpgpvQ/mVjR5OvconIgyXhYTWolvUxgcX4SzgAPlkmh1lbmM=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr19430679ybj.504.1631583381992;
 Mon, 13 Sep 2021 18:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <162756755600.301564.4957591913842010341.stgit@devnote2>
 <20210730083549.4e36df1cba88e408dc60b031@kernel.org> <CAEf4Bzb2i4Z9kUWU+L-HF3k+XQ0V3hLH1Er7U2_oCdv1BTvaBw@mail.gmail.com>
 <20210824143242.a0558b6632eef0407282364e@kernel.org> <CAEf4BzZjyt7dD4GGGyJVG0jL6iBZX1Y3CH5393JojdkCOmjCuA@mail.gmail.com>
 <20210914093852.9ed9c70cbc414c0aa3ae5304@kernel.org>
In-Reply-To: <20210914093852.9ed9c70cbc414c0aa3ae5304@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 18:36:10 -0700
Message-ID: <CAEf4BzY31icdEy-WPw5m+MFkSSQWBDXrZ3NA=sgJ3tLZ1F394A@mail.gmail.com>
Subject: Re: [PATCH -tip v10 00/16] kprobes: Fix stacktrace with kretprobes on x86
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
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
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 5:38 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Mon, 13 Sep 2021 10:14:55 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Mon, Aug 23, 2021 at 10:32 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > On Mon, 23 Aug 2021 22:12:06 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > On Thu, Jul 29, 2021 at 4:35 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > >
> > > > > On Thu, 29 Jul 2021 23:05:56 +0900
> > > > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > >
> > > > > > Hello,
> > > > > >
> > > > > > This is the 10th version of the series to fix the stacktrace with kretprobe on x86.
> > > > > >
> > > > > > The previous version is here;
> > > > > >
> > > > > >  https://lore.kernel.org/bpf/162601048053.1318837.1550594515476777588.stgit@devnote2/
> > > > > >
> > > > > > This version is rebased on top of new kprobes cleanup series(*1) and merging
> > > > > > Josh's objtool update series (*2)(*3) as [6/16] and [7/16].
> > > > > >
> > > > > > (*1) https://lore.kernel.org/bpf/162748615977.59465.13262421617578791515.stgit@devnote2/
> > > > > > (*2) https://lore.kernel.org/bpf/20210710192433.x5cgjsq2ksvaqnss@treble/
> > > > > > (*3) https://lore.kernel.org/bpf/20210710192514.ghvksi3ozhez4lvb@treble/
> > > > > >
> > > > > > Changes from v9:
> > > > > >  - Add Josh's objtool update patches with a build error fix as [6/16] and [7/16].
> > > > > >  - Add a API document for kretprobe_find_ret_addr() and check cur != NULL in [5/16].
> > > > > >
> > > > > > With this series, unwinder can unwind stack correctly from ftrace as below;
> > > > > >
> > > > > >   # cd /sys/kernel/debug/tracing
> > > > > >   # echo > trace
> > > > > >   # echo 1 > options/sym-offset
> > > > > >   # echo r vfs_read >> kprobe_events
> > > > > >   # echo r full_proxy_read >> kprobe_events
> > > > > >   # echo traceoff:1 > events/kprobes/r_vfs_read_0/trigger
> > > > > >   # echo stacktrace:1 > events/kprobes/r_full_proxy_read_0/trigger
> > > > > >   # echo 1 > events/kprobes/enable
> > > > > >   # cat /sys/kernel/debug/kprobes/list
> > > > > > ffffffff8133b740  r  full_proxy_read+0x0    [FTRACE]
> > > > > > ffffffff812560b0  r  vfs_read+0x0    [FTRACE]
> > > > > >   # echo 0 > events/kprobes/enable
> > > > > >   # cat trace
> > > > > > # tracer: nop
> > > > > > #
> > > > > > # entries-in-buffer/entries-written: 3/3   #P:8
> > > > > > #
> > > > > > #                                _-----=> irqs-off
> > > > > > #                               / _----=> need-resched
> > > > > > #                              | / _---=> hardirq/softirq
> > > > > > #                              || / _--=> preempt-depth
> > > > > > #                              ||| /     delay
> > > > > > #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> > > > > > #              | |         |   ||||      |         |
> > > > > >            <...>-134     [007] ...1    16.185877: r_full_proxy_read_0: (vfs_read+0x98/0x180 <- full_proxy_read)
> > > > > >            <...>-134     [007] ...1    16.185901: <stack trace>
> > > > > >  => kretprobe_trace_func+0x209/0x300
> > > > > >  => kretprobe_dispatcher+0x4a/0x70
> > > > > >  => __kretprobe_trampoline_handler+0xd4/0x170
> > > > > >  => trampoline_handler+0x43/0x60
> > > > > >  => kretprobe_trampoline+0x2a/0x50
> > > > > >  => vfs_read+0x98/0x180
> > > > > >  => ksys_read+0x5f/0xe0
> > > > > >  => do_syscall_64+0x37/0x90
> > > > > >  => entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > > >            <...>-134     [007] ...1    16.185902: r_vfs_read_0: (ksys_read+0x5f/0xe0 <- vfs_read)
> > > > > >
> > > > > > This shows the double return probes (vfs_read() and full_proxy_read()) on the stack
> > > > > > correctly unwinded. (vfs_read() returns to 'ksys_read+0x5f' and full_proxy_read()
> > > > > > returns to 'vfs_read+0x98')
> > > > > >
> > > > > > This also changes the kretprobe behavisor a bit, now the instraction pointer in
> > > > > > the 'pt_regs' passed to kretprobe user handler is correctly set the real return
> > > > > > address. So user handlers can get it via instruction_pointer() API, and can use
> > > > > > stack_trace_save_regs().
> > > > > >
> > > > > > You can also get this series from
> > > > > >  git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/kretprobe-stackfix-v9
> > > > >
> > > > > Oops, this is of course 'kprobes/kretprobe-stackfix-v10'. And this branch includes above (*1) series.
> > > >
> > > > Hi Masami,
> > > >
> > > > Was this ever merged/applied? This is a very important functionality
> > > > for BPF kretprobes, so I hope this won't slip through the cracks.
> > >
> > > No, not yet as far as I know.
> > > I'm waiting for any comment on this series. Since this is basically
> > > x86 ORC unwinder improvement, this series should be merged to -tip tree.
> > >
> >
> > Hey Masami,
> >
> > It's been a while since you posted v10. It seems like this series
> > doesn't apply cleanly anymore. Do you mind rebasing and resubmitting
> > it again to refresh the series and make it easier for folks to review
> > and test it?
>
> Yes, I'm planning to do that this week soon.
> Thank you for ping me :)

Sounds good, thank you.

>
> >
> > Also, do I understand correctly that [0] is a dependency of this
> > series? If yes, please rebase and resubmit that one as well. Not sure
> > on the status of Josh's patches you have dependency on as well. Can
> > you please coordinate with him and maybe incorporate them into your
> > series?
>
> Sorry I can not see [0], could you tell me another URL or title?

Make sure that you have `state=*` when you are copy/pasting that URL,
it is just a normal Patchworks URL, should be visible to anyone. But
it's just your "kprobes: treewide: Clean up kprobe code" series (v3).

> Or is that Kees's patch [1]?
>
> [1] https://lore.kernel.org/all/20210903021326.206548-1-keescook@chromium.org/T/#u
>
>
> >
> > Please also cc Paul McKenney <paulmck@kernel.org> for the future
> > revisions so he can follow along as well? Thanks!
>
> OK!
>
> >
> >
> >   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=522757&state=*
> >
> >
> >
> > > Ingo and Josh,
> > >
> > > Could you give me any comment, please?
> > >
> > > Thank you,
> > >
> > >
> > > > Thanks!
> > > >
> > > > >
> > > > > Thank you,
> > > > >
> > > > > --
> > > > > Masami Hiramatsu <mhiramat@kernel.org>
> > >
> > >
> > > --
> > > Masami Hiramatsu <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
