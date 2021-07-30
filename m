Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B543DB22B
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 06:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhG3EQb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 00:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhG3EQa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 00:16:30 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41685C061799
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 21:16:21 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id a93so13817457ybi.1
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 21:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVjXW3adP72vmVWYxyqVezS73ajEOyd8TzW5S554rao=;
        b=HAYYMJeRuHGEE/30M7hctiVUA+ztvNaDt0l/cpgunr9WlQKGNleG/LYZgjb9iFO1vw
         SBx0x5vLPv3WRIavHx/NwsSnS1dD6wJcVclmV5IQKa4gkExezQyd5xSyyQHETA1WeqoS
         4PV7vqczSsSZSTPM11uJ4+OReJKKDezP9Mlb2UAMgaxLV0Ty+8Fe1ZoUrr2MVQC1Zx0x
         XM0/PPJGfPtLK+DItvxNlRBmNVwq/56C+1mst30JZKFmE1rhbCfladI1hF3qkN4I5NwZ
         Ppkr6qRTiiIP8wOtWXWqk0vszM6lrei1tKUR5Jn8qDVfyATP92TE14B8aS7JQsDPrBrj
         QS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVjXW3adP72vmVWYxyqVezS73ajEOyd8TzW5S554rao=;
        b=htTb9t2HB+V+aok2BGYSPAaP+yvw+P3XQg+qDzNubeu5m6WahELB6BxdqXFniRef9H
         E/6DICmoRJnuo+F2qZgIdMAR9pHE/0kYgXN6xcy4upt26fUkHVMyksYt0PqzcpfERgHM
         m07Lw/D8gQQgZ4LUJo+B5bbrIaf7pJPQv4yUMMq3oec/yybNamLwexgcOP23x4D6KzuC
         CdfXsUxjf4Zwff6z9sYGG3BAgYdEF/5f4K32LV9i/gI61+Zc/Mi6M2BqLqhTR7//bXIg
         o/b9MjAZvHnFq3yRPoI2nLJBdM/A0GEvnHZFcY2qJ4WuN9MUBnjXeMbOyCy7KfyJ8wZX
         mBSA==
X-Gm-Message-State: AOAM532zYfGvFKN93/j0za50WG+uZEQcSGOKcUQLUdCeOSLeEbzon3QY
        QlWpqcNOERvvv1k9D3BbOcZzNFaglK7SeFjqxyM=
X-Google-Smtp-Source: ABdhPJwdJYMiPrmqV+fEiWE6QOwavEb0BL3xv0V83uX4HK2fsDw9ZznqVfRCZangSyWr3R29sCDysNlz9GyyAKTf0gw=
X-Received: by 2002:a25:b741:: with SMTP id e1mr621794ybm.347.1627618580522;
 Thu, 29 Jul 2021 21:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210726161211.925206-1-andrii@kernel.org> <20210726161211.925206-5-andrii@kernel.org>
 <6b61514f-3ab8-34bd-539f-e5ff8d769e77@fb.com>
