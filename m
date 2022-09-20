Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5E95BEE0B
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 21:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiITTxq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 15:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiITTxo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 15:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B6174356;
        Tue, 20 Sep 2022 12:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB3DD621DD;
        Tue, 20 Sep 2022 19:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0733AC433C1;
        Tue, 20 Sep 2022 19:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663703621;
        bh=K5D/cvhmWjxK0VnS1qCjWGXgGazK2EgtutCIcApbmxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rL7fTkTZDNCKo7hSdqwlfp2xVwaPupoyqnSYzapd1FdPVNpHAOeBHfwi7H9imZ+iF
         jEcaMnFOHPb6YerGWT/8ZhVGkvYZVMs/v1dhfvrMxjaPiRl65hu+Vetz3FRU+E1Kad
         nvfbsvh6WgWnFy17kzYUDdQnvkHUpXel9orrYQbQFCJGL1mhpHEtxXDGTbFyBSjCC5
         ZdGZ6IMb1rnFAzk32dlJwk98MNljLyhjVJ4SRRJyWqEAwmcZGMxEh6NAolktF6Ef7b
         pq3QHa3WHiiCYLyp+8N9z9ufUWIeJeWfSzgxBiOWAC2jgW6br71Li4KbyyBKaC0wTQ
         vX6G1lwpUd0LQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB03540856; Tue, 20 Sep 2022 20:53:37 +0100 (IST)
Date:   Tue, 20 Sep 2022 20:53:37 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH 0/4] perf stat: Fix bperf cgroup counters (v2)
Message-ID: <YyoaQZIrAO+1HgD5@kernel.org>
References: <20220916184132.1161506-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916184132.1161506-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Sep 16, 2022 at 11:41:28AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> This fixes random failures in the perf stat cgroup BPF counters (bperf).
> I've also added a new test to ensure it working properly.
> 
> v2 changes)
>  * fix a segfault with uncore event

Thanks, applied.

- Arnaldo

 
> You can get it from 'perf/bperf-cgrp-fix-v2' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf stat: Fix BPF program section name
>   perf stat: Fix cpu map index in bperf cgroup code
>   perf stat: Use evsel->core.cpus to iterate cpus in BPF cgroup counters
>   perf test: Add a new test for perf stat cgroup BPF counter
> 
>  .../tests/shell/stat_bpf_counters_cgrp.sh     | 83 +++++++++++++++++++
>  tools/perf/util/bpf_counter_cgroup.c          | 10 +--
>  tools/perf/util/bpf_skel/bperf_cgroup.bpf.c   |  2 +-
>  3 files changed, 89 insertions(+), 6 deletions(-)
>  create mode 100755 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
> 
> 
> base-commit: 62e64c9d2fd12839c02f1b3e8b873e7cb34e8720
> -- 
> 2.37.3.968.ga6b4b080e4-goog

-- 

- Arnaldo
