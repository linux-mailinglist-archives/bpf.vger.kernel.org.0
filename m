Return-Path: <bpf+bounces-11784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C03F7BF239
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 07:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15481281C79
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 05:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E055664;
	Tue, 10 Oct 2023 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948E2591;
	Tue, 10 Oct 2023 05:31:24 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA65A4;
	Mon,  9 Oct 2023 22:31:22 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so4296535b3a.3;
        Mon, 09 Oct 2023 22:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696915882; x=1697520682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vt2BqSIdl0ZNPc+ubdcIw6eHOY2+gZYtqV36VU3obnI=;
        b=RZmqpZEQnnHvy5bd/idU8FJTIuZkhnpf4c93ng4ppIoS2EnDE52ynqFad4ax94hwsx
         pHlWGk2Yx+Shp0ApnPomDPporzS7XgjDu/gEI4E/PvXOtbfXVNCiVnC1Anzx8mrwVvXV
         LrF1MB2WF8E35JVq7utRYECOC5l6TqTweWV2h+Vy5GodYqPYAfmc0SwRB41WOkw4K84E
         j9rrWZ89oLQVqb1Xs9WJrc/avxpyrmMV7xorL4wxOah7/5/PvX5Kgs0CB5WYFEIc+UUX
         EUggv1Rl8XJhF9VoXhxepOaHz3aJzmOD4NBS8Qo7a13hW30IR8cn6r0PunxOI/QrmH0Q
         fZyw==
X-Gm-Message-State: AOJu0YyhnKGgawITaeGTwodWk1zWCUC460wYF9gtf5aoqi39BP2S7LIz
	TfyDc8Q3JqDVX0xDMn9chvy/r9ruwXoQDebdKN8=
X-Google-Smtp-Source: AGHT+IEI28EFr1hR6ZNm1Rf2G5yChgniRPi2Ejn2WPUoqwH0AD8e844VB1VG+gpwmw4dZ5vSHy/gWmU4RMhWv7kEDJk=
X-Received: by 2002:a05:6a20:a121:b0:16b:d853:9a10 with SMTP id
 q33-20020a056a20a12100b0016bd8539a10mr13408996pzk.39.1696915882046; Mon, 09
 Oct 2023 22:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 9 Oct 2023 22:31:10 -0700
Message-ID: <CAM9d7cgwam22Fn3tvJ7dJL1zHWTQa1ixvePTMPQmvYQLn2=DxA@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] clang-tools support in tools
To: Ian Rogers <irogers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ming Wang <wangming01@loongson.cn>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ian,

On Mon, Oct 9, 2023 at 11:39=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Allow the clang-tools scripts to work with builds in tools such as
> tools/perf and tools/lib/perf. An example use looks like:
>
> ```
> $ cd tools/perf
> $ make CC=3Dclang CXX=3Dclang++
> $ ../../scripts/clang-tools/gen_compile_commands.py
> $ ../../scripts/clang-tools/run-clang-tools.py clang-tidy compile_command=
s.json -checks=3D-*,readability-named-parameter
> Skipping non-C file: 'tools/perf/bench/mem-memcpy-x86-64-asm.S'
> Skipping non-C file: 'tools/perf/bench/mem-memset-x86-64-asm.S'
> Skipping non-C file: 'tools/perf/arch/x86/tests/regs_load.S'
> 8 warnings generated.
> Suppressed 8 warnings (8 in non-user code).
> Use -header-filter=3D.* to display errors from all non-system headers. Us=
e -system-headers to display errors from system headers as well.
> 2 warnings generated.
> 4 warnings generated.
> Suppressed 4 warnings (4 in non-user code).
> Use -header-filter=3D.* to display errors from all non-system headers. Us=
e -system-headers to display errors from system headers as well.
> 2 warnings generated.
> 4 warnings generated.
> Suppressed 4 warnings (4 in non-user code).
> Use -header-filter=3D.* to display errors from all non-system headers. Us=
e -system-headers to display errors from system headers as well.
> 3 warnings generated.
> tools/perf/util/parse-events-flex.c:546:27: warning: all parameters shoul=
d be named in a function [readability-named-parameter]
> void *yyalloc ( yy_size_t , yyscan_t yyscanner );
>                           ^
>                            /*size*/
> ...
> ```
>
> Fix a number of the more serious low-hanging issues in perf found by
> clang-tidy.
>
> This support isn't complete, in particular it doesn't support output
> directories properly and so fails for tools/lib/bpf, tools/bpf/bpftool
> and if an output directory is used.
>
> v3. Add Nick Desaulniers reviewed-by to patch 3. For Namhyung, drop
>     "perf hisi-ptt: Fix potential memory leak", split lock change out
>     of "perf svghelper: Avoid memory leak" and address comments in
>     "perf header: Fix various error path memory leaks".
> v2: Address comments by Nick Desaulniers in patch 3, and add their
>     Reviewed-by to patches 1 and 2.
>
> Ian Rogers (18):
>   gen_compile_commands: Allow the line prefix to still be cmd_
>   gen_compile_commands: Sort output compile commands by file name
>   run-clang-tools: Add pass through checks and header-filter arguments
>   perf bench uprobe: Fix potential use of memory after free
>   perf buildid-cache: Fix use of uninitialized value
>   perf env: Remove unnecessary NULL tests
>   perf jitdump: Avoid memory leak
>   perf mem-events: Avoid uninitialized read
>   perf dlfilter: Be defensive against potential NULL dereference
>   perf hists browser: Reorder variables to reduce padding
>   perf hists browser: Avoid potential NULL dereference
>   perf svghelper: Avoid memory leak
>   perf lock: Fix a memory leak on an error path
>   perf parse-events: Fix unlikely memory leak when cloning terms
>   tools api: Avoid potential double free
>   perf trace-event-info: Avoid passing NULL value to closedir
>   perf header: Fix various error path memory leaks
>   perf bpf_counter: Fix a few memory leaks

I agree with your comment on v2 that it needs more work
to clean the code up.  Anyway I'm ok with v3 now.

For ther perf part (patch 4 to 18),
Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  scripts/clang-tools/gen_compile_commands.py |  8 +--
>  scripts/clang-tools/run-clang-tools.py      | 32 ++++++++---
>  tools/lib/api/io.h                          |  1 +
>  tools/perf/bench/uprobe.c                   |  1 +
>  tools/perf/builtin-buildid-cache.c          |  6 ++-
>  tools/perf/builtin-lock.c                   |  1 +
>  tools/perf/ui/browsers/hists.c              |  6 +--
>  tools/perf/util/bpf_counter.c               |  5 +-
>  tools/perf/util/dlfilter.c                  |  4 +-
>  tools/perf/util/env.c                       |  6 +--
>  tools/perf/util/header.c                    | 60 ++++++++++++---------
>  tools/perf/util/jitdump.c                   |  1 +
>  tools/perf/util/mem-events.c                |  3 +-
>  tools/perf/util/parse-events.c              |  4 +-
>  tools/perf/util/svghelper.c                 |  5 +-
>  tools/perf/util/trace-event-info.c          |  3 +-
>  16 files changed, 94 insertions(+), 52 deletions(-)
>
> --
> 2.42.0.609.gbb76f46606-goog
>

