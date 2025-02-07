Return-Path: <bpf+bounces-50742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4803A2BA5C
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 05:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E18818899F1
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 04:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8384223278D;
	Fri,  7 Feb 2025 04:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxypApCK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65DD47F4A;
	Fri,  7 Feb 2025 04:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738903452; cv=none; b=OYXN4xSueskcYWgzbMALTtAJj+B7/vpyy951dTsvp5O9OmTzyP7OPAkbKLlQB3Em7057W/79ylRiBxkG0ZWgFJUlwbS2B4WnhWLc0kxwKGY1KWOo2w4b+Sx1FMba9gbN9DbaNM5VuMCsFU0RMOrcgxB+YUXSMyLKkOz2SC2GUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738903452; c=relaxed/simple;
	bh=RYg5bvdCTTZKWyfRpejJaqTJz2+N6XZXC5Z9yJT7Iik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLZ5JaIq3zoaHosrkA6RinkdUF1YOgTSBm+oak1rXOe/+FGI61oLnwxOLq3KNukTqVPvW04+N6ZWpjL9ax/Vp3hvxbsgpOLs4+jbkz3j3cKqIy4PjJTxu7jQVImU9h89DnjIUAtx2XT8/YESX46ONp6DF29B7W5FcXagqKIKaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxypApCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BFFC4CED1;
	Fri,  7 Feb 2025 04:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738903451;
	bh=RYg5bvdCTTZKWyfRpejJaqTJz2+N6XZXC5Z9yJT7Iik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxypApCKI8oB5QzO1cbBExu8Xjz1WTbVG/kgKyduXz8mjFTxfl9SZfIZ2ulG1EzC6
	 4qG6gQBh4016BNA1KQSCf9RjAHWsWBMzJHSj3cRgBeuUhONVnSdNj4SKd8n3OSHW1b
	 dO+XEp8fvHptdY3Dg0piFopOr1Qtjn5aWy7lni3D/KmbfcXWQy1Jx4fcxgPajSDIEL
	 +Co0ZaOWvNIPtY//VMMJ1sKtIc9JHqwarrsfY4V2N5SelTsKbYOR+XSY1AchI1sNRV
	 L0mzoZZkqq2iNKAjV3hkaMAiUfRcJn8XzyOuecUsVzeScLlrBNbzNX0JpU9enOGzBQ
	 80BKxhOZg3RbQ==
Date: Thu, 6 Feb 2025 20:44:09 -0800
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
Message-ID: <Z6WPmYCJcc6pPKDA@google.com>
References: <Z5qjwRG5jX9zAGtf@google.com>
 <CAHBxVyHL4CO1xGpzkNfvxk71gUYdVyrXZkqZHZ+ZV2VxeGFf8w@mail.gmail.com>
 <Z51RxQslsfSrW2ub@google.com>
 <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>
 <Z6FcHJFYGc7HzSna@google.com>
 <CAP-5=fW9f2mxuTV2FGCdhKm7M9g8v6VsLJJXTPTLRr5tUv9rOA@mail.gmail.com>
 <Z6LFp5jiED7_-weN@google.com>
 <CAP-5=fU6WSOK_N0NoLcMSSdaWAkdC2DUBwLqsLn_KA7m6dJyeQ@mail.gmail.com>
 <Z6RD7NuT9IPhOkIV@google.com>
 <CAP-5=fV8rRMQyMDuy1vcxyEX9Gf8x0QJdVEP-K5krBec_A7mpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV8rRMQyMDuy1vcxyEX9Gf8x0QJdVEP-K5krBec_A7mpA@mail.gmail.com>

On Wed, Feb 05, 2025 at 11:44:57PM -0800, Ian Rogers wrote:
> On Wed, Feb 5, 2025 at 9:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Feb 04, 2025 at 08:48:20PM -0800, Ian Rogers wrote:
> > > On Tue, Feb 4, 2025 at 5:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > You mean the -z flag which is documented in the man page and also it the
> > help message (perf top -h).  Anyone can read the doc can know it's
> > there.  Of course, people would prefer reading zines than man pages. :)
> 
> I link to the patch. My point is that something as minor as making
> "perf top" behave as "top" does was too big a (user command line)
> regression to land - I strongly suspect nobody would notice. Your
> proposal breaks all non-core events on every perf command that takes
> PMU events. It is a bigger change.

