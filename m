Return-Path: <bpf+bounces-12066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B076C7C74BD
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 19:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAED7282D98
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD83588F;
	Thu, 12 Oct 2023 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C9347CB;
	Thu, 12 Oct 2023 17:26:51 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB51FD6C;
	Thu, 12 Oct 2023 10:24:02 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-27cfb8442f9so881447a91.2;
        Thu, 12 Oct 2023 10:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131442; x=1697736242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJnRK+79WNn0lGWIpav/hJW9jfda5+J6HE7W4OW4WDg=;
        b=pIni7pUJgajGYSQU9SwzMEYgHHHdN24f7FuW5z6iwT5Y3Qbq4DKAVLmKXDNkehhJfb
         o84qccj2pQfymB+6z1XrgKf8lXryt/dqJNBSvevXZ48TH0Zv0vSYqs4MC30fJRT7bvR7
         kHfLxczs5QunRMwof5JIwzbPGEMHIdRC0gl9CzuomngS4iexxt334utspR42uH+tW8BX
         PcSI3GQXJGAi0UVY934GK/O4ESSlBx/t12kVElLFUlc3ANTWhFdl8ku0u9jORuZOFxg5
         lOLWAi8R3Uxoz0BjZ180Di6I/1e4CH+zC+Q8NmZ5SCUQuRnoOL7qfpp0PXFRypiRBhZi
         lbxg==
X-Gm-Message-State: AOJu0YzqW4RvugHeUHRKUhmnrSlogUhF3HRYg3or4SJpy28JPN8af9yh
	gOShiXHzCV0D+0UughpY6HQLLgl9qWudgfxnaAU=
X-Google-Smtp-Source: AGHT+IFUhH11sDmFlYL7MWiTUMkq8goHP9pDVnkcL763Chb34fwG4DLwbzeA5QXZ9dzWHTz7uN1GoKUjJnFvWXox8KU=
X-Received: by 2002:a17:90b:14a:b0:27c:facc:e3eb with SMTP id
 em10-20020a17090b014a00b0027cfacce3ebmr6883711pjb.31.1697131442112; Thu, 12
 Oct 2023 10:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com> <CAM9d7cgwam22Fn3tvJ7dJL1zHWTQa1ixvePTMPQmvYQLn2=DxA@mail.gmail.com>
In-Reply-To: <CAM9d7cgwam22Fn3tvJ7dJL1zHWTQa1ixvePTMPQmvYQLn2=DxA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 12 Oct 2023 10:23:51 -0700
Message-ID: <CAM9d7cjgpXwC6D7F1DMrMw1j1k=o7oDw94Ofb_Xiyt_s7t5gJA@mail.gmail.com>
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

On Mon, Oct 9, 2023 at 10:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Mon, Oct 9, 2023 at 11:39=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Allow the clang-tools scripts to work with builds in tools such as
> > tools/perf and tools/lib/perf. An example use looks like:
> >
> > ```
> > $ cd tools/perf
> > $ make CC=3Dclang CXX=3Dclang++
> > $ ../../scripts/clang-tools/gen_compile_commands.py
> > $ ../../scripts/clang-tools/run-clang-tools.py clang-tidy compile_comma=
nds.json -checks=3D-*,readability-named-parameter
> > Skipping non-C file: 'tools/perf/bench/mem-memcpy-x86-64-asm.S'
> > Skipping non-C file: 'tools/perf/bench/mem-memset-x86-64-asm.S'
> > Skipping non-C file: 'tools/perf/arch/x86/tests/regs_load.S'
> > 8 warnings generated.
> > Suppressed 8 warnings (8 in non-user code).
> > Use -header-filter=3D.* to display errors from all non-system headers. =
Use -system-headers to display errors from system headers as well.
> > 2 warnings generated.
> > 4 warnings generated.
> > Suppressed 4 warnings (4 in non-user code).
> > Use -header-filter=3D.* to display errors from all non-system headers. =
Use -system-headers to display errors from system headers as well.
> > 2 warnings generated.
> > 4 warnings generated.
> > Suppressed 4 warnings (4 in non-user code).
> > Use -header-filter=3D.* to display errors from all non-system headers. =
Use -system-headers to display errors from system headers as well.
> > 3 warnings generated.
> > tools/perf/util/parse-events-flex.c:546:27: warning: all parameters sho=
uld be named in a function [readability-named-parameter]
> > void *yyalloc ( yy_size_t , yyscan_t yyscanner );
> >                           ^
> >                            /*size*/
> > ...
> > ```
> >
> > Fix a number of the more serious low-hanging issues in perf found by
> > clang-tidy.
> >
> > This support isn't complete, in particular it doesn't support output
> > directories properly and so fails for tools/lib/bpf, tools/bpf/bpftool
> > and if an output directory is used.
> >
> > v3. Add Nick Desaulniers reviewed-by to patch 3. For Namhyung, drop
> >     "perf hisi-ptt: Fix potential memory leak", split lock change out
> >     of "perf svghelper: Avoid memory leak" and address comments in
> >     "perf header: Fix various error path memory leaks".
> > v2: Address comments by Nick Desaulniers in patch 3, and add their
> >     Reviewed-by to patches 1 and 2.
> >
> > Ian Rogers (18):
> >   gen_compile_commands: Allow the line prefix to still be cmd_
> >   gen_compile_commands: Sort output compile commands by file name
> >   run-clang-tools: Add pass through checks and header-filter arguments
> >   perf bench uprobe: Fix potential use of memory after free
> >   perf buildid-cache: Fix use of uninitialized value
> >   perf env: Remove unnecessary NULL tests
> >   perf jitdump: Avoid memory leak
> >   perf mem-events: Avoid uninitialized read
> >   perf dlfilter: Be defensive against potential NULL dereference
> >   perf hists browser: Reorder variables to reduce padding
> >   perf hists browser: Avoid potential NULL dereference
> >   perf svghelper: Avoid memory leak
> >   perf lock: Fix a memory leak on an error path
> >   perf parse-events: Fix unlikely memory leak when cloning terms
> >   tools api: Avoid potential double free
> >   perf trace-event-info: Avoid passing NULL value to closedir
> >   perf header: Fix various error path memory leaks
> >   perf bpf_counter: Fix a few memory leaks
>
> I agree with your comment on v2 that it needs more work
> to clean the code up.  Anyway I'm ok with v3 now.
>
> For ther perf part (patch 4 to 18),
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!

