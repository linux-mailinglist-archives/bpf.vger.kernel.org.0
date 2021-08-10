Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B9B3E5070
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 02:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbhHJAw5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 20:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhHJAw5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 20:52:57 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F38C0613D3
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 17:52:36 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id b133so33000389ybg.4
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 17:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jds2gKDuAGU0dpcQKmyB4oW/B7Y+QPtbx0R9RM1xaDk=;
        b=hYgkeTsoX0N19Wkm3qtDdKhcLvMKKpOGa5cklPW2jASM5RTOl7/m60gN6vBak1CZqg
         lw0qvpiMbVp6q0kQIgzvqnJNOrW+bTStLH50pVFXg97Q4y13z1Su72sWhE8nAz/uNp0B
         vbBY3Am8ly1DTLeCDLYRThb+ZsFQL0Msly0R7wHM9FY9xn1v4jk1x1Zy69y4qQCIwGj5
         0oCOIlGLuszJXxdMVLMu2S5yMvVvFfinDWGp1XXru30o93KdyuwBCozHJYw2bet8hudC
         t6PrNHTPKUOOkTBkg9ROBrzCokzUWAbxMCzT8shlCCvGW2eJ9fAG65qJY68Z4NUkppxe
         T3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jds2gKDuAGU0dpcQKmyB4oW/B7Y+QPtbx0R9RM1xaDk=;
        b=B8pg446iMyX3+bHseIVlDZzGwHg915TSlJwh/Io2n9Oeq6UdtlqzzAx2i+xcCcE+D5
         1yyecBiE1p3ej9A66repKEvzmM7530UVhdcVB/kl3PaRdzbu/fvNFPiUEQDXVlyT42Ul
         UMhxvqt3rC83W0zKiAW8J6vqwQnhgyTrhaOJ/TNzY0YQsEwiqP4FetWCWeoRqcVJ9yaH
         tFkylPuI6q5Jc3WaJqU3jcaGNXHUBAUBvpSPTXC7VUnxdXKmZPohZqe3+2WmMPABXflF
         2TMH+p0uzwMtkaD1+TT5ENMJ6cnLua73kR284xG2ycNbeprbssPcbVHoEjGSb2Nze9DX
         Mgfg==
X-Gm-Message-State: AOAM531eJeMplcmc2mDb7qNjuP3p32pzU673MS1UKZMcKqlZSXcd4Eu+
        v3TamKDLzqGAPkhiniA+QIlN8ND7JbzCyvhrUJk=
X-Google-Smtp-Source: ABdhPJz5u8q8y+8xbWVTJ3uZkG2UoyUW7S9QO3Jdus38iPvj30C92VJ3NSayBSpf2TsVGXQpKn3zWQKLI1kOUfxnMdQ=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr36274784ybg.347.1628556755345;
 Mon, 09 Aug 2021 17:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210730053413.1090371-1-andrii@kernel.org> <20210730053413.1090371-6-andrii@kernel.org>
 <5e026f3e-d94a-b8b0-8564-e16b73d6bbcc@iogearbox.net>
