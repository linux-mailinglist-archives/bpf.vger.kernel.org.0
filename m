Return-Path: <bpf+bounces-126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D5D6F8677
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 18:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9741C2191D
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954BCC2FB;
	Fri,  5 May 2023 16:12:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA28BE0
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 16:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073E9C433EF;
	Fri,  5 May 2023 16:12:13 +0000 (UTC)
Date: Fri, 5 May 2023 12:12:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v9.1 02/11] tracing/probes: Add fprobe events for
 tracing function entry and exit.
Message-ID: <20230505121212.7569c9b9@gandalf.local.home>
In-Reply-To: <168299385687.3242086.18384268741128867952.stgit@mhiramat.roam.corp.google.com>
References: <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
	<168299385687.3242086.18384268741128867952.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 May 2023 11:17:36 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> new file mode 100644
> index 000000000000..0049d9ef2402
> --- /dev/null
> +++ b/kernel/trace/trace_fprobe.c
> @@ -0,0 +1,1053 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Fprobe-based tracing events
> + * Copyright (C) 2022 Google LLC.
> + */
> +#define pr_fmt(fmt)	"trace_fprobe: " fmt
> +
> +#include <linux/fprobe.h>
> +#include <linux/module.h>
> +#include <linux/rculist.h>
> +#include <linux/security.h>
> +#include <linux/uaccess.h>
> +
> +#include "trace_dynevent.h"
> +#include "trace_probe.h"
> +#include "trace_probe_kernel.h"
> +#include "trace_probe_tmpl.h"
> +
> +#define FPROBE_EVENT_SYSTEM "fprobes"
> +#define RETHOOK_MAXACTIVE_MAX 4096
> +
> +static int trace_fprobe_create(const char *raw_command);
> +static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev);
> +static int trace_fprobe_release(struct dyn_event *ev);
> +static bool trace_fprobe_is_busy(struct dyn_event *ev);
> +static bool trace_fprobe_match(const char *system, const char *event,
> +			int argc, const char **argv, struct dyn_event *ev);
> +
> +static struct dyn_event_operations trace_fprobe_ops = {
> +	.create = trace_fprobe_create,
> +	.show = trace_fprobe_show,
> +	.is_busy = trace_fprobe_is_busy,
> +	.free = trace_fprobe_release,
> +	.match = trace_fprobe_match,
> +};
> +
> +/*
> + * Fprobe event core functions
> + */
> +struct trace_fprobe {
> +	struct dyn_event	devent;
> +	struct fprobe		fp;
> +	const char		*symbol;
> +	struct trace_probe	tp;
> +};
> +
> +static bool is_trace_fprobe(struct dyn_event *ev)
> +{
> +	return ev->ops == &trace_fprobe_ops;
> +}
> +
> +static struct trace_fprobe *to_trace_fprobe(struct dyn_event *ev)
> +{
> +	return container_of(ev, struct trace_fprobe, devent);
> +}
> +
> +/**
> + * for_each_trace_fprobe - iterate over the trace_fprobe list
> + * @pos:	the struct trace_fprobe * for each entry
> + * @dpos:	the struct dyn_event * to use as a loop cursor
> + */
> +#define for_each_trace_fprobe(pos, dpos)	\
> +	for_each_dyn_event(dpos)		\
> +		if (is_trace_fprobe(dpos) && (pos = to_trace_fprobe(dpos)))
> +
> +static bool trace_fprobe_is_return(struct trace_fprobe *tf)
> +{
> +	return tf->fp.exit_handler != NULL;
> +}
> +
> +static const char *trace_fprobe_symbol(struct trace_fprobe *tf)
> +{
> +	return tf->symbol ? tf->symbol : "unknown";
> +}
> +
> +static bool trace_fprobe_is_busy(struct dyn_event *ev)
> +{
> +	struct trace_fprobe *tf = to_trace_fprobe(ev);
> +
> +	return trace_probe_is_enabled(&tf->tp);
> +}
> +
> +static bool trace_fprobe_match_command_head(struct trace_fprobe *tf,
> +					    int argc, const char **argv)
> +{
> +	char buf[MAX_ARGSTR_LEN + 1];
> +
> +	if (!argc)
> +		return true;
> +
> +	snprintf(buf, sizeof(buf), "%s", trace_fprobe_symbol(tf));
> +	if (strcmp(buf, argv[0]))
> +		return false;
> +	argc--; argv++;
> +
> +	return trace_probe_match_command_args(&tf->tp, argc, argv);
> +}
> +
> +static bool trace_fprobe_match(const char *system, const char *event,
> +			int argc, const char **argv, struct dyn_event *ev)
> +{
> +	struct trace_fprobe *tf = to_trace_fprobe(ev);
> +
> +	return (event[0] == '\0' ||
> +		strcmp(trace_probe_name(&tf->tp), event) == 0) &&
> +	    (!system || strcmp(trace_probe_group_name(&tf->tp), system) == 0) &&
> +	    trace_fprobe_match_command_head(tf, argc, argv);

The above is really hard to read, and Linus hates these kinds of
statements. Please break it up (the compiler should do the right thing).

Reversing the tests to return false:

	if (event[0] != '\0' &&
	    strcmp(trace_probe_name(&tf->tp), event) != 0))
		return false;

	if (system && strcmp(trace_probe_group_name(&tf->tp), system) != 0))
		return false;

	return trace_fprobe_match_command_head(tf, argc, argv);


