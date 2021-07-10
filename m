Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FB43C2CA8
	for <lists+bpf@lfdr.de>; Sat, 10 Jul 2021 03:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGJBny (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Jul 2021 21:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhGJBnx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Jul 2021 21:43:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A544661369;
        Sat, 10 Jul 2021 01:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625881269;
        bh=+B762d+bq/P3YApL0HbKAGd5FC2iONbt41tss4/+kfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KG6Vl4zFwfbbLHLcv3xNyv4CShhXLOO7so/wCHH00D8DMcYkEfz0l6nr+gc5K/rbB
         IIZ3PVZ4oS1pINjm8s+1l4XO6U0H+8tHNCFqQYY8hJF6I586MK06gj8We90aOlgvfv
         cQz+Y5wStzh2h5/z09Ctx60/c6Tig9yeGEWgzKFzh0u6y9m2wyW1i+guN71WcaoL2f
         T9C4CdO8kQp/mvIGzalEj96Ss/m82rgdX/wAWh/vRUtikASYmsAUcKmn6R4mpwTibO
         XT0dJuyuT/8yTk33dSnhhbevsjx++a6V6eDJKy5EQl/tgsfBhss8lYC7+JU8HgSaZb
         yKmD/DJL0AsIQ==
Date:   Sat, 10 Jul 2021 10:41:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH -tip v8 05/13] x86/kprobes: Add UNWIND_HINT_FUNC on
 kretprobe_trampoline code
Message-Id: <20210710104104.3a270168811ac38420093276@kernel.org>
In-Reply-To: <20210710003140.8e561ad33d42f9ac78de6a15@kernel.org>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162399996966.506599.810050095040575221.stgit@devnote2>
        <YOK8pzp8B2V+1EaU@gmail.com>
        <20210710003140.8e561ad33d42f9ac78de6a15@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ingo and Josh,

On Sat, 10 Jul 2021 00:31:40 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > +STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
> > > +#undef UNWIND_HINT_FUNC
> > > +#define UNWIND_HINT_FUNC
> > > +#endif
> > >  /*
> > >   * When a retprobed function returns, this code saves registers and
> > >   * calls trampoline_handler() runs, which calls the kretprobe's handler.
> > > @@ -1031,6 +1044,7 @@ asm(
> > >  	/* We don't bother saving the ss register */
> > >  #ifdef CONFIG_X86_64
> > >  	"	pushq %rsp\n"
> > > +	UNWIND_HINT_FUNC
> > >  	"	pushfq\n"
> > >  	SAVE_REGS_STRING
> > >  	"	movq %rsp, %rdi\n"
> > > @@ -1041,6 +1055,7 @@ asm(
> > >  	"	popfq\n"
> > >  #else
> > >  	"	pushl %esp\n"
> > > +	UNWIND_HINT_FUNC
> > >  	"	pushfl\n"
> > >  	SAVE_REGS_STRING
> > >  	"	movl %esp, %eax\n"
> > 
> > Why not provide an appropriate annotation method in <asm/unwind_hints.h>, 
> > so that other future code can use it too instead of reinventing the wheel?

I think I got what you meant. Let me summarize the issue.

In case of CONFIG_FRAME_POINTER=n, it is OK just adding UNWIND_HINT_FUNC.

In case of CONFIG_FRAME_POINTER=y, without STACK_FRAME_NON_STANDARD(),
the objtool complains that a CALL instruction without the frame pointer.
---
  arch/x86/kernel/kprobes/core.o: warning: objtool: __kretprobe_trampoline()+0x25: call without frame pointer save/setup
---

If we just add STACK_FRAME_NON_STANDARD() with UNWIND_HINT_FUNC macro,
the objtool complains that non-standard function has unwind hint.
---
arch/x86/kernel/kprobes/core.o: warning: objtool: __kretprobe_trampoline()+0x1: BUG: why am I validating an ignored function?
---

Thus, add STACK_FRAME_NON_STANDARD() and undefine UNWIND_HINT_FUNC macro,
the objtool doesn't complain.

This means that the STACK_FRAME_NON_STANDARD() and UNWIND_HINT_FUNC macro
are mutually exclusive. However, those macros are used different way.
The STACK_FRAME_NON_STANDARD() will have the target symbol and the
UNWIND_HINT_FUNC needs to be embedded in the target code.
Thus we can not combine them in general.

If we can have something like UNWIND_HINT_FUNC_NO_FP, it may solve this
issue without ugly #ifdef and #undef.

Is that correct?

Maybe I can add UNWIND_HINT_TYPE_FUNC_NO_FP for UNWIND_HINT and make objtool
ignore the call without frame pointer. This makes an exception that the
kretprobe_trampoline will be noted in '.discard.unwind_hints' section
instead of '.discard.func_stack_frame_non_standard' section. 

Or another idea is to introduce ANNOTATE_NO_FP_FUNCTION_CALL with a new
'.discard.no_fp_function_calls' section.

What do you think these ideas?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
