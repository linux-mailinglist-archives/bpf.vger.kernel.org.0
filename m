Return-Path: <bpf+bounces-1336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50D1712DB7
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 21:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802021C210F0
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 19:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF302911E;
	Fri, 26 May 2023 19:38:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374F24E96
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 19:38:59 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2060D9
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 12:38:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d247a023aso1044810b3a.2
        for <bpf@vger.kernel.org>; Fri, 26 May 2023 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685129936; x=1687721936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3l6Kc6vQODAomS0iGUGAjcuJW922K8qw6M+SstzYSLs=;
        b=HqvyLVRChHY3UO8I6ghrU2ML9KBgDNomZbZjuwNSTA9BvoMjromMxp9n6dwORJakCz
         z2Pkm4LCDMzJ7B6YVLT4W8an4Ty4BmZ0ESX5JjC43Az2pQB+5oKIYqUO9EBS+N+Er18z
         ke+3W0QM0dkP2QvYJQAbkH9crR4+9PP6CrZJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129936; x=1687721936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3l6Kc6vQODAomS0iGUGAjcuJW922K8qw6M+SstzYSLs=;
        b=ZvB95sgDFXln6zNh3J3JWs6iTFUOOUdpkYf73P9IP5R4VBLtlWwstJngVTa/1EyWIh
         VDf1WbBrXG5GVcH95CnDaypPD4HX0Eo6qLVcEdC3KzCkCkVBRGbsv0jJaB+VQ8GfVBEB
         pW+spbBkyAL+8r6fnPY/L3Qn/NmVVYATHaqNNaJm0dzLUy+1Nx+I92xASCSne5ZLcCBZ
         Lcs7N42Zr9dRo3LNyk1yabrLyn5A84HUm+YdMFula7Ip7Vq13T00HfylJBU/bKjPrEHp
         rGUCExxpajRTHfO3i3IhMI+ijK28ir1XUp5WglWNgLlV9BCJNVUptTF/qp8CTvyABqEL
         exTQ==
X-Gm-Message-State: AC+VfDzimTlJ5BnIoNQZWyjhPGDHeE8IX4IFaGHhiTqps4EHyoBL+7tN
	UkS5Qv3Ec6wVsiqpWwSzAPRfRndkw8ngFn9Xo6t6HA==
X-Google-Smtp-Source: ACHHUZ4a3DwDVo1a2lffMB8xS+rLpDuciOpZ4QgklcuYp793xpHxyggusOC2rmudD1Qv2LRnN6QGHgMaGqIfTrxrvC8=
X-Received: by 2002:a05:6a20:8e0b:b0:105:94e5:f5c2 with SMTP id
 y11-20020a056a208e0b00b0010594e5f5c2mr661415pzj.13.1685129936293; Fri, 26 May
 2023 12:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
 <168507469754.913472.6112857614708350210.stgit@mhiramat.roam.corp.google.com>
In-Reply-To: <168507469754.913472.6112857614708350210.stgit@mhiramat.roam.corp.google.com>
From: Florent Revest <revest@chromium.org>
Date: Fri, 26 May 2023 21:38:44 +0200
Message-ID: <CABRcYm+esb8J2O1v6=C+h+HSa5NxraPUgo63w7-iZj0CXbpusg@mail.gmail.com>
Subject: Re: [PATCH v13 03/12] tracing/probes: Add fprobe events for tracing
 function entry and exit.
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 26, 2023 at 6:18=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> [...] Since
> CONFIG_KPROBES_ON_FTRACE requires the CONFIG_DYNAMIC_FTRACE_WITH_REGS,
> it is not available if the architecture only supports
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS. And that means kprobe events can not
> probe function entry/exit effectively on such architecture.
> But this can be solved if the dynamic events supports fprobe events.

Currently CONFIG_FPROBE also requires CONFIG_DYNAMIC_FTRACE_WITH_REGS
so iiuc this will only be true when we'll have migrated fprobe to use
ftrace_regs instead of pt_regs right ?

We discussed having fprobe use ftrace_regs instead of pt_regs in the
past and I even had a proof of concept branch at one point but this
patch seems to make this transition quite a bit harder. Have you tried
to make fprobe work on ftrace_regs on top of this patch ?

> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> new file mode 100644
> index 000000000000..48dbbc72b7dd
> --- /dev/null
> +++ b/kernel/trace/trace_fprobe.c
> @@ -0,0 +1,1053 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Fprobe-based tracing events
> + * Copyright (C) 2022 Google LLC.
> + */
> +#define pr_fmt(fmt)    "trace_fprobe: " fmt
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
> +                       int argc, const char **argv, struct dyn_event *ev=
);
> +
> +static struct dyn_event_operations trace_fprobe_ops =3D {
> +       .create =3D trace_fprobe_create,
> +       .show =3D trace_fprobe_show,
> +       .is_busy =3D trace_fprobe_is_busy,
> +       .free =3D trace_fprobe_release,
> +       .match =3D trace_fprobe_match,
> +};
> +
> +/*
> + * Fprobe event core functions
> + */
> +struct trace_fprobe {
> +       struct dyn_event        devent;
> +       struct fprobe           fp;
> +       const char              *symbol;
> +       struct trace_probe      tp;
> +};
> +
> +static bool is_trace_fprobe(struct dyn_event *ev)
> +{
> +       return ev->ops =3D=3D &trace_fprobe_ops;
> +}
> +
> +static struct trace_fprobe *to_trace_fprobe(struct dyn_event *ev)
> +{
> +       return container_of(ev, struct trace_fprobe, devent);
> +}
> +
> +/**
> + * for_each_trace_fprobe - iterate over the trace_fprobe list
> + * @pos:       the struct trace_fprobe * for each entry
> + * @dpos:      the struct dyn_event * to use as a loop cursor
> + */
> +#define for_each_trace_fprobe(pos, dpos)       \
> +       for_each_dyn_event(dpos)                \
> +               if (is_trace_fprobe(dpos) && (pos =3D to_trace_fprobe(dpo=
s)))
> +
> +static bool trace_fprobe_is_return(struct trace_fprobe *tf)
> +{
> +       return tf->fp.exit_handler !=3D NULL;
> +}
> +
> +static const char *trace_fprobe_symbol(struct trace_fprobe *tf)
> +{
> +       return tf->symbol ? tf->symbol : "unknown";
> +}
> +
> +static bool trace_fprobe_is_busy(struct dyn_event *ev)
> +{
> +       struct trace_fprobe *tf =3D to_trace_fprobe(ev);
> +
> +       return trace_probe_is_enabled(&tf->tp);
> +}
> +
> +static bool trace_fprobe_match_command_head(struct trace_fprobe *tf,
> +                                           int argc, const char **argv)
> +{
> +       char buf[MAX_ARGSTR_LEN + 1];
> +
> +       if (!argc)
> +               return true;
> +
> +       snprintf(buf, sizeof(buf), "%s", trace_fprobe_symbol(tf));
> +       if (strcmp(buf, argv[0]))
> +               return false;
> +       argc--; argv++;
> +
> +       return trace_probe_match_command_args(&tf->tp, argc, argv);
> +}
> +
> +static bool trace_fprobe_match(const char *system, const char *event,
> +                       int argc, const char **argv, struct dyn_event *ev=
)
> +{
> +       struct trace_fprobe *tf =3D to_trace_fprobe(ev);
> +
> +       if (event[0] !=3D '\0' && strcmp(trace_probe_name(&tf->tp), event=
))
> +               return false;
> +
> +       if (system && strcmp(trace_probe_group_name(&tf->tp), system))
> +               return false;
> +
> +       return trace_fprobe_match_command_head(tf, argc, argv);
> +}
> +
> +static bool trace_fprobe_is_registered(struct trace_fprobe *tf)
> +{
> +       return fprobe_is_registered(&tf->fp);
> +}
> +
> +/*
> + * Note that we don't verify the fetch_insn code, since it does not come
> + * from user space.
> + */
> +static int
> +process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
> +                  void *base)
> +{
> +       struct pt_regs *regs =3D rec;

I gave it a try this week and it was mostly a matter of replacing
pt_regs with ftrace_regs in this file. Like here for example. Not too
bad so far.

> +       unsigned long val;
> +       int ret;
> +
> +retry:
> +       /* 1st stage: get value from context */
> +       switch (code->op) {
> +       case FETCH_OP_STACK:
> +               val =3D regs_get_kernel_stack_nth(regs, code->param);

This does not have a ftrace_regs equivalent at the moment. I suppose
we could introduce one without too much effort so that's probably ok.

> +               break;
> +       case FETCH_OP_STACKP:
> +               val =3D kernel_stack_pointer(regs);
> +               break;
> +       case FETCH_OP_RETVAL:
> +               val =3D regs_return_value(regs);
> +               break;
> +#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> +       case FETCH_OP_ARG:
> +               val =3D regs_get_kernel_argument(regs, code->param);
> +               break;
> +#endif
> +       case FETCH_NOP_SYMBOL:  /* Ignore a place holder */
> +               code++;
> +               goto retry;
> +       default:
> +               ret =3D process_common_fetch_insn(code, &val);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +       code++;
> +
> +       return process_fetch_insn_bottom(code, val, dest, base);
> +}
> +NOKPROBE_SYMBOL(process_fetch_insn)
> +
> +/* function entry handler */
> +static nokprobe_inline void
> +__fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
> +                   struct pt_regs *regs,
> +                   struct trace_event_file *trace_file)
> +{
> +       struct fentry_trace_entry_head *entry;
> +       struct trace_event_call *call =3D trace_probe_event_call(&tf->tp)=
;
> +       struct trace_event_buffer fbuffer;
> +       int dsize;
> +
> +       if (WARN_ON_ONCE(call !=3D trace_file->event_call))
> +               return;
> +
> +       if (trace_trigger_soft_disabled(trace_file))
> +               return;
> +
> +       dsize =3D __get_data_size(&tf->tp, regs);
> +
> +       entry =3D trace_event_buffer_reserve(&fbuffer, trace_file,
> +                                          sizeof(*entry) + tf->tp.size +=
 dsize);
> +       if (!entry)
> +               return;
> +
> +       fbuffer.regs =3D regs;
> +       entry =3D fbuffer.entry =3D ring_buffer_event_data(fbuffer.event)=
;
> +       entry->ip =3D entry_ip;
> +       store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize)=
;
> +
> +       trace_event_buffer_commit(&fbuffer);
> +}
> +
> +static void
> +fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
> +                 struct pt_regs *regs)
> +{
> +       struct event_file_link *link;
> +
> +       trace_probe_for_each_link_rcu(link, &tf->tp)
> +               __fentry_trace_func(tf, entry_ip, regs, link->file);
> +}
> +NOKPROBE_SYMBOL(fentry_trace_func);
> +
> +/* Kretprobe handler */
> +static nokprobe_inline void
> +__fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
> +                  unsigned long ret_ip, struct pt_regs *regs,
> +                  struct trace_event_file *trace_file)
> +{
> +       struct fexit_trace_entry_head *entry;
> +       struct trace_event_buffer fbuffer;
> +       struct trace_event_call *call =3D trace_probe_event_call(&tf->tp)=
;
> +       int dsize;
> +
> +       if (WARN_ON_ONCE(call !=3D trace_file->event_call))
> +               return;
> +
> +       if (trace_trigger_soft_disabled(trace_file))
> +               return;
> +
> +       dsize =3D __get_data_size(&tf->tp, regs);
> +
> +       entry =3D trace_event_buffer_reserve(&fbuffer, trace_file,
> +                                          sizeof(*entry) + tf->tp.size +=
 dsize);
> +       if (!entry)
> +               return;
> +
> +       fbuffer.regs =3D regs;
> +       entry =3D fbuffer.entry =3D ring_buffer_event_data(fbuffer.event)=
;
> +       entry->func =3D entry_ip;
> +       entry->ret_ip =3D ret_ip;
> +       store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize)=
;
> +
> +       trace_event_buffer_commit(&fbuffer);
> +}
> +
> +static void
> +fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
> +                unsigned long ret_ip, struct pt_regs *regs)
> +{
> +       struct event_file_link *link;
> +
> +       trace_probe_for_each_link_rcu(link, &tf->tp)
> +               __fexit_trace_func(tf, entry_ip, ret_ip, regs, link->file=
);
> +}
> +NOKPROBE_SYMBOL(fexit_trace_func);
> +
> +#ifdef CONFIG_PERF_EVENTS
> +
> +static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry=
_ip,
> +                           struct pt_regs *regs)
> +{
> +       struct trace_event_call *call =3D trace_probe_event_call(&tf->tp)=
;
> +       struct fentry_trace_entry_head *entry;
> +       struct hlist_head *head;
> +       int size, __size, dsize;
> +       int rctx;
> +
> +       head =3D this_cpu_ptr(call->perf_events);
> +       if (hlist_empty(head))
> +               return 0;
> +
> +       dsize =3D __get_data_size(&tf->tp, regs);
> +       __size =3D sizeof(*entry) + tf->tp.size + dsize;
> +       size =3D ALIGN(__size + sizeof(u32), sizeof(u64));
> +       size -=3D sizeof(u32);
> +
> +       entry =3D perf_trace_buf_alloc(size, NULL, &rctx);
> +       if (!entry)
> +               return 0;
> +
> +       entry->ip =3D entry_ip;
> +       memset(&entry[1], 0, dsize);
> +       store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize)=
;
> +       perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, reg=
s,

