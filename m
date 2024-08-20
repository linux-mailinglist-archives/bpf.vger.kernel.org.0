Return-Path: <bpf+bounces-37651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11B5958F5D
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 22:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A869C285977
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 20:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610B41C4631;
	Tue, 20 Aug 2024 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFLgTjjH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160B125D5;
	Tue, 20 Aug 2024 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724187115; cv=none; b=bL2FreoamknflYkUvu8m0wS4zTHmz9CXWvoPvakunfoZ2mBnRCCXegjpbAhkpuwsgRC8/cOXeLXt1zON8zMWuQ3vmvOGMy8L6uAIS/wN9Mav90WR+zZwESObhypfYwum3TEOvtdSs/6VjzO5LOWfpZWvEb1LdA1k1V0RtdHJYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724187115; c=relaxed/simple;
	bh=Hr2WkYXHht92BsyWhuWRTMVmA0WXX1rlmOk1TXoec1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtDlsavE7ihjOR4GhELNMXNla0aDRA+EwtCgGbMWQG8yfHpTL7ztiqRMWd1lH58K8w6egKlSSclqOmwr6tr21CH9pak/fxnzWIM0PZFp8s8m2r32K0FILtIhj9omKbToIxg8gcDN1BnGSgldq3J1teO4RBEF/DSDyWcqU44g9Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFLgTjjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F97C4AF12;
	Tue, 20 Aug 2024 20:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724187115;
	bh=Hr2WkYXHht92BsyWhuWRTMVmA0WXX1rlmOk1TXoec1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFLgTjjH2nTKwc5g1WJKnPgSRZSEatEv35Z7CV+HhQU9ntxqkkvMSHVmzchy0WI+j
	 bmYOpxWjo81VhmfmQBojGka0CHRkJUD2HdOFLPYFBvRMcRoVb00qrQQKAV12gca7iQ
	 xgVs4euWMarMDgUqw0IjiDHUtf1n7de6M/U51I+dUMUk4CjVwrv57/3Efx5YPAn9N1
	 1a/kR59+MbPAZxMxdDS/DVWjlAKDGUA0q56TASI5CY1KODgL0m1NGuKJZY1iRRQe+A
	 wSllWl0hX30hNCDONYYBQQue8mAtZz5jb5qNQI/RMS8j/UjiD6P6jpgcYt67zy6Hbn
	 Exg+9bkWTIHXA==
Date: Tue, 20 Aug 2024 17:51:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v3 2/3] perf tools: Print lost samples due to BPF filter
Message-ID: <ZsUB57VlFtdY0O0M@x1>
References: <20240820154504.128923-1-namhyung@kernel.org>
 <20240820154504.128923-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820154504.128923-2-namhyung@kernel.org>

