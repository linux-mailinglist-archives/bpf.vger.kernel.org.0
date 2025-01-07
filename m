Return-Path: <bpf+bounces-48170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266FA04A4F
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 20:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A2F165A31
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F591F63DA;
	Tue,  7 Jan 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQPDzuJT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D9A1F5419;
	Tue,  7 Jan 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736278652; cv=none; b=WxFpdwlxx8bCFRyGuaE5NgMXi/lMt2X0Mt6jnaE9ibqCf5Gbgbd281AQ5sgn/s2gDDEbV1Wc1y/sv65GtUKH/MS6HOSLdEA/q6Xkz+X3AUEmN3I3ZbTRw4HbCDd0VLQGQE/y1z6bOXb+2bRHBJGNCdknSQJT/ABVA7qrPnbl+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736278652; c=relaxed/simple;
	bh=SjHQPWUIXlEhwJpMaEW6FQEovzE3VLAPn+72YuB9FPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mwlre8LhHSIcUDZ2vBtEUb1MameqR0NqBKI5hl++ij5WjjVxUqCYORVYfjpIyuKDjmLShQzqtElaFL6DqqAYqgS73I1ovxcwhXxVaEyV3WP/4DUermPeU3H5ltx+YM6DGironH0l3qq+LEKEoYagsADeTOp0BO4cyVQouvP6iv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQPDzuJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ACCC4CED6;
	Tue,  7 Jan 2025 19:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736278652;
	bh=SjHQPWUIXlEhwJpMaEW6FQEovzE3VLAPn+72YuB9FPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQPDzuJTS5t2Xg0TzB+fUjabOoY0VILyTS2EjKAC1TAq4R/wxXYJedkxGGxcSjkvq
	 EKLcTKgcDT1czpjwYhliI+oIYQNg4JLDPlGc3DEkEADPAdGWTwAjftyH2HDdaqOhh0
	 Hw5tkidDSLLSzxQE52EE99deUadYzX9LmNeoA++ZMISfZJ0SCu+dIeASkBTc5Kja5P
	 zA0YdvUfogomUGXRY/BGuziuAbv1ReBb1s5e0ULZIZvAOu0ycxqya/uVoY+3trm1L4
	 0obnQmKubOFNCNhrgZEa3vAiYV9Vl3X1dQVOg18g2JIe0ABiJPf2Hkgz3cWWEx1ge8
	 SLZONclTmJqLQ==
Date: Tue, 7 Jan 2025 11:37:29 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v4 3/4] perf record: Skip don't fail for events that
 don't open
Message-ID: <Z32CeUuxt4ASJeRe@google.com>
References: <20250107180854.770470-1-irogers@google.com>
 <20250107180854.770470-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107180854.770470-4-irogers@google.com>

Hi Ian,

