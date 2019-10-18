Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A34DC3F6
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 13:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442564AbfJRL2b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 07:28:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56541 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389257AbfJRL2b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 07:28:31 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iLQQg-0005w0-Q6; Fri, 18 Oct 2019 13:28:22 +0200
Date:   Fri, 18 Oct 2019 13:28:21 +0200 (CEST)
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
In-Reply-To: <20191018055222.cwx5dmj6pppqzcpc@ast-mbp>
Message-ID: <alpine.DEB.2.21.1910181256120.1869@nanos.tec.linutronix.de>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de> <20191017145358.GA26267@pc-63.home> <20191017154021.ndza4la3hntk4d4o@linutronix.de> <20191017.132548.2120028117307856274.davem@davemloft.net> <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
 <CAADnVQJPJubTx0TxcXnbCfavcQDZeu8VTnYYpa8JYpWw9Ze4qg@mail.gmail.com> <alpine.DEB.2.21.1910180152110.1869@nanos.tec.linutronix.de> <20191018055222.cwx5dmj6pppqzcpc@ast-mbp>
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

Alexei,

On Thu, 17 Oct 2019, Alexei Starovoitov wrote:
> On Fri, Oct 18, 2019 at 02:22:40AM +0200, Thomas Gleixner wrote:
> > 
> > But that also means any code which explcitely disables preemption or
> > interrupts without taking a spin/rw lock can trigger the following issues:
> > 
> >   - Calling into code which requires to be preemtible/sleepable on RT
> >     results in a might sleep splat.
> > 
> >   - Has in RT terms potentially unbound or undesired runtime length without
> >     any chance for the scheduler to control it.
> 
> Much appreciate the explanation. Few more questions:
> There is a ton of kernel code that does preempt_disable()
> and proceeds to do per-cpu things. How is it handled in RT?

There is not really tons of it, at least not tons which actually hurt. Most
of those sections are extremly small or actually required even on RT
(e.g. scheduler, lock internals ...)

> Are you saying that every preempt_disable has to be paired with some lock?
> I don't think it's a practical requirement for fulfill, so I probably
> misunderstood something.

See above. The ones RT cares about are:

    - Long and potentially unbound preempt/interrupt disabled sections

    - Preempt disabled sections which call into code which might sleep
      under RT due to the magic 'sleeping' spin/rw_locks which we use
      as substitution.

> In BPF we disable preemption because of per-cpu maps and per-cpu data structures
> that are shared between bpf program execution and kernel execution.
> 
> BPF doesn't call into code that might sleep.

Sure, not if you look at it from the mainline perspective. RT changes the
picture there because due to forced interrupt/soft interrupt threading and
the lock substitution 'innocent' code becomes sleepable. That's especially
true for the memory allocators, which are required to be called with
preemption enabled on RT. But again, most GFP_ATOMIC allocations happen
from within spin/rwlock held sections, which are already made preemptible
by RT magically. The ones which were inside of contexts which are atomic
even on RT have been moved out of the atomic sections already (except for
the BPF ones).

The problem with standalone preempt_disable() and local_irq_disable() is
that the protection scope is not defined. These two are basically per CPU
big kernel locks. We all know how well the BKL semantics worked :)

One of the mechanisms RT uses to substitute standalone preempt_disable()
and local_irq_disable() which are not related to a lock operation with so
called local_locks. We haven't submitted the local_lock code yet, but that
might be a way out. The way it works is simple:

DEFINE_LOCAL_LOCK(this_scope);

in the code:

-	preempt_disable();
+	local_lock(this_scope);

and all kind of variants local_lock_bh/irq/irqsave(). You get the idea.

On a non RT enabled build these primitives just resolve to
preempt_disable(), local_bh_disable(), local_irq_disable() and
local_irq_save().

On RT the local lock is actually a per CPU lock which allows nesting. i.e.

      preempt_disable();
      ...
      local_irq_disable();

becomes

	local_lock(this_scope);
	...
	local_lock_irq(this_scope);

The local lock is a 'sleeping' spinlock on RT (PI support) and as any other
RT substituted lock it also ensures that the task cannot be migrated when
it is held, which makes per cpu assumptions work - the kernel has lots of
them. :)

That works as long as the scope is well defined and clear. It does not work
when preempt_disable() or any of the other scopeless protections is used to
protect random (unidentifiable) code against each other, which means the
protection has the dreaded per CPU BKL semantics, i.e. undefined.

One nice thing about local_lock even aside of RT is that it annotates the
code in terms of protection scope which actually gives you also lockdep
coverage. We found already a few bugs that way in the past, where data was
protected with preempt_disable() when the code was introduced and later
access from interrupt code was added without anyone noticing for years....

> BPF also doesn't have unbound runtime.
> So two above issues are actually non-issues.

That'd be nice :)

Anyway, we'll have a look whether this can be solved with local locks which
would be nice, but that still does not solve the issue with the non_owner
release of the rwsem.

Thanks,

	tglx
