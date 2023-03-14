Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDDD6B91D3
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 12:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjCNLjg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 07:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCNLjb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 07:39:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758E781CEF;
        Tue, 14 Mar 2023 04:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2196EB818EC;
        Tue, 14 Mar 2023 11:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80644C433D2;
        Tue, 14 Mar 2023 11:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678793960;
        bh=luG+2uJ/rehWgapl11w1aqOj1LPV0nhCPrhmlVJlaqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXkhavefrxy8Kkr7ZC+k6gzAHH84WV/h2I+deeprYe0k16vqGvv5xft4yt7rNJJdl
         0U9VbhTajNezp9sFOLexQKEMNHBNeCYysIfTMbnp8r88BIML6u+qtzieRi0nGielAo
         2uPJzTAYkDKJ5CkEvSkfPJ1sstgzvX321RYmUInPRLuVd7cTsTFv+FVD/HMul8d1nw
         VcEn99+E/0RoS2NcFmwQZSQ7stFP8e24az9aTWJxzJF3rZfQJFGbSbCNuIKE92XqvO
         0grc5gQss0yQGXLlWUE+vkJmGHQ730meiWW3ESX1Uz4wx9XWK3vMgmsL1iyx/nSEt+
         RIjdrYaP8Lc9w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DAE774049F; Tue, 14 Mar 2023 08:39:17 -0300 (-03)
Date:   Tue, 14 Mar 2023 08:39:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC/PATCHSET 0/9] perf record: Implement BPF sample filter (v4)
Message-ID: <ZBBc5SQK2OhIGtGy@kernel.org>
References: <20230307233309.3546160-1-namhyung@kernel.org>
 <f5b3de20-797c-4ff6-a85b-06c85b4eaa1b@amd.com>
 <ZAtG43JZkUoO9XkF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAtG43JZkUoO9XkF@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 10, 2023 at 12:04:03PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Mar 10, 2023 at 03:28:03PM +0530, Ravi Bangoria escreveu:
> > > It requires samples satisfy all the filter expressions otherwise it'd
> > > drop the sample.  IOW filter expressions are connected with logical AND
> > > operations unless they used "||" explicitly.  So if user has something
> > > like 'A, B || C, D', then BOTH A and D should be true AND either B or C
> > > also needs to be true.
> > > 
> > > Essentially the BPF filter expression is:
> > > 
> > >   <term> <operator> <value> (("," | "||") <term> <operator> <value>)*
> > > 
> > > The <term> can be one of:
> > >   ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
> > >   code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
> > >   p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
> > >   mem_dtlb, mem_blk, mem_hops
> > > 
> > > The <operator> can be one of:
> > >   ==, !=, >, >=, <, <=, &
> > > 
> > > The <value> can be one of:
> > >   <number> (for any term)
> > >   na, load, store, pfetch, exec (for mem_op)
> > >   l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
> > >   na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
> > >   remote (for mem_remote)
> > >   na, locked (for mem_locked)
> > >   na, l1_hit, l1_miss, l2_hit, l2_miss, any_hit, any_miss, walk, fault (for mem_dtlb)
> > >   na, by_data, by_addr (for mem_blk)
> > >   hops0, hops1, hops2, hops3 (for mem_hops)
> > 
> > I think this and few examples should be added in perf-record man page.
> 
> Agreed, and even mentioning cases where it overcome problems like the
> filtering you mentioned for AMD systems.

So, what do you think is best? Wait for v5 or apply v4 and then add
documentation and other touches as followup patches?

- Arnaldo
