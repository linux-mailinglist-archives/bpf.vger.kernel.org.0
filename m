Return-Path: <bpf+bounces-29802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 891F98C6D57
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 22:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD211C2208C
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4765715ADBE;
	Wed, 15 May 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6khn7+1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254BC158845;
	Wed, 15 May 2024 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805682; cv=none; b=fkzcKarvvIYimNdnFl3YH8TGvbHPAN36GQVsOr4Lou64L26LpLV6Uj9TpONbsV7lQ3jC62/OgtUzAcy2S0FNuZ4apN61g0lbeu4CFVehAuv/JEy4cIbs/k02Plk7pHHUl38MwBdhHrAGalRayylyeXyIVS/rDHdPXhY1kCIIwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805682; c=relaxed/simple;
	bh=Oms9kbAAAD6MgUECAqMq/TMfCBKJNl8uvzZVD5AqLik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6QbA13//v9wKI1Z2KUjDb5nuudpz232AHCmpsg1fo9jfSWwlq4bTIQCynFQgy1LrTCT3Kgk3gSt1l7TzK1lrMgmEwCb4E/4olQ2xCHEUVUvmV6iiQNDpd9yN8jZ86iviMA4nL5LMgzQf5GH5HO3f6ivMZFoOJO/s71A0MKikl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6khn7+1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f44bcbaae7so6592786b3a.2;
        Wed, 15 May 2024 13:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715805680; x=1716410480; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmTfrgvJLxAYZi2Ujwy4baryAmBWQiPWHNWFoOksldI=;
        b=d6khn7+1/9Hj4A6k3duU6p7kLr70NfmFS8FaHvWZU1O1gVkb99S+mY2T6RR0GTz2cl
         0H4FIzz880IsmCOxlGAsW8kNIcITRTfDb9DWKALXl1mWMQTI6oz2EQ58Vzn43x5ZpndA
         6iedVmekyDQ1nCqUP4huRfFG9A97uq6Bj9pippBY87t0cvmesWrw7efWNGK8mDqeaXi3
         JsiSSh+H1pEkjHs9LlAq0eqbPdDMjym0l1AAVamBSpk2MdSm6WELzCm/BsGrDbv5mpB1
         JGAaXMszIz23Z6n25YsGqtT/sOnfD5qkc7Rkm2UEzSqSLgn0/8wbK0Tzn1Sgc/Z4QR/X
         YbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715805680; x=1716410480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmTfrgvJLxAYZi2Ujwy4baryAmBWQiPWHNWFoOksldI=;
        b=KAt0TCV+hQFig2xKq7VFXrqP/sAf/Gl8RrO2OEHyrWeEOneydtuVq87b7eL25eLIEb
         hJBiUQr1UyHw0i+MaSd1BUOOPH1ZbVXolRlIuZOnFIBuWR57V+EtjmxfuApuNjORhlkg
         fRgmVPwUoovORck7ffgMCy/yKqnAjQrJS8AFE9PsF1Dj1CFd3CJAQEjTrE06FG8nWcH4
         mtk8ksFo82UQ8ADssnjAcxlu+vDTYBfj2qh7Ni6sReeJ7MFP9WkBfv02jtUkZQeIusz1
         Uijceax1KDvDJy1xj9fy7lmw8VcD3QzX0cf4WfaV5PJ8XjYqW0VbBiUWf+wj94Y1ztlV
         KvHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVMCAFVORFgROZymqifwilO8FGfz3Uk37T+Y6eMhZzMFlL5VVDEkcR+SEQnyosZflfFRcsLVaN65CeaUrqjQi+cuyAGM8Oa4tcWigP51+X0lmKLVmvSyx23VkZ1FJrUfvp
X-Gm-Message-State: AOJu0YxuVN+QuLhwP+4HpvBZyLuGCe2dGIVR+7rcEKMOLEiP+4RZYlPu
	8RkWAwo14JmSROMSA+hbaYQqT7zH+3KW3Zq4qTNw+beazLP2m4a7
X-Google-Smtp-Source: AGHT+IHDi7ruKHa8Jh7mBBhJVQGbVQF0iCBEcL/K5q4aAAbdyxveNpXTqHhVIbHHqgr5jEItNCgSwA==
X-Received: by 2002:a05:6a00:13a2:b0:6ea:b1f5:1134 with SMTP id d2e1a72fcca58-6f4e03466e7mr18810563b3a.27.1715805680246;
        Wed, 15 May 2024 13:41:20 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b02329sm11523349b3a.181.2024.05.15.13.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 13:41:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 May 2024 10:41:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
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
Message-ID: <ZkUd7oUr11VGme1p@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <ZjgWzhruwo8euPC0@slm.duckdns.org>
 <20240513080359.GI30852@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513080359.GI30852@noisy.programming.kicks-ass.net>

