Return-Path: <bpf+bounces-28142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FB98B616F
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B79D282BB8
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D75813AA52;
	Mon, 29 Apr 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndYrwIhk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A448E127E0E;
	Mon, 29 Apr 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416790; cv=none; b=koMh7J3zzmNmNdPqTIVrq3WBpO/JL+Qi05+XzBwimrSlmtI+5Jy0EbZ+PTvCYlQstjGRIOMH+lY4dbIucThLhLOSsp2alsb7tPfUQnaHabQmk7ocqYZ1xtV3sr3LW3viy0oR7S0EzR7YEqPvPcp2ndqFRgBjW3AoWGMFvP9OabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416790; c=relaxed/simple;
	bh=WGI3EDPZ4MlH4iutimdDJe0WHSBY2SL8FWVcewjevmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0cHWop24MfIiDX412KMUpA3hdFnqv6EIYVvQWCKERv02EUgjSTYhTNd5oeIkYwlucLkuRl3Zznx8X8VRE+qUWTABNGS/hY2He6dxvtNXTfx6j2S6ZtOAPfsM5ZL5YB1+RahY2IFErgJ73jOsfLcg3hSuRh1DqPB+70cDf93TlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndYrwIhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E24C113CD;
	Mon, 29 Apr 2024 18:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714416790;
	bh=WGI3EDPZ4MlH4iutimdDJe0WHSBY2SL8FWVcewjevmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ndYrwIhkPd76ERspDAtBN2dEusSWPiXpZLeeg5CCRnuK8QlFy9gFr0q41bRjCT7Vj
	 MyzR0UkIehyJPhcfF7nTcaT4MmjItePgeE7Q4udAI2n5bPpm5KBgJ/4mw4EOw2q0FB
	 82AbN1EtViXnALs03u4QaZS8HCGDmRbbZA/yqnt9jXRRt/ftcLfORGp5IQhYAsN8Q8
	 Q4XtgjqekDY/OzzcHG2KRqqqRV3EWgtSCHXUaZmivMP52Afdgdr5JetUAiGNInvOfC
	 WfKJJpXBChE2bRuV/gpcnYiyrJ5aUUrw//G7+xLplkSGrseLecWRkg4RXCOGSTBQ8D
	 ttI2zGcpsiQ+Q==
Date: Mon, 29 Apr 2024 15:53:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, zegao2021@gmail.com, leo.yan@linux.dev,
	ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1 1/4] perf record: Dump off-cpu samples directly
Message-ID: <Zi_slOlsZBjTbNIH@x1>
References: <20240422083645.1930939-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422083645.1930939-1-howardchu95@gmail.com>

On Mon, Apr 22, 2024 at 04:36:45PM +0800, Howard Chu wrote:
> Parse off-cpu events using parse_event(). Change the placement of
> record__config_off_cpu to after record__open because we need to write
> mmapped fds into BPF's perf_event_array map, also, write 
> sample_id/sample_type into BPF. In record__pushfn and record__aio_pushfn, 
> handle off-cpu samples using off_cpu_strip. This is because the off-cpu 
> samples that we want to write to perf.data is in off-cpu samples' raw_data 
> section:

Hey,

	This lacks a cover letter and the chainig of patches so that b4
can fetch the series.

	Also all 5 patches have the same summary and different
descriptions and contents, can you please rework the patch series, using
'git format-patch', and make the description reflect what each patch is
doing?

Thanks,

- Arnaldo
 
