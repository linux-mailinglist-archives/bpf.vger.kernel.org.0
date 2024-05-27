Return-Path: <bpf+bounces-30697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440348D0E98
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 22:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683431C2128A
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 20:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F06815A878;
	Mon, 27 May 2024 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="L0mrR4u7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0183A1DA
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716841764; cv=none; b=UTYLqa3WcEc8KGzNfQXx3r1Slma4rnfl4A49sunrVu9siBFM3uMwb2iDQbehDv+yc8WfmrmKJq6aYNYWvjNaNWm2BWutMIvnD/dQ7pcdHwVfplIa/gEi/uZXov9zrUca1LlNUozT1h+1IpJUtfotlXHPw2ZRQroF3XATk1AXzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716841764; c=relaxed/simple;
	bh=CDOLrRFs29pR9xmn5+FAu/xBrbZj3vSMC6L+qs+L2x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef8hhdHpX3fuoNXX1D726xZW6violQbYl0yVksRp6/D1TpcUFh3bDMFg+09iisX2MX05aZHVi8qyFHz+wU5uN1YgPTZb4bC7WJtz8kXpICAsGm1iWlPl7IOSLLBoEhmuP3i3a8X/CMqKqytKtBUOYg913zZ9p9CuL93WhyyiKRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=L0mrR4u7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-357d533b744so93613f8f.2
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716841760; x=1717446560; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YLRqaPAUPm8frI3jY2q5nOzb5PjVlz04d9/9cjDNXhA=;
        b=L0mrR4u7AqD0VGsBwVZMGBy30Qt3eQfFlE5Iqom5MSehVHbazZk+CZNQGbu43MyVhd
         JJ5HiTyLHG+k0UddFskv5Lec3upJ11eqs1oh84V/Dbx/qaU/pFS3UktiEAdfMAYxl6ua
         KdhlxJXSvGEEv5mAMXCuTSkwX7umRM5btVDK1wzvGTSa6VPAQkbSmH0g5FA2zndstmli
         XpeKpFeUihNVs5kr842vVdnijG9GJiQ1lCU6Whlj+uFTkDIo4k7nDoW8YFptSQmpym85
         v8RnA6v5qdjdX10wxkmO34sK+f/8k2tK1Xv8qxyUU3FvHrs4lxAfvoCfRoDxCezHdrDW
         R4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716841760; x=1717446560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLRqaPAUPm8frI3jY2q5nOzb5PjVlz04d9/9cjDNXhA=;
        b=rtTjgtc5J19nePZ2k4CHhpaBg4pRajAvvvCYev5eM5LSWIb704gzBw9Uo8Lvr8RzT5
         SFwI4vy1sFSNyoUCB3Zb9s7fFTNOlIfMA/EfE/QkG2denhoxkURY+FyZmTGgElDQeKac
         UYPAHt13u1lhr7i9KDG17bSQGCjNdKCUI3qb0aCjJVT4HJhTDxeestkRo4fxr0ti06aK
         PjNRECCKhCsr+OZ1mGY5n+waEjcP8VGx6drASzw4+562qq7nckGQbVQaio6MEOlNeTzw
         yCJzA2qXDFko9JetZuIevanmDvAiyhwgyguuEporNxuKwFUhTAq4zQ+jMIWfSMb44Vq4
         +u6w==
X-Forwarded-Encrypted: i=1; AJvYcCVol1xuXzvQYqNCvHsyoaaq/tB7QMbGIBuDZBErwfdGGRjW1G6jbcPKXHLlCfAVm16zzb0mPbO5nsrc1K3YekYTQiQg
X-Gm-Message-State: AOJu0YwyIGKCqibb+1wYKm1n/TSvzjf71kiyDPWUlK5IhzwBVzEAE941
	V3v0+jMtGTDC852M9oW3qIJczEFSycON4ItqTtGN20eNkRhOMBzFDWC02RJd2/k=
