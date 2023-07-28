Return-Path: <bpf+bounces-6178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3B7667BE
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 10:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2F92826C4
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 08:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E0107B5;
	Fri, 28 Jul 2023 08:51:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6924107AF
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 08:51:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA6CC2728;
	Fri, 28 Jul 2023 01:51:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC5852F4;
	Fri, 28 Jul 2023 01:51:46 -0700 (PDT)
Received: from [10.57.0.116] (unknown [10.57.0.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1BF53F67D;
	Fri, 28 Jul 2023 01:51:00 -0700 (PDT)
Message-ID: <a8833945-3f0a-7651-39ff-a01e7edc2b3a@arm.com>
Date: Fri, 28 Jul 2023 09:50:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 4/6] perf build: Disable fewer flex warnings
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
References: <20230728064917.767761-1-irogers@google.com>
 <20230728064917.767761-5-irogers@google.com>
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
In-Reply-To: <20230728064917.767761-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 28/07/2023 07:49, Ian Rogers wrote:
> If flex is version 2.6.4, reduce the number of flex C warnings
> disabled. Earlier flex versions have all C warnings disabled.

Hi Ian,

I get a build error with either this one or the bison warning change:

  $ make LLVM=1 -C tools/perf NO_BPF_SKEL=1 DEBUG=1

  util/pmu-bison.c:855:9: error: variable 'perf_pmu_nerrs' set but not
used [-Werror,-Wunused-but-set-variable]
    int yynerrs = 0;

I tried a clean build which normally fixes these kind of bison errors.
Let me know if you need any version info.

James

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/Build | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 96f4ea1d45c5..32239c4b0393 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -279,13 +279,9 @@ $(OUTPUT)util/bpf-filter-bison.c $(OUTPUT)util/bpf-filter-bison.h: util/bpf-filt
>  	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
>  		-o $(OUTPUT)util/bpf-filter-bison.c -p perf_bpf_filter_
>  
> -FLEX_GE_26 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 26)
> -ifeq ($(FLEX_GE_26),1)
> -  flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function -Wno-redundant-decls -Wno-sign-compare -Wno-unused-parameter -Wno-missing-prototypes -Wno-missing-declarations
> -  CC_HASNT_MISLEADING_INDENTATION := $(shell echo "int main(void) { return 0 }" | $(CC) -Werror -Wno-misleading-indentation -o /dev/null -xc - 2>&1 | grep -q -- -Wno-misleading-indentation ; echo $$?)
> -  ifeq ($(CC_HASNT_MISLEADING_INDENTATION), 1)
> -    flex_flags += -Wno-misleading-indentation
> -  endif
> +FLEX_GE_264 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 264)
> +ifeq ($(FLEX_GE_264),1)
> +  flex_flags := -Wno-redundant-decls -Wno-switch-default -Wno-unused-function
>  else
>    flex_flags := -w
>  endif

