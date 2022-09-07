Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ADD5AFCF0
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 08:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiIGG6X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 02:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIGG6W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 02:58:22 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82C48FD52;
        Tue,  6 Sep 2022 23:58:21 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1278a61bd57so15293821fac.7;
        Tue, 06 Sep 2022 23:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=d2GxsBffUoX3eM3Z9JvRT1gNftYOiyqMQZCPJIetS/o=;
        b=397koPNSKD4670SYO4FRp68vrXpBO5cEGeGBxcNN+jr9smvMTa+X1KS1PWbw6sDPGN
         9x7+G4TnWpnkFxqonTPY/H1DII+57+USRZi21DuQoNbARLcMv4GJeKO2+vbVuers9xBP
         KMckgp38yzWJbpFnfCZi3JkqqsG9f0rQaVMEX7IY35sf+ddpbaV48SX8li/PVcI1mTIU
         +oRIAgQrvpdWZzKXUSkzz5J8zqiu0P+EUZHyy7xsN7QekAaZ/FUmZ/Bdp9c35kWwBoUs
         MJol3fXMSdNqmiMrKWi/p69/Zj+9S1gMWbfaa0IA0UDywZshq22w+c5Jnqaq9xFTIxFn
         2omw==
X-Gm-Message-State: ACgBeo1LroH0okj1Tpnoiq78sg6HSyMs88OFhmBTaFXllEZqMuAGVP+W
        E6W/dpGS9i8SMP6jxiHjkCv33b9BaU8g2qSWYwwzlzw0
X-Google-Smtp-Source: AA6agR7eviQAT6IDpbbvRlqqBpL0NbF0igKjLYiuZbEZCoA+REG/y+NW3RA8tVNkQUMhLtD3+GIeVNNgs3+WFH+kyy0=
X-Received: by 2002:a05:6808:d46:b0:345:7b42:f987 with SMTP id
 w6-20020a0568080d4600b003457b42f987mr910550oik.92.1662533901033; Tue, 06 Sep
 2022 23:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220907050407.2711513-1-namhyung@kernel.org> <CAPhsuW4OT3XC8oREZBNreesYyVvU9hSGs5Hgz=r-cwsQSkiXRQ@mail.gmail.com>
In-Reply-To: <CAPhsuW4OT3XC8oREZBNreesYyVvU9hSGs5Hgz=r-cwsQSkiXRQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 6 Sep 2022 23:58:10 -0700
Message-ID: <CAM9d7cjZ4jJDx0wL5BQ1f4BvT=r0S72Z_q83WwvOdB8cQGzRKw@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Skip sigtrap test on old kernels
To:     Song Liu <song@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Marco Elver <elver@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

On Tue, Sep 6, 2022 at 10:58 PM Song Liu <song@kernel.org> wrote:
>
> On Tue, Sep 6, 2022 at 10:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > If it runs on an old kernel, perf_event_open would fail because of the
> > new fields sigtrap and sig_data.  Just skipping the test could miss an
> > actual bug in the kernel.
> >
> > Let's check BTF if it has the perf_event_attr.sigtrap field.
> >
> > Cc: Marco Elver <elver@google.com>
> > Cc: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/sigtrap.c | 46 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> > index e32ece90e164..32f08ce0f2b0 100644
> > --- a/tools/perf/tests/sigtrap.c
> > +++ b/tools/perf/tests/sigtrap.c
> > @@ -16,6 +16,8 @@
> >  #include <sys/syscall.h>
> >  #include <unistd.h>
> >
> > +#include <bpf/btf.h>
> > +
>
> Do we need "#ifdef HAVE_BPF_SKEL" for the include part?

Right, it'd be better to move it under the #ifdef.  Will change.

>
> Other than this, looks good to me.
>
> Acked-by: Song Liu <song@kernel.org>

Thanks for the review!
Namhyung
