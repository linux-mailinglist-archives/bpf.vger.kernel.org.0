Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2608C64CF30
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 19:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbiLNSLA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 13:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiLNSKr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 13:10:47 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BEB1170
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 10:10:44 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y16so640518wrm.2
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 10:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nybxgdJczlK9xtFGjAbTfjb9qk52fvIL/a1+enwIgmM=;
        b=rKhaXbQUggPZdCWaRsZFYOcBD7elT7dcVVUaN1vfyPFjGb2fI3BPdNaYhTmV3dAkeH
         AbEME5Avhe7kOhXTGK0ULD4flL+51h2MXC8EGR0Uji1O7f85qriSdy+nwGZwWg/rx/hf
         Sxx8UykaTQ//ct5rT9CwTZGcw2fZpUFPHOmLID8Uw2tnXibscF9WyVNCY25C9tR0WbS6
         1vAueqKVhath4j5KpnK6822TBPKbPl9+49A0fwRswb9aOhefnnAEsYs5lsSfJhIuzg1T
         bDLo57p31MqrmE2E08mIBBDAp9HLn3E8IqKpMnvZuW3qWauo2pAT9HUhGurOvYZJh4f4
         m1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nybxgdJczlK9xtFGjAbTfjb9qk52fvIL/a1+enwIgmM=;
        b=SCN6cG0TdhveFCloDAYmuXS3SOrLzTBGyFE5TredeVxYXBqubkZIibI1XcbZkRZ2xJ
         T4ghh/jZzRwgQWe8zHl48M9dJ/jNQb+WJHoWgY5NkVofKrVddczuTd//9lHyFPBjRCvq
         q1rdJsOOOEzgUChQzHbsxNpDCFBICJacWPPuLKH4eemHSKZ8Og98s0im8HETpQt44itY
         O6wxaMWBHopFHskS0Hkyk9DF7KMXEApoANaNbU1c2lWNRlvdIWYiXfkx/RE7rdcvsj40
         9AH2YzxVHmuGQjbO3h7Paat+1Ioy5rDnQz/YMLnCsOaC7CiExLTtRz8iMBkGfmqOnaO7
         QLbw==
X-Gm-Message-State: ANoB5pmPpxrZrXmJnec3curWHSGcDgjI9tScHa+PYmzaqCajgwqFkSOl
        2g/lqVKHYxw1U96PALJYwk/5XeRZyqWtxOB7e62qig==
X-Google-Smtp-Source: AA0mqf6MNK/WLTJN3L8riDu3wQ0pF0PYVfu3IsI/9xxVW9bP9ieIXPzqBSmaRP+e8JOEzQlpXXS6Wj8B3/KM2j5KcZE=
X-Received: by 2002:a5d:4a8c:0:b0:242:165e:7a79 with SMTP id
 o12-20020a5d4a8c000000b00242165e7a79mr28790047wrq.343.1671041443254; Wed, 14
 Dec 2022 10:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20221213232651.1269909-1-irogers@google.com> <Y5ncNQfPzq8qBP/f@kernel.org>
 <Y5oPQ0Cf/9JGME3n@kernel.org>