X-Google-Smtp-Source: AGHT+IFc4YOic6oqTTo0AXpDlL/eDNqUdNFvpRFHeTClIgrf8XzXM7VVpVgfPVm1UEmwnpFFBXMCvg==
X-Received: by 2002:a05:6000:1284:b0:354:de3b:a3f4 with SMTP id ffacd0b85a97d-35526c6f46bmr5756593f8f.40.1716841759617;
        Mon, 27 May 2024 13:29:19 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090c20sm9772278f8f.62.2024.05.27.13.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:29:19 -0700 (PDT)
Date: Mon, 27 May 2024 21:29:17 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
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
Message-ID: <20240527202917.awr7mw3yr7plytgw@airbuntu>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <ZjgWzhruwo8euPC0@slm.duckdns.org>
 <20240513080359.GI30852@noisy.programming.kicks-ass.net>
 <20240513142646.4dc5484d@rorschach.local.home>
 <20240514000715.4765jfpwi5ovlizj@airbuntu>
 <20240517095806.GJ30852@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517095806.GJ30852@noisy.programming.kicks-ass.net>

On 05/17/24 11:58, Peter Zijlstra wrote:

> > I really don't think the problems we have are because of EEVDF vs CFS vs
> > anything else. Other major OSes have one scheduler, but what they exceed on is
> > providing better QoS interfaces and mechanism to handle specific scenarios that
> > Linux lacks.
> 
> Quite possibly. The immediate problem being that adding interfaces is
> terrifying. Linus has a rather strong opinion about breaking stuff, and
> getting this wrong will very quickly result in a paint-into-corner type
> problem.

We need to move forward though. Let us find an approach and agree with Linus on
what will constitute regressions when things have to disappear.

My general worry is more about default behavior not just interfaces. As pointed
out below, the default behavior favoured throughput for a long time because
folks who care about throughput were more vocal, but it seems we have a silent
majority problem of people who need latency by default but find no path
forward.

And of course it'll never be possible to make them both happy by default.
Regression reports in this area need to consider the wider impact on other
users when deciding whether it needs to be fixed or not.

We do seem to be held hostages sometimes by older systems/workloads who IMHO if
can't move to use new facilities provided, have no good reason to complain
about regressions as we need to look forward for what new workloads and system
need by default. The world is moving on too fast - but we can't catch up due to
these regression reports. We need a better balance IMHO.

> 
> We can/could add fields to sched_attr under the understanding that
> they're purely optional and try thing, *however* too many such fields
> and we're up a creek again.

My personal vision on this is this

	https://lore.kernel.org/lkml/20230916213316.p36nhgnibsidoggt@airbuntu/

We don't need to continue to add new fields as this is a problem actually when
it comes to integrating to libc (who yet to have proper wrappers in pthreads
for the things we added). A u32 should be virtually infinite number of hints.
We should be able to deprecate at ease by making a specific hint type return an
error when it longer supported (-ENOSYS). We can even create uclamp alias for
this (that is called performance_hint given how widely people interpret uclamp
as a bandwidth hint) and make it the soruce of QoS truth.

> > Similarly for latency vs throughput. What is the correct way to
> > write an application to provide this info? Then we can ask what is missing in
> > the scheduler to enable this.
> 
> Right, so the EEVDF thing is a start here. By providing a per task
> request size, applications can indicate if they want frequent and short
> activations or more infrequent longer activations.
> 
> An application can know it's (average) activation time, the kernel has
> no clue when work starts and is completed. Applications can fairly
> trivially measure this using CLOCK_THREAD_CPUTIME_ID reads before and
> after and communicate this (very much like SCHED_DEADLINE).

I fear the concept of time in userspace will be hard to get right without some
further help from us due to DVFS/HMP having a Black Hole effect and causing
extreme Time Dilution problem. It is actually a problem for schedutil that I am
trying to find a reasonable fix for as part of my magic margins series.  On one
system I ran a test on, it took 30ms to take off from util 0. And the system
stayed running at the lowest frequency for 42ms! Our utilization invariance is
very good for estimating compute demand, but terrible for bursty tasks - which
I are very common on interactive systems. I think this is a cause of many
'latency' woos in general. Things can end up running slower for longer. But
this is a different problem for a different series/day.

