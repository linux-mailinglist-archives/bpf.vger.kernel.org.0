Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5DD65263B
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 19:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiLTS24 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 13:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiLTS2r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 13:28:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883941DDE3;
        Tue, 20 Dec 2022 10:28:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFCF7B818B1;
        Tue, 20 Dec 2022 18:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562FEC433D2;
        Tue, 20 Dec 2022 18:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671560922;
        bh=26BJsZF4v8uYU+L0SWB1rBznQrtMVFzrBO3rH/jfIS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D2sAAWG/LXFS34fdSRfw357w1UrXDJZSLS4z+ZYrJo6SksVGs4VPcrDjh41Mvutum
         DzVEnhqLHx6jcY9S5xr86JnmdAFvpU0YGtyLRjdGRUMpwSqmN9mSLH+2Quns37R99o
         4VFSXUs1SBVDZtWZaXc1RTuS1RwidB2SaffXiC9qY7PUozDejgvW49e1/QqTjRxHK9
         oooxQL/c29B0k1lV/WBjOEhuamumGIRN9ih5AJkNRP1SDHixz/mTLnRiQA8FziSrwG
         xk97wG0I6IjAdn0uJtU5Y6gPrD5H93v6QvfOUh7XoIVi3E0WZ8yPR4xSp9nu5J2eC2
         ogjV1vlgh1R8g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7ECDA40367; Tue, 20 Dec 2022 15:28:39 -0300 (-03)
Date:   Tue, 20 Dec 2022 15:28:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 0/6] perf lock contention: Add more filter options (v1)
Message-ID: <Y6H+11oOgpSpHuh/@kernel.org>
References: <20221219201732.460111-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219201732.460111-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Dec 19, 2022 at 12:17:26PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> This patchset adds a couple of filters to perf lock contention command.

Thanks, applied.

- Arnaldo

 
> The -Y/--type-filter is to filter by lock types like spinlock or mutex.
> 
>   $ sudo ./perf lock con -ab -Y spinlock -E 3 -- ./perf bench sched messaging
>   # Running 'sched/messaging' benchmark:
>   # 20 sender and receiver processes per group
>   # 10 groups == 400 processes run
> 
>        Total time: 0.167 [sec]
>    contended   total wait     max wait     avg wait         type   caller
> 
>           11    669.31 us    107.17 us     60.85 us     spinlock   remove_wait_queue+0x14
>           10    586.85 us     87.62 us     58.68 us     spinlock   prepare_to_wait+0x27
>          186    497.36 us     12.94 us      2.67 us     spinlock   try_to_wake_up+0x1f5
> 
> For the same workload, you can see the rwlock results only like below.
> 
>   $ sudo ./perf lock con -ab -Y rwlock -E 3 -- ./perf bench sched messaging
>   # Running 'sched/messaging' benchmark:
>   # 20 sender and receiver processes per group
>   # 10 groups == 400 processes run
> 
>        Total time: 0.171 [sec]
>    contended   total wait     max wait     avg wait         type   caller
> 
>           20    142.11 us     17.10 us      7.11 us     rwlock:W   do_exit+0x36d
>            3     26.49 us     12.04 us      8.83 us     rwlock:W   release_task+0x6e
>            5     12.46 us      5.12 us      2.49 us     rwlock:R   do_wait+0x8b
> 
> The -L/--lock-filter is to filter by lock address or name.  You can use
> the existing -l/--lock-addr option to get the info.
> 
>   $ sudo ./perf lock con -abl -- ./perf bench sched messaging 2>&1 | grep tasklist_lock
>           25     39.78 us     16.51 us      1.59 us   ffffffff9d006080   tasklist_lock
> 
> And use it with -L option like below.
> 
>   $ sudo ./perf lock con -ab -L tasklist_lock -- ./perf bench sched messaging 2>&1
>   # Running 'sched/messaging' benchmark:
>   # 20 sender and receiver processes per group
>   # 10 groups == 400 processes run
> 
>        Total time: 0.174 [sec]
>    contended   total wait     max wait     avg wait         type   caller
> 
>           22    227.18 us     24.16 us     10.33 us     rwlock:W   do_exit+0x36d
>            3     26.12 us     18.03 us      8.71 us     rwlock:W   release_task+0x6e
> 
> Passing the address is supported too.
> 
>   $ sudo ./perf lock con -ab -L ffffffff9d006080 -- ./perf bench sched messaging 2>&1
>   # Running 'sched/messaging' benchmark:
>   # 20 sender and receiver processes per group
>   # 10 groups == 400 processes run
> 
>        Total time: 0.190 [sec]
>    contended   total wait     max wait     avg wait         type   caller
> 
>           28    276.62 us     16.90 us      9.88 us     rwlock:W   do_exit+0x36d
>            4     22.36 us      7.04 us      5.59 us     rwlock:R   do_wait+0x8b
>            2     10.51 us      5.38 us      5.25 us     rwlock:W   release_task+0x6e
> 
> You can get it from 'perf/lock-filter-v1' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (6):
>   perf lock contention: Factor out lock_type_table
>   perf lock contention: Add -Y/--type-filter option
>   perf lock contention: Support lock type filtering for BPF
>   perf lock contention: Add -L/--lock-filter option
>   perf lock contention: Support lock addr/name filtering for BPF
>   perf test: Update perf lock contention test
> 
>  tools/perf/Documentation/perf-lock.txt        |  27 +-
>  tools/perf/builtin-lock.c                     | 305 ++++++++++++++++--
>  tools/perf/tests/shell/lock_contention.sh     |  58 +++-
>  tools/perf/util/bpf_lock_contention.c         |  55 +++-
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  38 ++-
>  tools/perf/util/lock-contention.h             |  10 +
>  6 files changed, 451 insertions(+), 42 deletions(-)
> 
> 
> base-commit: 51c4f2bf5397b34b79a6712221606e0ab2e6f7ed
> -- 
> 2.39.0.314.g84b9a713c41-goog

-- 

- Arnaldo
