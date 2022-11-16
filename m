Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E768462C24A
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 16:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiKPPTv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 10:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiKPPTb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 10:19:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270435F94;
        Wed, 16 Nov 2022 07:19:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B748B61E69;
        Wed, 16 Nov 2022 15:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE47BC433D6;
        Wed, 16 Nov 2022 15:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668611970;
        bh=amz+WZIooJmQLr8yARD9v3h2AKS1hVv79/Fc9v0jPko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgy7/EgfDDgiAjirNledOE4UcOvHe22VMXF11MKlJJEFIdilsk8r2lWx9pHCCiUBt
         Le7C6+GaRANyL++vfbXrEUndFHYHwqkTiSbNL5Mp4xWjEsyLT182DzNc2sJpwj5+g9
         hB3lrYqLRVDCMp/NUmmo3KfluO+FuUJsaySjonmcF3l4iZ4lo2dzKQXGfXWD6ygyEG
         zeQJJ99gB3HGxq7Dy1Uq5zEEpNwPKTfrgh1QLSrU6eIC3MXxqUBMG88cFg3ONt+snm
         JRM687rSpQtELuQtKSg3xv3RnnKzyMQ4YFa90ZI0Fd+s0iJCY6HGnOtKxDxR4g9sUQ
         4w6FH2+FTyVdQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 734A04034E; Wed, 16 Nov 2022 12:19:27 -0300 (-03)
Date:   Wed, 16 Nov 2022 12:19:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/1] Fix perf tools/lib includes
Message-ID: <Y3T/fxPOvZgePIEz@kernel.org>
References: <20221116072211.2837834-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116072211.2837834-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Nov 15, 2022 at 11:22:10PM -0800, Ian Rogers escreveu:
> This patch replaces the last on kernel/git/acme/linux.git branch
> perf/tools-libs-includes and fixes the race issue by using the prepare
> dependency. pmu-events.c needs this dependency too, as the header
> files it includes also include libperf - using perpare as a dependency
> rather than $(LIBPERF) is more consistent with the rest of the makefile.
> 
> Ian Rogers (1):
>   perf build: Use tools/lib headers from install path

Testing.
 
>  tools/perf/Makefile.config |  2 --
>  tools/perf/Makefile.perf   | 14 +++++++++++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> -- 
> 2.38.1.431.g37b22c650d-goog

-- 

- Arnaldo
