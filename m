Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13735BEEF2
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 23:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiITVFU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 17:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiITVFD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 17:05:03 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42413ED52;
        Tue, 20 Sep 2022 14:04:59 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id f20-20020a9d7b54000000b006574e21f1b6so2614536oto.5;
        Tue, 20 Sep 2022 14:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=h+5c+YAd8qnEXFc7fGMxvZO7wvFtjw5sICYJeM59wF0=;
        b=LQ2wiIdemgCzdLZ6gdFfOBUGjdvJG/MpUg0o7T1m1ONLwGbpT2jhPCzpNjIzmVRMUv
         gtY0ZaqkU+/5JUW3pqd16Y5dpaXYdPdRQEbQItkTvVGVjmPcE9wGzmWvWBriGIsRX5Jq
         Q2sErO/V7NogKi7UByBl/8zHxhktIL3XilTA/eaNALZ9ARRbuy6ksdM5MjgO6g/Dd95U
         8M5FdniifnjZOow/q79H3plCvHflKjVO85hziCBcO69sgJ8lgGF8y3nr2f483NdwA39h
         MrZHVrPOsoqyVMAkDcTTk8t7oed0/UVN+v55dMbxZfSrE/HJJak3TWQCE/n56s0zQEWO
         ClXA==
X-Gm-Message-State: ACrzQf1QIWKxg7Q3gd4Kew0E2AcCQSi2mAlWv+MSIW0cMrRPCqsZtxGA
        7nHb+2C4hlUST3PFcc8KiASICLSs7Dp4uO3P4pU=
X-Google-Smtp-Source: AMsMyM5nGKKKGoptudRJdUoFlMuenxndpYAOpTPmBbm79CYxd+RQ5I9/R5KyzB/IngkAoSDOPicGHKV5ecsxRnSzWzg=
X-Received: by 2002:a9d:805:0:b0:63b:1981:588 with SMTP id 5-20020a9d0805000000b0063b19810588mr10974504oty.190.1663707898592;
 Tue, 20 Sep 2022 14:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220908063754.1369709-1-namhyung@kernel.org> <Yxo32kpxsl9Mr7Mt@kernel.org>
 <CAM9d7cgOPUoGr96yc=M=bBTQG-jkW269Lc7-uEYTWGURiCAjyQ@mail.gmail.com> <YyohGGdnX88YOXtR@kernel.org>
In-Reply-To: <YyohGGdnX88YOXtR@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Sep 2022 14:04:47 -0700
Message-ID: <CAM9d7ch7owDKkn9a89qkZ-KpSf02+OVJd01_76xMadA+vv3owQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf lock contention: Improve call stack handling (v1)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 20, 2022 at 1:22 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Sep 08, 2022 at 04:44:15PM -0700, Namhyung Kim escreveu:
> > Hi Arnaldo,
> >
> > On Thu, Sep 8, 2022 at 11:43 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Wed, Sep 07, 2022 at 11:37:50PM -0700, Namhyung Kim escreveu:
> > > > Hello,
> > > >
> > > > I found that call stack from the lock tracepoint (using bpf_get_stackid)
> > > > can be different on each configuration.  For example it's very different
> > > > when I run it on a VM than on a real machine.
> > > >
> > > > The perf lock contention relies on the stack trace to get the lock
> > > > caller names, this kind of difference can be annoying.  Ideally we could
> > > > skip stack trace entries for internal BPF or lock functions and get the
> > > > correct caller, but it's not the case as of today.  Currently it's hard
> > > > coded to control the behavior of stack traces for the lock contention
> > > > tracepoints.
> > > >
> > > > To handle those differences, add two new options to control the number of
> > > > stack entries and how many it skips.  The default value worked well on
> > > > my VM setup, but I had to use --stack-skip=5 on real machines.
> > > >
> > > > You can get it from 'perf/lock-stack-v1' branch in
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> > >
> > > This clashed with a patch you Acked earlier, so lets see if someone has
> > > extra review comments and a v2 become needed for other reason, when you
> > > can refresh it, ok?
> >
> > Sounds good!
>
> Have you resubmitted this? /me goes on the backlog...

Yep :)

https://lore.kernel.org/r/20220912055314.744552-1-namhyung@kernel.org
