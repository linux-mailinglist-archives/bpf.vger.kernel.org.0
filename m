Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ED55A27E9
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiHZMhI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244686AbiHZMhH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 08:37:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A00C3F5E;
        Fri, 26 Aug 2022 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661517426; x=1693053426;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=yTOtV6ciy/JdpsT5lvadz9gkIiCcMqq8uplUxtO4454=;
  b=KILrfgHXoKS0qsmIJnrVY7TYV3nRApZuXkThEWNLcT6L7j+zjeF7Ayw9
   xfhAdtzdqe1ttNopCmvXZT1y9gYIGCxph26z4aBmMWf1W4sibdeXmzyJQ
   8kQ9nhLWoPS0d5lDu8zyydBCim77gq27C6EQpnBV3kjagC28cndvKWrCb
   IDu7LBETEfJ9hEK2P/UYARl1nteDkmImDtMJ2iq4Xdb+Y70RbgWNfCS7J
   Jkdpa241VZYotjhEiHXOzATicIvFJxyJFD7dkxXvmMzxG7tMCn27a6PCZ
   zXGBWXS0XzciMr6FRSIy8FHcaAJk+IgNxQPL+iu3RGvN/gk1bmm481Qb6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="281465791"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="281465791"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:37:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="640040886"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.209])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:36:52 -0700
Message-ID: <fd249ce0-f065-e522-d6c7-72985367cc53@intel.com>
Date:   Fri, 26 Aug 2022 15:36:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 00/18] Mutex wrapper, locking and memory leak fixes
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, llvm@lists.linux.dev
References: <20220824153901.488576-1-irogers@google.com>
 <CA+JHD906M0truH7wPNZ=eJwdCA=qLhYDonUx_ZQBwJYpiX1hNg@mail.gmail.com>
 <c422c9b3-d6e2-e1d5-5273-6a720fdde6c4@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <c422c9b3-d6e2-e1d5-5273-6a720fdde6c4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25/08/22 19:14, Adrian Hunter wrote:
> On 25/08/22 15:30, Arnaldo Carvalho de Melo wrote:
>> On Wed, Aug 24, 2022, 12:39 PM Ian Rogers <irogers@google.com <mailto:irogers@google.com>> wrote:
>>
>>     When fixing a locking race and memory leak in:
>>     https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/ <https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/>
>>
>>     It was requested that debug mutex code be separated out into its own
>>     files. This was, in part, done by Pavithra Gurushankar in:
>>     https://lore.kernel.org/lkml/20220727111954.105118-1-gpavithrasha@gmail.com/ <https://lore.kernel.org/lkml/20220727111954.105118-1-gpavithrasha@gmail.com/>
>>
>>     These patches fix issues with the previous patches, add in the
>>     original dso->nsinfo fix and then build on our mutex wrapper with
>>     clang's -Wthread-safety analysis. The analysis found missing unlocks
>>     in builtin-sched.c which are fixed and -Wthread-safety is enabled by
>>     default when building with clang.
>>
>>     v3. Adds a missing new line to the error messages and removes the
>>         pshared argument to mutex_init by having two functions, mutex_init
>>         and mutex_init_pshared. These changes were suggested by Adrian Hunter.
>>
>>
>> Adrian, can I have your Acked-by or, better, Reviewed-by?
> 
> Sure, just let me have another look.  Should get to it
> tomorrow.

Looks good but a couple of things that need to be fixed up.

