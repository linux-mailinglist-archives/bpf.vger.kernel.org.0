Return-Path: <bpf+bounces-11843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969257C437D
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 00:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E7A281E7F
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 22:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDB06119;
	Tue, 10 Oct 2023 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXnzN+Sl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836432C61
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 22:09:49 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0B694;
	Tue, 10 Oct 2023 15:09:47 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c871a095ceso46400085ad.2;
        Tue, 10 Oct 2023 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696975787; x=1697580587; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocMIZwsPwAUeO+we0n8h8enjCQGDDQ9xd1KmXD5+ghs=;
        b=YXnzN+Sl4ITgQIzxEXcTy8t85OIg7wc1YIa8C/e25dPM/w1PItuhmGpJz93uj/3dLp
         5PQJtEuWFhgLZyIXjUQzD/O8iTLyunt+v3gQTDuFiyT/AFrJqym7zs4fQWkX7kQVLgN/
         /EAHjRIhphMX9ydpp3Qi05HQFydnx9Ov0Pn2Qw3/1l/W8AhwydMwYbcG2yV4YeWXUDwt
         8qnQOrosJxFaDoXcwkcU9eNZClqXHqtKJm0F8SVoj/5K7Tic503cHKFvBh0NeipcBELd
         hxPeSWlxErEjkD5hE1dLnL/dTlTppbECnxtIuBkSa81ufPuHyO2KnwGONHB9of5IReA/
         uE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696975787; x=1697580587;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocMIZwsPwAUeO+we0n8h8enjCQGDDQ9xd1KmXD5+ghs=;
        b=H8o9FdjxKVb9alo7dPz2CLtuYU9T6Nu0LfF8tDf3Ynpz04FpM0UY83a7CPVplxYc72
         7IByukzBpFgHmI3l6Shj/Fwj52xikWbYJTQCCu1Up+/a/93ckqe5KO4WO1CDcOTBLT5P
         qLHTre0wWXR02d5n7oW9s28yIMVTlwxnATm+s5fvYFp0EoV5rNSIqQxZbrD4MV3Iq7o0
         BbfJQirD+LcnW9Ny0EeFtBGnutKNOHSfFSZlb70F8JzyC7m0+OGH7ivF6d5z/7XxbpDO
         gBR7UGBRai9r6YPHh38HShdtmMqc+c6x+QRQOup3y2Kzdr54h+SJ2+dRWGkYdBTXBVQ6
         DOPg==
X-Gm-Message-State: AOJu0YzDa4HLlAY8ohouVn/W3TRuM7iE/tABbi0794Di1fWCvyAFidWt
	Kq9oX3vCLTBUn9cocq2/GsA=
X-Google-Smtp-Source: AGHT+IGYndRyzIltdZjrYXp8OxEgKRpla2c8nWRYsKM6UiuFsBzYoAWF+zwa4GoI4dKfgWGxQwEncA==
X-Received: by 2002:a17:902:c947:b0:1c7:4a8a:32d1 with SMTP id i7-20020a170902c94700b001c74a8a32d1mr20484919pla.28.1696975786727;
        Tue, 10 Oct 2023 15:09:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cced])
        by smtp.gmail.com with ESMTPSA id ji2-20020a170903324200b001c75f94b0b0sm12342152plb.213.2023.10.10.15.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:09:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 10 Oct 2023 12:09:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHSET v4] sched: Implement BPF extensible scheduler class
Message-ID: <ZSXLqNKajmeFRT8x@slm.duckdns.org>
References: <20230711011412.100319-1-tj@kernel.org>
 <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
 <20230726091752.GA3802077@hirez.programming.kicks-ass.net>
 <ZMMH1WiYlipR0byf@slm.duckdns.org>
 <20230817124457.b5dca734zcixqctu@suse.de>
 <ZOfMNEoqt45Qmo00@slm.duckdns.org>
 <ZQngsfCdj0TJbEUL@slm.duckdns.org>
 <20230926092020.3alsvg6vwnc4g3td@suse.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926092020.3alsvg6vwnc4g3td@suse.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, Mel.

On Tue, Sep 26, 2023 at 10:20:20AM +0100, Mel Gorman wrote:
> Plenty, but I'm not sure how to reconcile this. I view pluggable scheduler
> as something that would be a future maintenance nightmare and our "lived
> experience" or "exposure bias" with respect to the expertise of users differs
> drastically. Some developers will be mostly dealing with users that have
> extensive relevant expertise, a strong incentive to maximise performance
> and full control of their stack, others do not and the time cost of
> supporting such users is high.

