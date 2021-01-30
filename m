Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C8B309337
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 10:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhA3JVw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jan 2021 04:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhA3JVh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Jan 2021 04:21:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB25C061351;
        Sat, 30 Jan 2021 00:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aUJjQWq04yfyD9i9zO9j9MoGWuJhNQkIG0RfzLvmCjA=; b=AT4G5Roe61L1QOg1iL8NT3diId
        42noT2VCN+nZqZwZifNNJEuAKpdH9LFV6XvuCR3Uh2zfpajNaXsXiOg5n76Xq+NBj44mhCd45f4WK
        eGp6KoJxSAMs2NlxP8XP2d1NYecOYacNLHC9fOVgnRWkpQvgE01aUKSDy2ZaLDGi6ZA4y7e+tmeAx
        gY80zaBz5B4mvLEBLsYBKTfgPNSZ/XxlzcSK1tVUmDePgWrWCQ2Ujda9G13fGP5YnasTTzKrgMZY0
        obzMbUh9zhtbhTd2lBIKIv0sQlZnb6eGD+cWnEUCkJAL78Ao5rRa1GFTof64b0Abo37Rk3UDBgmus
        iKoOBy7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l5lcQ-00AslN-Dx; Sat, 30 Jan 2021 08:28:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 05FD83011E6;
        Sat, 30 Jan 2021 09:28:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E15272DACC7DB; Sat, 30 Jan 2021 09:28:32 +0100 (CET)
Date:   Sat, 30 Jan 2021 09:28:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <YBUYsFlxjsQxuvfB@hirez.programming.kicks-ass.net>
References: <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net>
 <20210129013452.njuh3fomws62m4rc@ast-mbp.dhcp.thefacebook.com>
 <YBPNyRyrkzw2echi@hirez.programming.kicks-ass.net>
 <20210129224011.81bcdb3eba1227c414e69e1f@kernel.org>
 <20210129105952.74dc8464@gandalf.local.home>
 <20210129162438.GC8912@worktop.programming.kicks-ass.net>
 <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
 <20210129175943.GH8912@worktop.programming.kicks-ass.net>
 <20210129140103.3ce971b7@gandalf.local.home>
 <20210129162454.293523c6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129162454.293523c6@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 04:24:54PM -0500, Steven Rostedt wrote:
> Specifically, kprobe and ftrace callbacks may have this:
> 
> 	if (in_nmi())
> 		return;
> 
> 	raw_spin_lock_irqsave(&lock, flags);
> 	[..]
> 	raw_spin_unlock_irqrestore(&lock, flags);
> 
> Which is totally fine to have,

Why? There's a distinct lack of explaining here.

Note that we ripped out all such dodgy locking from kretprobes.