However, that call concerns me. Perf requires a pt_regs pointer here
and it expects certain specific fields of that pt_regs to be set (the
exact requirements don't seem to be explicitly stated anywhere).

For example, on arm64 (the architecture without
CONFIG_DYNAMIC_FTRACE_WITH_REGS on which I'd like to have fprobe...
:)) perf calls the user_mode(regs) macro which expects the pstate
register to be set in pt_regs. However, pstate is invalid outside of
an exception entry so ftrace_regs on arm64 does not have a pstate
field at all.

If we migrate fprobe to ftrace_regs and try to construct a sparse
pt_regs out of a ftrace_regs here, it wouldn't be enough to just copy
all the registers we know from ftrace_regs into the pt_regs: we would
also need to make up the pstate register with the knowledge that it
has to be set in certain way specifically to please perf... Arch code
wouldn't only have to provide a
"expand_ftrace_regs_into_sparse_pt_regs" macro but also a
"invent_registers_for_perf" similar to the current
perf_arch_fetch_caller_regs macro. This seems rough...

It sounds to me like we should have avoided the use of sparse and
"made up" pt_regs a long time back and the more users of fprobe that
expect pt_regs we add, the more difficult we make it to make fprobe
work on CONFIG_DYNAMIC_FTRACE_WITH_ARGS.

