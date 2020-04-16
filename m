Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08481AB81E
	for <lists+bpf@lfdr.de>; Thu, 16 Apr 2020 08:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408148AbgDPGgB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Apr 2020 02:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408138AbgDPGf5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Apr 2020 02:35:57 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8636C0610D5
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 23:35:56 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 189so2319214pgb.10
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 23:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KhRdNnm54eQUJjtSMuJOUHjnhJWAKBsxVSRTwuR/Fso=;
        b=ijMbw9UU5JgH5GKna10rkpIl9jWCHys9OrETFHgX5TDLXSJNnq4hXAv26IkzFMaRNq
         p7dEwi9RGcGhK76gpsa2hNP3Mww/un23PkJgSdlkWQZHA7H2MuRGBPfcUHnhS3/86aUX
         kD5Db2Fc9NLaB9BN3pf8N8ccelKiJXh23xhvctLK8Wq1dM+bV9TsfCmsvNULNnCtbdI/
         4bece0QPb1paToheesIQoeKlcatyfzBex4s4x7LyJP/I2urFrV45r0/ctV79TRc+GABX
         qZGhWJSXHhJToMLz9/J1xl5D5WDU35tOaUL6JMLmUsCt5PBpoR1WwAR510qdTKEULKSz
         v3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KhRdNnm54eQUJjtSMuJOUHjnhJWAKBsxVSRTwuR/Fso=;
        b=Nx/yNWwM+/hOl5f4hv4yskFHlKdc4aYZLr5DiLkoY9LOQBb3CTzGeuhRU7UaJo3DDx
         Pc8Pbr7o4Hjj36cYXQ+ilLKFwhz0XS4YSK6p0ToNo2Aow93gnCyKWHQ5+lLqOtcFfgDT
         sxrj8SGXFlNxOsT8IPBqasM9Jam4FxYKIlYOIt23go7Z80FEjHviefeKze7DhQMRkb8O
         jlyXJBQJ3JyOpSSO1orlhEUWmeNCi09H90oSjrd5mm54quVwTsP/f39BTrnZWVpBFmAH
         cm56qbcPjzogeg+8nGJiU4Pbp0ixKYTFZN3ychhimKpH7uSKKT+80dDV1oPwD0f09Wha
         BuEg==
X-Gm-Message-State: AGi0PuYEAatgKXOr7SScCcUPUbaHeqftC+BcogYn+/ksk2TBME3AumdB
        8pnRg+4PrmTHkAyaRuwwP3OSgUYmufus
X-Google-Smtp-Source: APiQypI7UXID7lirkky+K5t1P65Z7JhXhaH7GGJL00ifNMf1L/MU0E7Q7MyS5vyBBkWQiD4Cev2/PajqV2Qf
X-Received: by 2002:a17:90b:246:: with SMTP id fz6mr3276299pjb.138.1587018956086;
 Wed, 15 Apr 2020 23:35:56 -0700 (PDT)
Date:   Wed, 15 Apr 2020 23:35:47 -0700
Message-Id: <20200416063551.47637-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v9 0/4] perf tools: add support for libpfm4
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch links perf with the libpfm4 library if it is available
and NO_LIBPFM4 isn't passed to the build. The libpfm4 library
contains hardware event tables for all processors supported by
perf_events. It is a helper library that helps convert from a
symbolic event name to the event encoding required by the
underlying kernel interface. This library is open-source and
available from: http://perfmon2.sf.net.
    
With this patch, it is possible to specify full hardware events
by name. Hardware filters are also supported. Events must be
specified via the --pfm-events and not -e option. Both options
are active at the same time and it is possible to mix and match:
    
$ perf stat --pfm-events inst_retired:any_p:c=1:i -e cycles ....

v9 removes some unnecessary #ifs.
v8 addresses review comments from jolsa@redhat.com.
   Breaks the patch into 4, adds a test and moves the libpfm code into its
   own file. perf list encoding tries to be closer to existing:
