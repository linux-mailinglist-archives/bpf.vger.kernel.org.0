Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3FDC037
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 10:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632929AbfJRIqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 04:46:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56037 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbfJRIqI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 04:46:08 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iLNta-00026I-T6; Fri, 18 Oct 2019 10:46:03 +0200
Date:   Fri, 18 Oct 2019 10:46:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Clark Williams <williams@redhat.com>
cc:     David Miller <davem@davemloft.net>,
        Sebastian Sewior <bigeasy@linutronix.de>, daniel@iogearbox.net,
        bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
In-Reply-To: <20191017214917.18911f58@tagon>
Message-ID: <alpine.DEB.2.21.1910181038130.1869@nanos.tec.linutronix.de>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de> <20191017145358.GA26267@pc-63.home> <20191017154021.ndza4la3hntk4d4o@linutronix.de> <20191017.132548.2120028117307856274.davem@davemloft.net> <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
 <20191017214917.18911f58@tagon>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Clark,

On Thu, 17 Oct 2019, Clark Williams wrote:
> On Thu, 17 Oct 2019 23:54:07 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> >   #2) BPF does allocations in atomic contexts, which is a dubious decision
> >       even for non RT. That's related to #1
> 
> I guess my question here is, are the allocations done on behalf of an about-to-run
> BPF program, or as a result of executing BPF code?  Is it something we might be able
> to satisfy from a pre-allocated pool rather than kmalloc()? Ok, I need to go dive
> into BPF a bit deeper.

Sebastion?
 
> >   #3) BPF uses the up_read_non_owner() hackery which was only invented to
> >       deal with already existing horrors and not meant to be proliferated.
> > 
> >       Yes, I know it's a existing facility ....
> 
> I'm sure I'll regret asking this, but why is up_read_non_owner() a horror? I mean,
> I get the fundamental wrongness of having someone that's not the owner of a semaphore
> performing an 'up' on it, but is there an RT-specific reason that it's bad? Is it
> totally a blocker for using BPF with RT or is it something we should fix over time?

RT has strict locker == unlocker semantics simply because the owner
(locker) is subject to priority inheritance and a non-owner unlock cannot
undo PI on behalf of the locker sanely. Also exposing the locker to PI if
the locker is not involved in unlocking is obviously a pointless exercise
and potentially a source of unbound priority inversion.

> I do think that we (RT) are going to have to co-exist with BPF, if only due to the
> increased use of XDP. I also think that other sub-systems will start to
> employ BPF for production purposes (as opposed to debug/analysis which is
> how we generally look at tracing, packet sniffing, etc.). I think we *have* to
> figure out how to co-exist.

I'm not saying that RT does not want BPF, quite the contrary, but for the
initial merge BPF is not a hard requirement, so disabling it was the
straight forward path.

I'm all ears to get pointers how to solve that right now.
 
Thanks,

	tglx
