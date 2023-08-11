Return-Path: <bpf+bounces-7562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 130D77793EC
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441D31C2175F
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E615692;
	Fri, 11 Aug 2023 16:09:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDA21170B
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:09:48 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C567F10DE;
	Fri, 11 Aug 2023 09:09:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe4b95c371so12959845e9.1;
        Fri, 11 Aug 2023 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691770185; x=1692374985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gj6RcIM5t5nz3eaWtpxz9vjlj23IfmgvBZ8zsd7klI8=;
        b=muVl4Xl+lTMTvOpFocZFUmDiEvnMOY8PFCuwOkx56ORPFHaWulsQfIHWvc2KpPJg+w
         DpFVVQ782tZV/qB4bHcFQST3Zx9E+SPLPnwLmx+lsPpCISssU1ZZTRs62PGarbC4B2XM
         xZMnNyH10k0bZro92O6fshpbenTntEIOere/zh32An0uUBQeMiDdgfbXDmdBNpI7kwcC
         JJ2ZEZz5VuY84U5BSvPG62mKY3hZJX/aoqJ+3Bs3XWBzbKLIQs+okNRY/DSKFAEzq4Lv
         oNxtAWi9hQqmuIYCQoKSqAbeYAgotyS4g9DPbshX1Y3+MB29QEa6aDKrdlrlSM/EVmiG
         hrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691770185; x=1692374985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gj6RcIM5t5nz3eaWtpxz9vjlj23IfmgvBZ8zsd7klI8=;
        b=Wc3lMJU3gwArphdBtGGjWGbrsvUkItV1WHTuETZza9pDnPfROhsKO8pnyXHzclpA8H
         Fk9WJb1uY/El9t/kBmnz6sQTYnnelieRcPScE7x9BbXGvx5piElsrWQLSomQGv2ByHH/
         V27LQVIGGOJN2HslJZLGuHZTqROldc40qikX5k6YziZTmdSBmd8L4/xsrrI3mcVdT7/j
         nDU/hruF0dRrFTehOU7k36VFFHtOuFMeRWcfcdyc2tLHLCdltcSZamYtoPVBtMpujey0
         S/OHd9o4yuv1L8fJk/2YfyxMgrhmdgfJiB5pN89Cu8AzNvBlI49bF4xN3qdU0XkHID0i
         u/5g==
X-Gm-Message-State: AOJu0YxzNsKoAyraPfMYkah4iice+BZdFwuv7lGDYOR/o1AU5niyvU1e
	fYOwEvYKGhOAC/g4+dPQy4w=
X-Google-Smtp-Source: AGHT+IGcKf6v/9EVJ1A6GtZyZCJRuvnjFiatNiZiqH2sDuZt3qBsnnHi+Jv6+UD0KsEolE/9XDF+kg==
X-Received: by 2002:a1c:6a14:0:b0:3fe:1c10:8d04 with SMTP id f20-20020a1c6a14000000b003fe1c108d04mr2014646wmc.19.1691770184869;
        Fri, 11 Aug 2023 09:09:44 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id c6-20020a7bc846000000b003fe0a0e03fcsm8419320wml.12.2023.08.11.09.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:09:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 11 Aug 2023 18:09:41 +0200
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Fangrui Song <maskray@google.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Carsten Haitzler <carsten.haitzler@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	James Clark <james.clark@arm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, Wang Nan <wangnan0@huawei.com>,
	Wang ShaoBo <bobo.shaobowang@huawei.com>,
	YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>,
	Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: [PATCH v1 0/4] Remove BPF event support
Message-ID: <ZNZdRfkWqqZVltt+@krava>
References: <20230810184853.2860737-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810184853.2860737-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 11:48:49AM -0700, Ian Rogers wrote:
> The patch series removes BPF event support as past commits have shown
> the support has bit rotten:
> https://lore.kernel.org/lkml/20230728001212.457900-1-irogers@google.com/
> 
> Similar functionality is now available via the --filter option, that
> uses a BPF skeleton, and is therefore more compact and simpler to
> use. The simplicity coming from not having to build BPF object files.
> 
> A different use case for the events was for syscall augmentation in
> perf trace. So that this isn't broken, and to make its use
> significantly simpler, the support is migrated to use a BPF
> skeleton. This means perf trace is much more likely to augment
> syscalls for users.
> 
> Removal of BPF events was raised on LKML two weeks ago with the
> original authors cc-ed:
> https://lore.kernel.org/lkml/CAP-5=fXxGimJRXKf7bcaPqfjxxGcn1k3CspY_iSjQnpAKs3uFQ@mail.gmail.com/
> 
> BPF events are described publicly in very few places but one is:
> https://www.brendangregg.com/perf.html#eBPF
> "eBPF is currently a little restricted and difficult to use from
> perf. It's getting better all the time. A different and currently
> easier way to access eBPF is via the bcc Python interface, which is
> described on my eBPF Tools page. On this page, I'll discuss perf."
> 
> I don't think the "getting better all the time" is any longer true as
> BPF features are being added to perf primarily by using BPF
> skeletons. The given example is a filter and would be better supported
> via "perf record --filter".