In-Reply-To: <Y5oPQ0Cf/9JGME3n@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Dec 2022 10:10:31 -0800
Message-ID: <CAP-5=fW8n-8ayzjLj0q588d0ZVpTPOGNGLB0Oj2GkF7f7CA=cg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] build/libtraceevent resends
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Timothy Hayes <timothy.hayes@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        shaomin Deng <dengshaomin@cdjrlc.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 14, 2022 at 10:00 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Dec 14, 2022 at 11:22:45AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Tue, Dec 13, 2022 at 03:26:46PM -0800, Ian Rogers escreveu:
> > > All patches on the acme perf/core branch.
> > >
> > > Resend incremental build fix python plugin:
> > > https://lore.kernel.org/lkml/20221205225940.3079667-4-irogers@google.=
com/
> > >
> > > Break apart and resend libtraceevent debug logging support:
> > > https://lore.kernel.org/linux-perf-users/20210923001024.550263-4-irog=
ers@google.com/
> > >
> > > Switch "#if HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE" to "#if
> > > MAKE_LIBTRACEEVENT_VERSION(1, 5, 0) <=3D LIBTRACEEVENT_VERSION",
> > > ensuring trace-event.h is included as discussed on the mailing list.
> > >
> > > Resend removal of --group option:
> > > https://lore.kernel.org/lkml/20220707195610.303254-1-irogers@google.c=
om/
> >
> > Thanks, applied.
>
> Building on arm64:
>
> /home/acme/git/perf/tools/perf/util/evsel.c: In function =E2=80=98evsel__=
rawptr=E2=80=99:
> /home/acme/git/perf/tools/perf/util/evsel.c:2787:65: error: operator '<=
=3D' has no right operand
>  2787 | #if MAKE_LIBTRACEEVENT_VERSION(1, 5, 0) <=3D LIBTRACEEVENT_VERSIO=
N
>       |                                                                 ^
> error: command '/usr/bin/gcc' failed with exit code 1
> cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No such =
file or directory
>
> make[2]: *** [Makefile.perf:651: /tmp/build/perf/python/perf.cpython-310-=
aarch64-linux-gnu.so] Error 1
> make[2]: *** Waiting for unfinished jobs....
>   LD      /tmp/build/perf/libbpf/staticobjs/libbpf-in.o
>
> Trying to fix...

Thanks, I suspect the CFLAGS aren't passed through maybe, given this
is the python code. Perhaps an include of util/trace-event.h is also
necessary, but I thought that was already present:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/evsel.c?h=3Dperf/core#n43

Thanks for digging into it,
Ian

> > - Arnaldo
> >
> >
> > > Ian Rogers (5):
> > >   perf build: Fix python/perf.so library's name
> > >   perf trace-event: Add libtraceevent version tools to header
> > >   libtraceevent: Increase libtraceevent logging when verbose
> > >   perf trace-event: Use version check to avoid 1 define
> > >   perf evlist: Remove group option.
> > >
> > >  tools/perf/Documentation/perf-record.txt      |  4 ----
> > >  tools/perf/Documentation/perf-top.txt         |  7 ++----
> > >  tools/perf/Makefile.config                    |  8 +++----
> > >  tools/perf/Makefile.perf                      |  2 +-
> > >  tools/perf/builtin-record.c                   |  2 --
> > >  tools/perf/builtin-stat.c                     |  6 -----
> > >  tools/perf/builtin-top.c                      |  2 --
> > >  tools/perf/builtin-trace.c                    |  2 +-
> > >  tools/perf/tests/attr/README                  |  2 --
> > >  tools/perf/tests/attr/test-record-group       | 22 -----------------=
--
> > >  tools/perf/tests/attr/test-stat-group         | 17 --------------
> > >  tools/perf/util/data-convert-bt.c             |  3 ++-
> > >  tools/perf/util/debug.c                       | 10 +++++++++
> > >  tools/perf/util/evlist.c                      |  2 +-
> > >  tools/perf/util/evlist.h                      |  2 --
> > >  tools/perf/util/evsel.c                       |  2 +-
> > >  tools/perf/util/python.c                      | 10 +--------
> > >  tools/perf/util/record.c                      |  7 ------
> > >  tools/perf/util/record.h                      |  1 -
> > >  .../util/scripting-engines/trace-event-perl.c |  2 +-
> > >  .../scripting-engines/trace-event-python.c    |  2 +-
> > >  tools/perf/util/sort.c                        |  3 ++-
> > >  tools/perf/util/trace-event.h                 | 13 +++++++++++
> > >  23 files changed, 39 insertions(+), 92 deletions(-)
> > >  delete mode 100644 tools/perf/tests/attr/test-record-group
> > >  delete mode 100644 tools/perf/tests/attr/test-stat-group
> > >
> > > --
> > > 2.39.0.314.g84b9a713c41-goog
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo
