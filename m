Return-Path: <bpf+bounces-36415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D579483F4
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 23:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C7F284060
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 21:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E976916CD00;
	Mon,  5 Aug 2024 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No9yQqlV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E516C69A;
	Mon,  5 Aug 2024 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722892324; cv=none; b=gWnBCxdt0T6CvHXZQ5P1sjnsFxoNFYqinvni+EAJc04/MUJXaW4eurmLSKcxZCK7boxArm7Ll/QtLjJw2H9HCwu1zMY/dJKSLCEG1xDNe8Xn4/jJb4Qj7+TSnyMMqY7k95s2kH0PyE8qbH3YUWPhjw61sIKHbn1WeteKvVLUHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722892324; c=relaxed/simple;
	bh=/C6KCCXV/Y/gYFfLYENXnkylgx0vsLl6/6AYZHvkRNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1j1m0UqwNf+c+nfCIsPxo9FtJzLcX7R3lv7FecriDMCtXTBnsw23UEDuXSHCz1iOvwXPoL+G5DxF2bTLNI3O6z3ga7ubpC9HH5A1T7N1hgxIfUaC/Q+tIFJhReRTJPKEVEd1Uqbmi6JK2owiCy0XK+HiUmnf+U1A/pvRhIp2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No9yQqlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D2DC32782;
	Mon,  5 Aug 2024 21:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722892323;
	bh=/C6KCCXV/Y/gYFfLYENXnkylgx0vsLl6/6AYZHvkRNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=No9yQqlVaRJc2OYK9fPVCkjWVY1o8DkEuccw3jnKKFpFMzmRycMXmF9KDKvGXNV1t
	 45WLZ55QnK2vEDH2O2afCDCIiI6Nx3/geogWIN33l7JEjD6hBzcQpfK5DlXtK4qmeG
	 XXVRv64mwYRSrCjAmLkUTS/ojbkqut9THnPPhJZOgMpQde0vr+YG+C2Z9mJ1pHfTfo
	 35gj7xtEqEkmgMMU5GD41kPoCRQdwFe+FgnC93BgfoEqLDXQTKUBOwyGusU0QHaf/i
	 02kiUmmAsjnxSvrn29wIDwovDHif4i7QTEGBW22Hdb0WMtXMW11G+9lpqbvurYlvDu
	 LtSbN8caTYhSQ==
Date: Mon, 5 Aug 2024 14:12:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
	Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf bpf-filter: Support multiple events properly
Message-ID: <ZrFAIc0G8n0-zgxt@google.com>
References: <20240802173752.1014527-1-namhyung@kernel.org>
 <ZrDpsnReuIClKFnk@x1>
 <ZrEgeLkZx6uor7fg@google.com>
 <ZrEolmUz_2I1fmdJ@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZrEolmUz_2I1fmdJ@x1>

