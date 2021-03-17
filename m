Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A2633E29D
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 01:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhCQA2W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 20:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhCQA17 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 20:27:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4197764F51;
        Wed, 17 Mar 2021 00:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615940877;
        bh=0zM86IeZ16gQbh2WjS9qneWbXsvsXsFQFH+1uBs/HsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fioM8UYQY3gJjibcr6fntv31+P0JQUSmSn0WcM7OY0rZcFvO5WVK6HRNaFDFrSYlc
         XW7A/CktPRELD3jtBKHBPIXuE5RDvvxETeiT1gVyH+J9A1BH+y31oRM5lp7qmgtj+P
         /i6Pga7qpU5G4GtyHf4g/d1/K14XkJ35LmmGQq3Mj1D0W4tq1JNM1zPYJnNfhqXDqI
         qCgTLivkMpBfELjzAsrb7reuLGBIrmKVI4WYx3UlXgfPj1vnyJNy9y1FXrTCGbfqNt
         P6hh1JamWsR7er6oX4EFIkARRBZrPdgRG+ec8lF/7TnQslsL6wc/jOfm4VLFPiQ28j
         j7jvdJTzyXnGg==
Date:   Wed, 17 Mar 2021 09:27:51 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip v2 04/10] kprobes: stacktrace: Recover the address
 changed by kretprobe
Message-Id: <20210317092751.f29dd7dbcfb504efede83b43@kernel.org>
In-Reply-To: <161553134798.1038734.10913826398325010608.stgit@devnote2>
References: <161553130371.1038734.7661319550287837734.stgit@devnote2>
        <161553134798.1038734.10913826398325010608.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 12 Mar 2021 15:42:28 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Recover the return address on the stack which changed by the
> kretprobe. Note that this does not recover the address on the
> !current stack trace if CONFIG_ARCH_STACKWALK=n because old
> stack trace interface doesn't lock the stack in the generic
> stack_trace_save*() functions.

I found that v2 didn't work correctly with FP unwinder,
because this changes the unlink timing.

With frame pointer, the unwinder skips the first (on-going)
kretprobe_trampoline because kretprobe_trampoline doesn't
setup the frame pointer (push bp; mov sp, bp).
If there are 2 or more kretprobes on the stack, when the last
kretprobe_trampoline is running, the unwinder finds the 2nd
kretprobe_trampoline on the unwinding call stack at first.
However, while the user kretprobe handler is running, the last
real return address is still linked to the current->kretprobe_instances.

Thus, this will decode the 2nd kretprobe_trampoline with the
last real return address.

If the kretprobe_trampoline sets up the frame pointer at the entry
this can be avoided. However, that helps only x86.
Refering kretprobe_instance.fp (which should point the address of
replaced stack entry) to find correct return address seems better
solution, but this is implemented on the arch on which "call"
instruction stores the return address on the stack. E.g. arm and
some other RISCs stores the return address to the link register,
which has no "address".

So I would like to drop this arch-independent recovery routine.
Instead, it should be fixed per-arch basis.

Thank you,

