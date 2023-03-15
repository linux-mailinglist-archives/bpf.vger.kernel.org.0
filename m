Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090466BBA35
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 17:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjCOQvd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjCOQvb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 12:51:31 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7655BCB0;
        Wed, 15 Mar 2023 09:51:26 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-177ca271cb8so9128741fac.2;
        Wed, 15 Mar 2023 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678899086;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2iO6SE0jk/4T5zC5ED92WGfNNew9K4bx1ZgYZUwiahA=;
        b=l9kRloxut9BiWIUNIN1bGdlyh4rWs5dcIkiox+7F6cW/rBlwddgT9FfXvKnxbJGdfJ
         aqO1Yq3ChMsrxMydCInnwoKNauFYKzdwokp38zKphdncQerYudr1Y9RI+CxxqiTcRP4+
         Du88h4aq4PDLAUWsLpv7s1rTdolmSa7lybc6Bg5Jh488L+iXbD6WQhXoI+cThrkIxyLe
         0aeHI6s02jpWI/kWUhJRbu6eIlgLiMiJrxjpYj5gSrONxgDj1uAEf1r+TnX8r4KvZxfH
         srDFwKeThMaSBfDS2fjhxO3RO5dbi1VZpxPtjnlV8gIM8Zme9pNzxfUU+UH1CpTxgnJV
         EoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678899086;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2iO6SE0jk/4T5zC5ED92WGfNNew9K4bx1ZgYZUwiahA=;
        b=tjC4npzlLLSEBXtqk+XhDxEgndHODtRkcrrpE9ftImCrkoQZWfeFB5NsmywkjHmB68
         FlrU9xABLRuve4ONk/1zCKjkmghSyYNJ1EWeeRNakpUnrrepk3rOyg7/JERKxwa6KW+p
         y188T5LQMCcYsW2bu3julirytsqabkKeLqvyNbRnnCz1nlLFq0t5KoaFhYRXT7vY5vLT
         rWHT05MMkkPLcC0MwmCUB8TZWohPL0KTSdiEBOcdXRhpFBHM1PHvJXJUxqz15Aevkis4
         U1MlUZlvK+E9QGUNApXlp8fzHD/ALwf2IelIe0tnIMd0ynylgaf6qm1Kg8dWLzpjkSAr
         aMFg==
X-Gm-Message-State: AO0yUKXG7/wSwdv71XfaahwASEVIOaO3TyThQqibHV1c0SP7G415xjbE
        w23LiL0hLQPj0h4cno7KFII=
X-Google-Smtp-Source: AK7set/Tu3kMdS+qcUu9tIQumpejYaLD3Xlg9wrtNNiJpPYtLpz4w5WBQmetP1DIJ1UM8JH4BI1/Rg==
X-Received: by 2002:a05:6870:c083:b0:17a:b46c:ba27 with SMTP id c3-20020a056870c08300b0017ab46cba27mr3404343oad.54.1678899085830;
        Wed, 15 Mar 2023 09:51:25 -0700 (PDT)
Received: from [127.0.0.1] ([187.19.237.165])
        by smtp.gmail.com with ESMTPSA id p28-20020a056830319c00b006944e6b1abfsm2467849ots.51.2023.03.15.09.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:51:25 -0700 (PDT)
