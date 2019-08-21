Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F31982D5
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 20:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfHUScF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 14:32:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfHUScF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tVY1LXmdi32TE9w1SeLZsUhYLzjbIKh1g8jTSkv50s0=; b=bhJJa4E42SMEYiIa1DWA2XlMu
        4vGjx+rsvfe+CrMjov5MKEqtLN+RI/AcK6Vs7e5E3E7S1/KeayvRFeJ14231xfrWhGN7WN000fvI1
        wr6ARpqeyItdr4BeTOr4gIlYjDRXI9jQn/GdZuKv+i6EPx+OkN2r9RgSU//OsEDYyP+kQQNydRsEu
        4dsQfkB04uYA3XjbDZZvaRh7ww+8QaF0H1Br4ZgkIHEftCSadBmxj336Y0i2uq2d8euohNvTMJYgr
        ei8PQDJkEP29FLGm9feeESwlOZHZ9hxmFFSMYiF+iJ9olCPAoFo3nvHYqvnjl+ksRjTGX7ZIFtkAJ
        prHujlgIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0VOo-0003wh-HG; Wed, 21 Aug 2019 18:31:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3F5F307456;
        Wed, 21 Aug 2019 20:31:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C7DE20F0FB1F; Wed, 21 Aug 2019 20:31:55 +0200 (CEST)
Date:   Wed, 21 Aug 2019 20:31:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
Message-ID: <20190821183155.GE2349@hirez.programming.kicks-ass.net>
References: <20190820144503.GV2332@hirez.programming.kicks-ass.net>
 <BWENHQJIN885.216UOYEIWNGFU@dlxu-fedora-R90QNFJV>
 <20190821110856.GB2349@hirez.programming.kicks-ass.net>
 <62874df3-cae0-36a1-357f-b59484459e52@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62874df3-cae0-36a1-357f-b59484459e52@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 21, 2019 at 04:54:47PM +0000, Yonghong Song wrote:
> Currently, in kernel/trace/bpf_trace.c, we have
> 
> unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
> {
>          unsigned int ret;
> 
>          if (in_nmi()) /* not supported yet */
>                  return 1;
> 
>          preempt_disable();
> 
>          if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {

Yes, I'm aware of that.

> In the above, the events with bpf program attached will be missed
> if the context is nmi interrupt, or if some recursion happens even with 
> the same or different bpf programs.
> In case of recursion, the events will not be sent to ring buffer.

And while that is significantly worse than what ftrace/perf have, it is
fundamentally the same thing.

perf allows (and iirc ftrace does too) 4 nested context per CPU
(task,softirq,irq,nmi) but any recursion within those context and we
drop stuff.

The BPF stuff is just more eager to drop things on the floor, but it is
fundamentally the same.

> A lot of bpf-based tracing programs uses maps to communicate and
> do not allocate ring buffer at all.

So extending PERF_RECORD_LOST doesn't work. But PERF_FORMAT_LOST might
still work fine; but you get to implement it for all software events.

> Maybe we can still use ioctl based approach which is light weighted
> compared to ring buffer approach? If a fd has bpf attached, nhit/nmisses
> means the kprobe is processed by bpf program or not.

There is nothing kprobe specific here. Kprobes just appear to be the
only one actually accounting the recursion cases, but everyone has
them.

> Currently, for debugfs, the nhit/nmisses info is exposed at
> {k|u}probe_profile. Alternative, we could expose the nhit/nmisses
> in /proc/self/fdinfo/<fd>. User can query this interface to
> get numbers.

No, we're not adding stuff to procfs for this.
