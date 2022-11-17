Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD3862E5A5
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 21:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiKQUM3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 15:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiKQUM2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 15:12:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867077EBE9;
        Thu, 17 Nov 2022 12:12:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE992B821F3;
        Thu, 17 Nov 2022 20:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563B4C433C1;
        Thu, 17 Nov 2022 20:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668715944;
        bh=e56t0nc+8yUV+Q3+RwNDdQyrSxLwHO3oWil+eDUu2OQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aW4l8+bEIhdXj2ZhqjYoeuhszYj66EVOf9rvi+67SpIjx6a3fp0KXztwPzpIsQsao
         WQ0++A/LoX763NCRoD6DGhp+XvQLVuuLfTckbNSSeqqnDV3+fxoLoGqDvB+uQL7jM+
         PHhoE6UkJGITq7zjVVehYAkRN52Y1GX7wfKNcVYLk7QYoPU3P8IaLMkUGQ0zKXQpuA
         dZhYQj3YGDv5xdv3Nbfe03Bq3ptmRoz/ZHH3BV5F+htFuOPwB/HLMTY5iaLXf//gdd
         3Py16U5e87wF1Du96Gt1CmiQ8eEMX/KxTiE7ke21F0Gjtnl17viVdhYUc8eM+4Fnnm
         ZTyiqMYH1lUnA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 261D94034E; Thu, 17 Nov 2022 17:12:21 -0300 (-03)
Date:   Thu, 17 Nov 2022 17:12:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/6] Build output clean up
Message-ID: <Y3aVpVkPkOf8nw4x@kernel.org>
References: <20221117004356.279422-1-irogers@google.com>
 <Y3ZV0FDW70ADoIYE@kernel.org>
 <CAEf4BzbZ2-KiM=S6k11+39Y7vQMOmj7YvAd2w59BOXtCacjtFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbZ2-KiM=S6k11+39Y7vQMOmj7YvAd2w59BOXtCacjtFg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Nov 17, 2022 at 11:32:10AM -0800, Andrii Nakryiko escreveu:
> On Thu, Nov 17, 2022 at 7:40 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Nov 16, 2022 at 04:43:50PM -0800, Ian Rogers escreveu:
> > > Reduce build spam from commands not prefixed with @. Make
> > > install_headers targets distinguishable by adding in the library name
> > > so:
> > > INSTALL headers
> > > becomes:
> > > INSTALL libapi_headers
> > >
> > > Ian Rogers (6):
> > >   tools lib api: clean up install_headers
> > >   tools lib bpf: Avoid install_headers make warning
> > >   tools lib symbol: clean up build output
> > >   tools lib perf: Make install_headers clearer
> > >   tools lib subcmd: Make install_headers clearer
> > >   tools lib traceevent: Make install_headers clearer
> >
> > Andrii, are you ok with that? Can I carry this on my next (perf/core)
> > branch?
> 
> yep, lgtm. Please take it through your tree, in-kernel Makefile is not
> even synced into Github, so there is no downsides in terms of libbpf
> sync.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks, done.

- Arnaldo
