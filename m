Return-Path: <bpf+bounces-1370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C271423E
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 05:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7771C20978
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 03:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B99647;
	Mon, 29 May 2023 03:16:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4262D
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 03:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37735C433EF;
	Mon, 29 May 2023 03:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685330202;
	bh=SuwHK+3uvnhmr7CGQ1Uh5iGkHRJq+JULE8llPZ/Laq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PKz0TDcEzwaZcSqsXJsYOIBjL8QpVfPVFouOafv2xxKU6fm76PRcsY6l2kiP8DBCd
	 48htF2muGltMOdpYpANp+Y+EyPNOJtrs8bCNEcNQ+gGdeEwk86aAjnhnDdHN/HEZzn
	 2RePuI7cPBCjuUTz9qrhIy+ACPkMlrpskbJAdJSe3xwGHJG98rZGMscP4n1bjH2aB6
	 3XGyuEkk3LFFt3xZ/mFo8AB/Mff6tZUhCaeLWymU3Tbl092VUUFncycFpMFBkGn3TX
	 StcMa0/9paxbpDcI2APSaX8jgVvQqtPDFHOtj5+KwK2h5b1OPJtdrOUbPgeQ+ndysB
	 HlwsUL+K4W2Xg==
Date: Mon, 29 May 2023 12:16:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, Will
 Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v13 03/12] tracing/probes: Add fprobe events for tracing
 function entry and exit.
Message-Id: <20230529121638.74b94a2d85eb384d9b02c719@kernel.org>
In-Reply-To: <CABRcYm+esb8J2O1v6=C+h+HSa5NxraPUgo63w7-iZj0CXbpusg@mail.gmail.com>
References: <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
	<168507469754.913472.6112857614708350210.stgit@mhiramat.roam.corp.google.com>
	<CABRcYm+esb8J2O1v6=C+h+HSa5NxraPUgo63w7-iZj0CXbpusg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 26 May 2023 21:38:44 +0200
Florent Revest <revest@chromium.org> wrote:

> On Fri, May 26, 2023 at 6:18 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > [...] Since
> > CONFIG_KPROBES_ON_FTRACE requires the CONFIG_DYNAMIC_FTRACE_WITH_REGS,
> > it is not available if the architecture only supports
> > CONFIG_DYNAMIC_FTRACE_WITH_ARGS. And that means kprobe events can not
> > probe function entry/exit effectively on such architecture.
> > But this can be solved if the dynamic events supports fprobe events.
> 
> Currently CONFIG_FPROBE also requires CONFIG_DYNAMIC_FTRACE_WITH_REGS
> so iiuc this will only be true when we'll have migrated fprobe to use
> ftrace_regs instead of pt_regs right ?

Sorry for confusion, yes, that's right. Currently does, but I will remove
that.

> 
> We discussed having fprobe use ftrace_regs instead of pt_regs in the
> past and I even had a proof of concept branch at one point but this
> patch seems to make this transition quite a bit harder. Have you tried
> to make fprobe work on ftrace_regs on top of this patch ?

No, not yet, but taht should not be so hard. Let me try.

Thank you!

