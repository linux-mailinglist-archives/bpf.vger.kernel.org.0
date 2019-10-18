Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6235FDBAC5
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 02:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfJRAW5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 20:22:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54930 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbfJRAW5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 20:22:57 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iLG2T-0000ki-Ui; Fri, 18 Oct 2019 02:22:42 +0200
Date:   Fri, 18 Oct 2019 02:22:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
cc:     David Miller <davem@davemloft.net>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
In-Reply-To: <CAADnVQJPJubTx0TxcXnbCfavcQDZeu8VTnYYpa8JYpWw9Ze4qg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910180152110.1869@nanos.tec.linutronix.de>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de> <20191017145358.GA26267@pc-63.home> <20191017154021.ndza4la3hntk4d4o@linutronix.de> <20191017.132548.2120028117307856274.davem@davemloft.net> <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
 <CAADnVQJPJubTx0TxcXnbCfavcQDZeu8VTnYYpa8JYpWw9Ze4qg@mail.gmail.com>
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

On Thu, 17 Oct 2019, Alexei Starovoitov wrote:
> On Thu, Oct 17, 2019 at 2:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > I'm all ears for an alternative solution. Here are the pain points:
> 
> Let's talk about them one by one.
> 
> >   #1) BPF disables preemption unconditionally with no way to do a proper RT
> >       substitution like most other infrastructure in the kernel provides
> >       via spinlocks or other locking primitives.
> 
> Kernel has a ton of code that disables preemption.
> Why BPF is somehow special?
> Are you saying RT kernel doesn't disable preemption at all?
> I'm complete noob in RT.

The basic principle of RT is to break up the arbitrary long
preemption/interrupt disabled sections of the mainline kernel.

Most preempt/interrupt disabled sections are implicit by taking locks
(spinlock, rwlock). Just a few are explicit by issuing
preempt/local_irq_disable()

RT substitutes spinlock/rwlock with RT aware counterparts which

 - Do not disable preemption/interrupts

 - Prevent migration to keep the implicit migrate disable semantics
   of preempt disable

 - Convert the underlying lock primitive to a priority inheritance aware
   mechanism, aka. rtmutex.

In order to make the above work, RT forces interrupt and soft interrupt
processing into thread context except for interrupts which are explicitely
marked as interrupt safe (IRQF_NOTHREAD).

As a consequence most of the kernel code becomes fully preemptible. Of
course there are still code parts which require that preemption/interrupts
are hard disabled. That's pretty much initial low level entry code, hard
interrupt handling code (which just wakes up the threads), context switch
code and some other rather low level functions (vmenter/exit ....).

That also requires that we have still locks which disable
preemption/interrupts. That's why we have raw_spinlock and
spinlock. spinlock is substituted with a RT primitive while raw_spinlock
behaves like the traditional spinlock on a non RT kernel (disables
preemption/interrupts).

But that also means any code which explcitely disables preemption or
interrupts without taking a spin/rw lock can trigger the following issues:

  - Calling into code which requires to be preemtible/sleepable on RT
    results in a might sleep splat.

  - Has in RT terms potentially unbound or undesired runtime length without
    any chance for the scheduler to control it.

Aside of that RT has a more strict view vs. lock ownership because almost
all lock primitives except real counting semaphores are substituted by
priority inheritance aware counterparts. PI aware locks have not only the
requirement that they can only be taken in preemptible context (see above),
they also have a strict locker == unlocker requirement for obvious reasons.
up_read_non_owner() can't obviously fulfil that requirement.

I surely answered more than your initial question and probably not enough,
so feel free to ask for clarification.

Thanks for caring!

       Thomas


