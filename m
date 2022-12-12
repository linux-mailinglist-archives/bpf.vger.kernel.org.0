Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797DF64A84F
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 20:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiLLT6X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 14:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbiLLT6W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 14:58:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF14917431;
        Mon, 12 Dec 2022 11:58:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51F01B80DE1;
        Mon, 12 Dec 2022 19:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0F4C433D2;
        Mon, 12 Dec 2022 19:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670875098;
        bh=W06ornDnIgqPamggnn9sksOrET7i2brFvmdhKlkOwXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdVihdn6NUPo8d5PmHzGHv3RaQ5Z5WZbZ6GwcsRHxY1FjMXjLqETx/eiP3KDqOPHD
         qU705Pzncmk13DkW/jeJQc1YaGciwNkXz3fnsoVhli9crX1gEd5EYcOCmf8hH4BcFX
         Tuz21QhIxiORfBL9rL5a/sel8QznwA3PCSoxuiZgZh7x0MmHNMrZqhgQmq3xwWoGgQ
         TGqcaKhdtLr1b2PXy3Ibe0cqUOc/gaatFy85LI+ymT+3D6vh28XxIP28JKmsXHEqK5
         aR8LgvAqADKu4cIq/VRnDxjnyyn7oJFgImvnIjx2JtoIwN0cJWJBb3ncTPgdgxof07
         Z7ddzqmJZIcYA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DA32C40483; Mon, 12 Dec 2022 16:58:14 -0300 (-03)
Date:   Mon, 12 Dec 2022 16:58:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 0/4] perf lock contention: Support task/addr aggregation
 mode (v1)
Message-ID: <Y5eH1o/NXz4oxTpQ@kernel.org>
References: <20221209190727.759804-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209190727.759804-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Dec 09, 2022 at 11:07:23AM -0800, Namhyung Kim escreveu:
> Hello,
> 
> This patchset adds two more aggregation modes for perf lock contention.


Thanks, applied.

- Arnaldo

 
> The first one is the per-task mode with -t/--threads option.  The option
> was there already but it remained broken with BPF for a while.  Now it
> supports the output with and without BPF.
> 
>   # perf lock contention -a -b -t -- sleep 1
>    contended   total wait     max wait     avg wait          pid   comm
> 
>           11     11.85 us      2.23 us      1.08 us            0   swapper
>            2     11.13 us     10.22 us      5.56 us       749053   ThreadPoolForeg
>            1      8.15 us      8.15 us      8.15 us       321353   Chrome_ChildIOT
>            2      2.73 us      1.77 us      1.37 us       320761   Chrome_ChildIOT
>            1      1.40 us      1.40 us      1.40 us       320502   chrome
>            1       379 ns       379 ns       379 ns       321227   chrome
> 
> The other one is the per-lock-instance mode with -l/--lock-addr option.
> If the lock has a symbol, it will be displayed as well.
> 
>   # perf lock contention -a -b -l -- sleep 1
>    contended   total wait     max wait     avg wait            address   symbol
> 
>            3      4.79 us      2.33 us      1.60 us   ffffffffbaed50c0   rcu_state
>            4      4.19 us      1.62 us      1.05 us   ffffffffbae07a40   jiffies_lock
>            1      1.94 us      1.94 us      1.94 us   ffff9262277861e0
>            1       387 ns       387 ns       387 ns   ffff9260bfda4f60
> 
> It's based on the current acme/tmp.perf/core branch.
> You can find the code in the 'perf/lock-con-aggr-v1' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf lock contention: Add lock_data.h for common data
>   perf lock contention: Implement -t/--threads option for BPF
>   perf lock contention: Add -l/--lock-addr option
>   perf test: Update perf lock contention test
> 
>  tools/perf/Documentation/perf-lock.txt        |  4 +
>  tools/perf/builtin-lock.c                     | 95 ++++++++++++++-----
>  tools/perf/tests/shell/lock_contention.sh     | 48 ++++++++++
>  tools/perf/util/bpf_lock_contention.c         | 72 ++++++++++----
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 67 +++++++++----
>  tools/perf/util/bpf_skel/lock_data.h          | 30 ++++++
>  tools/perf/util/lock-contention.h             |  1 +
>  7 files changed, 255 insertions(+), 62 deletions(-)
>  create mode 100644 tools/perf/util/bpf_skel/lock_data.h
> 
> 
> base-commit: b22802e295a80ec16e355d7208d2fbbd7bbc1b7a
> -- 
> 2.39.0.rc1.256.g54fd8350bd-goog

-- 

- Arnaldo