...
skx pfm-events
  UNHALTED_CORE_CYCLES
    [Count core clock cycles whenever the clock signal on the specific ...
  UNHALTED_REFERENCE_CYCLES
    [Unhalted reference cycles]
  INSTRUCTION_RETIRED
    [Number of instructions at retirement]
  INSTRUCTIONS_RETIRED
    [This is an alias for INSTRUCTION_RETIRED]
  BRANCH_INSTRUCTIONS_RETIRED
    [Count branch instructions at retirement. Specifically, this event ...
  MISPREDICTED_BRANCH_RETIRED
    [Count mispredicted branch instructions at retirement. ...
  BACLEARS
    [Branch re-steered]
      BACLEARS:ANY
        [Number of front-end re-steers due to BPU misprediction]
  BR_INST_RETIRED
    [Branch instructions retired (Precise Event)]
      BR_INST_RETIRED:CONDITIONAL
        [Counts all taken and not taken macro conditional branch ...
...
  and supports --long-desc/-v:
...
  BACLEARS
    [Branch re-steered]
      Code  : 0xe6
      BACLEARS:ANY
        [Number of front-end re-steers due to BPU misprediction]
        Umask : 0x01 : PMU: [default] 
      Modif : PMU: [e] : edge level (may require counter-mask >= 1) ...
      Modif : PMU: [i] : invert (boolean)
      Modif : PMU: [c] : counter-mask in range [0-255] (integer)
      Modif : PMU: [t] : measure any thread (boolean)
      Modif : PMU: [intx] : monitor only inside transactional memory ...
      Modif : PMU: [intxcp] : do not count occurrences inside aborted ...
      Modif : perf_event: [u] : monitor at user level (boolean)
      Modif : perf_event: [k] : monitor at kernel level (boolean)
      Modif : perf_event: [period] : sampling period (integer)
      Modif : perf_event: [freq] : sampling frequency (Hz) (integer)
      Modif : perf_event: [excl] : exclusive access (boolean)
      Modif : perf_event: [mg] : monitor guest execution (boolean)
      Modif : perf_event: [mh] : monitor host execution (boolean)
      Modif : perf_event: [cpu] : CPU to program (integer)
      Modif : perf_event: [pinned] : pin event to counters (boolean)
  BR_INST_RETIRED
    [Branch instructions retired (Precise Event)]
      Code  : 0xc4
      BR_INST_RETIRED:CONDITIONAL
        [Counts all taken and not taken macro conditional branch ...
        Umask : 0x01 : PMU: [precise]

v7 rebases and adds fallback code for libpfm4 events.
   The fallback code is to force user only priv level in case the
   perf_event_open() syscall failed for permissions reason.
   the fallback forces a user privilege level restriction on the event
   string, so depending on the syntax either u or :u is needed.
    
   But libpfm4 can use a : or . as the separator, so simply searching
   for ':' vs. '/' is not good enough to determine the syntax needed.
   Therefore, this patch introduces a new evsel boolean field to mark
   events coming from  libpfm4. The field is then used to adjust the
   fallback string.
v6 was a rebase.
v5 was a rebase.
v4 was a rebase on
   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
   branch perf/core and re-adds the tools/build/feature/test-libpfm4.c
   missed in v3.
v3 is against acme/perf/core and removes a diagnostic warning.
v2 of this patch makes the --pfm-events man page documentation
   conditional on libpfm4 behing configured. It tidies some of the
   documentation and adds the feature test missed in the v1 patch.

Ian Rogers (1):
  perf doc: allow ASCIIDOC_EXTRA to be an argument

Stephane Eranian (3):
  tools feature: add support for detecting libpfm4
  perf pmu: add perf_pmu__find_by_type helper
  perf tools: add support for libpfm4

 tools/build/Makefile.feature             |   3 +-
 tools/build/feature/Makefile             |   6 +-
 tools/build/feature/test-libpfm4.c       |   9 +
 tools/perf/Documentation/Makefile        |   4 +-
 tools/perf/Documentation/perf-record.txt |  11 +
 tools/perf/Documentation/perf-stat.txt   |  10 +
 tools/perf/Documentation/perf-top.txt    |  11 +
 tools/perf/Makefile.config               |  12 +
 tools/perf/Makefile.perf                 |   6 +-
 tools/perf/builtin-list.c                |  12 +-
 tools/perf/builtin-record.c              |  11 +
 tools/perf/builtin-stat.c                |   8 +
 tools/perf/builtin-top.c                 |   8 +
 tools/perf/tests/Build                   |   1 +
 tools/perf/tests/builtin-test.c          |   9 +
 tools/perf/tests/pfm.c                   | 207 +++++++++++++++++
 tools/perf/tests/tests.h                 |   3 +
 tools/perf/util/Build                    |   2 +
 tools/perf/util/evsel.c                  |   2 +-
 tools/perf/util/evsel.h                  |   1 +
 tools/perf/util/parse-events.c           |  30 ++-
 tools/perf/util/parse-events.h           |   4 +
 tools/perf/util/pfm.c                    | 277 +++++++++++++++++++++++
 tools/perf/util/pfm.h                    |  43 ++++
 tools/perf/util/pmu.c                    |  11 +
 tools/perf/util/pmu.h                    |   1 +
 26 files changed, 687 insertions(+), 15 deletions(-)
 create mode 100644 tools/build/feature/test-libpfm4.c
 create mode 100644 tools/perf/tests/pfm.c
 create mode 100644 tools/perf/util/pfm.c
 create mode 100644 tools/perf/util/pfm.h

-- 
2.26.0.110.g2183baf09c-goog

