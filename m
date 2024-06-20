Return-Path: <bpf+bounces-32553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF62790FB57
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 04:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D750F1C210AB
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 02:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005171C680;
	Thu, 20 Jun 2024 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0rckpCxY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HoNGtmvp"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40481BF2A;
	Thu, 20 Jun 2024 02:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718850913; cv=none; b=sq6eSfMs5FBIT4SF4QsJzYhvnQduENsXq/CE8zTnYrTAlQsBFMCP6JB+1f8s2YxQCVKzBFUHElujBoxS9mhAcZC1rkd4quPA0cmH/eerayfGYMmUtuMZqf5lJvc4GPTlhpreYeh3Q6Df57R9UQb7M9CzTBNAWlqZkgeI4IW9Vw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718850913; c=relaxed/simple;
	bh=ka1mwYAvq0PwS/sKID5VbbxjlX+VdxxBbwPJ5FbVoDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N9OUS9A0tA/abjBnwaehfFWcZnLUw9I/3fFvG/7tJtQFLHK3wzy80V30qpv6KHxTseeh2eYBoud0jQ2B9E5Pp8LFLe8mK986LQmDFRVkJhPqd2OHPVTVfPCjLovBwpTtpDjXLPUc83I3PuMe8hPEia9xW1avbBlEV6F24Dl2xjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0rckpCxY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HoNGtmvp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718850909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=axeyVbmO6dC32aFs8QawmlttuapwPRGG6pRetfHXgJ0=;
	b=0rckpCxYLDM22VfvDhzZ8eqNv6HJjdfvB4WsQezJ/kvzSPgh6qRNlvYolQOLSTzKtbpqlK
	hZHvt2v5GWTFMrehUGWu75Ga3leYJBwMlnYZ4OgJ3eBILE4bqpr9jZJhuvsD+RywUMil5m
	acJ0HbwNP7QA1L1DltaB47fEmS21yxaMc1CXcXdZU9eDVzG4ATliwebnV9/hgueY6/bEPV
	44p2BCbZ8C0RihE1sgqQo5e+7vOv2C2ovqWRDgrdAzJAAUHyZevHqO/Wcfuknzwjv1Uk9i
	L6FkNZmwlsjzojM+SlFinh68mrw1yRkOA2moEH+9vkrvOTKijHVfEFTNnRvt9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718850909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=axeyVbmO6dC32aFs8QawmlttuapwPRGG6pRetfHXgJ0=;
	b=HoNGtmvpRa5rfJJ17WRmKWXeiMGESxwDgS9O0Mj5xDDQJKwIQm45S+djwyG8WWBbWSW+KS
	0N97p1NwXuhwP/Bw==
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
In-Reply-To: <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
Date: Thu, 20 Jun 2024 04:35:08 +0200
Message-ID: <878qz0pcir.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus!

On Wed, Jun 19 2024 at 15:55, Linus Torvalds wrote:
> On Wed, 19 Jun 2024 at 15:27, Thomas Gleixner <tglx@linutronix.de> wrote:
>> Right, but that applies to both sides, no?
>
> But Thomas, this isn't a "both sides" issue.

It is whether you like it or not.

I clearly gave the sched_ext people deep technical feedback on the way
how they integrated this seven months ago in Richmond.

I sat down with them because _you_ asked me explicitely for it as _you_
did not want to deal with it.

That feedback got ignored completely. Thank you very much for wasting
_my_ time.

> This is a "people want to do new code and features, and the scheduler
> people ARE ACTIVELY HOLDING IT UP" issue.
>
> Yes, part of that "actively holding it up" is trying to make rules for
> "you need to do this other XYZ thing to make us happy".
>
> But no, then "not doing XYZ" does *NOT* make it some "but but other side" issue.
>
> This, btw, is not some new thing. It's something that has been
> discussed multiple times over the years at the maintainer summit for
> different maintainers. When people come in and propose feature X, it's
> not kosher to then say "you have to do Y first".

Seriously? You yourself requested this from me more than once in the
past 20 years. But let's not go there.

> And yes, maybe everybody even agrees that Y would be a good thing, and
> yes, wouldn't it be lovely if somebody did it. But the people who
> wanted X didn't care about Y, and trying to get Y done by then gating
> X is simply not ok.

I very well remember the discussions about fix X first before Y.

