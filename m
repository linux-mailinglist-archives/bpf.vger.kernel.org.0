Return-Path: <bpf+bounces-30699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156AA8D0F66
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 23:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B082815B3
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 21:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20D816132B;
	Mon, 27 May 2024 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="dNyqEWFx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97853389
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845146; cv=none; b=AjAENbCD+utcrPCPUNf19V3pYld0J7MuM3u7dvjTXG3DaNfGyJMfVYDu99w+brvnkDVPdSaJJQMUN1+mwBMNuTZ91k6R1CPPR4e+XH/Nqgihp4Qp3zgEQVonJwhGbT87f9rT7maoxPPhN106+1wlR8XdwkDJ8VmCaPLCrj0XdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845146; c=relaxed/simple;
	bh=LdG7ktowhnjzEdPoZ+Ttq4iNXdNn5ME5OBb1WfTkjew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhuQVhnQAuFIvh76yEfXTADV0dvUECb6YlDVq1XIZ1QhCDtq65lZm+HE03Kxel0Nt23C0xuaR8Hkns1qI5gYaTezcYmmRx6vfjHhH3ep9SI4CwHHskuaoOhotPUxeEZntfDr3iDZgK/hFmUoUNhbRz6SWtmi+Uo+owHfqTH7wF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=dNyqEWFx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4202ca70289so874565e9.1
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716845143; x=1717449943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A7HC5A2aTc83IoX0PVow5xufAISx19nMRBT1reOH5cg=;
        b=dNyqEWFxxX3QJ9zmQcl6JbU880eqreRaUNxNw+d/ZNf3ySneSISnlZK5x59XHsgZ8b
         05G1G+6yIjspIR9OIW0aFDM9alvsroAJSciwKue+5plDyJ0JX4Am31k078cVGdFEq4is
         +ScXkAGlMr3ta6ERFYI7TDykyjUYvgbiT3k68oFOjXkJBOy3dgQkF+64nSUrd7jj1vYB
         WmuAHlrZQT45cVOSVPhvMBsBg4umw4pud19WEHYJah+06adcEvlNqsQQesdQRDkQzuuH
         87ochuk0ft4c0FGI1fQaP6jJuEKVMj0PrzCJhUhMzNLpbWlQIRLbN7NT8/5L55PCg3Jc
         dO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716845143; x=1717449943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7HC5A2aTc83IoX0PVow5xufAISx19nMRBT1reOH5cg=;
        b=mWTIKlYTnJnp32WK6+G84xBPkb2wnHUI03sAors8t4W3ZeVQxdpzjcW1dwM3nKiFfk
         hVpdw+dCE4YNmCteO+EEfHV9s57/md9zOXskgkdF6psE3vfTfMmngubwQO31hiibjm0W
         zsnmfyms5gJEQaERd7En0Phk/t24ke2x6K88F7fYIegWB7iAunV1OEs4RYYDxAaS2hj2
         rW7G0S+tEEATq+CW4QITV3tOPiM81eyjbv6qkUcR20M3/dnmJm/F2y0kivVA2OwfZL76
         Ptr6PM9jM77GsFase3RbIHgcFDQi/UnNmiZLr8QA7Vgk0F4lkpusprysynZkuRVwLHvc
         kWHw==
X-Forwarded-Encrypted: i=1; AJvYcCUzdhjmHDByjrr4NmL/Xzfh5GfbfvQ4VYVuJukG5+qSWt6LWcI2/SrWhCaArhu2hXNfOK3mkOeiF+qhXkYfYN0obzQv
X-Gm-Message-State: AOJu0YxIl6LOZ4DHFv3BvWR47SH4SQ46RdJnDKr4UETcuyO/7p/zIytE
	utYkYCK4Cu02aL2Nr3o1WbsGAxJcqROJwBlFPEi2nBUbUUS8J3GM3X9+uRZwzys=
X-Google-Smtp-Source: AGHT+IFItlgiowD1lpOXhBLswf+hJiQT8hJaOWHUuO8HHxQlu17vMeRwoNhNTg4OgDWHWokTneDkJQ==
X-Received: by 2002:a05:600c:46c4:b0:41a:e995:b924 with SMTP id 5b1f17b1804b1-42108a0b91dmr63716165e9.33.1716845142595;
        Mon, 27 May 2024 14:25:42 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9379sm9849541f8f.73.2024.05.27.14.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 14:25:42 -0700 (PDT)
