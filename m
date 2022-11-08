Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62690620A3B
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiKHHfc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiKHHfb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:35:31 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78524186D2
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:35:30 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-368036d93abso129906277b3.18
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F1MmSGrBOxsTKn6Pb+25q0RPXibwEcqP2UDBJI1Tgks=;
        b=gWxyNcVZeubHHTaQ+xbePkwblHCQSOhqq7bUx6TGRIGAndvz54rBnyIg2M6VkZ7Qty
         Zp4oVVIoS4rMO9UgtvSFBwRfsC6BOj4ASztBZdcd1ecwG40KO1pQI2dDTqJX3+VDs2Kk
         SP3dz5HWUdIVo9T1G/ylXRQj3mA1jj8cNAqBgcyXRPltl7b6uZvP3/rlr1XzEVvTFUpi
         17Pto5Yye0k/G0/7fC8FZj+xNQLHsoqiRepbSCjRh57Os4OdMzGHp01uUi0RdWr4nAqf
         nTLi0gnOEppnaNUCtXWZLXePrEY3hfwJj4Y9oYFzS0gfx8/WSutW4mlG1a5LQtIDezrO
         k/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F1MmSGrBOxsTKn6Pb+25q0RPXibwEcqP2UDBJI1Tgks=;
        b=y6GxFewBRl04+NKEyCHlNDhZOBHOQ1RxJizFy/ibK+VZPhWYoL2E1Cur8Tb2eH1QZN
         YCtmd5a4miWta6RHpgIwMeOXMNzZ9sVmeIcLpzhcMRI8UNRPVt9OmCTrbeSAs+MYbDa5
         SyeVINcl4Jne1oAjt6ALTTmeIZqJtfbKceXa/ryxk/8vP4khsxX8KnvW92Yu9j8u92xC
         tKbV7vMkHvanjpT33U5CfL96OH5KOuHSkganFFKsseH6sgnqBAl5AwPtYjz+5wEclIAE
         pYy6OJrd1et0k+Bj7tjCo1JtW+yOW8j4CSc+9ljD0Jy1bFdXCZJ21T8uLkMcHF/vxd/v
         Frqw==
X-Gm-Message-State: ACrzQf3R0Day8RX+75laonp7vMuQo8cOwzvpk014ZIcQgFcBkk2v5pK4
        L/I1dNMbY0Tg1frFS9fykiz1K9HO5S1U
X-Google-Smtp-Source: AMsMyM7gs3pQPbxBgww9O6WkP2k4tlGYhMoxjXnnNjkEfOEzyEqvQk18FteSSDahqDKpPaiulUNnaHpQK5BE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a05:6902:120b:b0:6d0:672f:9bbd with SMTP
 id s11-20020a056902120b00b006d0672f9bbdmr29483620ybu.613.1667892929713; Mon,
 07 Nov 2022 23:35:29 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:04 -0800
Message-Id: <20221108073518.1154450-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 00/14] Fix perf tools/lib includes
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

 tools/lib/api/Makefile                        |  52 ++++++
 tools/lib/perf/Makefile                       |  10 +-
 tools/lib/subcmd/Makefile                     |  49 ++++++
 tools/lib/symbol/Build                        |   1 +
 tools/lib/symbol/Makefile                     | 115 +++++++++++++
 tools/perf/.gitignore                         |   7 +-
 tools/perf/Makefile.config                    |   2 -
 tools/perf/Makefile.perf                      | 152 ++++++++++++------
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
 32 files changed, 361 insertions(+), 86 deletions(-)
 create mode 100644 tools/lib/symbol/Build
 create mode 100644 tools/lib/symbol/Makefile

-- 
2.38.1.431.g37b22c650d-goog

