Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13ED23BB80C
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 09:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhGEHpZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 03:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhGEHpZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 03:45:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8A6C061574;
        Mon,  5 Jul 2021 00:42:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w13so10720326wmc.3;
        Mon, 05 Jul 2021 00:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jMNBXEo+xl1RdMF++ZgNqFOZjlT123x/o16EeLnZJHI=;
        b=frygXrv0W9ilfZAwGNmWpXL4byAnCuKXVVXRktcfUW6y7Ft0MGTS+HJqikiADlg0P7
         9g2ZkKyPGLCJCrU1qjEaDyScX9gz34NEZ5+HxU3kpdcL17QAd1ImMADkP6uMNWCDvepQ
         3hq34oo3ilKtqynkR8Bmg8jJGjqXXn+QUgfktDZH7rbw3VB4oix8IL7kx6pqbDbKKjQc
         uQ7wBFLsWS9XBWQkkuesA9QFb9lWGm+DekpeTRmYhXs0uj3peqg6O2z7db3c/XsJ7LvZ
         Eb8colivkQn7Zyhq13j7TTjnU35mwOMTi904tceW6k1LuxLK7VZ366VnEIXWuLAGpyHC
         4JZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jMNBXEo+xl1RdMF++ZgNqFOZjlT123x/o16EeLnZJHI=;
        b=PwxZrgrPjxUw5kYjsBaHgFaqJTQsjxRoY9CjnTLjO6xTI800lNkPKGWDhf5rTqgNkh
         EEHMq5ThwhUKMieIdTsR1UbyHajpjgt9WNRqBCi1fsJtHdPUODiQ5kR868mdi65k8xJ8
         Vu1GaLI8zJWVmIYZ8ffK2A+iqnK1Geq9K+/ED81VdaSJGjH608ndKk6NAB/LXNIYc9Rh
         ToHeHqjhC6JsNMS2vWnxEg9/GYmfWHata+DmWZgCYoqVQuF2bv8izbS1bkDytJIa5HJu
         87gNdH4EHZj5L5fWujxx5WkB4fymZ0XfpV7HaBbz1hR+XN8G60lxRVaUjLSTMxWhz36P
         wDIw==
X-Gm-Message-State: AOAM531Rbup0PuN9MChmlnII9Q8RLxrnf5l0nd5z6vIRBqt5C+ZUdmiP
        G01DoD0c7779boZJkHcSsh8=
X-Google-Smtp-Source: ABdhPJwZ0TIL8f6QP+9W/pqN7/9lhfXFjuj0xRF477Pw5Yfh5el45ZmAN2WhVy7igz8vSKnihODZYw==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr13328109wml.74.1625470967161;
        Mon, 05 Jul 2021 00:42:47 -0700 (PDT)
Received: from gmail.com (178-164-188-14.pool.digikabel.hu. [178.164.188.14])
        by smtp.gmail.com with ESMTPSA id j12sm12040602wro.82.2021.07.05.00.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:42:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 5 Jul 2021 09:42:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 04/13] kprobes: Add kretprobe_find_ret_addr() for
 searching return address
Message-ID: <YOK39GTuueIDeaJL@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162399995900.506599.7731349506430654425.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162399995900.506599.7731349506430654425.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add kretprobe_find_ret_addr() for searching correct return address
> from kretprobe instance list.

A better changelog:

   Add kretprobe_find_ret_addr() for searching the correct return address 
   from the kretprobe instances list.

But an explanation of *why* we want to add this function would be even 
better. Is it a cleanup? Is it in preparation for future changes?

Plus:

>  include/linux/kprobes.h |   22 +++++++++++
>  kernel/kprobes.c        |   91 ++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 87 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 5ce677819a25..08d3415e4418 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -207,6 +207,14 @@ static nokprobe_inline void *kretprobe_trampoline_addr(void)
>  	return dereference_kernel_function_descriptor(kretprobe_trampoline);
>  }
>  
> +static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
> +{
> +	return (void *)addr == kretprobe_trampoline_addr();
> +}
> +
> +unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
> +				      struct llist_node **cur);

These prototypes for helpers are put into a section of:

  #ifdef CONFIG_KRETPROBES

But:

> +#if !defined(CONFIG_KRETPROBES)
> +static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
> +{
> +	return false;
> +}
> +
> +static nokprobe_inline
> +unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
> +				      struct llist_node **cur)
> +{
> +	return 0;
> +}
> +#endif

Why does this use such a weird pattern? What is wrong with:

   #ifndef CONFIG_KRETPROBES

But more importantly, why isn't this in the regular '#else' block of the 
CONFIG_KRETPROBES block you added the other functions to ??

Why this intentional obfuscation combined with poor changelogs - is the 
kprobes code too easy to read, does it have too few bugs?

And this series is on v8 already, and nobody noticed this?

> +/* This assumes the tsk is current or the task which is not running. */
> +static unsigned long __kretprobe_find_ret_addr(struct task_struct *tsk,
> +					       struct llist_node **cur)


A better comment:

    /* This assumes 'tsk' is the current task, or is not running. */

