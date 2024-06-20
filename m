Return-Path: <bpf+bounces-32614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C7F911158
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 20:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3719C281B36
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 18:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8580B1BB68C;
	Thu, 20 Jun 2024 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HRUVosr3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S2qeLCpe"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0DA1B3739;
	Thu, 20 Jun 2024 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909249; cv=none; b=arGT1zV406K7ql1ZZHEsutOFCNeB0sy5Xu+JvWgmxoTcEv2x505d1MmhvdpAzV2y19FgzxMjwhnNATiX0iYDrxOCSTQif9SGm+qIUI83hr1Q8GIGmY5G8Sizlk+Y12nr31otZcmRdRI1K4UHPUkKDoTCZbDuYkCYeoaotaxXZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909249; c=relaxed/simple;
	bh=xv72pM/CLkmNfQLX33OtZUmQooEWiIOgcs6NfeK07O8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=e6Ydp85vW/wy7Wa1mCLUMnTLTR7QZccy8260+Y8SLK9U1oMrj7ObixUbDfchW+eY91MZAXByal2f7R0TRxV2ujKqnBVBif9XPZ3i2MwEzu4Mrq33D/t/PuXEjxWrQxQoMvfa0ChQ8C2v1r9uULveCtBf/7eLs+qiYY4rc47R/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HRUVosr3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S2qeLCpe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718909244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=Vp38aipfo/voTVFIhOXTlwctks0QJYqmECO6qKad7xc=;
	b=HRUVosr3oDIhzz9qGE4X9+Qo7B2gAYw9ypoHpaaCDqkEaoMQH1EUF79GU/vBEhylglBOHP
	oQ/G4rtYAyiBUs4+dNfLra5BAoKnOD9BsJmYGAIwi9e1gvCh0S7o7zaOC+E/wra/1y9t7I
	t8vvEawzbw3PMJXDMHosmBllEG9KOcqwYIpeRaC45amNgQdNgoHGclaElAJuV015anuJ1r
	SCFvgHrlcNWEAyxdj1lmlnIK90xF+69ibSff+eIHZe3GTI49Wfsh0TA+z5NNHjz0tuGkH6
	Djz98u/zANJket7RPERR3Cit5PhS6g5IvGugFfjjns9cIreLpQlkOjZjw3kceA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718909244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=Vp38aipfo/voTVFIhOXTlwctks0QJYqmECO6qKad7xc=;
	b=S2qeLCpeq/AFjoVlVrdx8PkJimUSFdQ+hTgKu6edyq87/TVfxb4lZNjOzMX9Cu74+2vlj8
	/uM8V+55XFUflADw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 joshdon@google.com, brho@google.com, pjt@google.com, derkling@google.com,
 haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
 dskarlat@cs.cmu.edu, riel@surriel.com, changwoo@igalia.com,
 himadrics@inria.fr, memxor@gmail.com, andrea.righi@canonical.com,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
In-Reply-To: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
Date: Thu, 20 Jun 2024 20:47:23 +0200
Message-ID: <871q4rpi2s.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Linus!

On Wed, Jun 19 2024 at 22:07, Linus Torvalds wrote:
> On Wed, 19 Jun 2024 at 19:35, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> When I sat there in Richmond with the sched_ext people I gave them very
>> deep technical feedback especially on the way how they integrate it:
>>
>>   Sprinkle hooks and callbacks all over the place until it works by some
>>   definition of works.
>
> Are we even talking about the same thing?

Yes we do.

> But "sprinkle hooks and callbacks all over the place"?

There are too many places which add scx_***() invocations. That's what I
asked to be cleaned up and to be generalized so it becomes uniform over
the scheduler classes.

Sure one could argue that some of these calls are at places where some
other scheduling class dropped already one, but that's wrong because
accumulating bad code just creates more technical debt.

If cleaned up then the already existing hacks vanish into proper class
callbacks, which improves the existing code and allows to drop in sched
ext more naturally at the end.

One example I very explicitely mentioned back then is the dance around
fork().  It took me at least an hour last year to grok the convoluted
logic and it did not get any faster when I stared at it today again.

fork()
  sched_fork()
    scx_pre_fork()
      percpu_down_rwsem(&scx_fork_rwsem);

    if (dl_prio(p)) {
    	ret =3D -EINVAL;
        goto cancel; // required to release the semaphore
    }

  sched_cgroup_fork()
    return scx_fork();

  sched_post_fork()
    scx_post_fork()
      percpu_up_rwsem(&scx_fork_rwsem);

