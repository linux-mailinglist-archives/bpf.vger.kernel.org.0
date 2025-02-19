Return-Path: <bpf+bounces-52001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E61C6A3CD67
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 00:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3DB3B870C
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 23:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AB225D550;
	Wed, 19 Feb 2025 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDSxfMT6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38981CAA65;
	Wed, 19 Feb 2025 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007326; cv=none; b=TGKtEmlm3o1NYhae3yp3Ecl5Fg91n+OF1yNph1y8D3oyPjc7PiVjcxmOuYRzSiybn4E4MRH2RP0vFyC9clRgGPzY5BR4vISdHYD/xYRPzgT2Gj/B/WRj0lbDCWzOrYdU3AyMemeNquhHed02UJKUmA77QBcNkmAk7cfaUGHdfJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007326; c=relaxed/simple;
	bh=NFs28h4oZOzYikgX/E3b+bN1P4cHes1dBFWXJ6/mDn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLPLzTNuzRXz8CciYOquSqGmr8sghFskrBVHbja7tDR8FTtXKvTwVCck5tzupgqisDT24Un2laD36Mb89vNGebg+f5gSRIPXrmbSgimo728KYE8HGw4VbOHAaXCgSp7VXNOAdx6312yzA/QiIlDaGNb322QYOXiYTW1q9kT5Htw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDSxfMT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C75C4CED1;
	Wed, 19 Feb 2025 23:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740007326;
	bh=NFs28h4oZOzYikgX/E3b+bN1P4cHes1dBFWXJ6/mDn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDSxfMT6Cm6ysmBWptGMH0zGmHcLGNQzd9vCPGvGua8I9QEH9UEqA1Ncs7Z8MPFKt
	 H/jiT3D2hyHXQKUBelyw5bX0Gk+mR5sllcA341TQJI0ZdatufBPHxZMUr3gH2Af/NC
	 rs7mDUe8FfoO7r7c7dipQtoiBiHQsLbyb5PKRiYsuMDdmvcVoQlKzzjQAal3IKAOhb
	 Ux5vHvMZ890a84uFT3uONiHFzpVDNGg8A+e6WL+nFhSpEjRgEzg/t+xmeDBGqo0Ann
	 +F6woRzasxCKkXQgHac0gSFDbkbYbSJ/GckL405ei+yXOmbc4oYjE//RMRY6J1GNHA
	 qOZKdknM2hXJA==
Date: Wed, 19 Feb 2025 15:22:03 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Atish Kumar Patra <atishp@rivosinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>,
	Beeman Strong <beeman@rivosinc.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
Message-ID: <Z7Znm47DJcpAsvGI@google.com>
References: <Z51RxQslsfSrW2ub@google.com>
 <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>
 <Z6FcHJFYGc7HzSna@google.com>
 <CAP-5=fW9f2mxuTV2FGCdhKm7M9g8v6VsLJJXTPTLRr5tUv9rOA@mail.gmail.com>
 <Z6LFp5jiED7_-weN@google.com>
 <CAP-5=fU6WSOK_N0NoLcMSSdaWAkdC2DUBwLqsLn_KA7m6dJyeQ@mail.gmail.com>
 <Z6RD7NuT9IPhOkIV@google.com>
 <CAP-5=fV8rRMQyMDuy1vcxyEX9Gf8x0QJdVEP-K5krBec_A7mpA@mail.gmail.com>
 <Z6WPmYCJcc6pPKDA@google.com>
 <CAP-5=fU0263rZx+i_dpeBWVUiKHuNNp4ER7WhDe2zHPUsq=wmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU0263rZx+i_dpeBWVUiKHuNNp4ER7WhDe2zHPUsq=wmw@mail.gmail.com>

On Thu, Feb 06, 2025 at 10:15:43PM -0800, Ian Rogers wrote:
> On Thu, Feb 6, 2025 at 8:44 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Wed, Feb 05, 2025 at 11:44:57PM -0800, Ian Rogers wrote:
> > > Why was adding a PMU to an event name, working around ARM's PMU bug,
> > > such an unsurmontable problem that the original change was reverted?
> > > Because 1 person didn't want to have to write a PMU prefix and
> > > considered it a monumental regression having to do so.
> >
> > Because it's a legacy event 'cycles' and he didn't expect the wildcard
> > behavior?
> 
> And someone who say with perf v6.14 can type `perf stat -e data_read
> ...` and then with your proposal now has to type `perf stat -e
> uncore_imc_free_running/data_read/ ...` because data_read isn't a core
> event, this is expected behavior because the error message mentions
> perf list?

I still think it's better to have PMU with events (and people do that)
but I feel like I have to drop my argument.  It's there for a while and
I don't want to break things..

