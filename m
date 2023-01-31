Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD8C6835D8
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjAaS5i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjAaS5g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:57:36 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B095998F
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:57:22 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x7so12156545edr.0
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KbEz2KJXzbNkHBd/2oxt7Tv/IIxUZtdzNnoYk3cFQzE=;
        b=gDpvQcSxpngp2SSjT50XqDLTyJHnyy+RGDUjvvy/B3sWXRGAS1GU0vPavG9egKyvwK
         Kxu62wK8aJDa1xpRmJMn8mB2k1bdTtBG03NA7fpAmUqXehqlBhk5prYzRgrVCuLE9TJL
         C126NO0vh55qTUZ/7zEXKg4oSmN3te5enk1TqBuGiOywtpl7HCd2DgOI4/FJ29OPL96D
         i1sW9btdDEF2Jv7AVj1NV/YmmlI/v53hk8SIcQ1bR6IBCu06YskWfALdEZqbODfInYG9
         nsjkL1+yMoi1elVnBsFfD3fefpXEXjKkyR307Qr2Bwd6BwgUBNb15hskoDqGOcA2518f
         E6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbEz2KJXzbNkHBd/2oxt7Tv/IIxUZtdzNnoYk3cFQzE=;
        b=MXHNmlK6ERRfN3iirQeHv9uly7VeK3OYQRjL0ussvGL/bYfBQJa+epgeeuYib/U2IQ
         IpQsEiFd4QamThK2RcB41I6y+hsInE9lPe0V+Aivfdkyygd7UwVBsdvop1K4w4EZMsOC
         3P8wfKlJcP9vKiDZS+78twvuYdtuQugBU/9wH/A4qkSMmPjyicUHc2yR5bXPJjt97Oq3
         4KzdhyxprptJCYxO7yzw9038r/vJ6donO792kWOhHG6ZF/+K/RbU0w7VjwDE5u3sa0c+
         7bSenLLK+LVGxpEak2FxT1KC5LCAqsTfrtg8fmlSbWSPNWMoOUVo62IJyjeE9LBSGHFn
         jRRw==
X-Gm-Message-State: AO0yUKWIKnBB16c8e3QZ8MCgb4lDtN6iCJ8djyNuAURX/XPFJ0WmEZNK
        H0LcxKYQlzY49Z0egbneoXHSYPvmbqwyFZJ2XnA=
X-Google-Smtp-Source: AK7set9kd8D1T6sOOHL9hQdXhrAy9zXYmcM0hc9uTQ8oJ+jEHx4ePx8l+nEnSs+42anVNWRbebqFZA==
X-Received: by 2002:a05:6402:550f:b0:49f:da00:47a5 with SMTP id fi15-20020a056402550f00b0049fda0047a5mr31758220edb.25.1675191440466;
        Tue, 31 Jan 2023 10:57:20 -0800 (PST)
Received: from lavr ([2a02:168:f656:0:fa3:6e35:7858:23ee])
        by smtp.gmail.com with ESMTPSA id i22-20020a0564020f1600b004a2440f0150sm1296034eda.97.2023.01.31.10.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:57:20 -0800 (PST)
Date:   Tue, 31 Jan 2023 19:57:18 +0100
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 4/6] selftest/bpf/benchs: make quiet option
 common
Message-ID: <Y9lkjnQ/cSDUW2P+@lavr>
References: <20230127181457.21389-1-aspsk@isovalent.com>
 <20230127181457.21389-5-aspsk@isovalent.com>
 <CAEf4BzYDnGo+5gZKZc-gYTk0ES+s3hOSv7SKCZ9dV-oSnP6wXQ@mail.gmail.com>
 <Y9j0Mq4W5o+nTR6c@lavr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9j0Mq4W5o+nTR6c@lavr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/01/31 11:57, Anton Protopopov wrote:
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

Sure will do, for me --quiet=1 looks weird as well.

> > >         { "prod-affinity", ARG_PROD_AFFINITY_SET, "CPUSET", 0,
> > >           "Set of CPUs for producer threads; implies --affinity"},
> > >         { "cons-affinity", ARG_CONS_AFFINITY_SET, "CPUSET", 0,
> > 
> > [...]
