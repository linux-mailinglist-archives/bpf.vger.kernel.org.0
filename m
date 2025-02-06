Return-Path: <bpf+bounces-50606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4B2A29FDE
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 06:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A770418863D1
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 05:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E29521128F;
	Thu,  6 Feb 2025 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSql8nxU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA771FCCED;
	Thu,  6 Feb 2025 05:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738818543; cv=none; b=qoVbdSQ4uASqXZhWaMtDMwtaP634adPKqbMZ33zfWue8Jwuh1IRS3FV1V8lnz+egZrhjUQiGBKFoxPvCj4sUf5z34clhiLr9AHzk3WlMZcampw6kz5XdqeNr6l3wNcPV0e/cGumr/T8dQdWfJ2WOjFg6Zstxg7zQxfzVgJdgfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738818543; c=relaxed/simple;
	bh=BM3EHrnwN7ELuwzLXads97EF6hGC4Psya3GZjPkDWsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwCjkVDxkToMNoCypXyV9QjPacIwkN4zOzdWIxvxA5tOgV6tNzbNwi0LXKB0sbjv5XDLBffkAFzqVJwvpfinT6a/QBTJzkKW6wP6ulzT6+2G9uUpF+Syp8LCej/cktoU5EWNMOMPlt54PMhKPhS1V60wPp082K3OVLS3QRerIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSql8nxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34721C4CEDD;
	Thu,  6 Feb 2025 05:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738818543;
	bh=BM3EHrnwN7ELuwzLXads97EF6hGC4Psya3GZjPkDWsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSql8nxUuNkMHi0BTlIlo9nxun/736F0fVTV5XtseR8DLwgbLm9WidEJIx7G2O40u
	 1gCyKtFn7uufd+DwXLf9vBzx99V6KnErRoxKWYHPdAu0xj4T+EvPqAB2DtSL6vZCJR
	 VCDoR3WONPZ/T0TUu5J8Hz/3O20piX8fxQmAhwXrU9rjqnjUlFaL/hMrgnzBFxGKCu
	 KadSxiveBHqJ96KVT5y+RNng/qucUvJCdGJyg/Z4muygIG7NSOwKHLvakdhDEuqDp+
	 Tz0Czvw0w+/hxDR8bSZUgDxQN8PWFDbWz2IcnoexiH2T95vrSk9iMM1Pi1n7XUJgyv
	 qxEBT5Ge4nD8g==
Date: Wed, 5 Feb 2025 21:09:00 -0800
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
Message-ID: <Z6RD7NuT9IPhOkIV@google.com>
References: <Z4f3fDXemAMpBNMS@google.com>
 <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
 <Z5qjwRG5jX9zAGtf@google.com>
 <CAHBxVyHL4CO1xGpzkNfvxk71gUYdVyrXZkqZHZ+ZV2VxeGFf8w@mail.gmail.com>
 <Z51RxQslsfSrW2ub@google.com>
 <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>
 <Z6FcHJFYGc7HzSna@google.com>
 <CAP-5=fW9f2mxuTV2FGCdhKm7M9g8v6VsLJJXTPTLRr5tUv9rOA@mail.gmail.com>
 <Z6LFp5jiED7_-weN@google.com>
 <CAP-5=fU6WSOK_N0NoLcMSSdaWAkdC2DUBwLqsLn_KA7m6dJyeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU6WSOK_N0NoLcMSSdaWAkdC2DUBwLqsLn_KA7m6dJyeQ@mail.gmail.com>

On Tue, Feb 04, 2025 at 08:48:20PM -0800, Ian Rogers wrote:
> On Tue, Feb 4, 2025 at 5:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Feb 03, 2025 at 04:41:11PM -0800, Ian Rogers wrote:
> > > On Mon, Feb 3, 2025 at 4:15 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > [snip]
> > > > Yep, I agree it's confusing.  So my opinion is to use legacy encoding
> > > > and no default wildcard. :)
> > >
> > > Making it so that all non-legacy, non-core PMU events require a PMU is
> > > a breaking change and a regression for all users, command line event
> > > name suggesting, any tool built off of perf, and so on. Breaking all
> > > perf users and requiring all perf metrics be rewritten is well..
> > > something..
> >
> > Well, I guess the majority of users don't use non-core PMU events.  And
> > we used to have PMU prefix on those events for years so old users should
> > not be affected.  Actually perf list shows them with PMU prefix so I
> > think new users are also expected to use the PMU name.
> >
> >   $ perf list pmu
> >   ...
> >   cstate_pkg/c2-residency/                           [Kernel PMU event]
> >   ...
> >   i915/actual-frequency/                             [Kernel PMU event]
> >   i915/bcs0-busy/                                    [Kernel PMU event]
> >   ...
> >   msr/tsc/                                           [Kernel PMU event]
> >   ...
> >   power/energy-cores/                                [Kernel PMU event]
> >   ...
> >   uncore_clock/clockticks/                           [Kernel PMU event]
> >   uncore_imc_free_running/data_read/                 [Kernel PMU event]
> >   ...
> >
> > The exception is the JSON events like below.
> >
> >   uncore interconnect:
> >     unc_arb_coh_trk_requests.all
> >          [UNC_ARB_COH_TRK_REQUESTS.ALL. Unit: uncore_arb]
> >
> > which I hoped to be 'uncore_arb/unc_arb_coh_trk_requests.all/' or even
> > 'uncore_arb/coh_trk_requests.all/'.  But it would be hard to change the
> > all metric expressions now.  Also users can directly use them as they
> > are listed by `perf list`.  So we need to support that without PMUs.
> 
> So there's nothing wrong with your proposal except it breaks non-core
> events. We can't agree to flip the default on a flag for perf top:
> https://lore.kernel.org/lkml/20240516222159.3710131-1-irogers@google.com/
> to make perf top behave as, you know, top does as it could be an
> option people depend on. A behavior that matters if you do user
> filtering as exited processes stay in perf top (both confusing and
> un-top like). Fwiw, that reminds me of another patch series being
> unreviewed:
> https://lore.kernel.org/lkml/20250111190143.1029906-1-irogers@google.com/