On Tue, Jan 07, 2025 at 10:08:53AM -0800, Ian Rogers wrote:
> Whilst for many tools it is an expected behavior that failure to open
> a perf event is a failure, ARM decided to name PMU events the same as
> legacy events and then failed to rename such events on a server uncore
> SLC PMU. As perf's default behavior when no PMU is specified is to
> open the event on all PMUs that advertise/"have" the event, this
> yielded failures when trying to make the priority of legacy and
> sysfs/json events uniform - something requested by RISC-V and ARM. A
> legacy event user on ARM hardware may find their event opened on an
> uncore PMU which for perf record will fail. Arnaldo suggested skipping
> such events which this patch implements. Rather than have the skipping
> conditional on running on ARM, the skipping is done on all
> architectures as such a fundamental behavioral difference could lead
> to problems with tools built/depending on perf.
> 
> An example of perf record failing to open events on x86 is:
> ```
> $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> Error:
> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' which will be removed.
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> "dmesg | grep -i perf" may provide additional information.
> 
> Error:
> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' which will be removed.
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> "dmesg | grep -i perf" may provide additional information.
> 
> Error:
> Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> The LLC-prefetch-read event is not supported.
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> 
> $ perf report --stats
> Aggregated stats:
>                TOTAL events:      17255
>                 MMAP events:        284  ( 1.6%)
>                 COMM events:       1961  (11.4%)
>                 EXIT events:          1  ( 0.0%)
>                 FORK events:       1960  (11.4%)
>               SAMPLE events:         87  ( 0.5%)
>                MMAP2 events:      12836  (74.4%)
>              KSYMBOL events:         83  ( 0.5%)
>            BPF_EVENT events:         36  ( 0.2%)
>       FINISHED_ROUND events:          2  ( 0.0%)
>             ID_INDEX events:          1  ( 0.0%)
>           THREAD_MAP events:          1  ( 0.0%)
>              CPU_MAP events:          1  ( 0.0%)
>            TIME_CONV events:          1  ( 0.0%)
>        FINISHED_INIT events:          1  ( 0.0%)
> cycles stats:
>               SAMPLE events:         87
> ```
> 
> If all events fail to open then the perf record will fail:
> ```
> $ perf record -e LLC-prefetch-read true
> Error:
> Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> The LLC-prefetch-read event is not supported.
> Error:
> Failure to open any events for recording
> ```
> 
> This is done by detecting if dummy events were implicitly added by
> perf and seeing if the evlist is empty without them. This allows the
> dummy event still to be recorded:
> ```
> $ perf record -e dummy true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.046 MB perf.data ]
> ```
> but fail when inserted:
> ```
> $ perf record -e LLC-prefetch-read -a true
> Error:
> Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> The LLC-prefetch-read event is not supported.
> Error:
> Failure to open any events for recording
> ```
> 
> The issue with legacy events is that on RISC-V they want the driver to
> not have mappings from legacy to non-legacy config encodings for each
> vendor/model due to size, complexity and difficulty to update. It was
> reported that on ARM Apple-M? CPUs the legacy mapping in the driver
> was broken and the sysfs/json events should always take precedent,
> however, it isn't clear this is still the case. It is the case that
> without working around this issue a legacy event like cycles without a
> PMU can encode differently than when specified with a PMU - the
> non-PMU version favoring legacy encodings, the PMU one avoiding legacy
> encodings.
> 
> The patch removes events and then adjusts the idx value for each
> evsel. This is done so that the dense xyarrays used for file
> descriptors, etc. don't contain broken entries. As event opening
> happens relatively late in the record process, use of the idx value
> before the open will have become corrupted, so it is expected there
> are latent bugs hidden behind this change - the change is best
> effort. As the only vendor that has broken event names is ARM, this
> will principally effect ARM users. They will also experience warning
> messages like those above because of the uncore PMU advertising legacy
> event names.
> 
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: James Clark <james.clark@linaro.org>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/perf/builtin-record.c | 54 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 5db1aedf48df..b3f06638f3c6 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -161,6 +161,7 @@ struct record {
>  	struct evlist		*sb_evlist;
>  	pthread_t		thread_id;
>  	int			realtime_prio;
> +	int			num_parsed_dummy_events;
>  	bool			switch_output_event_set;
>  	bool			no_buildid;
>  	bool			no_buildid_set;
> @@ -961,7 +962,6 @@ static int record__config_tracking_events(struct record *rec)
>  	 */
>  	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
>  	    perf_pmus__num_core_pmus() > 1) {
> -
>  		/*
>  		 * User space tasks can migrate between CPUs, so when tracing
>  		 * selected CPUs, sideband for all CPUs is still needed.
> @@ -1366,6 +1366,7 @@ static int record__open(struct record *rec)
>  	struct perf_session *session = rec->session;
>  	struct record_opts *opts = &rec->opts;
>  	int rc = 0;
> +	bool skipped = false;
>  
>  	evlist__for_each_entry(evlist, pos) {
>  try_again:
> @@ -1381,15 +1382,50 @@ static int record__open(struct record *rec)
>  			        pos = evlist__reset_weak_group(evlist, pos, true);
>  				goto try_again;
>  			}
> -			rc = -errno;
>  			evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
> -			ui__error("%s\n", msg);
> -			goto out;
> +			ui__error("Failure to open event '%s' on PMU '%s' which will be removed.\n%s\n",
> +				  evsel__name(pos), evsel__pmu_name(pos), msg);
> +			pos->skippable = true;
> +			skipped = true;
> +		} else {
> +			pos->supported = true;
>  		}
> -
> -		pos->supported = true;
>  	}
>  
> +	if (skipped) {
> +		struct evsel *tmp;
> +		int idx = 0, num_dummy = 0, num_non_dummy = 0,
> +		    removed_dummy = 0, removed_non_dummy = 0;
> +
> +		/* Remove evsels that failed to open and update indices. */
> +		evlist__for_each_entry_safe(evlist, tmp, pos) {
> +			if (evsel__is_dummy_event(pos))
> +				num_dummy++;
> +			else
> +				num_non_dummy++;
> +
> +			if (!pos->skippable)
> +				continue;
> +
> +			if (evsel__is_dummy_event(pos))
> +				removed_dummy++;
> +			else
> +				removed_non_dummy++;
> +
> +			evlist__remove(evlist, pos);
> +		}
> +		evlist__for_each_entry(evlist, pos) {
> +			pos->core.idx = idx++;
> +		}
> +		/* If list is empty except implicitly added dummy events then fail. */
> +		if ((num_non_dummy == removed_non_dummy) &&
> +		    ((rec->num_parsed_dummy_events == 0) ||
> +		     (removed_dummy >= (num_dummy - rec->num_parsed_dummy_events)))) {
> +			ui__error("Failure to open any events for recording.\n");
> +			rc = -1;
> +			goto out;
> +		}
> +	}

Instead of couting dummy events, I wonder if it could check any
supported non-dummy events in the evlist.

	if (skipped) {
		bool found = false;

		evlist__for_each_entry_safe(evlist, tmp, pos) {
			if (pos->skippable) {
				evlist__remove(evlist, pos);
				continue;
			}
			if (evsel__is_dummy_event(pos))
				continue;
			found = true;
		}
		if (!found) {
			ui__error("...");
			rc = -1;
			goto out;
		}
		/* recalculate the index */
	}

Then it should do the same, no?  The corner case would be when users
specify dummy events in the command line (maybe to check permissions
by the exit code).

  $ perf record -a -e dummy true

If it fails to open, then 'skipped' set and 'found' not set so the
command will fail.  It it succeeds, then it doesn't set 'skipped'
and the command will exit with 0.

Do I miss something?

Thanks,
Namhyung


>  	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist)) {
>  		pr_warning(
>  "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
> @@ -3975,6 +4011,7 @@ int cmd_record(int argc, const char **argv)
>  	int err;
>  	struct record *rec = &record;
>  	char errbuf[BUFSIZ];
> +	struct evsel *evsel;
>  
>  	setlocale(LC_ALL, "");
>  
> @@ -4001,6 +4038,11 @@ int cmd_record(int argc, const char **argv)
>  	if (quiet)
>  		perf_quiet_option();
>  
> +	evlist__for_each_entry(rec->evlist, evsel) {
> +		if (evsel__is_dummy_event(evsel))
> +			rec->num_parsed_dummy_events++;
> +	}
> +
>  	err = symbol__validate_sym_arguments();
>  	if (err)
>  		return err;
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 

