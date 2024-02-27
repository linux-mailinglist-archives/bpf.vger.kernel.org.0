Return-Path: <bpf+bounces-22816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F7386A263
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 23:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AF52B2345F
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C4155314;
	Tue, 27 Feb 2024 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0ebS8+1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC871534F4;
	Tue, 27 Feb 2024 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072595; cv=none; b=jLiXpOyn3ouJkE6lceSYngpj+jPeszA+olbITMInOD+PktrL86q3q7u5OcvOcta9zGJfX4S0GVHTYwlfuBuwBdBurz+iYh9jl3E/WgRo+1IXhKhL+UU7oUdW+xm5OIi/rRUctGkzg7x5rV6L+3/2YbJ9gmXolHuZQaf8ipgH8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072595; c=relaxed/simple;
	bh=cYa790LN4uFzyEpG0nfySABkexUU7XOejAF1CJ/Tp6o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=plT4jKFmGbWRFgijzhzZNZxZ4vc+IFzD/Of99ZiBGALLSPtt+751kguFxhVnCZxIsXHBCb/KI15Tr9I6TZHe80YhnxamjBXDZF4xCbrypR44YSeR5OLVITRfWwl071g2eI2Z4K/9Pr8gdfDo5kdh4XbcP0AF1ySTr+0lrAI7U9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0ebS8+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98460C433C7;
	Tue, 27 Feb 2024 22:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709072595;
	bh=cYa790LN4uFzyEpG0nfySABkexUU7XOejAF1CJ/Tp6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h0ebS8+1puIeFwLlIdFakookoyJZqZF0Iv6Cz9fYFYMN8LYI9xDhTMzQRcJOVN0Ay
	 Uj6fN/55gXN6w/WEmf7ORWpHuOz3sOnFfc4ixq24bKLhkL9oda7mak8xvKQ1CnilR1
	 UAOanRoLw/INx8GCeLD2+PmXk43mY2wIEPgd+C+1kltp+KjsKMDg0EtVvIwHo8qnvn
	 7bXgM8pwQ9+En6Pxm/BEM/N6t78M3h9HxIZmzENJt4FN6LRiI/tMhBQ/sFRtmhSHnZ
	 nZ4KRZwzrTPgiDAJPEDxrm0RPxljlFzX1jXbczXYXXIInOqaq55SKuPOQl10Vuo32C
	 L5IW6gJ3LKVPg==
Date: Wed, 28 Feb 2024 07:23:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v8 31/35] fprobe: Rewrite fprobe on function-graph
 tracer
Message-Id: <20240228072309.3cdac0a00c789e541ecee613@kernel.org>
In-Reply-To: <ZdyKaRiI-PnG80Q0@krava>
References: <170887410337.564249.6360118840946697039.stgit@devnote2>
	<170887444346.564249.9630774181398892961.stgit@devnote2>
	<ZdyKaRiI-PnG80Q0@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 13:56:09 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Feb 26, 2024 at 12:20:43AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Rewrite fprobe implementation on function-graph tracer.
