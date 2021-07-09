Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CDD3C26DA
	for <lists+bpf@lfdr.de>; Fri,  9 Jul 2021 17:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhGIPe2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Jul 2021 11:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232248AbhGIPe2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Jul 2021 11:34:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E700F613C1;
        Fri,  9 Jul 2021 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625844704;
        bh=EJGDTErqhFfO+4+vO3fnUq+RuTjIL8rzCpz3Xvt7RAg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nAuK98c1w4esf+28ABqRQMXZ/TSLSo9cs01eDTxLDD0GrdE4WUkH+DmwMCQUdYjlJ
         wdNRiLZJvshUGJUkF+BBUz6X9Bd9mOwMhoyy3LxVlWM7eHfVVLpCOtly+/JM8DupTL
         85Pl0hown2YU/9o/yw/N+1LWRZnglUVckqA4YW8yukfeZGkO1fWC+VLyDny/h+lHNX
         HGM9eG0HFYOyCFpSyxraIk6ozDWDBAVCLqRkU2t2KxJASRnz4Q9zE+tdKUnV68/NQD
         x0BWRQq6fHp0I8QnjnQntzO4ArOqSNuvEQ+gi2g20UhdcNLGqD0slG59NtV5nX1LY7
         lbDQ1y6yAOYvw==
Date:   Sat, 10 Jul 2021 00:31:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 05/13] x86/kprobes: Add UNWIND_HINT_FUNC on
 kretprobe_trampoline code
Message-Id: <20210710003140.8e561ad33d42f9ac78de6a15@kernel.org>
In-Reply-To: <YOK8pzp8B2V+1EaU@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162399996966.506599.810050095040575221.stgit@devnote2>
        <YOK8pzp8B2V+1EaU@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 5 Jul 2021 10:02:47 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> > Add UNWIND_HINT_FUNC on kretporbe_trampoline code so that ORC
> > information is generated on the kretprobe_trampoline correctly.
> 
> What is a 'kretporbe'?

Oops, it's a typo.

> 
> > Note that when the CONFIG_FRAME_POINTER=y, since the
> > kretprobe_trampoline skips updating frame pointer, the stack frame
> > of the kretprobe_trampoline seems non-standard. So this marks it
> > is STACK_FRAME_NON_STANDARD() and undefine UNWIND_HINT_FUNC.
> 
> What does 'marks it is' mean?

Sorry, I meant, this marks the kretprobe_trampoline as non-standard
stack frame by STACK_FRAME_NON_STANDARD().

> 
> 'undefine' UNWIND_HINT_FUNC?
> 
> Doesn't the patch do the exact opposite:
> 
>   > +#define UNWIND_HINT_FUNC \
>   > +	UNWIND_HINT(ORC_REG_SP, 8, UNWIND_HINT_TYPE_FUNC, 0)
> 
> But it does undefine it in a specific spot:

Yes, if you think this is not correct way, what about the following?

#ifdef CONFIG_FRAME_POINTER
STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
#define KRETPROBE_UNWIND_HINT_FUNC
#else
#define KRETPROBE_UNWIND_HINT_FUNC	UNWIND_HINT_FUNC
#endif


> > Anyway, with the frame pointer, FP unwinder can unwind the stack
> > frame correctly without that hint.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Tested-by: Andrii Nakryik <andrii@kernel.org>
> 
> I have to say these changelogs are very careless.

Sorry for inconvenience...

> 
> > +#else
> > +
> 
> In headers, in longer CPP blocks, please always mark the '#else' branch 
> with what it is the else branch of.

OK.

> 
> See the output of:
> 
>    kepler:~/tip> git grep '#else' arch/x86/include/asm/ | head

Thanks for the hint!

> 
> > +#ifdef CONFIG_FRAME_POINTER
> > +/*
> > + * kretprobe_trampoline skips updating frame pointer. The frame pointer
> > + * saved in trampoline_handler points to the real caller function's
> > + * frame pointer. Thus the kretprobe_trampoline doesn't seems to have a
> > + * standard stack frame with CONFIG_FRAME_POINTER=y.
> > + * Let's mark it non-standard function. Anyway, FP unwinder can correctly
> > + * unwind without the hint.
> 
> s/doesn't seems to have a standard stack frame
>  /doesn't have a standard stack frame
> 
> There's nothing 'seems' about the situation - it's a non-standard function 
> entry and stack frame situation, and the unwinder needs to know about it.

OK.

> 
> > +STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
> > +#undef UNWIND_HINT_FUNC
> > +#define UNWIND_HINT_FUNC
> > +#endif
> >  /*
> >   * When a retprobed function returns, this code saves registers and
> >   * calls trampoline_handler() runs, which calls the kretprobe's handler.
> > @@ -1031,6 +1044,7 @@ asm(
> >  	/* We don't bother saving the ss register */
> >  #ifdef CONFIG_X86_64
> >  	"	pushq %rsp\n"
> > +	UNWIND_HINT_FUNC
> >  	"	pushfq\n"
> >  	SAVE_REGS_STRING
> >  	"	movq %rsp, %rdi\n"
> > @@ -1041,6 +1055,7 @@ asm(
> >  	"	popfq\n"
> >  #else
> >  	"	pushl %esp\n"
> > +	UNWIND_HINT_FUNC
> >  	"	pushfl\n"
> >  	SAVE_REGS_STRING
> >  	"	movl %esp, %eax\n"
> 
> Why not provide an appropriate annotation method in <asm/unwind_hints.h>, 
> so that other future code can use it too instead of reinventing the wheel?

Would you mean we should define the UNWIND_HINT_FUNC as a macro
which depends on CONFIG_FRAME_POINTER, in <asm/unwind_hints.h>?

Josh, what would you think?

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
