Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C07977BB
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 13:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfHULJL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 07:09:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45728 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfHULJL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 07:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W2UGQr4YUB1QteFjmkOBum/39f6kiIhySuwMzo7v67A=; b=S4Dn3R8NYRVAk4tyFWdTH0L+f
        qANdXfP3FBbW45sUO57pICZfhMyEU0wYl5uIr4jmtwpBKaBQ65WW+CE4QT34RbnyOns1uGLq6xAVR
        d5hr+bkowtZpY/ce6pLylnF35Cz338g/KmDxZI0azsTYI/iMWahINelh6Ty51PY3Lk9VWlPJesAQR
        TXs1cXfpyiShg5CtbpTdrJZhLx8tvwOJI6+/LBJZzp657v6Cw8xaNdZ+ZoX6UjPzfJczskqw548l4
        w76IVC8WlFjCJQBwfmubh1CEue7KP30TPcteLd3aL8KmfBJUX1RExoH9ZAMtZ4N0rKBlUh+WvM/cI
        ch0/XHytA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0OU8-0005Q0-3q; Wed, 21 Aug 2019 11:09:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79973307456;
        Wed, 21 Aug 2019 13:08:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D6C7D20A21FCB; Wed, 21 Aug 2019 13:08:56 +0200 (CEST)
Date:   Wed, 21 Aug 2019 13:08:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, mingo@redhat.com, acme@kernel.org, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
Message-ID: <20190821110856.GB2349@hirez.programming.kicks-ass.net>
References: <20190820144503.GV2332@hirez.programming.kicks-ass.net>
 <BWENHQJIN885.216UOYEIWNGFU@dlxu-fedora-R90QNFJV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BWENHQJIN885.216UOYEIWNGFU@dlxu-fedora-R90QNFJV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 20, 2019 at 10:58:47AM -0700, Daniel Xu wrote:
> Hi Peter,
> 
> On Tue Aug 20, 2019 at 4:45 PM Peter Zijlstra wrote:
> > On Fri, Aug 16, 2019 at 03:31:46PM -0700, Daniel Xu wrote:
> > > It's useful to know [uk]probe's nmissed and nhit stats. For example with
> > > tracing tools, it's important to know when events may have been lost.
> > > debugfs currently exposes a control file to get this information, but
> > > it is not compatible with probes registered with the perf API.
> > 
> > What is this nmissed and nhit stuff?
> 
> nmissed is the number of times the probe's handler should have been run
> but didn't. nhit is the number of times the probes handler has run. I've
> documented this information in the uapi header. If you'd like, I can put
> it in the commit message too.

That comment just says: 'number of times this probe was temporarily
disabled', which says exactly nothing.

But reading the kprobe code seems to suggest this happens on recursive
kprobes, which I'm thinking is a dodgy situation in the first place.

ftrace and perf in general don't keep counts of events lost due to
recursion, so why should we do this for kprobes? Also, while you write
to support uprobes, it doesn't actually suffer from this (it cannot,
uprobes cannot recurse), so supporting it makes no sense.

And with that, the name QUERY_PROBE also makes no sense, because it is
not specific to [uk]probes, all software events suffer this.

And I'm not sure an additional ioctl() is the right way, supposing we
want to expose this at all. You've mentioned no alternative approached,
I'm thinking PERF_FORMAT_LOST might be possible, or maybe a
PERF_RECORD_LOST extention.

Of course, then you get to implement it for tracepoints and software
events too.
