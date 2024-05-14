Return-Path: <bpf+bounces-29681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C5F8C4A55
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 02:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857981F21AA9
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 00:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226A87F8;
	Tue, 14 May 2024 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="BKXieJdp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E85737B
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 00:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715645242; cv=none; b=A6IVX6lLTjdDRv20YGWTf1ZZetxVOsJBbZTePLqdtyhwd1mW8SKqwCXWEOYoSr0YPLNmQOd6VXd1/n+yNtiZzAnE6M+0YLNdXuIQlMtwiNHgSEwWbMAWTI1HCiMMn758eAzh4cUdYNAuyxKFTfyGqz/fhHHXGZEgS/NVbBmGBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715645242; c=relaxed/simple;
	bh=9fuyaWdoWsUnb39lg1ASeTub/9uhj2XdPKUxDBuWnJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fD6+AlF2Ax4RfbOvVk388sUs/wyZUdN/Rgdd4C6WNodlaM0dA7zDhy74JXVRAFRMpc+UbQYOrrHljTf7M5Yz9DWsYXK/tbVQlEvmNK8KmQYCMBEAngqLLV3os8NGug4sWoeVvkNR7wOdNOKUbllB+8PupCdPtTjkEVAXAS5NqbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=BKXieJdp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4200ee47de7so18267355e9.2
        for <bpf@vger.kernel.org>; Mon, 13 May 2024 17:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715645239; x=1716250039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a0eU3NqGDNLbCoVdJoz+1meora358TepvHy5sboXoAc=;
        b=BKXieJdpDRaQ06NSG15s2PtTO9IXZEbrUwT+bgPrGZb6NKDsnKxdRpzz2eFLAm3LF+
         BMAy0u8nVGL3gZmuZ5qUnJ0c6SWkTAhnmlu3XjLdW8YcNfiEM/hhtvkOvkES9uWr04hU
         0ZikDO81I0bUevg8yiFO6S6iZt7uVqjt42XU0SVMg7ypPsmfE8q6X+fSAy+9DbYG997J
         vTBfTIkhJraqg3SqwLOuTGwV932rmd7LVtX0KTNm+DZAlAJGJy30PcMAjPLLxG3xSHSE
         17dnJW7gCilkLWlXTpy0OG1jHH9MUf1kagLzfNpyyoe60GHZqK1MfG6RJrkV0ZIXNWcu
         VayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715645239; x=1716250039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0eU3NqGDNLbCoVdJoz+1meora358TepvHy5sboXoAc=;
        b=QhWIwY+JVZ1z5cDEvHzGAe6y2CldZAbTbEa1YvdfHH6oIUwrBjOLY5UmaHNA4Ecxdq
         n/AEnlvGf+odOH68ZKcqCD7ardxndwlQrClechHyyOtjK6OaYeHg2PhyVpyMq4/3wZ5G
         lqgWO/X0jHJxJ8akxSQf1RxzLaZ3EEHHzgC6P9KelHRC5aVHsgMN2L3HqcvyZqdXRRPk
         LDBCT2O+rmS+OtAOYEOt9cKTXf9DHpDIi0YHLoH6utxNACtFQ17Nm46ztcGK1OS7LeTk
         N4QZLDSA0rpTjjkylFDBmibIhtN9PDZwZw7iRVwbLVYJUjOCO8zJaueR5/jFYekLpZQn
         NRKA==
X-Forwarded-Encrypted: i=1; AJvYcCXrjknh2PIhbVwiitKceOafVQ1mX+NvcunW7elSlox0iUXJtJvXAwt+9USy/i+t6mxcKRGsaq0Vd8ledfPVaaXGiFB/
X-Gm-Message-State: AOJu0Yxj8H1niO6Vt/fTRbgB12QJxEw45ZNAh6EEZAhyemJ0TS2ebsoy
	LKtTKBYUO+BlItY4CI1FUB60yA7ORb4sptUdkHzK7IbVE7XyRIgzQ/iWaYnKdls=
X-Google-Smtp-Source: AGHT+IGi3AnqmI7YSRvyBBFoDUACHshmp8TA9I9qm6edK45qdE4LdjhGM1uj9HE22bDLemk0E6CN7g==
X-Received: by 2002:a05:600c:4589:b0:420:1fa6:a3ee with SMTP id 5b1f17b1804b1-4201fa6a619mr2017625e9.27.1715645238537;
        Mon, 13 May 2024 17:07:18 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42013b4e9aesm66743835e9.40.2024.05.13.17.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 17:07:17 -0700 (PDT)
