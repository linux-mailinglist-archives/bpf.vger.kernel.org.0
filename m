Return-Path: <bpf+bounces-11747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B87BE9C5
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 20:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451931C203AB
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E9B18E24;
	Mon,  9 Oct 2023 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y1baXPaW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94672156F2
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 18:39:28 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154FBB7
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 11:39:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7ac9c1522so7543607b3.0
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876766; x=1697481566; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BpyZW6SIyDMddq/KpJ5/Dy63Sl93+U/oxSoQXfrAQ3A=;
        b=y1baXPaW4ackkfC5Ocaos5AsCGcbojhoUujqkbBVvlh7CKfLny2xAHK+jviqyTvOE6
         2FXlyAWm+JezeyFyZsrHAbbDiHxZftwUkVU8yDiwLQ3gt4YlbSYXatma/ggXQERSmjVk
         7oRxE8stHnCVmMMDwS0Vaj8IT/9a4DsUGNQzfvtpoPgW/UGTZMDNxbx3VklyHE+5kfMU
         p21JwWty6nqMm3pp15bL6B67dggp8g1hSkyKKmfOIMJDaxCJ1kvarXb75wM1vw1T/IH/
         WI6UKDAEq8EJ3pDfItbNcwMkUR8bv4NJWbfmsW3PMe99ZFPSpW3VXMkLRwD0G47jDkjT
         jqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876766; x=1697481566;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BpyZW6SIyDMddq/KpJ5/Dy63Sl93+U/oxSoQXfrAQ3A=;
        b=SQK2wkq7taqo7QoIlee4dDA0OXucuxekKEDidrJVNtbxPxp+miy6KaAGIhlV79bmnP
         adqYSTlf2Gy5vQdG4YwBCnjDYXhxbXBn1xmA0awR2yZM2yKrUIKS/6z076FoJP7Tnjm/
         gKzfMD4MVPd/auRYEYAKTA+w6HnT6ckjweWs53njPTEyNQgCA0KbUg3NQFh+43hFctaH
         KNCM9COGike0BcEJQtd3DnBZwB/jfrSGoAwYHjQNUq7Ii3Tt6u8dlIY41hLledu+LPIy
         EthT2bPbTciKpjanBhflGTFWy7JK629Dt3g26QxFVv+ga9sBkUdqfhnCiOBXt/eUN9oK
         J/SA==
X-Gm-Message-State: AOJu0Yz9BAlJt650bgaGYKor3bfpMK5CsRueMnriNi/43ce5wdP0+ZRT
	nYZJ8/7Fo6fVltmB4IqoO3pn67D4xT7y
X-Google-Smtp-Source: AGHT+IE5eoNJprN8tdSYHf6jE8fdT3BZ0VpowwVuHGUswqy5qF7XIcGdLKN5PekbQIWRZ7TgfCwwYCkWsS2V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a81:bd08:0:b0:59b:c811:a702 with SMTP id
 b8-20020a81bd08000000b0059bc811a702mr300054ywi.6.1696876766254; Mon, 09 Oct
 2023 11:39:26 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:01 -0700
Message-Id: <20231009183920.200859-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 00/18] clang-tools support in tools
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ming Wang <wangming01@loongson.cn>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
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

v3. Add Nick Desaulniers reviewed-by to patch 3. For Namhyung, drop
    "perf hisi-ptt: Fix potential memory leak", split lock change out
    of "perf svghelper: Avoid memory leak" and address comments in
    "perf header: Fix various error path memory leaks".
v2: Address comments by Nick Desaulniers in patch 3, and add their
    Reviewed-by to patches 1 and 2.

Ian Rogers (18):
  gen_compile_commands: Allow the line prefix to still be cmd_
  gen_compile_commands: Sort output compile commands by file name
  run-clang-tools: Add pass through checks and header-filter arguments
  perf bench uprobe: Fix potential use of memory after free
  perf buildid-cache: Fix use of uninitialized value
  perf env: Remove unnecessary NULL tests
  perf jitdump: Avoid memory leak
  perf mem-events: Avoid uninitialized read
  perf dlfilter: Be defensive against potential NULL dereference
  perf hists browser: Reorder variables to reduce padding
  perf hists browser: Avoid potential NULL dereference
  perf svghelper: Avoid memory leak
  perf lock: Fix a memory leak on an error path
  perf parse-events: Fix unlikely memory leak when cloning terms
  tools api: Avoid potential double free
  perf trace-event-info: Avoid passing NULL value to closedir
  perf header: Fix various error path memory leaks
  perf bpf_counter: Fix a few memory leaks

 scripts/clang-tools/gen_compile_commands.py |  8 +--
 scripts/clang-tools/run-clang-tools.py      | 32 ++++++++---
 tools/lib/api/io.h                          |  1 +
 tools/perf/bench/uprobe.c                   |  1 +
 tools/perf/builtin-buildid-cache.c          |  6 ++-
 tools/perf/builtin-lock.c                   |  1 +
 tools/perf/ui/browsers/hists.c              |  6 +--
 tools/perf/util/bpf_counter.c               |  5 +-
 tools/perf/util/dlfilter.c                  |  4 +-
 tools/perf/util/env.c                       |  6 +--
 tools/perf/util/header.c                    | 60 ++++++++++++---------
 tools/perf/util/jitdump.c                   |  1 +
 tools/perf/util/mem-events.c                |  3 +-
 tools/perf/util/parse-events.c              |  4 +-
 tools/perf/util/svghelper.c                 |  5 +-
 tools/perf/util/trace-event-info.c          |  3 +-
 16 files changed, 94 insertions(+), 52 deletions(-)

-- 
2.42.0.609.gbb76f46606-goog


