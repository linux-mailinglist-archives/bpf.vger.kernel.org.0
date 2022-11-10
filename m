Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FAF62491F
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 19:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiKJSKc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 13:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKJSKb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 13:10:31 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D022865F2;
        Thu, 10 Nov 2022 10:10:30 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-13c569e5ff5so3005696fac.6;
        Thu, 10 Nov 2022 10:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ii2uAwWf7GjMB0IiYJRHuLlDIfmuSdb6hv0bvJzZ04k=;
        b=hZGg/tMYHdvIq6uUvgBFQWg362cZZ65q1EovZWwFXzIy3/6Y9KCBzNShlCy8vFp6Sh
         NoRulcDK2Rq5YzNrtKrtHpGeXjMSllIiRDsT6DAmAg6vpP8mCSvLCCfjsTSabA/oHn38
         Le8rN7dyhHxNwLUak4JqppwGEh0CDpNMH3O3TIB3gGEZPjsE+C6qGRZr5Nh0O4KNlQbe
         qRqHBVAoazxWbIl/NXKopfi6iQVBT/IYfQaAxqxLhr50iun71ndJImr2PfhNR/PiGSXt
         h7rlkVIG4OigOfsy2ss93ChX9tWQYSfPQx3pCKfJxtSKj+USehDIBdeHgbyvjN+Za29P
         V0dA==
X-Gm-Message-State: ACrzQf2w3u31zv8OrYZhrinvU5ehdIDx9N9josXxgAEyBbU6vYqNI6zS
        L5GWaFdx3aKi1Jjr1XdCmTwtAOsEjRCspiCl8Kg=
X-Google-Smtp-Source: AMsMyM4vPjtYENfiSr6Uu6NX2CAOWsgWXktTtBylzHXoXDEA0dIm/3nVVQ1EvdUoMqdNRTYEisZ65gKK0POUas8u90c=
X-Received: by 2002:a05:6870:b6a8:b0:13c:8991:2ac7 with SMTP id
 cy40-20020a056870b6a800b0013c89912ac7mr1792064oab.209.1668103830064; Thu, 10
 Nov 2022 10:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Nov 2022 10:10:18 -0800
Message-ID: <CAM9d7ciPe-uR5MdayhUEEK8a-j1QDm50qPffsod9BHdUF5Z-TA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Fix perf tools/lib includes
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ian,

On Wed, Nov 9, 2022 at 10:49 AM Ian Rogers <irogers@google.com> wrote:
>
> The previous build would add -Itools/lib and get dependencies for
> libtraceevent, libsubcmd, libsymbol, libapi and libbpf meaning that
> overriding these libraries would change the link time dependency but
> the headers would erroneously come from tools/lib. Fix the build to
> install headers and then depend on these. To reduce exposing internal
> headers/APIs some clean up is performed. tools/lib/symbol has a
> Makefile added, while tools/lib/api and tools/lib/subcmd have install
> targets added. The pattern used for the dependencies in Makefile.perf
> is modelled on libbpf.
>
> The problem and solution were motivated by this issue and discussion:
> https://lore.kernel.org/lkml/CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=hq657buqe2_yRKxaK-A@mail.gmail.com/
>
> v2. Fix a MANIFEST issue for the source tar ball. Add dependencies for
>     the installed header files so that the build doesn't overtake
>     building these dependencies. Both issues reported by Arnaldo
>     Carvalho de Melo <acme@kernel.org>.
>
> Ian Rogers (14):
>   tools lib api: Add install target
>   tools lib subcmd: Add install target
>   perf build: Install libsubcmd locally when building
>   perf build: Install libapi locally when building
>   perf build: Install libperf locally when building
>   perf build: Install libtraceevent locally when building
>   tools lib api: Add missing install headers
>   tools lib perf: Add missing install headers
>   tool lib symbol: Add Makefile/Build
>   perf build: Install libsymbol locally when building
>   perf expr: Tidy hashmap dependency
>   perf thread_map: Reduce exposure of libperf internal API
>   perf cpumap: Tidy libperf includes
>   perf build: Use tools/lib headers from install path

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/lib/api/Makefile                        |  52 +++++
>  tools/lib/perf/Makefile                       |  10 +-
>  tools/lib/subcmd/Makefile                     |  49 +++++
>  tools/lib/symbol/Build                        |   1 +
>  tools/lib/symbol/Makefile                     | 115 +++++++++++
>  tools/perf/.gitignore                         |   7 +-
>  tools/perf/MANIFEST                           |   3 +-
>  tools/perf/Makefile.config                    |   2 -
>  tools/perf/Makefile.perf                      | 192 ++++++++++++++----
>  tools/perf/builtin-stat.c                     |   1 +
>  tools/perf/builtin-trace.c                    |   4 +-
>  tools/perf/tests/cpumap.c                     |   2 +-
>  tools/perf/tests/expr.c                       |   1 +
>  tools/perf/tests/openat-syscall.c             |   1 +
>  tools/perf/tests/pmu-events.c                 |   1 +
>  tools/perf/tests/thread-map.c                 |   1 +
>  tools/perf/util/Build                         |   5 -
>  tools/perf/util/auxtrace.h                    |   2 +-
>  tools/perf/util/bpf-loader.c                  |   4 -
>  tools/perf/util/bpf_counter.c                 |   2 +-
>  tools/perf/util/cpumap.c                      |   1 +
>  tools/perf/util/cpumap.h                      |   2 +-
>  tools/perf/util/evsel.c                       |   5 +-
>  tools/perf/util/evsel.h                       |   2 -
>  tools/perf/util/expr.c                        |   1 +
>  tools/perf/util/expr.h                        |   7 +-
>  tools/perf/util/metricgroup.c                 |   1 +
>  tools/perf/util/python.c                      |   6 +-
>  .../scripting-engines/trace-event-python.c    |   2 +-
>  tools/perf/util/stat-shadow.c                 |   1 +
>  tools/perf/util/stat.c                        |   4 -
>  tools/perf/util/thread_map.c                  |   1 +
>  tools/perf/util/thread_map.h                  |   2 -
>  33 files changed, 402 insertions(+), 88 deletions(-)
>  create mode 100644 tools/lib/symbol/Build
>  create mode 100644 tools/lib/symbol/Makefile
>
> --
> 2.38.1.431.g37b22c650d-goog
>