> 
> > > > 1. RISC-V is working on a solution with the current status and it's not
> > > >    absoluted needed to change the current behavior.
> > >
> > > They said to you directly it was what they wanted, that's why I
> > > reposted this change and it is, has always been, in the cover letter.
> > > They've then followed up expressing their desire for this behavior but
> > > having to have a plan b as the original change was reverted and you
> > > are blocking this change landing.
> >
> > So they have the plan B.  But still prefer overriding legacy with JSON?
> 
> Yes.
> 
> > > > 2. Apple-M is fixed already.
> > >
> > > No, James tried to repro the bug on a Juno board, not an Apple M, and
> > > didn't succeed. I don't know what kernel he tried. I was told by Mark
> > > Rutland (at LPC) that the tool fix was absolutely necessary and the
> > > PMU driver wouldn't be fixed, hence the series flipping behavior that
> > > I thought Intel would most likely block and wasn't keen to do in the
> > > 1st place (not least wade through all the test behavior changes and
> > > the bug tail). All of this was premised on a threat of reverting all
> > > of the hybrid support so that Apple M could be made to work again, and
> > > I was trying to do a less worse alternative.
> > > https://lore.kernel.org/r/20231123042922.834425-1-irogers@google.com
> >
> > Sorry, it's not clear to me what's the problem exactly.  Can you give me
> > an example command line?
> 
> What broke: when arm PMUs were recognized as core and not uncore PMUs,
> as part of fixing hybrid, we encoded legacy events on them. So
> arm_blah/cycles/ became a type 0 config 0 event, no extended type as
> PMU support for that is tested first. A type 0 config 0 event is
> broken on the Apple-M PMUs, an event that doesn't count or something
> like that. Because they had a sysfs event of arm_blah/cycles/ before
> the change the broken legacy encoding on the PMU was never used, the
> legacy event broke things.

I think it's an Apple-M PMU's problem leaving it broken.  And it should
be ok as long as it can use the sysfs encoding with arm_blah/cycles/.

> 
> Because they had this problem the Apple-M users were used to using
> arm_blah/cycles/ rather than cycles to avoid legacy events. This
> change, not your proposal, is making it so that without a PMU they
> also don't get legacy events because in no uncertain terms it was
> expressed they weren't going to work. There was a lot of advocating
> for removing all hybrid support from the tool.

So that's, I believe, the expected behavior.  'cycles' should use the
legacy and arm_blah/cycles/ for sysfs.  Users on the platform knows the
legacy encoding is broken, and they use the sysfs.

But maybe I'm wrong and it's better to make the tools smarter so that it
can just work with the default event (cycles:P).

I'd like to hear others' opinion on this.

> 
> > > I don't understand what you are trying to say. I'm saying the behavior
> > > of perf list in its output is arbitrary. We use the same printing code
> > > for every kind of event. An aesthetic decision to put things on a line
> > > does not imply that it is more valid to use or not use a PMU, it just
> > > happens to be what the tool does. Did I break perf list as if you look
> > > in old perf list you see:
> > > ```
> > > $ perf list
> > > List of pre-defined events (to be used in -e or -M):
> > >
> > >  duration_time                                      [Tool event]
> > > ...
> > > ```
> > > while now you see:
> > > ```
> > > $ perf list
> > > List of pre-defined events (to be used in -e or -M):
> > > ...
> > > tool:
> > >  duration_time
> > >       [Wall clock interval time in nanoseconds. Unit: tool]
> > > ...
> > > ```
> > > I'm hoping people find it useful to have the unit documented.
> >
> > The most important information I think is the name of the event
> > (duration_time).  It'd be appropriate if you could call it
> > 'tool/duration_time/' but I'm not sure if it's acceptable cause
> > tool events are not real PMU events.  If so, maybe
> >
> >  duration_time or tool/duration_time/
> >
> > ?
> 
> I don't mind showing a PMU and not showing a PMU. duration_time isn't
> a core event, does it also get allowed no PMU prefix in your new
> scheme? My point isn't to discuss duration_time it is to point out
> that `perf list` output isn't sacred and says different things over
> time. Those things may or may not include a PMU as there has never
> been any rigor, it is a mush of strings that are printed.

Sorry for the distraction.  I meant users would learn the events from
`perf list` so it should guide them to use the event properly.  I
originally thought having PMU is the right thing, but for practical and
convenience reasons it'd be fine without PMUs.

> 
> In the perf list code we have an event and an alias. In my opinion if
> something is an alias of something else then it implies having the
> same perf_event_attr encoding. In your proposal this wouldn't be true
> for legacy events as it isn't true today. Which has always been my
> point about wanting to get this fixed.

Hmm.. right.  This is a concern.  I don't know.. let's listen to others
first.

> 
> > I think people should use a PMU prefix before wildcard is enabled.
> 
> I don't understand. You want to break uncore events without a PMU and
> disable wild carding, then enable wildcarding again. Like I say I
> think it is better you work on this behavior under a non `-e` command
> line option.

Sorry, I meant people used to add a PMU prefix in the past.  But let's
move on and use wildcard. :)

> 
> > > > > What happens if an event is both in sysfs and json? Well the sysfs event
> > > > > will get the description from the json and then I believe it won't
> > > > > behave as you show. Did the event get broken, as perf list no longer
> > > > > shows it with a PMU, by having a json description written? I think not
> > > > > and I think having descriptions with events is a good thing.
> > > >
> > > > That's bad.  Probably we should fix it takes only one of the sources and
> > > > change the JSON event not to clash with sysfs.
> > >
> > > No, you are talking about breaking everything already, let's not break
> > > it yet further - not least as we lack a reasonable way to test it. I
> > > think if you are serious about having such breaking changes then it is
> > > best you add a new command line option, like with libpfm events.
> >
> > I don't want to break things.  What's the intended behavior in that case?
> 
> The behavior is in pmu's update_event, but basically we prefer the
> json data over the sysfs data:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n506
> This allows the json/tool data to correct the sysfs data - as well as
> to add information like descriptions and topic.
> But my point isn't that I support your let's have two events instead
> of updating events. I have maintained this behavior as it has always
> been the behavior and I care about not breaking everything. Something
> that I assumed was taken for granted hence making `perf top` behave in
> a way where it is showing samples for processes that have terminated
> by default.

I'm ok with preferring JSON over sysfs.  In general I think they don't
have the same event names unless you want to override one.

Thanks,
Namhyung