Hello, Peter.

On Mon, May 13, 2024 at 10:03:59AM +0200, Peter Zijlstra wrote:
> On Sun, May 05, 2024 at 01:31:26PM -1000, Tejun Heo wrote:
> > The hierarchical scheduling overhead isn't the main motivation for us. We
> > can't use the CPU controller for all workloads and while it'd be nice to
> > improve that,
> 
> Hurmph, I had the impression from the earlier threads that this ~5%
> cgroup overhead was most definitely a problem and a motivator for all
> this.
>
> The overhead was prohibitive, it was claimed, and you needed a solution.
> Did not previous versions use this very argument in order to push for
> all this?

Being able to experiment with potential solutions for problems like
hierarchical scheduling overhead is important and something we wanted to
demonstrate for sched_ext. It's true that the current hierarchical
scheduling is too expensive to deploy on certain workloads but as I wrote
before it's also not that difficult to work around and isn't a high priority
problem for us.

> By improving the cgroup mess -- I very much agree that the cgroup thing
> is not very nice. This whole argument goes away and we all get a better
> cgroup implementation.

Improving the cgroup CPU controller performance would be great. However, I
don't see how that'd be an argument against sched_ext. Sure, with sched_ext,
we can easily test out potential ideas which can lower the hierarchical
scheduling overhead but, if anything, that should make us want it more. Why
wouldn't we want to have such ability for other problems too?

> > This view works only if you assume that the entire world contains only a
> > handful of developers who can work on schedulers. The only way that would be
> > the case is if the barrier of entry is raised unreasonably high. Sometimes a
> > high barrier of entry can't be avoided or is beneficial. However, if it's
> > pushed up high enough to leave only a handful of people to work on an area
> > as large as scheduling, something probably is wrong.
> 
> I've never really felt there were too few sched patches to stare at on
> any one day (quite the opposite on many days in fact).
> 
> There have also always been plenty out of tree scheduler patches --
> although I rarely if ever have time to look at them.
...
> > I believe we agree that we want more people contributing to the scheduling
> > area. 
> 
> I think therein lies the rub -- contribution. If we were to do this
> thing, random loadable BPF schedulers, then how do we ensure people will
> contribute back?

Everything has cost and benefits. Forcing potential contributors into a
single narrow funnel has the benefit of concentrating the effort as you're
pointing out. However, the cost is that it's a single funnel. In addition to
the inherent downsides of having only one of anything, it can handle only so
much, and pushes people away from even considering contributing.

There are multiple types of contributions. Getting concrete patches into the
main scheduler is one. Trying out wildly different ideas and exploring the
problem space is another. Providing a viable competing implementation can be
an important contribution too by keeping everyone on their toes. If we
concentrate just on direct code contributions, we can lose the sight of the
bigger picture costing us in other areas.

During the short period of time that we've been experimenting with
sched_ext, we've already found multiple fairly generic approaches that show
significant gains. That's not because people who have been playing with
sched_ext have special abilities, but rather because there are plenty of
sometimes obvious things which have been difficult to try with the in-kernel
scheduler. Sure, anyone can modify the kernel, but, without a practical way
to publish, deploy and maintain such modifications, it’s really difficult to
justify such effort when the chance of landing upstream is really low. If
our experience up to this point is any indication, capable engineers who are
interested in the area don't seem to be in particularly short supply. What
is in short supply is an environment in which they can participate, develop
and refine their ideas.

Opportunity cost is often more difficult to appreciate but it is as real as
any cost. While there may be more than enough patches for you to review, we
are leaving a lot of opportunities unpursued and potential contributors
outside the fence because the funnel is too narrow and the barrier of entry
too high. Yes, there are benefits to the current setup where we tell
everyone to contribute to a single code base but at this point I believe
it's costing us more than benefiting.

> That is, from where I am sitting I see $vendor mandate their $enterprise
> product needs their $BPF scheduler. At which point $vendor will have no
> incentive to ever contribute back.
> 
> And customers of $vendor that want to run additional workloads on
> their machine are then stuck with that scheduler, irrespective of it
> being suitable for them or not. This is not a good experience.

The above scenario sounds contrived to me. The situation is already like
this with vendor patched kernels. Just like for patched kernels, the vendor
has to share the code for sched_ext schedulers due to GPL. After all, the
BPF verifier will flat out reject loading any non-GPL programs. In addition,
sched_ext has benefits in terms of user experience. Because sched_ext is
designed to be supplemental to the default scheduler, its users have an easy
out - falling back to CFS/EEVDF by simply unloading the sched_ext scheduler.
With patched kernels, they'd have to reboot and a stock kernel might not
even be available.

