Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419E2452CF8
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 09:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhKPIjH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 03:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhKPIiT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 03:38:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FF9C061200;
        Tue, 16 Nov 2021 00:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sU/4DH/+XhhXpbKXlYS/Eskb40hxc9he/91nSaQu5vc=; b=Y7f/Wtw7YpekMwuS6LpLvp6DQR
        UIdcXo4qyYBlCUOQ7Si4ZT2z/HVHtgCMt53XCGCe5/oxxEkTG0eoR0Cmbz33MVVB/UiOVJ6PKb9eG
        BKeVj6jdxbpZXDR+p0xI1pE1oCb0R9sls3t1gK4IzcEdii8MHE0HrCUxi6pHsVrDKaqKwTaXXmDQs
        0pvXFektuXsBSuM0r2kRphRqBqP+HPaeDGSBSFEue1WZdplqmBNn9/xwUccN0QXgO8JAw2yt4VxOq
        3DKEbOaz8uNaWHOKeTYhISiAR5MCH2qOXNtyEA9EiuQWwXFmzJ2q+8a2mLHwq4TXPffRHtmVYd9i0
        6VCCPi8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmtva-006ab5-K8; Tue, 16 Nov 2021 08:34:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D370498651D; Tue, 16 Nov 2021 09:34:54 +0100 (CET)
Date:   Tue, 16 Nov 2021 09:34:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Kajol Jain <kjain@linux.ibm.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        songliubraving@fb.com, andrii@kernel.org, kafai@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, davem@davemloft.net, kpsingh@kernel.org,
        hawk@kernel.org, kuba@kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        rnsastry@linux.ibm.com
Subject: Re: [PATCH] bpf: Enable bpf support for reading branch records in
 powerpc
Message-ID: <20211116083454.GY174703@worktop.programming.kicks-ass.net>
References: <20211115044437.12047-1-kjain@linux.ibm.com>
 <5a185d6b-7090-23f0-1ec9-140a31ee5fb4@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a185d6b-7090-23f0-1ec9-140a31ee5fb4@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 16, 2021 at 12:30:07AM +0100, Daniel Borkmann wrote:

> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index fdd14072fc3b..2b7343b64bb7 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1245,7 +1245,7 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
> >   BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
> >   	   void *, buf, u32, size, u64, flags)
> >   {
> > -#ifndef CONFIG_X86
> > +#if !(defined(CONFIG_X86) || defined(CONFIG_PPC64))
> 
> Can this really be enabled generically? Looking at 3925f46bb590 ("powerpc/perf: Enable
> branch stack sampling framework") it says POWER8 [and beyond]. Should there be a generic
> Kconfig symbol like ARCH_HAS_BRANCH_RECORDS that can be selected by archs instead?

I conplained about it before as well. I'd just take it out entirely.

If perf_snapshot_branch_stack isn't implemnted it'll return 0 and then
we'll -Esomething anyway.


