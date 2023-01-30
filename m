Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD2B681111
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 15:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbjA3OJ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 09:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbjA3OJz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 09:09:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0033B3DD;
        Mon, 30 Jan 2023 06:09:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49BB1B8117B;
        Mon, 30 Jan 2023 14:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEBDC433D2;
        Mon, 30 Jan 2023 14:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675087789;
        bh=HJDfDNRtvtMkI/CNFU46URo+WEQ69a9tFSAn18ubN5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qcx3qYHIRvWNeCs1V8s7ttq24HNGrf8rkU2zTJTwlDKVbjr3arv68tvhDnQzAPgBH
         4zTiSv/SOVKfAfAjjegeBEorXkJsD0B4ytw5iRqDcM/4NhL0+KmN8S0yfQGOau0a9o
         RcRVuJSQ682lwb3vBar1oq+ddWIwSyuvulqU0CAeukjPJ3Ok9mmPsV2NsiI0ozpGNh
         cfeUCJyEJ7mjLoQhpYfSlqJGhGVMjg2TNt5gRvW3GZgQ5dTWGlf11pxWa0ludN/ohy
         GiQYtxkKiMg5z//WcQxHP59ycpf+FyRPg5C+f8V0jcVGS19IH1cM5wEc/h4j8Uik7N
         oHlR2PUegZ+5Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4FE08405BE; Mon, 30 Jan 2023 11:09:45 -0300 (-03)
Date:   Mon, 30 Jan 2023 11:09:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] perf test: Switch basic bpf filtering test to use
 syscall tracepoint
Message-ID: <Y9fPqaZ1MksBX/lx@kernel.org>
References: <20230123083224.276404-1-naveen.n.rao@linux.vnet.ibm.com>
 <70b60459-2e7a-1944-77dc-54fef2e00975@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70b60459-2e7a-1944-77dc-54fef2e00975@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jan 30, 2023 at 02:28:49PM +0530, kajoljain escreveu:
> 
> 
> On 1/23/23 14:02, Naveen N. Rao wrote:
> > BPF filtering tests can sometime fail. Running the test in verbose mode
> > shows the following:
> >   $ sudo perf test 42
> >   42: BPF filter                                                      :
> >   42.1: Basic BPF filtering                                           : FAILED!
> >   42.2: BPF pinning                                                   : Skip
> >   42.3: BPF prologue generation                                       : Skip
> >   $ perf --version
> >   perf version 4.18.0-425.3.1.el8.ppc64le
> >   $ sudo perf test -v 42
> >   42: BPF filter                                                      :
> >   42.1: Basic BPF filtering                                           :
> >   --- start ---
> >   test child forked, pid 711060
> >   ...
> >   bpf: config 'func=do_epoll_wait' is ok
> >   Looking at the vmlinux_path (8 entries long)
> >   Using /usr/lib/debug/lib/modules/4.18.0-425.3.1.el8.ppc64le/vmlinux for symbols
> >   Open Debuginfo file: /usr/lib/debug/.build-id/81/56f5a07f92ccb62c5600ba0e4aacfb5f3a7534.debug
> >   Try to find probe point from debuginfo.
> >   Matched function: do_epoll_wait [4ef8cb0]
> >   found inline addr: 0xc00000000061dbe4
> >   Probe point found: __se_compat_sys_epoll_pwait+196
> >   found inline addr: 0xc00000000061d9f4
> >   Probe point found: __se_sys_epoll_pwait+196
> >   found inline addr: 0xc00000000061d824
> >   Probe point found: __se_sys_epoll_wait+36
> >   Found 3 probe_trace_events.
> >   Opening /sys/kernel/tracing//kprobe_events write=1
> >   ...
> >   BPF filter result incorrect, expected 56, got 56 samples
> >   test child finished with -1
> >   ---- end ----
> >   BPF filter subtest 1: FAILED!
> 
> Patch looks good to me.
> 
> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks, added to that cset, as it is still just on tmp.perf/core.

- Arnaldo