I also suspect not much people is using non-core events without PMU.
But I won't argue that since I don't have any data.

> 
> > > So, it would seem to me that
> > > changing something as fundamental as how all non-core events behave
> > > would be seen as a regression.
> >
> > Yep, it'd be a regression.
> 
> Agreed, you are arguing for a regression.

Right, but I thought it won't affect many.  But who knows..
And yes, I don't want to create new troubles.

> 
> > Which suffix do you mean?
> 
> It's off topic. ARM added hex suffixes to PMUs representing physical
> memory addresses of memory controllers but then that makes cortex_a72
> look like it has a 3 character suffix. So perf assumes hex digits more
> than 4 characters long is a hex suffix, which of course it wouldn't be
> for a1000 (which is also somewhat close to being an old Acorn
> archimedes machine number ;-) ).

ok.

> 
> > Anyway, the person looked up the intel webpage would be eager to learn
> > about performance related things.  Can we also assume if they also want
> > to learn about the perf tool itself? :)
> 
> I'm not sure how turning data_read into
> uncore_imc_free_running/data_read/ is in anyway helping people
> understand perf? They want an event name that matches the
> documentation, manual, web site. It is what the vendors I've spoken to
> want as they use the event names across tools (fwiw oprofile doesn't
> even have a notion of a PMU). To my knowledge the PMU names are the
> wild west, often illogical and never mentioned in any kind of
> documentation. I have a hard time explaining how the suffixes work and
> I believe there are more conventions in the works where there can be
> multiple what we are currently calling suffixes.

I mean if something doesn't work, they will look 'perf list' and find
the event name it supports.  For me, PMU name gives a tiny bit more
information about the 'data_read' event.  But proper decscription for
the event is preferred.

> 
> > If it's not the case, we have this:
> >
> >   $ perf record -e xxx
> >   event syntax error: 'xxx'
> >                        \___ Bad event name
> >
> >   Unable to find event on a PMU of 'xxx'
> >   Run 'perf list' for a list of valid events
> >
> >    Usage: perf record [<options>] [<command>]
> >       or: perf record [<options>] -- <command> [<options>]
> >
> >       -e, --event <event>   event selector. use 'perf list' to list available events
> >
> > So it says twice to run 'perf list' to see the events.  Then they can
> > run either:
> >
> >   $ perf list | grep xxx
> >
> > or
> >
> >   $ perf list xxx
> >
> > to see the actual name of the event available in the perf tool.
> 
> Why was adding a PMU to an event name, working around ARM's PMU bug,
> such an unsurmontable problem that the original change was reverted?
> Because 1 person didn't want to have to write a PMU prefix and
> considered it a monumental regression having to do so.

Because it's a legacy event 'cycles' and he didn't expect the wildcard
behavior?

> 
> > >
> > > Even with this what would be the behavior of core events? You want
> > > legacy events to have priority over sysfs/json when there is no PMU.
> > > You know, and have stated not caring, RISC-V wants different and that
> > > it breaks Apple-M's PMUs for a fairly large range of kernel releases
> > > including 1 LTS kernel - the only reason I'm writing patches in this
> > > area in the 1st place. Software is soft and you can go fix software
> > > anywhere in the stack. Listening to vendors and not breaking everyone
> > > is the point-of-view these patches have been coming from. I find it
> > > very hard to have a conversation where this is just forgotten about
> > > and we're working on hypotheticals which seem to be both unwanted and
> > > implausible.
> >
> > Sorry I don't want to repeat that too.  Correct me if I'm wrong:
> 
> You are wrong.

Hmm.. ok.

> 
> > 1. RISC-V is working on a solution with the current status and it's not
> >    absoluted needed to change the current behavior.
> 
> They said to you directly it was what they wanted, that's why I
> reposted this change and it is, has always been, in the cover letter.
> They've then followed up expressing their desire for this behavior but
> having to have a plan b as the original change was reverted and you
> are blocking this change landing.

