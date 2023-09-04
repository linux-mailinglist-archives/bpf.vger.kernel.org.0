Return-Path: <bpf+bounces-9189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E593D7918CD
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 15:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDD31C2032C
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 13:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D239EBE48;
	Mon,  4 Sep 2023 13:40:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E57471
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 13:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377CDC433C8;
	Mon,  4 Sep 2023 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693834844;
	bh=t2AyraPFiOp+fyZGg4upQyAjW/BgpRhlUvEy09oyAfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eSQZi5lMQR9LpyoitXwM8wQuAqU0LY52UChGvY/X/9tan9CUluA21cv5TCv55S6wj
	 HzO1MTfzYL4CnlUnD7hJWPFftBHbgMV9i4+DasRFvjI8yKl5XKmR/GPnMu410YlXf7
	 JMn4LwAaqfRJmJXj5XWs4QR54HXZg9+bgYH39qmjOp2g5SAgzlb9+VirbvcGo5R5xB
	 MEjk6B9uBImIjnqtJqmLLLJDbDcM0ztgNxRAINihuo/Hf9C7bpsQuiF6DEd7dHN4ZG
	 +29Qtl4Rxv3IaXl0i/DBVsZ3q7A+DhJMIrw/kn52C5MR9uwwil4DpVaNUjVJ283vsA
	 N16aiC1zB7F2Q==
Date: Mon, 4 Sep 2023 22:40:38 +0900
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
Subject: Re: [PATCH v4 4/9] fprobe: rethook: Use ftrace_regs in fprobe exit
 handler and rethook
Message-Id: <20230904224038.4420a76ea15931aa40179697@kernel.org>
In-Reply-To: <169280377434.282662.7610009313268953247.stgit@devnote2>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
	<169280377434.282662.7610009313268953247.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 24 Aug 2023 00:16:14 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Change the fprobe exit handler and rethook to use ftrace_regs data structure
> instead of pt_regs. This also introduce HAVE_PT_REGS_TO_FTRACE_REGS_CAST
> which means the ftrace_regs's memory layout is equal to the pt_regs so
> that those are able to cast. Only if it is enabled, kretprobe will use
> rethook since kretprobe requires pt_regs for backward compatibility.
> 
> This means the archs which currently implement rethook for kretprobes needs to
> set that flag and it must ensure struct ftrace_regs is same as pt_regs.
> If not, it must be either disabling kretprobe or implementing kretprobe
> trampoline separately from rethook trampoline.

I found that this is not enough becuase s390/loongarch already implemented
their rethook, and as far as I can see, the s390 ftrace_regs does not save
the required registers for rethook. Thus, for such architecture, we need
another kconfig flag and keep using the pt_regs for rethook.

In this series, I would like to focus on x86_64 and arm64, and others
will support later. What I will do is to introduce another Kconfig item
(HAVE_RETHOOK_FTRACE_REGS_HOOK) which means that the rethook is able to
hook a function with ftrace_regs on that architecture. Thus instead of
replacing pt_regs with ftrace_regs here, I will just introduce another
rethook API which uses ftrace_regs.

If HAVE_RETHOOK_FTRACE_REGS_HOOK=y, that API needs to be implemented too.
(currently, only x86_64 enables this)


      | HAVE_PT_REGS_TO_FTRACE_REGS_CAST | HAVE_RETHOOK_FTRACE_REGS_HOOK |
arm64 | no (keep kretprobe trampoline)   |  yes                          |
x86   | yes                              |  yes                          |
others| yes                              |  no (will be yes later)       |


If HAVE_RETHOOK_FTRACE_REGS_HOOK=n, fprobe requires DYNAMIC_FTRACE_WITH_REGS
and set the FTRACE_OPS_FL_SAVE_REGS flag so that it can get the pt_regs from
ftrace_regs for rethook. It also calls rethook with legacy pt_regs hook API.

Even though, rethook still provides the ftrace_regs callback interface for
fprobe, so that the rethook can be implemented on the architecture which
HAVE_PT_REGS_TO_FTRACE_REGS_CAST=n. 

Let me try to implement it.

Thank you,


> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Config rename to HAVE_PT_REGS_TO_FTRACE_REGS_CAST
>   - Use ftrace_regs_* APIs instead of ftrace_get_regs().
>  Changes in v4:
>   - Add static_assert() to ensure at least the size of pt_regs
>     and ftrace_regs are same if HAVE_PT_REGS_TO_FTRACE_REGS_CAST=y.
> ---
>  arch/Kconfig                    |    1 +
>  arch/loongarch/Kconfig          |    1 +
>  arch/s390/Kconfig               |    1 +
>  arch/x86/Kconfig                |    1 +
>  arch/x86/kernel/rethook.c       |   13 +++++++------
>  include/linux/fprobe.h          |    2 +-
>  include/linux/ftrace.h          |    6 ++++++
>  include/linux/rethook.h         |   11 ++++++-----
>  kernel/kprobes.c                |   10 ++++++++--
>  kernel/trace/Kconfig            |    7 +++++++
>  kernel/trace/bpf_trace.c        |    6 +++++-
>  kernel/trace/fprobe.c           |    6 +++---
>  kernel/trace/rethook.c          |   16 ++++++++--------
>  kernel/trace/trace_fprobe.c     |    6 +++++-
>  lib/test_fprobe.c               |    6 +++---
>  samples/fprobe/fprobe_example.c |    2 +-
>  16 files changed, 64 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index aff2746c8af2..e41a270c30bb 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -201,6 +201,7 @@ config KRETPROBE_ON_RETHOOK
>  	def_bool y
>  	depends on HAVE_RETHOOK
>  	depends on KRETPROBES
> +	depends on HAVE_PT_REGS_TO_FTRACE_REGS_CAST || !HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  	select RETHOOK
>  
>  config USER_RETURN_NOTIFIER
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index e71d5bf2cee0..33c3a4598ae0 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -103,6 +103,7 @@ config LOONGARCH
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +	select HAVE_PT_REGS_TO_FTRACE_REGS_CAST
>  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>  	select HAVE_EBPF_JIT
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 5b39918b7042..ef06c3c2b06d 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -165,6 +165,7 @@ config S390
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +	select HAVE_PT_REGS_TO_FTRACE_REGS_CAST
>  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>  	select HAVE_EBPF_JIT if HAVE_MARCH_Z196_FEATURES
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index e36261b4ea14..7c1f3194e209 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -207,6 +207,7 @@ config X86
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>  	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
> +	select HAVE_PT_REGS_TO_FTRACE_REGS_CAST	if X86_64
>  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
> diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
> index 8a1c0111ae79..d714d0276c93 100644
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
> @@ -104,22 +105,22 @@ NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
>  STACK_FRAME_NON_STANDARD_FP(arch_rethook_trampoline);
>  
>  /* This is called from rethook_trampoline_handler(). */
> -void arch_rethook_fixup_return(struct pt_regs *regs,
> +void arch_rethook_fixup_return(struct ftrace_regs *fregs,
>  			       unsigned long correct_ret_addr)
>  {
> -	unsigned long *frame_pointer = (void *)(regs + 1);
> +	unsigned long *frame_pointer = (void *)(fregs + 1);
>  
>  	/* Replace fake return address with real one. */
>  	*frame_pointer = correct_ret_addr;
>  }
>  NOKPROBE_SYMBOL(arch_rethook_fixup_return);
>  
> -void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
> +void arch_rethook_prepare(struct rethook_node *rh, struct ftrace_regs *fregs, bool mcount)
>  {
> -	unsigned long *stack = (unsigned long *)regs->sp;
> +	unsigned long *stack = (unsigned long *)ftrace_regs_get_stack_pointer(fregs);
>  
>  	rh->ret_addr = stack[0];
> -	rh->frame = regs->sp;
> +	rh->frame = (unsigned long)stack;
>  
>  	/* Replace the return addr with trampoline addr */
>  	stack[0] = (unsigned long) arch_rethook_trampoline;
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
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index fe335d861f08..c0a42d0860b8 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -151,6 +151,12 @@ struct ftrace_regs {
>  
>  #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || !CONFIG_FUNCTION_TRACER */
>  
> +#ifdef CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST
> +
> +static_assert(sizeof(struct pt_regs) == sizeof(struct ftrace_regs));
> +
> +#endif /* CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
> +
>  static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
>  {
>  	if (!fregs)
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
> index 0c6185aefaef..821dff656149 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2132,7 +2132,11 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  	if (rp->entry_handler && rp->entry_handler(ri, regs))
>  		rethook_recycle(rhn);
>  	else
> -		rethook_hook(rhn, regs, kprobe_ftrace(p));
> +		/*
> +		 * We can cast pt_regs to ftrace_regs because this depends on
> +		 * HAVE_PT_REGS_TO_FTRACE_REGS_CAST.
> +		 */
> +		rethook_hook(rhn, (struct ftrace_regs *)regs, kprobe_ftrace(p));
>  
>  	return 0;
>  }
> @@ -2140,9 +2144,11 @@ NOKPROBE_SYMBOL(pre_handler_kretprobe);
>  
>  static void kretprobe_rethook_handler(struct rethook_node *rh, void *data,
>  				      unsigned long ret_addr,
> -				      struct pt_regs *regs)
> +				      struct ftrace_regs *fregs)
>  {
>  	struct kretprobe *rp = (struct kretprobe *)data;
> +	/* Ditto, this depends on HAVE_PT_REGS_TO_FTRACE_REGS_CAST. */
> +	struct pt_regs *regs = (struct pt_regs *)fregs;
>  	struct kretprobe_instance *ri;
>  	struct kprobe_ctlblk *kcb;
>  
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 976fd594b446..d56304276318 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -57,6 +57,13 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  	 This allows for use of ftrace_regs_get_argument() and
>  	 ftrace_regs_get_stack_pointer().
>  
> +config HAVE_PT_REGS_TO_FTRACE_REGS_CAST
> +	bool
> +	help
> +	 If this is set, the memory layout of the ftrace_regs data structure
> +	 is the same as the pt_regs. So the pt_regs is possible to be casted
> +	 to ftrace_regs.
> +
>  config HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>  	bool
>  	help
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 22d00c817f1a..c4d57c7cdc7c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2675,10 +2675,14 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
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
> index 07deb52df44a..dfddc7e8424e 100644
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
> index 71bf38d698f1..c60d0d9f1a95 100644
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