Date: Tue, 14 May 2024 01:07:15 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	torvalds@linux-foundation.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <20240514000715.4765jfpwi5ovlizj@airbuntu>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <ZjgWzhruwo8euPC0@slm.duckdns.org>
 <20240513080359.GI30852@noisy.programming.kicks-ass.net>
 <20240513142646.4dc5484d@rorschach.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240513142646.4dc5484d@rorschach.local.home>

On 05/13/24 14:26, Steven Rostedt wrote:
> On Mon, 13 May 2024 10:03:59 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > I believe we agree that we want more people contributing to the scheduling
> > > area.   
> > 
> > I think therein lies the rub -- contribution. If we were to do this
> > thing, random loadable BPF schedulers, then how do we ensure people will
> > contribute back?
> 
> Hi Peter,
> 
> I'm somewhat agnostic to sched_ext itself, but I have been an advocate
> for a plugable scheduler infrastructure. And we are seriously looking
> at adding it to ChromeOS.
> 
> > 
> > That is, from where I am sitting I see $vendor mandate their $enterprise
> > product needs their $BPF scheduler. At which point $vendor will have no
> > incentive to ever contribute back.
> 
> Believe me they already have their own scheduler, and because its so
> different, it's very hard to contribute back.
> 
> > 
> > And customers of $vendor that want to run additional workloads on
> > their machine are then stuck with that scheduler, irrespective of it
> > being suitable for them or not. This is not a good experience.
> 
> And $vendor usually has a unique workload that their changes will
> likely cause regressions in other workloads, making it even harder to
> contribute back.
> 
> > 
> > So I don't at all mind people playing around with schedulers -- they can
> > do so today, there are a ton of out of tree patches to start or learn
> > from, or like I said, it really isn't all that hard to just rip out fair
> > and write something new.
> 
> For cloud servers, I bet a lot of schedulers are not public. Although,
> my company tries to publish the schedulers they use.
> 
> > 
> > Open source, you get to do your own thing. Have at.
> > 
> > But part of what made Linux work so well, is in my opinion the GPL. GPL
> > forces people to contribute back -- to work on the shared project. And I
> > see the whole BPF thing as a run-around on that.
> > 
> > Even the large cloud vendors and service providers (Amazon, Google,
> > Facebook etc.) contribute back because of rebase pain -- as you well
> > know. The rebase pain offsets the 'TIVO hole'.
> 
> From what I understand (I don't work on production, but Chromebooks), a
> lot of changes cannot be contributed back because their updates are far
> from what is upstream. Having a plugable scheduler would actually allow
> them to contribute *more*.
> 
> > 
> > But with the BPF muck; where is the motivation to help improve things?
> 
> For the same reasons you mention about GPL and why it works.
> Collaboration. Sharing ideas helps everyone. If there's some secret
> sauce scheduler then they would likely just replace the scheduler, as
> its more performant. I don't believe it would be worth while to use BPF
> for that purpose.
> 
> > 
> > Keeping a rando github repo with BPF schedulers is not contributing.
> 
> Agreed, and I would guess having them in the Linux kernel tree would be
> more beneficial.
> 
> > That's just a repo with multiple out of tree schedulers to be ignored.
> > Who will put in the effort of upsteaming things if they can hack up a
> > BPF and throw it over the wall?
> 
> If there's a place in the Linux kernel tree, I'm sure there would be
> motivation to place it there. Having it in the kernel proper does give
> more visibility of code, and therefore enhancements to that code. This
> was the same rationale for putting perf into the kernel proper.
> 
> > 
> > So yeah, I'm very much NOT supportive of this effort. From where I'm
> > sitting there is simply not a single benefit. You're not making my life
> > better, so why would I care?
> > 
> > How does this BPF muck translate into better quality patches for me?
> 
> Here's how we will be using it (we will likely be porting sched_ext to
> ChromeOS regardless of its acceptance).
> 
> Doing testing of scheduler changes in the field is extremely time
> consuming and complex. We tested EEVDF vs CFS by backporting EEVDF to
> 5.15 (as that is the kernel version we are using on the chromebooks we
> were testing on), and then we need to add a user space "switch" to
> change the scheduler. Note, this also risks causing a bug in adding
> these changes. Then we push the kernel out, and then start our
> experiment that enables our feature to a small percentage, and slowly
> increases the number of users until we have a enough for a statistical
> result.
> 
> What sched_ext would give us is a easy way to try different scheduling
> algorithms and get feedback much quicker. Once we determine a solution
> that improves things, we would then spend the time to implement it in
> the scheduler, and yes, send it upstream.
> 
> To me, sched_ext should never be the final solution, but it can be
> extremely useful in testing various changes quickly in the field. Which
> to me would encourage more contributions.