> > Major API changes are:
> >  -  'nr_maxactive' field is deprecated.
> >  -  This depends on CONFIG_DYNAMIC_FTRACE_WITH_ARGS or
> >     !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS, and
> >     CONFIG_HAVE_FUNCTION_GRAPH_FREGS. So currently works only
> >     on x86_64.
> >  -  Currently the entry size is limited in 15 * sizeof(long).
> >  -  If there is too many fprobe exit handler set on the same
> >     function, it will fail to probe.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v8:
> >   - Use trace_func_graph_ret/ent_t for fgraph_ops.
> >   - Update CONFIG_FPROBE dependencies.
> >   - Add ftrace_regs_get_return_address() for each arch.
> >  Changes in v3:
> >   - Update for new reserve_data/retrieve_data API.
> >   - Fix internal push/pop on fgraph data logic so that it can
> >     correctly save/restore the returning fprobes.
> >  Changes in v2:
> >   - Add more lockdep_assert_held(fprobe_mutex)
> >   - Use READ_ONCE() and WRITE_ONCE() for fprobe_hlist_node::fp.
> >   - Add NOKPROBE_SYMBOL() for the functions which is called from
> >     entry/exit callback.
> > ---
> >  arch/arm64/include/asm/ftrace.h     |    6 
> >  arch/loongarch/include/asm/ftrace.h |    6 
> >  arch/powerpc/include/asm/ftrace.h   |    6 
> >  arch/s390/include/asm/ftrace.h      |    6 
> >  arch/x86/include/asm/ftrace.h       |    6 
> >  include/linux/fprobe.h              |   54 ++-
> >  include/linux/ftrace.h              |    7 
> >  kernel/trace/Kconfig                |    8 
> >  kernel/trace/fprobe.c               |  638 +++++++++++++++++++++++++----------
> >  lib/test_fprobe.c                   |   45 --
> >  10 files changed, 536 insertions(+), 246 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index 95a8f349f871..800c75f46a13 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -143,6 +143,12 @@ ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
> >  	return fregs->fp;
> >  }
> >  
> > +static __always_inline unsigned long
> > +ftrace_regs_get_return_address(const struct ftrace_regs *fregs)
> > +{
> > +	return fregs->lr;
> > +}
> > +
> >  static __always_inline struct pt_regs *
> >  ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> >  {
> > diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
> > index 14a1576bf948..b8432b7cc9d4 100644
> > --- a/arch/loongarch/include/asm/ftrace.h
> > +++ b/arch/loongarch/include/asm/ftrace.h
> > @@ -81,6 +81,12 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs, unsigned long ip)
> >  #define ftrace_regs_get_frame_pointer(fregs) \
> >  	((fregs)->regs.regs[22])
> >  
> > +static __always_inline unsigned long
> > +ftrace_regs_get_return_address(struct ftrace_regs *fregs)
> > +{
> > +	return *(unsigned long *)(fregs->regs.regs[1]);
> > +}
> > +
> >  #define ftrace_graph_func ftrace_graph_func
> >  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> >  		       struct ftrace_ops *op, struct ftrace_regs *fregs);
> > diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
> > index 773e9011cff1..7ac1bc3e7196 100644
> > --- a/arch/powerpc/include/asm/ftrace.h
> > +++ b/arch/powerpc/include/asm/ftrace.h
> > @@ -85,6 +85,12 @@ ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
> >  #define ftrace_regs_query_register_offset(name) \
> >  	regs_query_register_offset(name)
> >  
> > +static __always_inline unsigned long
> > +ftrace_regs_get_return_address(struct ftrace_regs *fregs)
> > +{
> > +	return fregs->regs.link;
> > +}
> > +
> >  struct ftrace_ops;
> >  
> >  #define ftrace_graph_func ftrace_graph_func
> > diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
> > index e910924eee59..d434a0497683 100644
> > --- a/arch/s390/include/asm/ftrace.h
> > +++ b/arch/s390/include/asm/ftrace.h
> > @@ -89,6 +89,12 @@ ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
> >  	return sp[0];	/* return backchain */
> >  }
> >  
> > +static __always_inline unsigned long
> > +ftrace_regs_get_return_address(const struct ftrace_regs *fregs)
> > +{
> > +	return fregs->regs.gprs[14];
> > +}
> > +
> >  #define arch_ftrace_fill_perf_regs(fregs, _regs)	 do {		\
> >  		(_regs)->psw.addr = (fregs)->regs.psw.addr;		\
> >  		(_regs)->gprs[15] = (fregs)->regs.gprs[15];		\
> > diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> > index 7625887fc49b..979d3458a328 100644
> > --- a/arch/x86/include/asm/ftrace.h
> > +++ b/arch/x86/include/asm/ftrace.h
> > @@ -82,6 +82,12 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
> >  #define ftrace_regs_get_frame_pointer(fregs) \
> >  	frame_pointer(&(fregs)->regs)
> >  
> > +static __always_inline unsigned long
> > +ftrace_regs_get_return_address(struct ftrace_regs *fregs)
> > +{
> > +	return *(unsigned long *)ftrace_regs_get_stack_pointer(fregs);
> > +}
> > +
> >  struct ftrace_ops;
> >  #define ftrace_graph_func ftrace_graph_func
> >  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> > diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> > index 879a30956009..08b37b0d1d05 100644
> > --- a/include/linux/fprobe.h
> > +++ b/include/linux/fprobe.h
> > @@ -5,32 +5,56 @@
> >  
> >  #include <linux/compiler.h>
> >  #include <linux/ftrace.h>
> > -#include <linux/rethook.h>
> > +#include <linux/rcupdate.h>
> > +#include <linux/refcount.h>
> > +#include <linux/slab.h>
> > +
> > +struct fprobe;
> > +
> > +/**
> > + * strcut fprobe_hlist_node - address based hash list node for fprobe.
> > + *
> > + * @hlist: The hlist node for address search hash table.
> > + * @addr: The address represented by this.
> > + * @fp: The fprobe which owns this.
> > + */
> > +struct fprobe_hlist_node {
> > +	struct hlist_node	hlist;
> > +	unsigned long		addr;
> > +	struct fprobe		*fp;
> > +};
> > +
> > +/**
> > + * struct fprobe_hlist - hash list nodes for fprobe.
> > + *
> > + * @hlist: The hlist node for existence checking hash table.
> > + * @rcu: rcu_head for RCU deferred release.
> > + * @fp: The fprobe which owns this fprobe_hlist.
> > + * @size: The size of @array.
> > + * @array: The fprobe_hlist_node for each address to probe.
> > + */
> > +struct fprobe_hlist {
> > +	struct hlist_node		hlist;
> > +	struct rcu_head			rcu;
> > +	struct fprobe			*fp;
> > +	int				size;
> > +	struct fprobe_hlist_node	array[];
> > +};
> >  
> >  /**
> >   * struct fprobe - ftrace based probe.
> > - * @ops: The ftrace_ops.
> > + *
> >   * @nmissed: The counter for missing events.
> >   * @flags: The status flag.
> > - * @rethook: The rethook data structure. (internal data)
> >   * @entry_data_size: The private data storage size.
> > - * @nr_maxactive: The max number of active functions.
> > + * @nr_maxactive: The max number of active functions. (*deprecated)
> >   * @entry_handler: The callback function for function entry.
> >   * @exit_handler: The callback function for function exit.
> > + * @hlist_array: The fprobe_hlist for fprobe search from IP hash table.
> >   */
> >  struct fprobe {
> > -#ifdef CONFIG_FUNCTION_TRACER
> > -	/*
> > -	 * If CONFIG_FUNCTION_TRACER is not set, CONFIG_FPROBE is disabled too.
> > -	 * But user of fprobe may keep embedding the struct fprobe on their own
> > -	 * code. To avoid build error, this will keep the fprobe data structure
> > -	 * defined here, but remove ftrace_ops data structure.
> > -	 */
> > -	struct ftrace_ops	ops;
> > -#endif
> >  	unsigned long		nmissed;
> >  	unsigned int		flags;
> > -	struct rethook		*rethook;
> >  	size_t			entry_data_size;
> >  	int			nr_maxactive;
> >  
> > @@ -40,6 +64,8 @@ struct fprobe {
> >  	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip,
> >  			     unsigned long ret_ip, struct ftrace_regs *fregs,
> >  			     void *entry_data);
> > +
> > +	struct fprobe_hlist	*hlist_array;
> >  };
> >  
> >  /* This fprobe is soft-disabled. */
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index d895767dcb93..2bb819f08725 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -254,6 +254,13 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
> >  	regs_query_register_offset(name)
> >  #define ftrace_regs_get_frame_pointer(fregs) \
> >  	frame_pointer(&(fregs)->regs)
> > +
> > +#ifdef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
> > +/* This function works correctly in ftrace entry function. */
> > +static __always_inline unsigned long
> > +ftrace_regs_get_return_address(struct ftrace_regs *fregs);
> > +#endif
> > +
> >  #endif
> >  
> >  #ifdef CONFIG_HAVE_REGS_AND_STACK_ACCESS_API
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 9056315d56ed..d2ee9e6f1561 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -298,11 +298,9 @@ config DYNAMIC_FTRACE_WITH_ARGS
> >  
> >  config FPROBE
> >  	bool "Kernel Function Probe (fprobe)"
> > -	depends on FUNCTION_TRACER
> > -	depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
> > -	depends on HAVE_PT_REGS_TO_FTRACE_REGS_CAST || !HAVE_DYNAMIC_FTRACE_WITH_ARGS
> > -	depends on HAVE_RETHOOK
> > -	select RETHOOK
> > +	depends on FUNCTION_GRAPH_TRACER
> > +	depends on HAVE_FUNCTION_GRAPH_FREGS && HAVE_FTRACE_GRAPH_FUNC
> > +	depends on DYNAMIC_FTRACE_WITH_ARGS
> >  	default n
> >  	help
> >  	  This option enables kernel function probe (fprobe) based on ftrace.
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 31210423efc3..845ac5af4aeb 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -8,98 +8,193 @@
> >  #include <linux/fprobe.h>
> >  #include <linux/kallsyms.h>
> >  #include <linux/kprobes.h>
> > -#include <linux/rethook.h>
> > +#include <linux/list.h>
> > +#include <linux/mutex.h>
> >  #include <linux/slab.h>
> >  #include <linux/sort.h>
> >  
> >  #include "trace.h"
> >  
> > -struct fprobe_rethook_node {
> > -	struct rethook_node node;
> > -	unsigned long entry_ip;
> > -	unsigned long entry_parent_ip;
> > -	char data[];
> > -};
> > +#define FPROBE_IP_HASH_BITS 8
> > +#define FPROBE_IP_TABLE_SIZE (1 << FPROBE_IP_HASH_BITS)
> >  
> > -static inline void __fprobe_handler(unsigned long ip, unsigned long parent_ip,
> > -			struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > -{
> > -	struct fprobe_rethook_node *fpr;
> > -	struct rethook_node *rh = NULL;
> > -	struct fprobe *fp;
> > -	void *entry_data = NULL;
> > -	int ret = 0;
> > +#define FPROBE_HASH_BITS 6
> > +#define FPROBE_TABLE_SIZE (1 << FPROBE_HASH_BITS)
> >  
> > -	fp = container_of(ops, struct fprobe, ops);
> > +/*
> > + * fprobe_table: hold 'fprobe_hlist::hlist' for checking the fprobe still
> > + *   exists. The key is the address of fprobe instance.
> > + * fprobe_ip_table: hold 'fprobe_hlist::array[*]' for searching the fprobe
> > + *   instance related to the funciton address. The key is the ftrace IP
> > + *   address.
> > + *
> > + * When unregistering the fprobe, fprobe_hlist::fp and fprobe_hlist::array[*].fp
> > + * are set NULL and delete those from both hash tables (by hlist_del_rcu).
> > + * After an RCU grace period, the fprobe_hlist itself will be released.
> > + *
> > + * fprobe_table and fprobe_ip_table can be accessed from either
> > + *  - Normal hlist traversal and RCU add/del under 'fprobe_mutex' is held.
> > + *  - RCU hlist traversal under disabling preempt
> > + */
> > +static struct hlist_head fprobe_table[FPROBE_TABLE_SIZE];
> > +static struct hlist_head fprobe_ip_table[FPROBE_IP_TABLE_SIZE];
> > +static DEFINE_MUTEX(fprobe_mutex);
> >  
> > -	if (fp->exit_handler) {
> > -		rh = rethook_try_get(fp->rethook);
> > -		if (!rh) {
> > -			fp->nmissed++;
> > -			return;
> > -		}
> > -		fpr = container_of(rh, struct fprobe_rethook_node, node);
> > -		fpr->entry_ip = ip;
> > -		fpr->entry_parent_ip = parent_ip;
> > -		if (fp->entry_data_size)
> > -			entry_data = fpr->data;
> > +/*
> > + * Find first fprobe in the hlist. It will be iterated twice in the entry
> > + * probe, once for correcting the total required size, the second time is
> > + * calling back the user handlers.
> > + * Thus the hlist in the fprobe_table must be sorted and new probe needs to
> > + * be added *before* the first fprobe.
> > + */
> > +static struct fprobe_hlist_node *find_first_fprobe_node(unsigned long ip)
> > +{
> > +	struct fprobe_hlist_node *node;
> > +	struct hlist_head *head;
> > +
> > +	head = &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BITS)];
> > +	hlist_for_each_entry_rcu(node, head, hlist,
> > +				 lockdep_is_held(&fprobe_mutex)) {
> > +		if (node->addr == ip)
> > +			return node;
> >  	}
> > +	return NULL;
> > +}
> > +NOKPROBE_SYMBOL(find_first_fprobe_node);
> >  
> > -	if (fp->entry_handler)
> > -		ret = fp->entry_handler(fp, ip, parent_ip, fregs, entry_data);
> > +/* Node insertion and deletion requires the fprobe_mutex */
> > +static void insert_fprobe_node(struct fprobe_hlist_node *node)
> > +{
> > +	unsigned long ip = node->addr;
> > +	struct fprobe_hlist_node *next;
> > +	struct hlist_head *head;
> >  
> > -	/* If entry_handler returns !0, nmissed is not counted. */
> > -	if (rh) {
> > -		if (ret)
> > -			rethook_recycle(rh);
> > -		else
> > -			rethook_hook(rh, ftrace_get_regs(fregs), true);
> > +	lockdep_assert_held(&fprobe_mutex);
> > +
> > +	next = find_first_fprobe_node(ip);
> > +	if (next) {
> > +		hlist_add_before_rcu(&node->hlist, &next->hlist);
> > +		return;
> >  	}
> > +	head = &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BITS)];
> > +	hlist_add_head_rcu(&node->hlist, head);
> >  }
> >  
> > -static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> > -		struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > +/* Return true if there are synonims */
> > +static bool delete_fprobe_node(struct fprobe_hlist_node *node)
> >  {
> > -	struct fprobe *fp;
> > -	int bit;
> > +	lockdep_assert_held(&fprobe_mutex);
> >  
> > -	fp = container_of(ops, struct fprobe, ops);
> > -	if (fprobe_disabled(fp))
> > -		return;
> > +	WRITE_ONCE(node->fp, NULL);
> > +	hlist_del_rcu(&node->hlist);
> > +	return !!find_first_fprobe_node(node->addr);
> > +}
> >  
> > -	/* recursion detection has to go before any traceable function and
> > -	 * all functions before this point should be marked as notrace
> > -	 */
> > -	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> > -	if (bit < 0) {
> > -		fp->nmissed++;
> > -		return;
> > +/* Check existence of the fprobe */
> > +static bool is_fprobe_still_exist(struct fprobe *fp)
> > +{
> > +	struct hlist_head *head;
> > +	struct fprobe_hlist *fph;
> > +
> > +	head = &fprobe_table[hash_ptr(fp, FPROBE_HASH_BITS)];
> > +	hlist_for_each_entry_rcu(fph, head, hlist,
> > +				 lockdep_is_held(&fprobe_mutex)) {
> > +		if (fph->fp == fp)
> > +			return true;
> >  	}
> > -	__fprobe_handler(ip, parent_ip, ops, fregs);
> > -	ftrace_test_recursion_unlock(bit);
> > +	return false;
> > +}
> > +NOKPROBE_SYMBOL(is_fprobe_still_exist);
> > +
> > +static int add_fprobe_hash(struct fprobe *fp)
> > +{
> > +	struct fprobe_hlist *fph = fp->hlist_array;
> > +	struct hlist_head *head;
> > +
> > +	lockdep_assert_held(&fprobe_mutex);
> >  
> > +	if (WARN_ON_ONCE(!fph))
> > +		return -EINVAL;
> > +
> > +	if (is_fprobe_still_exist(fp))
> > +		return -EEXIST;
> > +
> > +	head = &fprobe_table[hash_ptr(fp, FPROBE_HASH_BITS)];
> > +	hlist_add_head_rcu(&fp->hlist_array->hlist, head);
> > +	return 0;
> >  }
> > -NOKPROBE_SYMBOL(fprobe_handler);
> >  
> > -static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
> > -				  struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > +static int del_fprobe_hash(struct fprobe *fp)
> >  {
> > -	struct fprobe *fp;
> > -	int bit;
> > +	struct fprobe_hlist *fph = fp->hlist_array;
> >  
> > -	fp = container_of(ops, struct fprobe, ops);
> > -	if (fprobe_disabled(fp))
> > -		return;
> > +	lockdep_assert_held(&fprobe_mutex);
> >  
> > -	/* recursion detection has to go before any traceable function and
> > -	 * all functions called before this point should be marked as notrace
> > -	 */
> > -	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> > -	if (bit < 0) {
> > -		fp->nmissed++;
> > -		return;
> > +	if (WARN_ON_ONCE(!fph))
> > +		return -EINVAL;
> > +
> > +	if (!is_fprobe_still_exist(fp))
> > +		return -ENOENT;
> > +
> > +	fph->fp = NULL;
> > +	hlist_del_rcu(&fph->hlist);
> > +	return 0;
> > +}
> > +
> > +/* The entry data size is 4 bits (=16) * sizeof(long) in maximum */
> > +#define FPROBE_HEADER_SIZE_BITS		4
> > +#define MAX_FPROBE_DATA_SIZE_WORD	((1L << FPROBE_HEADER_SIZE_BITS) - 1)
> > +#define MAX_FPROBE_DATA_SIZE		(MAX_FPROBE_DATA_SIZE_WORD * sizeof(long))
> > +#define FPROBE_HEADER_PTR_BITS		(BITS_PER_LONG - FPROBE_HEADER_SIZE_BITS)
> > +#define FPROBE_HEADER_PTR_MASK		GENMASK(FPROBE_HEADER_PTR_BITS - 1, 0)
> > +#define FPROBE_HEADER_SIZE		sizeof(unsigned long)
> > +
> > +static inline unsigned long encode_fprobe_header(struct fprobe *fp, int size_words)
> > +{
> > +	if (WARN_ON_ONCE(size_words > MAX_FPROBE_DATA_SIZE_WORD ||
> > +	    ((unsigned long)fp & ~FPROBE_HEADER_PTR_MASK) !=
> > +	    ~FPROBE_HEADER_PTR_MASK)) {
> > +		return 0;
> >  	}
> > +	return ((unsigned long)size_words << FPROBE_HEADER_PTR_BITS) |
> > +		((unsigned long)fp & FPROBE_HEADER_PTR_MASK);
> > +}
> > +
> > +/* Return reserved data size in words */
> > +static inline int decode_fprobe_header(unsigned long val, struct fprobe **fp)
> > +{
> > +	unsigned long ptr;
> > +
> > +	ptr = (val & FPROBE_HEADER_PTR_MASK) | ~FPROBE_HEADER_PTR_MASK;
> > +	if (fp)
> > +		*fp = (struct fprobe *)ptr;
> > +	return val >> FPROBE_HEADER_PTR_BITS;
> > +}
> > +
> > +/*
> > + * fprobe shadow stack management:
> > + * Since fprobe shares a single fgraph_ops, it needs to share the stack entry
> > + * among the probes on the same function exit. Note that a new probe can be
> > + * registered before a target function is returning, we can not use the hash
> > + * table to find the corresponding probes. Thus the probe address is stored on
> > + * the shadow stack with its entry data size.
> > + *
> > + */
> > +static inline int __fprobe_handler(unsigned long ip, unsigned long parent_ip,
> > +				   struct fprobe *fp, struct ftrace_regs *fregs,
> > +				   void *data)
> > +{
> > +	if (!fp->entry_handler)
> > +		return 0;
> > +
> > +	return fp->entry_handler(fp, ip, parent_ip, fregs, data);
> > +}
> >  
> > +static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
> > +					  struct fprobe *fp, struct ftrace_regs *fregs,
> > +					  void *data)
> > +{
> > +	int ret;
> >  	/*
> >  	 * This user handler is shared with other kprobes and is not expected to be
> >  	 * called recursively. So if any other kprobe handler is running, this will
> > @@ -108,45 +203,185 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
> >  	 */
> >  	if (unlikely(kprobe_running())) {
> >  		fp->nmissed++;
> > -		goto recursion_unlock;
> > +		return 0;
> >  	}
> >  
> >  	kprobe_busy_begin();
> > -	__fprobe_handler(ip, parent_ip, ops, fregs);
> > +	ret = __fprobe_handler(ip, parent_ip, fp, fregs, data);
> >  	kprobe_busy_end();
> > -
> > -recursion_unlock:
> > -	ftrace_test_recursion_unlock(bit);
> > +	return ret;
> >  }
> >  
> > -static void fprobe_exit_handler(struct rethook_node *rh, void *data,
> > -				unsigned long ret_ip, struct pt_regs *regs)
> > +static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > +			struct ftrace_regs *fregs)
> >  {
> > -	struct fprobe *fp = (struct fprobe *)data;
> > -	struct fprobe_rethook_node *fpr;
> > -	struct ftrace_regs *fregs = (struct ftrace_regs *)regs;
> > -	int bit;
> > +	struct fprobe_hlist_node *node, *first;
> > +	unsigned long *fgraph_data = NULL;
> > +	unsigned long func = trace->func;
> > +	unsigned long header, ret_ip;
> > +	int reserved_words;
> > +	struct fprobe *fp;
> > +	int used, ret;
> >  
> > -	if (!fp || fprobe_disabled(fp))
> > -		return;
> > +	if (WARN_ON_ONCE(!fregs))
> > +		return 0;
> >  
> > -	fpr = container_of(rh, struct fprobe_rethook_node, node);
> > +	first = node = find_first_fprobe_node(func);
> > +	if (unlikely(!first))
> > +		return 0;
> > +
> > +	reserved_words = 0;
> > +	hlist_for_each_entry_from_rcu(node, hlist) {
> > +		if (node->addr != func)
> > +			break;
> > +		fp = READ_ONCE(node->fp);
> > +		if (!fp || !fp->exit_handler)
> > +			continue;
> > +		/*
> > +		 * Since fprobe can be enabled until the next loop, we ignore the
> > +		 * fprobe's disabled flag in this loop.
> > +		 */
> > +		reserved_words +=
> > +			DIV_ROUND_UP(fp->entry_data_size, sizeof(long)) + 1;
> > +	}
> > +	node = first;
> > +	if (reserved_words) {
> > +		fgraph_data = fgraph_reserve_data(gops->idx, reserved_words * sizeof(long));
> > +		if (unlikely(!fgraph_data)) {
> > +			hlist_for_each_entry_from_rcu(node, hlist) {
> > +				if (node->addr != func)
> > +					break;
> > +				fp = READ_ONCE(node->fp);
> > +				if (fp && !fprobe_disabled(fp))
> > +					fp->nmissed++;
> > +			}
> > +			return 0;
> > +		}
> > +	}
> >  
> >  	/*
> > -	 * we need to assure no calls to traceable functions in-between the
> > -	 * end of fprobe_handler and the beginning of fprobe_exit_handler.
> > +	 * TODO: recursion detection has been done in the fgraph. Thus we need
> > +	 * to add a callback to increment missed counter.
> >  	 */
> > -	bit = ftrace_test_recursion_trylock(fpr->entry_ip, fpr->entry_parent_ip);
> > -	if (bit < 0) {
> > -		fp->nmissed++;
> > +	ret_ip = ftrace_regs_get_return_address(fregs);
> > +	used = 0;
> > +	hlist_for_each_entry_from_rcu(node, hlist) {
> > +		void *data;
> > +
> > +		if (node->addr != func)
> > +			break;
> > +		fp = READ_ONCE(node->fp);
> > +		if (!fp || fprobe_disabled(fp))
> > +			continue;
> > +
> > +		if (fp->entry_data_size && fp->exit_handler)
> > +			data = fgraph_data + used + 1;
> > +		else
> > +			data = NULL;
> > +
> > +		if (fprobe_shared_with_kprobes(fp))
> > +			ret = __fprobe_kprobe_handler(func, ret_ip, fp, fregs, data);
> > +		else
> > +			ret = __fprobe_handler(func, ret_ip, fp, fregs, data);
> > +		/* If entry_handler returns !0, nmissed is not counted but skips exit_handler. */
> > +		if (!ret && fp->exit_handler) {
> > +			int size_words = DIV_ROUND_UP(fp->entry_data_size, sizeof(long));
> > +
> > +			header = encode_fprobe_header(fp, size_words);
> > +			if (likely(header)) {
> > +				fgraph_data[used] = header;
> > +				used += size_words + 1;
> > +			}
> > +		}
> > +	}
> > +	if (used < reserved_words)
> > +		memset(fgraph_data + used, 0, reserved_words - used);
> > +
> > +	/* If any exit_handler is set, data must be used. */
> > +	return used != 0;
> > +}
> > +NOKPROBE_SYMBOL(fprobe_entry);
> > +
> > +static void fprobe_return(struct ftrace_graph_ret *trace,
> > +			  struct fgraph_ops *gops,
> > +			  struct ftrace_regs *fregs)
> > +{
> > +	unsigned long *fgraph_data = NULL;
> > +	unsigned long ret_ip;
> > +	unsigned long val;
> > +	struct fprobe *fp;
> > +	int size, curr;
> > +	int size_words;
> > +
> > +	fgraph_data = (unsigned long *)fgraph_retrieve_data(gops->idx, &size);
> > +	if (WARN_ON_ONCE(!fgraph_data))
> >  		return;
> > +	size_words = DIV_ROUND_UP(size, sizeof(long));
> > +	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
> > +
> > +	preempt_disable();
> > +
> > +	curr = 0;
> > +	while (size_words > curr) {
> > +		val = fgraph_data[curr++];
> 
> hi,
> the ++ in here -----------------------^^ screws the logic below,
> I think we need the change below to properly access the stack data
> 
> I wrote bpf test on top of this that adds multiple fprobes attached
> on single function and makes sure the fprobe gets its own data on
> fentry/fexit callbacks and with the change below it seems to work
> properly

Thanks for finding the bug!

> 
> jirka
> 
> > +		if (!val)
> > +			break;
> > +
> > +		size = decode_fprobe_header(val, &fp);
> > +		if (fp && is_fprobe_still_exist(fp) && !fprobe_disabled(fp)) {
> > +			if (WARN_ON_ONCE(curr + size > size_words))
> > +				break;
> > +			fp->exit_handler(fp, trace->func, ret_ip, fregs,
> > +					 size ? fgraph_data + curr : NULL);
> > +		}
> > +		curr += size + 1;

But I think the problem is here. We've already decoded header, so "cur += size" is enough.

BTW, I also found that I used DIV_ROUND_UP(..., sizeof(long)) on hotpath.
It should be changed.

Thank you,

> >  	}
> > +	preempt_enable();
> > +}
> 
> 
> ---
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 845ac5af4aeb..bfe255e12a13 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -323,16 +323,16 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
>  
>  	curr = 0;
>  	while (size_words > curr) {
> -		val = fgraph_data[curr++];
> +		val = fgraph_data[curr];
>  		if (!val)
>  			break;
>  
>  		size = decode_fprobe_header(val, &fp);
>  		if (fp && is_fprobe_still_exist(fp) && !fprobe_disabled(fp)) {
> -			if (WARN_ON_ONCE(curr + size > size_words))
> +			if (WARN_ON_ONCE(curr + size + 1 > size_words))
>  				break;
>  			fp->exit_handler(fp, trace->func, ret_ip, fregs,
> -					 size ? fgraph_data + curr : NULL);
> +					 size ? fgraph_data + curr + 1 : NULL);
>  		}
>  		curr += size + 1;
>  	}


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

