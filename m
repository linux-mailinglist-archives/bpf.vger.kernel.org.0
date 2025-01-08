Return-Path: <bpf+bounces-48224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E88A0525F
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 05:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A023A7235
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 04:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939AE19F121;
	Wed,  8 Jan 2025 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3xHI011"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE818EB0;
	Wed,  8 Jan 2025 04:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736311941; cv=none; b=izvRYn5WGZHgs0HhHAans0MEPtwQfcUcnZ/mqdzYfi+2pDw2iusgFf2FLDY5gOeLvE5Ohp4Lyn3MgdUcHFD7YrNSCnL3//vIlVBiGMULNsDckVbLvlGq0QV/nXlf1ycEtQMjDZ54NVcPSz18LsxkHopkBEXMIqNtIecycHet2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736311941; c=relaxed/simple;
	bh=D1PhWHZp6We3lr7kB99PxDSEro3BDLrjugvo4kINodU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aET6iJRlkKzLukY4eI6OtE9tVd6ylHPkf9t+q6iI8BBRfIRsD22f48r4E3rDucl8CDeLOtrGDWhelOThJqsPWwTQYurs0fSvEWl4JupeDXMNAUha6lRzEJ411CoLAf/JwWwugx576TFZAUzUwiUGPtsrgd86jjvPr0wd+VPButk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3xHI011; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B7EC4CED0;
	Wed,  8 Jan 2025 04:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736311940;
	bh=D1PhWHZp6We3lr7kB99PxDSEro3BDLrjugvo4kINodU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G3xHI011+ui/VTEAVoPJqf+lbvbeMZkCu1YPLBPK40W2Jws/lvEi9sP1YaZ1LJlkA
	 Gy78ufGq+CkPO+m66r0EqwwhMnExEh2gbDFvHY1UwaUlrTycxFAfJMCsgmZY0HNdNn
	 1x5SXwfKOhde+qw4crp++MKO1l26wstLJvtAffCf6dHn/gYTIYINlq2z2ZbcqDicMK
	 eB+AK0y8K0XcrR10EwPHvv/hX4RpKojdn91lsbSXPzSwVlRhkFgwkEZSioDo149//3
	 8l53F0fh8jyAT3ptqP6+i0cElf/5KhKrAE/xMK7BT5iGnANhDPTQ2Dh0IBSyIw4rxv
	 fd3KhGgdFECHw==
Date: Wed, 8 Jan 2025 13:52:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sven Schnelle <svens@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Zheng
 Yejian <zhengyejian@huaweicloud.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ftrace: Add print_function_args()
Message-Id: <20250108135217.9db8d131835acfb6ce4baa88@kernel.org>
In-Reply-To: <CAErzpms4g8=3486Uv-PPxiA0GSkNQQm1Ez67eo-H3LtAhTAJCA@mail.gmail.com>
References: <20241223201347.609298489@goodmis.org>
	<20241223201541.898496620@goodmis.org>
	<CAErzpms4g8=3486Uv-PPxiA0GSkNQQm1Ez67eo-H3LtAhTAJCA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 8 Jan 2025 10:30:08 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> Steven Rostedt <rostedt@goodmis.org>于2024年12月24日 周二04:14写道：
