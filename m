Return-Path: <bpf+bounces-61567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD29AE8E5F
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 21:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF99D169421
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750FC2DAFC1;
	Wed, 25 Jun 2025 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEcGmrEI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822E1DE3A4;
	Wed, 25 Jun 2025 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879074; cv=none; b=t1W2hq3qNeOMBDxJowTYeBv7aIlEF4uVQiDD69rQiSHUsLv5UEncqfraZt8vTyAmpO45oKNJKLBezxqOEkII+GHaM+KbTSGprP3HneVnjN/aocPsOlUBOwYN3c+BAv+Bp+bFhCq1C+pv67DymB8K3mH3kak8BMYITXISbnnClsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879074; c=relaxed/simple;
	bh=ObS53t5ibbJ70VRvdlHBqAuCY+N+9Uhjg1MN6x/9rLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbkVFe5YVdcOolooqgLNez7q4CbT4n4EJIdLJxn23JnCzFjWPx9Z7DjyTn6s4O496NxFXC6wZQ4sXd9gUrarpz3iyCqmu08aAIy4KfkX3HN51YpkmZhv29FypIBjUEPjVwdd4bFctaHdDKCm2ZN4AGjOY08Et0Mfj0Mo3EAc6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEcGmrEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2455EC4CEEA;
	Wed, 25 Jun 2025 19:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750879073;
	bh=ObS53t5ibbJ70VRvdlHBqAuCY+N+9Uhjg1MN6x/9rLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEcGmrEIusRhIcchiSq3qKmWZyA/UeSxICFhselvTbVCTgvM4berIzQCxRAwBS9eH
	 QziPxu2NxKePi4F7XcuvivPw+Xi58ISbGLRyMherR/eGX5+xGap7NTg8oQtzTguVyu
	 PhbS4VeZWny86NNgZWuMN4ZKovjDgaPuTyGWRUUvSIHdNV6A9cfd1U4SY+sY9veNQa
	 ExAjCp4KBnPvb2ncTMG91Vs9OErsnAs0TDK9Yfoz/b3AGO03MmRtZ3SsZ1ZXPDiFMG
	 KxyGlVf/sbiJxiB+z1K26ZN3lINm0yPTK0nZNqEOGlSW8oOM/7rhNYIKyecJywFIdh
	 tEF6mYhn3V21g==
Date: Wed, 25 Jun 2025 16:17:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2] perf trace: Split BPF skel code to
 util/bpf_trace_augment.c
Message-ID: <aFxLXpOaIuEe3zEZ@x1>
References: <20250623225721.21553-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623225721.21553-1-namhyung@kernel.org>

