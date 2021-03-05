Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82132E4C9
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 10:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCEJ2R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 04:28:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhCEJ2M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Mar 2021 04:28:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09E6664FDF;
        Fri,  5 Mar 2021 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614936491;
        bh=PtXjMmtZqUD+84/a3yNKxDwmP+HeI1eftjVgrgaTTbs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XGHeC5WbCnj/NdH+Hyr2fx/z0PWpqzfPypJVmFaRXDNNCOvKTJ13kAhDtXokcq+69
         v+TG2O65ktvyFEpAyV3vmcXGtRdE4pclJ1qB3fwTKgug6eYgf5NBvzjM+sx7ZTEoBy
         GOg7ky0gqVK7sYueXCKmzLGBRpqcgZ5DeBWf5U1s6MW86KEMJFfhkzj09cqH61msSX
         7tX0rzDjVtcZlISM+y6rFIVRyd+kI0yNsqYIUPEXK4gJPf/gY6lifMKtlTyILMGuoV
         04vfMSNkZjyxsUN3wI6YGAkXMQHf3XzKiLREqL+Xrn9lmSnmWYdHIkMDjr+oKhfhc7
         wEh0Z68C90baA==
Date:   Fri, 5 Mar 2021 18:28:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     rostedt@goodmis.org, jpoimboe@redhat.com, kuba@kernel.org,
        ast@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH] x86: kprobes: orc: Fix ORC walks in kretprobes
Message-Id: <20210305182806.df403dec398875c2c1b2c62d@kernel.org>
In-Reply-To: <d72c62498ea0514e7b81a3eab5e8c1671137b9a0.1614902828.git.dxu@dxuuu.xyz>
References: <d72c62498ea0514e7b81a3eab5e8c1671137b9a0.1614902828.git.dxu@dxuuu.xyz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On Thu,  4 Mar 2021 16:07:52 -0800
Daniel Xu <dxu@dxuuu.xyz> wrote:

> Getting a stack trace from inside a kretprobe used to work with frame
> pointer stack walks. After the default unwinder was switched to ORC,
> stack traces broke because ORC did not know how to skip the
> `kretprobe_trampoline` "frame".
> 
> Frame based stack walks used to work with kretprobes because
> `kretprobe_trampoline` does not set up a new call frame. Thus, the frame
> pointer based unwinder could walk directly to the kretprobe'd caller.
> 
> For example, this stack is walked incorrectly with ORC + kretprobe:
> 
>     # bpftrace -e 'kretprobe:do_nanosleep { @[kstack] = count() }'
>     Attaching 1 probe...
>     ^C
> 
>     @[
>         kretprobe_trampoline+0
>     ]: 1
> 
> After this patch, the stack is walked correctly:
> 
>     # bpftrace -e 'kretprobe:do_nanosleep { @[kstack] = count() }'
>     Attaching 1 probe...
>     ^C
> 
>     @[
>         kretprobe_trampoline+0
>         __x64_sys_nanosleep+150
>         do_syscall_64+51
>         entry_SYSCALL_64_after_hwframe+68
>     ]: 12
> 
> Fixes: fc72ae40e303 ("x86/unwind: Make CONFIG_UNWINDER_ORC=y the default in kconfig for 64-bit")
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

OK, basically good, but this is messy, and doing much more than fixing issue.

> ---
>  arch/x86/kernel/unwind_orc.c | 53 +++++++++++++++++++++++++++++++++++-
>  kernel/kprobes.c             |  8 +++---
>  2 files changed, 56 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 2a1d47f47eee..1b88d75e2e9e 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/kprobes.h>
>  #include <linux/objtool.h>
>  #include <linux/module.h>
>  #include <linux/sort.h>
> +#include <asm/kprobes.h>
>  #include <asm/ptrace.h>
>  #include <asm/stacktrace.h>
>  #include <asm/unwind.h>
> @@ -77,9 +79,11 @@ static struct orc_entry *orc_module_find(unsigned long ip)
>  }
>  #endif
>  
> -#ifdef CONFIG_DYNAMIC_FTRACE
> +#if defined(CONFIG_DYNAMIC_FTRACE) || defined(CONFIG_KRETPROBES)
>  static struct orc_entry *orc_find(unsigned long ip);
> +#endif
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE
>  /*
>   * Ftrace dynamic trampolines do not have orc entries of their own.
>   * But they are copies of the ftrace entries that are static and
> @@ -117,6 +121,43 @@ static struct orc_entry *orc_ftrace_find(unsigned long ip)
>  }
>  #endif
>  
> +#ifdef CONFIG_KRETPROBES
> +static struct orc_entry *orc_kretprobe_find(void)
> +{
> +	kprobe_opcode_t *correct_ret_addr = NULL;
> +	struct kretprobe_instance *ri = NULL;
> +	struct llist_node *node;
> +
> +	node = current->kretprobe_instances.first;
> +	while (node) {
> +		ri = container_of(node, struct kretprobe_instance, llist);
> +
> +		if ((void *)ri->ret_addr != &kretprobe_trampoline) {
> +			/*
> +			 * This is the real return address. Any other
> +			 * instances associated with this task are for
> +			 * other calls deeper on the call stack
> +			 */
> +			correct_ret_addr = ri->ret_addr;
> +			break;
> +		}
> +
> +
> +		node = node->next;
> +	}
> +
> +	if (!correct_ret_addr)
> +		return NULL;
> +
> +	return orc_find((unsigned long)correct_ret_addr);
> +}
> +#else
> +static struct orc_entry *orc_kretprobe_find(void)
> +{
> +	return NULL;
> +}
> +#endif

This code is too much depending on kretprobe internal implementation.
This should should be provided by kretprobe.

>  /*
>   * If we crash with IP==0, the last successfully executed instruction
>   * was probably an indirect function call with a NULL function pointer,
> @@ -148,6 +189,16 @@ static struct orc_entry *orc_find(unsigned long ip)
>  	if (ip == 0)
>  		return &null_orc_entry;
>  
> +	/*
> +	 * Kretprobe lookup -- must occur before vmlinux addresses as
> +	 * kretprobe_trampoline is in the symbol table.
> +	 */
> +	if (ip == (unsigned long) &kretprobe_trampoline) {
> +		orc = orc_kretprobe_find();
> +		if (orc)
> +			return orc;
> +	}

Here too. at least "ip == (unsigned long) &kretprobe_trampoline" should
be hidden by an inline function...

> +
>  	/* For non-init vmlinux addresses, use the fast lookup table: */
>  	if (ip >= LOOKUP_START_IP && ip < LOOKUP_STOP_IP) {
>  		unsigned int idx, start, stop;
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 745f08fdd7a6..334c23d33451 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1895,10 +1895,6 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
>  	BUG_ON(1);
>  
>  found:
> -	/* Unlink all nodes for this frame. */
> -	current->kretprobe_instances.first = node->next;
> -	node->next = NULL;
> -
>  	/* Run them..  */
>  	while (first) {
>  		ri = container_of(first, struct kretprobe_instance, llist);
> @@ -1917,6 +1913,10 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
>  		recycle_rp_inst(ri);
>  	}
>  
> +	/* Unlink all nodes for this frame. */
> +	current->kretprobe_instances.first = node->next;
> +	node->next = NULL;

Nack, this is a bit dangerous. We should unlink the chunk of kretprobe instances and
recycle it as I did in my patch, see below;

https://lore.kernel.org/bpf/20210304221947.5a177ce2e1e94314e57c38a4@kernel.org/

I would like to fix this issue in the generic part, not for x86 only.
Let me refresh my series for fixing it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