> 
> > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > new file mode 100644
> > index 000000000000..48dbbc72b7dd
> > --- /dev/null
> > +++ b/kernel/trace/trace_fprobe.c
> > @@ -0,0 +1,1053 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Fprobe-based tracing events
> > + * Copyright (C) 2022 Google LLC.
> > + */
> > +#define pr_fmt(fmt)    "trace_fprobe: " fmt
> > +
> > +#include <linux/fprobe.h>
> > +#include <linux/module.h>
> > +#include <linux/rculist.h>
> > +#include <linux/security.h>
> > +#include <linux/uaccess.h>
> > +
> > +#include "trace_dynevent.h"
> > +#include "trace_probe.h"
> > +#include "trace_probe_kernel.h"
> > +#include "trace_probe_tmpl.h"
> > +
> > +#define FPROBE_EVENT_SYSTEM "fprobes"
> > +#define RETHOOK_MAXACTIVE_MAX 4096
> > +
> > +static int trace_fprobe_create(const char *raw_command);
> > +static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev);
> > +static int trace_fprobe_release(struct dyn_event *ev);
> > +static bool trace_fprobe_is_busy(struct dyn_event *ev);
> > +static bool trace_fprobe_match(const char *system, const char *event,
> > +                       int argc, const char **argv, struct dyn_event *ev);
> > +
> > +static struct dyn_event_operations trace_fprobe_ops = {
> > +       .create = trace_fprobe_create,
> > +       .show = trace_fprobe_show,
> > +       .is_busy = trace_fprobe_is_busy,
> > +       .free = trace_fprobe_release,
> > +       .match = trace_fprobe_match,
> > +};
> > +
> > +/*
> > + * Fprobe event core functions
> > + */
> > +struct trace_fprobe {
> > +       struct dyn_event        devent;
> > +       struct fprobe           fp;
> > +       const char              *symbol;
> > +       struct trace_probe      tp;
> > +};
> > +
> > +static bool is_trace_fprobe(struct dyn_event *ev)
> > +{
> > +       return ev->ops == &trace_fprobe_ops;
> > +}
> > +
> > +static struct trace_fprobe *to_trace_fprobe(struct dyn_event *ev)
> > +{
> > +       return container_of(ev, struct trace_fprobe, devent);
> > +}
> > +
> > +/**
> > + * for_each_trace_fprobe - iterate over the trace_fprobe list
> > + * @pos:       the struct trace_fprobe * for each entry
> > + * @dpos:      the struct dyn_event * to use as a loop cursor
> > + */
> > +#define for_each_trace_fprobe(pos, dpos)       \
> > +       for_each_dyn_event(dpos)                \
> > +               if (is_trace_fprobe(dpos) && (pos = to_trace_fprobe(dpos)))
> > +
> > +static bool trace_fprobe_is_return(struct trace_fprobe *tf)
> > +{
> > +       return tf->fp.exit_handler != NULL;
> > +}
> > +
> > +static const char *trace_fprobe_symbol(struct trace_fprobe *tf)
> > +{
> > +       return tf->symbol ? tf->symbol : "unknown";
> > +}
> > +
> > +static bool trace_fprobe_is_busy(struct dyn_event *ev)
> > +{
> > +       struct trace_fprobe *tf = to_trace_fprobe(ev);
> > +
> > +       return trace_probe_is_enabled(&tf->tp);
> > +}
> > +
> > +static bool trace_fprobe_match_command_head(struct trace_fprobe *tf,
> > +                                           int argc, const char **argv)
> > +{
> > +       char buf[MAX_ARGSTR_LEN + 1];
> > +
> > +       if (!argc)
> > +               return true;
> > +
> > +       snprintf(buf, sizeof(buf), "%s", trace_fprobe_symbol(tf));
> > +       if (strcmp(buf, argv[0]))
> > +               return false;
> > +       argc--; argv++;
> > +
> > +       return trace_probe_match_command_args(&tf->tp, argc, argv);
> > +}
> > +
> > +static bool trace_fprobe_match(const char *system, const char *event,
> > +                       int argc, const char **argv, struct dyn_event *ev)
> > +{
> > +       struct trace_fprobe *tf = to_trace_fprobe(ev);
> > +
> > +       if (event[0] != '\0' && strcmp(trace_probe_name(&tf->tp), event))
> > +               return false;
> > +
> > +       if (system && strcmp(trace_probe_group_name(&tf->tp), system))
> > +               return false;
> > +
> > +       return trace_fprobe_match_command_head(tf, argc, argv);
> > +}
> > +
> > +static bool trace_fprobe_is_registered(struct trace_fprobe *tf)
> > +{
> > +       return fprobe_is_registered(&tf->fp);
> > +}
> > +
> > +/*
> > + * Note that we don't verify the fetch_insn code, since it does not come
> > + * from user space.
> > + */
> > +static int
> > +process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
> > +                  void *base)
> > +{
> > +       struct pt_regs *regs = rec;
> 
> I gave it a try this week and it was mostly a matter of replacing
> pt_regs with ftrace_regs in this file. Like here for example. Not too
> bad so far.
> 
> > +       unsigned long val;
> > +       int ret;
> > +
> > +retry:
> > +       /* 1st stage: get value from context */
> > +       switch (code->op) {
> > +       case FETCH_OP_STACK:
> > +               val = regs_get_kernel_stack_nth(regs, code->param);
> 
> This does not have a ftrace_regs equivalent at the moment. I suppose
> we could introduce one without too much effort so that's probably ok.
> 
> > +               break;
> > +       case FETCH_OP_STACKP:
> > +               val = kernel_stack_pointer(regs);
> > +               break;
> > +       case FETCH_OP_RETVAL:
> > +               val = regs_return_value(regs);
> > +               break;
> > +#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> > +       case FETCH_OP_ARG:
> > +               val = regs_get_kernel_argument(regs, code->param);
> > +               break;
> > +#endif
> > +       case FETCH_NOP_SYMBOL:  /* Ignore a place holder */
> > +               code++;
> > +               goto retry;
> > +       default:
> > +               ret = process_common_fetch_insn(code, &val);
> > +               if (ret < 0)
> > +                       return ret;
> > +       }
> > +       code++;
> > +
> > +       return process_fetch_insn_bottom(code, val, dest, base);
> > +}
> > +NOKPROBE_SYMBOL(process_fetch_insn)
> > +
> > +/* function entry handler */
> > +static nokprobe_inline void
> > +__fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > +                   struct pt_regs *regs,
> > +                   struct trace_event_file *trace_file)
> > +{
> > +       struct fentry_trace_entry_head *entry;
> > +       struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> > +       struct trace_event_buffer fbuffer;
> > +       int dsize;
> > +
> > +       if (WARN_ON_ONCE(call != trace_file->event_call))
> > +               return;
> > +
> > +       if (trace_trigger_soft_disabled(trace_file))
> > +               return;
> > +
> > +       dsize = __get_data_size(&tf->tp, regs);
> > +
> > +       entry = trace_event_buffer_reserve(&fbuffer, trace_file,
> > +                                          sizeof(*entry) + tf->tp.size + dsize);
> > +       if (!entry)
> > +               return;
> > +
> > +       fbuffer.regs = regs;
> > +       entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
> > +       entry->ip = entry_ip;
> > +       store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
> > +
> > +       trace_event_buffer_commit(&fbuffer);
> > +}
> > +
> > +static void
> > +fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > +                 struct pt_regs *regs)
> > +{
> > +       struct event_file_link *link;
> > +
> > +       trace_probe_for_each_link_rcu(link, &tf->tp)
> > +               __fentry_trace_func(tf, entry_ip, regs, link->file);
> > +}
> > +NOKPROBE_SYMBOL(fentry_trace_func);
> > +
> > +/* Kretprobe handler */
> > +static nokprobe_inline void
> > +__fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > +                  unsigned long ret_ip, struct pt_regs *regs,
> > +                  struct trace_event_file *trace_file)
> > +{
> > +       struct fexit_trace_entry_head *entry;
> > +       struct trace_event_buffer fbuffer;
> > +       struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> > +       int dsize;
> > +
> > +       if (WARN_ON_ONCE(call != trace_file->event_call))
> > +               return;
> > +
> > +       if (trace_trigger_soft_disabled(trace_file))
> > +               return;
> > +
> > +       dsize = __get_data_size(&tf->tp, regs);
> > +
> > +       entry = trace_event_buffer_reserve(&fbuffer, trace_file,
> > +                                          sizeof(*entry) + tf->tp.size + dsize);
> > +       if (!entry)
> > +               return;
> > +
> > +       fbuffer.regs = regs;
> > +       entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
> > +       entry->func = entry_ip;
> > +       entry->ret_ip = ret_ip;
> > +       store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
> > +
> > +       trace_event_buffer_commit(&fbuffer);
> > +}
> > +
> > +static void
> > +fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > +                unsigned long ret_ip, struct pt_regs *regs)
> > +{
> > +       struct event_file_link *link;
> > +
> > +       trace_probe_for_each_link_rcu(link, &tf->tp)
> > +               __fexit_trace_func(tf, entry_ip, ret_ip, regs, link->file);
> > +}
> > +NOKPROBE_SYMBOL(fexit_trace_func);
> > +
> > +#ifdef CONFIG_PERF_EVENTS
> > +
> > +static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > +                           struct pt_regs *regs)
> > +{
> > +       struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> > +       struct fentry_trace_entry_head *entry;
> > +       struct hlist_head *head;
> > +       int size, __size, dsize;
> > +       int rctx;
> > +
> > +       head = this_cpu_ptr(call->perf_events);
> > +       if (hlist_empty(head))
> > +               return 0;
> > +
> > +       dsize = __get_data_size(&tf->tp, regs);
> > +       __size = sizeof(*entry) + tf->tp.size + dsize;
> > +       size = ALIGN(__size + sizeof(u32), sizeof(u64));
> > +       size -= sizeof(u32);
> > +
> > +       entry = perf_trace_buf_alloc(size, NULL, &rctx);
> > +       if (!entry)
> > +               return 0;
> > +
> > +       entry->ip = entry_ip;
> > +       memset(&entry[1], 0, dsize);
> > +       store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
> > +       perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
> 
> However, that call concerns me. Perf requires a pt_regs pointer here
> and it expects certain specific fields of that pt_regs to be set (the
> exact requirements don't seem to be explicitly stated anywhere).
> 
> For example, on arm64 (the architecture without
> CONFIG_DYNAMIC_FTRACE_WITH_REGS on which I'd like to have fprobe...
> :)) perf calls the user_mode(regs) macro which expects the pstate
> register to be set in pt_regs. However, pstate is invalid outside of
> an exception entry so ftrace_regs on arm64 does not have a pstate
> field at all.
> 
> If we migrate fprobe to ftrace_regs and try to construct a sparse
> pt_regs out of a ftrace_regs here, it wouldn't be enough to just copy
> all the registers we know from ftrace_regs into the pt_regs: we would
> also need to make up the pstate register with the knowledge that it
> has to be set in certain way specifically to please perf... Arch code
> wouldn't only have to provide a
> "expand_ftrace_regs_into_sparse_pt_regs" macro but also a
> "invent_registers_for_perf" similar to the current
> perf_arch_fetch_caller_regs macro. This seems rough...
> 
> It sounds to me like we should have avoided the use of sparse and
> "made up" pt_regs a long time back and the more users of fprobe that
> expect pt_regs we add, the more difficult we make it to make fprobe
> work on CONFIG_DYNAMIC_FTRACE_WITH_ARGS.
> 
> > +                             head, NULL);
> > +       return 0;
> > +}
> > +NOKPROBE_SYMBOL(fentry_perf_func);
> > +
> > +static void
> > +fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > +               unsigned long ret_ip, struct pt_regs *regs)
> > +{
> > +       struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> > +       struct fexit_trace_entry_head *entry;
> > +       struct hlist_head *head;
> > +       int size, __size, dsize;
> > +       int rctx;
> > +
> > +       head = this_cpu_ptr(call->perf_events);
> > +       if (hlist_empty(head))
> > +               return;
> > +
> > +       dsize = __get_data_size(&tf->tp, regs);
> > +       __size = sizeof(*entry) + tf->tp.size + dsize;
> > +       size = ALIGN(__size + sizeof(u32), sizeof(u64));
> > +       size -= sizeof(u32);
> > +
> > +       entry = perf_trace_buf_alloc(size, NULL, &rctx);
> > +       if (!entry)
> > +               return;
> > +
> > +       entry->func = entry_ip;
> > +       entry->ret_ip = ret_ip;
> > +       store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
> > +       perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
> > +                             head, NULL);
> > +}
> > +NOKPROBE_SYMBOL(fexit_perf_func);
> > +#endif /* CONFIG_PERF_EVENTS */
> > +
> > +static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
> > +                            unsigned long ret_ip, struct pt_regs *regs,
> > +                            void *entry_data)
> > +{
> > +       struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
> > +       int ret = 0;
> > +
> > +       if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
> > +               fentry_trace_func(tf, entry_ip, regs);
> > +#ifdef CONFIG_PERF_EVENTS
> > +       if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
> > +               ret = fentry_perf_func(tf, entry_ip, regs);
> > +#endif
> > +       return ret;
> > +}
> > +NOKPROBE_SYMBOL(fentry_dispatcher);
> > +
> > +static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
> > +                            unsigned long ret_ip, struct pt_regs *regs,
> > +                            void *entry_data)
> > +{
> > +       struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
> > +
> > +       if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
> > +               fexit_trace_func(tf, entry_ip, ret_ip, regs);
> > +#ifdef CONFIG_PERF_EVENTS
> > +       if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
> > +               fexit_perf_func(tf, entry_ip, ret_ip, regs);
> > +#endif
> > +}
> > +NOKPROBE_SYMBOL(fexit_dispatcher);


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

