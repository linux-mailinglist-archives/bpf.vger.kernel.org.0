Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECD468730A
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 02:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjBBBbr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 20:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjBBBbo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 20:31:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37207750D;
        Wed,  1 Feb 2023 17:31:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AE96B82396;
        Thu,  2 Feb 2023 01:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01987C433D2;
        Thu,  2 Feb 2023 01:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675301491;
        bh=zygyBgHWKn+upRKRpydr8dS6gj6pxDw1R6YLUE0lRZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kLHEjeBF07JKgGMFdUWmW5ZQwnIekn+AsMFVhWPVe2zh0worfI4dPHrDPAhBU1Gk5
         y8HG/AKbn9VvfffNJfAJXRBX14dpSH2hGs4lSCrKNxhr0S0HpyQKuZt3QGzLVROXCA
         vlMhjVi8Lgn+skLJChu9s6rZhc0AoVu+ZyiVG9HlKHJmj0z9f5tw4Bmzs4/M30Kryn
         O4LypVOjXmaQsiiM4dd6ICRfXpq27OtIB+V9PxJIGx0L4YCqL0nTZND/9/SzEH5mzq
         XVmw5dCgtiyUEmX6dEVF1Ay47gwCIVfRpOcQ63TBuCImsCxb+zGdR8dfpVl+RFgpOF
         DfA2Eh45bGftg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3AD50405BE; Wed,  1 Feb 2023 22:31:28 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:31:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCH] perf lock contention: Add -S/--callstack-filter option
Message-ID: <Y9sScDj8eui+zowi@kernel.org>
References: <20230126000936.3017683-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126000936.3017683-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jan 25, 2023 at 04:09:36PM -0800, Namhyung Kim escreveu:
> The -S/--callstack-filter is to limit display entries having the given
> string in the callstack (not only in the caller in the output).
> 
> The following example shows lock contention results if the callstack
> has 'net' substring somewhere.  Note that the caller '__dev_queue_xmit'
> does not match to it, but it has 'inet6_csk_xmit' in the callstack.

Looks useful!


Thanks, applied.

