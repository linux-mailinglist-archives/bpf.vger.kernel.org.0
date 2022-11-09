Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEE76232E7
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiKISt2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiKISt1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:49:27 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5807613FBC
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 10:49:26 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id w2-20020a17090a8a0200b002119ea856edso1847859pjn.5
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 10:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lkoognfiz4T0FO9qiJqVW8CCjbYEKiYWyfXc5YQhyvU=;
        b=j69pt3b65opmCrEUZi5UPc1HYd/XHA0eHlmdQQkHI+ARnwDXXgf8KRyvL4NEZd7ajs
         x4iit8Zps0gDdr4HFiP8+viZ/HZYB2E9C874CDUbvquklngUPsMre2ujqhCQOnPfb0NF
         AxFGGgIDYJkTyPmwnMSwmPFdxZr/CgABD5SeaRHK17Y7N1wduXBq7rnqSSSulFHRSycz
         BRbFDhGcBNLAwNcZK3uAa5So2ICT5ZKA125taXxkT6I3R86sG6irVFVe5c8jJu3rl0F+
         4h3Uj8aQO4jCE+CZJwDhlhj+iKyr3mv2du7I1hmGySLgFGoANhaL+gHzt9tBPiII78ZQ
         Fp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lkoognfiz4T0FO9qiJqVW8CCjbYEKiYWyfXc5YQhyvU=;
        b=auiS+YgbUrdR8s2EJ7Ucjax7K9O+WBReepiKAdw89JDvDB67VsUzaXgDLlJ7/YAP8C
         g6xYpCKYUvDzAIvq9ReFxvZ/tMU6X9XN+RRPl6mEGx+vZtn/cIJh++vgB3raL45bC067
         W8NaURGom7NccIL/DqfeSnWO3G3L7hyxdw/zxGnrAY9D5r82m60znWek7rC8D4e6n+cw
         q6bal4b55WU76pqjfBRkmHN2Pjxh3bXbQM+lYeUzFxi0GgaC1a73CE9/IOKjCHVIzrwq
         AF5WeeNqj7ZBpPLLtxo1iCElW3B6MwzlZzut0bhNGVcFKmw+t0rlvAd835M77a6tM3+O
         NnOA==
X-Gm-Message-State: ANoB5pnniGVzRa4v6I5TlXfYku/Cus4TzznZmwRELhmotYTreCT4LclU
        /TBii8P+5+efDF/y4GM4AMfZaYhKq1k3
X-Google-Smtp-Source: AA0mqf6xXKCdkNXpupIQmxg0yHjBRRkaNlNnkQCtsTWy9wBoQEixEhlbyuYNPEZw62+aKLbuJYhHW1jqB27F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a17:90b:4003:b0:20a:fee1:8f69 with SMTP id
 ie3-20020a17090b400300b0020afee18f69mr55292pjb.0.1668019765401; Wed, 09 Nov
 2022 10:49:25 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:00 -0800
Message-Id: <20221109184914.1357295-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 00/14] Fix perf tools/lib includes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The previous build would add -Itools/lib and get dependencies for
libtraceevent, libsubcmd, libsymbol, libapi and libbpf meaning that
overriding these libraries would change the link time dependency but
the headers would erroneously come from tools/lib. Fix the build to
install headers and then depend on these. To reduce exposing internal
headers/APIs some clean up is performed. tools/lib/symbol has a
Makefile added, while tools/lib/api and tools/lib/subcmd have install
targets added. The pattern used for the dependencies in Makefile.perf
is modelled on libbpf.

The problem and solution were motivated by this issue and discussion:
https://lore.kernel.org/lkml/CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=hq657buqe2_yRKxaK-A@mail.gmail.com/

v2. Fix a MANIFEST issue for the source tar ball. Add dependencies for
    the installed header files so that the build doesn't overtake
    building these dependencies. Both issues reported by Arnaldo
    Carvalho de Melo <acme@kernel.org>.

Ian Rogers (14):
  tools lib api: Add install target
  tools lib subcmd: Add install target
  perf build: Install libsubcmd locally when building
  perf build: Install libapi locally when building
  perf build: Install libperf locally when building
  perf build: Install libtraceevent locally when building
  tools lib api: Add missing install headers
  tools lib perf: Add missing install headers
  tool lib symbol: Add Makefile/Build
  perf build: Install libsymbol locally when building
  perf expr: Tidy hashmap dependency
  perf thread_map: Reduce exposure of libperf internal API
  perf cpumap: Tidy libperf includes
  perf build: Use tools/lib headers from install path

 tools/lib/api/Makefile                        |  52 +++++
 tools/lib/perf/Makefile                       |  10 +-
 tools/lib/subcmd/Makefile                     |  49 +++++
 tools/lib/symbol/Build                        |   1 +
 tools/lib/symbol/Makefile                     | 115 +++++++++++
 tools/perf/.gitignore                         |   7 +-
 tools/perf/MANIFEST                           |   3 +-
 tools/perf/Makefile.config                    |   2 -
 tools/perf/Makefile.perf                      | 192 ++++++++++++++----
 tools/perf/builtin-stat.c                     |   1 +
 tools/perf/builtin-trace.c                    |   4 +-
 tools/perf/tests/cpumap.c                     |   2 +-
 tools/perf/tests/expr.c                       |   1 +
 tools/perf/tests/openat-syscall.c             |   1 +
 tools/perf/tests/pmu-events.c                 |   1 +
 tools/perf/tests/thread-map.c                 |   1 +
 tools/perf/util/Build                         |   5 -
 tools/perf/util/auxtrace.h                    |   2 +-
 tools/perf/util/bpf-loader.c                  |   4 -
 tools/perf/util/bpf_counter.c                 |   2 +-
 tools/perf/util/cpumap.c                      |   1 +
 tools/perf/util/cpumap.h                      |   2 +-
 tools/perf/util/evsel.c                       |   5 +-
 tools/perf/util/evsel.h                       |   2 -
 tools/perf/util/expr.c                        |   1 +
 tools/perf/util/expr.h                        |   7 +-
 tools/perf/util/metricgroup.c                 |   1 +
 tools/perf/util/python.c                      |   6 +-
 .../scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/stat-shadow.c                 |   1 +
 tools/perf/util/stat.c                        |   4 -
 tools/perf/util/thread_map.c                  |   1 +
 tools/perf/util/thread_map.h                  |   2 -
 33 files changed, 402 insertions(+), 88 deletions(-)
 create mode 100644 tools/lib/symbol/Build
 create mode 100644 tools/lib/symbol/Makefile

-- 
2.38.1.431.g37b22c650d-goog

