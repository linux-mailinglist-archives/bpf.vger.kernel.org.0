Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9978A696C3A
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 19:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjBNSDd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 13:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjBNSDb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 13:03:31 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A29A8;
        Tue, 14 Feb 2023 10:03:31 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id u20so1435432vsp.5;
        Tue, 14 Feb 2023 10:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGOa4TJfceKNfHiP6Y/llnztIjw1KykBvp/xFMHKCMg=;
        b=K94SGH3GAi+WXq3YseW49xIBbzyTu4Id0DdW/3Aq+M2IQOzOfwGMn3Oo5DCrxVCRbY
         bI5HOFoXBQZ9w1IZWnwLN3UGEaNvq1TY9+RitAN2R9LHxhzhX8TqgvIY+l2P6nq3vcyE
         V2WvOqgzXySEZ6rxlShVejGKOGoH+7us3H6QmHgeGf2Wb8ITzhSCKsQbgddymO0F1+hv
         kd0TqHgy8azfkJc7CA7+C39JUbQbr+cXNqNeMJz8Nz6q07ysN5L6P0PYS6NYAKvoKDvF
         QzIF2kd3mLXIMJ/VWQ7phtgNDCerqJpdSVQfFXZGeKJYNf8Sc02Kt9QgtdypaZF54vfq
         Fnvg==
X-Gm-Message-State: AO0yUKXmfm5rRlRYK5RGUpLfdm0JPietBlxN+hG6vn+bvi+6nscdRJOk
        1lJhELNecQiOjEdUT0IFShBhTSG6+gsudkjR5tA=
X-Google-Smtp-Source: AK7set+L3wtyGWF9Ao7v3qvtWZADbG7yigAnMne+6hRFKt01icvwXCXYZVadWz5Zv5+WuSOWPm0ubE5DKo3oQdlbyTc=
X-Received: by 2002:a67:b305:0:b0:412:194f:e67b with SMTP id
 a5-20020a67b305000000b00412194fe67bmr548974vsm.15.1676397810116; Tue, 14 Feb
 2023 10:03:30 -0800 (PST)
MIME-Version: 1.0
References: <20230214050452.26390-1-namhyung@kernel.org> <20230214050452.26390-2-namhyung@kernel.org>
 <CAP-5=fWn3ybuoJSsP8G1JmgEgUC2mY3A+0kscfN5DAJeiRK_eg@mail.gmail.com>
In-Reply-To: <CAP-5=fWn3ybuoJSsP8G1JmgEgUC2mY3A+0kscfN5DAJeiRK_eg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Feb 2023 10:03:19 -0800
Message-ID: <CAM9d7cjptc03upu7kct=MA3uxEwieO0Nt-r=LHSedDNDScSOQg@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf bpf filter: Introduce basic BPF filter expression
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
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

On Tue, Feb 14, 2023 at 8:10 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Feb 13, 2023 at 9:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
[SNIP]
> > diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
> > new file mode 100644
> > index 000000000000..0bf36ec30abf
> > --- /dev/null
> > +++ b/tools/perf/util/bpf-filter.y
> > @@ -0,0 +1,52 @@
> > +%parse-param {struct list_head *expr_head}
> > +
> > +%{
> > +
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <linux/compiler.h>
> > +#include <linux/list.h>
> > +#include "bpf-filter.h"
> > +
> > +static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
> > +                                 char const *msg)
> > +{
> > +       printf("perf_bpf_filter: %s\n", msg);
> > +}
> > +
> > +%}
> > +
> > +%union
> > +{
> > +       unsigned long num;
> > +       unsigned long sample;
> > +       enum perf_bpf_filter_op op;
> > +       struct perf_bpf_filter_expr *expr;
> > +}
> > +
> > +%token BFT_SAMPLE BFT_OP BFT_ERROR BFT_NUM
> > +%type <expr> filter_term
>
> To avoid memory leaks for parse errors, I think you want here:
> %destructor { free($$); } <expr>

Sure, thanks for the suggestion.

Namhyung