I really don't think the problems we have are because of EEVDF vs CFS vs
anything else. Other major OSes have one scheduler, but what they exceed on is
providing better QoS interfaces and mechanism to handle specific scenarios that
Linux lacks.

The confusion I see again and again over the years is the fragmentation of
Linux eco system and app writers don't know how to do things properly on Linux
vs other OSes. Note our CONFIG system is part of this fragmentation.

The addition of more flavours which inevitably will lead to custom QoS specific
to that scheduler and libraries built on top of it that require that particular
extension available is a recipe for more confusion and fragmentation. Not to
mention big players are likely to take over, and I wouldn't be surprised if new
business models start to spring up on top of that. Add to the lot the potential
security issues with the ease to lure people to download sneaky sched extension
that gives great promises but full of malware (more dangerous with the greater
power of BPF/sudo misused).

I really don't buy the rapid development aspect too. The scheduler was heavily
influenced by the early contributors which come from server market that had
(few) very specific workloads they needed to optimize for and throughput had
a heavier weight vs latency. Fast forward to now, things are different. Even on
server market latency/responsiveness has become more important. Power and
thermal are important on a larger class of systems now too. I'd dare say even
on server market. How do you know when it's okay for an app/task to consume too
much power and when it is not? Hint hint, you can't unless someone in userspace
tells you. Similarly for latency vs throughput. What is the correct way to
write an application to provide this info? Then we can ask what is missing in
the scheduler to enable this.

Note the original min/wakeup_granularity_ns, latency_ns etc were tuned by
default for throughput by the way (server market bias). You can manipulate
those and get better latencies.

And this brings me to the major point, we really need to stop thinking that we
must improve everything at system level. Workloads need to evolve to take best
out of systems and we need new libraries for performance and power management.
And this means they need to get new APIs and libraries do a be able to do
a better job and scale well.

I agree with Peter it is not hard to write something to make specific workload
better. But what we really need is enable workloads to be written better and be
more portable to take best of the hardware they run on, AND coexist with other
workloads. For example, how do you write a good multi threaded application that
can scale well across systems (including big.LITTLE) and not trip over other
workloads stealing resources sometimes? You need something like this

	https://developer.apple.com/documentation/DISPATCH

which has a linux port

	https://github.com/apple/swift-corelibs-libdispatch

not a new scheduler.

How do you write an app that can manage bad thermal situations?

	https://developer.android.com/games/optimize/adpf/thermal

POSIX is dormant, and every OS has to wing new interfaces to deal with the new
realities. And I don't see a lot of these discussions. Linux is lagging behind
in general in this aspect. The trend I see is how do I make existing stuff
better, and believe me I've seen strcmp(task->comm, ...) to hand pick things.
Which I am sure we'll end up down this path if we let things loose.

So I am against any custom extension. I think it all has to be part of the
kernel tree and adhere to all of its supported interfaces. Which I think what
we really ought on focusing to evolve and improve. This is the biggest friction
point IMO, not the scheduler algorithm. If the latter need to change, it needs
to be as the result of this friction - which what EEVDF came about from to my
understanding. To enable implementing a latency interface easier. But Vincent
had a working implementation with CFS too which I think would have worked fine
by the way.

I do hope we can reconsider some of our default behaviors though (that bias to
perf and throughput specifically).

FWIW IMO the biggest issues I see in the scheduler is that its testability and
debuggability is hard. I think BPF can be a good fit for that. For the latter
I started this project, yet I am still trying to figure out how to add tracer
for the difficult paths to help people more easily report when a bad decision
has happened to provide more info about the internal state of the scheduler, in
hope to accelerate the process of finding solutions. I think people are getting
stuck explaining why things are failing, which makes finding a common solution
hard if not impossible. We need better way to understand the problems people
are seeing

	https://github.com/qais-yousef/sched-analyzer

Similar methodology can be used to create a BPF based sched test framework.
I don't have cycles to start this, but hope to if no one beats me to it.

I think it would be great to have a clear list of the current limitations
people see in the scheduler. It could be a failure on my end, but I haven't
seen specifics of problems and what was tried and failed to the point it is
impossible to move forward. From what I see, I am hitting bugs here and there
all the time. But they are hard to debug to truly understand where things went
wrong. Like this one for example where PTHREAD_PRIO_PI is a NOP for fair tasks.
Many thought using this flag doesn't help (rather than buggy)..

	https://lore.kernel.org/lkml/20240403005930.1587032-1-qyousef@layalina.io/

