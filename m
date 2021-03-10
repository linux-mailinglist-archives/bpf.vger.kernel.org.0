Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9940933394F
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 10:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhCJJ5o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 04:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231880AbhCJJ5k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 04:57:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEC1064FD7;
        Wed, 10 Mar 2021 09:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615370260;
        bh=+DTrRVEF3qk4U23WJWKCrDPH2PrYHPiKc92L7OXbWHY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j1wrx0PQy5ZdUWwocyCM4N/fepb5BQpOGtakmcV2fHilmo6eWGnz1yybo1KOOHMNY
         sTfG5XoaZp0Y5p6hVf/OfiWWe2qKJs2hBQyF0mzn5RnfHYMbH5hoGdQHwebdO/0Zrc
         t9AsYwQm/g/La1TkD13V7VJ84P+HFnRvKRmAh+X6+AHTmLbeKW2hinSWXow6YDlo+8
         2OxrWK4l2f0xT+/8HenlDh0Bt68eUblGe5LoCHw0VzUb+3y1W/dIkGrNPfBXGF3uwi
         GdzDBWnscE+iFUVs3ViP5/V6GiMfw4hoKVh0BI5RHpdIkEkRRxRTPX0yxQtQJ12RwM
         l/TFKCIxAXynQ==
Date:   Wed, 10 Mar 2021 18:57:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-Id: <20210310185734.332d9d52a26780ba02d09197@kernel.org>
In-Reply-To: <20210309011945.ky7v3pnbdpxhmxkh@treble>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
        <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
        <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
        <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
        <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
        <20210309011945.ky7v3pnbdpxhmxkh@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Josh,

On Mon, 8 Mar 2021 19:19:45 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Mon, Mar 08, 2021 at 11:52:10AM +0900, Masami Hiramatsu wrote:
> > So at the kretprobe handler, we have 2 issues.
> > 1) the return address (caller_func+0x15) is not on the stack.
> >    this can be solved by searching from current->kretprobe_instances.
> > 2) the stack frame size of kretprobe_trampoline is unknown
> >    Since the stackframe is fixed, the fixed number (0x98) can be used.
> > 
> > However, those solutions are only for the kretprobe handler. The stacktrace
> > from interrupt handler hit in the kretprobe_trampoline still doesn't work.
> > 
> > So, here is my idea;
> > 
> > 1) Change the trampline code to prepare stack frame at first and save
> >    registers on it, instead of "push". This will makes ORC easy to setup
> >    stackframe information for this code.
> > 2) change the return addres fixup timing. Instead of using return value
> >    of trampoline handler, before removing the real return address from
> >    current->kretprobe_instances.
> > 3) Then, if orc_find() finds the ip is in the kretprobe_trampoline, it
> >    checks the contents of the end of stackframe (at the place of regs->sp)
> >    is same as the address of it. If it is, it can find the correct address
> >    from current->kretprobe_instances. If not, there is a correct address.
> > 
> > I need to find how the ORC info is prepared for 1), maybe UNWIND_HINT macro
> > may help?
> 
> Hi Masami,
> 
> If I understand correctly, for #1 you need an unwind hint which treats
> the instruction *after* the "pushq %rsp" as the beginning of the
> function.

Thanks for the patch. In that case, should I still change the stack allocation?
Or can I continue to use a series of "push/pop" ?

> 
> I'm thinking this should work:

OK, Let me test it.

Thanks!

> 
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
> index df776cdca327..38ff1387f95d 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -767,6 +767,7 @@ asm(
>  	/* We don't bother saving the ss register */
>  #ifdef CONFIG_X86_64
>  	"	pushq %rsp\n"
> +	UNWIND_HINT_FUNC
>  	"	pushfq\n"
>  	SAVE_REGS_STRING
>  	"	movq %rsp, %rdi\n"
> @@ -790,7 +791,6 @@ asm(
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
