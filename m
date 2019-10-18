Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0E2DBCC0
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 07:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389797AbfJRFOl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 18 Oct 2019 01:14:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbfJRFOk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 01:14:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E93303090FEE;
        Fri, 18 Oct 2019 02:49:21 +0000 (UTC)
Received: from tagon (ovpn-122-32.rdu2.redhat.com [10.10.122.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00BB75F7C0;
        Fri, 18 Oct 2019 02:49:19 +0000 (UTC)
Date:   Thu, 17 Oct 2019 21:49:17 -0500
From:   Clark Williams <williams@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Miller <davem@davemloft.net>,
        Sebastian Sewior <bigeasy@linutronix.de>, daniel@iogearbox.net,
        bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
Message-ID: <20191017214917.18911f58@tagon>
In-Reply-To: <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de>
        <20191017145358.GA26267@pc-63.home>
        <20191017154021.ndza4la3hntk4d4o@linutronix.de>
        <20191017.132548.2120028117307856274.davem@davemloft.net>
        <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
Organization: Red Hat, Inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 18 Oct 2019 02:49:22 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

+acme

On Thu, 17 Oct 2019 23:54:07 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 17 Oct 2019, David Miller wrote:
> 
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Date: Thu, 17 Oct 2019 17:40:21 +0200
> >   
> > > On 2019-10-17 16:53:58 [+0200], Daniel Borkmann wrote:  
> > >> On Thu, Oct 17, 2019 at 11:05:01AM +0200, Sebastian Andrzej Siewior wrote:  
> > >> > Disable BPF on PREEMPT_RT because
> > >> > - it allocates and frees memory in atomic context
> > >> > - it uses up_read_non_owner()
> > >> > - BPF_PROG_RUN() expects to be invoked in non-preemptible context  
> > >> 
> > >> For the latter you'd also need to disable seccomp-BPF and everything
> > >> cBPF related as they are /all/ invoked via BPF_PROG_RUN() ...  
> > > 
> > > I looked at tracing and it depended on BPF_SYSCALL so I assumed they all
> > > do… Now looking for BPF_PROG_RUN() there is PPP_FILTER,
> > > NET_TEAM_MODE_LOADBALANCE and probably more.  I didn't find a symbol for
> > > seccomp-BPF. 
> > > Would it make sense to override BPF_PROG_RUN() and make each caller fail
> > > instead? Other recommendations?  
> > 
> > I hope you understand that basically you are disabling any packet sniffing
> > on the system with this patch you are proposing.
> > 
> > This means no tcpdump, not wireshark, etc.  They will all become
> > non-functional.
> > 
> > Turning off BPF just because PREEMPT_RT is enabled is a non-starter it is
> > absolutely essential functionality for a Linux system at this point.  
> 
> I'm all ears for an alternative solution. Here are the pain points:
> 
>   #1) BPF disables preemption unconditionally with no way to do a proper RT
>       substitution like most other infrastructure in the kernel provides
>       via spinlocks or other locking primitives.

As I understand it, BPF programs cannot loop and are limited to 4096 instructions.
Has anyone done any timing to see just how much having preemption off while a
BPF program executes is going to affect us? Are we talking 1us or 50us? or longer?
I wonder if there's some instrumentation we could use to determine the maximum time
spent running a BPF program. Maybe some perf mojo...

> 
>   #2) BPF does allocations in atomic contexts, which is a dubious decision
>       even for non RT. That's related to #1

I guess my question here is, are the allocations done on behalf of an about-to-run
BPF program, or as a result of executing BPF code?  Is it something we might be able
to satisfy from a pre-allocated pool rather than kmalloc()? Ok, I need to go dive
into BPF a bit deeper.

> 
>   #3) BPF uses the up_read_non_owner() hackery which was only invented to
>       deal with already existing horrors and not meant to be proliferated.
> 
>       Yes, I know it's a existing facility ....

I'm sure I'll regret asking this, but why is up_read_non_owner() a horror? I mean,
I get the fundamental wrongness of having someone that's not the owner of a semaphore
performing an 'up' on it, but is there an RT-specific reason that it's bad? Is it
totally a blocker for using BPF with RT or is it something we should fix over time?

> 
> TBH, I have no idea how to deal with those things. So the only way forward
> for RT right now is to disable the whole thing.
> 
> Clark might have some insight from the product side for you how much that
> impacts usability.
> 
> Thanks,
> 
> 	tglx


Clark is only just starting his journey with BPF, so not an expert.

I do think that we (RT) are going to have to co-exist with BPF, if only due to the
increased use of XDP. I also think that other sub-systems will start to
employ BPF for production purposes (as opposed to debug/analysis which is
how we generally look at tracing, packet sniffing, etc.). I think we *have* to
figure out how to co-exist. 

Guess my "hey, that look interesting, think I'll leisurely read up on it" just got
a little less leisurely. I'm out most of the day tomorrow but I'll catch up on email
over the weekend.


Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
