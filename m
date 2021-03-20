Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E16342CB9
	for <lists+bpf@lfdr.de>; Sat, 20 Mar 2021 13:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhCTMQY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Mar 2021 08:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhCTMQX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Mar 2021 08:16:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59F4D61967;
        Sat, 20 Mar 2021 12:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616242583;
        bh=L6kTH0jPnKRJ0H6xWkNVyPWe1UOUc18Ymagil4Ig+YU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f4h9j8C3aQFdXsU1QceNHEE7rfxMBcj3EBvTJrm7UtrFwAzmIQpJm98cKrsgrnkzU
         bf4aI+QQMsMaJvzlv2b5Inzjil1j8A8kFXijRBa0vF5gaPWKbqhVLFNpMo5lmzKKWr
         nJJ/ItwVCkSK+RlH00aDKMdcpXjdGudh/q0/TK/cG69PT/lGnVbCS1+XjQFdl1l+t9
         lJ/fC4rq65sAyneWRiu6adkgT9pyhgF+zpKXAzySDMi6ErDVAs/YvkbBz6zepKv/V0
         ssT+K5KWx+Dqlu2FKJFmTsS3m5/LAoxbKGIzncELs4YJl+H/GhR9fyx9y2FZt7RoOF
         yk18YMeYaElUw==
Date:   Sat, 20 Mar 2021 21:16:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH -tip v3 05/11] x86/kprobes: Add UNWIND_HINT_FUNC on
 kretprobe_trampoline code
Message-Id: <20210320211616.a976fc66d0c51e13d3121e2f@kernel.org>
In-Reply-To: <161615655969.306069.4545805781593088526.stgit@devnote2>
References: <161615650355.306069.17260992641363840330.stgit@devnote2>
        <161615655969.306069.4545805781593088526.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 19 Mar 2021 21:22:39 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Add UNWIND_HINT_FUNC on kretporbe_trampoline code so that ORC
> information is generated on the kretprobe_trampoline correctly.
> 

Test bot also found a new warning for this.

> >> arch/x86/kernel/kprobes/core.o: warning: objtool: kretprobe_trampoline()+0x25: call without frame pointer save/setup

With CONFIG_FRAME_POINTER=y.

Of course this can be fixed with additional "push %bp; mov %sp, %bp" before calling
trampoline_handler. But actually we know that this function has a bit special
stack frame too. 

Can I recover STACK_FRAME_NON_STANDARD(kretprobe_trampoline) when CONFIG_FRAME_POINTER=y ?

Thank you,


> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  [MH] Add patch description.
> ---
>  arch/x86/include/asm/unwind_hints.h |    5 +++++
>  arch/x86/kernel/kprobes/core.c      |    3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
> index 8e574c0afef8..8b33674288ea 100644
> --- a/arch/x86/include/asm/unwind_hints.h
> +++ b/arch/x86/include/asm/unwind_hints.h
> @@ -52,6 +52,11 @@
>  	UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=8 type=UNWIND_HINT_TYPE_FUNC
>  .endm
>  
> +#else
> +
> +#define UNWIND_HINT_FUNC \
> +	UNWIND_HINT(ORC_REG_SP, 8, UNWIND_HINT_TYPE_FUNC, 0)
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_X86_UNWIND_HINTS_H */
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 427d648fffcd..b31058a152b6 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -772,6 +772,7 @@ asm(
>  	/* We don't bother saving the ss register */
>  #ifdef CONFIG_X86_64
>  	"	pushq %rsp\n"
> +	UNWIND_HINT_FUNC
>  	"	pushfq\n"
>  	SAVE_REGS_STRING
>  	"	movq %rsp, %rdi\n"
> @@ -782,6 +783,7 @@ asm(
>  	"	popfq\n"
>  #else
>  	"	pushl %esp\n"
> +	UNWIND_HINT_FUNC
>  	"	pushfl\n"
>  	SAVE_REGS_STRING
>  	"	movl %esp, %eax\n"
> @@ -795,7 +797,6 @@ asm(
>  	".size kretprobe_trampoline, .-kretprobe_trampoline\n"
>  );
>  NOKPROBE_SYMBOL(kretprobe_trampoline);
> -STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
>  
>  
>  /*
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