Plus the extra scx_cancel_fork() which releases the scx_fork_rwsem in
case that any call after sched_fork() fails.

My head still spins from deciphering this once more.

What has scx_fork() to do with sched_cgroup_fork()? It's completely
non-obvious and the lack of comments does not help either. The changelog is
handwaving at best.

scx_pre_fork() takes the semaphore unconditionally independent of the
scheduler class of the forking task and even in the case that no BPF
scheduler is loaded or active. Why? Neither the changelog nor the lack
of comments give any hint, which is also not a new complaint from me.

A proper cleanup would just eliminate the unconditional down(), the
dl_prio() cancel logic plus the whole if/elseif dance including the
#ifdef SCHED_EXT. It's not rocket science to come up with the obvious:

       ret =3D p->sched_class->pre_fork();
       if (ret)
       		return ret;

That's just proper engineering which is what some famous programmer
tells people to do for a very long time:

 "I=E2=80=99m a huge proponent of designing your code around the data, rath=
er
  than the other way around, ... I will, in fact, claim that the
  difference between a bad programmer and a good one is whether he
  considers his code or his data structures more important. Bad
  programmers worry about the code. Good programmers worry about data
  structures and their relationships."

And that's not only proper engineering it's also the other approach the
same famous programmer tells people to do:

 "I want them to lull me into a safe and cozy world where the stuff they
  are pushing is actually useful to mainline people _first_."

IOW, give me something which is useful to me _first_ so that you can add
your particular flavor of crazy on top without bothering me.

You obviously can complain now about the crazy people who actually listen
to what that famous programmer is saying. :)

But the above is not only true for that famous programmer personally,
that's equally true for any maintainer who has to deal with the result of a
submission for a long time.

I'm still not seeing the general mainline people benefit of all this, so I
have to trust you that there is one which is beyond my comprehension
skills.

That said, I'm more than wary about the hidden locking scheme of that
percpu semaphore in the fork path, but that's a different design
question to be debated on the way.

There are some other technical details which need to be sorted including
the interaction with other pending code, but that's something which can
be solved as we move forward.

Ideally this can be shaped in a way so that the scheduler becomes closer to
being modular, which would be the real useful thing for research and not
just the advertisment version of it.

But wait a moment, that can't happen as pluggable schedulers have been
rejected in the past:

  "I absolutely *detest* pluggable schedulers."

Guess which famous programmer said that.

> And scx_next_task_picked() isn't pretty - as far as I understand, it's
> because there's only a "class X picked" callback ("pick_next_task()"),
> and no way to tell other classes they weren't picked.
> Could things like that next_active_class() perhaps be done more
> prettily? I'm sure.

Well spotted.

> But I get the very strong feeling that people wanted to limit the
> amount of changes they made to the core scheduler code.

Which is exactly the point. If the existing code does not let your new
feature fall into place, then refactor it so it does. Working around the
short comings at some other place is patently wrong and that's not
something new either.

Requesting such refactoring is not an undue burden because the people who
maintain the code will have to deal with the result.

Unwrapping this stuff after the fact is the worst thing to do and I
definitely have an expert opinion on this.

None of this is rocket science and could have been done long ago even
without me holding hands.

>> I clearly offered you to try to resolve this amicably within a
>> reasonable time frame.
>>
>> How exaclty is that equivalent to "continue to do nothing" ?
>
> So if we actually *can* resolve this amicably in three months, then
> that sounds worth it.
>
> But my reaction is "what changed"? Nothing has become more amicable in
> the last nine months. What makes the next three months special?

The difference is:

  1) Peter is back and the capacity problem is less bad than it was

  2) As I explained before I unfortunately did not have cycles in the
     past _seven_ months, but I can make the cycles available now and
     drive this forward. That's possible when both sides are willing to
     cooperate. I'm sure there is enough incentive to do so.

  3) I'm going to focus on the integration and interaction aspect and
     grudgingly leave the cgroup trainwreck out of it.

     If someone from the crowd who caused it actually had the courtesy
     to mop this up, that would be a great signal for everyone and it
     can be done in parallel.

     Not that I'm holding my breath, but I'm still a hopeless optimist.

If you don't trust me on that, then we have a very different problem.

Thanks,

        Thomas

