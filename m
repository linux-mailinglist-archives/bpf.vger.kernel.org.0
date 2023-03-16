Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24C46BCC3F
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 11:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCPKP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 06:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCPKPI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 06:15:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1781E41B41;
        Thu, 16 Mar 2023 03:15:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92B2561FAC;
        Thu, 16 Mar 2023 10:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C718FC433D2;
        Thu, 16 Mar 2023 10:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678961706;
        bh=u6SbNFyGK6DhDprwxEpLwft4QJBSY9ZwoqO/Bt9FTx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olYXZdoylPgLMeNBvutIs3OL0QlxPkK3ARUtrT9sWY7RRQMrOrU7NXafZa6SuWGyb
         aRKeEshKf09U/bsdrlqEgb4q848QvzESN+qBEh++nW7q9C+tZ8lL3XhBChkOVz/j5d
         UYbjyXI5Sftx/Lza8suH/l51tUTK/uhKPF7UkNGQyyu9+S/UK0vD3swPVE6UcYLB3p
         t81jp/nHT27RNqppjt6C4mGi5T0KmKXEE6UVX/3PII5RJ0WIRIWRAbR8722d1xOi+v
         4zEI0pdZ4rq7se5k++lmiFp+bnwOXrrwCLKrLB5bJl5jcdX/DGSu1TQ5XYea7uRpg7
         CxxN+OnjLwz9A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 96C5E4049F; Thu, 16 Mar 2023 07:15:03 -0300 (-03)
Date:   Thu, 16 Mar 2023 07:15:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 02/10] perf bpf filter: Implement event sample filtering
Message-ID: <ZBLsJ+tt/hjIBQ6v@kernel.org>
References: <20230314234237.3008956-1-namhyung@kernel.org>
 <20230314234237.3008956-3-namhyung@kernel.org>
 <ZBHxRaP7BC+qDzJ/@kernel.org>
 <ZBH0s5P2KV5bJR3h@kernel.org>
 <CAM9d7cjrFT=c-Obw8TsVk3ntGtUEUoGzco8mUssiSPvuZN-iKw@mail.gmail.com>
 <ZBImvCSuWFUgjgQj@kernel.org>
 <ZBKmoeGAmlhv+yvc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBKmoeGAmlhv+yvc@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 15, 2023 at 10:18:25PM -0700, Namhyung Kim escreveu:
> On Wed, Mar 15, 2023 at 05:12:44PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 15, 2023 at 09:51:03AM -0700, Namhyung Kim escreveu:
> > > On Wed, Mar 15, 2023 at 9:39 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Wed, Mar 15, 2023 at 01:24:37PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Tue, Mar 14, 2023 at 04:42:29PM -0700, Namhyung Kim escreveu:
> > > > > > The BPF program will be attached to a perf_event and be triggered when
> > > > > > it overflows.  It'd iterate the filters map and compare the sample
> > > > > > value according to the expression.  If any of them fails, the sample
> > > > > > would be dropped.
> > > > > >
> > > > > > Also it needs to have the corresponding sample data for the expression
> > > > > > so it compares data->sample_flags with the given value.  To access the
> > > > > > sample data, it uses the bpf_cast_to_kern_ctx() kfunc which was added
> > > > > > in v6.2 kernel.
> > > > > >
> > > > > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > >
> > > > >
> > > > > I'm noticing this while building on a debian:11 container:
> > > > >
> > > > >   GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
> > > > >   GENSKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
> > > > >   GENSKEL /tmp/build/perf/util/bpf_skel/func_latency.skel.h
> > > > >   GENSKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
> > > > >   GENSKEL /tmp/build/perf/util/bpf_skel/kwork_trace.skel.h
> > > > >   GENSKEL /tmp/build/perf/util/bpf_skel/sample_filter.skel.h
> > > > > libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] section: -2
> > > > > Error: failed to open BPF object file: No such file or directory
> > > > > make[2]: *** [Makefile.perf:1085: /tmp/build/perf/util/bpf_skel/sample_filter.skel.h] Error 254
> > > > > make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/sample_filter.skel.h'
> > > > > make[2]: *** Waiting for unfinished jobs....
> > > > > make[1]: *** [Makefile.perf:236: sub-make] Error 2
> > > > > make: *** [Makefile:70: all] Error 2
> > > > > make: Leaving directory '/git/perf-6.3.0-rc1/tools/perf'
> > > > > + exit 1
> > > > > [perfbuilder@five 11]$
> > > >
> > > > Same thing on debian:10
> > > 
> > > Hmm.. I thought extern symbols with__ksym are runtime
> > > dependencies and it should build on old kernels too.
> > > 
> > > BPF folks, any suggestions?
> > 
> > Fedora 33 also fails, see below, but these work:
> 
> Maybe I can declare it as a weak symbol.  How about this?

Unsure this is the right fix, for now I'm using NO_BPF_SKEL=1 in those
older distros, will check again early next week when I'm back from a
short trip.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> ---8<---
> 
> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> index 57e3c67d6d37..52cbdd1765cd 100644
> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> @@ -17,7 +17,7 @@ struct filters {
> 
>  int dropped;
> 
> -void *bpf_cast_to_kern_ctx(void *) __ksym;
> +void *bpf_cast_to_kern_ctx(void *) __ksym __weak;
> 
>  /* new kernel perf_sample_data definition */
>  struct perf_sample_data___new {
> @@ -118,6 +118,10 @@ int perf_sample_filter(void *ctx)
>  	int group_result = 0;
>  	int i;
> 
> +	/* no kernel context support, no filtering */
> +	if (!bpf_cast_to_kern_ctx)
> +		return 1;
> +
>  	kctx = bpf_cast_to_kern_ctx(ctx);
> 
>  	for (i = 0; i < MAX_FILTERS; i++) {
> 

-- 

- Arnaldo
