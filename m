Return-Path: <bpf+bounces-13158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03C97D5C9E
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 22:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7561C20CAD
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 20:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6E439940;
	Tue, 24 Oct 2023 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2IGGYXkm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAEC79D6
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 20:52:41 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E5E10D4
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 13:52:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40837124e1cso27215e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 13:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698180755; x=1698785555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc+eG35bw1iGZpwNNHM4lO0BDe5utnOWKic0Qw9r840=;
        b=2IGGYXkmwtc7wPMOSEQx9yblKO74epuBGdRk3+sXBxQeKp/zA/6F5mFxe59v8i3Vwu
         C8JZYgvovm6n/32T1nROm04br6J5pSE6CgiS3q7nDPPEFaitp4l17G2A2oE47vPej/9o
         bt3M19NHdKUG2UqgS6FcWAiNqrmpC882vlQXTf4HeT6OnjjkCepWguR76nC5UCxgsM+8
         M4ZJ81wLwdKHm68ip7uVrQAoyGyhobzaim5rNdHesRMVPlwTsmHCqBsp72bsKvXdIphp
         pwVqLaJk0qVmamQFKxprUkXMi/N+LQ0YW+jC+4NHtEjDFIp/o87n9DB6cUJ2ponnY39h
         DcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698180755; x=1698785555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uc+eG35bw1iGZpwNNHM4lO0BDe5utnOWKic0Qw9r840=;
        b=COgVeHLt0u5rBT8EIJkEVLpTy6VEblbc1nsdYK8m2g9oYT4OqeTVSKHyH0q7wUuLhY
         XYjmkub4K72UyhGrBiuECgGC7V7WJR44NDDk9HMnUfB4myGE5Od5xE8N3peJKeVtAhjL
         DVCZ2J5VfcUyZuRSzaODf6KAy41qqK1w6JPkSAG6lnw4yrwYxc6L6wZ3e4Y6Ne6+0S7M
         YWDuklS2BfTOH6+AaP8dvCUgKJVlzd6x8IqCNESnPz+WFEwUKpvEeJhKB7ddyV+Tw5np
         FflWHrupC6ft4TW2xpJkDNRVdhgyVEJUm88jaN/rMU+FQAfrjWoxNtvkYx6AiYdBIXOM
         2aXQ==
X-Gm-Message-State: AOJu0Yzia4FuG66BGZWiS0CIFfw1LZi/SwZ1AthRSFgDyN2bTo/tZTmW
	ZHoXcIPZMjAQ8qomTa7EAsx01NGkXjLdiK1stQgEnQ==
X-Google-Smtp-Source: AGHT+IETMDtk6wyzOKg0bJiP64pef7TGydfCj428yOrlmahhZTy+ZQFoPtC2M+gLd0x4a8TD8TJezhZ/hQXskFR1SjI=
X-Received: by 2002:a05:600c:4f02:b0:404:74f8:f47c with SMTP id
 l2-20020a05600c4f0200b0040474f8f47cmr8525wmq.5.1698180754478; Tue, 24 Oct
 2023 13:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com> <20231012062359.1616786-10-irogers@google.com>
 <CAM9d7cih9+DCKzVXBFTMUfjjY6ZX-yrj3CEM+Q3tjTNRYmQ=Yw@mail.gmail.com>
In-Reply-To: <CAM9d7cih9+DCKzVXBFTMUfjjY6ZX-yrj3CEM+Q3tjTNRYmQ=Yw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Oct 2023 13:52:22 -0700
Message-ID: <CAP-5=fXzpDbzoL0CVeB8ewv37MNUYyXZahgJZQ=qxRh882jozw@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] perf mem_info: Add and use map_symbol__exit and addr_map_symbol__exit
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>, 
	German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 4:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Oct 11, 2023 at 11:24=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Fix leak where mem_info__put wouldn't release the maps/map as used by