Ok, I'll review that later.  Sorry my review bandwidth is not very high.


> Anyway, the perf top flag is one that no-one knows exists on a command
> most people don't know exists - Julia Evans' zine of course loves it
> and we love Julia's work and the zine.

You mean the -z flag which is documented in the man page and also it the
help message (perf top -h).  Anyone can read the doc can know it's
there.  Of course, people would prefer reading zines than man pages. :)


> So, it would seem to me that
> changing something as fundamental as how all non-core events behave
> would be seen as a regression.

Yep, it'd be a regression.  And that's why we cannot simply change the
behavior.  But I guess not much users would be affected by that since
it's undocumented behavior.


> Imagine the person going to
> perfmon-events.intel.com, finding an event name and expecting to be
> able to use it with perf. Now they need to grub around in perf list to
> locate the PMU. What is appropriate for them to know about how
> suffixes work and show in perf list..? Well that's assuming suffixes
> work in the future as ARM will probably launch an a1000 CPU and the
> PMU will look like a hex suffix and the whole naming convention
> implodes.

Which suffix do you mean?

Anyway, the person looked up the intel webpage would be eager to learn
about performance related things.  Can we also assume if they also want
to learn about the perf tool itself? :)

If it's not the case, we have this:

  $ perf record -e xxx
  event syntax error: 'xxx'
                       \___ Bad event name
  
  Unable to find event on a PMU of 'xxx'
  Run 'perf list' for a list of valid events
  
   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]
  
      -e, --event <event>   event selector. use 'perf list' to list available events

So it says twice to run 'perf list' to see the events.  Then they can
run either:

  $ perf list | grep xxx

or

  $ perf list xxx

to see the actual name of the event available in the perf tool.

> 
> Even with this what would be the behavior of core events? You want
> legacy events to have priority over sysfs/json when there is no PMU.
> You know, and have stated not caring, RISC-V wants different and that
> it breaks Apple-M's PMUs for a fairly large range of kernel releases
> including 1 LTS kernel - the only reason I'm writing patches in this
> area in the 1st place. Software is soft and you can go fix software
> anywhere in the stack. Listening to vendors and not breaking everyone
> is the point-of-view these patches have been coming from. I find it
> very hard to have a conversation where this is just forgotten about
> and we're working on hypotheticals which seem to be both unwanted and
> implausible.

Sorry I don't want to repeat that too.  Correct me if I'm wrong:

1. RISC-V is working on a solution with the current status and it's not
   absoluted needed to change the current behavior.

2. Apple-M is fixed already.

> 
> I don't know why people (yourself, Linus) keep wanting to show me the
> perf list output. It is arbitrary. I rewrote it and changed the
> behavior of all uncore PMUs within it (we didn't used to deduplicate
> based on the PMU suffix). It is nice that people think it reads like
> some religious text.

I think it's what we want users to know how to use the events.


> Why is the formatting different in perf list for
> json specified events? Well it is because json events have
> descriptions and the events you are showing with a PMU don't have a
> description. I think because there is no description, an effort was
> made to keep the output compact and put the PMU and event name
> together. It wasn't trying to enter some kind of long lasting marriage
> that the event name should only ever be used with the PMU.

I like the description but I don't like the formatting.  I think I
understand why it looks like that but it could be different.  Anyway,
I don't think showing PMU name is related to having descriptions.


> What happens if an event is both in sysfs and json? Well the sysfs event
> will get the description from the json and then I believe it won't
> behave as you show. Did the event get broken, as perf list no longer
> shows it with a PMU, by having a json description written? I think not
> and I think having descriptions with events is a good thing.

That's bad.  Probably we should fix it takes only one of the sources and
change the JSON event not to clash with sysfs.

Thanks,
Namhyung


