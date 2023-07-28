Return-Path: <bpf+bounces-6180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3E67667EF
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 10:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE432824D6
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A90107AF;
	Fri, 28 Jul 2023 08:56:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708FB10796
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 08:56:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E36E3A9B;
	Fri, 28 Jul 2023 01:56:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43993D75;
	Fri, 28 Jul 2023 01:57:31 -0700 (PDT)
Received: from [10.57.0.116] (unknown [10.57.0.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 271683F67D;
	Fri, 28 Jul 2023 01:56:45 -0700 (PDT)
Message-ID: <bd06ac8f-f3be-cd46-7dd7-86db7e7b7c63@arm.com>
Date: Fri, 28 Jul 2023 09:56:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 2/6] perf build: Don't always set -funwind-tables and
 -ggdb3
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20230728064917.767761-1-irogers@google.com>
 <20230728064917.767761-3-irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 Kan Liang <kan.liang@linux.intel.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Gaosheng Cui <cuigaosheng1@huawei.com>,
 Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
From: James Clark <james.clark@arm.com>
In-Reply-To: <20230728064917.767761-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 28/07/2023 07:49, Ian Rogers wrote:
> Commit 6a40cd90f5de ("perf tools: Add libunwind dependency for DWARF
> CFI unwinding") added libunwind support but also -funwind-tables and
> -ggdb3 to the standard build. These build flags aren't necessary so
> remove, set -g when DEBUG is enabled for the build.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a9cfe83638a9..14709a6bd622 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -246,6 +246,9 @@ ifeq ($(CC_NO_CLANG), 0)
>  else
>    CORE_CFLAGS += -O6
>  endif
> +else
> +  CORE_CFLAGS += -g
> +  CXXFLAGS += -g
>  endif
>  
>  ifdef PARSER_DEBUG
> @@ -324,8 +327,6 @@ FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
>  FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
>  
>  CORE_CFLAGS += -fno-omit-frame-pointer
> -CORE_CFLAGS += -ggdb3
> -CORE_CFLAGS += -funwind-tables
>  CORE_CFLAGS += -Wall
>  CORE_CFLAGS += -Wextra
>  CORE_CFLAGS += -std=gnu11
> @@ -333,8 +334,6 @@ CORE_CFLAGS += -std=gnu11
>  CXXFLAGS += -std=gnu++14 -fno-exceptions -fno-rtti
>  CXXFLAGS += -Wall
>  CXXFLAGS += -fno-omit-frame-pointer
> -CXXFLAGS += -ggdb3
> -CXXFLAGS += -funwind-tables
>  CXXFLAGS += -Wno-strict-aliasing
>  
>  HOSTCFLAGS += -Wall

Acked-by: James Clark <james.clark@arm.com>

