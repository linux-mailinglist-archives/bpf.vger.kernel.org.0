Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F4C3DB267
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 06:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhG3Ebh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 00:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhG3Ebh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 00:31:37 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BCCC061765
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 21:31:32 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id f26so13806618ybj.5
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 21:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7N/f7rU7kgtcvbGRa4UM+Bgvpd9uri83eErHORenl3Q=;
        b=sAbR8buz46NHfQUvcn4e2PdzaEM88lBb+4LQK+dV/YtssQ6Wi+FK/SDVWdqW76DRx0
         dHcQQ+kapa+0ffMbnai8JXFDJb3TPaZCjmkw6THbOZ1ByjgnZjBolh7jKNqqOf8Fz4xq
         XNhOHayYZ9TfjysHOkshFU2ErVGrJ8JBqvGi1vWKxhS1YnVe3Km/LiddMlocgOR2DhUY
         xLAEDM126ZK6qmQyOSI9PRryCzCV5AgTT4SHZ3UB64D6jlGGGiAMOXMvEfknzqiWT5ik
         KWmLCL5aCFNaOgYut2pCRPeKxMX5mRuDVHpd9BdKAJGyysHeAkeL9rlT6JSSr1GFw8FJ
         H4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7N/f7rU7kgtcvbGRa4UM+Bgvpd9uri83eErHORenl3Q=;
        b=SvqiCHG22a0rbPcdGT6DfjOAHRpjZn7VK682UnDZ29Nb4UljVIEkn9wZ8MATTqmcPf
         2TxLWiaIqNIbCkPXaJ6pxNP3jJyGV7kHbusWGTHsHhkwldcoo5YKpCjmdfiMTXcr7TSF
         H+nCRtKTR/F6Wv+hyOdVg86b36FVXzfSk/LwCZPU1IjkfFxgPkss0DKzEbEsF+DDSAfE
         WwA6r9ATCpwN5DtOc/p1bCtHGO3MuHtvZseKRUg/ybtPMmix7QkIiwla4kjsFqkwmBFm
         +PIPUCgUXWd1gWly6bujLWLOz+6wPZrPqWrwMh9QaK/hl6f9tDd4MJBc3/yk7MKxTigP
         cYqg==
X-Gm-Message-State: AOAM533WpeXlSeDlmqPENRTkX8xiAh401YvRTkv0kXopb//HsIM2qqWe
        /07qsgErrO/aBNeoZxQGdcThrMRrhMGn0RUxXsc=
X-Google-Smtp-Source: ABdhPJxOXnAHKGEPYHjxYM6zfH/q6xogXI7oYxaqy64dAzuD7bMY/0dZ25Pmhbc6PpnUSogrr707uRzPgITXK7nE96c=
X-Received: by 2002:a25:1455:: with SMTP id 82mr660452ybu.403.1627619491361;
 Thu, 29 Jul 2021 21:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210726161211.925206-1-andrii@kernel.org> <20210726161211.925206-6-andrii@kernel.org>
 <138b1ab0-1d9c-7288-06bd-fbe29285fc4f@fb.com>
In-Reply-To: <138b1ab0-1d9c-7288-06bd-fbe29285fc4f@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Jul 2021 21:31:20 -0700
Message-ID: <CAEf4Bzb39v5kz1Gc2YjNvGwN8kK8H2fSp1qvipie=ZLpuxRV6Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/14] bpf: allow to specify user-provided
 context value for BPF perf links
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

On Thu, Jul 29, 2021 at 11:00 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/26/21 9:12 AM, Andrii Nakryiko wrote:
> > Add ability for users to specify custom u64 value when creating BPF link for
> > perf_event-backed BPF programs (kprobe/uprobe, perf_event, tracepoints).
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
> > This is done by storing u64 user_ctx in struct bpf_prog_array_item,
> > corresponding to each attached and run BPF program. Given cgroup BPF programs
> > already use 2 8-byte pointers for their needs and cgroup BPF programs don't
> > have (yet?) support for user_ctx, reuse that space through union of
> > cgroup_storage and new user_ctx field.
> >
> > Make it available to kprobe/tracepoint BPF programs through bpf_trace_run_ctx.
> > This is set by BPF_PROG_RUN_ARRAY, used by kprobe/uprobe/tracepoint BPF
> > program execution code, which luckily is now also split from
> > BPF_PROG_RUN_ARRAY_CG. This run context will be utilized by a new BPF helper
> > giving access to this user context value from inside a BPF program. Generic
> > perf_event BPF programs will access this value from perf_event itself through
> > passed in BPF program context.
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   drivers/media/rc/bpf-lirc.c    |  4 ++--
> >   include/linux/bpf.h            | 16 +++++++++++++++-
> >   include/linux/perf_event.h     |  1 +
> >   include/linux/trace_events.h   |  6 +++---
> >   include/uapi/linux/bpf.h       |  7 +++++++
> >   kernel/bpf/core.c              | 29 ++++++++++++++++++-----------
> >   kernel/bpf/syscall.c           |  2 +-
> >   kernel/events/core.c           | 21 ++++++++++++++-------
> >   kernel/trace/bpf_trace.c       |  8 +++++---
> >   tools/include/uapi/linux/bpf.h |  7 +++++++
> >   10 files changed, 73 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
> > index afae0afe3f81..7490494273e4 100644
> > --- a/drivers/media/rc/bpf-lirc.c
> > +++ b/drivers/media/rc/bpf-lirc.c
> > @@ -160,7 +160,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
> >               goto unlock;
> >       }
> >
> > -     ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
> > +     ret = bpf_prog_array_copy(old_array, NULL, prog, 0, &new_array);
> >       if (ret < 0)
> >               goto unlock;
> >
> [...]
> >   void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 00b1267ab4f0..bc1fd54a8f58 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1448,6 +1448,13 @@ union bpf_attr {
> >                               __aligned_u64   iter_info;      /* extra bpf_iter_link_info */
> >                               __u32           iter_info_len;  /* iter_info length */
> >                       };
> > +                     struct {
> > +                             /* black box user-provided value passed through
> > +                              * to BPF program at the execution time and
> > +                              * accessible through bpf_get_user_ctx() BPF helper
> > +                              */
> > +                             __u64           user_ctx;
> > +                     } perf_event;
>
> Is it possible to fold this field into previous union?
>
>                  union {
>                          __u32           target_btf_id;  /* btf_id of
> target to attach to */
>                          struct {
>                                  __aligned_u64   iter_info;      /*
> extra bpf_iter_link_info */
>                                  __u32           iter_info_len;  /*
> iter_info length */
>                          };
>                  };
>
>

I didn't want to do it, because different types of BPF links will
accept this user_ctx (or now bpf_cookie). And then we'll have to have
different locations of that field for different types of links.

For example, when/if we add this user_ctx to BPF iterator programs,
having __u64 user_ctx in the same anonymous union will make it overlap
with iter_info, which is a problem. So I want to have a link
type-specific sections in LINK_CREATE command section, to allow the
same field name at different locations.

I actually think that we should put iter_info/iter_info_len into a
named field, like this (also added user_ctx for bpf_iter link as a
demonstration):

struct {
    __aligned_u64 info;
    __u32         info_len;
    __aligned_u64 user_ctx;  /* see how it's at a different offset
than perf_event.user_ctx */
} iter;
struct {
    __u64         user_ctx;
} perf_event;

(of course keeping already existing fields in anonymous struct for
backwards compatibility)

I decided to not do that in this patch set, though, to not distract
from the main goal. But I think we should avoid this shared field
"namespace" across different link types going forward.


> >               };
> >       } link_create;
> >
> [...]