> +}
> +
> +static bool trace_fprobe_is_registered(struct trace_fprobe *tf)
> +{
> +	return fprobe_is_registered(&tf->fp);
> +}
> +
> +/* Note that we don't verify it, since the code does not come from user space */

Verify what?

Hmm, I see this is a copy of the comment from both trace_kprobe.c and
trace_uprobe.c. I think this requires a bit more explanation (and also in
those locations as well).

> +static int
> +process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
> +		   void *base)
> +{
> +	struct pt_regs *regs = rec;
> +	unsigned long val;
> +
> +retry:
> +	/* 1st stage: get value from context */
> +	switch (code->op) {
> +	case FETCH_OP_REG:
> +		val = regs_get_register(regs, code->param);
> +		break;
> +	case FETCH_OP_STACK:
> +		val = regs_get_kernel_stack_nth(regs, code->param);
> +		break;
> +	case FETCH_OP_STACKP:
> +		val = kernel_stack_pointer(regs);
> +		break;
> +	case FETCH_OP_RETVAL:
> +		val = regs_return_value(regs);
> +		break;


> +	case FETCH_OP_IMM:
> +		val = code->immediate;
> +		break;
> +	case FETCH_OP_COMM:
> +		val = (unsigned long)current->comm;
> +		break;
> +	case FETCH_OP_DATA:
> +		val = (unsigned long)code->data;
> +		break;

These are new and not part of trace_kprobe.c. Should we have a version that
the two could share?

Probably a helper function that can be called by these two.

> +#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> +	case FETCH_OP_ARG:
> +		val = regs_get_kernel_argument(regs, code->param);
> +		break;
> +#endif
> +	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
> +		code++;
> +		goto retry;
> +	default:
> +		return -EILSEQ;
> +	}
> +	code++;
> +
> +	return process_fetch_insn_bottom(code, val, dest, base);
> +}
> +NOKPROBE_SYMBOL(process_fetch_insn)
> +
> +/* function entry handler */
> +static nokprobe_inline void
> +__fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
> +		    struct pt_regs *regs,
> +		    struct trace_event_file *trace_file)
> +{
> +	struct fentry_trace_entry_head *entry;
> +	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> +	struct trace_event_buffer fbuffer;
> +	int dsize;
> +
> +	WARN_ON(call != trace_file->event_call);

 WARN_ON_ONCE()?

And if you are doing the check, perhaps even:

	if (WARN_ON_ONCE(call != trace_file->event_call))
		return;

-- Steve

> +
> +	if (trace_trigger_soft_disabled(trace_file))
> +		return;
> +
> +	dsize = __get_data_size(&tf->tp, regs);
> +
> +	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
> +					   sizeof(*entry) + tf->tp.size + dsize);
> +	if (!entry)
> +		return;
> +
> +	fbuffer.regs = regs;
> +	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
> +	entry->ip = entry_ip;
> +	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
> +
> +	trace_event_buffer_commit(&fbuffer);
> +}
> +

