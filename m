Return-Path: <bpf+bounces-28646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B8C8BC4B9
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 01:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C8C281F36
	for <lists+bpf@lfdr.de>; Sun,  5 May 2024 23:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ED9140E40;
	Sun,  5 May 2024 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9MGABo4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E6140397;
	Sun,  5 May 2024 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714951890; cv=none; b=QTpmjjzIZvvY77b9MD2E+xPrNZfa+srQ5EaPrsDM3RKRGBg/dKV87h8A1i3eziljccOlUydOwyOk4MKfEyqkw1LOX5krMP95T9UYIxt4CmpEbibBMP8S7dyCShpPKPwgZS1mGUu4bCSa4fmnaLPNuk/UKk9aS7t1xj4ROevvYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714951890; c=relaxed/simple;
	bh=z1GbYrNlU3NE8YmAZlRg0cXAT+Isi/QijAv7NzXwz4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkcCaejuvXTwBewvSD0ZXgF7pmxLQnkt4NvgieEX3Y/ukWlKbtkEWTHgY+Xepi+e/aNs1yuW+OjD+MR5KuyM/887Y5TSsZcVSL/pPUYb+cEcxsfevGZq5IoUjdx/PtlXcWwpRRTmJrnqLmxObEC5/2xPO6aAp167C8KM6ZwFTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9MGABo4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f4521ad6c0so834885b3a.0;
        Sun, 05 May 2024 16:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714951888; x=1715556688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPunWSndy5BFPEsBc4QtGhdsMU20PDz/+dHvOyBwBqw=;
        b=E9MGABo4Tl9CKHZp1GJIrqqQ7HtTI9BHlkZL0dBvjHk8PDbjTMSUutJkB3Gsa5kWRV
         ZxSJHwHG5WZW5HXCWueTHmQ3DMqcT/ZhnkUPRXuddu4Gii4IKQy7JQCzBNhCQ7lry8p/
         wSZrf993Z2m2dDpGUjo8yzZZ4DsibcrjJKj641L4ESiydZCzovkcnV2aGPMU+h9k1B/v
         52u7WUiWs7q7ccn/wnOCxodidNcn0sZTGGaGsAUXen92erkgc+5EEkdBzQPNwiq4ZuOy
         uDl1jw7nVA3LN4aMpT0wBeTJUPn3rA9K53tgPeQvv238tGcnhAtY6STZMcX1uMBbyrbI
         ts3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714951888; x=1715556688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPunWSndy5BFPEsBc4QtGhdsMU20PDz/+dHvOyBwBqw=;
        b=Hf97bTvLSUOiE3IpdMOiCNrmjV4XW1E70RFMAyMAcEPpt4A24zlAR1eyXQOEu8jnEp
         9NfUjXpLhgIxtjBygOlg9fbxyU5pjFxvC9B7IKz8NgDk5h4jg033NbgbeU43guNbz5a5
         7y+nU7KdFE9Wpq2yQdve1XV+axdCZ1+KuoUEOQST6STfzmhbyDDGAkjtFk8SAbW5DIkQ
         3adgxlSMwWjhaHYE6JIH5w7K5KuH1/NT4fJzGBu9dpfNxIP69iBl3fbyucoxu9kT2oX/
         K3UFOE7gnJ0zNBhXbTMHBuAkkzPRNBDvKGNoA8c5YQB2LKa/9xDvQkCRYUnDHWtpNuYi
         TTcA==
X-Forwarded-Encrypted: i=1; AJvYcCXyp3Ng0vYy/71NGrW4YAYTCJS9MZIZlrvol4CPFMJvCEqqmWTSnlhufsInfoWlWSttTaU9JIDJow486bYNO8KwquJ06mVEO0EnuiAxv5y2YuBjDRC+L3F/j8cciHhDbH9g
X-Gm-Message-State: AOJu0YwKq7vj3NOUsnYehwBrVe7gf4y6/wMh773RsaqWyv3DrbWE4qX2
	ja8mN9n6RdoAL1/kKEbZg4pKC7YamzJIqMr2Ed6KUA9J51b57F0uwdcElFL5
X-Google-Smtp-Source: AGHT+IHjQJGro/+7Hl6lgqsYvUs6d9ceSTRyuGJW5VJma6LeoOqGAENnk7OLvAPWuX9tDR+9VqavzQ==
X-Received: by 2002:a05:6a20:a105:b0:1ad:7ff5:cb38 with SMTP id q5-20020a056a20a10500b001ad7ff5cb38mr8892202pzk.60.1714951888294;
        Sun, 05 May 2024 16:31:28 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id h26-20020aa786da000000b006f442343c6esm5918664pfo.200.2024.05.05.16.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 16:31:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 5 May 2024 13:31:26 -1000
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
Message-ID: <ZjgWzhruwo8euPC0@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503085232.GC30852@noisy.programming.kicks-ass.net>

Hello,

On Fri, May 03, 2024 at 10:52:32AM +0200, Peter Zijlstra wrote:
> On Thu, May 02, 2024 at 09:20:15AM -1000, Tejun Heo wrote:
> > We can resurrect the discussion on that patchset but how is that connected
> > to sched_ext? 
> 
> I'm absolutely not taking any of this until at the very least the cgroup
> situation that's been created is solved. And even then, I fundamentally
> believe the approach to be detrimental to the scheduler eco-system.

