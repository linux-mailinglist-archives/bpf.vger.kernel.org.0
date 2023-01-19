Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9F673E37
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 17:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjASQHS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 11:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjASQGl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 11:06:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7C48B308
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 08:05:52 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso3255801wmb.0
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 08:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEPCCxgC2jIqLmrj6LCd/iIxx6TnZmFs2qjrZ+6y0oo=;
        b=Ac/6/7fL76qxP6u1WQ578Bv4Npib5IfJp4T4ol/ksnH0LogMRiWoppP9E6t40NyTym
         i3L1YTc3IyzeXKZGpESXTUGlNOnSA8DTQ0wbQe0gQREqfQIkQsWDYKi1qc0lLRPccCev
         RIU4qDHcdm57g/WvA1aeoVgg//odWNKaPng+BDr28em4hP87f/L50446v3LIfZyDpebu
         uGxyVy7nE9uDbGXCasM4eRY/qWrLfDsrGODxsBZ/i6OHKfshyBgAlP5dqPtweW1ee8vh
         czBzVZEEAlzeTm5Es6+sROZ+qGw4aB4zqx+nyDSGEiYD0GCBVJKQtz/MqN5mQqT4nQfA
         yI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEPCCxgC2jIqLmrj6LCd/iIxx6TnZmFs2qjrZ+6y0oo=;
        b=PGgYRhywgkmxFWzeJWtfmTauAiuKf9wSbij7idkpZUJDCrMJ/X3780CqdaQSDTcdVd
         HAGw1vrW3RbSexRwg5p5Wwbh2mCOqqXWBO/p9na7M6DfMdFRmGWSvpd+VqALJE4Bx46e
         6lUzMh1YHbLfrbnSEAC9uxr4VPxniGtfeP0AioKhm9jRi23bjNvmrvBH60Meeavs98T2
         slUeIDzxIVQIVxVZz2rAVQPf6+Ro+j1M5HRd3NgUzi+MDnF8YqHY1rLLoyaXDvqf2cfk
         OD5cTAJ4StXkJzXXgH3VoXwpzyv0ImooEIYmTDYE/z5UAl7sif9LDvNFaYFds0Ft0d96
         SS1g==
X-Gm-Message-State: AFqh2kqSuZ2mN1F1a87oCHtsP9g4XRUlSxLef8OjaJlEf34VUwEJ/JQ8
        hFlXw8aGsWjvfY1G57ySQ30bPoVj7nSQcy4JPR9wTA==
X-Google-Smtp-Source: AMrXdXuKMugc8ghD6oWYIUPtih5kZPO6XNBt8xi+u8WnKa3PknXBFlXKXZvieWIrLCheeKAEh9/R7TPQRuHGbRnzew0=
X-Received: by 2002:a1c:7404:0:b0:3da:b40f:c734 with SMTP id
 p4-20020a1c7404000000b003dab40fc734mr954622wmc.115.1674144347902; Thu, 19 Jan
 2023 08:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20230110222003.1591436-1-irogers@google.com>
In-Reply-To: <20230110222003.1591436-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 Jan 2023 08:05:36 -0800
Message-ID: <CAP-5=fVQg4z-pd-ovjSPkxJ1p0fhQ4MuhWCqjN1ha52q44N6Rg@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Add and use run_command_strbuf
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Qi Liu <liuqi115@huawei.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Xin Gao <gaoxin@cdjrlc.com>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stephane Eranian <eranian@google.com>,
        German Gomez <german.gomez@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 10, 2023 at 2:20 PM Ian Rogers <irogers@google.com> wrote:
>
> It is commonly useful to run a command using "/bin/sh -c" (like popen)
> and to place the output in a string. Move strbuf to libapi, add a new
> run_command that places output in a strbuf, then use it in help and
> llvm in perf. Some small strbuf efficiency improvements are
> included. Whilst adding a new function should increase lines-of-code,
> by sharing two similar usages in perf llvm and perf help, the overall
> lines-of-code is moderately reduced.
>
> First "perf llvm: Fix inadvertent file creation" is cherry-picked
> from:
> https://lore.kernel.org/lkml/20230105082609.344538-1-irogers@google.com/
> to avoid a merge conflict. The next patches deal with moving strbuf,
> adding the run_command function with Makefile dependency from
> libsubcmd to libapi, and improving the strbuf performance. The final
> two patches add usage from the perf command.
>
> Ian Rogers (7):
>   perf llvm: Fix inadvertent file creation
>   tools lib: Move strbuf to libapi
>   tools lib subcmd: Add run_command_strbuf
>   tools lib api: Minor strbuf_read improvements
>   tools lib api: Tweak strbuf allocation size computation
>   perf help: Use run_command_strbuf
>   perf llvm: Remove read_from_pipe

This isn't ready yet. Kernel test robot reported legitimate build
breakages in other tools outside of perf, I'm looking to address those
in separate patch series.
https://lore.kernel.org/lkml/20230116215751.633675-1-irogers@google.com/

Thanks,
Ian

>  tools/lib/api/Build                   |   1 +
>  tools/lib/api/Makefile                |   2 +-
>  tools/{perf/util => lib/api}/strbuf.c |  28 ++--
>  tools/{perf/util => lib/api}/strbuf.h |   0
>  tools/lib/subcmd/Makefile             |  32 +++-
>  tools/lib/subcmd/run-command.c        |  30 ++++
>  tools/lib/subcmd/run-command.h        |  14 ++
>  tools/perf/bench/evlist-open-close.c  |   2 +-
>  tools/perf/builtin-help.c             |  49 ++----
>  tools/perf/builtin-list.c             |   2 +-
>  tools/perf/tests/bpf.c                |  12 +-
>  tools/perf/tests/llvm.c               |  18 +--
>  tools/perf/tests/llvm.h               |   3 +-
>  tools/perf/util/Build                 |   1 -
>  tools/perf/util/bpf-loader.c          |   9 +-
>  tools/perf/util/cache.h               |   2 +-
>  tools/perf/util/dwarf-aux.c           |   2 +-
>  tools/perf/util/env.c                 |   2 +-
>  tools/perf/util/header.c              |   2 +-
>  tools/perf/util/llvm-utils.c          | 207 ++++++++------------------
>  tools/perf/util/llvm-utils.h          |   6 +-
>  tools/perf/util/metricgroup.c         |   2 +-
>  tools/perf/util/pfm.c                 |   2 +-
>  tools/perf/util/pmu.c                 |   2 +-
>  tools/perf/util/probe-event.c         |   2 +-
>  tools/perf/util/probe-file.c          |   2 +-
>  tools/perf/util/probe-finder.c        |   2 +-
>  tools/perf/util/sort.c                |   2 +-
>  28 files changed, 201 insertions(+), 237 deletions(-)
>  rename tools/{perf/util => lib/api}/strbuf.c (87%)
>  rename tools/{perf/util => lib/api}/strbuf.h (100%)
>
> --
> 2.39.0.314.g84b9a713c41-goog
>