> regular samples:
> [sample: sample_data]
> 
> off-cpu samples:
> [sample: [raw_data: sample_data]]
> 
> We need to extract the real useful sample data out before writing.
> 
> Hooks record_done just before evlist__disable to stop BPF program from
> outputting, otherwise, we lose some samples.
> 
> After samples are collected, change sample_type of off-cpu event to
> the OFFCPU_SAMPLE_TYPES for parsing correctly, it was PERF_SAMPLE_RAW and
> some others, because BPF can only output to a specific type of perf_event,
> which is why `evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;` is
> deleted in util/evsel.c. 
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-record.c | 98 ++++++++++++++++++++++++++++++++++---
>  tools/perf/util/evsel.c     |  8 ---
>  2 files changed, 91 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 2ff718d3e202..c31b23905f1b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -389,6 +389,8 @@ struct record_aio {
>  static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size)
>  {
>  	struct record_aio *aio = to;
> +	char *bf_stripped = NULL;
> +	size_t stripped;
>  
>  	/*
>  	 * map->core.base data pointed by buf is copied into free map->aio.data[] buffer
> @@ -404,6 +406,31 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
>  	 * from the beginning of the kernel buffer till the end of the data chunk.
>  	 */
>  
> +	if (aio->rec->off_cpu) {
> +		if (size == 0)
> +			return 0;
> +
> +		map->core.start -= size;
> +		size = map->core.end - map->core.start;
> +
> +		bf_stripped = malloc(size);
> +
> +		if (bf_stripped == NULL) {
> +			pr_err("Failed to allocate off-cpu strip buffer\n");
> +			return -ENOMEM;
> +		}
> +
> +		stripped = off_cpu_strip(aio->rec->evlist, map, bf_stripped, size);
> +
> +		if (stripped < 0) {
> +			size = (int)stripped;
> +			goto out;
> +		}
> +
> +		size = stripped;
> +		buf = bf_stripped;
> +	}
> +
>  	if (record__comp_enabled(aio->rec)) {
>  		ssize_t compressed = zstd_compress(aio->rec->session, NULL, aio->data + aio->size,
>  						   mmap__mmap_len(map) - aio->size,
> @@ -432,6 +459,9 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
>  
>  	aio->size += size;
>  
> +out:
> +	free(bf_stripped);
> +
>  	return size;
>  }
>  
> @@ -635,6 +665,38 @@ static int process_locked_synthesized_event(struct perf_tool *tool,
>  static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  {
>  	struct record *rec = to;
> +	int err;
> +	char *bf_stripped = NULL;
> +	size_t stripped;
> +
> +	if (rec->off_cpu) {
> +		/*
> +		 * We'll read all the events at once without masking.
> +		 * When reading the remainder from a map, the size is 0, because
> +		 * start is shifted to the end so no more data is to be read.
> +		 */
> +		if (size == 0)
> +			return 0;
> +
> +		map->core.start -= size;
> +		/* get the total size */
> +		size = map->core.end - map->core.start;
> +
> +		bf_stripped = malloc(size);
> +
> +		if (bf_stripped == NULL) {
> +			pr_err("Failed to allocate off-cpu strip buffer\n");
> +			return -ENOMEM;
> +		}
> +
> +		stripped = off_cpu_strip(rec->evlist, map, bf_stripped, size);
> +
> +		if (stripped < 0)
> +			return (int)stripped;
> +
> +		size = stripped;
> +		bf = bf_stripped;
> +	}
>  
>  	if (record__comp_enabled(rec)) {
>  		ssize_t compressed = zstd_compress(rec->session, map, map->data,
> @@ -648,7 +710,11 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  	}
>  
>  	thread->samples++;
> -	return record__write(rec, map, bf, size);
> +	err = record__write(rec, map, bf, size);
> +
> +	free(bf_stripped);
> +
> +	return err;
>  }
>  
>  static volatile sig_atomic_t signr = -1;
> @@ -1790,6 +1856,7 @@ record__finish_output(struct record *rec)
>  		if (rec->buildid_all)
>  			perf_session__dsos_hit_all(rec->session);
>  	}
> +
>  	perf_session__write_header(rec->session, rec->evlist, fd, true);
>  
>  	return;
> @@ -2501,6 +2568,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		}
>  	}
>  
> +	if (rec->off_cpu) {
> +		err = record__config_off_cpu(rec);
> +		if (err) {
> +			pr_err("record__config_off_cpu failed, error %d\n", err);
> +			goto out_free_threads;
> +		}
> +	}
> +
>  	/*
>  	 * Normally perf_session__new would do this, but it doesn't have the
>  	 * evlist.
> @@ -2764,6 +2839,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		 * disable events in this case.
>  		 */
>  		if (done && !disabled && !target__none(&opts->target)) {
> +			perf_hooks__invoke_record_done();
>  			trigger_off(&auxtrace_snapshot_trigger);
>  			evlist__disable(rec->evlist);
>  			disabled = true;
> @@ -2827,14 +2903,17 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	} else
>  		status = err;
>  
> -	if (rec->off_cpu)
> -		rec->bytes_written += off_cpu_write(rec->session);
> -
>  	record__read_lost_samples(rec);
>  	record__synthesize(rec, true);
>  	/* this will be recalculated during process_buildids() */
>  	rec->samples = 0;
>  
> +	/* change to the correct sample type for parsing */
> +	if (rec->off_cpu && off_cpu_change_type(rec->evlist)) {
> +		pr_err("ERROR: Failed to change sample type for off-cpu event\n");
> +		goto out_delete_session;
> +	}
> +
>  	if (!err) {
>  		if (!rec->timestamp_filename) {
>  			record__finish_output(rec);
> @@ -3198,7 +3277,7 @@ static int switch_output_setup(struct record *rec)
>  	unsigned long val;
>  
>  	/*
> -	 * If we're using --switch-output-events, then we imply its 
> +	 * If we're using --switch-output-events, then we imply its
>  	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
>  	 *  thread to its parent.
>  	 */
> @@ -4221,9 +4300,14 @@ int cmd_record(int argc, const char **argv)
>  	}
>  
>  	if (rec->off_cpu) {
> -		err = record__config_off_cpu(rec);
> +		char off_cpu_event[64];
> +
> +		snprintf(off_cpu_event, sizeof(off_cpu_event),
> +			 "bpf-output/no-inherit=1,name=%s/", OFFCPU_EVENT);
> +
> +		err = parse_event(rec->evlist, off_cpu_event);
>  		if (err) {
> -			pr_err("record__config_off_cpu failed, error %d\n", err);
> +			pr_err("Failed to open off-cpu event\n");
>  			goto out;
>  		}
>  	}
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 3536404e9447..c08ae6a3c8d6 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1092,11 +1092,6 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
>  	}
>  }
>  
> -static bool evsel__is_offcpu_event(struct evsel *evsel)
> -{
> -	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
> -}
> -
>  /*
>   * The enable_on_exec/disabled value strategy:
>   *
> @@ -1363,9 +1358,6 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	if (evsel__is_dummy_event(evsel))
>  		evsel__reset_sample_bit(evsel, BRANCH_STACK);
>  
> -	if (evsel__is_offcpu_event(evsel))
> -		evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;
> -
>  	arch__post_evsel_config(evsel, attr);
>  }
>  
> -- 
> 2.44.0