Please see below for more on the flattened hierarchy patchset. However, no
matter how that discussion works out, what you seem to be suggesting -
suspending discussion or further push for upstream on sched_ext until a
mostly unrelated work is done - doesn't seem reasonable, especially when
most of the input that you have provided is not constructive.

Even if we agree that, for some reason, the two projects are linked and Meta
and Google owe to push the flattened hierarchy patchset to land sched_ext
upstream, it should be obvious how your proposition puts us in an impossible
spot - A is a prerequisite for B but B isn't going to happen. That's not a
motivating situation for anyone.

If working on the flattened hierarchy patchset is something you want us to
commit to as a gesture of good will, we can surely consider that, but that
shouldn't block further discussions on sched_ext or its upstreaming.

(I reordered your comment about the number of sched_ext schedulers and
developer attention towards the end of the reply to avoid jumping back and
forth between subjects.)

> You guys Google/Facebook got us the cgroup thing, Google did a lot of

We can't divorce ourselves completely from the organizations that we work
for but the above is still a pretty broad stroke. Neither David nor I was
involved in the CPU controller design or implementation and I don't think
it's the same group of people on the Google side either. We sure can discuss
how to proceed on the flattened hierarchy patchset but I don't think the
picture you're painting is a fair depiction of the overall situation.

> the work for cpu-cgroup, and now you Facebook say you can't live with it
> because it's too expensive. Yes Rik did put a lot of effort into it, but
> Google shot it down. What am I to do?

You could have encouraged and guided the project if it felt important
enough. You didn't have to but that was an option.

> You Google/Facebook are touting collaboration, collaborate on fixing it.
> Instead of re-posting this over and over. After all, your main
> motivation for starting this was the cpu-cgroup overhead.

The hierarchical scheduling overhead isn't the main motivation for us. We
can't use the CPU controller for all workloads and while it'd be nice to
improve that, it's pretty easy to work around especially with constantly
increasing number of CPUs. Currently, most sched_ext experiments are without
cgroups and even when cgroups are considered, they're just used as grouping
hints.

In fact, we want to try implementing hierarchical scheduling by dynamically
soft-affinitizing cgroups to CPUs, which would be a bridge too far for the
in-kernel scheduler, at least for now, as it wouldn't be able to handle
custom affinities properly, but it is an idea worth exploring. Enabling
experiments like that is definitely one of our main motivations.

> From where I'm sitting, you created a problem (cpu-cgroup) and now
> you're creating an even bigger problem as a work-around. Very much not
> appreciated.

I have a hard time agreeing. These projects don't overlap all that much.
Their scopes are wildly different. That said, if this is somehow the
blocker, we can talk and try to find a solution but such a solution would
have to be reasonable from our end too. How else would it work?

> Witness the metric ton of toy schedulers written for it, that's all
> effort not put into improving the existing code.

This view works only if you assume that the entire world contains only a
handful of developers who can work on schedulers. The only way that would be
the case is if the barrier of entry is raised unreasonably high. Sometimes a
high barrier of entry can't be avoided or is beneficial. However, if it's
pushed up high enough to leave only a handful of people to work on an area
as large as scheduling, something probably is wrong.

You know better than anyone that there's no such thing as the perfect
scheduler for all, or even most, workloads. There are too many interacting
factors and second-order effects for a single implementation, no matter how
advanced, to be perfect or even great for the multitudes of situations that
scheduling encounters. With hardware and workloads becoming more complex,
the situation isn't getting any better. This partially explains why we can
easily achieve significantly better behaviors for specific workloads even
with a toy scheduler which is just there to demonstrate an idea.

The built-in scheduler has to be good enough for everyone, and, thanks to
the effort of you and the other sched maintainers, it serves that role
admirably. However, that requirement also comes with stringent constraints.
Radical ideas are difficult to play with. Each change has to make some sense
for every use case. Nothing drastic can be introduced unless the future path
can reasonably be forecast. So, development efforts must be highly
orchestrated and stay consistent which justifies a higher barrier of entry
and strict control.

Yet, the many different ways that even simple schedulers can demonstrates
sometimes significant behavior and performance benefits for specific
workloads suggest that there are a lot of low hanging fruits in the area.
Low hanging fruits that we can't easily reach from our current local
optimum. A single implementation which has to satisfy all users all the time
is unlikely to be an effective vehicle for mapping out such landscape.

I believe we agree that we want more people contributing to the scheduling
area. We need that. However, I have a hard time seeing how that would be
achieved in the current structure. Most people can't afford to sink six
months, a year, two years into a project only to eventually be nacked
without any way to deploy and prove their ideas and efforts. Unfortunately,
that is where we end up today in many cases.

There are many smart people with bright ideas just outside the fence who are
eager to develop, tune and even just play with schedulers. I believe they
will flourish when they can work in an environment where scheduling
experimentation is accessible and encouraged. In fact, we are already seeing
that. Out of the four non-trivial sched_ext schedulers, three are either
primarily driven by or have significant contributions from people who had
not and wouldn't have worked on the in-kernel schedulers at all.

So, here's my proposition. Let's please open it up. sched_ext hooks into
sched infra but the contact surface is limited and we'll try our best to
stay out of your way. I can't promise that it won't ever get in your way,
but, if it ever does, just ping me and David. Resolving such situations
would be our highest priority. Let us and others try out crazy ideas and
find out what works.

Thanks.

-- 
tejun

