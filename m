Return-Path: <bpf+bounces-30949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C6A8D5021
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 18:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A7F282E1C
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93691381AD;
	Thu, 30 May 2024 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoT2rBvW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3AA42071;
	Thu, 30 May 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087745; cv=none; b=c5s0KLxYKrdGNOeQUdt4XAGtujDy8b6hnrRWbHQ/LyZHJ4K2+UsJEmN8Fk1lMuLszv943FkQt5dRRipi5zK0ndjX2LSbqG3qdl6tPb7x0KuF0S/VlyVO166nLOjE96BSg/OpwmBvBKVRExtcmQ7HDUrtnlTH0c7PoZuxGWkSd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087745; c=relaxed/simple;
	bh=I6BERmi5nPEKmxHL2HMDaClEL9MyjT47g54+Sy/rblo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2TwhwiAcDg5+r+MWid4ZyMTFPeBbtR7dk6QzEczQSLeepTsBR0+8xGMmmZ/AlcwOotnVEYWUEtC5oFglxq4Hyt8VUewmVdIeGPt6iWGt+5QVbhEWytSZDjRYIz2FSFsUym7fn9hgHs8zUS9nNy4ZAcvAkGPIBBWw6JVdcEa4zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoT2rBvW; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6bce380eb9cso915618a12.0;
        Thu, 30 May 2024 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717087743; x=1717692543; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/Ld2nqzB5x279KNvsmiD2HC7Uop3I6bxq/cd3hya74=;
        b=NoT2rBvWXpIilks1IjAo+zjyJDpfLMzHI/kl7eKaUXI3ZLiffMSUoZRAXjW1L5ymzP
         aBj8NIrCExrmNryhttMst8q5YPgrY3pi9Ve1IyrVEr398uisrpMw7laR3Kb7Zbrvv8pJ
         Wh5uhiF8hv9wR1F7l2p3UFIlkCFyGdt22xqwIM0SrJXLvKdFuuf5myJd5uZ76SmA3nQC
         lp4up8/dr9FSWiWjuVT5FFgMDCZLYyH2VjLvU2nMTMuh54axGFgqkKpQqJC1RVGBtYYS
         1ZxMpPAy76tQ/8iwokHe0TxjUOB+tp5wJrhs3s3LLev7TvHVH6l+OAgb2keMtXEG3TvM
         H/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717087743; x=1717692543;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/Ld2nqzB5x279KNvsmiD2HC7Uop3I6bxq/cd3hya74=;
        b=w/NlElIixSD3gDeQuRBvv3RXUwfGZAliKFX4J9T+NrceOMlw5VN/RrOoCEfk+AV1YW
         KpLaqNI6jXR8v9htWY8HWaRKtwuohCqbpHfsIhKEOGV6SpmXf+cDAV0qTKy/3CjVmE+5
         SGNf/V7f5/wfGNFNLtXT4FywXtxn42xpkM9DuWrK4UvLTT889OV/SN/tSkzfaqvArjmA
         f3wuJBdm9YFQCTXygqSjEU8WMCbDg8LwhMPp45tphcg0INUBaXvM5SuJOA83m90GI7rl
         ToOGwavucIzJBCBV9C17fkS0WfRNLfiNFw3KgY+3l/QDNGnqTE8r55DHlxc86zrVwTyB
         IyNw==
X-Forwarded-Encrypted: i=1; AJvYcCX+agFYdMVv8Bl7QJoNyE+NAIJrbbOfFTWRdL1h523QD0iCIlpzLwkXzP9lQofGt81+LCHOpaGMs+3RZppzCMQJdqgFrZbIh183/hfKHHnhh6rKpPNY8Y5klpjcsOMdEVkD
X-Gm-Message-State: AOJu0YwXRFs8hUnEDj8xWcDGxzwCBWqIeGmU1wI436cTFf36q9Qk2rM1
	S4e1PZZGnUq0bvTtGDV60xpcCuLZWBX2/8dWT1d2CGrISNYE0zuf
X-Google-Smtp-Source: AGHT+IHHbgLpocARyPawPF9UimvIl95SLEOKH1LFA/5BleZpLidB5rwVY+xFA/y/tRBULCttMeXsPg==
X-Received: by 2002:a17:902:c614:b0:1f4:7713:8f6 with SMTP id d9443c01a7336-1f619b2cbe3mr19999725ad.52.1717087742726;
        Thu, 30 May 2024 09:49:02 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323554a3sm87295ad.63.2024.05.30.09.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 09:49:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 30 May 2024 06:49:01 -1000
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
Message-ID: <Zlit_RUFPparkS3h@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <ZjgWzhruwo8euPC0@slm.duckdns.org>
 <20240513080359.GI30852@noisy.programming.kicks-ass.net>
 <ZkUd7oUr11VGme1p@slm.duckdns.org>
 <ZkvoqvY00UDDcKJU@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkvoqvY00UDDcKJU@slm.duckdns.org>

Hello,

