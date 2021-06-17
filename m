Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B5C3ABAD0
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 19:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhFQRsC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhFQRsC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 13:48:02 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CE9C061574;
        Thu, 17 Jun 2021 10:45:53 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g142so4197806qke.4;
        Thu, 17 Jun 2021 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B7BTSgB3n3cFjChzgxeznoOj27ryM7XxSlGPdzcMAHY=;
        b=eE2nqBZOXQlqR5DWIPcSHK9CrZBrJ6JZTmKOtx8ptpJGaB/FQsixcvEGgfrMzzabrE
         1rKqW3N8HHOkw0ZbSry/q1v4yUp4X7nVrB+KNz63J9zX0yWRro3MgB6DRS3no2mdXmbh
         WR72hdxX9+vL+rqKOxMFjppd8JTNAs5wsC9i9y4zR9dov5a6ZtLE5oKUiouiIGmD8v0C
         jLpUEDZ/bGXvfenJf9+2iLtccBB1/7FI26fJF3UMdhbelnvJJpC4CTJ5ixtKBTR00Mwq
         yN/Oc0A5O89v/1tqnDmz4yzNel6jN3Dwk9VKOoUDLCTpzLgikmKBHQ/nvVxHvQ9M8fty
         6I6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7BTSgB3n3cFjChzgxeznoOj27ryM7XxSlGPdzcMAHY=;
        b=TURzGSmrMWQGp3y8ZmWGpu1urqeCvJrzPO7sI/5MYNAZnEeRCsXACHOaBBeE9sRy/q
         5IfSmowha4rTUi4YLhR3/i3ryOTWqnJcR49D3qMN19E2oWc4R015cXBKnaM8aLuVjIC2
         uyvCZ6xME3bYXA5S5qidrImTeVK11dQuiH5zRJRtR9chsQRKLLdtPJLFQsoMCZjhjIpP
         66rZxLneJL8B0rYIaagBHoFgWZrN8RpR02AFD+PQnO5QwduATItYO8clgqOT6WQ51TCK
         zN1X+r3O2ABh06XOB6VjkrIe+n9xySfRVwHyIBBvCdQ8hiMEPcOOcOf7DZXW6tTMuzQC
         /Jmw==
X-Gm-Message-State: AOAM5323s4uAD9o4weT54FQcSBDvC1JkbWdTqwqjLVlEmwjYc2AUfHKR
        xBUSRHxPe701bMSnS9lcnOONMauGwHIrgKXjzbGvwPwHT2QQ/w==
X-Google-Smtp-Source: ABdhPJyTokwFn5xvIu9181W1fbdZwMgdI5fh/nmwyY5BuPu6gxfZL0RrzBxCLwvFIs1o3aZYtfLdNWxwaH13qTqP+lg=
X-Received: by 2002:a25:870b:: with SMTP id a11mr106565ybl.260.1623951952293;
 Thu, 17 Jun 2021 10:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
 <162209762943.436794.874947392889792501.stgit@devnote2> <20210617043909.fgu2lhnkxflmy5mk@treble>
 <20210617044032.txng4enhiduacvt6@treble> <20210617234001.54cd2ff60410ff82a39a2020@kernel.org>
 <20210618000239.f95de17418beae6d84ce783d@kernel.org>
In-Reply-To: <20210618000239.f95de17418beae6d84ce783d@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Jun 2021 10:45:41 -0700
Message-ID: <CAEf4Bzbob_M0aS-GUY5XaqePZr_prxUag3RLHtp=HY8Uu__10g@mail.gmail.com>
Subject: Re: [PATCH -tip v7 09/13] kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 17, 2021 at 8:02 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Thu, 17 Jun 2021 23:40:01 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > On Wed, 16 Jun 2021 23:40:32 -0500
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > > On Wed, Jun 16, 2021 at 11:39:11PM -0500, Josh Poimboeuf wrote:
> > > > On Thu, May 27, 2021 at 03:40:29PM +0900, Masami Hiramatsu wrote:
> > > > > To simplify the stacktrace with pt_regs from kretprobe handler,
> > > > > set the correct return address to the instruction pointer in
> > > > > the pt_regs before calling kretprobe handlers.
> > > > >
> > > > > Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > Tested-by: Andrii Nakryik <andrii@kernel.org>
> > > > > ---
> > > > >  Changes in v3:
> > > > >   - Cast the correct_ret_addr to unsigned long.
> > > > > ---
> > > > >  kernel/kprobes.c |    3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > > > index 54e5b89aad67..1598aca375c9 100644
> > > > > --- a/kernel/kprobes.c
> > > > > +++ b/kernel/kprobes.c
> > > > > @@ -1914,6 +1914,9 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
> > > > >                 BUG_ON(1);
> > > > >         }
> > > > >
> > > > > +       /* Set the instruction pointer to the correct address */
> > > > > +       instruction_pointer_set(regs, (unsigned long)correct_ret_addr);
> > > > > +
> > > > >         /* Run them. */
> > > > >         first = current->kretprobe_instances.first;
> > > > >         while (first) {
> > > > >
> > > >
> > > > Hi Masami,
> > > >
> > > > I know I suggested this patch, but I believe it would only be useful in
> > > > combination with the use of UNWIND_HINT_REGS in SAVE_REGS_STRING.  But I
> > > > think that would be tricky to pull off correctly.  Instead, we have
> > > > UNWIND_HINT_FUNC, which is working fine.
> > > >
> > > > So I'd suggest dropping this patch, as the unwinder isn't actually
> > > > reading regs->ip after all.
> > >
> > > ... and I guess this means patches 6-8 are no longer necessary.
> >
> > OK, I also confirmed that dropping those patche does not make any change
> > on the stacktrace.
> > Let me update the series without those.
>
> Oops, Andrii, can you also test the kernel without this patch?
> (you don't need to drop patch 6-8)

Hi Masami,

Dropping this patch and leaving all the other in place breaks stack
traces from kretprobes for BPF. I double checked with and without this
patch. Without this patch we are back to having broken stack traces. I
see either

  kretprobe_trampoline+0x0

or

  ftrace_trampoline+0xc8
  kretprobe_trampoline+0x0

Is there any problem if you leave this patch as is?

> This changes the kretprobe to pass the return address via regs->ip to handler.
> Dynamic-event doesn't use it, but I'm not sure bcc is using it or not.
>
> Thank you,
>
> >
> > Thank you,
> >
> > >
> > > --
> > > Josh
> > >
> >
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