So they have the plan B.  But still prefer overriding legacy with JSON?

> 
> > 2. Apple-M is fixed already.
> 
> No, James tried to repro the bug on a Juno board, not an Apple M, and
> didn't succeed. I don't know what kernel he tried. I was told by Mark
> Rutland (at LPC) that the tool fix was absolutely necessary and the
> PMU driver wouldn't be fixed, hence the series flipping behavior that
> I thought Intel would most likely block and wasn't keen to do in the
> 1st place (not least wade through all the test behavior changes and
> the bug tail). All of this was premised on a threat of reverting all
> of the hybrid support so that Apple M could be made to work again, and
> I was trying to do a less worse alternative.
> https://lore.kernel.org/r/20231123042922.834425-1-irogers@google.com

Sorry, it's not clear to me what's the problem exactly.  Can you give me
an example command line?

> 
> > >
> > > I don't know why people (yourself, Linus) keep wanting to show me the
> > > perf list output. It is arbitrary. I rewrote it and changed the
> > > behavior of all uncore PMUs within it (we didn't used to deduplicate
> > > based on the PMU suffix). It is nice that people think it reads like
> > > some religious text.
> >
> > I think it's what we want users to know how to use the events.
> 
> I don't understand what you are trying to say. I'm saying the behavior
> of perf list in its output is arbitrary. We use the same printing code
> for every kind of event. An aesthetic decision to put things on a line
> does not imply that it is more valid to use or not use a PMU, it just
> happens to be what the tool does. Did I break perf list as if you look
> in old perf list you see:
> ```
> $ perf list
> List of pre-defined events (to be used in -e or -M):
> 
>  duration_time                                      [Tool event]
> ...
> ```
> while now you see:
> ```
> $ perf list
> List of pre-defined events (to be used in -e or -M):
> ...
> tool:
>  duration_time
>       [Wall clock interval time in nanoseconds. Unit: tool]
> ...
> ```
> I'm hoping people find it useful to have the unit documented.

The most important information I think is the name of the event
(duration_time).  It'd be appropriate if you could call it
'tool/duration_time/' but I'm not sure if it's acceptable cause
tool events are not real PMU events.  If so, maybe

 duration_time or tool/duration_time/

?

> 
> > > Why is the formatting different in perf list for
> > > json specified events? Well it is because json events have
> > > descriptions and the events you are showing with a PMU don't have a
> > > description. I think because there is no description, an effort was
> > > made to keep the output compact and put the PMU and event name
> > > together. It wasn't trying to enter some kind of long lasting marriage
> > > that the event name should only ever be used with the PMU.
> >
> > I like the description but I don't like the formatting.  I think I
> > understand why it looks like that but it could be different.  Anyway,
> > I don't think showing PMU name is related to having descriptions.
> 
> No, it has more to do with how I was feeling about filling in two
> string fields called name and alias when rewriting the perf list code.
> I added aliases containing the PMU name just to add a little bit more
> detail when there seemed to be little documentation with certain
> events. I never intended placing the PMU names into any events to be a
> commitment that all non-core PMU events would need a PMU prefix and to
> break all such people using those events.

I think people should use a PMU prefix before wildcard is enabled.

> 
> > > What happens if an event is both in sysfs and json? Well the sysfs event
> > > will get the description from the json and then I believe it won't
> > > behave as you show. Did the event get broken, as perf list no longer
> > > shows it with a PMU, by having a json description written? I think not
> > > and I think having descriptions with events is a good thing.
> >
> > That's bad.  Probably we should fix it takes only one of the sources and
> > change the JSON event not to clash with sysfs.
> 
> No, you are talking about breaking everything already, let's not break
> it yet further - not least as we lack a reasonable way to test it. I
> think if you are serious about having such breaking changes then it is
> best you add a new command line option, like with libpfm events.

I don't want to break things.  What's the intended behavior in that case?

Thanks,
Namhyung


