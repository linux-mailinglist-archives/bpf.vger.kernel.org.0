Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAD4677C06
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 13:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjAWM6p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 07:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjAWM6o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 07:58:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D9110E9;
        Mon, 23 Jan 2023 04:58:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9268560EF8;
        Mon, 23 Jan 2023 12:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C932CC433D2;
        Mon, 23 Jan 2023 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674478723;
        bh=iqF4YslRUAOR8em9VxtEx6LNWXvY7IrQ9E5c6+BFk0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLSkM4a7cfgHy6X48ai/sKQ8h0q2CPGhVzFjtpYM+HhP5bGwzhSY6wU+xBRrOq3aX
         HvehlCCyhdJ19nF4mc0OdYwHm2xCSZehb409VJIpq53hIFWp7N4s3RPnkOTDeo+3WP
         nN9eh9T9kImOTbUktrXoLWqaZo4UMgiPVwIOfgXwTTTLfvLZ038n6OdF7AQ+stSOk7
         rj9/o7bGh8bZaCUF3xURM+0UypDj1j6LuW77UlwMS/RUpjQk67/wNSPOBFySXVElVS
         PbkvnvWx2OJfhFgjTykorxxaBIWwlrA70tqc7KwZ37Vo+IW1FjDkna/r0XFAcOg88k
         Jrkp0TzDBGUww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF79F405BE; Mon, 23 Jan 2023 09:58:39 -0300 (-03)
Date:   Mon, 23 Jan 2023 09:58:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Disha Goel <disgoel@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] perf test: Switch basic bpf filtering test to use
 syscall tracepoint
Message-ID: <Y86Ef0KKlor+XsXm@kernel.org>
References: <20230123083224.276404-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123083224.276404-1-naveen.n.rao@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jan 23, 2023 at 02:02:24PM +0530, Naveen N. Rao escreveu:
> BPF filtering tests can sometime fail. Running the test in verbose mode
> shows the following:

Thanks, applied.

- Arnaldo

>   $ sudo perf test 42
>   42: BPF filter                                                      :
>   42.1: Basic BPF filtering                                           : FAILED!
>   42.2: BPF pinning                                                   : Skip
>   42.3: BPF prologue generation                                       : Skip
>   $ perf --version
>   perf version 4.18.0-425.3.1.el8.ppc64le
>   $ sudo perf test -v 42
>   42: BPF filter                                                      :
>   42.1: Basic BPF filtering                                           :
>   --- start ---
>   test child forked, pid 711060
>   ...
>   bpf: config 'func=do_epoll_wait' is ok
>   Looking at the vmlinux_path (8 entries long)
>   Using /usr/lib/debug/lib/modules/4.18.0-425.3.1.el8.ppc64le/vmlinux for symbols
>   Open Debuginfo file: /usr/lib/debug/.build-id/81/56f5a07f92ccb62c5600ba0e4aacfb5f3a7534.debug
>   Try to find probe point from debuginfo.
>   Matched function: do_epoll_wait [4ef8cb0]
>   found inline addr: 0xc00000000061dbe4
>   Probe point found: __se_compat_sys_epoll_pwait+196
>   found inline addr: 0xc00000000061d9f4
>   Probe point found: __se_sys_epoll_pwait+196
>   found inline addr: 0xc00000000061d824
>   Probe point found: __se_sys_epoll_wait+36
>   Found 3 probe_trace_events.
>   Opening /sys/kernel/tracing//kprobe_events write=1
>   ...
>   BPF filter result incorrect, expected 56, got 56 samples
>   test child finished with -1
>   ---- end ----
>   BPF filter subtest 1: FAILED!
> 
> The statement above about the result being incorrect looks weird, and it
> is due to that particular perf build missing commit 3e11300cdfd5f1
> ("perf test: Fix bpf test sample mismatch reporting"). In reality, due
> to commit 4b04e0decd2518 ("perf test: Fix basic bpf filtering test"),
> perf expects there to be 56*3 samples.
> 
> However, the number of samples we receive is going to be dependent on
> where the probes are installed, which is dependent on where
> do_epoll_wait gets inlined. On s390x, it looks like probes at all the
> inlined locations are hit. But, that is not the case on ppc64le.
> 
> Fix this by switching the test to instead use the syscall tracepoint.
> This ensures that we will only ever install a single event enabling us
> to reliably determine the sample count.
> 
> Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>

> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/bpf-script-example.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
> index 7981c69ed1b456..b638cc99d5ae56 100644
> --- a/tools/perf/tests/bpf-script-example.c
> +++ b/tools/perf/tests/bpf-script-example.c
> @@ -43,7 +43,7 @@ struct {
>  	__type(value, int);
>  } flip_table SEC(".maps");
>  
> -SEC("func=do_epoll_wait")
> +SEC("syscalls:sys_enter_epoll_pwait")
>  int bpf_func__SyS_epoll_pwait(void *ctx)
>  {
>  	int ind =0;
> 
> base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
> -- 
> 2.39.1
> 

-- 

- Arnaldo
