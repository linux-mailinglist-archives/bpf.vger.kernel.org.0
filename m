Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49E6DA6A7
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 02:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbjDGAlh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 20:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbjDGAld (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 20:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE8A900C;
        Thu,  6 Apr 2023 17:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50C4B64D59;
        Fri,  7 Apr 2023 00:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23661C433D2;
        Fri,  7 Apr 2023 00:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680828091;
        bh=dq1IXvUBgolzsWbmedD4jqlqlJxPuw/36N/42c6gXb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebAD5c2r2xNtrHJKTAz6giOOapMGWH570NZEwkbzaLvZNtg1UGLsFsS9Sbp91QWKp
         r3Sit8VYkSIWtAJQ2fxJtA5smw/859eOb4k1I+RcyX1AHplcd88VAHJCO5DNWXJQ2T
         zJ/tIA9PH84EX/7NbH+TQs2BWLR7b2qoYOWZJq3QlfiaudSw/BcDFontyagR2icReJ
         dlcIaEgFfSChPpC8m7trUYzkLhgGLXdsBlasYLuM1RnwgBjMtyRNj/EV9x11U1psKP
         zMIuewcats7ySqwQvDjOAUh11nOvosi6Sa6uZ0gUZPK5aYxpnCQ/vyUJqHcWUZ7KBF
         ot1Bc0C9nzYbg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9B2B14052D; Thu,  6 Apr 2023 21:41:28 -0300 (-03)
Date:   Thu, 6 Apr 2023 21:41:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCHSET 0/7] perf lock contention: Improve performance if map
 is full (v1)
Message-ID: <ZC9muCsvRwV3ImhI@kernel.org>
References: <20230406210611.1622492-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406210611.1622492-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Apr 06, 2023 at 02:06:04PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> I got a report that the overhead of perf lock contention is too big in
> some cases.  It was running the task aggregation mode (-t) at the moment
> and there were lots of tasks contending each other.
> 
> It turned out that the hash map update is a problem.  The result is saved
> in the lock_stat hash map which is pre-allocated.  The BPF program never
> deletes data in the map, but just adds.  But if the map is full, (try to)
> update the map becomes a very heavy operation - since it needs to check
> every CPU's freelist to get a new node to save the result.  But we know
> it'd fail when the map is full.  No need to update then.

Thanks, applied.

- Arnaldo

 
> I've checked it on my 64 CPU machine with this.
> 
>     $ perf bench sched messaging -g 1000
>     # Running 'sched/messaging' benchmark:
>     # 20 sender and receiver processes per group
>     # 1000 groups == 40000 processes run
> 
>          Total time: 2.825 [sec]
> 
> And I used the task mode, so that it can guarantee the map is full.
> The default map entry size is 16K and this workload has 40K tasks.
> 
> Before:
>     $ sudo ./perf lock con -abt -E3 -- perf bench sched messaging -g 1000
>     # Running 'sched/messaging' benchmark:
>     # 20 sender and receiver processes per group
>     # 1000 groups == 40000 processes run
> 
>          Total time: 11.299 [sec]
>      contended   total wait     max wait     avg wait          pid   comm
> 
>          19284      3.51 s       3.70 ms    181.91 us      1305863   sched-messaging
>            243     84.09 ms    466.67 us    346.04 us      1336608   sched-messaging
>            177     66.35 ms     12.08 ms    374.88 us      1220416   node
> 
> After:
>     $ sudo ./perf lock con -abt -E3 -- perf bench sched messaging -g 1000
>     # Running 'sched/messaging' benchmark:
>     # 20 sender and receiver processes per group
>     # 1000 groups == 40000 processes run
> 
>          Total time: 3.044 [sec]
>      contended   total wait     max wait     avg wait          pid   comm
> 
>          18743    591.92 ms    442.96 us     31.58 us      1431454   sched-messaging
>             51    210.64 ms    207.45 ms      4.13 ms      1468724   sched-messaging
>             81     68.61 ms     65.79 ms    847.07 us      1463183   sched-messaging
> 
>     === output for debug ===
> 
>     bad: 1164137, total: 2253341
>     bad rate: 51.66 %
>     histogram of failure reasons
>            task: 0
>           stack: 0
>            time: 0
>            data: 1164137
> 
> The first few patches are small cleanups and fixes.  You can get the code
> from 'perf/lock-map-v1' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> Namhyung Kim (7):
>   perf lock contention: Simplify parse_lock_type()
>   perf lock contention: Use -M for --map-nr-entries
>   perf lock contention: Update default map size to 16384
>   perf lock contention: Add data failure stat
>   perf lock contention: Update total/bad stats for hidden entries
>   perf lock contention: Revise needs_callstack() condition
>   perf lock contention: Do not try to update if hash map is full
> 
>  tools/perf/Documentation/perf-lock.txt        |  4 +-
>  tools/perf/builtin-lock.c                     | 64 ++++++++-----------
>  tools/perf/util/bpf_lock_contention.c         |  7 +-
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 29 +++++++--
>  tools/perf/util/bpf_skel/lock_data.h          |  3 +
>  tools/perf/util/lock-contention.h             |  2 +
>  6 files changed, 60 insertions(+), 49 deletions(-)
> 
> 
> base-commit: e5116f46d44b72ede59a6923829f68a8b8f84e76
> -- 
> 2.40.0.577.gac1e443424-goog
> 

-- 

- Arnaldo