On Mon, Jun 23, 2025 at 03:57:21PM -0700, Namhyung Kim wrote:
> And make builtin-trace.c less conditional.  Dummy functions will be
> called when BUILD_BPF_SKEL=0 is used.  This makes the builtin-trace.c
> slightly smaller and simpler by removing the skeleton and its helpers.
> 
> The conditional guard of trace__init_syscalls_bpf_prog_array_maps() is
> changed from the HAVE_BPF_SKEL to HAVE_LIBBPF_SUPPORT as it doesn't
> have a skeleton in the code directly.  And a dummy function is added so
> that it can be called unconditionally.  The function will succeed only
> if the both conditions are true.
> 
> Do not include trace_augment.h from the BPF code and move the definition
> of TRACE_AUG_MAX_BUF to the BPF directly.

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2)
>  * rename to bpf_trace_augment.c
>  * rebase to the current perf-tools-next
>  * add Howard's Reviewed-by
> 
>  tools/perf/builtin-trace.c                    | 187 +++++-------------
>  tools/perf/util/Build                         |   1 +
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     |   3 +-
>  tools/perf/util/bpf_trace_augment.c           | 143 ++++++++++++++
>  tools/perf/util/trace_augment.h               |  62 +++++-
>  5 files changed, 255 insertions(+), 141 deletions(-)
>  create mode 100644 tools/perf/util/bpf_trace_augment.c
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index bf9b5d0630d3ddac..56c0dd5acf73073e 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -20,9 +20,6 @@
>  #include <bpf/bpf.h>
>  #include <bpf/libbpf.h>
>  #include <bpf/btf.h>
> -#ifdef HAVE_BPF_SKEL
> -#include "bpf_skel/augmented_raw_syscalls.skel.h"
> -#endif
>  #endif
>  #include "util/bpf_map.h"
>  #include "util/rlimit.h"
> @@ -155,9 +152,6 @@ struct trace {
>  				*bpf_output;
>  		}		events;
>  	} syscalls;
> -#ifdef HAVE_BPF_SKEL
> -	struct augmented_raw_syscalls_bpf *skel;
> -#endif
>  #ifdef HAVE_LIBBPF_SUPPORT
>  	struct btf		*btf;
>  #endif
> @@ -3701,7 +3695,10 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
>  	goto out;
>  }
>  
> -#ifdef HAVE_BPF_SKEL
> +#ifdef HAVE_LIBBPF_SUPPORT
> +
> +static struct bpf_program *unaugmented_prog;
> +
>  static int syscall_arg_fmt__cache_btf_struct(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
>  {
>         int id;
> @@ -3719,26 +3716,8 @@ static int syscall_arg_fmt__cache_btf_struct(struct syscall_arg_fmt *arg_fmt, st
>         return 0;
>  }
>  
> -static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace, const char *name)
> -{
> -	struct bpf_program *pos, *prog = NULL;
> -	const char *sec_name;
> -
> -	if (trace->skel->obj == NULL)
> -		return NULL;
> -
> -	bpf_object__for_each_program(pos, trace->skel->obj) {
> -		sec_name = bpf_program__section_name(pos);
> -		if (sec_name && !strcmp(sec_name, name)) {
> -			prog = pos;
> -			break;
> -		}
> -	}
> -
> -	return prog;
> -}
> -
> -static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace, struct syscall *sc,
> +static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace __maybe_unused,
> +							struct syscall *sc,
>  							const char *prog_name, const char *type)
>  {
>  	struct bpf_program *prog;
> @@ -3746,19 +3725,19 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace, str
>  	if (prog_name == NULL) {
>  		char default_prog_name[256];
>  		scnprintf(default_prog_name, sizeof(default_prog_name), "tp/syscalls/sys_%s_%s", type, sc->name);
> -		prog = trace__find_bpf_program_by_title(trace, default_prog_name);
> +		prog = augmented_syscalls__find_by_title(default_prog_name);
>  		if (prog != NULL)
>  			goto out_found;
>  		if (sc->fmt && sc->fmt->alias) {
>  			scnprintf(default_prog_name, sizeof(default_prog_name), "tp/syscalls/sys_%s_%s", type, sc->fmt->alias);
> -			prog = trace__find_bpf_program_by_title(trace, default_prog_name);
> +			prog = augmented_syscalls__find_by_title(default_prog_name);
>  			if (prog != NULL)
>  				goto out_found;
>  		}
>  		goto out_unaugmented;
>  	}
>  
> -	prog = trace__find_bpf_program_by_title(trace, prog_name);
> +	prog = augmented_syscalls__find_by_title(prog_name);
>  
>  	if (prog != NULL) {
>  out_found:
> @@ -3768,7 +3747,7 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace, str
>  	pr_debug("Couldn't find BPF prog \"%s\" to associate with syscalls:sys_%s_%s, not augmenting it\n",
>  		 prog_name, type, sc->name);
>  out_unaugmented:
> -	return trace->skel->progs.syscall_unaugmented;
> +	return unaugmented_prog;
>  }
>  
>  static void trace__init_syscall_bpf_progs(struct trace *trace, int e_machine, int id)
> @@ -3785,13 +3764,13 @@ static void trace__init_syscall_bpf_progs(struct trace *trace, int e_machine, in
>  static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int e_machine, int id)
>  {
>  	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
> -	return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_program__fd(trace->skel->progs.syscall_unaugmented);
> +	return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_program__fd(unaugmented_prog);
>  }
>  
>  static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int e_machine, int id)
>  {
>  	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
> -	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(trace->skel->progs.syscall_unaugmented);
> +	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(unaugmented_prog);
>  }
>  
>  static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, int key, unsigned int *beauty_array)
> @@ -3901,7 +3880,7 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
>  		bool is_candidate = false;
>  
>  		if (pair == NULL || pair->id == sc->id ||
> -		    pair->bpf_prog.sys_enter == trace->skel->progs.syscall_unaugmented)
> +		    pair->bpf_prog.sys_enter == unaugmented_prog)
>  			continue;
>  
>  		for (field = sc->args, candidate_field = pair->args;
> @@ -3967,7 +3946,7 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
>  		 */
>  		if (pair_prog == NULL) {
>  			pair_prog = trace__find_syscall_bpf_prog(trace, pair, pair->fmt ? pair->fmt->bpf_prog_name.sys_enter : NULL, "enter");
> -			if (pair_prog == trace->skel->progs.syscall_unaugmented)
> +			if (pair_prog == unaugmented_prog)
>  				goto next_candidate;
>  		}
>  
> @@ -3983,12 +3962,17 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
>  
>  static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_machine)
>  {
> -	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
> -	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
> -	int beauty_map_fd = bpf_map__fd(trace->skel->maps.beauty_map_enter);
> +	int map_enter_fd;
> +	int map_exit_fd;
> +	int beauty_map_fd;
>  	int err = 0;
>  	unsigned int beauty_array[6];
>  
> +	if (augmented_syscalls__get_map_fds(&map_enter_fd, &map_exit_fd, &beauty_map_fd) < 0)
> +		return -1;
> +
> +	unaugmented_prog = augmented_syscalls__unaugmented();
> +
>  	for (int i = 0, num_idx = syscalltbl__num_idx(e_machine); i < num_idx; ++i) {
>  		int prog_fd, key = syscalltbl__id_at_idx(e_machine, i);
>  
> @@ -4058,7 +4042,7 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_m
>  		 * For now we're just reusing the sys_enter prog, and if it
>  		 * already has an augmenter, we don't need to find one.
>  		 */
> -		if (sc->bpf_prog.sys_enter != trace->skel->progs.syscall_unaugmented)
> +		if (sc->bpf_prog.sys_enter != unaugmented_prog)
>  			continue;
>  
>  		/*
> @@ -4083,7 +4067,13 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_m
>  
>  	return err;
>  }
> -#endif // HAVE_BPF_SKEL
> +#else // !HAVE_LIBBPF_SUPPORT
> +static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace __maybe_unused,
> +						    int e_machine __maybe_unused)
> +{
> +	return -1;
> +}
> +#endif // HAVE_LIBBPF_SUPPORT
>  
>  static int trace__set_ev_qualifier_filter(struct trace *trace)
>  {
> @@ -4092,24 +4082,6 @@ static int trace__set_ev_qualifier_filter(struct trace *trace)
>  	return 0;
>  }
>  
> -static int bpf_map__set_filter_pids(struct bpf_map *map __maybe_unused,
> -				    size_t npids __maybe_unused, pid_t *pids __maybe_unused)
> -{
> -	int err = 0;
> -#ifdef HAVE_LIBBPF_SUPPORT
> -	bool value = true;
> -	int map_fd = bpf_map__fd(map);
> -	size_t i;
> -
> -	for (i = 0; i < npids; ++i) {
> -		err = bpf_map_update_elem(map_fd, &pids[i], &value, BPF_ANY);
> -		if (err)
> -			break;
> -	}
> -#endif
> -	return err;
> -}
> -
>  static int trace__set_filter_loop_pids(struct trace *trace)
>  {
>  	unsigned int nr = 1, err;
> @@ -4138,8 +4110,8 @@ static int trace__set_filter_loop_pids(struct trace *trace)
>  	thread__put(thread);
>  
>  	err = evlist__append_tp_filter_pids(trace->evlist, nr, pids);
> -	if (!err && trace->filter_pids.map)
> -		err = bpf_map__set_filter_pids(trace->filter_pids.map, nr, pids);
> +	if (!err)
> +		err = augmented_syscalls__set_filter_pids(nr, pids);
>  
>  	return err;
>  }
> @@ -4156,8 +4128,8 @@ static int trace__set_filter_pids(struct trace *trace)
>  	if (trace->filter_pids.nr > 0) {
>  		err = evlist__append_tp_filter_pids(trace->evlist, trace->filter_pids.nr,
>  						    trace->filter_pids.entries);
> -		if (!err && trace->filter_pids.map) {
> -			err = bpf_map__set_filter_pids(trace->filter_pids.map, trace->filter_pids.nr,
> +		if (!err) {
> +			err = augmented_syscalls__set_filter_pids(trace->filter_pids.nr,
>  						       trace->filter_pids.entries);
>  		}
>  	} else if (perf_thread_map__pid(trace->evlist->core.threads, 0) == -1) {
> @@ -4480,41 +4452,18 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	err = evlist__open(evlist);
>  	if (err < 0)
>  		goto out_error_open;
> -#ifdef HAVE_BPF_SKEL
> -	if (trace->syscalls.events.bpf_output) {
> -		struct perf_cpu cpu;
>  
> -		/*
> -		 * Set up the __augmented_syscalls__ BPF map to hold for each
> -		 * CPU the bpf-output event's file descriptor.
> -		 */
> -		perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events.bpf_output->core.cpus) {
> -			int mycpu = cpu.cpu;
> -
> -			bpf_map__update_elem(trace->skel->maps.__augmented_syscalls__,
> -					&mycpu, sizeof(mycpu),
> -					xyarray__entry(trace->syscalls.events.bpf_output->core.fd,
> -						       mycpu, 0),
> -					sizeof(__u32), BPF_ANY);
> -		}
> -	}
> +	augmented_syscalls__setup_bpf_output();
>  
> -	if (trace->skel)
> -		trace->filter_pids.map = trace->skel->maps.pids_filtered;
> -#endif
>  	err = trace__set_filter_pids(trace);
>  	if (err < 0)
>  		goto out_error_mem;
>  
> -#ifdef HAVE_BPF_SKEL
> -	if (trace->skel && trace->skel->progs.sys_enter) {
> -		/*
> -		 * TODO: Initialize for all host binary machine types, not just
> -		 * those matching the perf binary.
> -		 */
> -		trace__init_syscalls_bpf_prog_array_maps(trace, EM_HOST);
> -	}
> -#endif
> +	/*
> +	 * TODO: Initialize for all host binary machine types, not just
> +	 * those matching the perf binary.
> +	 */
> +	trace__init_syscalls_bpf_prog_array_maps(trace, EM_HOST);
>  
>  	if (trace->ev_qualifier_ids.nr > 0) {
>  		err = trace__set_ev_qualifier_filter(trace);
> @@ -5375,18 +5324,6 @@ static void trace__exit(struct trace *trace)
>  #endif
>  }
>  
> -#ifdef HAVE_BPF_SKEL
> -static int bpf__setup_bpf_output(struct evlist *evlist)
> -{
> -	int err = parse_event(evlist, "bpf-output/no-inherit=1,name=__augmented_syscalls__/");
> -
> -	if (err)
> -		pr_debug("ERROR: failed to create the \"__augmented_syscalls__\" bpf-output event\n");
> -
> -	return err;
> -}
> -#endif
> -
>  int cmd_trace(int argc, const char **argv)
>  {
>  	const char *trace_usage[] = {
> @@ -5580,7 +5517,6 @@ int cmd_trace(int argc, const char **argv)
>  				       "cgroup monitoring only available in system-wide mode");
>  	}
>  
> -#ifdef HAVE_BPF_SKEL
>  	if (!trace.trace_syscalls)
>  		goto skip_augmentation;
>  
> @@ -5599,42 +5535,17 @@ int cmd_trace(int argc, const char **argv)
>  			goto skip_augmentation;
>  	}
>  
> -	trace.skel = augmented_raw_syscalls_bpf__open();
> -	if (!trace.skel) {
> -		pr_debug("Failed to open augmented syscalls BPF skeleton");
> -	} else {
> -		/*
> -		 * Disable attaching the BPF programs except for sys_enter and
> -		 * sys_exit that tail call into this as necessary.
> -		 */
> -		struct bpf_program *prog;
> +	err = augmented_syscalls__prepare();
> +	if (err < 0)
> +		goto skip_augmentation;
>  
> -		bpf_object__for_each_program(prog, trace.skel->obj) {
> -			if (prog != trace.skel->progs.sys_enter && prog != trace.skel->progs.sys_exit)
> -				bpf_program__set_autoattach(prog, /*autoattach=*/false);
> -		}
> +	trace__add_syscall_newtp(&trace);
>  
> -		err = augmented_raw_syscalls_bpf__load(trace.skel);
> +	err = augmented_syscalls__create_bpf_output(trace.evlist);
> +	if (err == 0)
> +		trace.syscalls.events.bpf_output = evlist__last(trace.evlist);
>  
> -		if (err < 0) {
> -			libbpf_strerror(err, bf, sizeof(bf));
> -			pr_debug("Failed to load augmented syscalls BPF skeleton: %s\n", bf);
> -		} else {
> -			augmented_raw_syscalls_bpf__attach(trace.skel);
> -			trace__add_syscall_newtp(&trace);
> -		}
> -	}
> -
> -	err = bpf__setup_bpf_output(trace.evlist);
> -	if (err) {
> -		libbpf_strerror(err, bf, sizeof(bf));
> -		pr_err("ERROR: Setup BPF output event failed: %s\n", bf);
> -		goto out;
> -	}
> -	trace.syscalls.events.bpf_output = evlist__last(trace.evlist);
> -	assert(evsel__name_is(trace.syscalls.events.bpf_output, "__augmented_syscalls__"));
>  skip_augmentation:
> -#endif
>  	err = -1;
>  
>  	if (trace.trace_pgfaults) {
> @@ -5831,8 +5742,6 @@ int cmd_trace(int argc, const char **argv)
>  		fclose(trace.output);
>  out:
>  	trace__exit(&trace);
> -#ifdef HAVE_BPF_SKEL
> -	augmented_raw_syscalls_bpf__destroy(trace.skel);
> -#endif
> +	augmented_syscalls__cleanup();
>  	return err;
>  }
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 7910d908c814feec..17c7b71128d15970 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -175,6 +175,7 @@ perf-util-$(CONFIG_PERF_BPF_SKEL) += btf.o
>  
>  ifeq ($(CONFIG_TRACE),y)
>    perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-trace-summary.o
> +  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_trace_augment.o
>  endif
>  
>  ifeq ($(CONFIG_LIBTRACEEVENT),y)
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index e4352881e3faa602..cb86e261b4de0685 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -7,7 +7,6 @@
>   */
>  
>  #include "vmlinux.h"
> -#include "../trace_augment.h"
>  
>  #include <bpf/bpf_helpers.h>
>  #include <linux/limits.h>
> @@ -27,6 +26,8 @@
>  
>  #define MAX_CPUS  4096
>  
> +#define TRACE_AUG_MAX_BUF 32 /* for buffer augmentation in perf trace */
> +
>  /* bpf-output associated map */
>  struct __augmented_syscalls__ {
>  	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
> new file mode 100644
> index 0000000000000000..56ed17534caa4f3f
> --- /dev/null
> +++ b/tools/perf/util/bpf_trace_augment.c
> @@ -0,0 +1,143 @@
> +#include <bpf/libbpf.h>
> +#include <internal/xyarray.h>
> +
> +#include "util/debug.h"
> +#include "util/evlist.h"
> +#include "util/trace_augment.h"
> +
> +#include "bpf_skel/augmented_raw_syscalls.skel.h"
> +
> +static struct augmented_raw_syscalls_bpf *skel;
> +static struct evsel *bpf_output;
> +
> +int augmented_syscalls__prepare(void)
> +{
> +	struct bpf_program *prog;
> +	char buf[128];
> +	int err;
> +
> +	skel = augmented_raw_syscalls_bpf__open();
> +	if (!skel) {
> +		pr_debug("Failed to open augmented syscalls BPF skeleton\n");
> +		return -errno;
> +	}
> +
> +	/*
> +	 * Disable attaching the BPF programs except for sys_enter and
> +	 * sys_exit that tail call into this as necessary.
> +	 */
> +	bpf_object__for_each_program(prog, skel->obj) {
> +		if (prog != skel->progs.sys_enter && prog != skel->progs.sys_exit)
> +			bpf_program__set_autoattach(prog, /*autoattach=*/false);
> +	}
> +
> +	err = augmented_raw_syscalls_bpf__load(skel);
> +	if (err < 0) {
> +		libbpf_strerror(err, buf, sizeof(buf));
> +		pr_debug("Failed to load augmented syscalls BPF skeleton: %s\n", buf);
> +		return err;
> +	}
> +
> +	augmented_raw_syscalls_bpf__attach(skel);
> +	return 0;
> +}
> +
> +int augmented_syscalls__create_bpf_output(struct evlist *evlist)
> +{
> +	int err = parse_event(evlist, "bpf-output/no-inherit=1,name=__augmented_syscalls__/");
> +
> +	if (err) {
> +		pr_err("ERROR: Setup BPF output event failed: %d\n", err);
> +		return err;
> +	}
> +
> +	bpf_output = evlist__last(evlist);
> +	assert(evsel__name_is(bpf_output, "__augmented_syscalls__"));
> +
> +	return 0;
> +}
> +
> +void augmented_syscalls__setup_bpf_output(void)
> +{
> +	struct perf_cpu cpu;
> +	int i;
> +
> +	if (bpf_output == NULL)
> +		return;
> +
> +	/*
> +	 * Set up the __augmented_syscalls__ BPF map to hold for each
> +	 * CPU the bpf-output event's file descriptor.
> +	 */
> +	perf_cpu_map__for_each_cpu(cpu, i, bpf_output->core.cpus) {
> +		int mycpu = cpu.cpu;
> +
> +		bpf_map__update_elem(skel->maps.__augmented_syscalls__,
> +				     &mycpu, sizeof(mycpu),
> +				     xyarray__entry(bpf_output->core.fd,
> +						    mycpu, 0),
> +				     sizeof(__u32), BPF_ANY);
> +	}
> +}
> +
> +int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids)
> +{
> +	bool value = true;
> +	int err = 0;
> +
> +	if (skel == NULL)
> +		return 0;
> +
> +	for (size_t i = 0; i < nr; ++i) {
> +		err = bpf_map__update_elem(skel->maps.pids_filtered, &pids[i],
> +					   sizeof(*pids), &value, sizeof(value),
> +					   BPF_ANY);
> +		if (err)
> +			break;
> +	}
> +	return err;
> +}
> +
> +int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *beauty_fd)
> +{
> +	if (skel == NULL)
> +		return -1;
> +
> +	*enter_fd = bpf_map__fd(skel->maps.syscalls_sys_enter);
> +	*exit_fd  = bpf_map__fd(skel->maps.syscalls_sys_exit);
> +	*beauty_fd = bpf_map__fd(skel->maps.beauty_map_enter);
> +
> +	if (*enter_fd < 0 || *exit_fd < 0 || *beauty_fd < 0) {
> +		pr_err("Error: failed to get syscall or beauty map fd\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +struct bpf_program *augmented_syscalls__unaugmented(void)
> +{
> +	return skel->progs.syscall_unaugmented;
> +}
> +
> +struct bpf_program *augmented_syscalls__find_by_title(const char *name)
> +{
> +	struct bpf_program *pos;
> +	const char *sec_name;
> +
> +	if (skel->obj == NULL)
> +		return NULL;
> +
> +	bpf_object__for_each_program(pos, skel->obj) {
> +		sec_name = bpf_program__section_name(pos);
> +		if (sec_name && !strcmp(sec_name, name))
> +			return pos;
> +	}
> +
> +	return NULL;
> +}
> +
> +void augmented_syscalls__cleanup(void)
> +{
> +	augmented_raw_syscalls_bpf__destroy(skel);
> +}
> diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augment.h
> index 57a3e50459377983..4f729bc6775304b4 100644
> --- a/tools/perf/util/trace_augment.h
> +++ b/tools/perf/util/trace_augment.h
> @@ -1,6 +1,66 @@
>  #ifndef TRACE_AUGMENT_H
>  #define TRACE_AUGMENT_H
>  
> -#define TRACE_AUG_MAX_BUF 32 /* for buffer augmentation in perf trace */
> +#include <linux/compiler.h>
> +
> +struct bpf_program;
> +struct evlist;
> +
> +#ifdef HAVE_BPF_SKEL
> +
> +int augmented_syscalls__prepare(void);
> +int augmented_syscalls__create_bpf_output(struct evlist *evlist);
> +void augmented_syscalls__setup_bpf_output(void);
> +int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids);
> +int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *beauty_fd);
> +struct bpf_program *augmented_syscalls__find_by_title(const char *name);
> +struct bpf_program *augmented_syscalls__unaugmented(void);
> +void augmented_syscalls__cleanup(void);
> +
> +#else /* !HAVE_BPF_SKEL */
> +
> +static inline int augmented_syscalls__prepare(void)
> +{
> +	return -1;
> +}
> +
> +static inline int augmented_syscalls__create_bpf_output(struct evlist *evlist __maybe_unused)
> +{
> +	return -1;
> +}
> +
> +static inline void augmented_syscalls__setup_bpf_output(void)
> +{
> +}
> +
> +static inline int augmented_syscalls__set_filter_pids(unsigned int nr __maybe_unused,
> +						      pid_t *pids __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +static inline int augmented_syscalls__get_map_fds(int *enter_fd __maybe_unused,
> +						  int *exit_fd __maybe_unused,
> +						  int *beauty_fd __maybe_unused)
> +{
> +	return -1;
> +}
> +
> +static inline struct bpf_program *
> +augmented_syscalls__find_by_title(const char *name __maybe_unused)
> +{
> +	return NULL;
> +}
> +
> +static inline struct bpf_program *augmented_syscalls__unaugmented(void)
> +{
> +	return NULL;
> +}
> +
> +static inline void augmented_syscalls__cleanup(void)
> +{
> +}
> +
> +#endif /* HAVE_BPF_SKEL */
>  
>  #endif
> -- 
> 2.49.0

