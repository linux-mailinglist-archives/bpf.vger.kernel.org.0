Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADC24E73CF
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 13:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbiCYM56 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 08:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbiCYM56 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 08:57:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7166C1FF;
        Fri, 25 Mar 2022 05:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E594461A32;
        Fri, 25 Mar 2022 12:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EF0C340E9;
        Fri, 25 Mar 2022 12:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648212983;
        bh=oS4tL+SV9G0Ig1+bxWpZ34PnV6L85vmFPuSS6W8o7jo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bzIQQdkaL0piFrR8Bf+xnr3/CGNgjn+gcSyBdykdtD7Y5ZLDSvC/K95dqE0LMnfRN
         kFZBbzBIoFOW/jCxDBK590GMHKe4vH4LTO3Ri86ZlOSyDwv3MMme0/uGdqAUoMU7UF
         J963/CCUcHfCcmG5cXMe9aXxbO7GRWTQA1+OI2I95j1TnxbkWlNZ1LhPi4Aim2nel9
         vAaQULyLRqsX4E4zrJQ+2IMe5PFa1KE2RALrEkqRErewDVfL30OhKDxOr3y3FelArD
         PHKzpe6LsAZY09UF6F+WtXDo1CwElVeOlq48Evu59z1UM5HTAcg9Oz9I0Fkhh70fxj
         CKDgMrSdodySA==
Date:   Fri, 25 Mar 2022 21:56:17 +0900
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
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH bpf-next 2/2] rethook: kprobes: x86: Replace kretprobe
 with rethook on x86
Message-Id: <20220325215617.d7613c501226cf0875d96115@kernel.org>
In-Reply-To: <20220325100940.GM8939@worktop.programming.kicks-ass.net>
References: <164818251899.2252200.7306353689206167903.stgit@devnote2>
        <164818254148.2252200.5054811796192907193.stgit@devnote2>
        <20220325100940.GM8939@worktop.programming.kicks-ass.net>
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

On Fri, 25 Mar 2022 11:09:40 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Mar 25, 2022 at 01:29:01PM +0900, Masami Hiramatsu wrote:
> > Replaces the kretprobe code with rethook on x86. With this patch,
> > kretprobe on x86 uses the rethook instead of kretprobe specific
> > trampoline code.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/x86/Kconfig                 |    1 
> >  arch/x86/include/asm/unwind.h    |   23 +++----
> >  arch/x86/kernel/Makefile         |    1 
> >  arch/x86/kernel/kprobes/common.h |    1 
> >  arch/x86/kernel/kprobes/core.c   |  107 ----------------------------------
> >  arch/x86/kernel/rethook.c        |  121 ++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 135 insertions(+), 119 deletions(-)
> >  create mode 100644 arch/x86/kernel/rethook.c
> 
> I'm thinking you'll find it builds much better with this on...

Oops, Thanks. I've tested it with framepointer based unwinder...

> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 2de3c8c5eba9..794fdef2501a 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -550,15 +550,15 @@ bool unwind_next_frame(struct unwind_state *state)
>  		}
>  		/*
>  		 * There is a small chance to interrupt at the entry of
> -		 * __kretprobe_trampoline() where the ORC info doesn't exist.
> -		 * That point is right after the RET to __kretprobe_trampoline()
> +		 * arch_rethook_trampoline() where the ORC info doesn't exist.
> +		 * That point is right after the RET to arch_rethook_trampoline()
>  		 * which was modified return address.
> -		 * At that point, the @addr_p of the unwind_recover_kretprobe()
> +		 * At that point, the @addr_p of the unwind_recover_rethook()
>  		 * (this has to point the address of the stack entry storing
>  		 * the modified return address) must be "SP - (a stack entry)"
>  		 * because SP is incremented by the RET.
>  		 */
> -		state->ip = unwind_recover_kretprobe(state, state->ip,
> +		state->ip = unwind_recover_rethook(state, state->ip,
>  				(unsigned long *)(state->sp - sizeof(long)));
>  		state->regs = (struct pt_regs *)sp;
>  		state->prev_regs = NULL;
> @@ -573,7 +573,7 @@ bool unwind_next_frame(struct unwind_state *state)
>  			goto err;
>  		}
>  		/* See UNWIND_HINT_TYPE_REGS case comment. */
> -		state->ip = unwind_recover_kretprobe(state, state->ip,
> +		state->ip = unwind_recover_rethook(state, state->ip,
>  				(unsigned long *)(state->sp - sizeof(long)));
>  
>  		if (state->full_regs)


-- 
Masami Hiramatsu <mhiramat@kernel.org>
