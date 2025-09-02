Return-Path: <bpf+bounces-67145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA77B3F630
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 09:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D1417F3B1
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 07:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED042E6CB4;
	Tue,  2 Sep 2025 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3/nfLGy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64DC2E6CA7;
	Tue,  2 Sep 2025 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796855; cv=none; b=C44MaI5gAC9pVRg9y1OZ97S4tIG5BzS26zhhKFsFOErbqw7lQtZAIWe5YGI7gbDVkNV3vJyVv2lljBonS5sWXbK4Lvq9zQZD8apVbL2QcD5gFp5IMzzDSRv9ql2IDwqk2AU8vkBtRuGHeexhxh4T1G3rBtbvEPossJ3ZYtY5AK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796855; c=relaxed/simple;
	bh=e4m5GnWOsSvGxzLro6D9WD/YKtm4Gq9eDzFA5ZiKpUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvHx/QQUJrSqJRbTzN4VZPTafqzBbN2hk7d3wYaCRaHvBCkvWXC1NxmujqHeAzP0wlndvEvJ4rGgYh61c7RFjBdT8K6iWMl8+aWguz5zTT4xbuUqVWZToU5+3X1IGu/CH1iMjTjXUg+GGeqA03+CEgFMYuKPOydQErWQeGjLewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3/nfLGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC01C4CEF5;
	Tue,  2 Sep 2025 07:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756796855;
	bh=e4m5GnWOsSvGxzLro6D9WD/YKtm4Gq9eDzFA5ZiKpUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3/nfLGy9I1q28ajS7qxxBkiRLQj51N1PIEWL7Zrf81dZl4XDXSzBCkUWCfbsYV3Z
	 GuElCuyuAIjkN1ucKSQzqurdgT+6xTGObbyI/FN9ELCJ/QEyOACnKI4yJQ4pVFY1za
	 MMzLD/YaLR0Og4yjX22jdav9mckl7aSXXg/jbpK6QTKKGRPGJMxYK4fpAEMlHErycp
	 /dnqiDj0DCiFnM5x6sfVQygTxQosKzaJjGUAsoeXS7gYnnY+LpsBiGo/T8MK/7dowV
	 hN985bBeKng6QBsjYv03kWefJPRu+RelwJ7a8ferOhXgf2N19kVHQI6W0xZq+FVzZr
	 Gd2J/OOP5zDtA==
Date: Tue, 2 Sep 2025 00:07:32 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v15 8/8] perf tools: Merge deferred user callchains
Message-ID: <aLaXtBFCkzbKFr0B@z2>
References: <20250825180638.877627656@kernel.org>
 <20250825180802.725570056@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825180802.725570056@kernel.org>