FWIW even for userspace trying to create dynamic uclamp control are struggling
because they can't measure time reliable. A task can seem happy, but only
because something else on another CPU with shared policy had a 'heavy' tasks
running. As soon as this goes to sleep things look really different from the
tasks runtime perspective. It was running super fast by accident.

The average time will be hard to get right in general due to the interactive
nature for some workloads and things could have big variations in practice
based on my experience. Ie; the frame to frame variations could be larger than
expected.

I think it is a helpful interface, but won't address all workload demands. The
thing I care about for example they really want to run ASAP and that's it. They
could run for a longer period of time, or a shorter period of time. next_buddy
type of behavior will help these tasks. But might need to be stronger than
current implementation. I am trying to find out..

And oversubscribed scenarios are important. It is common to have a sudden surge
of activities that cause delays that requires load balancer's help to better
distribute as some CPUs can get less busy sooner but wakeup preemption won't
save those already enqueued tasks from getting CPU time ASAP without some
additional external trigger. In contrary, I do see problems today (older CFS
LTS kernel) where a surge of short running tasks can delay enqueued tasks
considerably. I have no clue what's going on yet. I don't have a reproducer but
creeps up often enough when I look at traces.

Generally I think latency is more important in majority of systems these days
and it might be better to default to more responsive system and let those who
want throughput to opt-in, rather than the other way around.

In theory, there should be (very) few tasks in the system that are actually
need the next_buddy type of behavior to skip the queue and run ASAP if the
average default latency is good (1-2ms).

I also think we need to enable HRTICK by default too. We will have more timely
preemption points then. I generally think sched_feat should be a good way to
give admins the power to control certain aspects of the scheduler. We can also
make uclamp a sched_feat and ensure it can be made available on any system
- unlike today where it's not enabled by default on Debian at least and this
hit me and looks like the Asahi folks who managed to get good power
improvements and thankfully has higher weight than me asking for this to be
enabled by default. Read Energy Aware Scheduling section here

	https://asahilinux.org/2024/01/fedora-asahi-new/

As a general topic for discussion not just for scheduler, there are core
features that must always be there from programmer's perspective. We are
shooting ourselves in the foot here by being too flexible with our usage of
CONFIGs, IMHO :)

Too much random babbling from my side maybe, but I think there's a series of
seemingly independent issues that are actually interconnected and one is
leading to the other but people are trying to find the one root-cause which
I don't think exists.

> 
> Anyway, yes, userspace needs to change and provide more information. The
> trick ofcourse is figuring out which bit of information is critical /
> useful etc.
> 
> There is a definite limit on the amount of constraints you want to solve
> at runtime.

+1

> 
> Everybody going off and hacking their own thing does not help, we need
> collaboration to figure out what it is that is needed.

+2 - I've been trying to snoop on many use cases to further understand what
truly goes wrong. Some of the issues I've seen were actually due to bugs in the
kernel. Other issues could already be fixed with existing facilities, but
users didn't know how to use them. So the task is not easy to untangle.

> 
> > Note the original min/wakeup_granularity_ns, latency_ns etc were tuned by
> > default for throughput by the way (server market bias). You can manipulate
> > those and get better latencies.
> 
> The immediate problem with those knobs is that they are system wide. But
> yes, everybody was randomly poking them knobs, sometimes in obviously
> insane ways.

Yes. I fear though that because they were system wide is that the
out-of-the-box experience for many (especially with CFS defaults) were bad
latencies. I like the new 3ms base_slice_ns, but I think for many who care
about 120Hz refresh for example this is too large. It's almost half of the
frame time.

The TICK value plays a big role too. On 4ms TICK, this 3ms will become 4ms if
wakeup preemption decided not to preempt immediately.

Is this 3ms a constant by the way? I see it still depends on NR_CPUS, but
I read it on different systems and I got 3ms. I think having a constant value
across all systems makes more sense. With EAS (which I think someone should put
effort to enable it for SMP systems) we tend to pack. And a lot of systems have
too few of CPUs and things being packed is common case - I think the rationale
in the past was that we distribute tasks to idle CPUs at wake up which is good
for latency, but I don't know if this is a good assumption to make still to
decide these values.

