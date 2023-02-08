Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F74B68EFF0
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 14:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjBHNht (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 08:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjBHNhs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 08:37:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D1128D30;
        Wed,  8 Feb 2023 05:37:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA7AA616C5;
        Wed,  8 Feb 2023 13:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A83C433D2;
        Wed,  8 Feb 2023 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675863465;
        bh=C18+lmDmHUQw89PNSRvF2CAYrWYkC0qccun9EmBW3H0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQ8J+eol+yyMXrd4AH9hAcIAZjS6oMI2ukumpGqI19C6GhHc3el6NqpumcupON9OT
         +L3hz6Cm3GSCwJ2ch8lwtRmPJ/1pLztJkkiMwj1op3bazsPDNMmVBvloIVe4t4Lb4N
         Q897aDQpW0a7IWfQKgVxei5oCjg3ncT/4C9C/UPEuNGgxcowS0MLo0VAVpnsNiEN21
         AtattiXwtVfk+1IYaUX1mfB+PfQ6D3e89FV757m4DkKc1S69kq6/AKWD4HPxCynSU9
         6furEgwbgX3b6CmZj5LY7vXg8nG4RF1u9DAkZsxg9H0aK6MTSkLUxSF0TVFs9QS6r3
         pnimBmJimBbZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7C87F405BE; Wed,  8 Feb 2023 10:37:42 -0300 (-03)
Date:   Wed, 8 Feb 2023 10:37:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org
Subject: Re: [RFC/PATCH 0/3] perf lock contention: Track lock owner (v2)
Message-ID: <Y+OlploNJlan/Gkm@kernel.org>
References: <20230207002403.63590-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207002403.63590-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 06, 2023 at 04:24:00PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> When there're many lock contentions in the system, people sometimes
> want to know who caused the contention, IOW who's the owner of the
> locks.
> 
> This patchset adds -o/--lock-owner option to track the owner info
> if it's available.  Right now, it supports mutex and rwsem as they
> have the owner fields in themselves.  Please see the patch 2 for the
> details.
> 
> Changes in v2)
>  * fix missing callstacks
>  * support old rwsem type with recent clang (>= 15.0)
> 
> The patch 1 is a fix for missing callstacks and the patch 2 is the
> main change.  The patch 3 adds support for old kernels when compiler
> supports a recent builtin to check field type in a struct (Thanks
> to Hao).
> 
> Example output (for mutex only):
> 
>   $ sudo ./perf lock con -abo -Y mutex -- ./perf bench sched pipe
>   # Running 'sched/pipe' benchmark:
>   # Executed 1000000 pipe operations between two processes
> 
>        Total time: 4.910 [sec]
> 
>          4.910435 usecs/op
>            203647 ops/sec
>    contended   total wait     max wait     avg wait          pid   owner
> 
>            2     15.50 us      8.29 us      7.75 us      1582852   sched-pipe
>            7      7.20 us      2.47 us      1.03 us           -1   Unknown
>            1      6.74 us      6.74 us      6.74 us      1582851   sched-pipe
> 
> You can get it from 'perf/lock-owner-v2' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> Namhyung Kim (3):
>   perf lock contention: Fix to save callstack for the default modified
>   perf lock contention: Add -o/--lock-owner option
>   perf lock contention: Support old rw_semaphore type
> 
>  tools/perf/Documentation/perf-lock.txt        |  5 +
>  tools/perf/builtin-lock.c                     | 52 +++++++++--
>  tools/perf/util/bpf_lock_contention.c         |  1 +
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 91 ++++++++++++++++++-
>  tools/perf/util/lock-contention.h             |  1 +
>  5 files changed, 136 insertions(+), 14 deletions(-)
> 
> 
> base-commit: 17f248aa8664ff5b3643491136283e73b5c18166
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 

-- 

- Arnaldo