My experience working for distros is shorter and less extensive than yours
but I believe I can appreciate the pain points to some degree. Getting
dropped into an enterprise software problem where most of the environment is
walled off can get really frustrating and pluggable schedulers can add
unfamiliar problems on top.

That said, I'd like to reiterate two counter points:

First, there are multiple substantial non-distro communities that use and
work on the kernel. Hyper-scalers that operate huge fleets of machines such
as Google and Meta among others, public cloud operators such as Amazon and
Google, hardware projects including smartphones, watches, VR headsets and so
on.

Because these communities tend to have more vertical integration across the
software stack and extremely high usage fan-out, development resource
allocation and the boundaries of what can be reasonably tried are different
from distros. In addition, the cost of failing to exploit optimization
opportunities is very direct and often extremely high. The cost-benefit
balance is pretty one sided in the favorable direction for these
communities.

Second, if a distro chooses to support sched_ext, there will be new kinds of
problems but that wouldn't be for nothing. While there will be stupid cases,
overall, the new problems will be there because users can now do things that
they couldn't do before. As I wrote before, in principle at least, adding
more capabilities should be a mutually beneficial proposition for both the
distros and their users.

> While I can see advantages to having specific
> schedulers targeting either a specific workload or hardware configuration,
> the proliferation of such schedulers and the inevitable need to avoid
> introducing any new regressions in deployed schedulers will be cumbersome.

I'm having a bit of a hard time following here. If someone (or group) writes
a custom scheduler, they'd be responsible for maintaining that, right? It
shouldn't significantly increase the maintenance burden somewhere centrally.
FUSE can be an imperfect analogy. There are numerous FUSE implementations.
While they sometimes expose shared underlying issues, the proliferation
doesn't usually lead to huge extra maintenance overhead.

If you're referring to the maintenance of sched_ext itself, yes, people
would get sad if things get slower or break and we'd want to avoid such
situations if we reasonably can. However, we absolutely can make breaking
changes if necessary. Here, BCC tools can serve as the imperfect analogy
(other BPF use cases often share similar characteristics). BCC tools are
coupled with the kernel in more fragile and opportunistic ways than
sched_ext, and some of them do break as the kernel code changes. However,
they get patched up pretty quickly and don't have any problem maintaining a
thriving ecosystem. This sort of arrangement isn't rare - browser, desktop,
even editor plugins are often like this.

Another point which may be worth considering is that there is an innate
drive towards consolidation even in open ecosystems. In most cases, over
time, a large number of experiments will be boiled down to a small number of
winners. Many people end up having similar needs and sooner or later
something becomes dominant in the area. While I don't have a crystal ball, I
don't think sched_ext schedulers are going to be much different - there will
probably be a handful that are both useful in some niches and well
maintained against the backdrop of many one-off and experimental ones. A bit
messy maybe, but not overwhelming. Most projects flourish in similar
situations.

> I generally worry that certain things may not have existed in the shipped
> scheduler if plugging was an option including EAS, throttling control,
> schedutil integration, big.Little, adapting to chiplets and picking preferred
> SMT siblings for turbo boost. In each case, integrating support was time
> consuming painful and a pluggable scheduler would have been a relatively
> easy out that would ultimately cost us if it was never properly integrated.
> While no one wants the pain, a few of us also want to avoid the problem
> of vendors publishing a hacky scheduler for their specific hardware and
> discontinuing the work at that point.

There are two diametric approaches. Currently, in the scheduler, everyone is
forced to work on a single implementation so that all the efforts and energy
can be captured in one place. Let's call this the funneling model. The
opposite would be the open model, where a common framework is laid out and
there are multiple competing implementations.

As with anything, there are pros and cons to both approaches and the long
term outcome can sometimes be counter-intuitive. For example, if a project
is funneled too hard, it's unlikely to grow a large and diverse pool of
contributors as there just isn't enough space to accommodate them. This
limits the contributor pool which in turn fortifies the justification for
funneling everyone into one thing, creating a feedback loop.

When development effort is perceived as finite zero-sum resource, this way
of describing the situation makes sense - "Had that developer not been
forced to work on this code base, we would have lost this feature."

Putting the other end into a similar proposition may be useful in seeing the
inherent trade-off - "What new ideas and talents are we missing out on by
constricting the contributor pool?"

As I mentioned before, the closest analogy I can think of is filesystems.
It's not an apples-to-apples comparison of course but there easily are an
order of magnitude more developers working on filesystems compared to
scheduling. Sure, a lot of efforts are diffused and duplicated but in the
long run we benefit so much more by letting people explore the problem
space, compete, copy from and improve upon each other.