It has been a couple weeks, so I take it that you aren't intending to
respond. I think it'd be useful to summarize the arguments against sched_ext
and list the counter-points.

(1) Merging sched_ext will weaken the incentive to contribute.

While this may partially be true, it isn't looking at the whole picture.
This argument looks at the costs of sched_ext while ignoring the benefits,
and it ignores the costs of funneling all scheduler work through one
codebase.

If you look at the whole picture, I think you’ll see that:

- The problem space of CPU scheduling is too big for a single code base to
  be effective. Hardware has changed a lot and so have the workloads. There
  are many areas that we haven't mapped out. It's difficult to try anything
  radical in a code base which has to satisfy everyone all the time, but
  holding the bar so high that experimentation is suppressed means we will
  all be worse off.

- The bar for contribution is too high, driving away potential contributors.
  Many vendors and users carry internal patches as the upstreaming cost is
  too high. We are already seeing multiple developers who have not
  previously contributed to fair.c actively participating in and driving
  sched_ext schedulers. It’s possible those developers will eventually
  contribute to fair.c, but if sched_ext didn’t exist this would be less
  likely.

The constraint of only one scheduler codebase makes it very difficult to
contribute. You say that this constraint is necessary to force
collaboration, but I think the opposite is happening - many people don't
bother trying to contribute because the bar is too high. If sched_ext is
merged, the scheduler code base may lose some of the enforcement. However,
in the longer term, I believe we will gain more talented and motivated
engineers working in the problem space and some of them will surely find it
worthwhile to contribute to fair.c. It will be the most widely used
scheduler in the world no matter what, and will be attractive for people to
work on.

EEVDF worked out because you have worked on the scheduler for a long time
and have gained a ton of context on what works and doesn't. It also worked
out because you were more confident that it'd get merged. How do we build
confidence in other developers who want to explore whatever comes after
EEVDF without worrying that it is hopeless to try? sched_ext provides an
outlet for people who aren't already established to take a smaller risk
first, which is likely to lead to more people contributing.

(2) Efforts and developments out of the kernel tree are worthless.

I believe this is too narrow a view. Direct contribution is one form of
contribution but there are many others, including research. EEVDF itself is
based on a research paper. Figuring out what works and sharing them seems as
important as anything to me.

One reason cited for the uselessness is that out-of-tree efforts are often
throw-away and don't build up to anything. There is some truth to this but
the main reason is the difficulty of working with out-of-tree kernel
modifications. Rebase is painful and there is no convenient way to
distribute to users. Some still power through but it's near impossible to
build a user base and community for things that are out-of-tree. sched_ext
solves these problems and the umbrella repo serves as the central repository
for the developers to collaborate and learn from each other. This isn’t a
prediction for the future, it is something which is already actively
happening.

Given the right environment, they will keep flourishing and finding new ways
to improve scheduling. Many of them won't be applicable to the built-in
scheduler, but some will. It's also likely that, in the long term, the
larger scheduler developer base will be directly beneficial to the built-in
scheduler too.

(3) This will lead to vendor-specific fragmentation.

This is already happening with or without sched_ext whether that's in the
form of out-of-tree scheduler patches or people trying to circumvent the
scheduler with creative uses of the RT class.

sched_ext will introduce a different mode of doing it. There are scenarios
where the situation can become a bit worse but I don't believe the
difference would be drastic. Because all sched_ext schedulers have to be
under the GPL, any vendor shipping a sched_ext scheduler to a customer will
have to publish the code. If there are useful ideas we'll be just as free to
take them as now. Also, users would have the benefit that it's a lot easier
to opt out of the vendor's scheduler.

On balance, yes, sched_ext may lead to more or at least different types of
fragmentation, but that seems like a minor downside compared to the overall
benefits especially given that we have to live with some level of
fragmentation no matter what.

(4) sched_ext is a debug tool and we don't merge debug tools.

I think both parts of the above claim are wrong. sched_ext can be used
purely as a debug tool but it's also performant and flexible enough to
readily enable non-trivial practical use cases. We are using it in
production today, and as stated elsewhere in this thread, there are multiple
other companies in various stages of rolling it out to production. It can be
a debug tool, a temporary bridge to field early ideas while working on
something more permanent, a proper solution to specific problems which don't
quite fit the general scheduler (an extreme example would be
standard-dictated scheduling for avionics), and so on.

Also, we merge debug tools all the time. Lockdep is a debug tool. The code
base is full of debug features and components. Why wouldn't we merge
something if it makes the lives of the developers and users better by making
it easier to understand and debug problems? We don't merge printks someone
sprinkled over the code base to debug one particular problem. We do and
should merge tools and frameworks which improve visibility and debugging.


To reiterate our proposition: Let’s please open it up. Scheduling doesn’t
have to be this closed. Many open subsystems survive fine and often thrive
thanks to their openness. sched_ext hooks into the core scheduling but the
contact surface is limited, and, if they ever get in the way, we’ll do our
best to resolve them. The balance in the trade-offs seems pretty obvious.

Thanks.

--
tejun