We always escape variable names in English sentences. This is nothing new.

> +			*cur = node;
> +			return (unsigned long)ri->ret_addr;

Don't just randomly add forced type casts (which are dangerous, 
bug-inducing patterns of code) without examining whether it's justified.

But a compiler warning is not justification!

In this case the examination would involve:

  kepler:~/tip> git grep -w ret_addr kernel/kprobes.c 

  kernel/kprobes.c:               if (ri->ret_addr != kretprobe_trampoline_addr()) {
  kernel/kprobes.c:                       return (unsigned long)ri->ret_addr;
  kernel/kprobes.c:                       ri->ret_addr = correct_ret_addr;

  kepler:~/tip> git grep -w correct_ret_addr kernel/kprobes.c 

  kernel/kprobes.c:       kprobe_opcode_t *correct_ret_addr = NULL;
  kernel/kprobes.c:       correct_ret_addr = (void *)__kretprobe_find_ret_addr(current, &node);
  kernel/kprobes.c:       if (!correct_ret_addr) {
  kernel/kprobes.c:                       ri->ret_addr = correct_ret_addr;
  kernel/kprobes.c:       return (unsigned long)correct_ret_addr;

what we can see here is unnecessary type confusion & friction of the first 
degree:

 - 'correct_ret_addr' is 'kprobe_opcode_t *' (which is good), but the newly 
   introduced __kretprobe_find_ret_addr() function doesn't return such a 
   type - why?

 - struct_kretprobe_instance::ret_address has a 'kprobe_opcode_t *' type as 
   well - which is good.

 - kretprobe_find_ret_addr() uses 'unsigned long', but it returns the value 
   to __kretprobe_trampoline_handler(), which does *another* forced type 
   cast:

  +       correct_ret_addr = (void *)__kretprobe_find_ret_addr(current, &node);


So we have the following type conversions:

  kprobe_opcode_t * => unsigned long => unsigned long => kprobe_opcode_t *

Is there a technical reason why we cannot just use 'kprobe_opcode_t *'.

All other type casts in the kprobes code should be reviewed as well.

> -	BUG_ON(1);
> +	return 0;

And in the proper, intact type propagation model this would become
'return NULL' - which is *far* more obviously a 'not found' condition
than a random zero that might mean anything...

> +unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
> +				      struct llist_node **cur)
> +{
> +	struct kretprobe_instance *ri = NULL;
> +	unsigned long ret;
> +
> +	do {
> +		ret = __kretprobe_find_ret_addr(tsk, cur);
> +		if (!ret)
> +			return ret;
> +		ri = container_of(*cur, struct kretprobe_instance, llist);
> +	} while (ri->fp != fp);
> +
> +	return ret;

Here I see another type model problem: why is the frame pointer 'void *', 
which makes it way too easy to mix up with text pointers such as 
'kprobe_opcode_t *'?

In the x86 unwinder we use 'unsigned long *' as the frame pointer:

     unsigned long *bp

but it might also make sense to introduce a more opaque dedicated type 
within the kprobes code, such as 'frame_pointer_t'.

> +unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
> +					     void *frame_pointer)
> +{
> +	kprobe_opcode_t *correct_ret_addr = NULL;
> +	struct kretprobe_instance *ri = NULL;
> +	struct llist_node *first, *node = NULL;
> +	struct kretprobe *rp;
> +
> +	/* Find correct address and all nodes for this frame. */
> +	correct_ret_addr = (void *)__kretprobe_find_ret_addr(current, &node);
> +	if (!correct_ret_addr) {
> +		pr_err("Oops! Kretprobe fails to find correct return address.\n");

Could we please make user-facing messages less random? Right now we have:

  kepler:~/tip> git grep -E 'pr_.*\(' kernel/kprobes.c include/linux/kprobes.h include/asm-generic/kprobes.h $(find arch/ -name kprobes.c)

  arch/arm64/kernel/probes/kprobes.c:             pr_warn("Unrecoverable kprobe detected.\n");
  arch/csky/kernel/probes/kprobes.c:              pr_warn("Address not aligned.\n");
  arch/csky/kernel/probes/kprobes.c:              pr_warn("Unrecoverable kprobe detected.\n");
  arch/mips/kernel/kprobes.c:             pr_notice("Kprobes for ll and sc instructions are not"
  arch/mips/kernel/kprobes.c:             pr_notice("Kprobes for branch delayslot are not supported\n");
  arch/mips/kernel/kprobes.c:             pr_notice("Kprobes for compact branches are not supported\n");
  arch/mips/kernel/kprobes.c:     pr_notice("%s: unaligned epc - sending SIGBUS.\n", current->comm);
  arch/mips/kernel/kprobes.c:                     pr_notice("Kprobes: Error in evaluating branch\n");
  arch/riscv/kernel/probes/kprobes.c:             pr_warn("Address not aligned.\n");
  arch/riscv/kernel/probes/kprobes.c:             pr_warn("Unrecoverable kprobe detected.\n");
  arch/s390/kernel/kprobes.c:             pr_err("Invalid kprobe detected.\n");
  kernel/kprobes.c:               pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
  kernel/kprobes.c:                       pr_debug("Failed to init kprobe-ftrace (%d)\n", ret);
  kernel/kprobes.c:               pr_err("Oops! Kretprobe fails to find correct return address.\n");
  kernel/kprobes.c:       pr_err("Dumping kprobe:\n");
  kernel/kprobes.c:       pr_err("Name: %s\nOffset: %x\nAddress: %pS\n",
  kernel/kprobes.c:               pr_err("kprobes: failed to populate blacklist: %d\n", err);
  kernel/kprobes.c:               pr_err("Please take care of using kprobes.\n");
  kernel/kprobes.c:               pr_warn("Kprobes globally enabled, but failed to arm %d out of %d probes\n",
  kernel/kprobes.c:               pr_info("Kprobes globally enabled\n");
  kernel/kprobes.c:               pr_warn("Kprobes globally disabled, but failed to disarm %d out of %d probes\n",
  kernel/kprobes.c:               pr_info("Kprobes globally disabled\n");

In particular, what users may see in their syslog, when the kprobes code 
runs into trouble, is, roughly:

  kepler:~/tip> git grep -E 'pr_.*\(' kernel/kprobes.c include/linux/kprobes.h include/asm-generic/kprobes.h $(find arch/ -name kprobes.c) | cut -d\" -f2

  Unrecoverable kprobe detected.\n
  Address not aligned.\n
  Unrecoverable kprobe detected.\n
  Kprobes for ll and sc instructions are not
  Kprobes for branch delayslot are not supported\n
  Kprobes for compact branches are not supported\n
  %s: unaligned epc - sending SIGBUS.\n
  Kprobes: Error in evaluating branch\n
  Address not aligned.\n
  Unrecoverable kprobe detected.\n
  Invalid kprobe detected.\n
  Failed to arm kprobe-ftrace at %pS (%d)\n
  Failed to init kprobe-ftrace (%d)\n
  Oops! Kretprobe fails to find correct return address.\n
  Dumping kprobe:\n
  Name: %s\nOffset: %x\nAddress: %pS\n
  kprobes: failed to populate blacklist: %d\n
  Please take care of using kprobes.\n
  Kprobes globally enabled, but failed to arm %d out of %d probes\n
  Kprobes globally enabled\n
  Kprobes globally disabled, but failed to disarm %d out of %d probes\n
  Kprobes globally disabled\n

Ugh. Some of the messages don't even have 'kprobes' in them...

So my suggestion would be:

 - Introduce a subsystem syslog message prefix, via the standard pattern  of:

     #define pr_fmt(fmt) "kprobes: " fmt

 - Standardize the messages:

    - Start each message with a key noun that stresses the nature of the 
      failure.

    - *Make each message self-explanatory*, don't leave users hanging in 
      the air about what is going to happen next. Messages like:

               Address not aligned.\n

    - Check spelling. This:

                pr_err("kprobes: failed to populate blacklist: %d\n", err);
                pr_err("Please take care of using kprobes.\n");

      should be on a single line and should probably say something like:

                pr_err("kprobes: Failed to populate blacklist (error: %d), kprobes not restricted, be careful using them!.\n", err);

      and if checkpatch complains that the line is 'too long', ignore 
      checkpatch and keep the message self-contained.

 - and most importantly: provide a suggested *resolution*. 
   Passive-aggressive messages like:

      Oops! Kretprobe fails to find correct return address.\n

   are next to useless. Instead, always describe:

     - what happened,
     - what is the kernel going to do or not do,
     - is the kernel fine,
     - what can the user do about it.

   In this case, a better message would be:

      kretprobes: Return address not found, not executing handler. Kernel is probably fine, but check the system tool that did this.

Each and every message should be reviewed & fixed to meet these standards - 
or should be removed and replaced with a WARN_ON() if it's indicating an 
internal bug that cannot be caused by kprobes using tools, such as this 
one:

> +		if (WARN_ON_ONCE(ri->fp != frame_pointer))
> +			break;

I can help double checking the fixed messages, if you are unsure about any 
of them.

> +	/* Recycle them.  */
> +	while (first) {
> +		ri = container_of(first, struct kretprobe_instance, llist);
> +		first = first->next;
>  
>  		recycle_rp_inst(ri);
>  	}

It would be helpful to explain, a bit more verbose comment, what 
'recycling' is in this context. The code is not very helpful:

  NOKPROBE_SYMBOL(free_rp_inst_rcu);

  static void recycle_rp_inst(struct kretprobe_instance *ri)
  {
          struct kretprobe *rp = get_kretprobe(ri);

          if (likely(rp)) {
                  freelist_add(&ri->freelist, &rp->freelist);
          } else
                  call_rcu(&ri->rcu, free_rp_inst_rcu);
  }
  NOKPROBE_SYMBOL(recycle_rp_inst);

BTW., why are unnecessary curly braces used here?

The kprobes code urgently needs a quality boost.

Thanks,

	Ingo
