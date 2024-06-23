Return-Path: <bpf+bounces-32841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1EF91398F
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 12:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107391C21258
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B3012C477;
	Sun, 23 Jun 2024 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gaz8XIRS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lk+N75qX"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E343D268;
	Sun, 23 Jun 2024 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719138817; cv=none; b=n8sD0IdcQKnztrPhAQtjPbgR/pUQfBUTLN/IQXzVcAmU/mwcA53dlQ0Ocxgq6hTfwyXLqhI64JZ3A1lmhxdTCkCaSRaGByLqmIHc0QQs/77Wu4i7JGgZbib1YES/GdDyIA+pSYq2cMlvtOgCCjZ3c8nOtsR6ID4OyBYz3YmHh3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719138817; c=relaxed/simple;
	bh=FKgb0Sm60csyqTrMtEIDjrtMC6/q8/CFi76z3MP1uI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ti6K/nd6vWKOrJC81RNww2N+2DoO7fs0NOKgvnkGt1b6jbeUmMB1MfWcbUQsKOjvgVlAL/KL5mDobLHeFMPhi7UapPc75jEy6ymh3re2O3/SAwSfVRc0RiZTampCw83v+aLoSMjcamTVZqb+eGuqwXkDU6kpmizoQU1CmvHK0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gaz8XIRS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lk+N75qX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719138814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=co03T6h7IE7aX6oWvJaMj3aNSpCybK0Ms+zqfGJvPyc=;
	b=Gaz8XIRSO8WysKDrAfhhBukhwif0dvqCLPpddyB7HoDkuqd/Ta/+cz2fbUNjtU+wZ1dPAv
	QuJACezoahTqAKLyqD4a22y4T4S9Eh7Ji62sjRiLzJjc2dctsoNqe/+fExf5CNN4owX2Jx
	jYbfLzUvBgXjm7I/IIiZHXRfAQkrhlyqi+IK+bh3YhXiffuW0LM9kAB031Jxs26c5cirH1
	DnK5aD4ygtcTz0Zse6tFa9WApeWPoz8zHOXLk6mUvRphpOnUMdIENd1ZCxq6mFGsYy9MNp
	VsCzAn5V5jSPuLDS5fUnddmHEToiF+Xi88DxMCJJAhFL+/QweumcWzeYZAPw1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719138814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=co03T6h7IE7aX6oWvJaMj3aNSpCybK0Ms+zqfGJvPyc=;
	b=lk+N75qXSbtOxt7oclNa2zWmr9agMZswySNJyzIPg4puqGhy74Hz1UR1XPii39bajYl/7p
	cvnye9P4IZekoMBw==
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
In-Reply-To: <CAHk-=wiRgsFsrnTR8XShrS_-aYS--4DSrRPmaWtYJ55-fmjznA@mail.gmail.com>
References: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <871q4rpi2s.ffs@tglx>
 <CAHk-=wgN6DRks55fsqiJYE3uV=_QTgzdxOvh1ZZNgm_YooKdYA@mail.gmail.com>
 <87v822ocy2.ffs@tglx>
 <CAHk-=wiRgsFsrnTR8XShrS_-aYS--4DSrRPmaWtYJ55-fmjznA@mail.gmail.com>
Date: Sun, 23 Jun 2024 12:33:33 +0200
Message-ID: <87zfrcx81u.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus!

On Fri, Jun 21 2024 at 09:34, Linus Torvalds wrote:
> On Fri, 21 Jun 2024 at 02:35, Thomas Gleixner <tglx@linutronix.de> wrote:
> And don't get me wrong - I'm not complaining about the RT patches. I
> think they improved things enormously in the end. They've been great.

Thanks!

> I'm just saying that they are _not_ the norm to compare against.

I'm not comparing them.

I was just pointing out that you repeatedly asked me whether the nasty
parts could stay out of tree forever, which I always found odd. But now in
the context of your out of tree lecture this question struck me even more
strange. Understandably, no?

> Anyway, what I'm saying is that you trying to equate this with the RT
> patches is absolutely laughable and intellectually dishonest.

See how communication between people fails?

I might have misinterpreted your question to keep RT out of tree and you
interpreted my answer as a comparison, which was not my intention at all.

If I want to compare another out of tree project with sched ext, then I
surely do not pick RT but DPDK. The network people rejected the DPDK
approach as they wanted to have things fixed and done in tree instead of
letting everyone create their own sand pit. It worked out as it made
people think and come up with XDP and other things which gives the
dataplane people a proper tool while having the general stuff work
nicely in the same context.

In other words, that forced people to really collaborate and sort it out
for the benefit of everyone. I might be missing something crucial, but I
fail to see the same benefit coming from sched ext.

Coming back to what you said in an earlier mail:

> And the "I detest pluggabnle schedulers" has been long superseded by
> "I detest people who complain about our one scheduler because they
> have special loads that only they care about".

I agree with that sentiment. I don't agree with the "solution".

The sad truth is that everyone involved admired the problem for a decade
and kept complaining in the one way or the other.

Google dropping out of scheduler development was not because of scheduler
people being hard to work with. Peter and Paul worked perfectly fine
together and the hierarchical cgroup scheduling muck was merged under the
premise "We work it out in tree". It just never happened because the people
who added it vanished in a black hole for reasons which have nothing to do
with the kernel scheduler community.

At last years OSPM everyone in the room, including the sched ext folks,
agreed that the main problem is that the scheduler does not have enough
information about the requirements and properties of applications, which is
not a Facebook/Google specific thing. That applies to all sorts of problems
including power, thermal and capacity constraints.

That's nothing new. The academic scheduler research identified that in the
late 90s already and came up with specific solutions to prove their
point. That effort fell short to be generalized.

So sched_ext does exactly this by putting requirements and properties of
workloads into the BPF scheduler and the related user space portion.

I completely agree that this is a nice tool for doing research to identify
what needs to be done to make this a generalized approach.

I disagree that providing it as an official workaround will result in more
collaboration and a better result for everyone in the very end. Quite the
contrary it is going to foster fragmentation way beyond the Google/Facebook
space.

The whole notion of 'my workload is so special and therefore we need
special sauce' is a strawman. We've debunked a lot of 'my thing is so
special' claims over the years by making people sit down and come up with
generalized solutions for the benefit of everyone.

I'm not saying we debunked all. Some of them failed because people refused
to work it out and opted for keeping their stuff out of tree forever. But
in the vast majority of cases it worked out pretty well.

I recently watched a talk about sched ext which explained how to model an
execution pipeline for a specific workload to optimize the scheduling of
the involved threads and how innovative that is. I really had a good laugh
because that's called explicit plan scheduling and has been described and
implemented in the early 2000s by academics already.

Innovative or not, that's not the point. The point is that none of this
resulted in the promised feed back to the scheduler proper. As this runs in
production already, it would have been a great talk at OSPM24 to follow up
on the 'requirements and properties' discussion to at least provide the
insights of this in the form of data to work from.

That's one of the reasons why I said:

> I'm still not seeing the general mainline people benefit of all this, so
> I have to trust you that there is one which is beyond my comprehension
> skills.

I can see your benefit that the detesting complaining will stop, but I fail
to map that into a general benefit for everyone else. Some enlightment
would be appreciated.

Thanks,

	tglx






