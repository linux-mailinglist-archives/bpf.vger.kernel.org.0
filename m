Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1AE3D7F94
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 22:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhG0U5K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 16:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhG0U5J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 16:57:09 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2BDC061757
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 13:57:08 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id a93so280120ybi.1
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zz3t9YEBgrEuR3D08dTQR8qBE6XsYirTeLozWo47liE=;
        b=uWYqNXK8Evbuh0tgbKKYbLC2YXdynZLu321OKOe5FT9sBMdi4Qtw6Js7fgggPuoIlg
         mOA47bcxaAgpTNEE57zJEjz/I4BueO4t44mY1wOdbzq/thzwU9+xi+EhljtRCoWvACuS
         LuWM8GUQEoUMN1P11NkuDD5VQ+FOkbJNUGCokJ5O31CHzpnOyoveoAXG37PPCBrVy4gP
         IsmmGiqP2HwYTSTDcmNuuLUGDR08bRCJboDJTb3l2MX514Jj76U3G1F1VVik9VdHpb5E
         qIxZX3lVoKpUu9aM2Gpaqnmsy0i0XUVdGpnCN9NrFNryWoZ1bR8y2QjBIT94hvJk79FN
         ORvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zz3t9YEBgrEuR3D08dTQR8qBE6XsYirTeLozWo47liE=;
        b=UZKNw8Nxnhc/nmZSjWN9YjR6Gbs68SIWfu05Is/w+Zq23eH022PzgW9Ih2RJTcSEUS
         nvIBNsnXrV4sOJ26BxwLx/0dcMmvJhtR6YtnKoc570jaf+lc1ZbTNzYJC11eF7ZiAnM6
         yK5bEXYpkcboRM93TUa4kzPrBXJJLg2x56mwR2cT7Y7DJXamFm5S2jQSvW4Uxh4brAPD
         RT5XAt7EMsL7ByTmgfyX3RLY91pTvDJU+kpJLn7RLUuw6VRD03ilpMWFL/Qw2bfx7a2X
         WmzFqPiLHVeLrsLQSATtsQAQKHJmpywFlXoJq3epPZ5c7nrrnFoieJhYp9HdhddH/L4z
         B9aw==
X-Gm-Message-State: AOAM530ID6qvypFUBAHzcOM8pvUJMuGC5STeTXy6W9sAOzeRCs+K15wj
        +3YxL0e7HTqlIPJAchhAgSXcwerXG1KhPoGS61Q=
X-Google-Smtp-Source: ABdhPJwdM7JXtHu4NDsZjsXWmmGStmdvdyfmvznCbJSn1xY89yhInIXPT30mleovRc4JOCdiGiyoima66lCJqWT6FLA=
X-Received: by 2002:a25:a045:: with SMTP id x63mr22940517ybh.27.1627419427764;
 Tue, 27 Jul 2021 13:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210726161211.925206-1-andrii@kernel.org> <20210726161211.925206-5-andrii@kernel.org>
 <YQApAyKpMOSGYhSu@krava>
In-Reply-To: <YQApAyKpMOSGYhSu@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Jul 2021 13:56:56 -0700
Message-ID: <CAEf4BzZ5pVqSYU1NcSo0u2u2gn_o1qerytGtMmFsFyTG2c5=KA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/14] bpf: implement minimal BPF perf link
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 27, 2021 at 8:40 AM Jiri Olsa <jolsa@redhat.com> wrote:
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
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf_types.h      |   3 +
> >  include/linux/trace_events.h   |   3 +
> >  include/uapi/linux/bpf.h       |   2 +
> >  kernel/bpf/syscall.c           | 105 ++++++++++++++++++++++++++++++---
> >  kernel/events/core.c           |  10 ++--
> >  tools/include/uapi/linux/bpf.h |   2 +
> >  6 files changed, 112 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > index a9db1eae6796..0a1ada7f174d 100644
> > --- a/include/linux/bpf_types.h
> > +++ b/include/linux/bpf_types.h
> > @@ -135,3 +135,6 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
> >  #ifdef CONFIG_NET
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
> >  #endif
> > +#ifdef CONFIG_PERF_EVENTS
> > +BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
> > +#endif
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index ad413b382a3c..8ac92560d3a3 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -803,6 +803,9 @@ extern void ftrace_profile_free_filter(struct perf_event *event);
> >  void perf_trace_buf_update(void *record, u16 type);
> >  void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
> >
> > +int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
> > +void perf_event_free_bpf_prog(struct perf_event *event);
> > +
> >  void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
> >  void bpf_trace_run2(struct bpf_prog *prog, u64 arg1, u64 arg2);
> >  void bpf_trace_run3(struct bpf_prog *prog, u64 arg1, u64 arg2,
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
> >  };
> >
> > @@ -1006,6 +1007,7 @@ enum bpf_link_type {
> >       BPF_LINK_TYPE_ITER = 4,
> >       BPF_LINK_TYPE_NETNS = 5,
> >       BPF_LINK_TYPE_XDP = 6,
> > +     BPF_LINK_TYPE_PERF_EVENT = 6,
>
> hi, should be 7
>

doh! Eagle eyes! Will fix, thanks :)

> jirka
>
