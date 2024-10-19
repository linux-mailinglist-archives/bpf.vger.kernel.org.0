Return-Path: <bpf+bounces-42508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7C89A4FD1
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 18:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A19B260EC
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 16:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358F518DF65;
	Sat, 19 Oct 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDxc04H5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8056216F0E8;
	Sat, 19 Oct 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729355311; cv=none; b=VbdZN1Wdw4M1ctputYhRqhmpWzSUbZpC9Cz2fh/gnkdgfbUypgI5MGIB2ddRakSLtp1Iqn0gIc63kPGRBljqHYenRSFT2IJ08dbKk3orKApMC4SlnDmfPEdrWcsSXHGtNH2ZKQVbI74NxEMiQTpoelQmE7jwNCWRd4mtBqt2UME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729355311; c=relaxed/simple;
	bh=xbGKRbkO5vEWFBFZS51O6UqO3O2/WZ8Ct3XqyqrPkeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr3xPluQzecaFrhf4H9EmsyAeRXAsovX3pR3sFOrM6Iel+VaUloVwNZR5Gt91Gw5NoK1nggSBzVqpN68v2hyQG4YgEJiMSkv0uSqKfCAjES4Dx49Q2HuBLvox/29oZuecqp5LmMhNu2CoubS1DkU002CEYg85PYxiay+cLKNW1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDxc04H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F7FC4CEC5;
	Sat, 19 Oct 2024 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729355311;
	bh=xbGKRbkO5vEWFBFZS51O6UqO3O2/WZ8Ct3XqyqrPkeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDxc04H5gdhBrTvLDARWJq81Z8FmJmwzP5chg91mN+4DhHqcdsVe7Mz3onEDD2RDO
	 J7gg7LhkdDJelN4rfjlcDVSMxR3ptFeHtLsMzd2sE/WccoKptEmzlxqJMth0dnGqM6
	 0hE/JPKGpKhpMCA59bCyJWQTLVGld93d9vorxBF2rL9AGSYxM/kqXZU/GZsrfnPNDQ
	 rfkhc9MicsoJ41ErgD0pm3bG605Rg/e0sDQKzL0tDrjWpz/oPGs7PkZc2ophR9+fQu
	 s/NbDoxsJEIl4ADjcyl1zE+tG0yio7wyVHx1x3/NmAz7z+BDjvbJf7TQSuDNNE86iD
	 krXN5NjTP/+Qw==
Date: Sat, 19 Oct 2024 09:28:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, song@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH -next v4 1/2] perf stat: Support inherit events during
 fork() for bperf
Message-ID: <ZxPeLaYXsEu9N1f1@google.com>
References: <20241012023225.151084-1-wutengda@huaweicloud.com>
 <20241012023225.151084-2-wutengda@huaweicloud.com>
 <ZxAtLsClDW8x0H_a@google.com>
 <5c8612d2-a0fb-4853-8b6f-aca85b200edb@huaweicloud.com>
 <ZxKXFMh6_8E6-z7H@google.com>
 <093e14a9-4008-4490-9946-5080449935c4@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <093e14a9-4008-4490-9946-5080449935c4@huaweicloud.com>

