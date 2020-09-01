Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1942592D1
	for <lists+bpf@lfdr.de>; Tue,  1 Sep 2020 17:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgIAPRR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Sep 2020 11:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729383AbgIAPRM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Sep 2020 11:17:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CDDB20767;
        Tue,  1 Sep 2020 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973432;
        bh=x2bRiouukbJBd8LT6tHebPJiKEStlGF3+9oAW9kOYlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BaXEODKj/uloxN64+u2lfagyNrs1j/QEoGpLxR4/eBtPRK9NV0YlrtevSWb1V9nse
         EfNMFM1BTq7jUkoCHxR3KQR/PB3rFELME554eHFWhtPvLMw1GAZvqkHsEbfM0m3bsr
         FBf0guFqTVpWFPrG2a7kVD44et5g/mshVDzHxB0Q=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 28ED840D3D; Tue,  1 Sep 2020 12:17:10 -0300 (-03)
Date:   Tue, 1 Sep 2020 12:17:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     tmricht@linux.ibm.com, hca@linux.ibm.com, svens@linux.ibm.com,
        jolsa@redhat.com, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] perf test: Fix basic bpf filtering test
Message-ID: <20200901151710.GD1424523@kernel.org>
References: <20200817072754.58344-1-sumanthk@linux.ibm.com>
 <1954643f-e268-b7bc-7c6e-75205d9f5f92@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1954643f-e268-b7bc-7c6e-75205d9f5f92@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Aug 25, 2020 at 10:32:45AM +0200, Sumanth Korikkar escreveu:
> Kind Ping. Thank you.

I've applied it already, will go to Linus today.

- Arnaldo
 
> On 8/17/20 9:27 AM, Sumanth Korikkar wrote:
> > BPF basic filtering test fails on s390x (when vmlinux debuginfo is
> > utilized instead of /proc/kallsyms)
> > 
> > Info:
> > - bpf_probe_load installs the bpf code at do_epoll_wait.
> > - For s390x, do_epoll_wait resolves to 3 functions including inlines.
> >    found inline addr: 0x43769e
> >    Probe point found: __s390_sys_epoll_wait+6
> >    found inline addr: 0x437290
> >    Probe point found: do_epoll_wait+0
> >    found inline addr: 0x4375d6
> >    Probe point found: __se_sys_epoll_wait+6
> > - add_bpf_event  creates evsel for every probe in a BPF object. This
> >    results in 3 evsels.
> > 
> > Solution:
> > - Expected result = 50% of the samples to be collected from epoll_wait *
> >    number of entries present in the evlist.
> > 
> > Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
> > ---
> >   tools/perf/tests/bpf.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> > index 5d20bf8397f0..cd77e334e577 100644
> > --- a/tools/perf/tests/bpf.c
> > +++ b/tools/perf/tests/bpf.c
> > @@ -197,7 +197,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
> >   		perf_mmap__read_done(&md->core);
> >   	}
> > -	if (count != expect) {
> > +	if (count != expect * evlist->core.nr_entries) {
> >   		pr_debug("BPF filter result incorrect, expected %d, got %d samples\n", expect, count);
> >   		goto out_delete_evlist;
> >   	}
> 
> -- 
> Sumanth Korikkar
> 

-- 

- Arnaldo
