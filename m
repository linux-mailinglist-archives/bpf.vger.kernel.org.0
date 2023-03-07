Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AFF6AF709
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 21:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCGU5l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 15:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjCGU5k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 15:57:40 -0500
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63D4ABB12;
        Tue,  7 Mar 2023 12:57:38 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id e82so12735055ybh.9;
        Tue, 07 Mar 2023 12:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MYcGa0FDnlV4+RzWjtLODWC2bUWFcR+22ILhsmpYos=;
        b=fLOaBg6I4gENBB6PkFZRhIY76i55U8VCubkWkUPqs3HN9cY6fnf6BBvCDJK0c6d6BU
         WH2Gy/lOjTOQJvDRFxmfbWwopcWep2/ouwoEYATuH/scAsqPmTtWrwOOidAE86PMztru
         UQhaN2jSk3yeITd6iQqLe9VoGE4XK7xtN++RbiZ80ev0cAZ09c0bLkWK5DWvHTDgjoc1
         eJdfnr7l7Q7ppLiV5lwHTo7PLqT238/5E9JYjNIGaK/qu1E44p7+OLWvOqOm09tR9CrE
         Q5WQPF3Vc4SUGPA2B69+A431wBeC/pobq2hWb/SYMW2iddYwoL+/KIR1mgm++jbsdQMw
         Gomg==
X-Gm-Message-State: AO0yUKUdvSf763CyHlxM7T+AcaNZCwjiSM5OHLjb443L9FdntSbTRmT7
        9YSRCquVDTL6MOsR2nHpWYGpatgA1nE0AmNI+cY=
X-Google-Smtp-Source: AK7set/NoV8+bRWpR4hZCAOIMHd3+do8A/zUKt46TPa8iqSccqhy9UJIMdg50xkil+9ptQtV6bzaoKq91dllqtIWoMA=
X-Received: by 2002:a5b:38a:0:b0:ac9:cb97:bd0e with SMTP id
 k10-20020a5b038a000000b00ac9cb97bd0emr7471455ybp.5.1678222657924; Tue, 07 Mar
 2023 12:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20230222230141.1729048-1-namhyung@kernel.org> <20230222230141.1729048-3-namhyung@kernel.org>
 <0c4afcfb-fe9a-89ac-16aa-57ce0d2a70bc@intel.com>
In-Reply-To: <0c4afcfb-fe9a-89ac-16aa-57ce0d2a70bc@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 7 Mar 2023 12:57:26 -0800
Message-ID: <CAM9d7chU4pPVTT1rFvr4zP27c5DOVuX6MJi6qBw9SgN1B-Ezww@mail.gmail.com>
Subject: Re: [PATCH 2/8] perf bpf filter: Implement event sample filtering
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
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

Hi Adrian,

Thanks for your feedback!

On Tue, Mar 7, 2023 at 5:04 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 23/02/23 01:01, Namhyung Kim wrote:
> > The BPF program will be attached to a perf_event and be triggered when
> > it overflows.  It'd iterate the filters map and compare the sample
> > value according to the expression.  If any of them fails, the sample
> > would be dropped.
> >
> > Also it needs to have the corresponding sample data for the expression
> > so it compares data->sample_flags with the given value.  To access the
> > sample data, it uses the bpf_cast_to_kern_ctx() kfunc which was added
> > in v6.2 kernel.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>

[SNIP]
> > diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
> > index fd5b1164a322..6077930073f9 100644
> > --- a/tools/perf/util/bpf-filter.h
> > +++ b/tools/perf/util/bpf-filter.h
> > @@ -4,15 +4,7 @@
> >
> >  #include <linux/list.h>
> >
> > -enum perf_bpf_filter_op {
> > -     PBF_OP_EQ,
> > -     PBF_OP_NEQ,
> > -     PBF_OP_GT,
> > -     PBF_OP_GE,
> > -     PBF_OP_LT,
> > -     PBF_OP_LE,
> > -     PBF_OP_AND,
> > -};
> > +#include "bpf_skel/sample-filter.h"
> >
> >  struct perf_bpf_filter_expr {
> >       struct list_head list;
> > @@ -21,16 +13,30 @@ struct perf_bpf_filter_expr {
> >       unsigned long val;
> >  };
> >
> > +struct evsel;
> > +
> >  #ifdef HAVE_BPF_SKEL
> >  struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
> >                                                      enum perf_bpf_filter_op op,
> >                                                      unsigned long val);
> >  int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
> > +int perf_bpf_filter__prepare(struct evsel *evsel);
> > +int perf_bpf_filter__destroy(struct evsel *evsel);
> > +
> >  #else /* !HAVE_BPF_SKEL */
> > +
> >  static inline int perf_bpf_filter__parse(struct list_head *expr_head __maybe_unused,
> >                                        const char *str __maybe_unused)
> >  {
> >       return -ENOSYS;
>
> Any reason for ENOSYS instead of say EOPNOTSUPP?

No specific reason.  I can change it to EOPNOTSUPP.

>
> >  }
> > +static inline int perf_bpf_filter__prepare(struct evsel *evsel)
>
> Needs  __maybe_unused on the parameters

Sure.

>
> > +{
> > +     return -ENOSYS;
> > +}
> > +static inline int perf_bpf_filter__destroy(struct evsel *evsel)
>
> Needs  __maybe_unused on the parameters

Will do.

Thanks,
Namhyung