On Sat, Oct 19, 2024 at 04:27:38PM +0800, Tengda Wu wrote:
> 
> 
> On 2024/10/19 1:12, Namhyung Kim wrote:
> > On Thu, Oct 17, 2024 at 10:53:46AM +0800, Tengda Wu wrote:
> >> Hi,
> >>
> >> On 2024/10/17 5:16, Namhyung Kim wrote:
> >>> Hello,
> >>>
> >>> On Sat, Oct 12, 2024 at 02:32:24AM +0000, Tengda Wu wrote:
> >>>> bperf has a nice ability to share PMUs, but it still does not support
> >>>> inherit events during fork(), resulting in some deviations in its stat
> >>>> results compared with perf.
> >>>>
> >>>> perf stat result:
> >>>> $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop
> >>>>
> >>>>    Performance counter stats for './perf test -w sqrtloop':
> >>>>
> >>>>        2,316,038,116      cycles
> >>>>        2,859,350,725      instructions
> >>>>
> >>>>          1.009603637 seconds time elapsed
> >>>>
> >>>>          1.004196000 seconds user
> >>>>          0.003950000 seconds sys
> >>>>
> >>>> bperf stat result:
> >>>> $ ./perf stat --bpf-counters -e cycles,instructions -- \
> >>>>       ./perf test -w sqrtloop
> >>>>
> >>>>    Performance counter stats for './perf test -w sqrtloop':
> >>>>
> >>>>           18,762,093      cycles
> >>>>           23,487,766      instructions
> >>>>
> >>>>          1.008913769 seconds time elapsed
> >>>>
> >>>>          1.003248000 seconds user
> >>>>          0.004069000 seconds sys
> >>>>
> >>>> In order to support event inheritance, two new bpf programs are added
> >>>> to monitor the fork and exit of tasks respectively. When a task is
> >>>> created, add it to the filter map to enable counting, and reuse the
> >>>> `accum_key` of its parent task to count together with the parent task.
> >>>> When a task exits, remove it from the filter map to disable counting.
> >>>>
> >>>> After support:
> >>>> $ ./perf stat --bpf-counters -e cycles,instructions -- \
> >>>>       ./perf test -w sqrtloop
> >>>>
> >>>>  Performance counter stats for './perf test -w sqrtloop':
> >>>>
> >>>>      2,316,252,189      cycles
> >>>>      2,859,946,547      instructions
> >>>>
> >>>>        1.009422314 seconds time elapsed
> >>>>
> >>>>        1.003597000 seconds user
> >>>>        0.004270000 seconds sys
> >>>>
> >>>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> >>>> ---
> >>>>  tools/perf/builtin-stat.c                     |  4 +-
> >>>>  tools/perf/util/bpf_counter.c                 | 57 +++++++++---
> >>>>  tools/perf/util/bpf_counter.h                 | 13 ++-
> >>>>  tools/perf/util/bpf_counter_cgroup.c          |  3 +-
> >>>>  tools/perf/util/bpf_skel/bperf_follower.bpf.c | 87 +++++++++++++++++--
> >>>>  tools/perf/util/bpf_skel/bperf_u.h            |  5 ++
> >>>>  6 files changed, 145 insertions(+), 24 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >>>> index 3e6b9f216e80..c27b107c1985 100644
> >>>> --- a/tools/perf/builtin-stat.c
> >>>> +++ b/tools/perf/builtin-stat.c
> >>>> @@ -698,6 +698,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >>>>  	char msg[BUFSIZ];
> >>>>  	unsigned long long t0, t1;
> >>>>  	struct evsel *counter;
> >>>> +	struct bpf_stat_opts opts;
> >>>>  	size_t l;
> >>>>  	int status = 0;
> >>>>  	const bool forks = (argc > 0);
> >>>> @@ -725,7 +726,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >>>>  
> >>>>  	evlist__for_each_entry(evsel_list, counter) {
> >>>>  		counter->reset_group = false;
> >>>> -		if (bpf_counter__load(counter, &target)) {
> >>>> +		opts.inherit = !stat_config.no_inherit;
> >>>> +		if (bpf_counter__load(counter, &target, &opts)) {
> >>>
> >>> Maybe you can just add a boolean member in the struct target.
> >>
> >> Yes，this approach would be more straightforward. 
> >>
> >> I had considered it before, but, as you see, considering that `inherit` does not
> >> align well with the `target` semantics, I chose the another one.
> > 
> > Well, I think 'inherit' is well aligned with the target semantics.
> > We want some processes as the targets of the event and we want to
> > profile their children or not.
> > 
> 
> Ok.
> 
> >>
> >> Anyway, I'll try it. Code changes would be more clean. Thanks.
> >>
> >>>
> >>>
> >>>>  			err = -1;
> >>>>  			goto err_out;
> >>>>  		}
> >>>> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> >>>> index 7a8af60e0f51..00afea6bde63 100644
> >>>> --- a/tools/perf/util/bpf_counter.c
> >>>> +++ b/tools/perf/util/bpf_counter.c
> >>>> @@ -166,7 +166,9 @@ static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
> >>>>  	return -1;
> >>>>  }
> >>>>  
> >>>> -static int bpf_program_profiler__load(struct evsel *evsel, struct target *target)
> >>>> +static int bpf_program_profiler__load(struct evsel *evsel,
> >>>> +				      struct target *target,
> >>>> +				      struct bpf_stat_opts *opts __maybe_unused)
> >>>>  {
> >>>>  	char *bpf_str, *bpf_str_, *tok, *saveptr = NULL, *p;
> >>>>  	u32 prog_id;
> >>>> @@ -364,6 +366,7 @@ static int bperf_lock_attr_map(struct target *target)
> >>>>  
> >>>>  static int bperf_check_target(struct evsel *evsel,
> >>>>  			      struct target *target,
> >>>> +			      struct bpf_stat_opts *opts,
> >>>>  			      enum bperf_filter_type *filter_type,
> >>>>  			      __u32 *filter_entry_cnt)
> >>>>  {
> >>>> @@ -383,7 +386,12 @@ static int bperf_check_target(struct evsel *evsel,
> >>>>  		*filter_type = BPERF_FILTER_PID;
> >>>>  		*filter_entry_cnt = perf_thread_map__nr(evsel->core.threads);
> >>>>  	} else if (target->pid || evsel->evlist->workload.pid != -1) {
> >>>> -		*filter_type = BPERF_FILTER_TGID;
> >>>> +		/*
> >>>> +		 * unlike the PID type, the TGID type implicitly enables
> >>>> +		 * event inheritance within a single process.
> >>>> +		 */
> >>>> +		*filter_type = opts->inherit ?
> >>>> +				BPERF_FILTER_TGID : BPERF_FILTER_PID;
> >>>
> >>> I'm not sure if it's right.  You should be able to use PID type with
> >>> inheritance.  In this case child processes or threads from the selected
> >>> thread would be counted only.
> >>
> >> Sorry, don't quite understand. TGID type counts together with all sub-threads within
> >> the same process, which is what inheritance needs to do; while PID type only counts
> >> for a single thread and should be used when inheritance is turned off. This is equivalent
> >> to the code above.
> > 
> > Let me be clear:
> > 
> >  * PID w/o inherit : specified threads only
> >  * PID w/ inherit  : specified threads + all threads or child process from the threads
> >  * TGID w/o inherit: specified process (all threads in the process) only
> >  * TGID w/ inherit : specified process + all children from the processes
> > 
> > For the TGID w/o inherit case, it's ok not to track new threads in the
> > process because they will have the same tgid anyway.
> > 
> > So you cannot change the filter type using inherit value.  It should be
> > used to control whether it tracks new task only.
> > 
> 
> So changing 'TGID w/o inherit' to 'PID w/o inherit' will lose counts of all
> threads in the process, right?

Yep.

> 
> It's clear now. Thanks for the explanation.
 
No problem, looking forward to v5.

Thanks,
Namhyung


