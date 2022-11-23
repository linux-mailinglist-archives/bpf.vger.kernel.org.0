Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C75636095
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 14:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbiKWNzr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 08:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiKWNz2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 08:55:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A77721D;
        Wed, 23 Nov 2022 05:49:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06C6BB81FFA;
        Wed, 23 Nov 2022 13:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1A3C433D7;
        Wed, 23 Nov 2022 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669211396;
        bh=tOKgVpDb4YGEFJ3vnIjCVjTP0R5hACprgjJE1++ks5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JdrwUSVjuZIOmtlcCA9eWQ8bGMGKmJ2H4NWLVqLwjbAeh7G1wTGKaZ+nUkHeT+YEP
         VWY36FquxoghtFAlf9Vu0gunxbiPiqfLCWumwDRyaQw1I0Km0o61koKlLyVsxHVu/C
         2fRzcSt6wrKssbPtUlR6llOIF30W6JF4jNRPnK/c3nTK52Bh2IP/5sUpJ60aOSGocL
         2eXWf5a5lgJcMMw9gibzI8DokDn5RiGsCYU8YAf2Cw3p1CktQRf2sOmRsAgg0ytOKp
         PnP8rPvmr5ZGBa8QgYcmAye48D+FhT/x9yDkSTcsBdUfwPm67Twnl7FLuDgJgyENQk
         wmuRvK0dlAy9g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 15D4E4034E; Wed, 23 Nov 2022 10:49:54 -0300 (-03)
Date:   Wed, 23 Nov 2022 10:49:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org, Blake Jones <blakejones@google.com>,
        Chris Li <chriscli@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf lock contention: Do not use BPF task local storage
Message-ID: <Y34lAgJzG1DvUFXw@kernel.org>
References: <20221118190109.1512674-1-namhyung@kernel.org>
 <dea8c3c5-0739-58c1-9a88-b989878a9b8f@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea8c3c5-0739-58c1-9a88-b989878a9b8f@linux.dev>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Nov 21, 2022 at 09:32:56AM -0800, Martin KaFai Lau escreveu:
> On 11/18/22 11:01 AM, Namhyung Kim wrote:
> > It caused some troubles when a lock inside kmalloc is contended
> > because task local storage would allocate memory using kmalloc.
> > It'd create a recusion and even crash in my system.
> > 
> > There could be a couple of workarounds but I think the simplest
> > one is to use a pre-allocated hash map.
> 
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Thanks, applied.

- Arnaldo

 
> > We could fix the task local storage to use the safe BPF allocator,
> > but it takes time so let's change this until it happens actually.
> 
> I also got another report on the kfree_rcu path.  I am also looking into
> this direction on using the BPF allocator.

-- 

- Arnaldo
