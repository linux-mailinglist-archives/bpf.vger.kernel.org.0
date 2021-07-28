Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1F33D8A1E
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 10:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhG1I6j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 04:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1I6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 04:58:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F201C061757
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D+E2MJ/UDABVRN+xUn4YbQObkJSAPaB3ZfCmWo+l9b4=; b=OGTtKu8pFSyUTMpoqGSXKWUUMI
        qrzQzHwdWnoGjzDHdj4C2eIhcG2aO7oSwBrFPKLKGR7brA1YgwX83LG1BZpNoybaLjzU6eKOrQa7o
        HOePCVUmVCaDvDeH+LqqeCNDgdpmzI1Gr2hnIvMaxweIFinHEDenRaRJ8qfyQFI5GERJOJf4T3JhY
        BLlVarGR7VFgxRBW287LF8atiHT2QLqAS6SZDnuaV5ZwRMVI5OK6cXTWfOJLANXyFFQVORZplqi6t
        HOVo39MszFoCW5DeRaDPbXW0g2E4gO5ciiDFdE+pwwAc9E6arQDQh+4WtL6hDERD0oLCiiGLpxb/N
        rLy7iuew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8fOT-003fUS-Db; Wed, 28 Jul 2021 08:58:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45957300056;
        Wed, 28 Jul 2021 10:58:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B1082C8D3FC7; Wed, 28 Jul 2021 10:58:24 +0200 (CEST)
Date:   Wed, 28 Jul 2021 10:58:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 05/14] bpf: allow to specify user-provided
 context value for BPF perf links
Message-ID: <YQEcMEHm+Ww1m4WO@hirez.programming.kicks-ass.net>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-6-andrii@kernel.org>
 <YP/N1HR6GAanBd9m@hirez.programming.kicks-ass.net>
 <CAEf4BzZCOj_rQrUjLnvBNYTDCg6A_5mC7rBuBJxm0Lzr8F5-pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZCOj_rQrUjLnvBNYTDCg6A_5mC7rBuBJxm0Lzr8F5-pg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 27, 2021 at 02:09:08PM -0700, Andrii Nakryiko wrote:
> On Tue, Jul 27, 2021 at 2:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jul 26, 2021 at 09:12:02AM -0700, Andrii Nakryiko wrote:
> > > Add ability for users to specify custom u64 value when creating BPF link for
> > > perf_event-backed BPF programs (kprobe/uprobe, perf_event, tracepoints).
> >
> > If I read this right, the value is dependent on the link, not the
> > program. In which case:
> 
> You can see it both ways. BPF link in this (and at least few other
> cases) is just this invisible orchestrator of BPF program
> attachment/detachment. The underlying perf_event subsystem doesn't
> know about the existence of the BPF link at all. In the end, it's
> actually struct bpf_prog that is added to perf_event or into tp's
> bpf_prog_array list, and this user-provided value (bpf cookie per
> below) is associated with that particular attachment. So when we call
> trace_call_bpf() from tracepoint or kprobe/uprobe, there is no BPF
> link anywhere, it's just a list of bpf_prog_array_items, with bpf_prog
> pointer and associated user value. Note, exactly the same bpf_prog can
> be attached to another perf_event with a completely different cookie
> and that's expected and is fine.
> 
> So in short, perf_event just needs to know about attaching/detaching
> bpf_prog pointer (and this cookie), it doesn't need to know about
> bpf_link. Everything is handled the same regardless if bpf_link is
> used to attach or ioctl(PERF_EVENT_IOC_SET_BPF).

OK, fair enough I suppose.

> > > @@ -9966,6 +9968,7 @@ static int perf_event_set_bpf_handler(struct perf_event *event, struct bpf_prog
> > >       }
> > >
> > >       event->prog = prog;
> > > +     event->user_ctx = user_ctx;
> > >       event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
> > >       WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
> > >       return 0;
> >
> > Also, the name @user_ctx is a bit confusing. Would something like
> > @bpf_cookie or somesuch not be a better name?
> 
> I struggled to come up with a good name, user_ctx was the best I could
> do. But I do like bpf_cookie for this, thank you! I'll switch the
> terminology in the next revision.

y/w :-)


Thanks!
