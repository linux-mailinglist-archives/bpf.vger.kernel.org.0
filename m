Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B0C69FC76
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 20:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjBVTt1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 14:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBVTt1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 14:49:27 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726482C648;
        Wed, 22 Feb 2023 11:49:25 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id u14so10658810vsp.8;
        Wed, 22 Feb 2023 11:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPwmrZMQEF/WqljDsqQcVQAbBSuSNPhojo4n19aTh9s=;
        b=RxKnw91l53egv9x4eQ1xpjnfQYA9cxhJNJ1Avx1FMUfgLavyXzYxG8nSJVtQYhqmcu
         l/QM/7dpMEuW7Mnurxjpql9d253Ttm+JNLtTr56a1M1N4Mq5cB91HSDHh3DJJ2mloMqY
         3pEBzEWGQmDnM/qQ083CgffpUgT4EYDpakC3oxpo0lKsxUDA/HUnzXteT0/6lLm5EDaB
         xLBRU8Ly3ALIz4odQjlxG/7ydrpZFuN0rMpgbCIVezGxD+tzwcBjNaddQDz24vBfvbqW
         rlsIEyA83/tc968Olqfa1nts/jX+1Km2hyeyurDrlntP4Qc2ze3IEBNWtmOw7ZibIkt/
         8aLw==
X-Gm-Message-State: AO0yUKWqLkhNQRrNzaBSM+nCu5wK6+vC9gipPWCaNUEtwDjdjJ3OKh0z
        MR4oCqPuWu5iNuofmnzQJedxfReRJ9aOeiiHkfw=
X-Google-Smtp-Source: AK7set8RYEDZQ1ZJVf/Cd883h0wazdej2RHkrYUvMC8AirqpmQ3FZMCdQA99Yv0BF6PHO/+1LqSFbbGCR3gWYsLOGNg=
X-Received: by 2002:a05:6102:334a:b0:411:ac85:c5d0 with SMTP id
 j10-20020a056102334a00b00411ac85c5d0mr2362279vse.8.1677095364554; Wed, 22 Feb
 2023 11:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20230219061329.1001079-1-namhyung@kernel.org> <20230219061329.1001079-3-namhyung@kernel.org>
 <Y/Sw/NGEvPJ9XdtN@krava>
In-Reply-To: <Y/Sw/NGEvPJ9XdtN@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 22 Feb 2023 11:49:13 -0800
Message-ID: <CAM9d7ciwJXp2LEpZHSifgjbHwzhvAEkGEQxdas0LFMN3rNHCyg@mail.gmail.com>
Subject: Re: [PATCH 2/8] perf bpf filter: Implement event sample filtering
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 21, 2023 at 3:54 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Sat, Feb 18, 2023 at 10:13:23PM -0800, Namhyung Kim wrote:
>
> SNIP
>
> > +#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
> > +
> > +int perf_bpf_filter__prepare(struct evsel *evsel)
> > +{
> > +     int i, x, y, fd;
> > +     struct sample_filter_bpf *skel;
> > +     struct bpf_program *prog;
> > +     struct bpf_link *link;
> > +     struct perf_bpf_filter_expr *expr;
> > +
> > +     skel = sample_filter_bpf__open();
> > +     if (!skel) {
> > +             pr_err("Failed to open perf sample-filter BPF skeleton\n");
> > +             return -1;
> > +     }
> > +
> > +     bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
>
> is this needed? max_entries is defined in the bpf object

Nop, will remove.

Thanks,
Namhyung
