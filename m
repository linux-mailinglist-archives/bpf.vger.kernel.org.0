Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEEEEA664
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2019 23:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfJ3Wey (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Oct 2019 18:34:54 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33967 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfJ3Wex (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Oct 2019 18:34:53 -0400
Received: by mail-pg1-f201.google.com with SMTP id w9so2742671pgl.1
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2019 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SRqw2LSx0YB2BdwYQ6EePHj++2f3aHwtcvmz2x8WsbQ=;
        b=gcodcIUvslFSwPfERYqecGIMte9yZP43PhQ2Qu2F0DwSy4nX1lyCG88L9b1XI1X+5I
         90cZ4xb6DDfBB4c3rGWuqDz8/ZuDnttkFXaLS41zGenOuxdev/msOAnwI9zLKNXG5PMm
         k/5nc5BKy0uwCDpRdGMXE5FtRp0c/Rr69FiBA+uuwwdAR5z1SVcESm+VaTtERF8dplMX
         cwmci8lP8mY9/PqIxVDQdpIOBNrtTzEmBPGDupEYl1hl9bFDkJfk9b3uSfeoaCjQUe+F
         0dBqIB9Acr8kyBTr6JmUqBsUoYjHFnH/pLGsgo09O/OmseQoNhxFZj4/xclg3WbcadkG
         15tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SRqw2LSx0YB2BdwYQ6EePHj++2f3aHwtcvmz2x8WsbQ=;
        b=VSs0GYxj7thyKn2QGQYCEK27cciJY6HiHW4o7Ru3ghy1iFyaLr18by2ys/s6RhVs/x
         GsgQN7LEsXC1shxH/VukQ20efvXM1z9ABYcqDZqGmQTzan2wv0wQ408wlnLDVBDQyEku
         YD1DBIKraYYSvofH2b82YBaxmcljCIcBKs5p4nk4HADhJ8LP9d9UWnQ0S3AZQh/ZOjkr
         i+ZqcmvmHPjPOee4Xm0zo8b8H58a+R0Ojab0LIrqP0MlEJcWZGXWHm/A+QjGFJoxSDwm
         C4WRKXvxBeO/VLhS8nGdSA/27YJagxUf03KJo+26i3Uxb64VVkqTfEgVTpBNQZWs2DcS
         pd3Q==
X-Gm-Message-State: APjAAAX5tPWJJ1dfT1FPoIO8zh8+wwofnrGsbItsmCSbAVWgjggfD1H2
        ld0DIZdZO1iAoE/b9rCWUh55LV7TDA+V
X-Google-Smtp-Source: APXvYqy9Ma/nNUlrb2KjTqrKbpXVkwQKxeJS0X5WWuIRbJghR6jybob5m6FKIPhd8WkYpa5BE2yhCG7IFYJJ
X-Received: by 2002:a65:588e:: with SMTP id d14mr2063152pgu.56.1572474892551;
 Wed, 30 Oct 2019 15:34:52 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:34:38 -0700
In-Reply-To: <20191025180827.191916-1-irogers@google.com>
Message-Id: <20191030223448.12930-1-irogers@google.com>
Mime-Version: 1.0
References: <20191025180827.191916-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 00/10] Improvements to memory usage by parse events
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
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The parse events parser leaks memory for certain expressions as well
as allowing a char* to reference stack, heap or .rodata. This series
of patches improves the hygeine and adds free-ing operations to
reclaim memory in the parser in error and non-error situations.

The series of patches was generated with LLVM's address sanitizer and
libFuzzer:
https://llvm.org/docs/LibFuzzer.html
called on the parse_events function with randomly generated input. With
the patches no leaks or memory corruption issues were present.

The v5 patches add initial error print to the set, as requested by
Jiri Olsa. They also fix additional 2 missed frees in the patch
'before yyabort-ing free components' and remove a redundant new_str
variable from the patch 'add parse events handle error' as spotted by
Stephane Eranian.

The v4 patches address review comments from Jiri Olsa, turning a long
error message into a single warning, fixing the data type in a list
iterator and reordering patches.

The v3 patches address review comments from Jiri Olsa improving commit
messages, handling ENOMEM errors from strdup better, and removing a
printed warning if an invalid event is passed.

The v2 patches are preferable to an earlier proposed patch:
   perf tools: avoid reading out of scope array

Ian Rogers (10):
  perf tools: add parse events handle error
  perf tools: move ALLOC_LIST into a function
  perf tools: avoid a malloc for array events
  perf tools: splice events onto evlist even on error
  perf tools: ensure config and str in terms are unique
  perf tools: add destructors for parse event terms
  perf tools: before yyabort-ing free components
  perf tools: if pmu configuration fails free terms
  perf tools: add a deep delete for parse event terms
  perf tools: report initial event parsing error

 tools/perf/arch/powerpc/util/kvm-stat.c |   9 +-
 tools/perf/builtin-stat.c               |   2 +
 tools/perf/builtin-trace.c              |  16 +-
 tools/perf/tests/parse-events.c         |   3 +-
 tools/perf/util/metricgroup.c           |   2 +-
 tools/perf/util/parse-events.c          | 236 ++++++++++----
 tools/perf/util/parse-events.h          |   7 +
 tools/perf/util/parse-events.y          | 390 +++++++++++++++++-------
 tools/perf/util/pmu.c                   |  32 +-
 9 files changed, 509 insertions(+), 188 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