> 
> So with this patch, ftrace correctly shows the stacktrace
> as below;
> 
>  # echo r vfs_read > kprobe_events
>  # echo stacktrace > events/kprobes/r_vfs_read_0/trigger
>  # echo 1 > events/kprobes/r_vfs_read_0/enable
>  # echo 1 > options/sym-offset
>  # less trace
> ...
> 
>               sh-132     [007] ...1    22.524917: <stack trace>
>  => kretprobe_dispatcher+0x7d/0xc0
>  => __kretprobe_trampoline_handler+0xdb/0x1b0
>  => trampoline_handler+0x48/0x60
>  => kretprobe_trampoline+0x2a/0x50
>  => ksys_read+0x70/0xf0
>  => __x64_sys_read+0x1a/0x20
>  => do_syscall_64+0x38/0x50
>  => entry_SYSCALL_64_after_hwframe+0x44/0xae
>  => 0
> 
> The trampoline_handler+0x48 is actual call site address,
> not modified by kretprobe.
> 
> Reported-by: Daniel Xu <dxu@dxuuu.xyz>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Add is_kretprobe_trampoline() for checking address outside of
>     kretprobe_find_ret_addr()
>   - Remove unneeded addr from kretprobe_find_ret_addr()
>   - Rename fixup_kretprobe_tramp_addr() to fixup_kretprobe_trampoline()
> ---
>  include/linux/kprobes.h |   22 ++++++++++++++
>  kernel/kprobes.c        |   73 ++++++++++++++++++++++++++++++-----------------
>  kernel/stacktrace.c     |   22 ++++++++++++++
>  3 files changed, 91 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 65dadd4238a2..674b5adad281 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -215,6 +215,14 @@ static nokprobe_inline void *kretprobe_trampoline_addr(void)
>  	return dereference_function_descriptor(kretprobe_trampoline);
>  }
>  
> +static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
> +{
> +	return (void *)addr == kretprobe_trampoline_addr();
> +}
> +
> +unsigned long kretprobe_find_ret_addr(struct task_struct *tsk,
> +				      struct llist_node **cur);
> +
>  /* If the trampoline handler called from a kprobe, use this version */
>  unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
>  					     void *frame_pointer);
> @@ -514,6 +522,20 @@ static inline bool is_kprobe_optinsn_slot(unsigned long addr)
>  }
>  #endif
>  
> +#if !defined(CONFIG_KRETPROBES)
> +static nokprobe_inline bool is_kretprobe_trampoline(unsigned long addr)
> +{
> +	return false;
> +}
> +
> +static nokprobe_inline
> +unsigned long kretprobe_find_ret_addr(struct task_struct *tsk,
> +				      struct llist_node **cur)
> +{
> +	return 0;
> +}
> +#endif
> +
>  /* Returns true if kprobes handled the fault */
>  static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
>  					      unsigned int trap)
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 75c0a58c19c2..2550521ff64d 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1858,45 +1858,51 @@ static struct notifier_block kprobe_exceptions_nb = {
>  
>  #ifdef CONFIG_KRETPROBES
>  
> -unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
> -					     void *frame_pointer)
> +/* This assumes the tsk is current or the task which is not running. */
> +unsigned long kretprobe_find_ret_addr(struct task_struct *tsk,
> +				      struct llist_node **cur)
>  {
> -	kprobe_opcode_t *correct_ret_addr = NULL;
>  	struct kretprobe_instance *ri = NULL;
> -	struct llist_node *first, *node;
> -	struct kretprobe *rp;
> +	struct llist_node *node = *cur;
> +
> +	if (!node)
> +		node = tsk->kretprobe_instances.first;
> +	else
> +		node = node->next;
>  
> -	/* Find all nodes for this frame. */
> -	first = node = current->kretprobe_instances.first;
>  	while (node) {
>  		ri = container_of(node, struct kretprobe_instance, llist);
> -
> -		BUG_ON(ri->fp != frame_pointer);
> -
>  		if (ri->ret_addr != kretprobe_trampoline_addr()) {
> -			correct_ret_addr = ri->ret_addr;
> -			/*
> -			 * This is the real return address. Any other
> -			 * instances associated with this task are for
> -			 * other calls deeper on the call stack
> -			 */
> -			goto found;
> +			*cur = node;
> +			return (unsigned long)ri->ret_addr;
>  		}
> -
>  		node = node->next;
>  	}
> -	pr_err("Oops! Kretprobe fails to find correct return address.\n");
> -	BUG_ON(1);
> +	return 0;
> +}
> +NOKPROBE_SYMBOL(kretprobe_find_ret_addr);
>  
> -found:
> -	/* Unlink all nodes for this frame. */
> -	current->kretprobe_instances.first = node->next;
> -	node->next = NULL;
> +unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
> +					     void *frame_pointer)
> +{
> +	kprobe_opcode_t *correct_ret_addr = NULL;
> +	struct kretprobe_instance *ri = NULL;
> +	struct llist_node *first, *node = NULL;
> +	struct kretprobe *rp;
> +
> +	/* Find correct address and all nodes for this frame. */
> +	correct_ret_addr = (void *)kretprobe_find_ret_addr(current, &node);
> +	if (!correct_ret_addr) {
> +		pr_err("Oops! Kretprobe fails to find correct return address.\n");
> +		BUG_ON(1);
> +	}
>  
> -	/* Run them..  */
> +	/* Run them. */
> +	first = current->kretprobe_instances.first;
>  	while (first) {
>  		ri = container_of(first, struct kretprobe_instance, llist);
> -		first = first->next;
> +
> +		BUG_ON(ri->fp != frame_pointer);
>  
>  		rp = get_kretprobe(ri);
>  		if (rp && rp->handler) {
> @@ -1907,6 +1913,21 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
>  			rp->handler(ri, regs);
>  			__this_cpu_write(current_kprobe, prev);
>  		}
> +		if (first == node)
> +			break;
> +
> +		first = first->next;
> +	}
> +
> +	/* Unlink all nodes for this frame. */
> +	first = current->kretprobe_instances.first;
> +	current->kretprobe_instances.first = node->next;
> +	node->next = NULL;
> +
> +	/* Recycle them.  */
> +	while (first) {
> +		ri = container_of(first, struct kretprobe_instance, llist);
> +		first = first->next;
>  
>  		recycle_rp_inst(ri);
>  	}
> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> index 9f8117c7cfdd..511287069473 100644
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -13,6 +13,7 @@
>  #include <linux/export.h>
>  #include <linux/kallsyms.h>
>  #include <linux/stacktrace.h>
> +#include <linux/kprobes.h>
>  
>  /**
>   * stack_trace_print - Print the entries in the stack trace
> @@ -69,6 +70,18 @@ int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
>  }
>  EXPORT_SYMBOL_GPL(stack_trace_snprint);
>  
> +static void fixup_kretprobe_trampoline(unsigned long *store, unsigned int len,
> +				       struct task_struct *tsk)
> +{
> +	struct llist_node *cur = NULL;
> +
> +	while (len--) {
> +		if (is_kretprobe_trampoline(*store))
> +			*store = kretprobe_find_ret_addr(tsk, &cur);
> +		store++;
> +	}
> +}
> +
>  #ifdef CONFIG_ARCH_STACKWALK
>  
>  struct stacktrace_cookie {
> @@ -119,6 +132,7 @@ unsigned int stack_trace_save(unsigned long *store, unsigned int size,
>  	};
>  
>  	arch_stack_walk(consume_entry, &c, current, NULL);
> +	fixup_kretprobe_trampoline(store, c.len, current);
>  	return c.len;
>  }
>  EXPORT_SYMBOL_GPL(stack_trace_save);
> @@ -147,6 +161,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
>  		return 0;
>  
>  	arch_stack_walk(consume_entry, &c, tsk, NULL);
> +	fixup_kretprobe_trampoline(store, c.len, tsk);
>  	put_task_stack(tsk);
>  	return c.len;
>  }
> @@ -171,6 +186,7 @@ unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
>  	};
>  
>  	arch_stack_walk(consume_entry, &c, current, regs);
> +	fixup_kretprobe_trampoline(store, c.len, current);
>  	return c.len;
>  }
>  
> @@ -205,6 +221,8 @@ int stack_trace_save_tsk_reliable(struct task_struct *tsk, unsigned long *store,
>  		return 0;
>  
>  	ret = arch_stack_walk_reliable(consume_entry, &c, tsk);
> +	if (!ret)
> +		fixup_kretprobe_trampoline(store, c.len, tsk);
>  	put_task_stack(tsk);
>  	return ret ? ret : c.len;
>  }
> @@ -276,6 +294,8 @@ unsigned int stack_trace_save(unsigned long *store, unsigned int size,
>  	};
>  
>  	save_stack_trace(&trace);
> +	fixup_kretprobe_trampoline(store, trace.nr_entries, current);
> +
>  	return trace.nr_entries;
>  }
>  EXPORT_SYMBOL_GPL(stack_trace_save);
> @@ -323,6 +343,8 @@ unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
>  	};
>  
>  	save_stack_trace_regs(regs, &trace);
> +	fixup_kretprobe_trampoline(store, trace.nr_entries, current);
> +
>  	return trace.nr_entries;
>  }
>  
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
