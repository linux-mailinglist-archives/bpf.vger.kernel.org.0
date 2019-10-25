Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFEE50D1
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504858AbfJYQIt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 12:08:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39469 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504327AbfJYQIt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 12:08:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id r141so2542312wme.4
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2019 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUAd15LRZOGwcYUMNoWJDAN25LcrehG7DRhTjZLaCUQ=;
        b=TX3fDtskQmARxaduJ9lW2PYUO1GrW/aaoetTvbCvWaK7Y6aiSmPid5yYypW/7fPr3S
         pTzYMe+iwvF8daPxny21YlbO3e25Jvl1JvaJitNVo4nuI3+/Y7OyCh+R7vTHG3kqoofX
         wjCQUO47OFRuIZkvZ2y1VJArRHsZODtnmnay4fne3iIlZR8JZJRFj2fvJLVqKwvk/zko
         bWiSWJZGL95li5wQSGofbVYJgioN1O9PVXwrDPm7fDK39g7hfCLzMjBnPcgzXh5is9qw
         GMXE/6DbCobNqz7yWibJaox8AUyumylmLg9TZ9QrObNXyNlUI8to+hEACV5igUw9BiIN
         sIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUAd15LRZOGwcYUMNoWJDAN25LcrehG7DRhTjZLaCUQ=;
        b=RMSAEKvK3841F/pWythp4zAYOpnrzXPcZh2lmWIMBzUs4zu//jmlLYbXMDDsPcgmud
         PbhKFeG2XkEMbalfELEzJyp/PSO4+0Nf4pz9DMYjZYCL0Suzovd28MDDL/aXJhT3jWie
         ZVROAyCcALqBJj85eWQqkq2+Psav0mUqeSRBgIX28RnyJ3goR4kNcZzYUp3rGPOW9pfN
         49YmK4BssxawuwmmUZFN44g9JEGUCCZrTBU+fQ5mXHqYcZ8YJWMWkHoYqj4DXGe+zTYk
         ND/CSwCLy6T8IAcQm9PWSTMAfHuz8/rBy3bONbtTtp1NCpsIMgJbfFL5cElNAV1GZrit
         nRVA==
X-Gm-Message-State: APjAAAWvLzvgBfnpICLADU4z2OoBmlkCzWHSNeK3J6KZtTpLRE/xrrjJ
        hU47sOhprNb3ZjFQIPJk5gEvgJxkYR0r7XhH8eW18Q==
X-Google-Smtp-Source: APXvYqxgEKH4JI31XMApFgp97WIl0mpGTv/DJYlY9rEO7toLsBkrC/1TRbAdMMaeG/BVltRL3FzSpAjcCsP0I2qd/rQ=
X-Received: by 2002:a1c:a791:: with SMTP id q139mr4111694wme.155.1572019725853;
 Fri, 25 Oct 2019 09:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191023005337.196160-1-irogers@google.com> <20191024190202.109403-1-irogers@google.com>
 <20191024190202.109403-7-irogers@google.com> <20191025082714.GH31679@krava>
In-Reply-To: <20191025082714.GH31679@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 25 Oct 2019 09:08:34 -0700
Message-ID: <CAP-5=fU6quu74JwZSd70UMTSS2wf_29hBgvdXfJZedOfrE7ohw@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] perf tools: add destructors for parse event terms
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 25, 2019 at 1:27 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Oct 24, 2019 at 12:01:59PM -0700, Ian Rogers wrote:
> > If parsing fails then destructors are ran to clean the up the stack.
> > Rename the head union member to make the term and evlist use cases more
> > distinct, this simplifies matching the correct destructor.
>
> nice did not know about this.. looks like it's been in bison for some time, right?