Date: Mon, 27 May 2024 22:25:40 +0100
From: Qais Yousef <qyousef@layalina.io>
To: David Vernet <void@manifault.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
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
Message-ID: <20240527212540.u66l3svj3iigj7ig@airbuntu>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <ZjgWzhruwo8euPC0@slm.duckdns.org>
 <20240513080359.GI30852@noisy.programming.kicks-ass.net>
 <20240513142646.4dc5484d@rorschach.local.home>
 <20240514000715.4765jfpwi5ovlizj@airbuntu>
 <20240514213402.GB295811@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514213402.GB295811@maniforge>

On 05/14/24 16:34, David Vernet wrote:
> On Tue, May 14, 2024 at 01:07:15AM +0100, Qais Yousef wrote:
> 
> [...]
> 
> > > > 
> > > > How does this BPF muck translate into better quality patches for me?
> > > 
> > > Here's how we will be using it (we will likely be porting sched_ext to
> > > ChromeOS regardless of its acceptance).
> > > 
> > > Doing testing of scheduler changes in the field is extremely time
> > > consuming and complex. We tested EEVDF vs CFS by backporting EEVDF to
> > > 5.15 (as that is the kernel version we are using on the chromebooks we
> > > were testing on), and then we need to add a user space "switch" to
> > > change the scheduler. Note, this also risks causing a bug in adding
> > > these changes. Then we push the kernel out, and then start our
> > > experiment that enables our feature to a small percentage, and slowly
> > > increases the number of users until we have a enough for a statistical
> > > result.
> > > 
> > > What sched_ext would give us is a easy way to try different scheduling
> > > algorithms and get feedback much quicker. Once we determine a solution
> > > that improves things, we would then spend the time to implement it in
> > > the scheduler, and yes, send it upstream.
> > > 
> > > To me, sched_ext should never be the final solution, but it can be
> > > extremely useful in testing various changes quickly in the field. Which
> > > to me would encourage more contributions.
> 
> Hello Qais,
> 
> [...]
> 
> > I really don't buy the rapid development aspect too. The scheduler was heavily
> 
> There are already several examples from users who have shown that the rapid
> development and experimentation is extremely useful. Imagine if you're
> iterating on the scheduler to improve p99 frame rates on the Steam Deck, as
> Changwoo described. It's much more efficient to be able to just tweak and load
> a BPF scheduler (that is safe and can't crash the machine) to try some random
> idea out than it is to:
> 
> 1. Tweak and recompile the kernel
> 2. Reinstall the kernel on the Steam Deck
> 3. Reboot the Steam Deck
> 4. Reload a game and let caches rewarm
> 5. Measure FPS
> 
> You're talking about a 5 second compile job + 1 second to reload a safe BPF
> scheduler vs. having to do all of the above steps _and_ potentially making a
> mistake that brings the machine down. These benefits are also extremely useful
> for testing workloads on production servers, etc. Let’s also not forget that
> unlike many other kernel features, you probably can’t get reliable scheduling
> results from running in a VM. The experimentation overhead is very real.

What I read here is that I can hack my system quickly. Is the intention to
extend the kernel? If yes, I can't see how this experimentation is actually
valid if not implemented in the kernel first taking into account the real
constraint that you have to deal with sooner or later.

> 
> [...]
> 
> > influenced by the early contributors which come from server market that had
> > (few) very specific workloads they needed to optimize for and throughput had
> > a heavier weight vs latency. Fast forward to now, things are different. Even on
> > server market latency/responsiveness has become more important. Power and
> > thermal are important on a larger class of systems now too. I'd dare say even
> > on server market. How do you know when it's okay for an app/task to consume too
> > much power and when it is not? Hint hint, you can't unless someone in userspace
> > tells you. Similarly for latency vs throughput. What is the correct way to
> > write an application to provide this info? Then we can ask what is missing in
> > the scheduler to enable this.
> 
> Hmm, you seem to be arguing that the way forward here is to have our one
> general purpose scheduler be entirely driven by user space hinting. Assuming
> I’m not misunderstanding you, I strongly disagree with this sentiment.  User
> space hinting can be powerful, but I think we need to have a general purpose
> scheduler that's completely agnostic to whatever is running in user space.
> We’ve also been able to get strong results from sched_ext schedulers that don’t
> use any user space hinting.

I'm curious. If you believe in general purpose system, what work was done to
improve the current one? What debugging and analysis was done to improve the
current situation? It seems you reached a conclusion that we need something
different - but no reasons behind it why is that.

Is the problem with the default behavior of the system? Or are your problems
focused on corner cases where things seem to fail?

> 
> Also, even if this ended up being the way forward, I don’t see it being
> practical to implement. Wouldn’t it require us to update all of user space

People swear by Apple's GCD by the way. It'd be really great if someone can
create something similar that works properly on Linux. I have never tried the
libdispatch port to see how well it does.

And have you seen these?

	https://developer.android.com/stories/games/mediatek-adpf

> globally just to update how it interfaces with the scheduler?

I think you're confusing default scheduler behavior and dealing with corner
cases that are impossible for the scheduler to resolve. These corner cases are
when help is needed. Note that the thermal API is actually info from the system
to the app. If the app decides to listen, then they can help reduce the thermal
impact without causing throttling. If they decide not to listen, then the best
the system can do is throttle everything hard to protect from damage. And under
bad thermal pressure, the scheduler can know which tasks to prioritize to
performance if it has explicit knowledge/hints.

If the default behavior is not working for you; could you provide more details
on what goes wrong? It's unlikely that a new algorithm is the solution, but
likely a bug somewhere or some configuration problem.

And if someone wants to optimize for best perf, power and thermal, they need to
do the work. There's only so much you can do on their behalf that is actually
scalable.

System designers want apps (all type of apps) to take best advantage of the
hardware they built.

App writers want to write portable software that gives the desired experience
on all type of systems without special optimization.

> 
> [...]
> 
> > Note the original min/wakeup_granularity_ns, latency_ns etc were tuned by
> > default for throughput by the way (server market bias). You can manipulate
> > those and get better latencies.
> 
> Those knobs aren't available anymore in EEVDF.

I generalized my statement as I didn't expect many have moved to 6.6 LTS, which
is the only one that has EEVDF.

EEVDF has base_slice_ns. What value do you read on your system? What is your
TICK value and how m any CPUs do you have?

>  
> [...]
> 
> > point IMO, not the scheduler algorithm. If the latter need to change, it needs
> > to be as the result of this friction - which what EEVDF came about from to my
> > understanding. To enable implementing a latency interface easier. But Vincent
> > had a working implementation with CFS too which I think would have worked fine
> > by the way.
> 
> This friction is nothing new. It's why we already find ourselves in the
> unfortunate position of having a large corpus of out of tree scheduler patches.
> If there is a lot of performance being left on the table, vendors are going to
> find a way to get that performance. Corporations don't need our consent to ship
> kernels with custom schedulers on their devices. They've already been doing it
> for years, and it's ultimately the users who suffer.

I think everyone agrees on the need to improve. But..

> 
> I genuinely believe that the fair.c scheduler will benefit from being able to
> apply ideas conceived in a sched_ext scheduler which end up working well for
> general use cases. For example, in scx_rusty, we’re able to get very good
> interactivity [0] by determining a task’s deadline as a function of its average

.. I am really failing to see why you jumped to the fact we need a new
scheduler. And you'll find a lot of skepticism about the validity of your
results. We have no clue what kind of unknown constraint you've left out with
these test. And how limited your environment is.

> runtime (along with some other great ideas that Changwoo first added to
> scx_lavd) rather than from its eligibility + slice as with what EEVDF does.

You'll find soon that the concept of runtime is hard. And generally there's
a big soup of tasks running in the system. Most of which have no real deadline.
Only few do. And corner cases are the complexity of any situation when you
have more tasks that need to run immediately than you have CPUs to distribute
them on. I don't think we can figure this out automatically based on runtime.

> Over the course of a day or two, I tried way more ideas that didn’t work than
> would have been possible in that time frame than with a recompile-reboot cycle,
> and ended up finding one that seems to work very well. It would be awesome if
> these ideas were added to EEVDF so that everyone can benefit.

Why do you think they're applicable? And how do you know you're not working
around different problems? Or have missed constraints in your testing once
applied will make the whole results invalid?

Too many unknowns IMHO. I am not against a different scheduler algorithm if it
proves to be a more generic default. But you'll find first you have to explain
what has failed in current one and what kind of analysis made you reach this
conclusion. And then you'll find you'll need to actually do it in the kernel
taking into account all the constraints that you must handle to prove it is
still as valid as you initially thought.

And I can only share my experience, I don't think the algorithm itself is the
bottleneck here. The devil is in the corner cases. And these are hard to deal
with without explicit hints.

The biggest issue I see generally with the default behavior is that
traditionally it has been biased towards throughput because those folks are
the one that keep reporting regressions when anything changes on the list.

Please add your voice and report problems when you notice things don't work for
you. That's the best way to ensure there's visibility of these issues. It seems
to me you're hitting problems that people expect to work. But I have no clue
what problems you have. I am not sure if this was reported somewhere else, but
it seems not.


Thanks!

--
Qais Yousef

