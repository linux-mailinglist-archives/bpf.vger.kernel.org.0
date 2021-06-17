Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736953ABD11
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 21:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhFQTsm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 15:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhFQTsk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 15:48:40 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ED2C061574;
        Thu, 17 Jun 2021 12:46:30 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f70so5051982qke.13;
        Thu, 17 Jun 2021 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHjhxQva9EqItRDnboJPSeBtoksB4yVp/cB0goEaX5s=;
        b=XamLhBaI1GSZ2+vrW/wyH0bL2nwlnwZAVwC3AWu7ot3as3odzo2hb7SQUDeKRjAmWH
         /UJyzlLnW1T13BGwTRNlyuJ3rFZscMsqsRXVKgTF0L0yGC2j8ux1oFuooO5MP/uKM27T
         Ox0R0jTY6guZIGAVJNqVo0MKVfvud5ukECGVrNEQVF4bqxE6bTILpBeQffgUbigHAKSY
         pF4quAMPijMQHO4PQOeL1nbVJbM45MPhz62huMfxruyoSsGwqYS9pmvl3LxzENRNGs1I
         F+ltt7K4+gR9fXEiF/DCs1mLkiuRJm0z3BTqbbocsMIzzGV9zSi8KCbabj8Hzttb+PF8
         5hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHjhxQva9EqItRDnboJPSeBtoksB4yVp/cB0goEaX5s=;
        b=NwQEjaLP4HhvqtjceeLB3KwPuoUfuIU50fKt6Rj5ZwkJU+AuEMGJoaafo37X67UIix
         I4GKhuLUkH5S+w9gvBZlN8DgniiLZcSZL7YbeYvY0u2rTasC8s04Ipp053TJ7MYWlwpy
         ieglxwInW5NNHde/2ekhE/X6tUFZ8RZLQqXnBrZRnZWHX0DDCPk8TdV78Fuy0QcK8gyF
         xfM24OQW7LvPLHRe+oHp+Ij8IbBEo9dUe9mQOW1X69OKqSPxiNojMKEXE7GlnBJ5huZq
         pNmli3DhNXaMXilBTkS+Nv3RIvukaISeZsHCVy94xeI4q9KuohqYl1XAmgZGhwtDMFll
         sOmA==
X-Gm-Message-State: AOAM532JlVLyDXYCP6cvtwdaqI4wKYdTJC+mL5o2JL8hgHS42brA5B85
        Pe3QYTtWKYqv+6UH2hY1LPhKFIJFYIkDkH8tLMA=
X-Google-Smtp-Source: ABdhPJztSCAJAPvpSrL2xIrTB+/Qq2BpIypiT4gZF4+HC3wRlJL8YTUxA/bXgqDIhV28kU2Z9wm4c+Rb4OHkfwec5OA=
X-Received: by 2002:a25:870b:: with SMTP id a11mr828411ybl.260.1623959190021;
 Thu, 17 Jun 2021 12:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
 <162209762943.436794.874947392889792501.stgit@devnote2> <20210617043909.fgu2lhnkxflmy5mk@treble>
 <20210617044032.txng4enhiduacvt6@treble> <20210617234001.54cd2ff60410ff82a39a2020@kernel.org>
 <20210618000239.f95de17418beae6d84ce783d@kernel.org> <CAEf4Bzbob_M0aS-GUY5XaqePZr_prxUag3RLHtp=HY8Uu__10g@mail.gmail.com>
 <20210617182159.ka227nkmhe4yu2de@treble> <CAEf4BzbQxxAWEvE7BfrBPCPzBjrAEVL9cg-duwbFNzEmbPPW2w@mail.gmail.com>
 <20210617192608.4nt6sdass6gw5ehl@treble>
In-Reply-To: <20210617192608.4nt6sdass6gw5ehl@treble>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Jun 2021 12:46:19 -0700
Message-ID: <CAEf4BzbGp6aGuv9CY_uAJ9JxeQy9uNDNYRCtgZSksorEcSWp6A@mail.gmail.com>
Subject: Re: [PATCH -tip v7 09/13] kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
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

On Thu, Jun 17, 2021 at 12:26 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Jun 17, 2021 at 11:31:03AM -0700, Andrii Nakryiko wrote:
> > On Thu, Jun 17, 2021 at 11:22 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Thu, Jun 17, 2021 at 10:45:41AM -0700, Andrii Nakryiko wrote:
> > > > > > > > I know I suggested this patch, but I believe it would only be useful in
> > > > > > > > combination with the use of UNWIND_HINT_REGS in SAVE_REGS_STRING.  But I
> > > > > > > > think that would be tricky to pull off correctly.  Instead, we have
> > > > > > > > UNWIND_HINT_FUNC, which is working fine.
> > > > > > > >
> > > > > > > > So I'd suggest dropping this patch, as the unwinder isn't actually
> > > > > > > > reading regs->ip after all.
> > > > > > >
> > > > > > > ... and I guess this means patches 6-8 are no longer necessary.
> > > > > >
> > > > > > OK, I also confirmed that dropping those patche does not make any change
> > > > > > on the stacktrace.
> > > > > > Let me update the series without those.
> > > > >
> > > > > Oops, Andrii, can you also test the kernel without this patch?
> > > > > (you don't need to drop patch 6-8)
> > > >
> > > > Hi Masami,
> > > >
> > > > Dropping this patch and leaving all the other in place breaks stack
> > > > traces from kretprobes for BPF. I double checked with and without this
> > > > patch. Without this patch we are back to having broken stack traces. I
> > > > see either
> > > >
> > > >   kretprobe_trampoline+0x0
> > > >
> > > > or
> > > >
> > > >   ftrace_trampoline+0xc8
> > > >   kretprobe_trampoline+0x0
>
> Do the stack traces end there?  Or do they continue normally after that?

That's the entire stack trace.

>
> --
> Josh
>