Looks like it wasn't in Bison 1 but in Bison 2, we're at Bison 3 and
Bison 2 is > 14 years old:
https://web.archive.org/web/20050924004158/http://www.gnu.org/software/bison/manual/html_mono/bison.html#Destructor-Decl

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.y | 69 +++++++++++++++++++++++-----------
> >  1 file changed, 48 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > index 545ab7cefc20..4725b14b9db4 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -12,6 +12,7 @@
> >  #include <stdio.h>
> >  #include <linux/compiler.h>
> >  #include <linux/types.h>
> > +#include <linux/zalloc.h>
> >  #include "pmu.h"
> >  #include "evsel.h"
> >  #include "parse-events.h"
> > @@ -37,6 +38,25 @@ static struct list_head* alloc_list()
> >       return list;
> >  }
> >
> > +static void free_list_evsel(struct list_head* list_evsel)
> > +{
> > +     struct perf_evsel *pos, *tmp;
> > +
> > +     list_for_each_entry_safe(pos, tmp, list_evsel, node) {
> > +             list_del_init(&pos->node);
> > +             perf_evsel__delete(pos);
> > +     }
> > +     free(list_evsel);
>
> I think you need to iterate 'struct evsel' in here, not 'struct perf_evsel'
>
> should be:
>
>         struct evsel *evsel, *tmp;
>
>         list_for_each_entry_safe(evsel, tmp, list_evsel, core.node) {
>                 list_del_init(&evsel->core.node);
>                 evsel__delete(evsel);
>         }

Thanks, I'll address this.

Ian

> thanks,
> jirka
>
> > +}
> > +
> > +static void free_term(struct parse_events_term *term)
> > +{
> > +     if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
> > +             free(term->val.str);
> > +     zfree(&term->array.ranges);
> > +     free(term);
> > +}
> > +
> >  static void inc_group_count(struct list_head *list,
> >                      struct parse_events_state *parse_state)
> >  {
> > @@ -66,6 +86,7 @@ static void inc_group_count(struct list_head *list,
> >  %type <num> PE_VALUE_SYM_TOOL
> >  %type <num> PE_RAW
> >  %type <num> PE_TERM
> > +%type <num> value_sym
> >  %type <str> PE_NAME
> >  %type <str> PE_BPF_OBJECT
> >  %type <str> PE_BPF_SOURCE
> > @@ -76,37 +97,43 @@ static void inc_group_count(struct list_head *list,
> >  %type <str> PE_EVENT_NAME
> >  %type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT
> >  %type <str> PE_DRV_CFG_TERM
> > -%type <num> value_sym
> > -%type <head> event_config
> > -%type <head> opt_event_config
> > -%type <head> opt_pmu_config
> > +%destructor { free ($$); } <str>
> >  %type <term> event_term
> > -%type <head> event_pmu
> > -%type <head> event_legacy_symbol
> > -%type <head> event_legacy_cache
> > -%type <head> event_legacy_mem
> > -%type <head> event_legacy_tracepoint
> > +%destructor { free_term ($$); } <term>
> > +%type <list_terms> event_config
> > +%type <list_terms> opt_event_config
> > +%type <list_terms> opt_pmu_config
> > +%destructor { parse_events_terms__delete ($$); } <list_terms>
> > +%type <list_evsel> event_pmu
> > +%type <list_evsel> event_legacy_symbol
> > +%type <list_evsel> event_legacy_cache
> > +%type <list_evsel> event_legacy_mem
> > +%type <list_evsel> event_legacy_tracepoint
> > +%type <list_evsel> event_legacy_numeric
> > +%type <list_evsel> event_legacy_raw
> > +%type <list_evsel> event_bpf_file
> > +%type <list_evsel> event_def
> > +%type <list_evsel> event_mod
> > +%type <list_evsel> event_name
> > +%type <list_evsel> event
> > +%type <list_evsel> events
> > +%type <list_evsel> group_def
> > +%type <list_evsel> group
> > +%type <list_evsel> groups
> > +%destructor { free_list_evsel ($$); } <list_evsel>
> >  %type <tracepoint_name> tracepoint_name
> > -%type <head> event_legacy_numeric
> > -%type <head> event_legacy_raw
> > -%type <head> event_bpf_file
> > -%type <head> event_def
> > -%type <head> event_mod
> > -%type <head> event_name
> > -%type <head> event
> > -%type <head> events
> > -%type <head> group_def
> > -%type <head> group
> > -%type <head> groups
> > +%destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
> >  %type <array> array
> >  %type <array> array_term
> >  %type <array> array_terms
> > +%destructor { free ($$.ranges); } <array>
> >
> >  %union
> >  {
> >       char *str;
> >       u64 num;
> > -     struct list_head *head;
> > +     struct list_head *list_evsel;
> > +     struct list_head *list_terms;
> >       struct parse_events_term *term;
> >       struct tracepoint_name {
> >               char *sys;
> > --
> > 2.23.0.866.gb869b98d4c-goog
> >
>
