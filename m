Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F1747D945
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 23:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbhLVWRx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 17:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhLVWRw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Dec 2021 17:17:52 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6CEC061574;
        Wed, 22 Dec 2021 14:17:52 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id l3so2517290iol.10;
        Wed, 22 Dec 2021 14:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWyy7scyoeZya5HasVDpq+xnY3B8i15BnGzI0aJkktI=;
        b=Hgj3CvWp4Dzd/Xkm+kjAhPYeVms5SUkcjbSIcsm9iXgquzVH0LRh7MkzArtgRFqaFH
         /ZAF9tLgDLVvhePrkj5DbW2hTZmsZROMLH4ZPSaxkIoXsgt8q7UGixq5hMI7vaRBE1mt
         +DtIL2/dH2FgMsR10PC22ZpuRwqgxuKieZT/S/3J5B2zmtMlXiByChdR8bhRwRGxN7qM
         8x6frAGrGGcLyG1me2azp3v4IupzMxVyQhwNgrhOh0a/Q2HbtPed9bxCsV0R17bEfst4
         fK8Js5IShrRK1KUqnB5bQG5Zkl9prYPX8qQWHqCquv4nIFArG7gnpjR2zW3/uZ09pyqj
         UV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWyy7scyoeZya5HasVDpq+xnY3B8i15BnGzI0aJkktI=;
        b=dF1opkKdlfP11sMKYoY9oBFg1AjIxzYjYss+rak8r3TS6Xk+IhxZltpSRKPUkyZmor
         oUyMoa5xAdxFXgz4sPcAIirmuXG7k2B5woI35uiPBpm2OWTxrkutX259wBRNRQBHJ0yz
         7sTE/DfMHVe3ISO6cwI72oNf0vjxWrkS+ZI3IOT+MxBvtYmRNkcpT7awcxlmGPYjcbrJ
         W8WCy8X853kLW0B2fk8F2ks1yL4IVWPhHdc98JYrKgTWUszQsgTOEPivqtqJM649iRA3
         BAfD3uj1cnBw23+7gJSwZsHsoJHxTUnSE/gEYt15qTOP0v5RPqCQKMhqNXwfjHniBUb+
         n8cA==
X-Gm-Message-State: AOAM532NTfP7FfmzNR0JnSvp10/DxlKnu3oBZjoXGEiQmOibihe41TrQ
        haaVZjdW3SvqTfl3vF9t3JVRsxqZcRfx3pgPLlo=
X-Google-Smtp-Source: ABdhPJz+NLxpOibqTkfhFhqCODM95H0olZXn8XnZn+iaOEIEoWiSHsNRqREdvP8pk//64t7iLbpkVc+rgl/l4f2hBAo=
X-Received: by 2002:a05:6602:2d81:: with SMTP id k1mr2388965iow.112.1640211471535;
 Wed, 22 Dec 2021 14:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20211216222108.110518-1-christylee@fb.com> <20211216222108.110518-3-christylee@fb.com>
 <YcGO271nDvfMeSlK@krava> <CAEf4BzZpNvEtfsVHUJGfwi_1xM+7-ohBPKPrRo--X=fYkYLrsw@mail.gmail.com>
 <YcMr1LeP6zUBdCiK@krava>
In-Reply-To: <YcMr1LeP6zUBdCiK@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Dec 2021 14:17:40 -0800
Message-ID: <CAEf4Bzb2HWiuJmeb6WxE2Dift5qQOLBE=j1ZqfpVMjuWV3+EDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] perf: stop using deprecated
 bpf__object_next() API
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        He Kuang <hekuang@huawei.com>, Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 22, 2021 at 5:44 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Dec 21, 2021 at 01:58:14PM -0800, Andrii Nakryiko wrote:
> > On Tue, Dec 21, 2021 at 12:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Thu, Dec 16, 2021 at 02:21:08PM -0800, Christy Lee wrote:
> > > > bpf__object_next is deprecated, track bpf_objects directly in
> > > > perf instead.
> > > >
> > > > Signed-off-by: Christy Lee <christylee@fb.com>
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
> > > >  tools/perf/util/bpf-loader.h |  1 +
> > > >  2 files changed, 55 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > > > index 528aeb0ab79d..9e3988fd719a 100644
> > > > --- a/tools/perf/util/bpf-loader.c
> > > > +++ b/tools/perf/util/bpf-loader.c
> > > > @@ -29,9 +29,6 @@
> > > >
> > > >  #include <internal/xyarray.h>
> > > >
> > > > -/* temporarily disable libbpf deprecation warnings */
> > > > -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > > -
> > > >  static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
> > > >                             const char *fmt, va_list args)
> > > >  {
> > > > @@ -49,6 +46,36 @@ struct bpf_prog_priv {
> > > >       int *type_mapping;
> > > >  };
> > > >
> > > > +struct bpf_perf_object {
> > > > +     struct bpf_object *obj;
> > > > +     struct list_head list;
> > > > +};
> > > > +
> > > > +static LIST_HEAD(bpf_objects_list);
> > >
> > > hum, so this duplicates libbpf's bpf_objects_list,
> > > how do objects get on this list?
> >
> > yep, this list needs to be updated on perf side each time
> > bpf_object__open() (and any variant of open) is called.
> >
> > >
> > > could you please put more comments in changelog
> > > and share how you tested this?
> >
> > I actually have no idea how to test this as well, can you please share
> > some ideas?
> >
>
> I don't use it, I just know it's there.. that's why I asked ;-)
>
> it's possible to specify bpf program on the perf command line
> to be attached to event, like:
>
>       # cat tools/perf/examples/bpf/hello.c
>       #include <stdio.h>
>
>       int syscall_enter(openat)(void *args)
>       {
>               puts("Hello, world\n");
>               return 0;
>       }
>
>       license(GPL);
>       #
>       # perf trace -e openat,tools/perf/examples/bpf/hello.c cat /etc/passwd > /dev/null
>          0.016 (         ): __bpf_stdout__:Hello, world
>          0.018 ( 0.010 ms): cat/9079 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
>          0.057 (         ): __bpf_stdout__:Hello, world
>          0.059 ( 0.011 ms): cat/9079 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
>          0.417 (         ): __bpf_stdout__:Hello, world
>          0.419 ( 0.009 ms): cat/9079 openat(dfd: CWD, filename: /etc/passwd) = 3
>       #
>
> I took that example from commit message
>
> >
> > BTW, while we are at it, Jiri, do you have any good ideas on how to
> > remove perf's usage of bpf_program__set_priv() and
> > bpf_program__set_prep() APIs in perf code base? These APIs are
> > deprecated as well, but seems like perf relies on them pretty heavily.
> > What would be the best way to stop using them?
> >
> > For set_priv(), I think it should be totally fine to maintain a
> > separate lookup hash table by `struct bpf_program *` or its name, that
> > shouldn't be hard.
>
> ok, so there's no alternative api for this one then

nope

>
> >
> > But for set_prep(), what does perf use it for? I assume for cloning
> > BPF programs, right? Anything else besides that? If it's just for
> > cloning, libbpf provides bpf_program__insns() API to get access to
> > underlying bpf_insn array, do you think it's possible to switch perf
> > to that instead?
>
> look like it's used to generate prologs for programs:
>   a08357d8dc7d perf bpf: Generate prologue for BPF programs
>
> the author Wang Nan haven't touched that for some time,
> I'm cc-ing other folks that were involved..  Arnaldo? ;-)
>
> if nobody volunteers, I can check on that

thanks! I appreciate the help with moving perf away for libbpf's
obscure and deprecated APIs.

>
> jirka
>
