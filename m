Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736583DB233
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 06:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhG3EYK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 00:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhG3EYK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 00:24:10 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106E3C0613C1
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 21:24:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id k65so13698802yba.13
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 21:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHg2OSXs2kvta8H1O6/BxrhtsssswTKvDoRl/otBSAE=;
        b=Tc04u0nVEnFX19DnS29dVxjo+oGSSwu8bsoQvPuz4YrTJ9VOva3qVXVthx6D9HyM79
         8HFZ7WgRZBcTwU0Vo6KZsSSznk9SHDXCvh1vaearx2P4Snq0b27Le6JgxMlwm6OjMb/3
         wKkER8tJVyszIwIyhUcjgdXzrtW/ga1tQwHWvhWC8MCEL2iYMUKmpVJyDVj9/WYzfB4N
         EmhMuuBVvpklh4luQpOrUdfpWgHY2tlCeOm3oDfM6HgwbdCjGnN1cDAO3v/5YjFRWiNH
         h0aUzuHsagr60I+xg4dGZdXnWLU+KVUHdi5lRRlznU3/Ao41B32KHywbmiXFiE8gKdGP
         brYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHg2OSXs2kvta8H1O6/BxrhtsssswTKvDoRl/otBSAE=;
        b=r99pnWLcIBsYj5MSCLGpw6Xjnx7XHWFv01Ic27WSj9XJRexz/vjiRMDxjjTrVG2mU7
         OzjMhIz/YIxGyAC95I33ZosAm+38B8IWJSkFR2ou+0YxtmNzI8ELjEuWcXnO8WpXAlPk
         thz2Xqpo+2Js9k7qwMPmL0XcYP+v5yMvGIq4ytuDhKcIpBPdbSG2HHafAC17QlvLPm7Q
         ZwkDdEmDtjuY4+n6/cTVeXBf0+mohMJgw3f6ngVQODYwMAxdvl9BiHiD+6nKj+pnZEw0
         0eX7DFCm4fzRWwm/nRUGJj3V7aYZwL2/F7RDlEf0fKgapIO0BmLAMYaerCgp94tye2pI
         dnCA==
X-Gm-Message-State: AOAM532+QFx/qeamAgcPqT+xsx3jp7Ndiga/uCnCKT27DeT9+V94Zsb4
        JaqLOPx5xfuTo6hALELdNq6iyjaxnNySDnw/hvs=
X-Google-Smtp-Source: ABdhPJxARu2m3ETZYOK5RhG6DrY0tKrG0YBnPZn7zrNHtGVtould5eTQqilMZqq9AB2AczE7rcumbQLWSlNw39UtA70=
X-Received: by 2002:a25:9942:: with SMTP id n2mr708734ybo.230.1627619044357;
 Thu, 29 Jul 2021 21:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210726161211.925206-1-andrii@kernel.org> <20210726161211.925206-5-andrii@kernel.org>
 <YP/MG3ZTq+fmJ+YQ@hirez.programming.kicks-ass.net>
In-Reply-To: <YP/MG3ZTq+fmJ+YQ@hirez.programming.kicks-ass.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Jul 2021 21:23:53 -0700
Message-ID: <CAEf4Bzbf2jnkXQ2pTksLse6CQjUeVHeBhhJoz9O4aSib+hhrkA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/14] bpf: implement minimal BPF perf link
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 27, 2021 at 2:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 26, 2021 at 09:12:01AM -0700, Andrii Nakryiko wrote:
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
>
> So I have no idea what all that means... I don't speak BPF. That said,
> the patch doesn't look terrible.
>
> One little question below, but otherwise:
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> > +static void bpf_perf_link_release(struct bpf_link *link)
> > +{
> > +     struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
> > +     struct perf_event *event = perf_link->perf_file->private_data;
> > +
> > +     perf_event_free_bpf_prog(event);
> > +     fput(perf_link->perf_file);
> > +}
>
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
> > +             goto out_put_file;
> > +     }
> > +     /* perf_event_set_bpf_prog() doesn't take its own refcnt on prog */
>
> Is that otherwise expected? AFAICT the previous users of that function
> were guaranteed the existance of the BPF program. But afaict there is
> nothing that prevents perf_event_*_bpf_prog() from doing the addition
> refcounting if that is more convenient.

Sorry, I missed this on my last pass. Yes, it's expected. The general
convention we use for BPF when passing bpf_prog (and bpf_map and other
objects like that) is that the caller already has an incremented
refcnt before calling callee. If callee succeeds, that refcnt is
"transferred" into the caller (so callee doesn't increment it, caller
doesn't put it). If callee errors out, caller is decrementing refcnt
after necessary clean up, but callee does nothing. While asymmetrical,
in practice it results in a simple and straightforward  error handling
logic.

In this case bpf_perf_link_attach() assumes one refcnt from its
caller, but if everything is ok and perf_event_set_bpf_prog()
succeeds, we need to keep 2 refcnts: one for bpf_link and one for
perf_event_set_bpf_prog() internally. So we just bump refcnt one extra
time. I intentionally removed bpf_prog_put() from
perf_event_set_bpf_prog() in the previous patch to make error handling
uniform with the rest of the code and simpler overall.

>
> > +     bpf_prog_inc(prog);
> > +
> > +     return bpf_link_settle(&link_primer);
> > +
> > +out_put_file:
> > +     fput(perf_file);
> > +     return err;
> > +}
