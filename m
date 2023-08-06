Return-Path: <bpf+bounces-7091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2753E771312
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 02:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEAF1C20976
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 00:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803147F0;
	Sun,  6 Aug 2023 00:19:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC1179
	for <bpf@vger.kernel.org>; Sun,  6 Aug 2023 00:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7C5C433C7;
	Sun,  6 Aug 2023 00:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691281193;
	bh=/ltL2o954lMqLdezAtNZm4oqXbShMW084Nq1dD4XnZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GxFZYcvstgTLQbCwCQhCl5VfXj00comsxIUhUKp4rvNYMc2hiHYoecSMpxIys5w41
	 y4gdbW/5FLT4Nw/QSGn2x1JDMNRgMUoqCuEf8c0yx/X6BKdlpGKMgzwMuSvX1IHeMT
	 66NAj5sRCNJSmhbMoolmWuA2Nr+TgaEsHRgUcqc0Wz9iIxhgndDexMqiYTdVtJf+UI
	 lsvFcD8b2nEUwk4QZ5MIt0H5C6yAauDBI/w2QVp6uEOCqTlM/DzA9RF2SQ6DvHImw+
	 tK3ZsbdFEelOKZolLZ6NPA0b5+HiPc44zmtN8Ll58mtoCSNYEXPdL8mzMJME3I5YJd
	 7Aae9Gjud2zCA==
Date: Sun, 6 Aug 2023 09:19:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 2/5] fprobe: rethook: Use fprobe_regs in fprobe exit
 handler and rethook
Message-Id: <20230806091947.793c0f8fba8c912c14c69757@kernel.org>
In-Reply-To: <169124749229.186149.1426658495303367593.stgit@devnote2>
References: <169124746774.186149.2326708176801468806.stgit@devnote2>
	<169124749229.186149.1426658495303367593.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Aug 2023 23:58:12 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Change the fprobe exit handler and rethook to use ftrace_regs data structure
> instead of pt_regs. This also introduce HAVE_FTRACE_REGS_COMPATIBLE_WITH_PT_REGS
> which means the ftrace_regs is equal to the pt_regs so that those are
> compatible. Only if it is enabled, kretprobe will use rethook since kretprobe
> requires pt_regs for backward compatibility.
> 
> This means the archs which currently implement rethook for kretprobes needs to
> set that flag and it must ensure struct ftrace_regs is same as pt_regs.
> If not, it must be either disabling kretprobe or implementing kretprobe
> trampoline separately from rethook trampoline.

Oh, btw, kernel test bot found a problem with this. Since rethook and kretprobe
does not depend on function-trace, if CONFIG_FTRACE=n but CONFIG_KPROBE=y, it
causes build errors. We can avoid it by exposing ftrace_regs and ftrace_get_regs
even if function-trace is disabled.

Thanks,

> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/Kconfig                    |    1 +
>  arch/loongarch/Kconfig          |    1 +
>  arch/s390/Kconfig               |    1 +
>  arch/x86/Kconfig                |    1 +
>  arch/x86/kernel/rethook.c       |    9 ++++++---
>  include/linux/fprobe.h          |    2 +-
>  include/linux/rethook.h         |   11 ++++++-----
>  kernel/kprobes.c                |    9 +++++++--
>  kernel/trace/Kconfig            |    7 +++++++
>  kernel/trace/bpf_trace.c        |    6 +++++-
>  kernel/trace/fprobe.c           |    6 +++---
>  kernel/trace/rethook.c          |   16 ++++++++--------
>  kernel/trace/trace_fprobe.c     |    6 +++++-
>  lib/test_fprobe.c               |    6 +++---
>  samples/fprobe/fprobe_example.c |    2 +-
>  15 files changed, 56 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index aff2746c8af2..e321bdb8b22b 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -201,6 +201,7 @@ config KRETPROBE_ON_RETHOOK
>  	def_bool y
>  	depends on HAVE_RETHOOK
>  	depends on KRETPROBES
> +	depends on HAVE_PT_REGS_COMPAT_FTRACE_REGS || !HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  	select RETHOOK
>  
>  config USER_RETURN_NOTIFIER
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index e55511af4c77..93a4336b0a94 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -102,6 +102,7 @@ config LOONGARCH
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +	select HAVE_PT_REGS_COMPAT_FTRACE_REGS
>  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>  	select HAVE_EBPF_JIT
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 5b39918b7042..299ba17d3316 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -165,6 +165,7 @@ config S390
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +	select HAVE_PT_REGS_COMPAT_FTRACE_REGS
>  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>  	select HAVE_EBPF_JIT if HAVE_MARCH_Z196_FEATURES
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7422db409770..df1b7a2791e8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -207,6 +207,7 @@ config X86
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>  	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
> +	select HAVE_PT_REGS_COMPAT_FTRACE_REGS	if X86_64
>  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
> diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
> index 8a1c0111ae79..79a52bfde562 100644
> --- a/arch/x86/kernel/rethook.c
> +++ b/arch/x86/kernel/rethook.c
> @@ -83,7 +83,8 @@ __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
>  	 * arch_rethook_fixup_return() which called from this
>  	 * rethook_trampoline_handler().
>  	 */
> -	rethook_trampoline_handler(regs, (unsigned long)frame_pointer);
> +	rethook_trampoline_handler((struct ftrace_regs *)regs,
> +				   (unsigned long)frame_pointer);
>  
>  	/*
>  	 * Copy FLAGS to 'pt_regs::ss' so that arch_rethook_trapmoline()
> @@ -104,9 +105,10 @@ NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
>  STACK_FRAME_NON_STANDARD_FP(arch_rethook_trampoline);
>  
>  /* This is called from rethook_trampoline_handler(). */
> -void arch_rethook_fixup_return(struct pt_regs *regs,
> +void arch_rethook_fixup_return(struct ftrace_regs *fregs,
>  			       unsigned long correct_ret_addr)
>  {
> +	struct pt_regs *regs = ftrace_get_regs(fregs);
>  	unsigned long *frame_pointer = (void *)(regs + 1);
>  
>  	/* Replace fake return address with real one. */
> @@ -114,8 +116,9 @@ void arch_rethook_fixup_return(struct pt_regs *regs,
>  }
>  NOKPROBE_SYMBOL(arch_rethook_fixup_return);
>  
> -void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
> +void arch_rethook_prepare(struct rethook_node *rh, struct ftrace_regs *fregs, bool mcount)
>  {
> +	struct pt_regs *regs = ftrace_get_regs(fregs);
>  	unsigned long *stack = (unsigned long *)regs->sp;
>  
>  	rh->ret_addr = stack[0];
> diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> index 36c0595f7b93..b9c0c216dedb 100644
> --- a/include/linux/fprobe.h
> +++ b/include/linux/fprobe.h
> @@ -38,7 +38,7 @@ struct fprobe {
>  			     unsigned long ret_ip, struct ftrace_regs *regs,
>  			     void *entry_data);
>  	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip,
> -			     unsigned long ret_ip, struct pt_regs *regs,
> +			     unsigned long ret_ip, struct ftrace_regs *regs,
>  			     void *entry_data);
>  };
>  
> diff --git a/include/linux/rethook.h b/include/linux/rethook.h
> index 26b6f3c81a76..138d64c8b67b 100644
> --- a/include/linux/rethook.h
> +++ b/include/linux/rethook.h
> @@ -7,6 +7,7 @@
>  
>  #include <linux/compiler.h>
>  #include <linux/freelist.h>
> +#include <linux/ftrace.h>
>  #include <linux/kallsyms.h>
>  #include <linux/llist.h>
>  #include <linux/rcupdate.h>
> @@ -14,7 +15,7 @@
>  
>  struct rethook_node;
>  
> -typedef void (*rethook_handler_t) (struct rethook_node *, void *, unsigned long, struct pt_regs *);
> +typedef void (*rethook_handler_t) (struct rethook_node *, void *, unsigned long, struct ftrace_regs *);
>  
>  /**
>   * struct rethook - The rethook management data structure.
> @@ -64,12 +65,12 @@ void rethook_free(struct rethook *rh);
>  void rethook_add_node(struct rethook *rh, struct rethook_node *node);
>  struct rethook_node *rethook_try_get(struct rethook *rh);
>  void rethook_recycle(struct rethook_node *node);
> -void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount);
> +void rethook_hook(struct rethook_node *node, struct ftrace_regs *regs, bool mcount);
>  unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame,
>  				    struct llist_node **cur);
>  
>  /* Arch dependent code must implement arch_* and trampoline code */
> -void arch_rethook_prepare(struct rethook_node *node, struct pt_regs *regs, bool mcount);
> +void arch_rethook_prepare(struct rethook_node *node, struct ftrace_regs *regs, bool mcount);
>  void arch_rethook_trampoline(void);
>  
>  /**
> @@ -84,11 +85,11 @@ static inline bool is_rethook_trampoline(unsigned long addr)
>  }
>  
>  /* If the architecture needs to fixup the return address, implement it. */
> -void arch_rethook_fixup_return(struct pt_regs *regs,
> +void arch_rethook_fixup_return(struct ftrace_regs *regs,
>  			       unsigned long correct_ret_addr);
>  
>  /* Generic trampoline handler, arch code must prepare asm stub */
> -unsigned long rethook_trampoline_handler(struct pt_regs *regs,
> +unsigned long rethook_trampoline_handler(struct ftrace_regs *regs,
>  					 unsigned long frame);
>  
>  #ifdef CONFIG_RETHOOK
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 1fc6095d502d..ccbe41c961c3 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2120,7 +2120,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  	if (rp->entry_handler && rp->entry_handler(ri, regs))
>  		rethook_recycle(rhn);
>  	else
> -		rethook_hook(rhn, regs, kprobe_ftrace(p));
> +		rethook_hook(rhn, (struct ftrace_regs *)regs, kprobe_ftrace(p));
>  
>  	return 0;
>  }
> @@ -2128,12 +2128,17 @@ NOKPROBE_SYMBOL(pre_handler_kretprobe);
>  
>  static void kretprobe_rethook_handler(struct rethook_node *rh, void *data,
>  				      unsigned long ret_addr,
> -				      struct pt_regs *regs)
> +				      struct ftrace_regs *fregs)
>  {
>  	struct kretprobe *rp = (struct kretprobe *)data;
> +	struct pt_regs *regs = ftrace_get_regs(fregs);
>  	struct kretprobe_instance *ri;
>  	struct kprobe_ctlblk *kcb;
>  
> +	/* This is bug because this depends on HAVE_PT_REGS_COMPAT_FTRACE_REGS */
> +	if (WARN_ON_ONCE(!regs))
> +		return;
> +
>  	/* The data must NOT be null. This means rethook data structure is broken. */
>  	if (WARN_ON_ONCE(!data) || !rp->handler)
>  		return;
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 976fd594b446..7d6abb5bd861 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -57,6 +57,13 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  	 This allows for use of ftrace_regs_get_argument() and
>  	 ftrace_regs_get_stack_pointer().
>  
> +config HAVE_PT_REGS_COMPAT_FTRACE_REGS
> +	bool
> +	help
> +	 If this is set, the ftrace_regs data structure is compatible
> +	 with the pt_regs. So it is possible to be converted by
> +	 ftrace_get_regs().
> +
>  config HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>  	bool
>  	help
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 51573eaa04c4..99c5f95360f9 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2668,10 +2668,14 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
>  
>  static void
>  kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
> -			       unsigned long ret_ip, struct pt_regs *regs,
> +			       unsigned long ret_ip, struct ftrace_regs *fregs,
>  			       void *data)
>  {
>  	struct bpf_kprobe_multi_link *link;
> +	struct pt_regs *regs = ftrace_get_regs(fregs);
> +
> +	if (!regs)
> +		return;
>  
>  	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
>  	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 15a2aef92733..70b9c493e52d 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -53,7 +53,7 @@ static inline void __fprobe_handler(unsigned long ip, unsigned long parent_ip,
>  		if (ret)
>  			rethook_recycle(rh);
>  		else
> -			rethook_hook(rh, ftrace_get_regs(fregs), true);
> +			rethook_hook(rh, fregs, true);
>  	}
>  }
>  
> @@ -120,7 +120,7 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
>  }
>  
>  static void fprobe_exit_handler(struct rethook_node *rh, void *data,
> -				unsigned long ret_ip, struct pt_regs *regs)
> +				unsigned long ret_ip, struct ftrace_regs *fregs)
>  {
>  	struct fprobe *fp = (struct fprobe *)data;
>  	struct fprobe_rethook_node *fpr;
> @@ -141,7 +141,7 @@ static void fprobe_exit_handler(struct rethook_node *rh, void *data,
>  		return;
>  	}
>  
> -	fp->exit_handler(fp, fpr->entry_ip, ret_ip, regs,
> +	fp->exit_handler(fp, fpr->entry_ip, ret_ip, fregs,
>  			 fp->entry_data_size ? (void *)fpr->data : NULL);
>  	ftrace_test_recursion_unlock(bit);
>  }
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index 5eb9b598f4e9..7c5cf9d5910c 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -189,7 +189,7 @@ NOKPROBE_SYMBOL(rethook_try_get);
>  /**
>   * rethook_hook() - Hook the current function return.
>   * @node: The struct rethook node to hook the function return.
> - * @regs: The struct pt_regs for the function entry.
> + * @fregs: The struct ftrace_regs for the function entry.
>   * @mcount: True if this is called from mcount(ftrace) context.
>   *
>   * Hook the current running function return. This must be called when the
> @@ -199,9 +199,9 @@ NOKPROBE_SYMBOL(rethook_try_get);
>   * from the real function entry (e.g. kprobes) @mcount must be set false.
>   * This is because the way to hook the function return depends on the context.
>   */
> -void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount)
> +void rethook_hook(struct rethook_node *node, struct ftrace_regs *fregs, bool mcount)
>  {
> -	arch_rethook_prepare(node, regs, mcount);
> +	arch_rethook_prepare(node, fregs, mcount);
>  	__llist_add(&node->llist, &current->rethooks);
>  }
>  NOKPROBE_SYMBOL(rethook_hook);
> @@ -269,7 +269,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
>  }
>  NOKPROBE_SYMBOL(rethook_find_ret_addr);
>  
> -void __weak arch_rethook_fixup_return(struct pt_regs *regs,
> +void __weak arch_rethook_fixup_return(struct ftrace_regs *fregs,
>  				      unsigned long correct_ret_addr)
>  {
>  	/*
> @@ -281,7 +281,7 @@ void __weak arch_rethook_fixup_return(struct pt_regs *regs,
>  }
>  
>  /* This function will be called from each arch-defined trampoline. */
> -unsigned long rethook_trampoline_handler(struct pt_regs *regs,
> +unsigned long rethook_trampoline_handler(struct ftrace_regs *fregs,
>  					 unsigned long frame)
>  {
>  	struct llist_node *first, *node = NULL;
> @@ -295,7 +295,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
>  		BUG_ON(1);
>  	}
>  
> -	instruction_pointer_set(regs, correct_ret_addr);
> +	ftrace_regs_set_instruction_pointer(fregs, correct_ret_addr);
>  
>  	/*
>  	 * These loops must be protected from rethook_free_rcu() because those
> @@ -315,7 +315,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
>  		handler = READ_ONCE(rhn->rethook->handler);
>  		if (handler)
>  			handler(rhn, rhn->rethook->data,
> -				correct_ret_addr, regs);
> +				correct_ret_addr, fregs);
>  
>  		if (first == node)
>  			break;
> @@ -323,7 +323,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
>  	}
>  
>  	/* Fixup registers for returning to correct address. */
> -	arch_rethook_fixup_return(regs, correct_ret_addr);
> +	arch_rethook_fixup_return(fregs, correct_ret_addr);
>  
>  	/* Unlink used shadow stack */
>  	first = current->rethooks.first;
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 4d3ae79f036e..f440c97e050f 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -341,10 +341,14 @@ static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
>  NOKPROBE_SYMBOL(fentry_dispatcher);
>  
>  static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
> -			     unsigned long ret_ip, struct pt_regs *regs,
> +			     unsigned long ret_ip, struct ftrace_regs *fregs,
>  			     void *entry_data)
>  {
>  	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
> +	struct pt_regs *regs = ftrace_get_regs(fregs);
> +
> +	if (!regs)
> +		return;
>  
>  	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
>  		fexit_trace_func(tf, entry_ip, ret_ip, regs);
> diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
> index ff607babba18..d1e80653bf0c 100644
> --- a/lib/test_fprobe.c
> +++ b/lib/test_fprobe.c
> @@ -59,9 +59,9 @@ static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
>  
>  static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
>  				    unsigned long ret_ip,
> -				    struct pt_regs *regs, void *data)
> +				    struct ftrace_regs *fregs, void *data)
>  {
> -	unsigned long ret = regs_return_value(regs);
> +	unsigned long ret = ftrace_regs_return_value(fregs);
>  
>  	KUNIT_EXPECT_FALSE(current_test, preemptible());
>  	if (ip != target_ip) {
> @@ -89,7 +89,7 @@ static notrace int nest_entry_handler(struct fprobe *fp, unsigned long ip,
>  
>  static notrace void nest_exit_handler(struct fprobe *fp, unsigned long ip,
>  				      unsigned long ret_ip,
> -				      struct pt_regs *regs, void *data)
> +				      struct ftrace_regs *fregs, void *data)
>  {
>  	KUNIT_EXPECT_FALSE(current_test, preemptible());
>  	KUNIT_EXPECT_EQ(current_test, ip, target_nest_ip);
> diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
> index 1545a1aac616..d476d1f07538 100644
> --- a/samples/fprobe/fprobe_example.c
> +++ b/samples/fprobe/fprobe_example.c
> @@ -67,7 +67,7 @@ static int sample_entry_handler(struct fprobe *fp, unsigned long ip,
>  }
>  
>  static void sample_exit_handler(struct fprobe *fp, unsigned long ip,
> -				unsigned long ret_ip, struct pt_regs *regs,
> +				unsigned long ret_ip, struct ftrace_regs *regs,
>  				void *data)
>  {
>  	unsigned long rip = ret_ip;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