- Arnaldo

 
> This applies even if you don't use -v option to show the full callstack.
> 
>   $ sudo ./perf lock con -abv -S net sleep 1
>   ...
>    contended   total wait     max wait     avg wait         type   caller
> 
>            5     70.20 us     16.13 us     14.04 us     spinlock   __dev_queue_xmit+0xb6d
>                           0xffffffffa5dd1c60  _raw_spin_lock+0x30
>                           0xffffffffa5b8f6ed  __dev_queue_xmit+0xb6d
>                           0xffffffffa5cd8267  ip6_finish_output2+0x2c7
>                           0xffffffffa5cdac14  ip6_finish_output+0x1d4
>                           0xffffffffa5cdb477  ip6_xmit+0x457
>                           0xffffffffa5d1fd17  inet6_csk_xmit+0xd7
>                           0xffffffffa5c5f4aa  __tcp_transmit_skb+0x54a
>                           0xffffffffa5c6467d  tcp_keepalive_timer+0x2fd
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-lock.txt |  6 +++
>  tools/perf/builtin-lock.c              | 68 +++++++++++++++++++++++++-
>  tools/perf/util/bpf_lock_contention.c  |  2 +-
>  tools/perf/util/lock-contention.h      |  1 +
>  4 files changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index 0f9f720e599d..11b8901d8d13 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -187,6 +187,12 @@ CONTENTION OPTIONS
>  --lock-filter=<value>::
>  	Show lock contention only for given lock addresses or names (comma separated list).
>  
> +-S::
> +--callstack-filter=<value>::
> +	Show lock contention only if the callstack contains the given string.
> +	Note that it matches the substring so 'rq' would match both 'raw_spin_rq_lock'
> +	and 'irq_enter_rcu'.
> +
>  
>  SEE ALSO
>  --------
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 506c2fe42d52..216a9a252bf4 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -63,11 +63,22 @@ static unsigned long bpf_map_entries = 10240;
>  static int max_stack_depth = CONTENTION_STACK_DEPTH;
>  static int stack_skip = CONTENTION_STACK_SKIP;
>  static int print_nr_entries = INT_MAX / 2;
> +static LIST_HEAD(callstack_filters);
> +
> +struct callstack_filter {
> +	struct list_head list;
> +	char name[];
> +};
>  
>  static struct lock_filter filters;
>  
>  static enum lock_aggr_mode aggr_mode = LOCK_AGGR_ADDR;
>  
> +static bool needs_callstack(void)
> +{
> +	return verbose > 0 || !list_empty(&callstack_filters);
> +}
> +
>  static struct thread_stat *thread_stat_find(u32 tid)
>  {
>  	struct rb_node *node;
> @@ -1060,7 +1071,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
>  		if (!ls)
>  			return -ENOMEM;
>  
> -		if (aggr_mode == LOCK_AGGR_CALLER && verbose > 0) {
> +		if (aggr_mode == LOCK_AGGR_CALLER && needs_callstack()) {
>  			ls->callstack = get_callstack(sample, max_stack_depth);
>  			if (ls->callstack == NULL)
>  				return -ENOMEM;
> @@ -1595,6 +1606,31 @@ static void print_contention_result(struct lock_contention *con)
>  		if (!st->wait_time_total)
>  			continue;
>  
> +		if (aggr_mode == LOCK_AGGR_CALLER && !list_empty(&callstack_filters)) {
> +			struct map *kmap;
> +			struct symbol *sym;
> +			u64 ip;
> +
> +			for (int i = 0; i < max_stack_depth; i++) {
> +				struct callstack_filter *filter;
> +
> +				if (!st->callstack || !st->callstack[i])
> +					break;
> +
> +				ip = st->callstack[i];
> +				sym = machine__find_kernel_symbol(con->machine, ip, &kmap);
> +				if (sym == NULL)
> +					continue;
> +
> +				list_for_each_entry(filter, &callstack_filters, list) {
> +					if (strstr(sym->name, filter->name))
> +						goto found;
> +				}
> +			}
> +			continue;
> +		}
> +
> +found:
>  		list_for_each_entry(key, &lock_keys, list) {
>  			key->print(key, st);
>  			pr_info(" ");
> @@ -1743,6 +1779,7 @@ static int __cmd_contention(int argc, const char **argv)
>  		.max_stack = max_stack_depth,
>  		.stack_skip = stack_skip,
>  		.filters = &filters,
> +		.save_callstack = needs_callstack(),
>  	};
>  
>  	session = perf_session__new(use_bpf ? NULL : &data, &eops);
> @@ -2123,6 +2160,33 @@ static int parse_lock_addr(const struct option *opt __maybe_unused, const char *
>  	return ret;
>  }
>  
> +static int parse_call_stack(const struct option *opt __maybe_unused, const char *str,
> +			   int unset __maybe_unused)
> +{
> +	char *s, *tmp, *tok;
> +	int ret = 0;
> +
> +	s = strdup(str);
> +	if (s == NULL)
> +		return -1;
> +
> +	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
> +		struct callstack_filter *entry;
> +
> +		entry = malloc(sizeof(*entry) + strlen(tok) + 1);
> +		if (entry == NULL) {
> +			pr_err("Memory allocation failure\n");
> +			return -1;
> +		}
> +
> +		strcpy(entry->name, tok);
> +		list_add_tail(&entry->list, &callstack_filters);
> +	}
> +
> +	free(s);
> +	return ret;
> +}
> +
>  int cmd_lock(int argc, const char **argv)
>  {
>  	const struct option lock_options[] = {
> @@ -2190,6 +2254,8 @@ int cmd_lock(int argc, const char **argv)
>  		     "Filter specific type of locks", parse_lock_type),
>  	OPT_CALLBACK('L', "lock-filter", NULL, "ADDRS/NAMES",
>  		     "Filter specific address/symbol of locks", parse_lock_addr),
> +	OPT_CALLBACK('S', "callstack-filter", NULL, "NAMES",
> +		     "Filter specific function in the callstack", parse_call_stack),
>  	OPT_PARENT(lock_options)
>  	};
>  
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index 0236334fd69b..4902ac331f41 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -268,7 +268,7 @@ int lock_contention_read(struct lock_contention *con)
>  			break;
>  		}
>  
> -		if (verbose > 0) {
> +		if (con->save_callstack) {
>  			st->callstack = memdup(stack_trace, stack_size);
>  			if (st->callstack == NULL)
>  				break;
> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> index b99e83fccf5c..17e594d57a61 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -128,6 +128,7 @@ struct lock_contention {
>  	int max_stack;
>  	int stack_skip;
>  	int aggr_mode;
> +	bool save_callstack;
>  };
>  
>  #ifdef HAVE_BPF_SKEL
> -- 
> 2.39.1.456.gfc5497dd1b-goog
> 

-- 

- Arnaldo
