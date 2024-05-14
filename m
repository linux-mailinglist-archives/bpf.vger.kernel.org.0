Return-Path: <bpf+bounces-29716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8CE8C5D7B
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 00:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D10D1C210F6
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 22:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F9C181CF6;
	Tue, 14 May 2024 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7EhYSQe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA0180A77
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715724391; cv=none; b=Qx20D08JyAmBKIl28KQOsdxWSqZLKxhCeKgNtgbI7L7Fq23tUdo7H0iB4yavccWZqdS8GF4fslmWkrEUbs79rvGDPTj2SmNHGbYr7qd6t9TPitAH41W9V3onKBA8znqbSTSU79iyGI3KZAA+UBH9vLdTqlw6D5PVytG4VdXMC0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715724391; c=relaxed/simple;
	bh=YbQYOllK15p36m5kWDRm8liM4m46xq9SxG5vSq5wvAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfR+isABIaWB9du9nee7+Y/1dfyK/zxp8XX0WJEkzI58AU4oVo0xYN/Q7lSeKKVyQ2mzVXoRowebhC5TX3t0nZmVbmpjQK9F7VjcEdDHuYwqccOB5ExU04mJYF7Mae2+jtJp5arNRSTBFTM/5T2/VMB6vrkxQdmvLRqGNMubs98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7EhYSQe; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso21525a12.1
        for <bpf@vger.kernel.org>; Tue, 14 May 2024 15:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715724388; x=1716329188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbQYOllK15p36m5kWDRm8liM4m46xq9SxG5vSq5wvAw=;
        b=i7EhYSQeJCRb0qN6yooJKIw0CYeEpRjFEnstGir/vnV7x04a/2IsGAU8sxZ9Gz5yCQ
         qS7Pc9l9zjm00QvSZeDxaIwxri1oBqX9Hee3Llmn97P2A/6CygNQi81YrAmp0v73NUCh
         O+IgR47bzboqpfU7VEOKctd7teZ+jjr8o0UKNBlgn49EzXKhftp5jtKq4h3ZgUCENQwa
         brRLlrB0qEH5ucFn8TZ6nOw+89u4eJlAcJ/moyTXsetao3r0XxRRh5C0OViNjnjSyDmb
         ByrpBZheUFX+H+nXvnJYuLuy/+y1UkmsZC03rlV/7J/BxSmG6dsjoK5PMtwxdPl3L7Y/
         a2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715724388; x=1716329188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbQYOllK15p36m5kWDRm8liM4m46xq9SxG5vSq5wvAw=;
        b=m11cbHLpUupg3UtluG4olnY0byWl3Q80/daKRwLywqMBxvXvgYTwL4WQmPPgNfTsQd
         Oe1/tGyhbUexeaS0Y0KQnnx7OzufCeS9taDFU5fVJ9LfbwDn+oYKSjCp4ii0kI8rSfAj
         INw6FJ9TPlBCdRJChxO7VwJfGIt9+eRlc3X7SY8gX/LnzmOUz/BOWzL3d/xlL1nZfzNs
         5Ui9vLCkq32OeSrmTOtbQ8+zfVY6W073PxYtuU3kkxRDWypDXHYpX3xaG+6KZcICMSDk
         lO7TKJSPSlP2vqVBBJPOvAX7LqKTiE/Ft0RnT4dxl3rcNSFYEZ8MYOTXCVq2KGFR02KW
         gmvg==
X-Forwarded-Encrypted: i=1; AJvYcCURuKbV6+xwkGH1mFpns3z1kzSDHzaWGkMmknmWWhxr5NCpKoOQOnpoGIlW0O/Z0BehgqY8juzLIfokoq37Q7CqUtDN
X-Gm-Message-State: AOJu0YzY31eMtBTQoepGjpRw23g8lhTDEFWjPZTxOQxg8s5alj/R4Muj
	L6aunI0vHddkJd4EZSA0v8h1q0Z3AYODQF0leIcaIUIJsq+73trVM/hRRO7Mr0LbdKLqKEZtlSh
	hdzqUAGIkvZQFPTeCcIKQB0nUfSHyjiu0BzwP
X-Google-Smtp-Source: AGHT+IG9HjsBxTI/Tn+sfvxH+NHeFYU7SU2RHKcB94ear0Rv8qNVvSYjT3h0KkFxeb1WpLvUZiX1L+yR7k1wU5zJKf4=
X-Received: by 2002:a50:85c6:0:b0:573:438c:7789 with SMTP id
 4fb4d7f45d1cf-574ae418342mr688763a12.1.1715724388207; Tue, 14 May 2024
 15:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501151312.635565-1-tj@kernel.org> <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org> <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <ZjgWzhruwo8euPC0@slm.duckdns.org> <20240513080359.GI30852@noisy.programming.kicks-ass.net>