Given how much both the machines and workloads have changed, we should be
trying wilder things a lot more and we can't do that with the funneled
model.

> I see that some friction with the current state is due to tuning knobs
> moving to debugfs. FWIW, I didn't 100% agree with that move either and
> carried an out-of-tree revert that displayed warnings for a time but I
> understood the logic behind it. However, if the tuning parameters are
> insufficient, and there is good reason to change them then the answer
> is to add tuning knobs with defined semantics and document them -- not
> pluggable schedulers. We've seen something along those lines recently
> with nice_latency even if it turned into EEVDF instead of a new interface,
> so I guess we'll see how that pans out.

That only works if we assume that most of what we want to try can be
reasonably covered by parameterizing EEVDF. The argument for sched_ext is
that there are a lot more radical things we can and should be trying. For
example, if we have many dozens of CPUs and workloads which are logically
grouped, it may make more sense to allocate CPUs to workloads rather than
scheduling each task's slice. Or given the close distance within a LLC
domain and non-uniform LLC layouts on some chiplet processors, task-to-CPU
stickiness maybe doesn’t matter anymore while spilling across multiple CCXs
can benefit from application-side hinting. Or given that CPU time has become
a lot flimsier as a way to measure CPU utilization, we should experiment
with different metrics which may or may not include wallclock times. Or,
given the proliferation of async frameworks in userspace, working closely
with async runtime could be pretty interesting.

That's too big a surface to cover by parametrizing EEVDF in any reasonable
way. Once we know what's really useful, some part can likely be incorporated
with well-defined interface but we don't know what this should look like yet
and it's pretty difficult to find out without an easy way to experiment.

> I get most of your points. Maybe most users will not care about a pluggable
> scheduler but *some will* and they will the maintenance burden. I get your
> point as well that if there is a bug and the pluggable scheduler then the
> first step would be "reproduce without the pluggable scheduler" and again,
> you'd be right, that is a great first step *except* sometimes they can't or
> sometimes they simply won't without significant proof and that's incurs a
> maintenance burden. Even if the pluggable schedulers are GPL, there still
> is a burden to understood any scheduler that is loaded to see if it's the
> source of a problem which means. Instead of understanding a defined number
> of schedulers that are developed over time with the history in changelogs,
> we may have to understand N schedulers that may be popular and that also
> is painful. That's leaving aside the difficulty of what happens when
> more than 1 can be loaded and interacting once containers are involved
> assuming that such support would exist in the future. It's already known
> that interacting IO schedulers are a nightmare so presumably interacting
> CPU schedulers within the same host would also be zero fun.

We should do a better job of clarifying and enforcing which IO controllers
and schedulers can be employed together, but here's the same question turned
around. What'd it be like if cfq had been deemed the only allowable IO
scheduler while the underlying hardware was going through rapid
developments? The IO schedulers and controllers being pluggable makes the
overall scene more complicated but that's also what allowed the block layer
to quickly adapt to the new hardware reality.

> Pluggable schedulers are effectively a change that we cannot walk back
> from if it turns out to be a bad idea because it potentially comes under
> the "you cannot break userspace" rule if a particular pluggable scheduler
> becomes popular.

I believe the track record of BPF use cases provides pretty strong evidence
against this. There are a lot more tools and usages which depend on kernel
internals now than several years ago, but that hasn't really gotten in the
way of kernel evolving in any meaningful way. We need to manage the
expectations as necessary but I believe the recent history has shown that
this concern doesn't really match reality.

> As I strongly believe it will be a nightmare to support
> within distributions where there is almost no control over the software
> stack of managing user expectations, I'm opposed to crossing that line with
> pluggable schedulers. While my nightmare scenarios may never be realised
> and could be overblown, it'll be hard to convince me it'll not kick me in
> the face eventually.

I agree that this may add support cost to distros and we should take
measures to limit that (e.g. make it evident which scheduler\[s\] have been
active and we’d be happy to take any suggestions), but we can't just look at
the costs. What benefits other parts of the industry are going to benefit
enterprise users too. If enterprise customers want to use sched_ext, their
reasons wouldn't be all that different from other industries.

Taking a further step back. You're asking "What's the cost that sched_ext
will add in terms of maintenance and support?" The question I'd like to
counter with is "How much are we missing out on by making it difficult to
explore and experiment in the scheduling space?" Opportunity costs are
usually more challenging to factor in but they're costs all the same at the
end of the day.

Thanks.

-- 
tejun