But you are completely ignoring the fact that in this case

    - problem X got introduced by the very same people who are now
      pushing for Y

    - the resolution to problem X was not rejected by the scheduler
      people at all

      It stayed unresolved because the very same parties which are now
      so cosily working together on Y (aka sched_ext0 could not agree on
      anything

      So the mess they created in the first place stays as is and both
      parties "solved" their problem with Y (aka sched_ext) and have
      their own implementations to work around it how they see fit.

IOW, what you are saying is:

    #1 Push for your solution X and get it merged

    #2 Ignore the resulting problems related to X for at least a decade

    #3 Come up with a half baken workaround Y to be able to deal with #2
       and leave everyone else behind to deal with the results of #1 and
       #2

    #4 Make Linus decide that Y is the right thing to do because other
       people suck

The past discussions about fix "X" before "Y" were distinctly different.

> Now, if there was some technical argument against X itself, that would
> be one thing. But the arguments I've heard have basically fallen into
> two camps: the political one ("We don't want to do X because we simply
> don't want an extensible scheduler, because we want people to work on
> _our_ scheduler") and the tying one ("X is ok but we want Y solved
> first").

There have been voiced a lot of technical arguments, which never got
addressed and at some point people gave up due to being ignored.

When I sat there in Richmond with the sched_ext people I gave them very
deep technical feedback especially on the way how they integrate it:

  Sprinkle hooks and callbacks all over the place until it works by some
  definition of works.

That's perfectly fine for a PoC, but not for something which gets merged
into the core of an OS. I clearly asked them to refactor the existing
code so that these warts go away and everything is contained into the
scheduler classes and at the very end sched_ext falls into place. That's
a basic engineering principle as far as I know.

They nodded, ignored my feedback and just continued to persue their way.

Are you still claiming with a straight face that this is a problem
rooted in one party?

It's a problem of one interest group to get this into the tree no matter
what.

I sat in the room at OSPM 2023 when the introduction of the sched ext
advertisement started with "This saves us (FB) millions and Google is
collaborating with us [unspoken - to save millions too by eliminating
their unmaintainable scheduler hacks]', which is clearly a technical
argument, right?

> I was hoping the tying argument would get solved. I saw a couple of
> half-hearted emails to that effect, and Rik at some point saying
> "maybe the problems are solvable", referring to his work from a couple
> of years ago, but again, nothing actually happened.

See above. It's not a problem of the scheduler people.

It's a problem created by the very same people who refuse to solve it
and at the same time push for their new magic cure.

> And I don't see the argument that the way to make something happen is
> to continue to do nothing.

I clearly offered you to try to resolve this amicably within a
reasonable time frame.

How exaclty is that equivalent to "continue to do nothing" ?

> Because if you are serious about making forward progress *with* the
> BPF extensions, why not merge them and actually work with that as the
> base?

There is a very simple argument to this:

   - The way how it is integrated sucks in a big way on purely technical
     grounds. If you want details, I'm happy to reiterate them again in
     a separate mail just in case you can't find them in your inbox or
     can't remember what I told you seven month ago.

   - This got pointed out by myself seven months ago to the sched_ext
     people

   - They sat with me at the table and nodded

   - Then they went off and ignored it for seven months and just added
     more warts.

Now you are asking me seriously why I don't want to see this merged in
the technical state which it is in right now?

Are you seriously expecting that this is resolved amicably just by
forcing this into the tree on the obvious expense of the people who were
working on the existing code for decades?

That aside, your whole argument about the so "very high" participation
barrier on the scheduler is just based on hearsay and not on facts,
which you could easily have gathered yourself. Let me do your homework.

In the past five years there have been:

   ~4000 mail (patch) threads related to scheduler issues
   ~1600 commits (i.e. 1.6 commits per work day on average)
    ~300 different authors

300 different authors is clearly not a sign of a problematic community
neither is the ratio of commits to mail threads is 1:2.5.

The fact tell clearly that this is a healthy community and not a sign of
a participation barrier problem.

The fact, that the contributions and contribution attempts from the
proponents of sched_ext are close to zero cannot be abused to claim that
there is a high bar to get patches into the scheduler subsystem.

If you don't try in the first place then you can't complain about it,
no?

Just for the record, the scheduler people and myself spent a lot of time
to help to get intrusive features like UMCG into mainline, but the
efforts were dropped by the submitters for no reason. Short time after
that sched_ext came around.

Can we please agree that the root of this has left the technical grounds
long ago?

If you think that the correct non-technical solution is to resolve this
brute force without giving those who are willing to work this out in the
proper way a completely irrelevant delay of three month, then I really
have to ask you what you are trying to achive.

If you pull that stuff as is then you create a patently bad precedent
and on top of that you slap everyone who worked and works
collaboratively and constructively with maintainers and the wider
community to get their features merged straight into their face.

You are obviously free to do so, but then please clearly state that this
is the new world order by merging an unreviewed patch against
Documentation/process/* which makes this as a general rule applicable
for everyone.

We've been there and done that during the 2.5 period and it took us
years to recover from it, but maybe you have forgotten about that
because you merely had to merge the fixes which were created by people
who cared and lost their sleep over the mess.

Whatever the outcome is, we definitely have to have a major discussion
about the underlying problem at the maintainer summit whether you like
it or not.

That said, my offer stands to work on an amicable and collaborative
solution for this nuisance, but that's obviously all I can do.

Up to you.

Thanks,

        Thomas

