Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6833418290
	for <lists+bpf@lfdr.de>; Sat, 25 Sep 2021 16:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343711AbhIYORN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Sep 2021 10:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233738AbhIYORM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Sep 2021 10:17:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25F76610CB;
        Sat, 25 Sep 2021 14:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632579337;
        bh=F+AlHS6PPVuRVCyevcsvKlF4dvGCZ7T9raeM92tjuFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CkD7gc0d34PTtEkrdbBVIHHjGNtym7V83Sae7/Y4xDh15w6XhDbwLtlDGBUW6R6W9
         r5wkk/LrzdraQ5CpMFsDQ/Ffu4Ancb3nUvCr3pDSBIE7y9czR/32gdWr6qAViNMqLD
         a3ekd8Y51Sn91nG0F0lSFVhbkLZpczJsn+g/afvvdsIGKQATuAzgaGHiS+7kia7ngt
         kIJN5EKhBrkiEgD+RvmpMyogNZgBH2SHCs/1lk9uS1D90tu/hkIArCu9o5KSABaLKX
         cdiqopQSi++qzMl8yoV4XnISmMe86ga45cw8g3Yffgz8Wmn8/4phG7BjaclPa3mUIV
         P54PQ4A+ImG/A==
Date:   Sat, 25 Sep 2021 23:15:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tracing/kprobe: Support $$args for function entry
Message-Id: <20210925231535.aba3f620efa94e2a213c558f@kernel.org>
In-Reply-To: <aba162cc-8ee5-45e1-e29b-60118bc2a980@oracle.com>
References: <163240078318.34105.12819521680435948398.stgit@devnote2>
        <163240079198.34105.7585817231870405021.stgit@devnote2>
        <aba162cc-8ee5-45e1-e29b-60118bc2a980@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 24 Sep 2021 18:51:04 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> On 23/09/2021 13:39, Masami Hiramatsu wrote:
> 
> > Support $$args fetch arg for function entry. This uses
> > BTF for finding the function argument. Thus it depends
> > on CONFIG_BPF_SYSCALL.
> >
> > /sys/kernel/tracing # echo 'p vfs_read $$args' >> kprobe_events
> > /sys/kernel/tracing # cat kprobe_events
> > p:kprobes/p_vfs_read_0 vfs_read file=$arg1:x64 buf=$arg2:x64 count=$arg3:u64 pos=$arg4:x64
> >
> > Note that $$args must be used without argument name.
> 
> This looks great! Can I ask which tree you're building on
> 
> top of so I can play around with this a bit?

This can be applied on top of Steve's tracing tree, ftrace/core branch.

git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

> 
> 
> I also wonder if we could rework btf_show_name() to help
> 
> render full type info for the args? in kernel/bpf/btf.c:
> 
> 
> /*
>   * Populate show->state.name with type name information.
>   * Format of type name is
>   *
>   * [.member_name = ] (type_name)
>   */
> 
> The (type_name) part is what we'd want from here; no reason
> 
> we can't refactor that function to make the type name available
> 
> as a cast. It would rework the output to be something like
> 
> 
> p:kprobes/p_vfs_read_0 vfs_read struct file *file=$arg1 , char *buf=$arg2 , size_t count=$arg3 , loff_t pos=$arg4
> 
> ...if that's wanted of course (not sure what the constraints on format are here)? Thanks for pushing this along!

Sorry, the kprobe_events interface syntax doesn't accept such cast info.
And I want such BTF type query interface to be independent from
this kprobe-events interface.
Can we have a query interface like /sys/kernel/btf/query?

Thank you,