On Mon, Aug 05, 2024 at 04:31:34PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Aug 05, 2024 at 11:56:56AM -0700, Namhyung Kim wrote:
> > On Mon, Aug 05, 2024 at 12:03:14PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Fri, Aug 02, 2024 at 10:37:52AM -0700, Namhyung Kim wrote:
> > > > So far it used tgid as a key to get the filter expressions in the
> > > > pinned filters map for regular users but it won't work well if the has
> > > > more than one filters at the same time.  Let's add the event id to the
> > > > key of the filter hash map so that it can identify the right filter
> > > > expression in the BPF program.
> > > > 
> > > > As the event can be inherited to child tasks, it should use the primary
> > > > id which belongs to the parent (original) event.  Since evsel opens the
> > > > event for multiple CPUs and tasks, it needs to maintain a separate hash
> > > > map for the event id.
> > > 
> > > I'm trying to test it now, it would be nice to have the series of events
> > > needed to test that the feature is working.
> > 
> > Sure, I used the following command.
> > 
> >   ./perf record -e cycles --filter 'ip < 0xffffffff00000000' -e instructions --filter 'period < 100000' -o- ./perf test -w noploop | ./perf script -i-
> 
> Thanks
>  
> > > 
> > > Some comments below.
> > >  
> > > > In the user space, it keeps a list for the multiple evsel and release
> > > > the entries in the both hash map when it closes the event.
> > > > 
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/util/bpf-filter.c                 | 288 ++++++++++++++++---
> > > >  tools/perf/util/bpf_skel/sample-filter.h     |  11 +-
> > > >  tools/perf/util/bpf_skel/sample_filter.bpf.c |  42 ++-
> > > >  tools/perf/util/bpf_skel/vmlinux/vmlinux.h   |   5 +
> > > >  4 files changed, 304 insertions(+), 42 deletions(-)
> > > > 
> > > > diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> > > > index c5eb0b7eec19..69b147cba969 100644
> > > > --- a/tools/perf/util/bpf-filter.c
> > > > +++ b/tools/perf/util/bpf-filter.c
> > > > @@ -1,4 +1,45 @@
> > > >  /* SPDX-License-Identifier: GPL-2.0 */
> > > > +/**
> > > > + * Generic event filter for sampling events in BPF.
> > > > + *
> > > > + * The BPF program is fixed and just to read filter expressions in the 'filters'
> > > > + * map and compare the sample data in order to reject samples that don't match.
> > > > + * Each filter expression contains a sample flag (term) to compare, an operation
> > > > + * (==, >=, and so on) and a value.
> > > > + *
> > > > + * Note that each entry has an array of filter repxressions and it only succeeds
> > > 
> > >                                                   expressions
> > 
> > Oops, thanks.
> > 
> > > 
> > > > + * when all of the expressions are satisfied.  But it supports the logical OR
> > > > + * using a GROUP operation which is satisfied when any of its member expression
> > > > + * is evaluated to true.  But it doesn't allow nested GROUP operations for now.
> > > > + *
> > > > + * To support non-root users, the filters map can be loaded and pinned in the BPF
> > > > + * filesystem by root (perf record --setup-filter pin).  Then each user will get
> > > > + * a new entry in the shared filters map to fill the filter expressions.  And the
> > > > + * BPF program will find the filter using (task-id, event-id) as a key.
> > > > + *
> > > > + * The pinned BPF object (shared for regular users) has:
> > > > + *
> > > > + *                  event_hash                   |
> > > > + *                  |        |                   |
> > > > + *   event->id ---> |   id   | ---+   idx_hash   |     filters
> > > > + *                  |        |    |   |      |   |    |       |
> > > > + *                  |  ....  |    +-> |  idx | --+--> | exprs | --->  perf_bpf_filter_entry[]
> > > > + *                                |   |      |   |    |       |               .op
> > > > + *   task id (tgid) --------------+   | .... |   |    |  ...  |               .term (+ part)
> > > > + *                                               |                            .value
> > > > + *                                               |
> > > > + *   ======= (root would skip this part) ========                     (compares it in a loop)
> > > > + *
> > > > + * This is used for per-task use cases while system-wide profiling (normally from
> > > > + * root user) uses a separate copy of the program and the maps for its own so that
> > > > + * it can proceed even if a lot of non-root users are using the filters at the
> > > > + * same time.  In this case the filters map has a single entry and no need to use
> > > > + * the hash maps to get the index (key) of the filters map (IOW it's always 0).
> > > > + *
> > > > + * The BPF program returns 1 to accept the sample or 0 to drop it.
> > > > + * The 'dropped' map is to keep how many samples it dropped by the filter and
> > > > + * it will be reported as lost samples.
> > > 
> > > I think there is value in reporting how many were filtered out, I'm just
> > > unsure about reporting it as "lost" samples, as lost has another
> > > semantic associated, i.e. ring buffer was full or couldn't process it
> > > for some other resource starvation issue, no?
> > 
> > Then we need a way to save the information.  It could be a new record
> > type (PERF_RECORD_DROPPED_SAMPLES), a new misc flag in the lost samples
> 
> I guess "PERF_RECORD_FILTERED_SAMPLES" would be better, more precise,
> wdyt?
> 
> > record or a header field.  I prefer the misc flag.
> 
> I think we can have both filtered and lost samples, so I would prefer
> the new record type.

I think we can have two LOST_SAMPLES records then - one with the new
misc flag for BPF and the other (without the flag) for the usual lost
samples.  This would require minimal changes IMHO.

Thanks,
Namhyung

>  
> > Also there should be a separate PERF_RECORD_LOST record in the middle
> > when there's actual issue.  Without that we can say it's from the BPF.
> 
> Right, disambiguating filtered from lost samples is indeed useful.
> 
> - Arnaldo
>  
> > Thanks,
> > Namhyung

