Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1811A69FC7D
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 20:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjBVTvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 14:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjBVTvA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 14:51:00 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AD943440;
        Wed, 22 Feb 2023 11:50:57 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id x14so11041560vso.9;
        Wed, 22 Feb 2023 11:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677095456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REE+ef0e7B87qEFp3QV5xjO+8g40xyGabze32yJEghU=;
        b=cGlttOgOaJOT9DsDX0wjk/KNEgI+9AYjMTL8pNWhtDpuoWvDbB073ASuUSkzpjNLLh
         3tESOytjJsfP4l3iWx1LGx+IM5BsuLS0M7uQsInotri53PIdTGQLbcU5OtmMIuNDO/XK
         5WG+GJRl/orBE4ce/TKMYJGP3dkVQDKvyHwYgMh16gTvHTQq6ZOY+fThN1uOLMJZEvx9
         lVyGsEUG4KpgEvrqlzjv3v2lIbGVWuwQvrXahM+AHUZh0m4szMEwGafdr/1GpiLFZBGY
         e5drSghIgTuR6hO/fwG+XQA7jYFyaH5hVDqi9dXWUJiPpk49V+/roSw/reKUj9KKGbz/
         bG8A==
X-Gm-Message-State: AO0yUKV2oDyp2h5KHz/Wj6v5cne1B5QYS2IxhlKTYTfK/nUpK02SSTEG
        K+SPW/51WL45y4io5/pfEZNj5ZaIkU/FmKOHcwxhy2rw
X-Google-Smtp-Source: AK7set+ix5t9sPDbnKvhcT2dxs2wUW9xzkkKlAcueIrwb0TvkJS3OtsqfCQHHKGtOkpm7l0dXW+zjcXkKgApy6ni9Ac=
X-Received: by 2002:a05:6122:84a:b0:411:b190:fe5b with SMTP id
 10-20020a056122084a00b00411b190fe5bmr205060vkk.39.1677095456147; Wed, 22 Feb
 2023 11:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20230219061329.1001079-1-namhyung@kernel.org> <20230219061329.1001079-4-namhyung@kernel.org>
 <Y/Sw9Cd5nvf/YKjA@krava>
In-Reply-To: <Y/Sw9Cd5nvf/YKjA@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 22 Feb 2023 11:50:45 -0800
Message-ID: <CAM9d7cj_gm7m344Q4GS2v4cBzJWqL=s0POON-9e9DE4p8ohX-Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf record: Add BPF event filter support
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
> On Sat, Feb 18, 2023 at 10:13:24PM -0800, Namhyung Kim wrote:
>
> SNIP
>
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 8374117e66f6..6429915d376d 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -52,6 +52,7 @@
> >  #include "util/pmu-hybrid.h"
> >  #include "util/evlist-hybrid.h"
> >  #include "util/off_cpu.h"
> > +#include "util/bpf-filter.h"
> >  #include "asm/bug.h"
> >  #include "perf.h"
> >  #include "cputopo.h"
> > @@ -1364,6 +1365,14 @@ static int record__open(struct record *rec)
> >
> >       session->evlist = evlist;
> >       perf_session__set_id_hdr_size(session);
> > +
> > +     evlist__for_each_entry(evlist, pos) {
> > +             if (list_empty(&pos->bpf_filters))
> > +                     continue;
> > +             rc = perf_bpf_filter__prepare(pos);
> > +             if (rc)
> > +                     break;
> > +     }
>
> might fit better under evlist__apply_filters ?

Right, it'd be better.  Will move.

Thanks,
Namhyung
