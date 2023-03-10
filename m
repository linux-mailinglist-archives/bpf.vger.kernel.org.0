Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530F46B4972
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 16:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjCJPMw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 10:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjCJPMf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 10:12:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4AD123DCC;
        Fri, 10 Mar 2023 07:04:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57D3061A4E;
        Fri, 10 Mar 2023 15:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D66EC4339E;
        Fri, 10 Mar 2023 15:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678460645;
        bh=mqk0HwoIiz3oQZAzA3nO4eAGQCmcs8r7gMDQJtl6vC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1grifkb0unP7UXl7M6IKeC1E+2Lf/xVmtTNrgSaYdOEphZMzj5RgyCPm2lXEiglt
         cZmgyPLrd4yEN2jb6MkbVeGg1n+iRsx5FYN6WR2IJIcYDpbh1Yvy63nJ36A3YtDwOZ
         XzEJJ8lEIGDZxX66/mSI0cst4mAdkxLMyo8cRNPHbyo1CxK7hWJL4KUMchIJtCv6jC
         avIGlHd/mWNDP76esfh2ec5UX7h9gSyhRvgAT3x1JdClX7RO9i/CkFnb718l7SS0Gl
         pSDdXGmXC5jltVjj/p8OKC+dCQKns1dk8byzIaSut4SHzqeA6IRy7BTH3alYOd0D1t
         T5orV4yzAzf8A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6750E4049F; Fri, 10 Mar 2023 12:04:03 -0300 (-03)
Date:   Fri, 10 Mar 2023 12:04:03 -0300
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
Message-ID: <ZAtG43JZkUoO9XkF@kernel.org>
References: <20230307233309.3546160-1-namhyung@kernel.org>
 <f5b3de20-797c-4ff6-a85b-06c85b4eaa1b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b3de20-797c-4ff6-a85b-06c85b4eaa1b@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 10, 2023 at 03:28:03PM +0530, Ravi Bangoria escreveu:
> > It requires samples satisfy all the filter expressions otherwise it'd
> > drop the sample.  IOW filter expressions are connected with logical AND
> > operations unless they used "||" explicitly.  So if user has something
> > like 'A, B || C, D', then BOTH A and D should be true AND either B or C
> > also needs to be true.
> > 
> > Essentially the BPF filter expression is:
> > 
> >   <term> <operator> <value> (("," | "||") <term> <operator> <value>)*
> > 
> > The <term> can be one of:
> >   ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
> >   code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
> >   p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
> >   mem_dtlb, mem_blk, mem_hops
> > 
> > The <operator> can be one of:
> >   ==, !=, >, >=, <, <=, &
> > 
> > The <value> can be one of:
> >   <number> (for any term)
> >   na, load, store, pfetch, exec (for mem_op)
> >   l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
> >   na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
> >   remote (for mem_remote)
> >   na, locked (for mem_locked)
> >   na, l1_hit, l1_miss, l2_hit, l2_miss, any_hit, any_miss, walk, fault (for mem_dtlb)
> >   na, by_data, by_addr (for mem_blk)
> >   hops0, hops1, hops2, hops3 (for mem_hops)
> 
> I think this and few examples should be added in perf-record man page.

Agreed, and even mentioning cases where it overcome problems like the
filtering you mentioned for AMD systems.

- Arnaldo
