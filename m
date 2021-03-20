Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0624342990
	for <lists+bpf@lfdr.de>; Sat, 20 Mar 2021 02:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCTBEw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 21:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhCTBEe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 21:04:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7051C6194B;
        Sat, 20 Mar 2021 01:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616202274;
        bh=7DSr2YWlRb/3DPRrevc7NPTF1eK14cvWuynOrfdjdd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NFEfmIGVCcgE9Gw7EjECIfxuY28HareUFZ6B8DSEv1ke5mK5HTlhNkrxBbiRAt/T0
         h/SMWX+pcRoL3tH+HTbuVt9gTj2uFMtbzzPdPdFcaF4p48aoTYCyVWnz3Z9szmzdOs
         P5eBUTY3Gw9zKh2DUEv7pGSprAMY+SjTwNz+XoEE1Q/H7Ib7DuYIDL6t6dn0Y1AEEZ
         zSr3AvJOaiJ/FJYeGdjWVw4cMOaivslzTnQRRxwJfsYWY8T+Ha47iFuD6eyASS9DbZ
         cqI54CaFYFEwRdcdEwXS6yIN2BSGic8uF/Xv1mX/iZG+pjh4cl42FFXU/IHH7KJAr5
         G2S2qYx6s8r9A==
Date:   Sat, 20 Mar 2021 10:04:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH -tip v3 07/11] ia64: Add instruction_pointer_set() API
Message-Id: <20210320100428.7cd2acb7d5c084ce293249d9@kernel.org>
In-Reply-To: <161615658087.306069.12036720803234007510.stgit@devnote2>
References: <161615650355.306069.17260992641363840330.stgit@devnote2>
        <161615658087.306069.12036720803234007510.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 19 Mar 2021 21:23:01 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add instruction_pointer_set() API for ia64.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/ia64/include/asm/ptrace.h |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
> index b3aa46090101..e382f1a6bff3 100644
> --- a/arch/ia64/include/asm/ptrace.h
> +++ b/arch/ia64/include/asm/ptrace.h
> @@ -45,6 +45,7 @@
>  #include <asm/current.h>
>  #include <asm/page.h>
>  
> +# define ia64_psr(regs)			((struct ia64_psr *) &(regs)->cr_ipsr)
>  /*
>   * We use the ia64_psr(regs)->ri to determine which of the three
>   * instructions in bundle (16 bytes) took the sample. Generate
> @@ -71,6 +72,12 @@ static inline long regs_return_value(struct pt_regs *regs)
>  		return -regs->r8;
>  }
>  
> +static inline void instruction_pointer_set(struct pt_regs *regs, unsigned long val)
> +{
> +	ia64_psr(regs)->ri = (val & 0xf);
> +	regs->cr_iip = (val & ~0xfULL);
> +}

Oops, this caused a build error. Thanks for the kernel test bot.

It seems that all code which accessing to the "struct ia64_psr" in asm/ptrace.h
has to be a macro, because "struct ia64_psr" is defined in the asm/processor.h
which includes asm/ptrace.h (for pt_regs?).
If the code is defined as an inline function, the "struct ia64_psr" is evaluated
at that point, and caused build error.

arch/ia64/include/asm/ptrace.h:77:16: error: dereferencing pointer to incomplete type 'struct ia64_psr'

But macro code evaluation is postponed until it is used...

Let me update it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
