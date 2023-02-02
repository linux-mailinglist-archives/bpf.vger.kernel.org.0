Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C702687DF6
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 13:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjBBMzF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 07:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjBBMyy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 07:54:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F192E7E06E;
        Thu,  2 Feb 2023 04:54:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9551DB82642;
        Thu,  2 Feb 2023 12:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243F9C433D2;
        Thu,  2 Feb 2023 12:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675342485;
        bh=+EPHg08aCa9UZ2s6YJYAW2ESddgw2LFkCJGtMrotMJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6ZNiAP/YYxarTe8TF3fVFdYwQGxhD/+w1KC/3dRRH3gSxYgLPjMkkbEYxZuHKVfW
         Bv7FUzkdL1VmNjxPpAUugklPhaPCz6tafQng1BAne3khq6oqv6T4se2K2oU6Bdf2ZS
         VOJhoCuFPFlBz4Q7gb6Lj0uZMfFhj2iJrokjprGTrNOQodSZWpz/Sy3/N9bOkj+nU/
         b86G+PJWi+UWf/l/KI/WF+QrVGPC9lXn4VvySSrz21exBIT2LBLGxWu0oRnhV/I7ka
         79XbCZsN/en6bVu4DMg7I8O3CaXm9pdhwc0I3pdcpHoMzJ5auhxX9QPVSarA+rmzfm
         WCSS6Y4j9ut3w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C08FE405BE; Thu,  2 Feb 2023 09:54:42 -0300 (-03)
Date:   Thu, 2 Feb 2023 09:54:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 0/4] perf lock contention: Improve aggr x filter
 combination (v1)
Message-ID: <Y9uykljo89Ub5ogb@kernel.org>
References: <20230202050455.2187592-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202050455.2187592-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 01, 2023 at 09:04:51PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> The callstack filter can be useful to debug lock issues but it has a
> limitation that it only works with caller aggregation mode (which is the
> default setting).  IOW it cannot filter by callstack when showing tasks
> or lock addresses/names.

Thanks, applied, the only nit was for a preexisting problem I only
caught now in a refactoring, please consider fixing those.

- Arnaldo
 
> But sometimes users want to use the filter for other aggregation mode.
> Like "show me lock addresses/names from this caller only" or "show me
> tasks having these callers".
> 
> When it's using tracepoint events from the data file, the situation is
> good since the tracepoints have all the necessary info.  But when using
> BPF it needs to extend the key of lock stat BPF map to have more than
> one info like 'pid + stack_id' or 'lock_addr + stack_id'.  As callstack
> filter works in userspace, it should save the both info.
> 
> With this change we can now use the -S/--callstack-filter with the
> -t/--threads option or -l/--lock-addr option.  It's also possible to use
> it with other filter options.
> 
> The following example shows the top 5 tasks that have contention
> somewhere in the epoll handling.
> 
>   $ sudo perf lock con -abt -S epoll -E5 -- sleep 1
>    contended   total wait     max wait     avg wait          pid   comm
> 
>            2     58.64 us     32.38 us     29.32 us      1514752   Chrome_IOThread
>            3     29.31 us     12.65 us      9.77 us         3773   Xorg
>            1     17.45 us     17.45 us     17.45 us      1514906   Chrome_ChildIOT
>            1     15.41 us     15.41 us     15.41 us      1515382   Chrome_ChildIOT
>            1     12.52 us     12.52 us     12.52 us       293878   IPC I/O Parent
> 
> You get get the code at 'perf/lock-filter-v1' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> Namhyung Kim (4):
>   perf lock contention: Factor out lock_contention_get_name()
>   perf lock contention: Use lock_stat_find{,new}
>   perf lock contention: Support filters for different aggregation
>   perf test: Add more test cases for perf lock contention
> 
>  tools/perf/builtin-lock.c                     |  79 ++++----
>  tools/perf/tests/shell/lock_contention.sh     |  66 ++++++-
>  tools/perf/util/bpf_lock_contention.c         | 178 +++++++++++-------
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  15 +-
>  tools/perf/util/bpf_skel/lock_data.h          |   4 +-
>  tools/perf/util/lock-contention.h             |   5 +
>  6 files changed, 234 insertions(+), 113 deletions(-)
> 
> 
> base-commit: 7cfa9f5e440054db7c7e28e83a045d36993ff958
> -- 
> 2.39.1.456.gfc5497dd1b-goog
> 

-- 

- Arnaldo
