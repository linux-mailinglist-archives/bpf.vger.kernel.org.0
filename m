Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7804A345398
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 01:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhCWAFJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 20:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhCWAEf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 20:04:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68F11619A3;
        Tue, 23 Mar 2021 00:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616457873;
        bh=OHo+vflUXrll9v/rTKEgd/KJdrtb/YspGpJNGL7VLQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NBgaXuGQo7HTAuPy5mjlDYjF33dYGEWYE+IGtP41/3SJJL1o+OlCzwquSv08024K2
         Uj568H3nV42Rm/zpaGxRWk7qrwUNzl/wFr7x6hAio2NAv3pQt2SiNGI7OVPYclBiXP
         hwCszuVvEupNYZAGMCYIIg3p940tSU0BkGXfzK/X5Tf7pFprFiDZX25GatbgHEnYzx
         U2f4OG3z/XUqWVhayFE1ahAAbagNETfbdcXdWQrK/UwKKi9quQO1KfSKMrsO1uxE7z
         MMXtMG4/yDjV4bYHW1V+OIN7TTfWUnG5NU8FPZrGk8ZlmtoLnR7yirYgQoSummOBLP
         gQfZNwEr9RcNQ==
Date:   Tue, 23 Mar 2021 09:04:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v4 08/12] arm: kprobes: Make a space for
 regs->ARM_pc at kretprobe_trampoline
Message-Id: <20210323090429.da18461654ef9907581dab95@kernel.org>
In-Reply-To: <161639527851.895304.14313883616251450754.stgit@devnote2>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
        <161639527851.895304.14313883616251450754.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 22 Mar 2021 15:41:18 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Change kretprobe_trampoline to make a space for regs->ARM_pc so that
> kretprobe_trampoline_handler can call instruction_pointer_set()
> safely.

BTW, if kretprobe_trampoline is replaced with the assembly code,
I think it should fill all the regs as much as possible, because
originally it is written by a software break.
Thus the regs->sp should point the stack address at the entry of 
kretprobe_trampoline, and also regs->lr and regs->pc will be
kretprobe_trampoline, so that user handler can access caller stack.


Thanks, 

> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm/probes/kprobes/core.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> index 1782b41df095..5f3c2b42787f 100644
> --- a/arch/arm/probes/kprobes/core.c
> +++ b/arch/arm/probes/kprobes/core.c
> @@ -397,11 +397,13 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>  void __naked __kprobes kretprobe_trampoline(void)
>  {
>  	__asm__ __volatile__ (
> +		"sub	sp, sp, #16		\n\t"
>  		"stmdb	sp!, {r0 - r11}		\n\t"
>  		"mov	r0, sp			\n\t"
>  		"bl	trampoline_handler	\n\t"
>  		"mov	lr, r0			\n\t"
>  		"ldmia	sp!, {r0 - r11}		\n\t"
> +		"add	sp, sp, #16		\n\t"
>  #ifdef CONFIG_THUMB2_KERNEL
>  		"bx	lr			\n\t"
>  #else
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
