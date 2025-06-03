Return-Path: <bpf+bounces-59568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59530ACD056
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 01:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F941897E70
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 23:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A42528FD;
	Tue,  3 Jun 2025 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1L+wnin"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB5319D8AC;
	Tue,  3 Jun 2025 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748994087; cv=none; b=H8FnYQtLJRUJQ3kNecJWT1xYdh/jatzPMgwWAIn/05I+pGQXEZq3kbKHcm6ap07Xp4bhGpyXO51+bYFiuYEtkbBOWZTq/J6QydB6cp21mEs+s2BNGjXf/4MIDxKU7nDmpx/ba0i3iURhQAFlXlOdxKFh85SUb0uQchXEiM0tYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748994087; c=relaxed/simple;
	bh=jcY/C4ofy4+Q1Z2QfgHwr2QW+0HHCEq2O6cW3dOTmCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOd01rJosCj1qK3FGqVS/P061AI0iwbZozyuaWVgb5GHp2OXLC+i2WgXmI1omZBDNpu41tsdwaxQSIZ5+OUmdQN5nHghZuMMys3KoD9MUSU2vdcsj4KYCLhKpJe6WtZaHVi9udwdv6f3JaAKPgFpXUSCk1rN9dsuP2p/xcwEtoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1L+wnin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81775C4CEED;
	Tue,  3 Jun 2025 23:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748994087;
	bh=jcY/C4ofy4+Q1Z2QfgHwr2QW+0HHCEq2O6cW3dOTmCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1L+wninfoiRbAtjUlpB+Qpbp0fDiyHAUJ5nsiE7t/MN1odkoLEPT6W6OAiLGutgv
	 D9X/AUaaKhgvVYOZIpWMRsSYliNzadsPyC4IX5VZ7a1UtygsZNgx9WPD17trS/+4Ap
	 swiYcdelilgNwWfnmkLKsUFKt6tWwLQo/I4JDLoVitlWvabygNuJCu+dVJWJScoBbD
	 I3UY+Iq/AIWUvpdMnfaU6f2Ejg1MUItUX8zXTc69AW1VVwF0nXowpxIs+KfxZATrpP
	 xIN1VltwO5SX1jKV8vqrmrdvu7E+iq+R2eaj99G2D3xhH3xN5w/13vbfIoiwWdO6j4
	 npu5H+MnbTC3A==
Date: Tue, 3 Jun 2025 16:41:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Xu Yang <xu.yang_2@nxp.com>, Tengda Wu <wutengda@huaweicloud.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Move uid filtering to BPF filters
Message-ID: <aD-IJRi0n1WGmOFP@google.com>
References: <20250425214008.176100-1-irogers@google.com>
 <CAP-5=fXiYHbe9gd_TNyy=txzrd+ONxecnpZr+uPeOnF5XxunGw@mail.gmail.com>
 <aD586_XkeOH2_Fes@google.com>
 <CAP-5=fUXJ6fW4738Fnx9AK2mPeA74ZpYKv=Ui6wYLWXE3KRRTQ@mail.gmail.com>
 <aD94FJN4Pjsx7exP@google.com>
 <CAP-5=fX98m+PPkHR2+KdjtJfc0ONMwkjeoCLzjwG_O=5j50=5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX98m+PPkHR2+KdjtJfc0ONMwkjeoCLzjwG_O=5j50=5g@mail.gmail.com>

