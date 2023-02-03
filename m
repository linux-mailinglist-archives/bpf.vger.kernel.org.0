Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC4368A4D2
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 22:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBCVmv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 16:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCVmt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 16:42:49 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF407696
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 13:42:47 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so19038867ejc.4
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 13:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2i3Md4h5dpojAmtbSAiYDyUWHhhQMoNyql3P518/y9A=;
        b=LFHDC1BNYL4XFUl97sROG91wWFGL2dTJI0IA1cvWWvw2jtXznkALj6aaJscxcXIpKY
         FdsFHfMYvEXRZJvvVkrUZkwFVP9v6URZ05sA/OpyaZ57W+dUI0CgKcf+ttY/RSTmaseT
         bj3PX223XIj4Vr8+55aDbxOtAX2cyo5h9y1Tt03NnTGno78KElUBxxzL48czOsZj42ic
         jrr/orTvf4O6KMedXQKUF6HOx9ab0xOwTUvzLn2QH9NTISqTwDfM/BEVkrN/eYB1hp3J
         6elllKxemJJxlbRpFpBlb7XM01U9KCt8/+T4rb8HC1oHpg5rcrBulLXhsONGJZ0aSUhl
         8p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2i3Md4h5dpojAmtbSAiYDyUWHhhQMoNyql3P518/y9A=;
        b=vU6qSGxJK+fN+UBQMWKPdpe2WYqMnebYAdChAbIWdi8LCovr91KXdafxJos7E25iGa
         41ga8kXuzrXFpPGHnpXQopmwONdr+c9A72e16QWzdz6RGtmu8qinCRR3fd4p3BvhXWD/
         2/JUEQx/Nbn/hQidoTlxbFiavNmnbtsAdvVX3S6DX3z1+8C44s+xmalfJJ0lRuAzAygn
         YgwM7SKAw1xV9lzBTlPdIkEjUS+SFfzDoEArjoxUVoAWQVfu1oULefgExmKdAL5D6Xvu
         9E9NNfh+Lzgjp9TvJ/ibtH33fPp/EDxqW092H8M/8jlhx2fPdRcuwhMPiSfy3ooHA2Cw
         nvXg==
X-Gm-Message-State: AO0yUKW5adfrF/46+d7ZsrnEVeF/czpn39vtN6CglGnHKNjjlJDeK/o6
        nlmclMF2Br3bPJSPBivnyIg5RmmeWul0R58eVqpIReQB
X-Google-Smtp-Source: AK7set/xfuB9t0qZBdwlKYNgs/M0dwtSyB8FUJSXFZTVd5TQsFfOzgyJ4B6S/cj4VTv2+SUBv6OhFKfAHP60ZLtl7Hw=
X-Received: by 2002:a17:906:cb9a:b0:877:5b9b:b426 with SMTP id
 mf26-20020a170906cb9a00b008775b9bb426mr3130566ejb.12.1675460566321; Fri, 03
 Feb 2023 13:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20230202062549.632425-1-arilou@gmail.com> <479c7e94-9502-6f94-c465-ac051f99b2ae@meta.com>
In-Reply-To: <479c7e94-9502-6f94-c465-ac051f99b2ae@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Feb 2023 13:42:34 -0800
Message-ID: <CAEf4BzbGHucDcFEyjDxSeW1fJxKDAt2mt9WXFagn=y9B+pqBSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Add wakeup_events to creation options
To:     Yonghong Song <yhs@meta.com>
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

On Fri, Feb 3, 2023 at 10:31 AM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 2/1/23 10:25 PM, Jon Doron wrote:
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
> >   tools/lib/bpf/libbpf.c | 4 ++--
> >   tools/lib/bpf/libbpf.h | 3 ++-
> >   2 files changed, 4 insertions(+), 3 deletions(-)
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
> > +     attr.wakeup_events = OPTS_GET(opts, wakeup_events, 1);
> >
> >       p.attr = &attr;
> >       p.sample_cb = sample_cb;
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 8777ff21ea1d..e83c0a915dc7 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -1246,8 +1246,9 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
> >   /* common use perf buffer options */
> >   struct perf_buffer_opts {
> >       size_t sz;
> > +     __u32 wakeup_events;
>
> Since you are adding wakeup_events here, do you think it make sense
> to add sample_period to struct perf_buffer_opts as well? In some cases,
> users might want to have different values for sample_period and
> wakeup_events, e.g., smaller sample_period to accumulate data and
> larger wakeup_events to wakeup user space poll?

It's not clear to me from reading perf_event_open manpage what
"sample_period" means for perf buffer. What will happen when we have
sample_period != wakeup_events?

>
> >   };
> > -#define perf_buffer_opts__last_field sz
> > +#define perf_buffer_opts__last_field wakeup_events
> >
> >   /**
> >    * @brief **perf_buffer__new()** creates BPF perfbuf manager for a specified