And looks like we have a bug. I didn't spend a lot of time on studying EEVDF
impact on latencies, but I had this simple run with my pi_test [1]. You need
sched-analyzer/sched-analyzer-pp somewhere in your path which you can download
from [2]. setup Perfetto traced [3]. Running on 6.8.8 M1 Mac Mini

	./run.sh 0 0 0

	=====================================
	::  2255 | pi_test | ['./pi_test'] ::
	====================================================================================================
	----------------------------------------------------------------------------------------------------
	───────────────────────────── Sum Time in State Exclude Sleeping (ms) ──────────────────────────────
	R       ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4533.25
	Running ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4533.75

	────────────────────────────── % Time in State Exclude Sleeping (ms) ───────────────────────────────
	R       ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 50.0
	Running ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 50.0

	─────────────────────────────────── Sum Time Running on CPU (ms) ───────────────────────────────────
	CPU0.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4533.75

	──────────────────────────────────── % Time Running on CPU (ms) ────────────────────────────────────
	CPU0.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 100.0

	Time in State (ms):
	----------------------------------------------------------------------------------------------------
		  count  mean   std  min  50%  75%  90%   95%  99%   max
	state
	R        1149.0  3.95  1.12 -0.0  4.0  4.0  6.0  6.01  7.0  7.01
	Running  1149.0  3.95  1.11  0.0  4.0  4.0  6.0  6.00  7.0  7.00

	Time Running on CPU (ms):
	----------------------------------------------------------------------------------------------------
	      count  mean   std  min  50%  75%  90%  95%  99%  max
	cpu
	0.0  1149.0  3.95  1.11  0.0  4.0  4.0  6.0  6.0  7.0  7.0



	=========================================
	::  2257 | pi_test_low | ['./pi_test'] ::
	====================================================================================================
	----------------------------------------------------------------------------------------------------
	───────────────────────────── Sum Time in State Exclude Sleeping (ms) ──────────────────────────────
	R       ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4533.89
	Running ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4533.11

	────────────────────────────── % Time in State Exclude Sleeping (ms) ───────────────────────────────
	R       ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 50.0
	Running ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 50.0

	─────────────────────────────────── Sum Time Running on CPU (ms) ───────────────────────────────────
	CPU0.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4533.11

	──────────────────────────────────── % Time Running on CPU (ms) ────────────────────────────────────
	CPU0.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 100.0

	Time in State (ms):
	----------------------------------------------------------------------------------------------------
		  count  mean   std  min  50%  75%  90%  95%  99%  max
	state
	R        1154.0  3.93  1.14  0.0  4.0  4.0  6.0  6.0  7.0  7.0
	Running  1154.0  3.93  1.13 -0.0  4.0  4.0  6.0  6.0  7.0  7.0

	Time Running on CPU (ms):
	----------------------------------------------------------------------------------------------------
	      count  mean   std  min  50%  75%  90%  95%  99%  max
	cpu
	0.0  1154.0  3.93  1.13 -0.0  4.0  4.0  6.0  6.0  7.0  7.0

Note that the average RUNNING (R is for RUNNABLE) time is ~4ms instead of 3ms.
Oour P90 and max values are almost double the 3ms slice. I am running with 1ms
TICK, so I think there has to be a bug somewhere preventing timely preemption..

