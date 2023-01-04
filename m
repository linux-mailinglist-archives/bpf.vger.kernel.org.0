Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB7965D581
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 15:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjADOWH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 09:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbjADOVz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 09:21:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C41FAA;
        Wed,  4 Jan 2023 06:21:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD971B81674;
        Wed,  4 Jan 2023 14:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CDAC433D2;
        Wed,  4 Jan 2023 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672842112;
        bh=S0pBAaBYAWYNmqrdaqt5KAjvTcU4XOUWLTxzTiYZlc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P7/+rbmx9zgpXDCY2DL8IiEBDNoJZQz8nHuPnLxP2v+Cr9Dbj8uxTnGewRb6SPMso
         KlyfTvck3sL5jLdaihFnx4EsmF5uAj7hOP2JoZ0MmxVlO/18ySgOT+goOPmJtIJq7j
         JGZ7O+SsY5Uqsz2ow1+FUmWnGGS5oo3bAwnQ6uS6duUsiCuR9TqKFbYCM2lIygqMoN
         B3I0JAfzNdnLvOkUtrSv3hPgA+JuTC7oUX+9kzm9lkqIi91EPaCBXV/MeTzka+qaPR
         KjDj8/i+A2U0FrPRQ8GwQeuzOhjnY76JP9MVzbE5EozR7RMofDm74uhC71MN9nw5G0
         /Ku+8JEuL228A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 71CA140468; Wed,  4 Jan 2023 11:21:50 -0300 (-03)
Date:   Wed, 4 Jan 2023 11:21:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH 0/4] perf bpf_counter: A set of random fixes (v1)
Message-ID: <Y7WLfqrR6NlMQPTs@kernel.org>
References: <20230104064402.1551516-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104064402.1551516-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jan 03, 2023 at 10:43:58PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> This is a collection of small fixes for perf stat bpf counters (bperf).
> 
> The bperf framework maintains perf_attr_map in the BPF fs to share the
> same event as much as possible.  But the size was limited to 16 and
> perf stat with -ddd option would create more than 16 events and fails.
> 
> Also cgroup events with --for-each-cgroup had some other problems when
> dealing with unsupported events and duplicate cgroups.
> 
> The code is available at 'perf/stat-bpf-fix-v1' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

The first two are improvements, not strict fixes, so I'm leaving them
for the next merge window.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> Namhyung Kim (4):
>   perf bpf_counter: Add more error messages for bperf
>   perf bpf_counter: Increase perf_attr_map entries to 32
>   perf bpf_counter: Handle unsupported cgroup events
>   perf stat: Do not use the same cgroup more than once
> 
>  tools/perf/util/bpf_counter.c        | 11 ++++++++---
>  tools/perf/util/bpf_counter_cgroup.c | 14 +++-----------
>  tools/perf/util/cgroup.c             | 23 ++++++++++++++++++-----
>  3 files changed, 29 insertions(+), 19 deletions(-)
> 
> 
> base-commit: d8d85ce86dc82de4f88b821a78f533b9d5b22a45
> -- 
> 2.39.0.314.g84b9a713c41-goog

-- 

- Arnaldo
