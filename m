Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7BA3435D7
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 01:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCVAJU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Mar 2021 20:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhCVAIw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Mar 2021 20:08:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B906461879;
        Mon, 22 Mar 2021 00:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616371732;
        bh=7Qx5MsoTC6ImroO/sjbGWUAvLaBCYw51hxNZtjI6Zn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MGLcQtaJahXilneNPq4nlwnA+t+6aNfckiauwVrR3l3k0at5sNqzJc2eLQ3EFKk6N
         S1A6oNoIpO1VNb/r8EkVkZmCqv5X3dL7YPltgwQWurvf91puylGDUYXdOqgzH8mbGt
         mHzMd9FmnVe93u7PiURp2v5ww7C9u7J3efgjPSbq3L6qxRNImP23HMaqFs0dJMKCXX
         P5Ric8L8DRtXEb0QCfqXMNMzf/D3mrh9LYIaMYYV64wfesHTal2k8UYkOcQmpNAR+d
         NMwjohw3kfgExFu0sDT2ontAjgN6OmVzPj+TawsEFMwJL6O8T6tSEwovZfbG3LlgSq
         1aZLhnBumTj1g==
Date:   Mon, 22 Mar 2021 09:08:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH -tip v3 05/11] x86/kprobes: Add UNWIND_HINT_FUNC on
 kretprobe_trampoline code
Message-Id: <20210322090846.515f8c0a9b71acadfc186b7f@kernel.org>
In-Reply-To: <20210321175203.4kcptzgs6pwxh5oh@treble>
References: <161615650355.306069.17260992641363840330.stgit@devnote2>
        <161615655969.306069.4545805781593088526.stgit@devnote2>
        <20210320211616.a976fc66d0c51e13d3121e2f@kernel.org>
        <20210320220543.e1558ce3a351554c6be3ea26@kernel.org>
        <20210321175203.4kcptzgs6pwxh5oh@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 21 Mar 2021 12:52:03 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Sat, Mar 20, 2021 at 10:05:43PM +0900, Masami Hiramatsu wrote:
> > On Sat, 20 Mar 2021 21:16:16 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > On Fri, 19 Mar 2021 21:22:39 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > 
> > > > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > 
> > > > Add UNWIND_HINT_FUNC on kretporbe_trampoline code so that ORC
> > > > information is generated on the kretprobe_trampoline correctly.
> > > > 
> > > 
> > > Test bot also found a new warning for this.
> > > 
> > > > >> arch/x86/kernel/kprobes/core.o: warning: objtool: kretprobe_trampoline()+0x25: call without frame pointer save/setup
> > > 
> > > With CONFIG_FRAME_POINTER=y.
> > > 
> > > Of course this can be fixed with additional "push %bp; mov %sp, %bp" before calling
> > > trampoline_handler. But actually we know that this function has a bit special
> > > stack frame too. 
> > > 
> > > Can I recover STACK_FRAME_NON_STANDARD(kretprobe_trampoline) when CONFIG_FRAME_POINTER=y ?
> > 
> > So something like this. Does it work?
> > 
> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > index b31058a152b6..651f337dc880 100644
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -760,6 +760,10 @@ int kprobe_int3_handler(struct pt_regs *regs)
> >  }
> >  NOKPROBE_SYMBOL(kprobe_int3_handler);
> >  
> > +#ifdef CONFIG_FRAME_POINTER
> > +#undef UNWIND_HINT_FUNC
> > +#define UNWIND_HINT_FUNC
> > +#endif
> 
> This hunk isn't necessary.  The unwind hints don't actually have an
> effect with frame pointers.

Without this, objtool shows the following warning with CONFIG_FRAME_POINTER=y.

arch/x86/kernel/kprobes/core.o: warning: objtool: kretprobe_trampoline()+0x1: BUG: why am I validating an ignored function?

It seems to complain about putting UNWIND_HINT on STACK_FRAME_NON_STANDARD function.

> 
> >  /*
> >   * When a retprobed function returns, this code saves registers and
> >   * calls trampoline_handler() runs, which calls the kretprobe's handler.
> > @@ -797,7 +801,14 @@ asm(
> >  	".size kretprobe_trampoline, .-kretprobe_trampoline\n"
> >  );
> >  NOKPROBE_SYMBOL(kretprobe_trampoline);
> > -
> > +#ifdef CONFIG_FRAME_POINTER
> > +/*
> > + * kretprobe_trampoline skips updating frame pointer. The frame pointer
> > + * saved in trampoline_handler points to the real caller function's
> > + * frame pointer.
> > + */
> > +STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
> > +#endif
> >  
> >  /*
> >   * Called from kretprobe_trampoline
> 
> Ack.

Thank you!

> 
> -- 
> Josh
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
