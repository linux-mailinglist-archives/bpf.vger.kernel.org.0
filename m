Return-Path: <bpf+bounces-36393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BBC947D92
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 17:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAD61F2352C
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71115B118;
	Mon,  5 Aug 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUKQN3p/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4315921D;
	Mon,  5 Aug 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870198; cv=none; b=ZeoUNf+uPqAQlgpnjlAoRO/0/uewbPIVtvmvMA/qkWF/EfE9RglMDo234etI2x1MfjiS0rs0ZSvgmo2ELW1vwI51CSF68J1TZDB6v+BxDN9tp2idW7cJFKOK/7e7gNU9V7rceu0bN5mz+2P8b72zZIgNFEOdD5wf43HBSVMCLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870198; c=relaxed/simple;
	bh=Qm1k48o0KGpJ2pRtySvmjFFs/Av1mEF82Gx3Fp1bTec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br2ymLG4O0wM7C3WZAG1f4vGBnsRGvv+p2jVOE84+SVcOd65EbfzjtjuOXGe/+kh4q1Lp9uh0tBW4lCgY40rumc2huKnZHuxrAXVZx1rmLt0Jme44nWRw37GGS8VvCxAZi1Q+EYvoxqKsaSLIgaUDxVeAnGGAI5k0Lg89iiCpcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUKQN3p/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC8CC32782;
	Mon,  5 Aug 2024 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722870198;
	bh=Qm1k48o0KGpJ2pRtySvmjFFs/Av1mEF82Gx3Fp1bTec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUKQN3p/onoewFeQlGUUZstawjLhgR/+b8NomOKQY0rwjKeK/wKgaDPAL3A0iV6VV
	 d6eB1wJqfuGaMcNg1ywJ1yXsESEN4BXTT3TAqcDZnOcALgSLYcn0KmOmOik4C0GCbk
	 aLtBIefoR4ifszlJDkiGMpBTCGpV66eqJXrGSSwVze6lKmDdLytiTjyJXj00oce53g
	 lUOap4BiW3AqDSyeynmpY/Srz434bW/+v/0g0AX9KEB1VFcyT62PbEtE4fd0gY7zAg
	 VLRS0dMRtfJBS6GiUUe2VKrMphSbczkjeWDehGijs6xKcYAljIS1oWy3b8daWAoz4p
	 htAomuzqn6GVw==
Date: Mon, 5 Aug 2024 12:03:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
	Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf bpf-filter: Support multiple events properly
Message-ID: <ZrDpsnReuIClKFnk@x1>
References: <20240802173752.1014527-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802173752.1014527-1-namhyung@kernel.org>

On Fri, Aug 02, 2024 at 10:37:52AM -0700, Namhyung Kim wrote:
> So far it used tgid as a key to get the filter expressions in the
> pinned filters map for regular users but it won't work well if the has
> more than one filters at the same time.  Let's add the event id to the
> key of the filter hash map so that it can identify the right filter
> expression in the BPF program.
> 
> As the event can be inherited to child tasks, it should use the primary
> id which belongs to the parent (original) event.  Since evsel opens the
> event for multiple CPUs and tasks, it needs to maintain a separate hash
> map for the event id.

I'm trying to test it now, it would be nice to have the series of events
needed to test that the feature is working.

Some comments below.
 