In-Reply-To: <6b61514f-3ab8-34bd-539f-e5ff8d769e77@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Jul 2021 21:16:09 -0700
Message-ID: <CAEf4BzYah9zEKiwygK_4=fqOWF7rDOXu3RH_7GLDYwn7Y7sR2A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/14] bpf: implement minimal BPF perf link
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 29, 2021 at 10:36 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/26/21 9:12 AM, Andrii Nakryiko wrote:
> > Introduce a new type of BPF link - BPF perf link. This brings perf_event-based
> > BPF program attachments (perf_event, tracepoints, kprobes, and uprobes) into
> > the common BPF link infrastructure, allowing to list all active perf_event
> > based attachments, auto-detaching BPF program from perf_event when link's FD
> > is closed, get generic BPF link fdinfo/get_info functionality.
> >
> > BPF_LINK_CREATE command expects perf_event's FD as target_fd. No extra flags
> > are currently supported.
> >
> > Force-detaching and atomic BPF program updates are not yet implemented, but
> > with perf_event-based BPF links we now have common framework for this without
> > the need to extend ioctl()-based perf_event interface.
> >
> > One interesting consideration is a new value for bpf_attach_type, which
> > BPF_LINK_CREATE command expects. Generally, it's either 1-to-1 mapping from
> > bpf_attach_type to bpf_prog_type, or many-to-1 mapping from a subset of
> > bpf_attach_types to one bpf_prog_type (e.g., see BPF_PROG_TYPE_SK_SKB or
> > BPF_PROG_TYPE_CGROUP_SOCK). In this case, though, we have three different
> > program types (KPROBE, TRACEPOINT, PERF_EVENT) using the same perf_event-based
> > mechanism, so it's many bpf_prog_types to one bpf_attach_type. I chose to
> > define a single BPF_PERF_EVENT attach type for all of them and adjust
> > link_create()'s logic for checking correspondence between attach type and
> > program type.
> >
> > The alternative would be to define three new attach types (e.g., BPF_KPROBE,
> > BPF_TRACEPOINT, and BPF_PERF_EVENT), but that seemed like unnecessary overkill
> > and BPF_KPROBE will cause naming conflicts with BPF_KPROBE() macro, defined by
> > libbpf. I chose to not do this to avoid unnecessary proliferation of
> > bpf_attach_type enum values and not have to deal with naming conflicts.
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   include/linux/bpf_types.h      |   3 +
> >   include/linux/trace_events.h   |   3 +
> >   include/uapi/linux/bpf.h       |   2 +
> >   kernel/bpf/syscall.c           | 105 ++++++++++++++++++++++++++++++---
> >   kernel/events/core.c           |  10 ++--
> >   tools/include/uapi/linux/bpf.h |   2 +
> >   6 files changed, 112 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > index a9db1eae6796..0a1ada7f174d 100644
> > --- a/include/linux/bpf_types.h
> > +++ b/include/linux/bpf_types.h
> > @@ -135,3 +135,6 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
> >   #ifdef CONFIG_NET
> >   BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
> >   #endif
> > +#ifdef CONFIG_PERF_EVENTS
> > +BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
> > +#endif
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index ad413b382a3c..8ac92560d3a3 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -803,6 +803,9 @@ extern void ftrace_profile_free_filter(struct perf_event *event);
> >   void perf_trace_buf_update(void *record, u16 type);
> >   void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
> >
> > +int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
> > +void perf_event_free_bpf_prog(struct perf_event *event);
> > +
> >   void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
> >   void bpf_trace_run2(struct bpf_prog *prog, u64 arg1, u64 arg2);
> >   void bpf_trace_run3(struct bpf_prog *prog, u64 arg1, u64 arg2,
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 2db6925e04f4..00b1267ab4f0 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -993,6 +993,7 @@ enum bpf_attach_type {
> >       BPF_SK_SKB_VERDICT,
> >       BPF_SK_REUSEPORT_SELECT,
> >       BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,
> > +     BPF_PERF_EVENT,
> >       __MAX_BPF_ATTACH_TYPE
> >   };
> >
> > @@ -1006,6 +1007,7 @@ enum bpf_link_type {
> >       BPF_LINK_TYPE_ITER = 4,
> >       BPF_LINK_TYPE_NETNS = 5,
> >       BPF_LINK_TYPE_XDP = 6,
> > +     BPF_LINK_TYPE_PERF_EVENT = 6,
>
> As Jiri has pointed out, BPF_LINK_TYPE_PERF_EVENT = 7.

yep, fixed

>
> >
> >       MAX_BPF_LINK_TYPE,
> >   };
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 9a2068e39d23..80c03bedd6e6 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2906,6 +2906,79 @@ static const struct bpf_link_ops bpf_raw_tp_link_lops = {
> >       .fill_link_info = bpf_raw_tp_link_fill_link_info,
> >   };
> >
> > +#ifdef CONFIG_PERF_EVENTS
> > +struct bpf_perf_link {
> > +     struct bpf_link link;
> > +     struct file *perf_file;
> > +};
> > +
> > +static void bpf_perf_link_release(struct bpf_link *link)
> > +{
> > +     struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
> > +     struct perf_event *event = perf_link->perf_file->private_data;
> > +
> > +     perf_event_free_bpf_prog(event);
> > +     fput(perf_link->perf_file);
> > +}
> > +
> > +static void bpf_perf_link_dealloc(struct bpf_link *link)
> > +{
> > +     struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
> > +
> > +     kfree(perf_link);
> > +}
> > +
> > +static const struct bpf_link_ops bpf_perf_link_lops = {
> > +     .release = bpf_perf_link_release,
> > +     .dealloc = bpf_perf_link_dealloc,
> > +};
> > +
> > +static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> > +{
> > +     struct bpf_link_primer link_primer;
> > +     struct bpf_perf_link *link;
> > +     struct perf_event *event;
> > +     struct file *perf_file;
> > +     int err;
> > +
> > +     if (attr->link_create.flags)
> > +             return -EINVAL;
> > +
> > +     perf_file = perf_event_get(attr->link_create.target_fd);
> > +     if (IS_ERR(perf_file))
> > +             return PTR_ERR(perf_file);
> > +
> > +     link = kzalloc(sizeof(*link), GFP_USER);
>
> add __GFP_NOWARN flag?

I looked at few other bpf_link_alloc places in this file, they don't
use NOWARN flag. I think the idea with NOWARN flag is to avoid memory
alloc warnings when amount of allocated memory depends on
user-specified parameter (like the size of the map value). In this
case it's just a single fixed-size kernel object, so while users can
create lots of them, each is fixed in size. It's similar as any other
kernel object (e.g., struct file). So I think it's good as is.

>
> > +     if (!link) {
> > +             err = -ENOMEM;
> > +             goto out_put_file;
> > +     }
> > +     bpf_link_init(&link->link, BPF_LINK_TYPE_PERF_EVENT, &bpf_perf_link_lops, prog);
> > +     link->perf_file = perf_file;
> > +
> > +     err = bpf_link_prime(&link->link, &link_primer);
> > +     if (err) {
> > +             kfree(link);
> > +             goto out_put_file;
> > +     }
> > +
> > +     event = perf_file->private_data;
> > +     err = perf_event_set_bpf_prog(event, prog);
> > +     if (err) {
> > +             bpf_link_cleanup(&link_primer);
>
> Do you need kfree(link) here?

bpf_link_cleanup() will call kfree() in deferred fashion. This is due
to bpf_link_prime() allocating anon_inode file internally, so it needs
to be freed carefully and that's what bpf_link_cleanup() is for.

>
> > +             goto out_put_file;
> > +     }
> > +     /* perf_event_set_bpf_prog() doesn't take its own refcnt on prog */
> > +     bpf_prog_inc(prog);
> > +
> > +     return bpf_link_settle(&link_primer);
> > +
> > +out_put_file:
> > +     fput(perf_file);
> > +     return err;
> > +}
> > +#endif /* CONFIG_PERF_EVENTS */
> > +
> >   #define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
> >
> [...]
