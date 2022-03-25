Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814294E73DF
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 14:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356650AbiCYNDF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 09:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359211AbiCYNC4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 09:02:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9D86EC4B;
        Fri, 25 Mar 2022 06:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD1DAB81DEA;
        Fri, 25 Mar 2022 13:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D78CC340E9;
        Fri, 25 Mar 2022 13:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648213279;
        bh=Y8XRkWJsjrQI0FowRsPE3U8uXwfLybylV/731J2THY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CEv44hAOKB5GU5dNqASdeQ0Ua4a8DeaeuH1pF1deO/Ph54vfusbVvXnBEL3yCgtMD
         Rn0uBG3cl1uCVydODRRSm+PTvWsZAA7uGny8sLEQPUP6dl6m6Cpj0Di+AuOY6EfxHk
         Mz6mWpckCtKTkIsi+jksF2aEbMYkwlPyh24lzPX99sFgx2YWt+hgqZFYn2B9xwxBT2
         KmpjjaCGax9Q598wDLPdcFsvPj72t4iKHz+9dyjz7vrGvNzAxnx/6Otrecu0zGb5Om
         HAaX4/yWsUs2sWz6uTQOGcsxIZ5WAZmkQ5HJA61Cs6EGRyHmopcvRw9y/7Caoj85eq
         prywNJyHVzQHw==
Date:   Fri, 25 Mar 2022 22:01:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/2] x86,rethook: Fix arch_rethook_trampoline()
 to generate a complete pt_regs
Message-Id: <20220325220113.a80c05905b7633b105a7abe1@kernel.org>
In-Reply-To: <20220325114012.GO8939@worktop.programming.kicks-ass.net>
References: <164818251899.2252200.7306353689206167903.stgit@devnote2>
        <20220325114012.GO8939@worktop.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Mar 2022 12:40:12 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> 
> You lost the regs->ss bit again..

Yeah, I planed to split it in another series with optprobe update
because the optprobe also skips regs->ss. Anyway...

> 
> Boot tested on tigerlake with IBT enabled -- passed the boot time
> kretprobe selftests.
> 
> ---
> 
> Subject: x86,rethook: Fix arch_rethook_trampoline() to generate a complete pt_regs
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Mar 25 10:25:56 CET 2022
> 
> Currently arch_rethook_trampoline() generates an almost complete
> pt_regs on-stack, everything except regs->ss that is, that currently
> points to the fake return address, which is not a valid segment
> descriptor.
> 
> Since interpretation of regs->[sb]p should be done in the context of
> regs->ss, and we have code actually doing that (see
> arch/x86/lib/insn-eval.c for instance), complete the job by also
> pushing ss.

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> This ensures that anybody who does do look at regs->ss doesn't
> mysteriously malfunction, avoiding much future pain.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/rethook.c |   24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> --- a/arch/x86/kernel/rethook.c
> +++ b/arch/x86/kernel/rethook.c
> @@ -25,29 +25,31 @@ asm(
>  	/* Push a fake return address to tell the unwinder it's a kretprobe. */
>  	"	pushq $arch_rethook_trampoline\n"
>  	UNWIND_HINT_FUNC
> -	/* Save the 'sp - 8', this will be fixed later. */
> +	"       pushq $" __stringify(__KERNEL_DS) "\n"
> +	/* Save the 'sp - 16', this will be fixed later. */
>  	"	pushq %rsp\n"
>  	"	pushfq\n"
>  	SAVE_REGS_STRING
>  	"	movq %rsp, %rdi\n"
>  	"	call arch_rethook_trampoline_callback\n"
>  	RESTORE_REGS_STRING
> -	/* In the callback function, 'regs->flags' is copied to 'regs->sp'. */
> -	"	addq $8, %rsp\n"
> +	/* In the callback function, 'regs->flags' is copied to 'regs->ss'. */
> +	"	addq $16, %rsp\n"
>  	"	popfq\n"
>  #else
>  	/* Push a fake return address to tell the unwinder it's a kretprobe. */
>  	"	pushl $arch_rethook_trampoline\n"
>  	UNWIND_HINT_FUNC
> -	/* Save the 'sp - 4', this will be fixed later. */
> +	"	pushl %ss\n"
> +	/* Save the 'sp - 8', this will be fixed later. */
>  	"	pushl %esp\n"
>  	"	pushfl\n"
>  	SAVE_REGS_STRING
>  	"	movl %esp, %eax\n"
>  	"	call arch_rethook_trampoline_callback\n"
>  	RESTORE_REGS_STRING
> -	/* In the callback function, 'regs->flags' is copied to 'regs->sp'. */
> -	"	addl $4, %esp\n"
> +	/* In the callback function, 'regs->flags' is copied to 'regs->ss'. */
> +	"	addl $8, %esp\n"
>  	"	popfl\n"
>  #endif
>  	ASM_RET
> @@ -69,8 +71,8 @@ __used __visible void arch_rethook_tramp
>  #endif
>  	regs->ip = (unsigned long)&arch_rethook_trampoline;
>  	regs->orig_ax = ~0UL;
> -	regs->sp += sizeof(long);
> -	frame_pointer = &regs->sp + 1;
> +	regs->sp += 2*sizeof(long);
> +	frame_pointer = (long *)(regs + 1);
>  
>  	/*
>  	 * The return address at 'frame_pointer' is recovered by the
> @@ -80,10 +82,10 @@ __used __visible void arch_rethook_tramp
>  	rethook_trampoline_handler(regs, (unsigned long)frame_pointer);
>  
>  	/*
> -	 * Copy FLAGS to 'pt_regs::sp' so that arch_rethook_trapmoline()
> +	 * Copy FLAGS to 'pt_regs::ss' so that arch_rethook_trapmoline()
>  	 * can do RET right after POPF.
>  	 */
> -	regs->sp = regs->flags;
> +	*(unsigned long *)&regs->ss = regs->flags;
>  }
>  NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
>  
> @@ -101,7 +103,7 @@ STACK_FRAME_NON_STANDARD_FP(arch_rethook
>  void arch_rethook_fixup_return(struct pt_regs *regs,
>  			       unsigned long correct_ret_addr)
>  {
> -	unsigned long *frame_pointer = &regs->sp + 1;
> +	unsigned long *frame_pointer = (void *)(regs + 1);
>  
>  	/* Replace fake return address with real one. */
>  	*frame_pointer = correct_ret_addr;


-- 
Masami Hiramatsu <mhiramat@kernel.org>
