Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4827C69C15F
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 17:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjBSQtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 11:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjBSQs7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 11:48:59 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCF212844;
        Sun, 19 Feb 2023 08:48:55 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id l5-20020a05600c4f0500b003dc4050c94aso692741wmq.4;
        Sun, 19 Feb 2023 08:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsCVWrbLL/D50N7P27MmqiJUQZU2UivM1r339HWQD0k=;
        b=a9/KqAy9P3QlpR4XtTZ82sxORtD9vVXj93bL3ixlwZgpThd49/zVjm9lCSg3zbn/ZV
         gJ88DkidKN0KHmj/qy9Onxys31GZvh6hki5s3/bZh1d+/Ws7ForSG8ws7KvqQnhufY1U
         WfA/LhUdgtIahn3gISzv2LKnnSdV3Lnlmbn4aPfhPLRYX2pL5xuy+oSK0d6Cg0AtfBw6
         Pwj+CC5RYy9vwoTPigzY1Z8G2GuI0SqpmIPHVdyrfG2AV41JyEKSlPbo65AIV8f3GLGY
         lJPnnRpi1xtKl+DCyHOu8GmN9anZo6GaLIY45QH9DiJuTJX5fNSd5ZUM/9z5TDisOhFg
         K3XQ==
X-Gm-Message-State: AO0yUKX6Q0WBSPW6UK6RBjoQfSS4WrCpXFqdN+JFOHPELDAAcDmbso/z
        RdV8/RMfPFwo3eMchf6InbANUYRexJSMZ+HQz5Y=
X-Google-Smtp-Source: AK7set+mVKstVfwjdkCojHGxAPiVA/T14JygnjkP5djwbBkCfMgP5aqesm1O+I/2G9xrS4PTHhLqrltcYVTXd60HSOw=
X-Received: by 2002:a05:600c:384a:b0:3d1:cb12:1013 with SMTP id
 s10-20020a05600c384a00b003d1cb121013mr778196wmr.165.1676825333622; Sun, 19
 Feb 2023 08:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20230219061329.1001079-1-namhyung@kernel.org> <20230219061329.1001079-3-namhyung@kernel.org>
 <Y/IEpW77gNpQbpK2@kernel.org>
In-Reply-To: <Y/IEpW77gNpQbpK2@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 19 Feb 2023 08:48:42 -0800
Message-ID: <CAM9d7chrbQ+79HRJF=e3DLA7rDL-LdNw2fVW3enjJjY+E-ESsQ@mail.gmail.com>
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

On Sun, Feb 19, 2023 at 3:14 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sat, Feb 18, 2023 at 10:13:23PM -0800, Namhyung Kim escreveu:
> > The BPF program will be attached to a perf_event and be triggered when
> > it overflows.  It'd iterate the filters map and compare the sample
> > value according to the expression.  If any of them fails, the sample
> > would be dropped.
> >
> > Also it needs to have the corresponding sample data for the expression
> > so it compares data->sample_flags with the given value.  To access the
> > sample data, it uses the bpf_cast_to_kern_ctx() kfunc which was added
> > in v6.2 kernel.
>
>   CLANG   /tmp/build/perf/util/bpf_skel/.tmp/sample_filter.bpf.o
> util/bpf_skel/sample_filter.bpf.c:26:19: error: no member named 'sample_flags' in 'struct perf_sample_data'
>         if ((kctx->data->sample_flags & entry->flags) == 0)
>              ~~~~~~~~~~  ^
> 1 error generated.
> make[2]: *** [Makefile.perf:1078: /tmp/build/perf/util/bpf_skel/.tmp/sample_filter.bpf.o] Error 1
> make[1]: *** [Makefile.perf:236: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
>
>  Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin':

Hmm.. strange.  In the include/linux/perf_event.h, the
perf_sample_data has sample_flags, but vmlinux.h doesn't.

Thanks,
Namhyung
