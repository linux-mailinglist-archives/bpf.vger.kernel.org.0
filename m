Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9E76872FA
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 02:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjBBB2n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 20:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBBB2m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 20:28:42 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809496AC84
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 17:28:41 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mc11so1753250ejb.10
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 17:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lpTdTvMtwVEJ1vMYC/0fBj2tc7aBnnGNMojNtzSSn6s=;
        b=idH9k6pK85P8VWPitS7I66m8Ojx3nlgJMgExD+lOpvsIggaKExiLLXZvHrixg+3IcE
         pb2zH8Eq3lhUg+aVpYlXwJUv3LhHeW4S+D2Jx440l6NbCYtCnLKEeXm9WboWPU/BnMfN
         1yxXedQMuZJUM2cpQRKEm4LB6OYrLSawGIXOgDA94CSU4Fid8jtOkJrzCo4BU15tLI4o
         dPxAKscvCVi+qpvejhjOTk9+AdVNpxhJeDcr/c+JJdwHTz8loDRmvq7eFyEAzpFx56/l
         hhGb6yAcQym7wzP0dW6I6oTBGWHk6FaixkBjH4Oe98iD+iWvNPEnOJRhKnbGpLy2oK9U
         Vppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpTdTvMtwVEJ1vMYC/0fBj2tc7aBnnGNMojNtzSSn6s=;
        b=uqoyoMAe3WTyEDuCQfYONdpC0ua8xS+8U48GH9Nh9x3cS9YQebJ+Ctox93/JQIPzjQ
         SYr+6LQNvo1Bu0iqbji6oZyUWTKmDYC3TwlL//9JnDnF+6dTI6xx4aTy/XKf+LvSl6ov
         6eq1k0/762WrGKJuN5yO4BQ9J/zFMQ9h75Fnmf0V813DJ2OmvfvQdRaGLgxwNfDj4RC9
         hD3BDQqbcNK4+Nl76r1fgsDQZCCOv65NbN4iulu9P9k3VHhRqsgAZDRmuipcyOJl2Qrs
         p+KHyIgd9UYnKVossjwQEISMbZJ3zDOZed7PP4RG3Je6NzqjAocyWw2z4itvH2O8h58+
         H2sg==
X-Gm-Message-State: AO0yUKXqFKTVzhFbAqq34kNe65AclAD3T6+XKJ6EiFwCfz1oZ7hX67DT
        BFUya2tAtiUNg60CwjoByXljwpd97UXcMKs4FbcT0uvFtnU=
X-Google-Smtp-Source: AK7set85Hek3llwW72mXzMLANTqOqB2Of5UoWXA3RoAENN9E7xXYp2q/7uZY76LEc+GCmmbixZdUfWTld3jZPE4CrQE=
X-Received: by 2002:a17:906:5390:b0:888:1f21:4424 with SMTP id
 g16-20020a170906539000b008881f214424mr1458020ejo.141.1675301319788; Wed, 01
 Feb 2023 17:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20230201090009.114398-1-arilou@gmail.com> <Y9rEDDF7qqSs1wSs@krava>
In-Reply-To: <Y9rEDDF7qqSs1wSs@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Feb 2023 17:28:27 -0800
Message-ID: <CAEf4BzZNH_omrTUUO2M=tx2KD+hGaAAS611i69ih=eN7s2dzJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] libbpf: Add wakeup_events to creation options
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Jon Doron <arilou@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, Jon Doron <jond@wiz.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 1, 2023 at 11:57 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Feb 01, 2023 at 11:00:09AM +0200, Jon Doron wrote:
> > From: Jon Doron <jond@wiz.io>
> >
> > Add option to set when the perf buffer should wake up, by default the
> > perf buffer becomes signaled for every event that is being pushed to it.
> >
> > In case of a high throughput of events it will be more efficient to wake
> > up only once you have X events ready to be read.
> >
> > So your application can wakeup once and drain the entire perf buffer.
> >
> > Signed-off-by: Jon Doron <jond@wiz.io>
> > ---
> >  tools/lib/bpf/libbpf.c | 4 ++--
> >  tools/lib/bpf/libbpf.h | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index eed5cec6f510..6b30ff13922b 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -11719,8 +11719,8 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
> >       attr.config = PERF_COUNT_SW_BPF_OUTPUT;
> >       attr.type = PERF_TYPE_SOFTWARE;
> >       attr.sample_type = PERF_SAMPLE_RAW;
> > -     attr.sample_period = 1;
> > -     attr.wakeup_events = 1;
> > +     attr.sample_period = OPTS_GET(opts, wakeup_events, 1);
>
> hm, but I think we still want every event.. setting sample_period to X
> would store only every X-th bpf-output event, no?

seems like benchs/bench_ringbufs.c sets both sample_period and
wakeup_events, but it would be nice to make sure we do not lose events
with such configuration.

Let's add a selftest for this feature.

>
> jirka
>
> > +     attr.wakeup_events = OPTS_GET(opts, wakeup_events, 1);
> >
> >       p.attr = &attr;
> >       p.sample_cb = sample_cb;
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 8777ff21ea1d..2e4bdfc58c82 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -1246,6 +1246,7 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
> >  /* common use perf buffer options */
> >  struct perf_buffer_opts {
> >       size_t sz;
> > +     __u32 wakeup_events;
> >  };
> >  #define perf_buffer_opts__last_field sz

you need to update perf_buffer_opts__last_field to wakeup_events as well


> >
> > --
> > 2.39.1
> >
