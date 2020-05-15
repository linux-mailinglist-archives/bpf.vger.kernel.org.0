Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A831D5C28
	for <lists+bpf@lfdr.de>; Sat, 16 May 2020 00:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgEOWRj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 18:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgEOWRi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 May 2020 18:17:38 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B036BC05BD09
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 15:17:38 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e44so4080326qta.9
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RIG0VC8wWBXE+zeibTDt9JODs/7dvggYtmxngUASdpU=;
        b=olvZ/Slhy5Yyi8+y+6aXL8Aj+nAjABM7NqTEQPrtoyCmkctb9h1+cXT5Ar9rEFjm28
         zdaj1Vu1aCl0p/Jsl+lj7Zl2oXs3ufiSM9V0VZ6LBf60zKDQ+fcvT2hG2jaTCM2UYaER
         GQTwlh9awOG2loH0AjoDEw00F4qcSJltIjKjMJ5wLS2VhU+eKBynXbTgsZulS71I7bom
         XjXn/NUAX35OrXSOZcdEq6YuX37IWywVz+tlUvJeOHJTUPjFJscDE07jfkQoOijsS2XE
         7qqQzmTB5NnRdlcZBGiMincFmLP5cA7jneTzhHqG9wzlqIpnzWpRwItQTu4d/MTLrtKC
         YLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RIG0VC8wWBXE+zeibTDt9JODs/7dvggYtmxngUASdpU=;
        b=WqsVvf09GQkB5k+qzt11X54TSEPQqAddPrV4Wvr13jYaCg83w+utWG9bgF5H66/YEG
         FPWMuk/UF/7IzpBtJlnmTd2z6mMpPLIlnQUMLwlMa9qgdYKai1A35QnauR4KsyN3wkx4
         /0zdMK3YGLWJBUTKVYHLt7XVDiSaw0JNgRBIlTaUT0P1JGMozUA8aoFP0gda7Fs9jSyj
         UiWsMOeLXVnqC0tBtLenyGj94RuEuAzJdshNpe6w01VK0h9d02YBQA6oC3BfS0gx7J7T
         PzupFj0vqA5MafUecYXI6k7bDVhTIFTLo3WY6jjq07Eh+JPGHMJTqsaWemRfuNVlvsk7
         vNKQ==
X-Gm-Message-State: AOAM530t3h6mKIi3IT1xWFiM7Di8dR2/A7revIK3QqEgXM3fgxXh5Bdy
        /iTS8abOHQYzuAPdw9oP3HVwfV+TPXTZ
X-Google-Smtp-Source: ABdhPJy14KsIty053SHq60u0QT6HwyCaIc4vtLao7xNAvuG4PcEU120Mqk2e/9NsPVsjpqVtvyI8eplpfjZA
X-Received: by 2002:ad4:44e3:: with SMTP id p3mr5708036qvt.166.1589581057704;
 Fri, 15 May 2020 15:17:37 -0700 (PDT)
Date:   Fri, 15 May 2020 15:17:25 -0700
Message-Id: <20200515221732.44078-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v3 0/7] Copy hashmap to tools/perf/util, use in perf expr
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
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Perf's expr code currently builds an array of strings then removes
duplicates. The array is larger than necessary and has recently been
increased in size. When this was done it was commented that a hashmap
would be preferable.

libbpf has a hashmap but libbpf isn't currently required to build
perf. To satisfy various concerns this change copies libbpf's hashmap
into tools/perf/util, it then adds a check in perf that the two are in
sync.

Andrii's patch to hashmap from bpf-next is brought into this set to
fix issues with hashmap__clear.

Two minor changes to libbpf's hashmap are made that remove an unused
dependency and fix a compiler warning.

Two perf test changes are also brought in as they need refactoring to
account for the expr API change and it is expected they will land
ahead of this.
https://lore.kernel.org/lkml/20200513062236.854-2-irogers@google.com/

Tested with 'perf test' and 'make -C tools/perf build-test'.

The hashmap change was originally part of an RFC:
https://lore.kernel.org/lkml/20200508053629.210324-1-irogers@google.com/

v3. addresses review feedback from Andrii Nakryiko <andriin@fb.com>
and Jiri Olsa <jolsa@redhat.com>.
v2. moves hashmap into tools/perf/util rather than libapi, to allow
hashmap's libbpf symbols to be visible when built statically for
testing.

Andrii Nakryiko (1):
  libbpf: Fix memory leak and possible double-free in hashmap__clear

Ian Rogers (6):
  libbpf hashmap: Remove unused #include
  libbpf hashmap: Fix signedness warnings
  tools lib/api: Copy libbpf hashmap to tools/perf/util
  perf test: Provide a subtest callback to ask for the reason for
    skipping a subtest
  perf test: Improve pmu event metric testing
  perf expr: Migrate expr ids table to a hashmap

 tools/lib/bpf/hashmap.c         |  10 +-
 tools/lib/bpf/hashmap.h         |   1 -
 tools/perf/check-headers.sh     |   4 +
 tools/perf/tests/builtin-test.c |  18 ++-
 tools/perf/tests/expr.c         |  44 +++---
 tools/perf/tests/pmu-events.c   | 169 ++++++++++++++++++++++-
 tools/perf/tests/tests.h        |   4 +
 tools/perf/util/Build           |   4 +
 tools/perf/util/expr.c          | 129 +++++++++--------
 tools/perf/util/expr.h          |  26 ++--
 tools/perf/util/expr.y          |  22 +--
 tools/perf/util/hashmap.c       | 238 ++++++++++++++++++++++++++++++++
 tools/perf/util/hashmap.h       | 177 ++++++++++++++++++++++++
 tools/perf/util/metricgroup.c   |  92 ++++++------
 tools/perf/util/stat-shadow.c   |  49 ++++---
 15 files changed, 798 insertions(+), 189 deletions(-)
 create mode 100644 tools/perf/util/hashmap.c
 create mode 100644 tools/perf/util/hashmap.h

-- 
2.26.2.761.g0e0b3e54be-goog

