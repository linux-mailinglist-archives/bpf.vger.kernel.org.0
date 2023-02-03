Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6AA68A36B
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 21:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjBCUMx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 15:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjBCUMw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 15:12:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CC0A8425;
        Fri,  3 Feb 2023 12:12:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2B1861FE5;
        Fri,  3 Feb 2023 20:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2449C433EF;
        Fri,  3 Feb 2023 20:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675455170;
        bh=4cYcCPYkEMmGYnotndJDbonkHWa1OTh1uLq8K0ufV2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IuDt1yfjPrp0UzZ5DrOE7Of/AGHeP9WkPgZcg7g/VdrTgDi0ySUyNyj01FmBvwwao
         3ufGKChTDu8YBAfotgIuUi4e4CZ0NL9IvmQfO/4DRYiMIUcLjKj3492exZLPpX9g6n
         sT4s6hAfzI+1IagNAj3Ddslh/DRxnNUNvVEYWNOINhe/w1l7I+tTHUSqJWdK4MDn7r
         lS4ycYtkcaeD17quUFXktJTl46YPd+quUJcXpCub3lsJbP2Be7qGW6WI2lUzZxZlBn
         G4l76Wu/1qu5OBKYEbZVpL3fxZqDY2CFJU3qnLDd8d2tM50muuxFXZm5fPDpyb8UHd
         fJMzauCI5lnng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5161F405BE; Fri,  3 Feb 2023 17:12:47 -0300 (-03)
Date:   Fri, 3 Feb 2023 17:12:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        irogers@google.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        song@kernel.org, haoluo@google.com, bpf@vger.kernel.org,
        juri.lelli@redhat.com
Subject: Re: [PATCH v2 0/3] perf lock contention: Improve aggr x filter
 combination
Message-ID: <Y91qvwSIs2tc2JAk@kernel.org>
References: <20230203021324.143540-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203021324.143540-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Feb 02, 2023 at 06:13:21PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> The callstack filter can be useful to debug lock issues but it has a
> limitation that it only works with caller aggregation mode (which is the
> default setting).  IOW it cannot filter by callstack when showing tasks
> or lock addresses/names.

Thanks, applied.

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
> Namhyung Kim (3):
>   perf lock contention: Factor out lock_contention_get_name()
>   perf lock contention: Use lock_stat_find{,new}
>   perf lock contention: Support filters for different aggregation
> 
>  tools/perf/builtin-lock.c                     |  79 ++++----
>  tools/perf/util/Build                         |   5 +-
>  tools/perf/util/bpf_lock_contention.c         | 180 +++++++++++-------
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  15 +-
>  tools/perf/util/bpf_skel/lock_data.h          |   4 +-
>  tools/perf/util/lock-contention.h             |   5 +
>  6 files changed, 178 insertions(+), 110 deletions(-)
> 
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 

-- 

- Arnaldo