In-Reply-To: <20240513080359.GI30852@noisy.programming.kicks-ass.net>
From: Josh Don <joshdon@google.com>
Date: Tue, 14 May 2024 15:06:16 -0700
Message-ID: <CABk29NtinMd=UOCzGHWUyJvG=Wvj0YASCH6HngQbnXFR_iOwdQ@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, brho@google.com, pjt@google.com, derkling@google.com, 
	haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com, 
	dskarlat@cs.cmu.edu, riel@surriel.com, changwoo@igalia.com, 
	himadrics@inria.fr, memxor@gmail.com, andrea.righi@canonical.com, 
	joel@joelfernandes.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 1:04=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, May 05, 2024 at 01:31:26PM -1000, Tejun Heo wrote:
>
> > > You Google/Facebook are touting collaboration, collaborate on fixing =
it.
> > > Instead of re-posting this over and over. After all, your main
> > > motivation for starting this was the cpu-cgroup overhead.
> >
> > The hierarchical scheduling overhead isn't the main motivation for us. =
We
> > can't use the CPU controller for all workloads and while it'd be nice t=
o
> > improve that,
>
> Hurmph, I had the impression from the earlier threads that this ~5%
> cgroup overhead was most definitely a problem and a motivator for all
> this.
>
> The overhead was prohibitive, it was claimed, and you needed a solution.
> Did not previous versions use this very argument in order to push for
> all this?
>
> By improving the cgroup mess -- I very much agree that the cgroup thing
> is not very nice. This whole argument goes away and we all get a better
> cgroup implementation.

I talked with pjt to get some historical context on these patches, it
sounds like these were some advocated performance improvements but had
fairness issues that Paul pointed out. We're happy to help take a look
at this again, but this is all independent from the motivation for
sched_ext. Sounds like we're on the same page about this now though :)

Thus, cgroups are not a primary motivator for sched_ext. However, one
aspect of cgroups is made quite a bit nicer by the pluggable
scheduling. This is the fact that cgroups are a second class citizen
in CFS, because they are still a compile time option, so everything
must be built to support a thread-only model. That makes it really
hard to write group schedulers; fundamentally, task placement, load
balancing, etc. is operating on lists of tasks, not lists of cgroups.
As you can see, improving hierarchical performance of cgroups is nice
to have but not related to this goal.

> Writing a custom scheduler isn't that hard, simply ripping out
> fair_sched_class and replacing it with something simple really isn't
> *that* hard.

Getting that custom scheduler back into upstream is pretty hard
though. I like Chris' analogy of filesystems because it gives a really
good sense of what a bigger ecosystem might look like with schedulers.
It simply is not feasible to implement certain types of behavior in
CFS, because the behavior is too specialized for certain classes of
workloads, and the model/heuristics could not be made to work in a
general purpose scheduling environment, which CFS strives to achieve.
Taking these ideas and putting them into a different scheduling class
is also a bit of a non-starter. The scheduler is optimized to have
most tasks running in a single scheduling class (CFS), and adding
additional classes both adds additional static overhead, as well as
complexity from dealing with the need to ensure non-starvation of
lower priority sched classes (due to the strict priority ordering of
sched classes).

As an example, a few years ago Xi posted a simple new scheduling class
optimized for high frequency context switching
(https://lkml.org/lkml/2019/9/6/177), which was nack'd offline.
There's an argument to be made that some of the functionality there
could have been rolled into RT, but I think it serves as a good
example of the friction of adding even simple new sched classes.

Pluggable scheduling helps to fill the gap here for policies that have
elements making them not a good fit for CFS, given that we don't want
a plethora of new sched classes in the tree. That's not to say that
just because a policy cannot be fully integrated into CFS it has no
benefit for upstream contribution; there are pieces that might make
sense to adapt to CFS. For example, we've been experimenting with a
policy that schedules based on cgroups rather than simply tasks, and
uses that to provide better CCX locality for the cgroup, with better
control of how the group spills over to remote CCX. The group based
scheduling nature cannot be easily integrated into CFS, as described
above, but the CCX scheduling portion could find its way into CFS by
means of a more nuanced evaluation of migration_cost, or new placement
heuristics.

> But you can easily ignore cgroups, uclamp and a ton of other stuff and
> still boot and play around.

Please don't underestimate the value that swapping policies around at
runtime has. Sure, playing around in a VM isn't bad, but getting
performance data from real hardware can take quite a while between
boots, not including the time to actually restart the workload and
have it warmed up. We're talking several orders of magnitude more
latency in the iterative policy development and analysis portion here.
I imagine it would have been nice, for example, to swap in and out
successive versions of EEVDF while hackbench was actively running, and
observe how each swap out changes running averages of latency, etc.
Even in a world where we committed to having a single scheduler, I
think it would be nice if we had in-tree CFS BPF programs that
implemented several of the hooks, just for the purpose of improving
development velocity. What BPF has done for networking could be made
to improve heuristic heavy areas like select_task_rq, for example.

My point here is that allowing new sched policies is a big benefit,
but also placing those policies in BPF is another (separate) big
benefit that sched_ext provides natively.

Best,
Josh