Date:   Wed, 15 Mar 2023 13:51:20 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>,
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
Subject: Re: [PATCH 03/10] perf record: Add BPF event filter support
User-Agent: K-9 Mail for Android
In-Reply-To: <CAM9d7cgzes+PgVKNPHQB3mzz-5wwHnBEh-RV8Mc5PqgSfGsy-Q@mail.gmail.com>
References: <20230314234237.3008956-1-namhyung@kernel.org> <20230314234237.3008956-4-namhyung@kernel.org> <ZBHMcfCr+GeQJ9Sz@kernel.org> <CAM9d7cgzes+PgVKNPHQB3mzz-5wwHnBEh-RV8Mc5PqgSfGsy-Q@mail.gmail.com>
Message-ID: <DA83C6A5-EF0C-4F48-9D98-770052F6E3D3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On March 15, 2023 1:41:29 PM GMT-03:00, Namhyung Kim <namhyung@kernel=2Eor=
g> wrote:
>Hi Arnaldo,
>
>On Wed, Mar 15, 2023 at 6:47=E2=80=AFAM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> Em Tue, Mar 14, 2023 at 04:42:30PM -0700, Namhyung Kim escreveu:
>> > Use --filter option to set BPF filter for generic events other than t=
he
>> > tracepoints or Intel PT=2E  The BPF program will check the sample dat=
a and
>> > filter according to the expression=2E
>> >
>> > For example, the below is the typical perf record for frequency mode=
=2E
>> > The sample period started from 1 and increased gradually=2E
>> >
>> > $ sudo =2E/perf record -e cycles true
>> > $ sudo =2E/perf script
>> >        perf-exec 2272336 546683=2E916875:          1 cycles:  fffffff=
f828499b8 perf_event_exec+0x298 ([kernel=2Ekallsyms])
>> >        perf-exec 2272336 546683=2E916892:          1 cycles:  fffffff=
f828499b8 perf_event_exec+0x298 ([kernel=2Ekallsyms])
>> >        perf-exec 2272336 546683=2E916899:          3 cycles:  fffffff=
f828499b8 perf_event_exec+0x298 ([kernel=2Ekallsyms])
>> >        perf-exec 2272336 546683=2E916905:         17 cycles:  fffffff=
f828499b8 perf_event_exec+0x298 ([kernel=2Ekallsyms])
>> >        perf-exec 2272336 546683=2E916911:        100 cycles:  fffffff=
f828499b8 perf_event_exec+0x298 ([kernel=2Ekallsyms])
>> >        perf-exec 2272336 546683=2E916917:        589 cycles:  fffffff=
f828499b8 perf_event_exec+0x298 ([kernel=2Ekallsyms])
>> >        perf-exec 2272336 546683=2E916924:       3470 cycles:  fffffff=
f828499b8 perf_event_exec+0x298 ([kernel=2Ekallsyms])
>> >        perf-exec 2272336 546683=2E916930:      20465 cycles:  fffffff=
f828499b8 perf_event_exec+0x298 ([kernel=2Ekallsyms])
>> >             true 2272336 546683=2E916940:     119873 cycles:  fffffff=
f8283afdd perf_iterate_ctx+0x2d ([kernel=2Ekallsyms])
>> >             true 2272336 546683=2E917003:     461349 cycles:  fffffff=
f82892517 vma_interval_tree_insert+0x37 ([kernel=2Ekallsyms])
>> >             true 2272336 546683=2E917237:     635778 cycles:  fffffff=
f82a11400 security_mmap_file+0x20 ([kernel=2Ekallsyms])
>> >
>> > When you add a BPF filter to get samples having periods greater than =
1000,
>> > the output would look like below:
>>
>> Had to add:
>>
>> diff --git a/tools/perf/util/python=2Ec b/tools/perf/util/python=2Ec
>> index be336f1b2b689602=2E=2E153a13cdca9df1ea 100644
>> --- a/tools/perf/util/python=2Ec
>> +++ b/tools/perf/util/python=2Ec
>> @@ -19,6 +19,7 @@
>>  #include "mmap=2Eh"
>>  #include "stat=2Eh"
>>  #include "metricgroup=2Eh"
>> +#include "util/bpf-filter=2Eh"
>>  #include "util/env=2Eh"
>>  #include "util/pmu=2Eh"
>>  #include <internal/lib=2Eh>
>> @@ -135,6 +136,18 @@ int bpf_counter__disable(struct evsel *evsel __may=
be_unused)
>>         return 0;
>>  }
>>
>> +// not to drag util/bpf-filter=2Ec
>> +
>> +int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused)
>> +{
>> +       return 0;
>> +}
>> +
>> +int perf_bpf_filter__destroy(struct evsel *evsel __maybe_unused)
>> +{
>> +       return 0;
>> +}
>> +
>>  /*
>>   * Support debug printing even though util/debug=2Ec is not linked=2E =
 That means
>>   * implementing 'verbose' and 'eprintf'=2E
>>
>>
>> Please run 'perf test' before submitting patches,
>
>Ugh, sorry=2E  I think I ran it at some point but missed the python test =
:-p
>
>Anyway, I'm afraid you need to enclose with #ifndef HAVE_BPF_SKEL=2E

Right, I noticed that

>
>Thanks,
>Namhyung
>
>
>>
>> - Arnaldo
>>
>> > $ sudo =2E/perf record -e cycles --filter 'period > 1000' true
>> > $ sudo =2E/perf script
>> >        perf-exec 2273949 546850=2E708501:       5029 cycles:  fffffff=
f826f9e25 finish_wait+0x5 ([kernel=2Ekallsyms])
>> >        perf-exec 2273949 546850=2E708508:      32409 cycles:  fffffff=
f826f9e25 finish_wait+0x5 ([kernel=2Ekallsyms])
>> >        perf-exec 2273949 546850=2E708526:     143369 cycles:  fffffff=
f82b4cdbf xas_start+0x5f ([kernel=2Ekallsyms])
>> >        perf-exec 2273949 546850=2E708600:     372650 cycles:  fffffff=
f8286b8f7 __pagevec_lru_add+0x117 ([kernel=2Ekallsyms])
>> >        perf-exec 2273949 546850=2E708791:     482953 cycles:  fffffff=
f829190de __mod_memcg_lruvec_state+0x4e ([kernel=2Ekallsyms])
>> >             true 2273949 546850=2E709036:     501985 cycles:  fffffff=
f828add7c tlb_gather_mmu+0x4c ([kernel=2Ekallsyms])
>> >             true 2273949 546850=2E709292:     503065 cycles:      7f2=
446d97c03 _dl_map_object_deps+0x973 (/usr/lib/x86_64-linux-gnu/ld-linux-x86=
-64=2Eso=2E2)
>> >
>> > Acked-by: Jiri Olsa <jolsa@kernel=2Eorg>
>> > Signed-off-by: Namhyung Kim <namhyung@kernel=2Eorg>
>> > ---
>> >  tools/perf/Documentation/perf-record=2Etxt | 15 +++++++++++---
>> >  tools/perf/util/bpf_counter=2Ec            |  3 +--
>> >  tools/perf/util/evlist=2Ec                 | 25 +++++++++++++++++---=
----
>> >  tools/perf/util/evsel=2Ec                  |  2 ++
>> >  tools/perf/util/parse-events=2Ec           |  8 +++-----
>> >  5 files changed, 36 insertions(+), 17 deletions(-)
>> >
>> > diff --git a/tools/perf/Documentation/perf-record=2Etxt b/tools/perf/=
Documentation/perf-record=2Etxt
>> > index ff815c2f67e8=2E=2E122f71726eaa 100644
>> > --- a/tools/perf/Documentation/perf-record=2Etxt
>> > +++ b/tools/perf/Documentation/perf-record=2Etxt
>> > @@ -119,9 +119,12 @@ OPTIONS
>> >         "perf report" to view group events together=2E
>> >
>> >  --filter=3D<filter>::
>> > -        Event filter=2E This option should follow an event selector =
(-e) which
>> > -     selects either tracepoint event(s) or a hardware trace PMU
>> > -     (e=2Eg=2E Intel PT or CoreSight)=2E
>> > +     Event filter=2E  This option should follow an event selector (-=
e)=2E
>> > +     If the event is a tracepoint, the filter string will be parsed =
by
>> > +     the kernel=2E  If the event is a hardware trace PMU (e=2Eg=2E I=
ntel PT
>> > +     or CoreSight), it'll be processed as an address filter=2E  Othe=
rwise
>> > +     it means a general filter using BPF which can be applied for an=
y
>> > +     kind of event=2E
>> >
>> >       - tracepoint filters
>> >
>> > @@ -176,6 +179,12 @@ OPTIONS
>> >
>> >       Multiple filters can be separated with space or comma=2E
>> >
>> > +     - bpf filters
>> > +
>> > +     A BPF filter can access the sample data and make a decision bas=
ed on the
>> > +     data=2E  Users need to set an appropriate sample type to use th=
e BPF
>> > +     filter=2E
>> > +
>> >  --exclude-perf::
>> >       Don't record events issued by perf itself=2E This option should=
 follow
>> >       an event selector (-e) which selects tracepoint event(s)=2E It =
adds a
>> > diff --git a/tools/perf/util/bpf_counter=2Ec b/tools/perf/util/bpf_co=
unter=2Ec
>> > index aa78a15a6f0a=2E=2E1b77436e067e 100644
>> > --- a/tools/perf/util/bpf_counter=2Ec
>> > +++ b/tools/perf/util/bpf_counter=2Ec
>> > @@ -763,8 +763,7 @@ extern struct bpf_counter_ops bperf_cgrp_ops;
>> >
>> >  static inline bool bpf_counter_skip(struct evsel *evsel)
>> >  {
>> > -     return list_empty(&evsel->bpf_counter_list) &&
>> > -             evsel->follower_skel =3D=3D NULL;
>> > +     return evsel->bpf_counter_ops =3D=3D NULL;
>> >  }
>> >
>> >  int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, in=
t fd)
>> > diff --git a/tools/perf/util/evlist=2Ec b/tools/perf/util/evlist=2Ec
>> > index b74e12239aec=2E=2Ecc491a037836 100644
>> > --- a/tools/perf/util/evlist=2Ec
>> > +++ b/tools/perf/util/evlist=2Ec
>> > @@ -31,6 +31,7 @@
>> >  #include "util/evlist-hybrid=2Eh"
>> >  #include "util/pmu=2Eh"
>> >  #include "util/sample=2Eh"
>> > +#include "util/bpf-filter=2Eh"
>> >  #include <signal=2Eh>
>> >  #include <unistd=2Eh>
>> >  #include <sched=2Eh>
>> > @@ -1086,17 +1087,27 @@ int evlist__apply_filters(struct evlist *evli=
st, struct evsel **err_evsel)
>> >       int err =3D 0;
>> >
>> >       evlist__for_each_entry(evlist, evsel) {
>> > -             if (evsel->filter =3D=3D NULL)
>> > -                     continue;
>> > -
>> >               /*
>> >                * filters only work for tracepoint event, which doesn'=
t have cpu limit=2E
>> >                * So evlist and evsel should always be same=2E
>> >                */
>> > -             err =3D perf_evsel__apply_filter(&evsel->core, evsel->f=
ilter);
>> > -             if (err) {
>> > -                     *err_evsel =3D evsel;
>> > -                     break;
>> > +             if (evsel->filter) {
>> > +                     err =3D perf_evsel__apply_filter(&evsel->core, =
evsel->filter);
>> > +                     if (err) {
>> > +                             *err_evsel =3D evsel;
>> > +                             break;
>> > +                     }
>> > +             }
>> > +
>> > +             /*
>> > +              * non-tracepoint events can have BPF filters=2E
>> > +              */
>> > +             if (!list_empty(&evsel->bpf_filters)) {
>> > +                     err =3D perf_bpf_filter__prepare(evsel);
>> > +                     if (err) {
>> > +                             *err_evsel =3D evsel;
>> > +                             break;
>> > +                     }
>> >               }
>> >       }
>> >
>> > diff --git a/tools/perf/util/evsel=2Ec b/tools/perf/util/evsel=2Ec
>> > index a83d8cd5eb51=2E=2Edc3faf005c3b 100644
>> > --- a/tools/perf/util/evsel=2Ec
>> > +++ b/tools/perf/util/evsel=2Ec
>> > @@ -50,6 +50,7 @@
>> >  #include "off_cpu=2Eh"
>> >  #include "=2E=2E/perf-sys=2Eh"
>> >  #include "util/parse-branch-options=2Eh"
>> > +#include "util/bpf-filter=2Eh"
>> >  #include <internal/xyarray=2Eh>
>> >  #include <internal/lib=2Eh>
>> >  #include <internal/threadmap=2Eh>
>> > @@ -1517,6 +1518,7 @@ void evsel__exit(struct evsel *evsel)
>> >       assert(list_empty(&evsel->core=2Enode));
>> >       assert(evsel->evlist =3D=3D NULL);
>> >       bpf_counter__destroy(evsel);
>> > +     perf_bpf_filter__destroy(evsel);
>> >       evsel__free_counts(evsel);
>> >       perf_evsel__free_fd(&evsel->core);
>> >       perf_evsel__free_id(&evsel->core);
>> > diff --git a/tools/perf/util/parse-events=2Ec b/tools/perf/util/parse=
-events=2Ec
>> > index 3b2e5bb3e852=2E=2E6c5cf5244486 100644
>> > --- a/tools/perf/util/parse-events=2Ec
>> > +++ b/tools/perf/util/parse-events=2Ec
>> > @@ -28,6 +28,7 @@
>> >  #include "perf=2Eh"
>> >  #include "util/parse-events-hybrid=2Eh"
>> >  #include "util/pmu-hybrid=2Eh"
>> > +#include "util/bpf-filter=2Eh"
>> >  #include "tracepoint=2Eh"
>> >  #include "thread_map=2Eh"
>> >
>> > @@ -2542,11 +2543,8 @@ static int set_filter(struct evsel *evsel, con=
st void *arg)
>> >               perf_pmu__scan_file(pmu, "nr_addr_filters",
>> >                                   "%d", &nr_addr_filters);
>> >
>> > -     if (!nr_addr_filters) {
>> > -             fprintf(stderr,
>> > -                     "This CPU does not support address filtering\n"=
);
>> > -             return -1;
>> > -     }
>> > +     if (!nr_addr_filters)
>> > +             return perf_bpf_filter__parse(&evsel->bpf_filters, str)=
;
>> >
>> >       if (evsel__append_addr_filter(evsel, str) < 0) {
>> >               fprintf(stderr,
>> > --
>> > 2=2E40=2E0=2Erc1=2E284=2Eg88254d51c5-goog
>> >
>>
>> --
>>
>> - Arnaldo
