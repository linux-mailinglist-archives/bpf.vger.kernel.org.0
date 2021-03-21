Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3AA34329D
	for <lists+bpf@lfdr.de>; Sun, 21 Mar 2021 13:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhCUMzM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Mar 2021 08:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhCUMyp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Mar 2021 08:54:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 440916192C;
        Sun, 21 Mar 2021 12:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616331282;
        bh=gxSLgsHjpoXlEVp0yZV3Q1ElINUeZsnQ2yc4m407QA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JNDOfNv3iRm7ZTNQzS9VSKStMvvU9YgG0X7VImdilLRbUkhraI2BYJpqJ2ewd8YSD
         RoadP0vYLncdibdS16voc3ysthzr1csAkU9s5avgayc9FXd0HpRC20KRELTTFaM7ku
         tfzq4f6h4yrlglAgo1HjZ0nJkzEJS/CkDHoiY04GdjyZ3NmuSf4yfcVgkhJ8/19Rlx
         ZQ1YIdKOo7NpIiSEuj/+28k0XaARVwPuLu9MngqhDmOrDXu2jLBOdnWtyXycsiePpA
         B2qzhk0kQhSpzzbw65/9ddrq5a/u4UhbkswGppa68XTT9ntaBR9sjPvoAjeujBJSBW
         QsMwUfNZxpdEw==
Date:   Sun, 21 Mar 2021 21:54:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH -tip v3 08/11] kprobes: Setup instruction pointer in
 __kretprobe_trampoline_handler
Message-Id: <20210321215436.2e0447bf4fc43471bcecc243@kernel.org>
In-Reply-To: <161615659174.306069.12736134222759644948.stgit@devnote2>
References: <161615650355.306069.17260992641363840330.stgit@devnote2>
        <161615659174.306069.12736134222759644948.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 19 Mar 2021 21:23:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> To simplify the stacktrace with pt_regs from kretprobe handler,
> set the correct return address to the instruction pointer in
> the pt_regs before calling kretprobe handlers.
> 

Oops, now I also find this breaks kretprobe for arm. It seems
not enough registers stores. I need to fix the arm kprobe code
too.

In arch/arm/include/uapi/asm/ptrace.h,

---
#define ARM_pc          uregs[15]
---

And in arch/arm/probes/kprobes/core.c,

---
/*
 * When a retprobed function returns, trampoline_handler() is called,
 * calling the kretprobe's handler. We construct a struct pt_regs to
 * give a view of registers r0-r11 to the user return-handler.  This is
 * not a complete pt_regs structure, but that should be plenty sufficient
 * for kretprobe handlers which should normally be interested in r0 only
 * anyway.
 */
void __naked __kprobes kretprobe_trampoline(void)
{
        __asm__ __volatile__ (
                "stmdb  sp!, {r0 - r11}         \n\t"
---

So, changing regs->ARM_pc will break a stack entry. I need to expand
it to r15.

Thanks,

> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Cast the correct_ret_addr to unsigned long.
> ---
>  kernel/kprobes.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index cf19edc038e4..4ce3e6f5d28d 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1914,6 +1914,9 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
>  		BUG_ON(1);
>  	}
>  
> +	/* Set the instruction pointer to the correct address */
> +	instruction_pointer_set(regs, (unsigned long)correct_ret_addr);
> +
>  	/* Run them. */
>  	first = current->kretprobe_instances.first;
>  	while (first) {
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
