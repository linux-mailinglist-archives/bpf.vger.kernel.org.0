Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAE24CE686
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 20:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiCETOG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 14:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiCETOF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 14:14:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED51DF3;
        Sat,  5 Mar 2022 11:13:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AFD960B58;
        Sat,  5 Mar 2022 19:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A5FC004E1;
        Sat,  5 Mar 2022 19:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646507593;
        bh=ismCCXTQN4wRCQCh0iN8ukxF4lK+mQ4/GREdYf3TjbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaAVBuzRjfjoeHXPcCDbsYEY6FYB+MB7x0U30ugLRbtGOf6xm0Xdn9VxkPcC2wWKV
         Rf98iyA7igwEvWFKG696RBSIO3ke+tw2ZzC4LhCsg7inaLR9sChckCJUhBT5Q4xlyf
         hGexSd5xg0qFXZVjg1Wv2MpkF+8EtVokfFXVtQ+JNIweif5g87a9fCWrgCryrBpfUf
         vHJPCUj++EU8McL1o7lGAT8k35o7FqbGEGFbti2SYPi/e/XsohASkaDl4Vjxzi3tyu
         0vfUPXL5fb3ulsGAHjIQre7VID89ckDEb3sXmTy6EU1Vcskuwhe49F9UfYcBmNEg7Y
         yL3xAPvlIhs4g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 78027403C8; Sat,  5 Mar 2022 16:13:09 -0300 (-03)
Date:   Sat, 5 Mar 2022 16:13:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCHv3 0/2] perf/bpf: Replace deprecated code
Message-ID: <YiO2RXfZU0oaKRnd@kernel.org>
References: <20220224155238.714682-1-jolsa@kernel.org>
 <CAEf4BzYZ5adRWP7AtnwDEa51UArjgWvBCF0d+tvoVgv+QSv2cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYZ5adRWP7AtnwDEa51UArjgWvBCF0d+tvoVgv+QSv2cA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 28, 2022 at 05:49:55PM -0800, Andrii Nakryiko escreveu:
> On Thu, Feb 24, 2022 at 7:52 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > the original patchset [1] removed the whole perf functionality
> > with the hope nobody's using that. But it turned out there's
> > actually bpf script using prologue functionality, so there
> > might be users of this.
> >
> > v3 changes:
> >   - sending priv related changes, because they can be already
> >     merged, the rest will need more discussion and work
> >
> >   - this version gets rid of and adds workaround (and keeps the
> >     current functionality) for following deprecated libbpf functions:
> >
> >       bpf_program__set_priv
> >       bpf_program__priv
> >       bpf_map__set_priv
> >       bpf_map__priv
> >
> >     Basically it implements workarounds suggested by Andrii in [2].
> >
> 
> LGTM, for the series:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks, applied.

- Arnaldo

 
> > Also available in here:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   bpf/depre
> >
> > thanks,
> > jirka
> >
> >
> > [1] https://lore.kernel.org/linux-perf-users/YgoPxhE3OEEmZqla@krava/T/#t
> > [2] https://lore.kernel.org/linux-perf-users/YgoPxhE3OEEmZqla@krava/T/#md3ccab9fe70a4583e94603b1a562e369bd67b17d
> > ---
> > Jiri Olsa (2):
> >       perf tools: Remove bpf_program__set_priv/bpf_program__priv usage
> >       perf tools: Remove bpf_map__set_priv/bpf_map__priv usage
> >
> >  tools/perf/util/bpf-loader.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 141 insertions(+), 23 deletions(-)

-- 

- Arnaldo