> 
> 
> Alan
> 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >   kernel/trace/trace_kprobe.c |   60 ++++++++++++++++++++++++-
> >   kernel/trace/trace_probe.c  |  105 +++++++++++++++++++++++++++++++++++++++++++
> >   kernel/trace/trace_probe.h  |    5 ++
> >   3 files changed, 168 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 3dd4fb719aa3..fe88ee8c8cd8 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -712,6 +712,58 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
> >   	return NOTIFY_DONE;
> >   }
> >   
> > +#ifdef CONFIG_BPF_SYSCALL
> > +
> > +static int trace_kprobe_parse_btf_args(struct trace_kprobe *tk, int i,
> > +				       const char *arg, unsigned int flags)
> > +{
> > +	struct trace_probe *tp = &tk->tp;
> > +	static struct btf *btf;
> > +	const struct btf_type *t;
> > +	const struct btf_param *args;
> > +	s32 id, nargs;
> > +	int ret;
> > +
> > +	if (!(flags & TPARG_FL_FENTRY))
> > +		return -EINVAL;
> > +	if (!tk->symbol)
> > +		return -EINVAL;
> > +
> > +	if (!btf)
> > +		btf = btf_parse_vmlinux();
> > +
> > +	id = btf_find_by_name_kind(btf, tk->symbol, BTF_KIND_FUNC);
> > +	if (id <= 0)
> > +		return -ENOENT;
> > +
> > +	/* Get BTF_KIND_FUNC type */
> > +	t = btf_type_by_id(btf, id);
> > +	if (!btf_type_is_func(t))
> > +		return -ENOENT;
> > +
> > +	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> > +	t = btf_type_by_id(btf, t->type);
> > +	if (!btf_type_is_func_proto(t))
> > +		return -ENOENT;
> > +
> > +	args = (const struct btf_param *)(t + 1);
> > +	nargs = btf_type_vlen(t);
> > +	for (i = 0; i < nargs; i++) {
> > +		ret = traceprobe_parse_btf_arg(tp, i, btf, &args[i]);
> > +		if (ret < 0)
> > +			break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +#else
> > +static int trace_kprobe_parse_btf_args(struct trace_kprobe *tk, int i,
> > +				       const char *arg, unsigned int flags)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +#endif
> > +
> >   static struct notifier_block trace_kprobe_module_nb = {
> >   	.notifier_call = trace_kprobe_module_callback,
> >   	.priority = 1	/* Invoked after kprobe module callback */
> > @@ -733,12 +785,13 @@ static int __trace_kprobe_create(int argc, const char *argv[])
> >   	 *  $stack	: fetch stack address
> >   	 *  $stackN	: fetch Nth of stack (N:0-)
> >   	 *  $comm       : fetch current task comm
> > +	 *  $$args	: fetch parameters using BTF
> >   	 *  @ADDR	: fetch memory at ADDR (ADDR should be in kernel)
> >   	 *  @SYM[+|-offs] : fetch memory at SYM +|- offs (SYM is a data symbol)
> >   	 *  %REG	: fetch register REG
> >   	 * Dereferencing memory fetch:
> >   	 *  +|-offs(ARG) : fetch memory at ARG +|- offs address.
> > -	 * Alias name of args:
> > +	 * Alias name of args (except for $$args) :
> >   	 *  NAME=FETCHARG : set NAME as alias of FETCHARG.
> >   	 * Type of args:
> >   	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
> > @@ -877,7 +930,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
> >   	/* parse arguments */
> >   	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
> >   		trace_probe_log_set_index(i + 2);
> > -		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], flags);
> > +		if (strcmp(argv[i], "$$args") == 0)
> > +			ret = trace_kprobe_parse_btf_args(tk, i, argv[i], flags);
> > +		else
> > +			ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], flags);
> >   		if (ret)
> >   			goto error;	/* This can be -ENOMEM */
> >   	}
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 2fe104109525..bbac261b1688 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -765,6 +765,111 @@ static int traceprobe_conflict_field_name(const char *name,
> >   	return 0;
> >   }
> >   
> > +#ifdef CONFIG_BPF_SYSCALL
> > +
> > +static u32 btf_type_int(const struct btf_type *t)
> > +{
> > +	return *(u32 *)(t + 1);
> > +}
> > +
> > +static const char *traceprobe_type_from_btf(struct btf *btf, s32 id)
> > +{
> > +	const struct btf_type *t;
> > +	u32 intdata;
> > +	s32 tid;
> > +
> > +	/* TODO: const char * could be converted as a string */
> > +	t = btf_type_skip_modifiers(btf, id, &tid);
> > +
> > +	switch (BTF_INFO_KIND(t->info)) {
> > +	case BTF_KIND_ENUM:
> > +		/* enum is "int", so convert to "s32" */
> > +		return "s32";
> > +	case BTF_KIND_PTR:
> > +		/* pointer will be converted to "x??" */
> > +		if (IS_ENABLED(CONFIG_64BIT))
> > +			return "x64";
> > +		else
> > +			return "x32";
> > +	case BTF_KIND_INT:
> > +		intdata = btf_type_int(t);
> > +		if (BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED) {
> > +			switch (BTF_INT_BITS(intdata)) {
> > +			case 8:
> > +				return "s8";
> > +			case 16:
> > +				return "s16";
> > +			case 32:
> > +				return "s32";
> > +			case 64:
> > +				return "s64";
> > +			}
> > +		} else {	/* unsigned */
> > +			switch (BTF_INT_BITS(intdata)) {
> > +			case 8:
> > +				return "u8";
> > +			case 16:
> > +				return "u16";
> > +			case 32:
> > +				return "u32";
> > +			case 64:
> > +				return "u64";
> > +			}
> > +		}
> > +	}
> > +
> > +	/* Default type */
> > +	if (IS_ENABLED(CONFIG_64BIT))
> > +		return "x64";
> > +	else
> > +		return "x32";
> > +}
> > +
> > +int traceprobe_parse_btf_arg(struct trace_probe *tp, int i, struct btf *btf,
> > +			     const struct btf_param *arg)
> > +{
> > +	struct probe_arg *parg = &tp->args[i];
> > +	const char *name, *tname;
> > +	char *body;
> > +	int ret;
> > +
> > +	tp->nr_args++;
> > +	name = btf_name_by_offset(btf, arg->name_off);
> > +	parg->name = kstrdup(name, GFP_KERNEL);
> > +	if (!parg->name)
> > +		return -ENOMEM;
> > +
> > +	if (!is_good_name(parg->name)) {
> > +		trace_probe_log_err(0, BAD_ARG_NAME);
> > +		return -EINVAL;
> > +	}
> > +	if (traceprobe_conflict_field_name(parg->name, tp->args, i)) {
> > +		trace_probe_log_err(0, USED_ARG_NAME);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * Since probe event needs an appropriate command for dyn_event interface,
> > +	 * convert BTF type to corresponding fetch-type string.
> > +	 */
> > +	tname = traceprobe_type_from_btf(btf, arg->type);
> > +	if (tname)
> > +		body = kasprintf(GFP_KERNEL, "$arg%d:%s", i + 1, tname);
> > +	else
> > +		body = kasprintf(GFP_KERNEL, "$arg%d", i + 1);
> > +
> > +	if (!body)
> > +		return -ENOMEM;
> > +	/* Parse fetch argument */
> > +	ret = traceprobe_parse_probe_arg_body(body, &tp->size, parg,
> > +				TPARG_FL_KERNEL | TPARG_FL_FENTRY, 0);
> > +
> > +	kfree(body);
> > +
> > +	return ret;
> > +}
> > +#endif
> > +
> >   int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, const char *arg,
> >   				unsigned int flags)
> >   {
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index 355c78a930f8..857b946afe29 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -23,6 +23,7 @@
> >   #include <linux/limits.h>
> >   #include <linux/uaccess.h>
> >   #include <linux/bitops.h>
> > +#include <linux/btf.h>
> >   #include <asm/bitsperlong.h>
> >   
> >   #include "trace.h"
> > @@ -359,6 +360,10 @@ int trace_probe_create(const char *raw_command, int (*createfn)(int, const char
> >   
> >   extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
> >   				const char *argv, unsigned int flags);
> > +#ifdef CONFIG_BPF_SYSCALL
> > +int traceprobe_parse_btf_arg(struct trace_probe *tp, int i, struct btf *btf,
> > +			     const struct btf_param *arg);
> > +#endif
> >   
> >   extern int traceprobe_update_arg(struct probe_arg *arg);
> >   extern void traceprobe_free_probe_arg(struct probe_arg *arg);
> >


-- 
Masami Hiramatsu <mhiramat@kernel.org>