> +                             head, NULL);
> +       return 0;
> +}
> +NOKPROBE_SYMBOL(fentry_perf_func);
> +
> +static void
> +fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> +               unsigned long ret_ip, struct pt_regs *regs)
> +{
> +       struct trace_event_call *call =3D trace_probe_event_call(&tf->tp)=
;
> +       struct fexit_trace_entry_head *entry;
> +       struct hlist_head *head;
> +       int size, __size, dsize;
> +       int rctx;
> +
> +       head =3D this_cpu_ptr(call->perf_events);
> +       if (hlist_empty(head))
> +               return;
> +
> +       dsize =3D __get_data_size(&tf->tp, regs);
> +       __size =3D sizeof(*entry) + tf->tp.size + dsize;
> +       size =3D ALIGN(__size + sizeof(u32), sizeof(u64));
> +       size -=3D sizeof(u32);
> +
> +       entry =3D perf_trace_buf_alloc(size, NULL, &rctx);
> +       if (!entry)
> +               return;
> +
> +       entry->func =3D entry_ip;
> +       entry->ret_ip =3D ret_ip;
> +       store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize)=
;
> +       perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, reg=
s,
> +                             head, NULL);
> +}
> +NOKPROBE_SYMBOL(fexit_perf_func);
> +#endif /* CONFIG_PERF_EVENTS */
> +
> +static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
> +                            unsigned long ret_ip, struct pt_regs *regs,
> +                            void *entry_data)
> +{
> +       struct trace_fprobe *tf =3D container_of(fp, struct trace_fprobe,=
 fp);
> +       int ret =3D 0;
> +
> +       if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
> +               fentry_trace_func(tf, entry_ip, regs);
> +#ifdef CONFIG_PERF_EVENTS
> +       if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
> +               ret =3D fentry_perf_func(tf, entry_ip, regs);
> +#endif
> +       return ret;
> +}
> +NOKPROBE_SYMBOL(fentry_dispatcher);
> +
> +static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
> +                            unsigned long ret_ip, struct pt_regs *regs,
> +                            void *entry_data)
> +{
> +       struct trace_fprobe *tf =3D container_of(fp, struct trace_fprobe,=
 fp);
> +
> +       if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
> +               fexit_trace_func(tf, entry_ip, ret_ip, regs);
> +#ifdef CONFIG_PERF_EVENTS
> +       if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
> +               fexit_perf_func(tf, entry_ip, ret_ip, regs);
> +#endif
> +}
> +NOKPROBE_SYMBOL(fexit_dispatcher);