agreed, I don't think it's being really used as well,
also caused problems with libbpf updates

> 
> Ian Rogers (4):
>   perf parse-events: Remove BPF event support
>   perf trace: Migrate BPF augmentation to use a skeleton
>   perf bpf examples: With no BPF events remove examples
>   perf trace: Tidy comments
> 
>  tools/perf/Documentation/perf-config.txt      |   33 -
>  tools/perf/Documentation/perf-record.txt      |   22 -
>  tools/perf/Makefile.config                    |   43 -
>  tools/perf/Makefile.perf                      |   19 +-
>  tools/perf/builtin-record.c                   |   45 -
>  tools/perf/builtin-trace.c                    |  310 +--
>  tools/perf/examples/bpf/5sec.c                |   53 -
>  tools/perf/examples/bpf/empty.c               |   12 -
>  tools/perf/examples/bpf/hello.c               |   27 -
>  tools/perf/examples/bpf/sys_enter_openat.c    |   33 -
>  tools/perf/perf.c                             |    2 -
>  tools/perf/tests/.gitignore                   |    5 -
>  tools/perf/tests/Build                        |   31 -
>  tools/perf/tests/bpf-script-example.c         |   60 -
>  tools/perf/tests/bpf-script-test-kbuild.c     |   21 -
>  tools/perf/tests/bpf-script-test-prologue.c   |   49 -
>  tools/perf/tests/bpf-script-test-relocation.c |   51 -
>  tools/perf/tests/bpf.c                        |  390 ----
>  tools/perf/tests/builtin-test.c               |    3 -
>  tools/perf/tests/clang.c                      |   32 -
>  tools/perf/tests/llvm.c                       |  219 --
>  tools/perf/tests/llvm.h                       |   31 -
>  tools/perf/tests/make                         |    2 -
>  tools/perf/tests/tests.h                      |    2 -
>  tools/perf/trace/beauty/beauty.h              |   15 +-
>  tools/perf/util/Build                         |    8 +-
>  tools/perf/util/bpf-loader.c                  | 2006 -----------------
>  tools/perf/util/bpf-loader.h                  |  216 --
>  .../bpf_skel/augmented_raw_syscalls.bpf.c}    |   35 +-
>  tools/perf/util/c++/Build                     |    5 -
>  tools/perf/util/c++/clang-c.h                 |   43 -
>  tools/perf/util/c++/clang-test.cpp            |   67 -
>  tools/perf/util/c++/clang.cpp                 |  225 --
>  tools/perf/util/c++/clang.h                   |   27 -
>  tools/perf/util/config.c                      |    4 -
>  tools/perf/util/llvm-utils.c                  |  612 -----
>  tools/perf/util/llvm-utils.h                  |   69 -
>  tools/perf/util/parse-events.c                |  268 ---
>  tools/perf/util/parse-events.h                |   15 -
>  tools/perf/util/parse-events.l                |   31 -
>  tools/perf/util/parse-events.y                |   44 +-
>  41 files changed, 133 insertions(+), 5052 deletions(-)

awesome :)) 

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

>  delete mode 100644 tools/perf/examples/bpf/5sec.c
>  delete mode 100644 tools/perf/examples/bpf/empty.c
>  delete mode 100644 tools/perf/examples/bpf/hello.c
>  delete mode 100644 tools/perf/examples/bpf/sys_enter_openat.c
>  delete mode 100644 tools/perf/tests/.gitignore
>  delete mode 100644 tools/perf/tests/bpf-script-example.c
>  delete mode 100644 tools/perf/tests/bpf-script-test-kbuild.c
>  delete mode 100644 tools/perf/tests/bpf-script-test-prologue.c
>  delete mode 100644 tools/perf/tests/bpf-script-test-relocation.c
>  delete mode 100644 tools/perf/tests/bpf.c
>  delete mode 100644 tools/perf/tests/clang.c
>  delete mode 100644 tools/perf/tests/llvm.c
>  delete mode 100644 tools/perf/tests/llvm.h
>  delete mode 100644 tools/perf/util/bpf-loader.c
>  delete mode 100644 tools/perf/util/bpf-loader.h
>  rename tools/perf/{examples/bpf/augmented_raw_syscalls.c => util/bpf_skel/augmented_raw_syscalls.bpf.c} (93%)
>  delete mode 100644 tools/perf/util/c++/Build
>  delete mode 100644 tools/perf/util/c++/clang-c.h
>  delete mode 100644 tools/perf/util/c++/clang-test.cpp
>  delete mode 100644 tools/perf/util/c++/clang.cpp
>  delete mode 100644 tools/perf/util/c++/clang.h
>  delete mode 100644 tools/perf/util/llvm-utils.c
>  delete mode 100644 tools/perf/util/llvm-utils.h
> 
> -- 
> 2.41.0.640.ga95def55d0-goog
> 

