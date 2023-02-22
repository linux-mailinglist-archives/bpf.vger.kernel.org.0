Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7C169FC74
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 20:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjBVTs5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 14:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjBVTs4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 14:48:56 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2AB27D7F;
        Wed, 22 Feb 2023 11:48:55 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id v3so10764566vse.0;
        Wed, 22 Feb 2023 11:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XM/lQi5N/iiNMtRIy5H0b7ls2dpYLYTqiw3Gl5EGGP8=;
        b=3DLr0kLc5pVMx2L5ETn0W75sSNp5V8ejVqbJb1VTNUNbMyu7ohRz8fk2g1lOGVjmyO
         SQrJ2Ni6W0sNcBdofx1hW4APGtVeBoICQVm2Nc+9IW5AGPXpthQ3up+DKia9GU4cav6c
         FcqvgpC2tsD9HIMB3w7OV5OLVgm/5OtHqREVZq6oHDxSzBk20MSCC1fgsoTht2fSC+NK
         Ex7eT9pVXZ26+WFNL9geVozn26yDnkjvzscLZvDK3uvS5YziSv+4KpcVYE7XqEP0wjpt
         Uxj22+ox3sbigPJb/2HwS/DtTx6vvRI1UjWgCS0gd7COvzN60ojjyHEK6VfVngwTzeuR
         4C1g==
X-Gm-Message-State: AO0yUKUr/PbRGV2SA8BOPMlt6yGU1kzvCVsqKYouWxWGlLrx1BAgQY4d
        QcCum6sorjLauFmgR+2iHo3yGLCY5XxsJgfjm64=
X-Google-Smtp-Source: AK7set/JOuNdH1Xqx90bNX1Aqnfcv1+F2m1Exkm49i1plXuAeh7llPRwlEUfRRIxFP8Elkp8A+malkHf1PZvkQv5kB0=
X-Received: by 2002:ab0:54da:0:b0:687:afc8:ffb9 with SMTP id
 q26-20020ab054da000000b00687afc8ffb9mr1587192uaa.2.1677095334627; Wed, 22 Feb
 2023 11:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20230219061329.1001079-1-namhyung@kernel.org> <20230219061329.1001079-3-namhyung@kernel.org>
 <Y/IEpW77gNpQbpK2@kernel.org> <CAM9d7chrbQ+79HRJF=e3DLA7rDL-LdNw2fVW3enjJjY+E-ESsQ@mail.gmail.com>
In-Reply-To: <CAM9d7chrbQ+79HRJF=e3DLA7rDL-LdNw2fVW3enjJjY+E-ESsQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 22 Feb 2023 11:48:43 -0800
Message-ID: <CAM9d7cg_bnLuYN+SnS_m6gV2qto8hVGF1oYE7gSko=TuY-dpOQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] perf bpf filter: Implement event sample filtering
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
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

On Sun, Feb 19, 2023 at 8:48 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Sun, Feb 19, 2023 at 3:14 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Sat, Feb 18, 2023 at 10:13:23PM -0800, Namhyung Kim escreveu:
> > > The BPF program will be attached to a perf_event and be triggered when
> > > it overflows.  It'd iterate the filters map and compare the sample
> > > value according to the expression.  If any of them fails, the sample
> > > would be dropped.
> > >
> > > Also it needs to have the corresponding sample data for the expression
> > > so it compares data->sample_flags with the given value.  To access the
> > > sample data, it uses the bpf_cast_to_kern_ctx() kfunc which was added
> > > in v6.2 kernel.
> >
> >   CLANG   /tmp/build/perf/util/bpf_skel/.tmp/sample_filter.bpf.o
> > util/bpf_skel/sample_filter.bpf.c:26:19: error: no member named 'sample_flags' in 'struct perf_sample_data'
> >         if ((kctx->data->sample_flags & entry->flags) == 0)
> >              ~~~~~~~~~~  ^
> > 1 error generated.
> > make[2]: *** [Makefile.perf:1078: /tmp/build/perf/util/bpf_skel/.tmp/sample_filter.bpf.o] Error 1
> > make[1]: *** [Makefile.perf:236: sub-make] Error 2
> > make: *** [Makefile:113: install-bin] Error 2
> > make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> >
> >  Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin':
>
> Hmm.. strange.  In the include/linux/perf_event.h, the
> perf_sample_data has sample_flags, but vmlinux.h doesn't.

It looks like the vmlinux.h came from the old kernel image (before v6.1).
Please try again after building the kernel.  I'll add a check to prevent
such a build error in v3.

Thanks,
Namhyung
