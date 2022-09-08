Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CEC5B2606
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 20:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiIHSnp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 14:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiIHSno (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 14:43:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74D9B2DAF;
        Thu,  8 Sep 2022 11:43:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52DADB82220;
        Thu,  8 Sep 2022 18:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F2CC433D6;
        Thu,  8 Sep 2022 18:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662662621;
        bh=9o8UhnmvSSPQAX15Og0MpXzXj8mBI1uz6bugcbcXZ3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vh5ViOxtHE8L/b75nj2myzQzSBr6t6JiYtj/GTWhSx5rpQk3/S6Hh7aGOQJm5K2+9
         25gO3JcWwgcVzFvQL/V6D8eTFRmWZ0CpkLuCB5hctH2Z5RNep9zBvHSj1sP2C/VDYc
         iPTzl2un/oFhShla4hnB59+v+rBPKaptwLGjRh5diJ2F1L8RfQpW9o/A1trGPqm/PP
         cPVDgeWip7GUbwUl3CYfJ3lXqWzVcP3y2ToApjtiGDlpj3gq0TQ2EGN3DX19sz/owU
         mmCLYLgJNSfdO8GVCLUEFOr+IeS8YxFtR354baTezosAPq4pkn62UBma+B2qYKO3LO
         gxHeIBeVVv0qA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0BBF404A1; Thu,  8 Sep 2022 15:43:38 -0300 (-03)
Date:   Thu, 8 Sep 2022 15:43:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH 0/4] perf lock contention: Improve call stack handling
 (v1)
Message-ID: <Yxo32kpxsl9Mr7Mt@kernel.org>
References: <20220908063754.1369709-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908063754.1369709-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Sep 07, 2022 at 11:37:50PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> I found that call stack from the lock tracepoint (using bpf_get_stackid)
> can be different on each configuration.  For example it's very different
> when I run it on a VM than on a real machine.
> 
> The perf lock contention relies on the stack trace to get the lock
> caller names, this kind of difference can be annoying.  Ideally we could
> skip stack trace entries for internal BPF or lock functions and get the
> correct caller, but it's not the case as of today.  Currently it's hard
> coded to control the behavior of stack traces for the lock contention
> tracepoints.
> 
> To handle those differences, add two new options to control the number of
> stack entries and how many it skips.  The default value worked well on
> my VM setup, but I had to use --stack-skip=5 on real machines.
> 
> You can get it from 'perf/lock-stack-v1' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

This clashed with a patch you Acked earlier, so lets see if someone has
extra review comments and a v2 become needed for other reason, when you
can refresh it, ok?

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf lock contention: Factor out get_symbol_name_offset()
>   perf lock contention: Show full callstack with -v option
>   perf lock contention: Allow to change stack depth and skip
>   perf lock contention: Skip stack trace from BPF
> 
>  tools/perf/Documentation/perf-lock.txt        |  6 ++
>  tools/perf/builtin-lock.c                     | 89 ++++++++++++++-----
>  tools/perf/util/bpf_lock_contention.c         | 21 +++--
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  3 +-
>  tools/perf/util/lock-contention.h             |  3 +
>  5 files changed, 96 insertions(+), 26 deletions(-)
> 
> 
> base-commit: 6c3bd8d3e01d9014312caa52e4ef1c29d5249648
> -- 
> 2.37.2.789.g6183377224-goog

-- 

- Arnaldo
