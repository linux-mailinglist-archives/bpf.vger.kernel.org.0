Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CAD687DEB
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 13:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjBBMx1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 07:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBBMx0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 07:53:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C1D402F6;
        Thu,  2 Feb 2023 04:53:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6FD8B82655;
        Thu,  2 Feb 2023 12:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E356C433D2;
        Thu,  2 Feb 2023 12:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675342392;
        bh=lIYG9G3eXXBiCdhqDyaNCFdjb7UufWLfQlCBOY72k3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V70IZs8WbeayTGg04pECw3Da2UlQG3GhOi/bQtUxZGCglwBd8S7HFVKdiGQH4AVC1
         gFeJ/g6YEew3OKIkoYZ9ucHAq5GS6AYy7/ewU4H5D5MEKs+17FIl/30fGHsDNEJgZJ
         sqs5Z+fM8/G7rsMp2/h5ooEYetWeVg/KFn7I4dlHVTLgJb7KLPCj+cqtJgf8KM8GN9
         0LRbrUCTDY2pppGRssHityIFpwIQLi69kuwPJ22BebVTi4Eph5j9/ndAPtrsK752Ou
         /ig4iiJ99LNh4FJWv1cK4Y2L2IPBSjqTeUvpMC1npdAFG2RAiPUDyBEDKVRkjJ/eRE
         vzRgHzEEnmw0A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F313405BE; Thu,  2 Feb 2023 09:53:09 -0300 (-03)
Date:   Thu, 2 Feb 2023 09:53:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] perf lock contention: Factor out
 lock_contention_get_name()
Message-ID: <Y9uyNSA+UVjGBgpi@kernel.org>
References: <20230202050455.2187592-1-namhyung@kernel.org>
 <20230202050455.2187592-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202050455.2187592-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 01, 2023 at 09:04:52PM -0800, Namhyung Kim escreveu:
> The lock_contention_get_name() returns a name for the lock stat entry
> based on the current aggregation mode.  As it's called sequentially in a
> single thread, it can return the address of a static buffer for symbol
> and offset of the caller.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_lock_contention.c | 113 ++++++++++++++------------
>  1 file changed, 63 insertions(+), 50 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index 4902ac331f41..967ce168f163 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -163,9 +163,68 @@ int lock_contention_stop(void)
>  	return 0;
>  }
>  
> +static const char *lock_contention_get_name(struct lock_contention *con,
> +					    struct contention_key *key,
> +					    u64 *stack_trace)
> +{
> +	int idx = 0;
> +	u64 addr;
> +	const char *name = "";
> +	static char name_buf[KSYM_NAME_LEN];
> +	struct symbol *sym;
> +	struct map *kmap;
> +	struct machine *machine = con->machine;
> +
> +	if (con->aggr_mode == LOCK_AGGR_TASK) {
> +		struct contention_task_data task;
> +		struct thread *t;
> +		int pid = key->aggr_key;
> +		int task_fd = bpf_map__fd(skel->maps.task_data);
> +

I'm processing this as-is, but please consider to reduce the number of
lines by declaring variables where they are needed, for instance, the
't' variable is only used inside the next if block, so it could have
been:

> +		/* do not update idle comm which contains CPU number */
> +		if (pid) {
> +			bpf_map_lookup_elem(task_fd, &pid, &task);
> +			t = __machine__findnew_thread(machine, /*pid=*/-1, pid);

+			struct thread *t = __machine__findnew_thread(machine, /*pid=*/-1, pid);

But since __machine__findnew_thread() can fail, please check for that
and send a new patch series... Humm, you're just factoring out, the
problem was there before, so, to make progress, I'll process it as is
and later we can add fixes, can you please look into that?

> +			thread__set_comm(t, task.comm, /*timestamp=*/0);

thread__set_comm() can fail as well.

> +			name = task.comm;
> +		}
> +		return name;
> +	}
> +
> +	if (con->aggr_mode == LOCK_AGGR_ADDR) {
> +		sym = machine__find_kernel_symbol(machine, key->aggr_key, &kmap);
> +		if (sym)
> +			name = sym->name;

Here you check :-)

> +		return name;
> +	}
> +
> +	/* LOCK_AGGR_CALLER: skip lock internal functions */
> +	while (machine__is_lock_function(machine, stack_trace[idx]) &&
> +	       idx < con->max_stack - 1)
> +		idx++;
> +
> +	addr = stack_trace[idx];
> +	sym = machine__find_kernel_symbol(machine, addr, &kmap);
> +
> +	if (sym) {
> +		unsigned long offset;
> +
> +		offset = kmap->map_ip(kmap, addr) - sym->start;
> +
> +		if (offset == 0)
> +			return sym->name;
> +
> +		snprintf(name_buf, sizeof(name_buf), "%s+%#lx", sym->name, offset);
> +	} else {
> +		snprintf(name_buf, sizeof(name_buf), "%#lx", (unsigned long)addr);
> +	}
> +
> +	return name_buf;
> +}
> +
>  int lock_contention_read(struct lock_contention *con)
>  {
> -	int fd, stack, task_fd, err = 0;
> +	int fd, stack, err = 0;
>  	struct contention_key *prev_key, key;
>  	struct contention_data data = {};
>  	struct lock_stat *st = NULL;
> @@ -175,7 +234,6 @@ int lock_contention_read(struct lock_contention *con)
>  
>  	fd = bpf_map__fd(skel->maps.lock_stat);
>  	stack = bpf_map__fd(skel->maps.stacks);
> -	task_fd = bpf_map__fd(skel->maps.task_data);
>  
>  	con->lost = skel->bss->lost;
>  
> @@ -195,9 +253,6 @@ int lock_contention_read(struct lock_contention *con)
>  
>  	prev_key = NULL;
>  	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
> -		struct map *kmap;
> -		struct symbol *sym;
> -		int idx = 0;
>  		s32 stack_id;
>  
>  		/* to handle errors in the loop body */
> @@ -219,61 +274,19 @@ int lock_contention_read(struct lock_contention *con)
>  		st->flags = data.flags;
>  		st->addr = key.aggr_key;
>  
> -		if (con->aggr_mode == LOCK_AGGR_TASK) {
> -			struct contention_task_data task;
> -			struct thread *t;
> -			int pid = key.aggr_key;
> -
> -			/* do not update idle comm which contains CPU number */
> -			if (st->addr) {
> -				bpf_map_lookup_elem(task_fd, &pid, &task);
> -				t = __machine__findnew_thread(machine, /*pid=*/-1, pid);
> -				thread__set_comm(t, task.comm, /*timestamp=*/0);
> -			}
> -			goto next;
> -		}
> -
> -		if (con->aggr_mode == LOCK_AGGR_ADDR) {
> -			sym = machine__find_kernel_symbol(machine, st->addr, &kmap);
> -			if (sym)
> -				st->name = strdup(sym->name);
> -			goto next;
> -		}
> -
>  		stack_id = key.aggr_key;
>  		bpf_map_lookup_elem(stack, &stack_id, stack_trace);
>  
> -		/* skip lock internal functions */
> -		while (machine__is_lock_function(machine, stack_trace[idx]) &&
> -		       idx < con->max_stack - 1)
> -			idx++;
> -
> -		st->addr = stack_trace[idx];
> -		sym = machine__find_kernel_symbol(machine, st->addr, &kmap);
> -
> -		if (sym) {
> -			unsigned long offset;
> -			int ret = 0;
> -
> -			offset = kmap->map_ip(kmap, st->addr) - sym->start;
> -
> -			if (offset)
> -				ret = asprintf(&st->name, "%s+%#lx", sym->name, offset);
> -			else
> -				st->name = strdup(sym->name);
> -
> -			if (ret < 0 || st->name == NULL)
> -				break;
> -		} else if (asprintf(&st->name, "%#lx", (unsigned long)st->addr) < 0) {
> +		st->name = strdup(lock_contention_get_name(con, &key, stack_trace));
> +		if (st->name == NULL)
>  			break;
> -		}
>  
>  		if (con->save_callstack) {
>  			st->callstack = memdup(stack_trace, stack_size);
>  			if (st->callstack == NULL)
>  				break;
>  		}
> -next:
> +
>  		hlist_add_head(&st->hash_entry, con->result);
>  		prev_key = &key;
>  
> -- 
> 2.39.1.456.gfc5497dd1b-goog
> 

-- 

- Arnaldo