> 
>>
>> Thanks, 
>>
>> -  Arnaldo 
>>
>>     v2. Breaks apart changes that s/pthread_mutex/mutex/g and the lock
>>         annotations as requested by Arnaldo and Namhyung. A boolean is
>>         added to builtin-sched.c to terminate thread funcs rather than
>>         leaving them blocked on delted mutexes.
>>
>>     Ian Rogers (17):
>>       perf bench: Update use of pthread mutex/cond
>>       perf tests: Avoid pthread.h inclusion
>>       perf hist: Update use of pthread mutex
>>       perf bpf: Remove unused pthread.h include
>>       perf lock: Remove unused pthread.h include
>>       perf record: Update use of pthread mutex
>>       perf sched: Update use of pthread mutex
>>       perf ui: Update use of pthread mutex
>>       perf mmap: Remove unnecessary pthread.h include
>>       perf dso: Update use of pthread mutex
>>       perf annotate: Update use of pthread mutex
>>       perf top: Update use of pthread mutex
>>       perf dso: Hold lock when accessing nsinfo
>>       perf mutex: Add thread safety annotations
>>       perf sched: Fixes for thread safety analysis
>>       perf top: Fixes for thread safety analysis
>>       perf build: Enable -Wthread-safety with clang
>>
>>     Pavithra Gurushankar (1):
>>       perf mutex: Wrapped usage of mutex and cond
>>
>>      tools/perf/Makefile.config                 |   5 +
>>      tools/perf/bench/epoll-ctl.c               |  33 +++---
>>      tools/perf/bench/epoll-wait.c              |  33 +++---
>>      tools/perf/bench/futex-hash.c              |  33 +++---
>>      tools/perf/bench/futex-lock-pi.c           |  33 +++---
>>      tools/perf/bench/futex-requeue.c           |  33 +++---
>>      tools/perf/bench/futex-wake-parallel.c     |  33 +++---
>>      tools/perf/bench/futex-wake.c              |  33 +++---
>>      tools/perf/bench/numa.c                    |  93 ++++++----------
>>      tools/perf/builtin-inject.c                |   4 +
>>      tools/perf/builtin-lock.c                  |   1 -
>>      tools/perf/builtin-record.c                |  13 ++-
>>      tools/perf/builtin-sched.c                 | 105 +++++++++---------
>>      tools/perf/builtin-top.c                   |  45 ++++----
>>      tools/perf/tests/mmap-basic.c              |   2 -
>>      tools/perf/tests/openat-syscall-all-cpus.c |   2 +-
>>      tools/perf/tests/perf-record.c             |   2 -
>>      tools/perf/ui/browser.c                    |  20 ++--
>>      tools/perf/ui/browsers/annotate.c          |  12 +--
>>      tools/perf/ui/setup.c                      |   5 +-
>>      tools/perf/ui/tui/helpline.c               |   5 +-
>>      tools/perf/ui/tui/progress.c               |   8 +-
>>      tools/perf/ui/tui/setup.c                  |   8 +-
>>      tools/perf/ui/tui/util.c                   |  18 ++--
>>      tools/perf/ui/ui.h                         |   4 +-
>>      tools/perf/util/Build                      |   1 +
>>      tools/perf/util/annotate.c                 |  15 +--
>>      tools/perf/util/annotate.h                 |   4 +-
>>      tools/perf/util/bpf-event.h                |   1 -
>>      tools/perf/util/build-id.c                 |  12 ++-
>>      tools/perf/util/dso.c                      |  19 ++--
>>      tools/perf/util/dso.h                      |   4 +-
>>      tools/perf/util/hist.c                     |   6 +-
>>      tools/perf/util/hist.h                     |   4 +-
>>      tools/perf/util/map.c                      |   3 +
>>      tools/perf/util/mmap.h                     |   1 -
>>      tools/perf/util/mutex.c                    | 119 +++++++++++++++++++++
>>      tools/perf/util/mutex.h                    | 109 +++++++++++++++++++
>>      tools/perf/util/probe-event.c              |   3 +
>>      tools/perf/util/symbol.c                   |   4 +-
>>      tools/perf/util/top.h                      |   5 +-
>>      41 files changed, 570 insertions(+), 323 deletions(-)
>>      create mode 100644 tools/perf/util/mutex.c
>>      create mode 100644 tools/perf/util/mutex.h
>>
>>     -- 
>>     2.37.2.609.g9ff673ca1a-goog
>>
> 