> In the user space, it keeps a list for the multiple evsel and release
> the entries in the both hash map when it closes the event.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf-filter.c                 | 288 ++++++++++++++++---
>  tools/perf/util/bpf_skel/sample-filter.h     |  11 +-
>  tools/perf/util/bpf_skel/sample_filter.bpf.c |  42 ++-
>  tools/perf/util/bpf_skel/vmlinux/vmlinux.h   |   5 +
>  4 files changed, 304 insertions(+), 42 deletions(-)
> 
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index c5eb0b7eec19..69b147cba969 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -1,4 +1,45 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +/**
> + * Generic event filter for sampling events in BPF.
> + *
> + * The BPF program is fixed and just to read filter expressions in the 'filters'
> + * map and compare the sample data in order to reject samples that don't match.
> + * Each filter expression contains a sample flag (term) to compare, an operation
> + * (==, >=, and so on) and a value.
> + *
> + * Note that each entry has an array of filter repxressions and it only succeeds

                                                  expressions

> + * when all of the expressions are satisfied.  But it supports the logical OR
> + * using a GROUP operation which is satisfied when any of its member expression
> + * is evaluated to true.  But it doesn't allow nested GROUP operations for now.
> + *
> + * To support non-root users, the filters map can be loaded and pinned in the BPF
> + * filesystem by root (perf record --setup-filter pin).  Then each user will get
> + * a new entry in the shared filters map to fill the filter expressions.  And the
> + * BPF program will find the filter using (task-id, event-id) as a key.
> + *
> + * The pinned BPF object (shared for regular users) has:
> + *
> + *                  event_hash                   |
> + *                  |        |                   |
> + *   event->id ---> |   id   | ---+   idx_hash   |     filters
> + *                  |        |    |   |      |   |    |       |
> + *                  |  ....  |    +-> |  idx | --+--> | exprs | --->  perf_bpf_filter_entry[]
> + *                                |   |      |   |    |       |               .op
> + *   task id (tgid) --------------+   | .... |   |    |  ...  |               .term (+ part)
> + *                                               |                            .value
> + *                                               |
> + *   ======= (root would skip this part) ========                     (compares it in a loop)
> + *
> + * This is used for per-task use cases while system-wide profiling (normally from
> + * root user) uses a separate copy of the program and the maps for its own so that
> + * it can proceed even if a lot of non-root users are using the filters at the
> + * same time.  In this case the filters map has a single entry and no need to use
> + * the hash maps to get the index (key) of the filters map (IOW it's always 0).
> + *
> + * The BPF program returns 1 to accept the sample or 0 to drop it.
> + * The 'dropped' map is to keep how many samples it dropped by the filter and
> + * it will be reported as lost samples.

I think there is value in reporting how many were filtered out, I'm just
unsure about reporting it as "lost" samples, as lost has another
semantic associated, i.e. ring buffer was full or couldn't process it
for some other resource starvation issue, no?

> + */
>  #include <stdlib.h>
>  #include <fcntl.h>
>  #include <sys/ioctl.h>
> @@ -6,6 +47,7 @@
>  
>  #include <bpf/bpf.h>
>  #include <linux/err.h>
> +#include <linux/list.h>
>  #include <api/fs/fs.h>
>  #include <internal/xyarray.h>
>  #include <perf/threadmap.h>
> @@ -27,7 +69,14 @@
>  #define PERF_SAMPLE_TYPE(_st, opt)	__PERF_SAMPLE_TYPE(PBF_TERM_##_st, PERF_SAMPLE_##_st, opt)
>  
>  /* Index in the pinned 'filters' map.  Should be released after use. */
> -static int pinned_filter_idx = -1;
> +struct pinned_filter_idx {
> +	struct list_head list;
> +	struct evsel *evsel;
> +	u64 event_id;
> +	int hash_idx;
> +};
> +
> +static LIST_HEAD(pinned_filters);
>  
>  static const struct perf_sample_info {
>  	enum perf_bpf_filter_term type;
> @@ -175,24 +224,145 @@ static int convert_to_tgid(int tid)
>  	return tgid;
>  }
>  
> -static int update_pid_hash(struct evsel *evsel, struct perf_bpf_filter_entry *entry)
> +/*
> + * The event might be closed already so we cannot get the list of ids using FD
> + * like in create_event_hash() below, let's iterate the event_hash map and
> + * delete all entries that have the event id as a key.
> + */
> +static void destroy_event_hash(u64 event_id)
> +{
> +	int fd;
> +	u64 key, *prev_key = NULL;
> +	int num = 0, alloced = 32;
> +	u64 *ids = calloc(alloced, sizeof(*ids));
> +
> +	if (ids == NULL)
> +		return;
> +
> +	fd = get_pinned_fd("event_hash");
> +	if (fd < 0) {
> +		pr_debug("cannot get fd for 'event_hash' map\n");
> +		free(ids);
> +		return;
> +	}
> +
> +	/* Iterate the whole map to collect keys for the event id. */
> +	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
> +		u64 id;
> +
> +		if (bpf_map_lookup_elem(fd, &key, &id) == 0 && id == event_id) {
> +			if (num == alloced) {
> +				void *tmp;
> +
> +				alloced *= 2;
> +				tmp = realloc(ids, alloced * sizeof(*ids));
> +				if (tmp == NULL)
> +					break;
> +
> +				ids = tmp;
> +			}
> +			ids[num++] = key;
> +		}
> +
> +		prev_key = &key;
> +	}
> +
> +	for (int i = 0; i < num; i++)
> +		bpf_map_delete_elem(fd, &ids[i]);
> +
> +	free(ids);
> +	close(fd);
> +}
> +
> +/*
> + * Return a representative id if ok, or 0 for failures.
> + *
> + * The perf_event->id is good for this, but an evsel would have multiple
> + * instances for CPUs and tasks.  So pick up the first id and setup a hash
> + * from id of each instance to the representative id (the first one).
> + */
> +static u64 create_event_hash(struct evsel *evsel)
> +{
> +	int x, y, fd;
> +	u64 the_id = 0, id;
> +
> +	fd = get_pinned_fd("event_hash");
> +	if (fd < 0) {
> +		pr_err("cannot get fd for 'event_hash' map\n");
> +		return 0;
> +	}
> +
> +	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
> +		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
> +			int ret = ioctl(FD(evsel, x, y), PERF_EVENT_IOC_ID, &id);
> +
> +			if (ret < 0) {
> +				pr_err("Failed to get the event id\n");
> +				if (the_id)
> +					destroy_event_hash(the_id);
> +				return 0;
> +			}
> +
> +			if (the_id == 0)
> +				the_id = id;
> +
> +			bpf_map_update_elem(fd, &id, &the_id, BPF_ANY);
> +		}
> +	}
> +
> +	close(fd);
> +	return the_id;
> +}
> +
> +static void destroy_idx_hash(struct pinned_filter_idx *pfi)
> +{
> +	int fd, nr;
> +	struct perf_thread_map *threads;
> +
> +	fd = get_pinned_fd("filters");
> +	bpf_map_delete_elem(fd, &pfi->hash_idx);
> +	close(fd);
> +
> +	if (pfi->event_id)
> +		destroy_event_hash(pfi->event_id);
> +
> +	threads = perf_evsel__threads(&pfi->evsel->core);
> +	if (threads == NULL)
> +		return;
> +
> +	fd = get_pinned_fd("idx_hash");
> +	nr = perf_thread_map__nr(threads);
> +	for (int i = 0; i < nr; i++) {
> +		/* The target task might be dead already, just try the pid */
> +		struct idx_hash_key key = {
> +			.evt_id = pfi->event_id,
> +			.tgid = perf_thread_map__pid(threads, i),
> +		};
> +
> +		bpf_map_delete_elem(fd, &key);
> +	}
> +	close(fd);
> +}
> +
> +/* Maintain a hashmap from (tgid, event-id) to filter index */
> +static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter_entry *entry)
>  {
>  	int filter_idx;
>  	int fd, nr, last;
> +	u64 event_id = 0;
> +	struct pinned_filter_idx *pfi = NULL;
>  	struct perf_thread_map *threads;
>  
>  	fd = get_pinned_fd("filters");
>  	if (fd < 0) {
> -		pr_debug("cannot get fd for 'filters' map\n");
> +		pr_err("cannot get fd for 'filters' map\n");
>  		return fd;
>  	}
>  
>  	/* Find the first available entry in the filters map */
>  	for (filter_idx = 0; filter_idx < MAX_FILTERS; filter_idx++) {
> -		if (bpf_map_update_elem(fd, &filter_idx, entry, BPF_NOEXIST) == 0) {
> -			pinned_filter_idx = filter_idx;
> +		if (bpf_map_update_elem(fd, &filter_idx, entry, BPF_NOEXIST) == 0)
>  			break;
> -		}
>  	}
>  	close(fd);
>  
> @@ -201,22 +371,44 @@ static int update_pid_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
>  		return -EBUSY;
>  	}
>  
> +	pfi = zalloc(sizeof(*pfi));
> +	if (pfi == NULL) {
> +		pr_err("Cannot save pinned filter index\n");
> +		goto err;
> +	}
> +
> +	pfi->evsel = evsel;
> +	pfi->hash_idx = filter_idx;
> +
> +	event_id = create_event_hash(evsel);
> +	if (event_id == 0) {
> +		pr_err("Cannot update the event hash\n");
> +		goto err;
> +	}
> +
> +	pfi->event_id = event_id;
> +
>  	threads = perf_evsel__threads(&evsel->core);
>  	if (threads == NULL) {
>  		pr_err("Cannot get the thread list of the event\n");
> -		return -EINVAL;
> +		goto err;
>  	}
>  
>  	/* save the index to a hash map */
> -	fd = get_pinned_fd("pid_hash");
> -	if (fd < 0)
> -		return fd;
> +	fd = get_pinned_fd("idx_hash");
> +	if (fd < 0) {
> +		pr_err("cannot get fd for 'idx_hash' map\n");
> +		goto err;
> +	}
>  
>  	last = -1;
>  	nr = perf_thread_map__nr(threads);
>  	for (int i = 0; i < nr; i++) {
>  		int pid = perf_thread_map__pid(threads, i);
>  		int tgid;
> +		struct idx_hash_key key = {
> +			.evt_id = event_id,
> +		};
>  
>  		/* it actually needs tgid, let's get tgid from /proc. */
>  		tgid = convert_to_tgid(pid);
> @@ -228,16 +420,25 @@ static int update_pid_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
>  		if (tgid == last)
>  			continue;
>  		last = tgid;
> +		key.tgid = tgid;
>  
> -		if (bpf_map_update_elem(fd, &tgid, &filter_idx, BPF_ANY) < 0) {
> -			pr_err("Failed to update the pid hash\n");
> +		if (bpf_map_update_elem(fd, &key, &filter_idx, BPF_ANY) < 0) {
> +			pr_err("Failed to update the idx_hash\n");
>  			close(fd);
> -			return -1;
> +			goto err;
>  		}
> -		pr_debug("pid hash: %d -> %d\n", tgid, filter_idx);
> +		pr_debug("bpf-filter: idx_hash (task=%d,%s) -> %d\n",
> +			 tgid, evsel__name(evsel), filter_idx);
>  	}
> +
> +	list_add(&pfi->list, &pinned_filters);
>  	close(fd);
> -	return 0;
> +	return filter_idx;
> +
> +err:
> +	destroy_idx_hash(pfi);
> +	free(pfi);
> +	return -1;
>  }
>  
>  int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
> @@ -247,7 +448,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  	struct bpf_program *prog;
>  	struct bpf_link *link;
>  	struct perf_bpf_filter_entry *entry;
> -	bool needs_pid_hash = !target__has_cpu(target) && !target->uid_str;
> +	bool needs_idx_hash = !target__has_cpu(target) && !target->uid_str;
>  
>  	entry = calloc(MAX_FILTERS, sizeof(*entry));
>  	if (entry == NULL)
> @@ -259,11 +460,11 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  		goto err;
>  	}
>  
> -	if (needs_pid_hash && geteuid() != 0) {
> +	if (needs_idx_hash && geteuid() != 0) {
>  		int zero = 0;
>  
>  		/* The filters map is shared among other processes */
> -		ret = update_pid_hash(evsel, entry);
> +		ret = create_idx_hash(evsel, entry);
>  		if (ret < 0)
>  			goto err;
>  
> @@ -274,7 +475,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  		}
>  
>  		/* Reset the lost count */
> -		bpf_map_update_elem(fd, &pinned_filter_idx, &zero, BPF_ANY);
> +		bpf_map_update_elem(fd, &ret, &zero, BPF_ANY);
>  		close(fd);
>  
>  		fd = get_pinned_fd("perf_sample_filter");
> @@ -288,6 +489,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  				ret = ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd);
>  				if (ret < 0) {
>  					pr_err("Failed to attach perf sample-filter\n");
> +					close(fd);
>  					goto err;
>  				}
>  			}
> @@ -332,6 +534,15 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  
>  err:
>  	free(entry);
> +	if (!list_empty(&pinned_filters)) {
> +		struct pinned_filter_idx *pfi, *tmp;
> +
> +		list_for_each_entry_safe(pfi, tmp, &pinned_filters, list) {
> +			destroy_idx_hash(pfi);
> +			list_del(&pfi->list);

		         list_del_init()? But I see you're not using it
in other places,like in perf_bpf_filter__destroy().

> +			free(pfi);
> +		}
> +	}
>  	sample_filter_bpf__destroy(skel);
>  	return ret;
>  }
> @@ -339,6 +550,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  int perf_bpf_filter__destroy(struct evsel *evsel)
>  {
>  	struct perf_bpf_filter_expr *expr, *tmp;
> +	struct pinned_filter_idx *pfi, *pos;
>  
>  	list_for_each_entry_safe(expr, tmp, &evsel->bpf_filters, list) {
>  		list_del(&expr->list);
> @@ -346,14 +558,11 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
>  	}
>  	sample_filter_bpf__destroy(evsel->bpf_skel);
>  
> -	if (pinned_filter_idx >= 0) {
> -		int fd = get_pinned_fd("filters");
> -
> -		bpf_map_delete_elem(fd, &pinned_filter_idx);
> -		pinned_filter_idx = -1;
> -		close(fd);
> +	list_for_each_entry_safe(pfi, pos, &pinned_filters, list) {
> +		destroy_idx_hash(pfi);
> +		list_del(&pfi->list);
> +		free(pfi);
>  	}
> -
>  	return 0;
>  }
>  
> @@ -364,10 +573,20 @@ u64 perf_bpf_filter__lost_count(struct evsel *evsel)
>  	if (list_empty(&evsel->bpf_filters))
>  		return 0;
>  
> -	if (pinned_filter_idx >= 0) {
> +	if (!list_empty(&pinned_filters)) {
>  		int fd = get_pinned_fd("dropped");
> +		struct pinned_filter_idx *pfi;
> +
> +		if (fd < 0)
> +			return 0;
>  
> -		bpf_map_lookup_elem(fd, &pinned_filter_idx, &count);
> +		list_for_each_entry(pfi, &pinned_filters, list) {
> +			if (pfi->evsel != evsel)
> +				continue;
> +
> +			bpf_map_lookup_elem(fd, &pfi->hash_idx, &count);
> +			break;
> +		}
>  		close(fd);
>  	} else if (evsel->bpf_skel) {
>  		struct sample_filter_bpf *skel = evsel->bpf_skel;
> @@ -429,9 +648,10 @@ int perf_bpf_filter__pin(void)
>  
>  	/* pinned program will use pid-hash */
>  	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
> -	bpf_map__set_max_entries(skel->maps.pid_hash, MAX_PIDS);
> +	bpf_map__set_max_entries(skel->maps.event_hash, MAX_EVT_HASH);
> +	bpf_map__set_max_entries(skel->maps.idx_hash, MAX_IDX_HASH);
>  	bpf_map__set_max_entries(skel->maps.dropped, MAX_FILTERS);
> -	skel->rodata->use_pid_hash = 1;
> +	skel->rodata->use_idx_hash = 1;
>  
>  	if (sample_filter_bpf__load(skel) < 0) {
>  		ret = -errno;
> @@ -484,8 +704,12 @@ int perf_bpf_filter__pin(void)
>  		pr_debug("chmod for filters failed\n");
>  		ret = -errno;
>  	}
> -	if (fchmodat(dir_fd, "pid_hash", 0666, 0) < 0) {
> -		pr_debug("chmod for pid_hash failed\n");
> +	if (fchmodat(dir_fd, "event_hash", 0666, 0) < 0) {
> +		pr_debug("chmod for event_hash failed\n");
> +		ret = -errno;
> +	}
> +	if (fchmodat(dir_fd, "idx_hash", 0666, 0) < 0) {
> +		pr_debug("chmod for idx_hash failed\n");
>  		ret = -errno;
>  	}
>  	if (fchmodat(dir_fd, "dropped", 0666, 0) < 0) {
> diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
> index e666bfd5fbdd..5f0c8e4e83d3 100644
> --- a/tools/perf/util/bpf_skel/sample-filter.h
> +++ b/tools/perf/util/bpf_skel/sample-filter.h
> @@ -1,8 +1,9 @@
>  #ifndef PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
>  #define PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
>  
> -#define MAX_FILTERS  64
> -#define MAX_PIDS     (16 * 1024)
> +#define MAX_FILTERS   64
> +#define MAX_IDX_HASH  (16 * 1024)
> +#define MAX_EVT_HASH  (1024 * 1024)
>  
>  /* supported filter operations */
>  enum perf_bpf_filter_op {
> @@ -62,4 +63,10 @@ struct perf_bpf_filter_entry {
>  	__u64 value;
>  };
>  
> +struct idx_hash_key {
> +	__u64 evt_id;
> +	__u32 tgid;
> +	__u32 reserved;
> +};
> +
>  #endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> index 4c75354b84fd..4872a16eedfd 100644
> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> @@ -15,13 +15,25 @@ struct filters {
>  	__uint(max_entries, 1);
>  } filters SEC(".maps");
>  
> -/* tgid to filter index */
> -struct pid_hash {
> +/*
> + * An evsel has multiple instances for each CPU or task but we need a single
> + * id to be used as a key for the idx_hash.  This hashmap would translate the
> + * instance's ID to a representative ID.
> + */
> +struct event_hash {
>  	__uint(type, BPF_MAP_TYPE_HASH);
> -	__type(key, int);
> +	__type(key, __u64);
> +	__type(value, __u64);
> +	__uint(max_entries, 1);
> +} event_hash SEC(".maps");
> +
> +/* tgid/evtid to filter index */
> +struct idx_hash {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__type(key, struct idx_hash_key);
>  	__type(value, int);
>  	__uint(max_entries, 1);
> -} pid_hash SEC(".maps");
> +} idx_hash SEC(".maps");
>  
>  /* tgid to filter index */
>  struct lost_count {
> @@ -31,7 +43,7 @@ struct lost_count {
>  	__uint(max_entries, 1);
>  } dropped SEC(".maps");
>  
> -volatile const int use_pid_hash;
> +volatile const int use_idx_hash;
>  
>  void *bpf_cast_to_kern_ctx(void *) __ksym;
>  
> @@ -202,11 +214,25 @@ int perf_sample_filter(void *ctx)
>  
>  	k = 0;
>  
> -	if (use_pid_hash) {
> -		int tgid = bpf_get_current_pid_tgid() >> 32;
> +	if (use_idx_hash) {
> +		struct idx_hash_key key = {
> +			.tgid = bpf_get_current_pid_tgid() >> 32,
> +		};
> +		__u64 eid = kctx->event->id;
> +		__u64 *key_id;
>  		int *idx;
>  
> -		idx = bpf_map_lookup_elem(&pid_hash, &tgid);
> +		/* get primary_event_id */
> +		if (kctx->event->parent)
> +			eid = kctx->event->parent->id;
> +
> +		key_id = bpf_map_lookup_elem(&event_hash, &eid);
> +		if (key_id == NULL)
> +			goto drop;
> +
> +		key.evt_id = *key_id;
> +
> +		idx = bpf_map_lookup_elem(&idx_hash, &key);
>  		if (idx)
>  			k = *idx;
>  		else
> diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> index e9028235d771..05edc7d28151 100644
> --- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> +++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> @@ -174,6 +174,11 @@ struct perf_sample_data {
>  	u64			 code_page_size;
>  } __attribute__((__aligned__(64))) __attribute__((preserve_access_index));
>  
> +struct perf_event {
> +	struct perf_event	*parent;
> +	u64			id;
> +} __attribute__((preserve_access_index));
> +
>  struct bpf_perf_event_data_kern {
>  	struct perf_sample_data *data;
>  	struct perf_event	*event;
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog

