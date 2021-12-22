Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22F847D323
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 14:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhLVNo5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 08:44:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234159AbhLVNo5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Dec 2021 08:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640180696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EUX0ogKpf3d14pHpuY30V0wv60QYvAzDmFZeRw8TXic=;
        b=HvqWn3xliTo9gmnK3Ni/QVq5tLG2XP78f8kBKpDocDjq2On/meDkU4zz4JhI6bLdvPjeEf
        f/SHuBx7m4wHrZOOgRJTNZK8WwQlR4fxQaW1Awhg1l5hfDo9tjO2ebPED1Y1jbO2s1sI84
        C+KzI1En4JMm12AB1fo7vpGHRW1Rnog=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-Njhx80XTNLiXNsTLyvyrng-1; Wed, 22 Dec 2021 08:44:55 -0500
X-MC-Unique: Njhx80XTNLiXNsTLyvyrng-1
Received: by mail-ed1-f70.google.com with SMTP id ch27-20020a0564021bdb00b003f8389236f8so1847996edb.19
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 05:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EUX0ogKpf3d14pHpuY30V0wv60QYvAzDmFZeRw8TXic=;
        b=J4QqOOnIcDeJ/Mptx0/g6kADEDSUdfwsJvDXpYwZchmdKFjlsQexzqmR1LkBEo1RXa
         +79Zd3bLFYJhlpC0DdimpWxPqzz2iMs+S8mRARKUgGnPSg2sGM+LHHdmx+pbRvovzpMF
         d5cTgp+ErsE1rsI2GfpHPMHghaUwUEBVMK3QWa4je5jYx3HZJGpemYU5Lv8zAtChIIrs
         AexCM+shJvUlxhh7ZACN6xhdHMVZjGYZtmScXWleHaYNUbt1VKQH8tQOloIPGrpX0YX8
         ggGkw1Qmjh6E+mXqbaukecmnzpAJZd/2HMUdhy9RxLnt9SekPLfOuBiC2wqspx9iPApd
         Ww7A==
X-Gm-Message-State: AOAM532xXJ+dPOGjjtFVAN7LBGvMq/MhwJnrXCfU4DhBWZQjmxbpLrOh
        T0jCcwk4i+uGhf2FVQwbC2H3NVPOYNeBvsRMYUdasgt0mXwCthLY7L57n1oHOKGt01Cbq68+uqN
        OHAcUzi0a9lWo
X-Received: by 2002:a17:907:8a06:: with SMTP id sc6mr931761ejc.214.1640180694379;
        Wed, 22 Dec 2021 05:44:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzH2Ch4giRTpV+TGELmHFEzgTDQlBiWQMnDDaSrIPTcmLp/t4Ey8yKkKy7hlVrNJH2pmznoPA==
X-Received: by 2002:a17:907:8a06:: with SMTP id sc6mr931742ejc.214.1640180694125;
        Wed, 22 Dec 2021 05:44:54 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id 12sm742338eja.187.2021.12.22.05.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 05:44:53 -0800 (PST)
Date:   Wed, 22 Dec 2021 14:44:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCH bpf-next 2/2] perf: stop using deprecated
 bpf__object_next() API
Message-ID: <YcMr1LeP6zUBdCiK@krava>
References: <20211216222108.110518-1-christylee@fb.com>
 <20211216222108.110518-3-christylee@fb.com>
 <YcGO271nDvfMeSlK@krava>
 <CAEf4BzZpNvEtfsVHUJGfwi_1xM+7-ohBPKPrRo--X=fYkYLrsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZpNvEtfsVHUJGfwi_1xM+7-ohBPKPrRo--X=fYkYLrsw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 21, 2021 at 01:58:14PM -0800, Andrii Nakryiko wrote:
> On Tue, Dec 21, 2021 at 12:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Dec 16, 2021 at 02:21:08PM -0800, Christy Lee wrote:
> > > bpf__object_next is deprecated, track bpf_objects directly in
> > > perf instead.
> > >
> > > Signed-off-by: Christy Lee <christylee@fb.com>
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
> > >  tools/perf/util/bpf-loader.h |  1 +
> > >  2 files changed, 55 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> > > index 528aeb0ab79d..9e3988fd719a 100644
> > > --- a/tools/perf/util/bpf-loader.c
> > > +++ b/tools/perf/util/bpf-loader.c
> > > @@ -29,9 +29,6 @@
> > >
> > >  #include <internal/xyarray.h>
> > >
> > > -/* temporarily disable libbpf deprecation warnings */
> > > -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> > > -
> > >  static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
> > >                             const char *fmt, va_list args)
> > >  {
> > > @@ -49,6 +46,36 @@ struct bpf_prog_priv {
> > >       int *type_mapping;
> > >  };
> > >
> > > +struct bpf_perf_object {
> > > +     struct bpf_object *obj;
> > > +     struct list_head list;
> > > +};
> > > +
> > > +static LIST_HEAD(bpf_objects_list);
> >
> > hum, so this duplicates libbpf's bpf_objects_list,
> > how do objects get on this list?
> 
> yep, this list needs to be updated on perf side each time
> bpf_object__open() (and any variant of open) is called.
> 
> >
> > could you please put more comments in changelog
> > and share how you tested this?
> 
> I actually have no idea how to test this as well, can you please share
> some ideas?
> 

I don't use it, I just know it's there.. that's why I asked ;-)

it's possible to specify bpf program on the perf command line
to be attached to event, like:

      # cat tools/perf/examples/bpf/hello.c
      #include <stdio.h>
    
      int syscall_enter(openat)(void *args)
      {
              puts("Hello, world\n");
              return 0;
      }
    
      license(GPL);
      #
      # perf trace -e openat,tools/perf/examples/bpf/hello.c cat /etc/passwd > /dev/null
         0.016 (         ): __bpf_stdout__:Hello, world
         0.018 ( 0.010 ms): cat/9079 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
         0.057 (         ): __bpf_stdout__:Hello, world
         0.059 ( 0.011 ms): cat/9079 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
         0.417 (         ): __bpf_stdout__:Hello, world
         0.419 ( 0.009 ms): cat/9079 openat(dfd: CWD, filename: /etc/passwd) = 3
      #

I took that example from commit message

> 
> BTW, while we are at it, Jiri, do you have any good ideas on how to
> remove perf's usage of bpf_program__set_priv() and
> bpf_program__set_prep() APIs in perf code base? These APIs are
> deprecated as well, but seems like perf relies on them pretty heavily.
> What would be the best way to stop using them?
> 
> For set_priv(), I think it should be totally fine to maintain a
> separate lookup hash table by `struct bpf_program *` or its name, that
> shouldn't be hard.

ok, so there's no alternative api for this one then

> 
> But for set_prep(), what does perf use it for? I assume for cloning
> BPF programs, right? Anything else besides that? If it's just for
> cloning, libbpf provides bpf_program__insns() API to get access to
> underlying bpf_insn array, do you think it's possible to switch perf
> to that instead?

look like it's used to generate prologs for programs:
  a08357d8dc7d perf bpf: Generate prologue for BPF programs

the author Wang Nan haven't touched that for some time,
I'm cc-ing other folks that were involved..  Arnaldo? ;-)

if nobody volunteers, I can check on that

jirka