On Tue, Aug 20, 2024 at 08:45:03AM -0700, Namhyung Kim wrote:
> +++ b/tools/perf/builtin-report.c
> @@ -795,8 +795,13 @@ static int count_lost_samples_event(const struct perf_tool *tool,
>  
>  	evsel = evlist__id2evsel(rep->session->evlist, sample->id);
>  	if (evsel) {
> -		hists__inc_nr_lost_samples(evsel__hists(evsel),
> -					   event->lost_samples.lost);
> +		struct hists *hists = evsel__hists(evsel);
> +		u32 count = event->lost_samples.lost;
> +
> +		if (event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_BPF)
> +			hists__inc_nr_dropped_samples(hists, count);

So this is inconsistent, we call it sometimes "lost", sometines
"dropped", I think we should make it consistent and call it "dropped",
because its not like it was "lost" because we didn't have the required
resources, memory, ring buffer being full, etc, i.e. the semantic
associated with PERF_RECORD_LOST.

I.e. LOST is non intentional, not expected, DROPPED is the result of the
user _asking_ for something to be trown away, to be filtered, its
expected behaviour, there is value in differentiating one from the
other.

- Arnaldo

> +		else
> +			hists__inc_nr_lost_samples(hists, count);
>  	}
>  	return 0;
>  }
> diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
> index 9372e8904d22..74b2c619c56c 100644
> --- a/tools/perf/ui/stdio/hist.c
> +++ b/tools/perf/ui/stdio/hist.c
> @@ -913,11 +913,11 @@ size_t events_stats__fprintf(struct events_stats *stats, FILE *fp)
>  			continue;
>  
>  		if (i && total) {
> -			ret += fprintf(fp, "%16s events: %10d  (%4.1f%%)\n",
> +			ret += fprintf(fp, "%20s events: %10d  (%4.1f%%)\n",
>  				       name, stats->nr_events[i],
>  				       100.0 * stats->nr_events[i] / total);
>  		} else {
> -			ret += fprintf(fp, "%16s events: %10d\n",
> +			ret += fprintf(fp, "%20s events: %10d\n",
>  				       name, stats->nr_events[i]);
>  		}
>  	}
> diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
> index f43e5b1a366a..eabd7913c309 100644
> --- a/tools/perf/util/events_stats.h
> +++ b/tools/perf/util/events_stats.h
> @@ -18,7 +18,18 @@
>   * PERF_RECORD_LOST_SAMPLES event. The number of lost-samples events is stored
>   * in .nr_events[PERF_RECORD_LOST_SAMPLES] while total_lost_samples tells
>   * exactly how many samples the kernel in fact dropped, i.e. it is the sum of
> - * all struct perf_record_lost_samples.lost fields reported.
> + * all struct perf_record_lost_samples.lost fields reported without setting the
> + * misc field in the header.
> + *
> + * The BPF program can discard samples according to the filter expressions given
> + * by the user.  This number is kept in a BPF map and dumped at the end of perf
> + * record in a PERF_RECORD_LOST_SAMPLES event.  To differentiate it from other
> + * lost samples, perf tools sets PERF_RECORD_MISC_LOST_SAMPLES_BPF flag in the
> + * header.misc field.  The number of dropped-samples events is stored in
> + * .nr_events[PERF_RECORD_LOST_SAMPLES] while total_dropped_samples tells
> + * exactly how many samples the BPF program in fact dropped, i.e. it is the sum
> + * of all struct perf_record_lost_samples.lost fields reported with the misc
> + * field set in the header.
>   *
>   * The total_period is needed because by default auto-freq is used, so
>   * multiplying nr_events[PERF_EVENT_SAMPLE] by a frequency isn't possible to get
> @@ -28,6 +39,7 @@
>  struct events_stats {
>  	u64 total_lost;
>  	u64 total_lost_samples;
> +	u64 total_dropped_samples;
>  	u64 total_aux_lost;
>  	u64 total_aux_partial;
>  	u64 total_aux_collision;
> @@ -48,6 +60,7 @@ struct hists_stats {
>  	u32 nr_samples;
>  	u32 nr_non_filtered_samples;
>  	u32 nr_lost_samples;
> +	u32 nr_dropped_samples;
>  };
>  
>  void events_stats__inc(struct events_stats *stats, u32 type);
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 0f9ce2ee2c31..dadce2889e52 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -2385,6 +2385,11 @@ void hists__inc_nr_lost_samples(struct hists *hists, u32 lost)
>  	hists->stats.nr_lost_samples += lost;
>  }
>  
> +void hists__inc_nr_dropped_samples(struct hists *hists, u32 lost)
> +{
> +	hists->stats.nr_dropped_samples += lost;
> +}
> +
>  static struct hist_entry *hists__add_dummy_entry(struct hists *hists,
>  						 struct hist_entry *pair)
>  {
> @@ -2729,18 +2734,24 @@ size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp)
>  
>  	evlist__for_each_entry(evlist, pos) {
>  		struct hists *hists = evsel__hists(pos);
> +		u64 total_samples = hists->stats.nr_samples;
> +
> +		total_samples += hists->stats.nr_lost_samples;
> +		total_samples += hists->stats.nr_dropped_samples;
>  
> -		if (symbol_conf.skip_empty && !hists->stats.nr_samples &&
> -		    !hists->stats.nr_lost_samples)
> +		if (symbol_conf.skip_empty && total_samples == 0)
>  			continue;
>  
>  		ret += fprintf(fp, "%s stats:\n", evsel__name(pos));
>  		if (hists->stats.nr_samples)
> -			ret += fprintf(fp, "%16s events: %10d\n",
> +			ret += fprintf(fp, "%20s events: %10d\n",
>  				       "SAMPLE", hists->stats.nr_samples);
>  		if (hists->stats.nr_lost_samples)
> -			ret += fprintf(fp, "%16s events: %10d\n",
> +			ret += fprintf(fp, "%20s events: %10d\n",
>  				       "LOST_SAMPLES", hists->stats.nr_lost_samples);
> +		if (hists->stats.nr_dropped_samples)
> +			ret += fprintf(fp, "%20s events: %10d\n",
> +				       "LOST_SAMPLES (BPF)", hists->stats.nr_dropped_samples);
>  	}
>  
>  	return ret;
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 30c13fc8cbe4..4ea247e54fb6 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -371,6 +371,7 @@ void hists__inc_stats(struct hists *hists, struct hist_entry *h);
>  void hists__inc_nr_events(struct hists *hists);
>  void hists__inc_nr_samples(struct hists *hists, bool filtered);
>  void hists__inc_nr_lost_samples(struct hists *hists, u32 lost);
> +void hists__inc_nr_dropped_samples(struct hists *hists, u32 lost);
>  
>  size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
>  		      int max_cols, float min_pcnt, FILE *fp,
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index c08774d06d14..00a49d0744fc 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -642,8 +642,9 @@ int machine__process_lost_event(struct machine *machine __maybe_unused,
>  int machine__process_lost_samples_event(struct machine *machine __maybe_unused,
>  					union perf_event *event, struct perf_sample *sample)
>  {
> -	dump_printf(": id:%" PRIu64 ": lost samples :%" PRI_lu64 "\n",
> -		    sample->id, event->lost_samples.lost);
> +	dump_printf(": id:%" PRIu64 ": lost samples :%" PRI_lu64 "%s\n",
> +		    sample->id, event->lost_samples.lost,
> +		    event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_BPF ? " (BPF)" : "");
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index d2bd563119bc..774eb3382000 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1290,8 +1290,9 @@ static int machines__deliver_event(struct machines *machines,
>  			evlist->stats.total_lost += event->lost.lost;
>  		return tool->lost(tool, event, sample, machine);
>  	case PERF_RECORD_LOST_SAMPLES:
> -		if (tool->lost_samples == perf_event__process_lost_samples &&
> -		    !(event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_BPF))
> +		if (event->header.misc & PERF_RECORD_MISC_LOST_SAMPLES_BPF)
> +			evlist->stats.total_dropped_samples += event->lost_samples.lost;
> +		else if (tool->lost_samples == perf_event__process_lost_samples)
>  			evlist->stats.total_lost_samples += event->lost_samples.lost;
>  		return tool->lost_samples(tool, event, sample, machine);
>  	case PERF_RECORD_READ:
> -- 
> 2.46.0.184.g6999bdac58-goog