On Mon, Aug 25, 2025 at 02:06:46PM -0400, Steven Rostedt wrote:
> From: Namhyung Kim <namhyung@kernel.org>
> 
> Save samples with deferred callchains in a separate list and deliver
> them after merging the user callchains.  If users don't want to merge
> they can set tool->merge_deferred_callchains to false to prevent the
> behavior.
> 
> With previous result, now perf script will show the merged callchains.
> 
>   $ perf script
>   perf     801 [000]    18.031793:          1 cycles:P:
>           ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.kallsyms])
>           ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
>           ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
>           ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
>           ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
>           ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsyms])
>           ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
>           ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsyms])
>           ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
>           ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
>           ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
>           ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
>           ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
>               7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/libc.so.6)
>   ...
> 
> The old output can be get using --no-merge-callchain option.
> Also perf report can get the user callchain entry at the end.
> 
>   $ perf report --no-children --percent-limit=0 --stdio -q -S __intel_pmu_enable_all.isra.0
>   # symbol: __intel_pmu_enable_all.isra.0
>        0.00%  perf     [kernel.kallsyms]
>               |
>               ---__intel_pmu_enable_all.isra.0
>                  perf_ctx_enable
>                  event_function
>                  remote_function
>                  generic_exec_single
>                  smp_call_function_single
>                  event_function_call
>                  perf_event_for_each_child
>                  _perf_ioctl
>                  perf_ioctl
>                  __x64_sys_ioctl
>                  do_syscall_64
>                  entry_SYSCALL_64
>                  __GI___ioctl
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v14: https://lore.kernel.org/20250718164324.925232448@kernel.org
> 
> - Use both TID and cookie to match the request event to the deferred
>   unwind event.
> 
>  tools/perf/Documentation/perf-script.txt |  5 ++
>  tools/perf/builtin-script.c              |  5 +-
>  tools/perf/util/callchain.c              | 24 +++++++++
>  tools/perf/util/callchain.h              |  3 ++
>  tools/perf/util/evlist.c                 |  1 +
>  tools/perf/util/evlist.h                 |  1 +
>  tools/perf/util/session.c                | 64 +++++++++++++++++++++++-
>  tools/perf/util/tool.c                   |  1 +
>  tools/perf/util/tool.h                   |  1 +
>  9 files changed, 103 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 28bec7e78bc8..03d112960632 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -527,6 +527,11 @@ include::itrace.txt[]
>  	The known limitations include exception handing such as
>  	setjmp/longjmp will have calls/returns not match.
>  
> +--merge-callchains::
> +	Enable merging deferred user callchains if available.  This is the
> +	default behavior.  If you want to see separate CALLCHAIN_DEFERRED
> +	records for some reason, use --no-merge-callchains explicitly.
> +
>  :GMEXAMPLECMD: script
>  :GMEXAMPLESUBCMD:
>  include::guest-files.txt[]
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index d17e0a3d8567..70e7658a61fb 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3785,6 +3785,7 @@ int cmd_script(int argc, const char **argv)
>  	bool header_only = false;
>  	bool script_started = false;
>  	bool unsorted_dump = false;
> +	bool merge_deferred_callchains = true;
>  	char *rec_script_path = NULL;
>  	char *rep_script_path = NULL;
>  	struct perf_session *session;
> @@ -3938,6 +3939,8 @@ int cmd_script(int argc, const char **argv)
>  		    "Guest code can be found in hypervisor process"),
>  	OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
>  		    "Enable LBR callgraph stitching approach"),
> +	OPT_BOOLEAN('\0', "merge-callchains", &merge_deferred_callchains,
> +		    "Enable merge deferred user callchains"),
>  	OPTS_EVSWITCH(&script.evswitch),
>  	OPT_END()
>  	};
> @@ -4194,7 +4197,7 @@ int cmd_script(int argc, const char **argv)
>  	script.tool.throttle		 = process_throttle_event;
>  	script.tool.unthrottle		 = process_throttle_event;
>  	script.tool.ordering_requires_timestamps = true;
> -	script.tool.merge_deferred_callchains = false;
> +	script.tool.merge_deferred_callchains = merge_deferred_callchains;
>  	session = perf_session__new(&data, &script.tool);
>  	if (IS_ERR(session))
>  		return PTR_ERR(session);
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index d7b7eef740b9..d2d672f1d6ba 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1828,3 +1828,27 @@ int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
>  	}
>  	return 0;
>  }
> +
> +int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
> +				     struct perf_sample *sample_callchain)
> +{
> +	u64 nr_orig = sample_orig->callchain->nr - PERF_DEFERRED_ITEMS;
> +	u64 nr_deferred = sample_callchain->callchain->nr;
> +	struct ip_callchain *callchain;
> +
> +	callchain = calloc(1 + nr_orig + nr_deferred, sizeof(u64));
> +	if (callchain == NULL) {
> +		sample_orig->deferred_callchain = false;
> +		return -ENOMEM;
> +	}
> +
> +	callchain->nr = nr_orig + nr_deferred;
> +	/* copy except for the last PERF_CONTEXT_USER_DEFERRED */
> +	memcpy(callchain->ips, sample_orig->callchain->ips, nr_orig * sizeof(u64));
> +	/* copy deferred use callchains */
> +	memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips,
> +	       nr_deferred * sizeof(u64));
> +
> +	sample_orig->callchain = callchain;
> +	return 0;
> +}
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index 86ed9e4d04f9..89785125ed25 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -317,4 +317,7 @@ int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
>  				    struct perf_sample *sample, int max_stack,
>  				    bool symbols, callchain_iter_fn cb, void *data);
>  
> +int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
> +				     struct perf_sample *sample_callchain);
> +
>  #endif	/* __PERF_CALLCHAIN_H */
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 80d8387e6b97..9518b45af393 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -85,6 +85,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
>  	evlist->ctl_fd.pos = -1;
>  	evlist->nr_br_cntr = -1;
>  	metricgroup__rblist_init(&evlist->metric_events);
> +	INIT_LIST_HEAD(&evlist->deferred_samples);
>  }
>  
>  struct evlist *evlist__new(void)
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 5e71e3dc6042..309ef8d78495 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -92,6 +92,7 @@ struct evlist {
>  	 * of struct metric_expr.
>  	 */
>  	struct rblist	metric_events;
> +	struct list_head deferred_samples;
>  };
>  
>  struct evsel_str_handler {
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index a071006350f5..ef1902309395 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1283,6 +1283,57 @@ static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool
>  					    per_thread);
>  }
>  
> +struct deferred_event {
> +	struct list_head list;
> +	union perf_event *event;
> +};
> +
> +static int evlist__deliver_deferred_samples(struct evlist *evlist,
> +					    const struct perf_tool *tool,
> +					    union  perf_event *event,
> +					    struct perf_sample *sample,
> +					    struct machine *machine)
> +{
> +	struct deferred_event *de, *tmp;
> +	struct evsel *evsel;
> +	int ret = 0;
> +
> +	if (!tool->merge_deferred_callchains) {
> +		evsel = evlist__id2evsel(evlist, sample->id);
> +		return tool->callchain_deferred(tool, event, sample,
> +						evsel, machine);
> +	}
> +
> +	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
> +		struct perf_sample orig_sample;
> +
> +		ret = evlist__parse_sample(evlist, de->event, &orig_sample);
> +		if (ret < 0) {
> +			pr_err("failed to parse original sample\n");
> +			break;
> +		}
> +
> +		if (sample->tid != orig_sample.tid ||
> +		    event->callchain_deferred.cookie != orig_sample.deferred_cookie)
> +			continue;

I think we should handle original samples with different cookies too.  
They are before LOST records so we don't merge the callchain though.

> +
> +		evsel = evlist__id2evsel(evlist, orig_sample.id);
> +		sample__merge_deferred_callchain(&orig_sample, sample);
> +		ret = evlist__deliver_sample(evlist, tool, de->event,
> +					     &orig_sample, evsel, machine);

Something like this.

@@ -1313,12 +1313,13 @@ static int evlist__deliver_deferred_samples(struct evlist *evlist,
                        break;
                }

-               if (sample->tid != orig_sample.tid ||
-                   event->callchain_deferred.cookie != orig_sample.deferred_cookie)
+               if (sample->tid != orig_sample.tid)
                        continue;

+               if (event->callchain_deferred.cookie == orig_sample.deferred_cookie)
+                       sample__merge_deferred_callchain(&orig_sample, sample);
+
                evsel = evlist__id2evsel(evlist, orig_sample.id);
-               sample__merge_deferred_callchain(&orig_sample, sample);
                ret = evlist__deliver_sample(evlist, tool, de->event,
                                             &orig_sample, evsel, machine);


Thanks,
Namhyung

> +
> +		if (orig_sample.deferred_callchain)
> +			free(orig_sample.callchain);
> +
> +		list_del(&de->list);
> +		free(de);
> +
> +		if (ret)
> +			break;
> +	}
> +	return ret;
> +}
> +
>  static int machines__deliver_event(struct machines *machines,
>  				   struct evlist *evlist,
>  				   union perf_event *event,
> @@ -1311,6 +1362,16 @@ static int machines__deliver_event(struct machines *machines,
>  			return 0;
>  		}
>  		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
> +		if (sample->deferred_callchain && tool->merge_deferred_callchains) {
> +			struct deferred_event *de = malloc(sizeof(*de));
> +
> +			if (de == NULL)
> +				return -ENOMEM;
> +
> +			de->event = event;
> +			list_add_tail(&de->list, &evlist->deferred_samples);
> +			return 0;
> +		}
>  		return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
>  	case PERF_RECORD_MMAP:
>  		return tool->mmap(tool, event, sample, machine);
> @@ -1370,7 +1431,8 @@ static int machines__deliver_event(struct machines *machines,
>  		return tool->aux_output_hw_id(tool, event, sample, machine);
>  	case PERF_RECORD_CALLCHAIN_DEFERRED:
>  		dump_deferred_callchain(evsel, event, sample);
> -		return tool->callchain_deferred(tool, event, sample, evsel, machine);
> +		return evlist__deliver_deferred_samples(evlist, tool, event,
> +							sample, machine);
>  	default:
>  		++evlist->stats.nr_unknown_events;
>  		return -1;
> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> index 8bf86af1ca90..9ab9e231b5d5 100644
> --- a/tools/perf/util/tool.c
> +++ b/tools/perf/util/tool.c
> @@ -258,6 +258,7 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
>  	tool->cgroup_events = false;
>  	tool->no_warn = false;
>  	tool->show_feat_hdr = SHOW_FEAT_NO_HEADER;
> +	tool->merge_deferred_callchains = true;
>  
>  	tool->sample = process_event_sample_stub;
>  	tool->mmap = process_event_stub;
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index 2676d84da80c..7165a487a485 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -88,6 +88,7 @@ struct perf_tool {
>  	bool		cgroup_events;
>  	bool		no_warn;
>  	bool		dont_split_sample_group;
> +	bool		merge_deferred_callchains;
>  	enum show_feature_header show_feat_hdr;
>  };
>  
> -- 
> 2.50.1
> 
> 