> So I don't at all mind people playing around with schedulers -- they can
> do so today, there are a ton of out of tree patches to start or learn
> from, or like I said, it really isn't all that hard to just rip out fair
> and write something new.
> 
> Open source, you get to do your own thing. Have at.
> 
> But part of what made Linux work so well, is in my opinion the GPL. GPL
> forces people to contribute back -- to work on the shared project. And I
> see the whole BPF thing as a run-around on that.
> 
> Even the large cloud vendors and service providers (Amazon, Google,
> Facebook etc.) contribute back because of rebase pain -- as you well
> know. The rebase pain offsets the 'TIVO hole'.

Two things are being conflated here. What GPL gives us is that ideas and
code don't get locked up behind a paywall. If someone based their work on a
GPL project, others get to take a look at what they did to learn and copy
from them. The upstream pressure is a separate mechanism which nudges people
towards upstream because the overhead of rebase is painful regardless of the
license requirements.

The upstream pressure works well but as I wrote above it also can be pushed
too far to the point where it costs rather than benefits long term
development. Controlling too tight runs the risk of pushing changes and
proposals worth considering under the ground and potential contributors
away. It may be difficult to judge and agree on where the current situation
exactly is but it is not difficult to see signs of stress. Even just for us,
scheduling is one of the common pain points for both server workloads and
Oculus. Talking to other organizations, we hear similar concerns.

You said two conflicting things - that people can have at it as it's open
source but at the same time that even large organizations are forced to the
funnel due to the rebase pain. It's true that even for large organizations,
deviating from upstream is expensive. However, big orgs can still do it
because the benefit usually scales with the number of machines allowing them
to cross the break-even point and thus pay for it.

But the same pain applies to smaller organizations, researchers and
individuals. Imagine how big a deterrence the current situation would be for
them. It's extremely challenging for them to build a user base and community
as it's very awkward to deploy and painful to maintain custom kernels. Some
still persevere but most would be discouraged even from starting if the
prospect of their work being useful is so slim. This limits potential
contributions from a lot of organizations.

CFS / EEVDF is an excellent general purpose scheduler. It obviously is the
most used and most important scheduler in the whole world. It's difficult to
believe that the only way to get enough people to contribute to it is by
suppressing alternatives. The current approach of funneling potential
contributors to a single code base with a very high bar creates a lot of
pain for those potential contributors, and probably feels unnecessarily
punitive to anyone new to the space. If we have to really worry about losing
contributors to the main Linux scheduler just because sched_ext creates an
additional space that interested engineers can work in, something has gone
really wrong and I don't believe that matches the reality.

> But with the BPF muck; where is the motivation to help improve things?
> 
> Keeping a rando github repo with BPF schedulers is not contributing.
> That's just a repo with multiple out of tree schedulers to be ignored.
> Who will put in the effort of upsteaming things if they can hack up a
> BPF and throw it over the wall?

I wouldn't be so dismissive about development happening outside the kernel
tree. We already see strong community and collaborations in the SCX repo
which is serving as an umbrella project for the sched_ext schedulers.
Different schedulers are chasing different directions but they actively
learn and borrow from each other. It can definitely serve as an incubator to
prove and refine new ideas which can be adopted widely and to grow
scheduling engineers.

For an example, it's still early but Changwoo's work on interactivity in
scx_lavd seems generally useful and has already been adopted by scx_rusty.
It's something which can easily be applied to EEVDF too. Changwoo may or may
not work on EEVDF directly (he says he wants to) but the code change
necessary is neither big nor difficult. Figuring out what actually works was
the hard part, not the implementation. Not all ideas would be like this but
this serves as a good example of how contribution is not just directly
writing patches and how work outside the tree can benefit the kernel.

> So yeah, I'm very much NOT supportive of this effort. From where I'm
> sitting there is simply not a single benefit. You're not making my life
> better, so why would I care?
> 
> How does this BPF muck translate into better quality patches for me?

I'm not sure whether it would make your life better but I firmly believe
that it will benefit overall Linux scheduling in the long term. You don't
necessarily have to care. We'll do our best to ensure that it bothers you as
little as possible.

Maybe I'm mistaken and we won't find much that'd be useful enough for EEVDF
but also maybe there are enough things that we haven't tried that will make
things better for everyone. I believe in the latter and the indications till
now seem to agree. You don't have to share my optimism but wouldn’t it at
least be worthwhile to find out?

Thanks.

-- 
tejun