On Tue, Jun 03, 2025 at 04:22:53PM -0700, Ian Rogers wrote:
> On Tue, Jun 3, 2025 at 3:32 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Jun 02, 2025 at 11:26:12PM -0700, Ian Rogers wrote:
> > > On Mon, Jun 2, 2025 at 9:41 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > On Tue, May 27, 2025 at 01:39:21PM -0700, Ian Rogers wrote:
> > > > > On Fri, Apr 25, 2025 at 2:40 PM Ian Rogers <irogers@google.com> wrote:
> > > > > >
> > > > > > Rather than scanning /proc and skipping PIDs based on their UIDs, use
> > > > > > BPF filters for uid filtering. The /proc scanning in thread_map is
> > > > > > racy as the PID may exit before the perf_event_open causing perf to
> > > > > > abort. BPF UID filters are more robust as they avoid the race. The
> > > > > > /proc scanning also misses processes starting after the perf
> > > > > > command. Add a helper for commands that support UID filtering and wire
> > > > > > up. Remove the non-BPF UID filtering support given it doesn't work.
> > > > > >
> > > > > > v3: Add lengthier commit messages as requested by Arnaldo. Rebase on
> > > > > >     tmp.perf-tools-next.
> > > > > >
> > > > > > v2: Add a perf record uid test (Namhyung) and force setting
> > > > > >     system-wide for perf trace and perf record (Namhyung). Ensure the
> > > > > >     uid filter isn't set on tracepoint evsels.
> > > > > >
> > > > > > v1: https://lore.kernel.org/lkml/20250111190143.1029906-1-irogers@google.com/
> > > > >
> > > > > Ping. Thanks,
> > > >
> > > > I'm ok with preferring BPF over /proc scanning, but still hesitate to
> > > > remove it since some people don't use BPF.  Can you please drop that
> > > > part and make parse_uid_filter() conditional on BPF?
> > >
> > > Hi Namhyung,
> > >
> > > The approach of scanning /proc fails as:
> > > 1) processes that start after perf starts will be missed,
> > > 2) processes that terminate between being scanned in /proc and
> > > perf_event_open will cause perf to fail (essentially the -u option is
> > > just sugar to scan /proc and then provide the processes as if they
> > > were a -p option - such an approach doesn't need building into the
> > > tool).
> >
> > Yeah, I remember we had this discussion before.  I think (1) is not true
> > as perf events will be inherited to children (but there is a race).
> 
> If you log in from another terminal? Anything that creates a new
> process for that user but isn't inherited will be missed, which isn't
> merely a race.

As long as the another terminal is owned by the same user, any new
process from the terminal will inherit events, no?

> 
> >  And
> > (2) is a real problem but it's also about a race and it can succeed.
> >
> > Maybe we could change it to skip failed events when the target is a
> > user but that's not the direction you want.
> 
> We could have other events and try to discover new processes via them,
> do things like dummy events to cover races. It is just a lot of
> complexity for something that is a trivial amount of BPF. In something
> like 10 years nobody has bothered to fix this up.

I don't want any complex solution for this.  Let's not touch this.

> 
> > >
> > > This patch series adds a test [1] and perf test has lots of processes
> > > starting and exiting, matching condition (2) above*. If this series
> > > were changed to an approach that uses BPF and falls back on /proc
> > > scanning then the -u option would be broken for both reasons above but
> > > also prove a constant source of test flakes.
> > >
> > > Rather than give the users something both frustrating to use (keeps
> > > quitting due to failed opens) and broken (missing processes) I think
> > > it is better to quit perf at that point informing the user they need
> > > more permissions to load the BPF program. This also makes the -u
> > > option testable.
> > >
> > > So the request for a change I don't think is sensible as it provides a
> > > worse user and testing experience. There is also the cognitive load of
> > > having the /proc scanning code in the code base, whereas the BPF
> > > filter is largely isolated.
> >
> > But I think the problem is that it has different requirements - BPF and
> > root privilege.  So it should be used after checking the requirements
> > and fail or fallback.
> >
> > Does it print proper error messages if not?  With that we can deprecate
> > the existing behavior and remove it later.
> 
> For `perf top` with TUI you get an error message in a box of:
> ```
> failed to set filter "BPF" on event cpu_atom/cycles/P with 1
> (Operation not permitted)
> ```
> With --stdio you get:
> ```
> libbpf: Error in bpf_object__probe_loading(): -EPERM. Couldn't load
> trivial BPF program. Make sure your kernel supports BPF
> (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough
> value.
> libbpf: failed to load object 'sample_filter_bpf'
> libbpf: failed to load BPF skeleton 'sample_filter_bpf': -EPERM
> Failed to load perf sample-filter BPF skeleton
> failed to set filter "BPF" on event cpu_atom/cycles/P with 1
> (Operation not permitted)
> ```
> This matches the existing behavior if you put a filter on an event.

But that's different as user directly asked the BPF filter.
The following message would be better (unless you fallback to the old
behavior).

"-u/--uid option is using BPF filter but perf is not built with BPF.
Please make sure to build with libbpf and bpf skeletons."

and/or

"-u/--uid option is using BPF filter which requires root privilege."

You may check if the filter program and map is pinned already.

Thanks,
Namhyung


