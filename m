Return-Path: <bpf+bounces-10664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CCB7ABDD9
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D2C6C28222B
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7205B20F5;
	Sat, 23 Sep 2023 05:35:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F881B
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:35:39 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEAF19E
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e9a08f882so51255947b3.3
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447337; x=1696052137; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nz52NPo/ldRCO4SlmJCa/5s+fqete8nkApWr4O0tYXg=;
        b=v0gr7cPWUEjzrH4M9hCXYqtzyhLDUn1sNxRtXxDiaxOYA5gR/Sr45yji+/H2KK9bnC
         4+K2JcPBOJ4VSa6yc2Vb+GxyKeVwd0N/LGZfJFoFCq8YArrcFm0XmvMPB2uf7zAWBYTb
         cX+QM/e7bKKSxztbBLDj3VVAGYkn7jCq2YBYY58wx4NLl7fiaNm9IaAaJpGz2Pe8ajBV
         +b4SDwiEBXaZ2EFzfKWzqpNhdK7QzsIDavFva7bRBXAtZXU5nnCejVv2646bNUmOxNYA
         WFfAkjQbdhmVNVZAtYymBUpO7T2YKP/qc14GUu1t+HAnVowxM88tilYYYOqnBtNNyu4O
         BJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447337; x=1696052137;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nz52NPo/ldRCO4SlmJCa/5s+fqete8nkApWr4O0tYXg=;
        b=YPwioDRb5/DIvkE2Pue8I7HKTddMR3kbTk6w+uQAIlWD6R1ocxmrGSDhCOdb3HSDED
         4JK+SDk+E9iadI33IvfNCtnCoZPb2HgxolqC5KPTiFEZQy/LBzU7eXoSW8nFXLlf0HNX
         X6MaKO45HN5syWjjzhtE35g83Xj77MfKw4Ls54DZ+cFhFchGIwH+RmJjpfRGUap2VDMO
         dfjmpkAEuApIrvKl+LijV14Dbz1yD3QKE+p6L4TCd/vdnwK8YAR7EuXytBTHFxrgZW+W
         tcdLsWukPxJf1yE9zQvhf1LRW/an2P6kR7yO/V/GdMbrcPzuLur8wcmrBdkTrr1IKeCq
         ztHw==
X-Gm-Message-State: AOJu0Yyxa6ZEHlWJC/hbGgznnogQrfjPxuRnrTgx5g+K3i5bXZIgxN5B
	UyzgzxTvFsjj88KLK42UvLG4ID8Jjg11
X-Google-Smtp-Source: AGHT+IFCqnNJv73Q/yXR30wTlheSaQlr3r+LpivpJ1x8n3rk2tghT2eny4ehycX34rqpiIXzwwawLsihbDb2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a81:4417:0:b0:59b:db15:a088 with SMTP id
 r23-20020a814417000000b0059bdb15a088mr21169ywa.3.1695447336863; Fri, 22 Sep
 2023 22:35:36 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:34:57 -0700
Message-Id: <20230923053515.535607-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 00/18] clang-tools support in tools
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Allow the clang-tools scripts to work with builds in tools such as
tools/perf and tools/lib/perf. An example use looks like:

```
$ cd tools/perf
$ make CC=clang CXX=clang++
$ ../../scripts/clang-tools/gen_compile_commands.py
$ ../../scripts/clang-tools/run-clang-tools.py clang-tidy compile_commands.json -checks=-*,readability-named-parameter
Skipping non-C file: 'tools/perf/bench/mem-memcpy-x86-64-asm.S'
Skipping non-C file: 'tools/perf/bench/mem-memset-x86-64-asm.S'
Skipping non-C file: 'tools/perf/arch/x86/tests/regs_load.S'
8 warnings generated.
Suppressed 8 warnings (8 in non-user code).
Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
2 warnings generated.
4 warnings generated.
Suppressed 4 warnings (4 in non-user code).
Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
2 warnings generated.
4 warnings generated.
Suppressed 4 warnings (4 in non-user code).
Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
3 warnings generated.
tools/perf/util/parse-events-flex.c:546:27: warning: all parameters should be named in a function [readability-named-parameter]
void *yyalloc ( yy_size_t , yyscan_t yyscanner );
                          ^
                           /*size*/
...
```

Fix a number of the more serious low-hanging issues in perf found by
clang-tidy.

This support isn't complete, in particular it doesn't support output
directories properly and so fails for tools/lib/bpf, tools/bpf/bpftool
and if an output directory is used.

Ian Rogers (18):
  gen_compile_commands: Allow the line prefix to still be cmd_
  gen_compile_commands: Sort output compile commands by file name
  run-clang-tools: Add pass through checks and and header-filter
    arguments
  perf hisi-ptt: Fix potential memory leak
  perf bench uprobe: Fix potential use of memory after free
  perf buildid-cache: Fix use of uninitialized value
  perf env: Remove unnecessary NULL tests
  perf jitdump: Avoid memory leak
  perf mem-events: Avoid uninitialized read
  perf dlfilter: Be defensive against potential NULL dereference
  perf hists browser: Reorder variables to reduce padding
  perf hists browser: Avoid potential NULL dereference
  perf svghelper: Avoid memory leak
  perf parse-events: Fix unlikely memory leak when cloning terms
  tools api: Avoid potential double free
  perf trace-event-info: Avoid passing NULL value to closedir
  perf header: Fix various error path memory leaks
  perf bpf_counter: Fix a few memory leaks

 scripts/clang-tools/gen_compile_commands.py |  8 +--
 scripts/clang-tools/run-clang-tools.py      | 34 ++++++++---
 tools/lib/api/io.h                          |  1 +
 tools/perf/bench/uprobe.c                   |  1 +
 tools/perf/builtin-buildid-cache.c          |  6 +-
 tools/perf/builtin-lock.c                   |  1 +
 tools/perf/ui/browsers/hists.c              |  6 +-
 tools/perf/util/bpf_counter.c               |  5 +-
 tools/perf/util/dlfilter.c                  |  4 +-
 tools/perf/util/env.c                       |  6 +-
 tools/perf/util/header.c                    | 63 +++++++++++++--------
 tools/perf/util/hisi-ptt.c                  | 12 ++--
 tools/perf/util/jitdump.c                   |  1 +
 tools/perf/util/mem-events.c                |  3 +-
 tools/perf/util/parse-events.c              |  4 +-
 tools/perf/util/svghelper.c                 |  5 +-
 tools/perf/util/trace-event-info.c          |  3 +-
 17 files changed, 106 insertions(+), 57 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog


