Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74951D5C08
	for <lists+bpf@lfdr.de>; Sat, 16 May 2020 00:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgEOWD3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 18:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgEOWD2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 May 2020 18:03:28 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E7C05BD0A
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 15:03:28 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id a10so1895584ybc.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAuns5l+V0vwIv3z0kLgsyRcBseJuPIzou+9SjbnNYk=;
        b=Q41c+n8yK3nkE3KDJdYhiZiAf04uT8mHpZRDb8LE9n2aTAq1FORypaxmgE+gDKOUQw
         XgmE1rrLddyYi6BvRhTpUZGcbSG9WZ4laYZ/IsOQ5McL2z5nhvUo8LoOPaVLULfkSJxV
         fHfq0IjeQjp9CpDRbkwM790U4XVnPDGPrI4p21eO5Ib59s5h8FpNgx4YwRUOJ4N2qnUk
         vTTYOJLfNG5qTjOyAP+P5zN0ehyw6s3ofnQpoyTPIHB8LfKqimn3eokLjj4qQ/sdZ4Ib
         /uU60ACLgOtg2gvO4J5Gke8xnpFW5a9XAfQK2Q65DgzFRHtelZU1+bGJjM9/dUnDoOws
         Ldvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAuns5l+V0vwIv3z0kLgsyRcBseJuPIzou+9SjbnNYk=;
        b=J1WjAQTEoTSTU4mSrkGp0cOrke9dGuDhPfp7i4VIluPfwfhwUckzSSx33asvxRzA74
         mqN0hD6GshV1XpVNw9Ow7Y6gp9SsfajYSQFFNJ7HKJGhjN5Y9q+tlCKoWE2S0E9W8PIc
         sBIhr8P+4hiQfTf1dwDTbw7skGMKD8i/37W4jDB/29mNqNM+NC3SyZi/CG8KAR/luzse
         8EfsrQQm1wx0t7aA6Vg4zYD3GZgOmb0CYCYbaK+1vnmcEk5hZ251D90oZ64ZtONrbpuP
         HO2PcRE/j5PCysLVd+aWFol2ck4Semh768L/UROc55tRPKQQ6ItCo8jwRv3xRLG7i9vL
         8XiQ==
X-Gm-Message-State: AOAM532TU39qRmcqGuwjwmAMaEbinnDTdy0865r8y9enbzGGkZoK5vNA
        oDJC+h/GMcpwUt97gEqgL8UBnRYGHgb/C4Sn/lEx3w==
X-Google-Smtp-Source: ABdhPJzfqW9TpPIr4WyY6xHhbnwlZYh3KZfmffOwbln4Qe2yqXWQ03KcYpFkzfLBZh3oqp6m7nE1uizCVUgjHaSw5cE=
X-Received: by 2002:a25:5387:: with SMTP id h129mr8404945ybb.47.1589580207492;
 Fri, 15 May 2020 15:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200515165007.217120-1-irogers@google.com> <20200515165007.217120-8-irogers@google.com>
 <CAEf4BzZOB0L0iie0CAduNOnE4TXbfKeo-g97kwfMPZ5Mg7uRwg@mail.gmail.com>
In-Reply-To: <CAEf4BzZOB0L0iie0CAduNOnE4TXbfKeo-g97kwfMPZ5Mg7uRwg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 15 May 2020 15:03:16 -0700
Message-ID: <CAP-5=fV83V_DxaR8M4LXgS-s-+gW18Q3UmfjrpAkz4u2K4B7MA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] perf expr: Migrate expr ids table to a hashmap
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 15, 2020 at 12:39 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, May 15, 2020 at 9:51 AM Ian Rogers <irogers@google.com> wrote:
> >
> > Use a hashmap between a char* string and a double* value. While bpf's
> > hashmap entries are size_t in size, we can't guarantee sizeof(size_t) >=
> > sizeof(double). Avoid a memory allocation when gathering ids by making 0.0
> > a special value encoded as NULL.
> >
> > Original map suggestion by Andi Kleen:
> > https://lore.kernel.org/lkml/20200224210308.GQ160988@tassilo.jf.intel.com/
> > and seconded by Jiri Olsa:
> > https://lore.kernel.org/lkml/20200423112915.GH1136647@krava/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/expr.c       |  40 ++++++-----
> >  tools/perf/tests/pmu-events.c |  25 +++----
> >  tools/perf/util/expr.c        | 129 +++++++++++++++++++---------------
> >  tools/perf/util/expr.h        |  26 +++----
> >  tools/perf/util/expr.y        |  22 +-----
> >  tools/perf/util/metricgroup.c |  87 +++++++++++------------
> >  tools/perf/util/stat-shadow.c |  49 ++++++++-----
> >  7 files changed, 197 insertions(+), 181 deletions(-)
> >
> > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > index 3f742612776a..5e606fd5a2c6 100644
> > --- a/tools/perf/tests/expr.c
> > +++ b/tools/perf/tests/expr.c
> > @@ -19,11 +19,9 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
> >  int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> >  {
> >         const char *p;
> > -       const char **other;
> > -       double val;
> > -       int i, ret;
> > +       double val, *val_ptr;
> > +       int ret;
> >         struct expr_parse_ctx ctx;
> > -       int num_other;
> >
> >         expr__ctx_init(&ctx);
> >         expr__add_id(&ctx, "FOO", 1);
> > @@ -52,25 +50,29 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> >         ret = expr__parse(&val, &ctx, p, 1);
> >         TEST_ASSERT_VAL("missing operand", ret == -1);
> >
> > +       hashmap__clear(&ctx.ids);
>
> hashmap__clear() will free up memory allocated for hashmap itself and
> hash entries, but not keys/values. Unless it's happening somewhere
> else, you'll need to do something similar to expr__ctx_clear() below?

In this case the const char* keys come from the literals added on
lines 27 and 28 and so didn't need free-ing - which is what
expr__ctx_clear() does. I've made these literals strdups and switched
to expr__ctx_clear() as you suggest, as this is more reflective of the
real use.

> Same below for another "lone" hashmap_clear() call.

This was a memory leak, thanks!
Ian

> >         TEST_ASSERT_VAL("find other",
> > -                       expr__find_other("FOO + BAR + BAZ + BOZO", "FOO", &other, &num_other, 1) == 0);
>
> [...]
