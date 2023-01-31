Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A0C6835AF
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjAaSvy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjAaSvo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:51:44 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE51856192
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:51:38 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ml19so20919943ejb.0
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+zLryEyLsCXkEtMa+lT/EJ68XxAaghRTa0IseT6hIVc=;
        b=pN3KEvkZUyF6lc3gu+eIY8/qX3wsuep6C98f6SCZ2SUr65w8SJmjpy9637A8+FWo46
         A4agDRkI99vh09jDE3R3jjeW8f+CxtwgZEz5rELk41vML+ADfzisgJ0Qp//RyXnoz0gh
         vahOGrAc8j76DpEBgDzini6f2JRB18B+06dX0LPzlQcb9oxd/Oki1fW99ytpgthLrubK
         rtTvAOa0gA+PH2Hpbk+BdVwV690jihdyU5twlgUE+y4I5wbL9jwxxCqqQYtMStrI/3br
         GUnaC/PHC6QsbULpd5vbCMBee4CMqUafRainuG93B5l+C/xT9tX0pyg9DN/fR7/g5j4Y
         3IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zLryEyLsCXkEtMa+lT/EJ68XxAaghRTa0IseT6hIVc=;
        b=kaPToetSdStWQVHMA2UuJM/oXZs7pYWohYaF2H3Uupl85seRcq5o9IcD0WQ6mblv8h
         9POpK5AOqtnLGQK0PZIzBJJNNAF6ILpH7AYg9G3uKKhvVJyo+1uITU3c66JA32UWJf7N
         Q7ygMUz4Es+vP64KWxvy7MCJPi+KvhTvYQjgiR7/zqkNqGOX4fgSJmg6FESlKUS/h0K2
         GEEByQuL1MfpKjV8JC8sRh1INdZyAoDUEVb71lQ4XhBWaxNCGyTeppRdLFn2ogdE0wlm
         3qH3kPeWnZYEGnB3JHY9ED28oVLvENyc3dmDsA8AcHq2hE9zGTiNavayT2//URe7N+Xa
         5i5w==
X-Gm-Message-State: AO0yUKXJZThInRFH88Dmw6IqlL4ywTHyTuJ6XmfeIuWg3E4E4U5fn51V
        PJt9yO2Qm/4iePjlx9zNRwlhXWP4xb7rJxO07qA=
X-Google-Smtp-Source: AK7set+wCH5bEkUD8UghZlKqZWG1skYoO0WSg954t/dTA0S+Jp/gyjZZrO/0lSR0GxGFarW3vuKt3Ac9onu2kM04JNU=
X-Received: by 2002:a17:906:ad3:b0:878:6f08:39ec with SMTP id
 z19-20020a1709060ad300b008786f0839ecmr5564969ejf.233.1675191097299; Tue, 31
 Jan 2023 10:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20230127181457.21389-1-aspsk@isovalent.com> <20230127181457.21389-5-aspsk@isovalent.com>
 <CAEf4BzYDnGo+5gZKZc-gYTk0ES+s3hOSv7SKCZ9dV-oSnP6wXQ@mail.gmail.com> <Y9j0Mq4W5o+nTR6c@lavr>
In-Reply-To: <Y9j0Mq4W5o+nTR6c@lavr>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 Jan 2023 10:51:25 -0800
Message-ID: <CAEf4Bza1LYumO5G2Hez0Zy2DKJOAEj6OfX_Sso5O9rsN4a2BdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] selftest/bpf/benchs: make quiet option common
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
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

On Tue, Jan 31, 2023 at 2:57 AM Anton Protopopov <aspsk@isovalent.com> wrote:
>
> On 23/01/30 04:10, Andrii Nakryiko wrote:
> > On Fri, Jan 27, 2023 at 10:14 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > >
> > > The "local-storage-tasks-trace" benchmark has a `--quiet` option. Move it to
> > > the list of common options, so that the main code and other benchmarks can use
> > > (now global) env.quiet as well.
> > >
> > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > ---
> > >  tools/testing/selftests/bpf/bench.c               | 15 +++++++++++++++
> > >  tools/testing/selftests/bpf/bench.h               |  1 +
> > >  .../benchs/bench_local_storage_rcu_tasks_trace.c  | 14 +-------------
> > >  3 files changed, 17 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> > > index ba93f1b268e1..42bf41a9385e 100644
> > > --- a/tools/testing/selftests/bpf/bench.c
> > > +++ b/tools/testing/selftests/bpf/bench.c
> > > @@ -16,6 +16,7 @@ struct env env = {
> > >         .warmup_sec = 1,
> > >         .duration_sec = 5,
> > >         .affinity = false,
> > > +       .quiet = false,
> > >         .consumer_cnt = 1,
> > >         .producer_cnt = 1,
> > >  };
> > > @@ -257,6 +258,7 @@ static const struct argp_option opts[] = {
> > >         { "consumers", 'c', "NUM", 0, "Number of consumer threads"},
> > >         { "verbose", 'v', NULL, 0, "Verbose debug output"},
> > >         { "affinity", 'a', NULL, 0, "Set consumer/producer thread affinity"},
> > > +       { "quiet", 'q', "{0,1}", OPTION_ARG_OPTIONAL, "If true, be quiet"},
> >
> > given the default is not quiet, why add 0 or 1? -q for quiet, no "-q"
> > for not quiet? Keeping it simple?
>
> The local-storage-tasks-trace benchmark expected 0 or 1 there, so I didn't want
> to break any script which utilize this option.
>
> The new parser accepts the old --quiet=0|1 for consistency, but also -q|--quiet
> without value, as you've suggested (I pass OPTION_ARG_OPTIONAL and set
> quiet=true if arg is NULL in the new parser).
>

I think it was mostly due to copy/pasting some other integer-based
argument handling. We don't need that for boolean flags. Let's just
fix benchs/run_bench_local_storage_rcu_tasks_trace.sh to do -q and
keep it simple?

> > >         { "prod-affinity", ARG_PROD_AFFINITY_SET, "CPUSET", 0,
> > >           "Set of CPUs for producer threads; implies --affinity"},
> > >         { "cons-affinity", ARG_CONS_AFFINITY_SET, "CPUSET", 0,
> >
> > [...]
