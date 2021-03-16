Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6743533CDF7
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 07:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhCPGad (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 02:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230478AbhCPGa1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 02:30:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 948EB65169;
        Tue, 16 Mar 2021 06:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615876227;
        bh=9V0KUrLMiXL6VT/H+rjc7n2huomnlDIWLOvYHtisMtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TpfY2jKZtLeiOYq1Du+xi8AJXy35Cfcxz2F1Q6RvKH/uA1WO2mt8SFIClfFrloM7T
         a90+TLD7l+lQIK24FVJ05nzEy9Z6qOU04fpWbAUg7KDtToKoLmJEDcANoyzbd7CsEc
         6kEUScSjytuShT4qq8cyPmMeU3jgAHr8/8JaUPU2CkTKHmTfHYvSFX4NFxZDKVeLtY
         +RaS9hH/FYjb4+s282y2kwNb/72SksBWIrIDY3V+7WZ26kJgQHVgTmmZ9msmJJyyEm
         nBa6+uSqF6FU0wxlGZOAfFqq3/AZEYdPX665rfPfoTE/rnShwiqNFMZO2shPxbryd6
         8BJFs84TZjt+A==
Date:   Tue, 16 Mar 2021 15:30:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip v2 00/10] kprobes: Fix stacktrace with kretprobes
Message-Id: <20210316153022.70cc181a2b3e0f73923e54da@kernel.org>
In-Reply-To: <20210316023003.xbmgce3ndkouu65e@treble>
References: <161553130371.1038734.7661319550287837734.stgit@devnote2>
        <20210316023003.xbmgce3ndkouu65e@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Mar 2021 21:30:03 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Fri, Mar 12, 2021 at 03:41:44PM +0900, Masami Hiramatsu wrote:
> > Hello,
> > 
> > Here is the 2nd version of the series to fix the stacktrace with kretprobe.
> > 
> > The 1st series is here;
> > 
> > https://lore.kernel.org/bpf/161495873696.346821.10161501768906432924.stgit@devnote2/
> > 
> > In this version I merged the ORC unwinder fix for kretprobe which discussed in the
> > previous thread. [3/10] is updated according to the Miroslav's comment. [4/10] is
> > updated for simplify the code. [5/10]-[9/10] are discussed in the previsous tread
> > and are introduced to the series.
> > 
> > Daniel, can you also test this again? I and Josh discussed a bit different
> > method and I've implemented it on this version.
> > 
> > This actually changes the kretprobe behavisor a bit, now the instraction pointer in
> > the pt_regs passed to kretprobe user handler is correctly set the real return
> > address. So user handlers can get it via instruction_pointer() API.
> 
> When I add WARN_ON(1) to a test kretprobe, it doesn't unwind properly.
> 
> show_trace_log_lvl() reads the entire stack in lockstep with calls to
> the unwinder so that it can decide which addresses get prefixed with
> '?'.  So it expects to find an actual return address on the stack.
> Instead it finds %rsp.  So it never syncs up with unwind_next_frame()
> and shows all remaining addresses as unreliable.
> 
>   Call Trace:
>    __kretprobe_trampoline_handler+0xca/0x1a0
>    trampoline_handler+0x3d/0x50
>    kretprobe_trampoline+0x25/0x50
>    ? init_test_probes.cold+0x323/0x387
>    ? init_kprobes+0x144/0x14c
>    ? init_optprobes+0x15/0x15
>    ? do_one_initcall+0x5b/0x300
>    ? lock_is_held_type+0xe8/0x140
>    ? kernel_init_freeable+0x174/0x2cd
>    ? rest_init+0x233/0x233
>    ? kernel_init+0xa/0x11d
>    ? ret_from_fork+0x22/0x30
> 
> How about pushing 'kretprobe_trampoline' instead of %rsp for the return
> address placeholder.  That fixes the above test, and removes the need
> for the weird 'state->ip == sp' check:
> 
>   Call Trace:
>    __kretprobe_trampoline_handler+0xca/0x150
>    trampoline_handler+0x3d/0x50
>    kretprobe_trampoline+0x29/0x50
>    ? init_test_probes.cold+0x323/0x387
>    elfcorehdr_read+0x10/0x10
>    init_kprobes+0x144/0x14c
>    ? init_optprobes+0x15/0x15
>    do_one_initcall+0x72/0x280
>    kernel_init_freeable+0x174/0x2cd
>    ? rest_init+0x122/0x122
>    kernel_init+0xa/0x10e
>    ret_from_fork+0x22/0x30
> 
> Though, init_test_probes.cold() (the real return address) is still
> listed as unreliable.  Maybe we need a call to kretprobe_find_ret_addr()
> in show_trace_log_lvl(), similar to the ftrace_graph_ret_addr() call
> there.

Thanks for the test!
OK, that could be acceptable. However, push %sp still needed for accessing
stack address from kretprobe handler via pt_regs. (regs->sp must point
the stack address)
Anyway, with int3, it pushes one more entry for emulating call, so I think
it is OK.
Let me update the series!

Thank you!

> 
> 
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 06f33bfebc50..70188fdd288e 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -766,19 +766,19 @@ asm(
>  	"kretprobe_trampoline:\n"
>  	/* We don't bother saving the ss register */
>  #ifdef CONFIG_X86_64
> -	"	pushq %rsp\n"
> +	/* Push fake return address to tell the unwinder it's a kretprobe */
> +	"	pushq $kretprobe_trampoline\n"
>  	UNWIND_HINT_FUNC
>  	"	pushfq\n"
>  	SAVE_REGS_STRING
>  	"	movq %rsp, %rdi\n"
>  	"	call trampoline_handler\n"
> -	/* Replace saved sp with true return address. */
> +	/* Replace the fake return address with the real one. */
>  	"	movq %rax, 19*8(%rsp)\n"
>  	RESTORE_REGS_STRING
>  	"	popfq\n"
>  #else
>  	"	pushl %esp\n"
> -	UNWIND_HINT_FUNC
>  	"	pushfl\n"
>  	SAVE_REGS_STRING
>  	"	movl %esp, %eax\n"
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 1d1b9388a1b1..1d3de84d2410 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -548,8 +548,7 @@ bool unwind_next_frame(struct unwind_state *state)
>  		 * In those cases, find the correct return address from
>  		 * task->kretprobe_instances list.
>  		 */
> -		if (state->ip == sp ||
> -		    is_kretprobe_trampoline(state->ip))
> +		if (is_kretprobe_trampoline(state->ip))
>  			state->ip = kretprobe_find_ret_addr(state->task,
>  							    &state->kr_iter);
>  
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