In-Reply-To: <5e026f3e-d94a-b8b0-8564-e16b73d6bbcc@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 Aug 2021 17:52:24 -0700
Message-ID: <CAEf4BzbOy1Ct4xWBNFXsQq2i3VQ4_T0xecAdSFXGiu7vtuLMqA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/14] bpf: allow to specify user-provided
 bpf_cookie for BPF perf links
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 9, 2021 at 4:30 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 7/30/21 7:34 AM, Andrii Nakryiko wrote:
> > Add ability for users to specify custom u64 value (bpf_cookie) when creating
> > BPF link for perf_event-backed BPF programs (kprobe/uprobe, perf_event,
> > tracepoints).
> >
> > This is useful for cases when the same BPF program is used for attaching and
> > processing invocation of different tracepoints/kprobes/uprobes in a generic
> > fashion, but such that each invocation is distinguished from each other (e.g.,
> > BPF program can look up additional information associated with a specific
> > kernel function without having to rely on function IP lookups). This enables
> > new use cases to be implemented simply and efficiently that previously were
> > possible only through code generation (and thus multiple instances of almost
> > identical BPF program) or compilation at runtime (BCC-style) on target hosts
> > (even more expensive resource-wise). For uprobes it is not even possible in
> > some cases to know function IP before hand (e.g., when attaching to shared
> > library without PID filtering, in which case base load address is not known
> > for a library).
> >
> > This is done by storing u64 bpf_cookie in struct bpf_prog_array_item,
> > corresponding to each attached and run BPF program. Given cgroup BPF programs
> > already use two 8-byte pointers for their needs and cgroup BPF programs don't
> > have (yet?) support for bpf_cookie, reuse that space through union of
> > cgroup_storage and new bpf_cookie field.
> >
> > Make it available to kprobe/tracepoint BPF programs through bpf_trace_run_ctx.
> > This is set by BPF_PROG_RUN_ARRAY, used by kprobe/uprobe/tracepoint BPF
> > program execution code, which luckily is now also split from
> > BPF_PROG_RUN_ARRAY_CG. This run context will be utilized by a new BPF helper
> > giving access to this user-provided cookie value from inside a BPF program.
> > Generic perf_event BPF programs will access this value from perf_event itself
> > through passed in BPF program context.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> [...]
> >
> > +struct bpf_trace_run_ctx {
> > +     struct bpf_run_ctx run_ctx;
> > +     u64 bpf_cookie;
> > +};
> > +
> >   #ifdef CONFIG_BPF_SYSCALL
> >   static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
> >   {
> > @@ -1247,6 +1256,8 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
> >       const struct bpf_prog_array_item *item;
> >       const struct bpf_prog *prog;
> >       const struct bpf_prog_array *array;
> > +     struct bpf_run_ctx *old_run_ctx;
> > +     struct bpf_trace_run_ctx run_ctx;
> >       u32 ret = 1;
> >
> >       migrate_disable();
> > @@ -1254,11 +1265,14 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
> >       array = rcu_dereference(array_rcu);
> >       if (unlikely(!array))
> >               goto out;
> > +     old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> >       item = &array->items[0];
> >       while ((prog = READ_ONCE(item->prog))) {
> > +             run_ctx.bpf_cookie = item->bpf_cookie;
> >               ret &= run_prog(prog, ctx);
> >               item++;
> >       }
> > +     bpf_reset_run_ctx(old_run_ctx);
> >   out:
> >       rcu_read_unlock();
> >       migrate_enable();
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 2d510ad750ed..fe156a8170aa 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -762,6 +762,7 @@ struct perf_event {
> >   #ifdef CONFIG_BPF_SYSCALL
> >       perf_overflow_handler_t         orig_overflow_handler;
> >       struct bpf_prog                 *prog;
> > +     u64                             bpf_cookie;
> >   #endif
> >
> >   #ifdef CONFIG_EVENT_TRACING
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index 8ac92560d3a3..8e0631a4b046 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -675,7 +675,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
> >
> >   #ifdef CONFIG_BPF_EVENTS
> >   unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
> > -int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
> > +int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
> >   void perf_event_detach_bpf_prog(struct perf_event *event);
> >   int perf_event_query_prog_array(struct perf_event *event, void __user *info);
> >   int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
> > @@ -692,7 +692,7 @@ static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *c
> >   }
> >
> >   static inline int
> > -perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
> > +perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie)
> >   {
> >       return -EOPNOTSUPP;
> >   }
> > @@ -803,7 +803,7 @@ extern void ftrace_profile_free_filter(struct perf_event *event);
> >   void perf_trace_buf_update(void *record, u16 type);
> >   void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
> >
> > -int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
> > +int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
> >   void perf_event_free_bpf_prog(struct perf_event *event);
> >
> >   void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 94fe8329b28f..63ee482d50e1 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1448,6 +1448,13 @@ union bpf_attr {
> >                               __aligned_u64   iter_info;      /* extra bpf_iter_link_info */
> >                               __u32           iter_info_len;  /* iter_info length */
> >                       };
> > +                     struct {
> > +                             /* black box user-provided value passed through
> > +                              * to BPF program at the execution time and
> > +                              * accessible through bpf_get_attach_cookie() BPF helper
> > +                              */
> > +                             __u64           bpf_cookie;
>
>  From API PoV, should we just name this link_id to avoid confusion around gen_cookie_next()

I'd like to avoid the "id" connotations, as it doesn't have to be
ID-like at all. It can be duplicated across multiple
links/attachments, it could be random, it could be sequential, it
could be hash, whatever. I started originally with "user value" name
for the concept, switching to "user context" before submitting v1. And
then Peter proposed "cookie" terminology and it clicked, because
that's how custom user-provided value is often called when passed back
to user-provided callback. I agree about possible confusion with
socket and netns cookie, but ultimately there are only so many
different words we can use :) I think link_id itself is super
confusing as well, as there is BPF link ID (similar to prog ID and map
ID), which means a completely different thing, yet applies to the same
BPF link object.

> users? Do we expect other link types to implement similar mechanism? I'd think probably yes
> if the prog would be common and e.g. do htab lookups based on that opaque value.

Yes, you are right. I intend to add it at least to fentry/fexit
programs, but ultimately any type of program and its attachment might
benefit (e.g., BPF iterator is a pretty good candidate as well). In
practice, I'd try to use array to pass extra info, but hashmap is also
an option, of course.

>
> Is the 8b chosen given function IP fits, or is there a different rationale size-wise? Should
> this be of dynamic size to be more future proof, e.g. hidden map like in prog's global sections
> that libbpf sets up / prepopulates internally, but tied to link object instead?

See my previous reply to Yonghong about this ([0]). 4 bytes probably
would be workable in most cases, but felt like unnecessary economy,
given we are still going to use full 8 bytes in prog_array_item and
the likes. But I also explicitly don't want an arbitrary sized
"storage", that's not necessary. Users are free to handle extra
storage on their own and use this cookie value as an index/key into
that extra storage. So far I always used an ARRAY map for this, it's
actually very easy for user-space to do this efficiently, based on a
specific problem it is solving. I feel like adding libbpf conventions
with some hidden map just adds lots of complexity without adding much
value. Sometimes it has to be dynamically-sized BPF_MAP_TYPE_ARRAY,
but often it's enough to have a global variable (struct my_config
configs[MAX_CONFIG_CNT]), and in some other cases we don't even need a
storage at all.


  [0] https://lore.kernel.org/bpf/CAEf4BzY2fVJN5CEdWDDNkWQ9En4N6Rynnnzj7hTnWG65BqdusQ@mail.gmail.com/


>
> > +                     } perf_event;
> >               };
> >       } link_create;
> >
> Thanks,
> Daniel