If I enable HRTICK it looks much better

	=====================================
	::  2517 | pi_test | ['./pi_test'] ::
	====================================================================================================
	----------------------------------------------------------------------------------------------------
	───────────────────────────── Sum Time in State Exclude Sleeping (ms) ──────────────────────────────
	R       ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4911.05
	Running ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4911.96

	────────────────────────────── % Time in State Exclude Sleeping (ms) ───────────────────────────────
	R       ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 50.0
	Running ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 50.0

	─────────────────────────────────── Sum Time Running on CPU (ms) ───────────────────────────────────
	CPU0.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4911.96

	──────────────────────────────────── % Time Running on CPU (ms) ────────────────────────────────────
	CPU0.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 100.0

	Time in State (ms):
	----------------------------------------------------------------------------------------------------
		  count  mean   std  min  50%  75%  90%  95%   99%   max
	state
	R        1645.0  2.99  0.22  0.0  3.0  3.0  3.0  3.0  3.01  3.97
	Running  1646.0  2.98  0.17 -0.0  3.0  3.0  3.0  3.0  3.00  3.01

	Time Running on CPU (ms):
	----------------------------------------------------------------------------------------------------
	      count  mean   std  min  50%  75%  90%  95%  99%   max
	cpu
	0.0  1646.0  2.98  0.17 -0.0  3.0  3.0  3.0  3.0  3.0  3.01



	=========================================
	::  2519 | pi_test_low | ['./pi_test'] ::
	====================================================================================================
	----------------------------------------------------------------------------------------------------
	───────────────────────────── Sum Time in State Exclude Sleeping (ms) ──────────────────────────────
	R       ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4912.11
	Running ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4910.89

	────────────────────────────── % Time in State Exclude Sleeping (ms) ───────────────────────────────
	R       ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 50.01
	Running ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 49.99

	─────────────────────────────────── Sum Time Running on CPU (ms) ───────────────────────────────────
	CPU0.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4910.89

	──────────────────────────────────── % Time Running on CPU (ms) ────────────────────────────────────
	CPU0.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 100.0

	Time in State (ms):
	----------------------------------------------------------------------------------------------------
		  count  mean   std   min  50%  75%  90%  95%   99%   max
	state
	R        1644.0  2.99  0.19 -0.00  3.0  3.0  3.0  3.0  3.01  3.95
	Running  1643.0  2.99  0.16  0.51  3.0  3.0  3.0  3.0  3.00  3.01

	Time Running on CPU (ms):
	----------------------------------------------------------------------------------------------------
	      count  mean   std   min  50%  75%  90%  95%  99%   max
	cpu
	0.0  1643.0  2.99  0.16  0.51  3.0  3.0  3.0  3.0  3.0  3.01

[1] https://github.com/qais-yousef/pi_test
[2] https://github.com/qais-yousef/sched-analyzer/releases
[3] https://github.com/qais-yousef/sched-analyzer?tab=readme-ov-file#perfetto-mode

> 
> > FWIW IMO the biggest issues I see in the scheduler is that its testability and
> > debuggability is hard. I think BPF can be a good fit for that. For the latter
> > I started this project, yet I am still trying to figure out how to add tracer
> > for the difficult paths to help people more easily report when a bad decision
> > has happened to provide more info about the internal state of the scheduler, in
> > hope to accelerate the process of finding solutions. 
> 
> So the pitfalls here are that exposing that information for debug
> purposes can/will lead to people consuming this information for
> non-debug purposes and then when we want to change things we're stuck
> because suddenly someone relies something we believed was an
> implementation detail :/
> 
> I've been bitten by this before and this is why I'm so very hesitant to
> put tracepoints in the scheduler.

I was hoping the 'bare' tracepoint approach I added is okay? I don't need more
than that. Function signature and structure internals can never be ABIs.
I already had to deal with util_est changes across kernel versions.

If our emperor penguin is reading, it'd be great if he has new thoughts on
debug features and userspace dependency. I think we really need to help people
to better debug and understand why things aren't behaving as they anticipate.
Or at least make it easier to provide info on the list to help us understand
what could have gone wrong.

Your concerns are real. These should not prevent code from moving on without
worrying about breakages. If anyone latched into those I hope we can tell them
sorry, but this one is expected breakage.. I think by design the bare
tracepoints can never be ABI though.

> > From what I see, I am hitting bugs here and there
> > all the time. But they are hard to debug to truly understand where things went
> > wrong. Like this one for example where PTHREAD_PRIO_PI is a NOP for fair tasks.
> > Many thought using this flag doesn't help (rather than buggy)..
> 
> Yay for the terminal backlog :/ I'll try and have a look.

It seems hard to fix without Proxy Execution :( If you have ideas for
a temporary solution that'd be great. But looks like we just need to get PE
merged and available for users - I think John's series doesn't tie this to
futex_pi yet.

