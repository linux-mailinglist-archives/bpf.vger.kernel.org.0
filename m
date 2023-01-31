Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4462682AEF
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 11:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjAaK6D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 05:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAaK57 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 05:57:59 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BEA7DBA
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 02:57:57 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ml19so16861634ejb.0
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 02:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4E+GErgDq7dt2AdK8pJyh6DAONRiC5pv3sjxTZv3ZLM=;
        b=48jUmDAEmkTiX1mKraVDN/lwYuqx3mdOyFqmYXnyWuBrcSruI+2ImbTeNAzo/g4QV8
         CPz/pJAaCE5J2cHRn47NXHNaOsTU8w2PPhXJqzHR0i40LDGfubSBAf38N1omoojmyXWL
         HlJI+rzc8gx2WvXJMDFhOd85+DN6MWVpVOrOnDbfvwmtJGzGZxebYQ3AKSAgEiZNbI/p
         TqIWyYOeQGZwdcDmbMheEY9XquyGx2WntUHPgIJsib0cIC6q2F5E6pio5kPzHBN8ylaB
         SnIzPP4RtbruQil5YDY90ES5PWXUvbN25Tc7o9gy0aGlPDdUr/QEQQh62ZpZSaPKVUyc
         YKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4E+GErgDq7dt2AdK8pJyh6DAONRiC5pv3sjxTZv3ZLM=;
        b=pVYdfepEaRiU1dnLlyhptS3YKL2lngeHTsvyC7aR6gt8kLAf/NVL9hsffu95x+/GCg
         tcuq7db9ul/+tUTlwGfMAoj8HmZG7rLm4udptiZ1huZMygHESsVlqaHbGyD83nnqdjIa
         qztWq6Q3f6h50jy3C1oXgF9YhqeeiSKaewNLRRjEqIgsF9jtVhiO67ALAu8NTpd/iJhJ
         zsVgEqX1VQu7K5Mj89j3AXjN9a6xmoJk+MnR5DNLG1QfsB6aycHZYl6xnWNpuNGjESMh
         6eMcDUkAl3jaho/0k4gQn+EeVT/YtwipK+T5ZGSDZ5viz0c93KhKsQV9Dlt3CSCPFdo4
         +CzA==
X-Gm-Message-State: AO0yUKU/JHVfqkYevCOylAJ6IIpbS+4IRn2K8o6YXEAbTabrKATerQJX
        osdl1dRV84rFYCJBiU4dW4Xnsg==
X-Google-Smtp-Source: AK7set9v8jM4CjrkFXYJst+wJ6dw4vj/j+4vC/N8rzphCfWMycTUP+KjLHEB/kNhLpJaPx6hBYOeJw==
X-Received: by 2002:a17:906:fc16:b0:878:81d9:63ea with SMTP id ov22-20020a170906fc1600b0087881d963eamr20215588ejb.52.1675162676052;
        Tue, 31 Jan 2023 02:57:56 -0800 (PST)
Received: from lavr ([2a02:168:f656:0:fa3:6e35:7858:23ee])
        by smtp.gmail.com with ESMTPSA id fe15-20020a1709072a4f00b008845c668408sm4724593ejc.169.2023.01.31.02.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 02:57:55 -0800 (PST)
Date:   Tue, 31 Jan 2023 11:57:54 +0100
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 4/6] selftest/bpf/benchs: make quiet option
 common
Message-ID: <Y9j0Mq4W5o+nTR6c@lavr>
References: <20230127181457.21389-1-aspsk@isovalent.com>
 <20230127181457.21389-5-aspsk@isovalent.com>
 <CAEf4BzYDnGo+5gZKZc-gYTk0ES+s3hOSv7SKCZ9dV-oSnP6wXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYDnGo+5gZKZc-gYTk0ES+s3hOSv7SKCZ9dV-oSnP6wXQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/01/30 04:10, Andrii Nakryiko wrote:
> On Fri, Jan 27, 2023 at 10:14 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > The "local-storage-tasks-trace" benchmark has a `--quiet` option. Move it to
> > the list of common options, so that the main code and other benchmarks can use
> > (now global) env.quiet as well.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  tools/testing/selftests/bpf/bench.c               | 15 +++++++++++++++
> >  tools/testing/selftests/bpf/bench.h               |  1 +
> >  .../benchs/bench_local_storage_rcu_tasks_trace.c  | 14 +-------------
> >  3 files changed, 17 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> > index ba93f1b268e1..42bf41a9385e 100644
> > --- a/tools/testing/selftests/bpf/bench.c
> > +++ b/tools/testing/selftests/bpf/bench.c
> > @@ -16,6 +16,7 @@ struct env env = {
> >         .warmup_sec = 1,
> >         .duration_sec = 5,
> >         .affinity = false,
> > +       .quiet = false,
> >         .consumer_cnt = 1,
> >         .producer_cnt = 1,
> >  };
> > @@ -257,6 +258,7 @@ static const struct argp_option opts[] = {
> >         { "consumers", 'c', "NUM", 0, "Number of consumer threads"},
> >         { "verbose", 'v', NULL, 0, "Verbose debug output"},
> >         { "affinity", 'a', NULL, 0, "Set consumer/producer thread affinity"},
> > +       { "quiet", 'q', "{0,1}", OPTION_ARG_OPTIONAL, "If true, be quiet"},
> 
> given the default is not quiet, why add 0 or 1? -q for quiet, no "-q"
> for not quiet? Keeping it simple?

The local-storage-tasks-trace benchmark expected 0 or 1 there, so I didn't want
to break any script which utilize this option.

The new parser accepts the old --quiet=0|1 for consistency, but also -q|--quiet
without value, as you've suggested (I pass OPTION_ARG_OPTIONAL and set
quiet=true if arg is NULL in the new parser).

> >         { "prod-affinity", ARG_PROD_AFFINITY_SET, "CPUSET", 0,
> >           "Set of CPUs for producer threads; implies --affinity"},
> >         { "cons-affinity", ARG_CONS_AFFINITY_SET, "CPUSET", 0,
> 
> [...]