> > perf mem. Add exit functions and use elsewhere that the maps and map
> > are released.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/Build        |  1 +
> >  tools/perf/util/callchain.c  | 15 +++++----------
> >  tools/perf/util/hist.c       |  6 ++----
> >  tools/perf/util/machine.c    |  6 ++----
> >  tools/perf/util/map_symbol.c | 15 +++++++++++++++
> >  tools/perf/util/map_symbol.h |  4 ++++
> >  tools/perf/util/symbol.c     |  5 ++++-
> >  7 files changed, 33 insertions(+), 19 deletions(-)
> >  create mode 100644 tools/perf/util/map_symbol.c
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 0ea5a9d368d4..96058f949ec9 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -49,6 +49,7 @@ perf-y +=3D dso.o
> >  perf-y +=3D dsos.o
> >  perf-y +=3D symbol.o
> >  perf-y +=3D symbol_fprintf.o
> > +perf-y +=3D map_symbol.o
> >  perf-y +=3D color.o
> >  perf-y +=3D color_config.o
> >  perf-y +=3D metricgroup.o
> > diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> > index 0a7919c2af91..02881d5b822c 100644
> > --- a/tools/perf/util/callchain.c
> > +++ b/tools/perf/util/callchain.c
> > @@ -1496,16 +1496,14 @@ static void free_callchain_node(struct callchai=
n_node *node)
> >
> >         list_for_each_entry_safe(list, tmp, &node->parent_val, list) {
> >                 list_del_init(&list->list);
> > -               map__zput(list->ms.map);
> > -               maps__zput(list->ms.maps);
> > +               map_symbol__exit(&list->ms);
> >                 zfree(&list->brtype_stat);
> >                 free(list);
> >         }
> >
> >         list_for_each_entry_safe(list, tmp, &node->val, list) {
> >                 list_del_init(&list->list);
> > -               map__zput(list->ms.map);
> > -               maps__zput(list->ms.maps);
> > +               map_symbol__exit(&list->ms);
> >                 zfree(&list->brtype_stat);
> >                 free(list);
> >         }
> > @@ -1591,8 +1589,7 @@ int callchain_node__make_parent_list(struct callc=
hain_node *node)
> >  out:
> >         list_for_each_entry_safe(chain, new, &head, list) {
> >                 list_del_init(&chain->list);
> > -               map__zput(chain->ms.map);
> > -               maps__zput(chain->ms.maps);
> > +               map_symbol__exit(&chain->ms);
> >                 zfree(&chain->brtype_stat);
> >                 free(chain);
> >         }
> > @@ -1676,10 +1673,8 @@ void callchain_cursor_reset(struct callchain_cur=
sor *cursor)
> >         cursor->nr =3D 0;
> >         cursor->last =3D &cursor->first;
> >
> > -       for (node =3D cursor->first; node !=3D NULL; node =3D node->nex=
t) {
> > -               map__zput(node->ms.map);
> > -               maps__zput(node->ms.maps);
> > -       }
> > +       for (node =3D cursor->first; node !=3D NULL; node =3D node->nex=
t)
> > +               map_symbol__exit(&node->ms);
> >  }
> >
> >  void callchain_param_setup(u64 sample_type, const char *arch)
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index ac8c0ef48a7f..d62693b8fad8 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -524,8 +524,7 @@ static int hist_entry__init(struct hist_entry *he,
> >                 map__put(he->mem_info->daddr.ms.map);
> >         }
> >  err:
> > -       maps__zput(he->ms.maps);
> > -       map__zput(he->ms.map);
> > +       map_symbol__exit(&he->ms);
> >         zfree(&he->stat_acc);
> >         return -ENOMEM;
> >  }
> > @@ -1317,8 +1316,7 @@ void hist_entry__delete(struct hist_entry *he)
> >         struct hist_entry_ops *ops =3D he->ops;
> >
> >         thread__zput(he->thread);
> > -       maps__zput(he->ms.maps);
> > -       map__zput(he->ms.map);
> > +       map_symbol__exit(&he->ms);
> >
> >         if (he->branch_info) {
> >                 map__zput(he->branch_info->from.ms.map);
>
> What about he->branch_info and he->mem_info ?
>
> Also I think we can use it in hists__account_cycles() too.

Thanks, I addressed the ones I could find. Running perf mem report I still =
see:

=3D=3D2948587=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 1296 byte(s) in 162 object(s) allocated from:
    #0 0x7f2a018d85bf in __interceptor_malloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x556104500e47 in map__get util/map.h:180
    #2 0x55610450cd6d in ip__resolve_data util/machine.c:2260
    #3 0x55610450d022 in sample__resolve_mem util/machine.c:2275
    #4 0x55610459dc73 in iter_prepare_mem_entry util/hist.c:824
    #5 0x5561045a0175 in hist_entry_iter__add util/hist.c:1238
    #6 0x5561042d8e8e in process_sample_event tools/perf/builtin-report.c:3=
32
    #7 0x556104526a37 in evlist__deliver_sample util/session.c:1518
    #8 0x556104526d18 in machines__deliver_event util/session.c:1557
    #9 0x556104527942 in perf_session__deliver_event util/session.c:1639
    #10 0x55610451d576 in ordered_events__deliver_event util/session.c:188
    #11 0x556104536b6a in do_flush util/ordered-events.c:245
    #12 0x5561045372a8 in __ordered_events__flush util/ordered-events.c:324
    #13 0x556104537544 in ordered_events__flush util/ordered-events.c:342
    #14 0x5561045240b0 in perf_event__process_finished_round util/session.c=
:1080
    #15 0x556104527fd5 in perf_session__process_user_event util/session.c:1=
692
    #16 0x556104529396 in perf_session__process_event util/session.c:1861
    #17 0x55610452cf8c in process_simple util/session.c:2436
    #18 0x55610452c69b in reader__read_event util/session.c:2365
    #19 0x55610452cb36 in reader__process_events util/session.c:2414
    #20 0x55610452d467 in __perf_session__process_events util/session.c:246=
1
    #21 0x55610452ec52 in perf_session__process_events util/session.c:2627
    #22 0x5561042dd613 in __cmd_report tools/perf/builtin-report.c:992
    #23 0x5561042e7ac7 in cmd_report tools/perf/builtin-report.c:1711
    #24 0x556104343967 in report_events tools/perf/builtin-mem.c:374
    #25 0x556104345278 in cmd_mem tools/perf/builtin-mem.c:516
    #26 0x55610441848d in run_builtin tools/perf/perf.c:322
    #27 0x5561044189f9 in handle_internal_command tools/perf/perf.c:375
    #28 0x556104418dc1 in run_argv tools/perf/perf.c:419
    #29 0x556104419329 in main tools/perf/perf.c:535

Direct leak of 1296 byte(s) in 162 object(s) allocated from:
    #0 0x7f2a018d85bf in __interceptor_malloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x556104500e47 in map__get util/map.h:180
    #2 0x55610450c97e in ip__resolve_ams util/machine.c:2239
    #3 0x55610450cf1b in sample__resolve_mem util/machine.c:2274
    #4 0x55610459dc73 in iter_prepare_mem_entry util/hist.c:824
    #5 0x5561045a0175 in hist_entry_iter__add util/hist.c:1238
    #6 0x5561042d8e8e in process_sample_event tools/perf/builtin-report.c:3=
32
    #7 0x556104526a37 in evlist__deliver_sample util/session.c:1518
    #8 0x556104526d18 in machines__deliver_event util/session.c:1557
    #9 0x556104527942 in perf_session__deliver_event util/session.c:1639
    #10 0x55610451d576 in ordered_events__deliver_event util/session.c:188
    #11 0x556104536b6a in do_flush util/ordered-events.c:245
    #12 0x5561045372a8 in __ordered_events__flush util/ordered-events.c:324
    #13 0x556104537544 in ordered_events__flush util/ordered-events.c:342
    #14 0x5561045240b0 in perf_event__process_finished_round util/session.c=
:1080
    #15 0x556104527fd5 in perf_session__process_user_event util/session.c:1=
692
    #16 0x556104529396 in perf_session__process_event util/session.c:1861
    #17 0x55610452cf8c in process_simple util/session.c:2436
    #18 0x55610452c69b in reader__read_event util/session.c:2365
    #19 0x55610452cb36 in reader__process_events util/session.c:2414
    #20 0x55610452d467 in __perf_session__process_events util/session.c:246=
1
    #21 0x55610452ec52 in perf_session__process_events util/session.c:2627
    #22 0x5561042dd613 in __cmd_report tools/perf/builtin-report.c:992
    #23 0x5561042e7ac7 in cmd_report tools/perf/builtin-report.c:1711
    #24 0x556104343967 in report_events tools/perf/builtin-mem.c:374
    #25 0x556104345278 in cmd_mem tools/perf/builtin-mem.c:516
    #26 0x55610441848d in run_builtin tools/perf/perf.c:322
    #27 0x5561044189f9 in handle_internal_command tools/perf/perf.c:375
    #28 0x556104418dc1 in run_argv tools/perf/perf.c:419
    #29 0x556104419329 in main tools/perf/perf.c:535

Which looks like iter->priv was freed without puts. The use of void*s
and the general layout of the histogram code I find confusing. It
would be nice to get this resolved but I wasn't able to do it in v3.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 8e5085b77c7b..6ca7500e2cf4 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -2389,8 +2389,7 @@ static int add_callchain_ip(struct thread *thread=
,
> >                                       iter_cycles, branch_from, srcline=
);
> >  out:
> >         addr_location__exit(&al);
> > -       maps__put(ms.maps);
> > -       map__put(ms.map);
> > +       map_symbol__exit(&ms);
> >         return err;
> >  }
> >
> > @@ -3116,8 +3115,7 @@ static int append_inlines(struct callchain_cursor=
 *cursor, struct map_symbol *ms
> >                 if (ret !=3D 0)
> >                         return ret;
> >         }
> > -       map__put(ilist_ms.map);
> > -       maps__put(ilist_ms.maps);
> > +       map_symbol__exit(&ilist_ms);
> >
> >         return ret;
> >  }
> > diff --git a/tools/perf/util/map_symbol.c b/tools/perf/util/map_symbol.=
c
> > new file mode 100644
> > index 000000000000..bef5079f2403
> > --- /dev/null
> > +++ b/tools/perf/util/map_symbol.c
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "map_symbol.h"
> > +#include "maps.h"
> > +#include "map.h"
> > +
> > +void map_symbol__exit(struct map_symbol *ms)
> > +{
> > +       maps__zput(ms->maps);
> > +       map__zput(ms->map);
> > +}
> > +
> > +void addr_map_symbol__exit(struct addr_map_symbol *ams)
> > +{
> > +       map_symbol__exit(&ams->ms);
> > +}
> > diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.=
h
> > index e08817b0c30f..72d5ed938ed6 100644
> > --- a/tools/perf/util/map_symbol.h
> > +++ b/tools/perf/util/map_symbol.h
> > @@ -22,4 +22,8 @@ struct addr_map_symbol {
> >         u64           phys_addr;
> >         u64           data_page_size;
> >  };
> > +
> > +void map_symbol__exit(struct map_symbol *ms);
> > +void addr_map_symbol__exit(struct addr_map_symbol *ams);
> > +
> >  #endif // __PERF_MAP_SYMBOL
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 2740d4457c13..d67a87072eec 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -2790,8 +2790,11 @@ struct mem_info *mem_info__get(struct mem_info *=
mi)
> >
> >  void mem_info__put(struct mem_info *mi)
> >  {
> > -       if (mi && refcount_dec_and_test(&mi->refcnt))
> > +       if (mi && refcount_dec_and_test(&mi->refcnt)) {
> > +               addr_map_symbol__exit(&mi->iaddr);
> > +               addr_map_symbol__exit(&mi->daddr);
> >                 free(mi);
> > +       }
> >  }
> >
> >  struct mem_info *mem_info__new(void)
> > --
> > 2.42.0.609.gbb76f46606-goog
> >

