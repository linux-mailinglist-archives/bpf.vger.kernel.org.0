Return-Path: <bpf+bounces-32837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4B29138F7
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 10:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9880728244E
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 08:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAB36F2F2;
	Sun, 23 Jun 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x2GEyvIU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rB/AELsI"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BED10A0C;
	Sun, 23 Jun 2024 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719130501; cv=none; b=T2eXzu3Uuap1MAVpPH1Jkyi8RXgLw+JAKi4AC3G447QMaut+fGWLVFqTOq6lENeeATWM8kqQoEd7f6c7MfXef6kdzsJdT1gAuE+D4OJTN5YHcTCnyxmsdoN/xJpH0M2xw5qUbtpwgIK9U63mMPIRgrJulMMuzI3PB7X8g+LLOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719130501; c=relaxed/simple;
	bh=UiiF/SQvjM3wSxNwq6sidqKXgAho7/A4yBOnz0Slotk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ESKvuXEMyLdbG5O2NPEYuAu5ME40BdUmOkhEl5uIkQTStyrl7fcpgsVgj65quTdzxHajlhVOCgs2NobY0QyGL1Q5ScXOx5oBhIROIajaClEDSoe7PY1bLZZtR6i2khALmDXwfBzlltR4OXptc1Z9Hhx8dxmA1pX3Uya6QLIyJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x2GEyvIU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rB/AELsI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719130496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo8NTmvHXHfIffMG5bHyk+c4Z7Aq7L+9Znqy4meJ6j0=;
	b=x2GEyvIUAr47gJ+8zeyKkCcQgPXBU9mM5Z/Pq+r++HvKShhdntcYWcqfdQ95ijKgevt+6Z
	0c0CTZZipLxKrabHR0ALX4GOP1ciwz5FrqtK3+3UBce+EfLgVx2iYTyf7Spk2TdJ+t8a9t
	+7qklXNp9BGCGNgMoA9A1Nqa+iihjJxmWu6tWe8ZIEA48C6IZYNg11lf0wibQYKDYMsB8y
	yWtFXbThYQfOJAThszQA93s4SGDrN7+zOgizKkQvWD+GJr8Bxb0+548Zjsx948PuYEfgTO
	zDbv5xnoSZNq9lyA50XI/5ldLZZugIeyC5u64mgmzY+kAzdUFybyoPjh2qlBfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719130496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo8NTmvHXHfIffMG5bHyk+c4Z7Aq7L+9Znqy4meJ6j0=;
	b=rB/AELsIY7hQ5jGNyS4kpDhT+9rmnyfexN3C6g7Kt62fGmmiRA9SqkP0SmriaVflyuCJdU
	AaO7dwMm5GWAFsCw==
To: Chris Mason <clm@meta.com>, Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
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
In-Reply-To: <364ed9fa-e614-4994-8dd3-48b1d8887712@meta.com>
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx> <ZnSEeO8MHIQRJyt1@slm.duckdns.org>
 <87r0cqo9p0.ffs@tglx> <364ed9fa-e614-4994-8dd3-48b1d8887712@meta.com>
Date: Sun, 23 Jun 2024 10:14:55 +0200
Message-ID: <878qywyt1c.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris!

On Fri, Jun 21 2024 at 17:14, Chris Mason wrote:
> On 6/21/24 6:46 AM, Thomas Gleixner wrote:
> I'll be honest, the only clear and consistent communication we've gotten
> about sched_ext was "no, please go away".  You certainly did engage with
> face to face discussions, but at the end of the day/week/month the
> overall message didn't change.

The only time _I_ really told you "go away" was at OSPM 2023 when you
approached everyone in the worst possible way. I surely did not even say
"please" back then.

The message people (not only me) perceived was:

  "The scheduler sucks, sched_ext solves the problems, saves us millions
   and Google is happy to work with us [after dropping upstream scheduler
   development a decade ago and leaving the opens for others to mop up]."

followed by:

  "You should take it, as it will bring in fresh people to work on the
   scheduler due to the lower entry barrier [because kernel hacking sucks].
   This will result in great new ideas which will be contributed back to
   the scheduler proper."

That was a really brilliant marketing stunt and I told you so very bluntly.

It was presumably not your intention, but that's the problem of
communication between people. Though I haven't seen an useful attempt to
cure that.

After that clash, the room got into a lively technical discussion about the
real underlying problem, i.e. that a big part of scheduling issues comes
from the fact, that there is not enough information about the requirements
and properties of an application available. Even you agreed with that, if I
remember correctly.

sched_ext does not solve that problem. It just works around it by putting
the requirements and properties of an application into the BPF scheduler
and the user space portion of it. That works well in a controlled
environment like yours, but it does not even remotely help to solve the
underlying general problems. You acknowlegded that and told: But we don't
have it today, though sched_ext is ready and will help with that.

The concern that sched_ext will reduce the incentive to work on the
scheduler proper is not completely unfounded and I've yet to see the
slightest evidence which proves the contrary.

Don't tell me that this is impossible because sched_ext is not yet
upstream. It's used in production successfully as you said, so there
clearly must be something to learn from which could be shared at least in
form of data. OSPM24 would have been a great place for that especially as
the requirements and properties discussion was continued there with a plan.

At all other occasions, I sat down with people and discussed at a technical
level, but also clearly asked to resolve the social rift which all of this
created.

I thereby surely said several times: "I wish it would just go away and stay
out of tree", but that's a very different message, no?

Quite some of the questions and concerns I voiced, which got also voiced by
others on the list, have not been sorted out until today. Just to name a
few from the top of my head:

    - How is this supposed to work with different applications requiring
      different sched_ext schedulers?

    - How are distros/users supposed to handle this especially when
      applications start to come with their own optimized schedulers?

    - What's the documented rule for dealing with bugs and regressions on a
      system where sched_ext is active?

"We'll work it out in tree" is not an answer to that. Ignoring it and let
the rest of the world deal with the fallout is not a really good answer
either.

I'm not saying that this is all your and the sched_ext peoples fault, the
other side was not always constructive either. Neither did it help that I
had to drop the ball.

For me, Linus telling that he will merge it no matter what, was a wakeup
call to all involved parties. One side reached out with a clear message to
sort this out amicably and not making the situation worse.

> At any rate, I think sched_ext has a good path forward, and I know we'll
> keep working together however we can.

Carefully avoiding the perception trap, may I politely ask what this is
supposed to tell me?

Thanks,

	tglx