> 
> > From: Sven Schnelle <svens@linux.ibm.com>
> >
> > Add a function to decode argument types with the help of BTF. Will
> > be used to display arguments in the function and function graph
> > tracer.
> >
> > It can only handle simply arguments and up to FTRACE_REGS_MAX_ARGS number
> > of arguments. When it hits a max, it will print ", ...":
> >
> >    page_to_skb(vi=0xffff8d53842dc980, rq=0xffff8d53843a0800,
> > page=0xfffffc2e04337c00, offset=6160, len=64, truesize=1536, ...)
> >
> > And if it hits an argument that is not recognized, it will print the raw
> > value and the type of argument it is:
> >
> >    make_vfsuid(idmap=0xffffffff87f99db8, fs_userns=0xffffffff87e543c0,
> > kuid=0x0 (STRUCT))
> >    __pti_set_user_pgtbl(pgdp=0xffff8d5384ab47f8, pgd=0x110e74067 (STRUCT))
> >
> > Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> > Changes since v1:
> > https://lore.kernel.org/20240904065908.1009086-5-svens@linux.ibm.com
> >
> >  - Added Config option FUNCTION_TRACE_ARGS to this patch
> >   (unconditional if dependencies are met)
> >
> >  - Changed the print_function_args() function to take an array of
> >    unsigned long args and not the ftrace_regs pointer. The ftrace_regs
> >    should be opaque from generic code.
> >
> >  - Have the function print the name of an BTF type that is not supported.
> >
> >  - Added FTRACE_REGS_MAX_ARGS as the number of arguments saved in
> >    the event and printed out.
> >
> >  - Print "...," if the number of arguments goes past FTRACE_REGS_MAX_ARGS.
> >
> >  include/linux/ftrace_regs.h |  5 +++
> >  kernel/trace/Kconfig        |  6 +++
> >  kernel/trace/trace_output.c | 78 +++++++++++++++++++++++++++++++++++++
> >  kernel/trace/trace_output.h |  9 +++++
> >  4 files changed, 98 insertions(+)
> >
> > diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
> > index bbc1873ca6b8..15627ceea9bc 100644
> > --- a/include/linux/ftrace_regs.h
> > +++ b/include/linux/ftrace_regs.h
> > @@ -35,4 +35,9 @@ struct ftrace_regs;
> >
> >  #endif /* HAVE_ARCH_FTRACE_REGS */
> >
> > +/* This can be overridden by the architectures */
> > +#ifndef FTRACE_REGS_MAX_ARGS
> > +# define FTRACE_REGS_MAX_ARGS  6
> > +#endif
> > +
> >  #endif /* _LINUX_FTRACE_REGS_H */
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index d570b8b9c0a9..60412c1012ef 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -263,6 +263,12 @@ config FUNCTION_GRAPH_RETADDR
> >           the function is called. This feature is off by default, and you
> > can
> >           enable it via the trace option funcgraph-retaddr.
> >
> > +config FUNCTION_TRACE_ARGS
> > +       bool
> > +       depends on HAVE_FUNCTION_ARG_ACCESS_API
> > +       depends on DEBUG_INFO_BTF
> > +       default y
> > +
> >  config DYNAMIC_FTRACE
> >         bool "enable/disable function tracing dynamically"
> >         depends on FUNCTION_TRACER
> > diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> > index da748b7cbc4d..40d6c7a9e0c4 100644
> > --- a/kernel/trace/trace_output.c
> > +++ b/kernel/trace/trace_output.c
> > @@ -12,8 +12,11 @@
> >  #include <linux/sched/clock.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/idr.h>
> > +#include <linux/btf.h>
> > +#include <linux/bpf.h>
> >
> >  #include "trace_output.h"
> > +#include "trace_btf.h"
> >
> >  /* must be a power of 2 */
> >  #define EVENT_HASHSIZE 128
> > @@ -680,6 +683,81 @@ int trace_print_lat_context(struct trace_iterator
> > *iter)
> >         return !trace_seq_has_overflowed(s);
> >  }
> >
> > +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> > +void print_function_args(struct trace_seq *s, unsigned long *args,
> > +                        unsigned long func)
> > +{
> > +       const struct btf_param *param;
> > +       const struct btf_type *t;
> > +       const char *param_name;
> > +       char name[KSYM_NAME_LEN];
> > +       unsigned long arg;
> > +       struct btf *btf;
> > +       s32 tid, nr = 0;
> > +       int i;
> > +
> > +       trace_seq_printf(s, "(");
> > +
> > +       if (!args)
> > +               goto out;
> > +       if (lookup_symbol_name(func, name))
> > +               goto out;
> > +
> > +       btf = bpf_get_btf_vmlinux();
> > +       if (IS_ERR_OR_NULL(btf))
> > +               goto out;
> 
> 
> There is no need to the retrieve the BTF of vmlinux, as btf_find_func_proto
> will return the correct BTF via its second parameter.

Good catch! The second parameter of btf_find_func_proto() is output.

Thank you,

> 
> — donglin
> 
> 
> > +
> > +       t = btf_find_func_proto(name, &btf);
> > +       if (IS_ERR_OR_NULL(t))
> > +               goto out;
> > +
> > +       param = btf_get_func_param(t, &nr);
> > +       if (!param)
> > +               goto out_put;
> > +
> > +       for (i = 0; i < nr; i++) {
> > +               /* This only prints what the arch allows (6 args by
> > default) */
> > +               if (i == FTRACE_REGS_MAX_ARGS) {
> > +                       trace_seq_puts(s, "...");
> > +                       break;
> > +               }
> > +
> > +               arg = args[i];
> > +
> > +               param_name = btf_name_by_offset(btf, param[i].name_off);
> > +               if (param_name)
> > +                       trace_seq_printf(s, "%s=", param_name);
> > +               t = btf_type_skip_modifiers(btf, param[i].type, &tid);
> > +
> > +               switch (t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN) {
> > +               case BTF_KIND_UNKN:
> > +                       trace_seq_putc(s, '?');
> > +                       /* Still print unknown type values */
> > +                       fallthrough;
> > +               case BTF_KIND_PTR:
> > +                       trace_seq_printf(s, "0x%lx", arg);
> > +                       break;
> > +               case BTF_KIND_INT:
> > +                       trace_seq_printf(s, "%ld", arg);
> > +                       break;
> > +               case BTF_KIND_ENUM:
> > +                       trace_seq_printf(s, "%ld", arg);
> > +                       break;
> > +               default:
> > +                       /* This does not handle complex arguments */
> > +                       trace_seq_printf(s, "0x%lx (%s)", arg,
> > btf_type_str(t));
> > +                       break;
> > +               }
> > +               if (i < nr - 1)
> > +                       trace_seq_printf(s, ", ");
> > +       }
> > +out_put:
> > +       btf_put(btf);
> > +out:
> > +       trace_seq_printf(s, ")");
> > +}
> > +#endif
> > +
> >  /**
> >   * ftrace_find_event - find a registered event
> >   * @type: the type of event to look for
> > diff --git a/kernel/trace/trace_output.h b/kernel/trace/trace_output.h
> > index dca40f1f1da4..2e305364f2a9 100644
> > --- a/kernel/trace/trace_output.h
> > +++ b/kernel/trace/trace_output.h
> > @@ -41,5 +41,14 @@ extern struct rw_semaphore trace_event_sem;
> >  #define SEQ_PUT_HEX_FIELD(s, x)                                \
> >         trace_seq_putmem_hex(s, &(x), sizeof(x))
> >
> > +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> > +void print_function_args(struct trace_seq *s, unsigned long *args,
> > +                        unsigned long func);
> > +#else
> > +static inline void print_function_args(struct trace_seq *s, unsigned long
> > *args,
> > +                                      unsigned long func) {
> > +       trace_seq_puts(s, "()");
> > +}
> > +#endif
> >  #endif
> >
> > --
> > 2.45.2
> >
> >
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

