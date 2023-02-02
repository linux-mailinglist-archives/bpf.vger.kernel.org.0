Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0664268883D
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 21:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjBBU16 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 15:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBBU15 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 15:27:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6A922038;
        Thu,  2 Feb 2023 12:27:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B8D6B82778;
        Thu,  2 Feb 2023 20:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6710C433EF;
        Thu,  2 Feb 2023 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675369673;
        bh=/yv6z44DjS37fPnTEcfK9tOUPF+JjplCO3q90mk7/Nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rFUOLQ7F6AYZI1xbHoOpVL9ux3EJlQ9bQW12TYvSvyFVAHHLXu0xL83sTnwOl7acU
         8KKUYvjR5OU0cctleDSHDeMl6I/77YbfQOM8+mfNBvCq7BjrOd/mJM1rr88Szysx4d
         yohKE5NqpsIxdR5eYQqX4OpvAtjvRK17Sjwk72y1LA0oaNCf6lnuw9X6dsXNqKccoa
         Y6plnDhy3Mo11kk/kaqRP2dv101IDrZRZAu9LWpci2Tm5yXevcL5eZXqCLTWd2BhL7
         exT00cbSb7RN58KHIYoSQENrQJt3GZf27YLBlVlHnqPo5hVhZsALrlDVYOD34gF37S
         c5ZL/usVQQ8hA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 05C42405BE; Thu,  2 Feb 2023 17:27:49 -0300 (-03)
Date:   Thu, 2 Feb 2023 17:27:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 2/4] perf lock contention: Use lock_stat_find{,new}
Message-ID: <Y9wcxfrL3J+nfp0P@kernel.org>
References: <20230202050455.2187592-1-namhyung@kernel.org>
 <20230202050455.2187592-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202050455.2187592-3-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 01, 2023 at 09:04:53PM -0800, Namhyung Kim escreveu:
> This is a preparation work to support complex keys of BPF maps.  Now it
> has single value key according to the aggregation mode like stack_id or
> pid.  But we want to use a combination of those keys.
> 
> Then lock_contention_read() should still aggregate the result based on
> the key that was requested by user.  The other key info will be used for
> filtering.
> 
> So instead of creating a lock_stat entry always, Check if it's already
> there using lock_stat_find() first.

Hey, try building without libtraceevent-devel installed, should be
equivalent to NO_LIBTRACEEVENT=1.

At this point I think you should move bpf_lock_contention.o to inside
that CONFIG_LIBTRACEEVENT if block.

perf-$(CONFIG_PERF_BPF_SKEL) += bpf_lock_contention.o

ifeq ($(CONFIG_LIBTRACEEVENT),y)
  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_kwork.o
endif

I'm removing this series from tmp.perf/core for now.

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-lock.c             |  4 +--
>  tools/perf/util/bpf_lock_contention.c | 41 ++++++++++++++++-----------
>  tools/perf/util/lock-contention.h     |  3 ++
>  3 files changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 216a9a252bf4..0593c6e636c6 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -465,7 +465,7 @@ static struct lock_stat *pop_from_result(void)
>  	return container_of(node, struct lock_stat, rb);
>  }
>  
> -static struct lock_stat *lock_stat_find(u64 addr)
> +struct lock_stat *lock_stat_find(u64 addr)
>  {
>  	struct hlist_head *entry = lockhashentry(addr);
>  	struct lock_stat *ret;
> @@ -477,7 +477,7 @@ static struct lock_stat *lock_stat_find(u64 addr)
>  	return NULL;
>  }
>  
> -static struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
> +struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
>  {
>  	struct hlist_head *entry = lockhashentry(addr);
>  	struct lock_stat *ret, *new;
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index 967ce168f163..c6f2db603d5a 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -254,12 +254,34 @@ int lock_contention_read(struct lock_contention *con)
>  	prev_key = NULL;
>  	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
>  		s32 stack_id;
> +		const char *name;
>  
>  		/* to handle errors in the loop body */
>  		err = -1;
>  
>  		bpf_map_lookup_elem(fd, &key, &data);
> -		st = zalloc(sizeof(*st));
> +
> +		if (con->save_callstack) {
> +			stack_id = key.aggr_key;
> +			bpf_map_lookup_elem(stack, &stack_id, stack_trace);
> +		}
> +
> +		st = lock_stat_find(key.aggr_key);
> +		if (st != NULL) {
> +			st->wait_time_total += data.total_time;
> +			if (st->wait_time_max < data.max_time)
> +				st->wait_time_max = data.max_time;
> +			if (st->wait_time_min > data.min_time)
> +				st->wait_time_min = data.min_time;
> +
> +			st->nr_contended += data.count;
> +			if (st->nr_contended)
> +				st->avg_wait_time = st->wait_time_total / st->nr_contended;
> +			goto next;
> +		}
> +
> +		name = lock_contention_get_name(con, &key, stack_trace);
> +		st = lock_stat_findnew(key.aggr_key, name, data.flags);
>  		if (st == NULL)
>  			break;
>  
> @@ -272,14 +294,6 @@ int lock_contention_read(struct lock_contention *con)
>  			st->avg_wait_time = data.total_time / data.count;
>  
>  		st->flags = data.flags;
> -		st->addr = key.aggr_key;
> -
> -		stack_id = key.aggr_key;
> -		bpf_map_lookup_elem(stack, &stack_id, stack_trace);
> -
> -		st->name = strdup(lock_contention_get_name(con, &key, stack_trace));
> -		if (st->name == NULL)
> -			break;
>  
>  		if (con->save_callstack) {
>  			st->callstack = memdup(stack_trace, stack_size);
> @@ -287,19 +301,14 @@ int lock_contention_read(struct lock_contention *con)
>  				break;
>  		}
>  
> -		hlist_add_head(&st->hash_entry, con->result);
> +next:
>  		prev_key = &key;
>  
> -		/* we're fine now, reset the values */
> -		st = NULL;
> +		/* we're fine now, reset the error */
>  		err = 0;
>  	}
>  
>  	free(stack_trace);
> -	if (st) {
> -		free(st->name);
> -		free(st);
> -	}
>  
>  	return err;
>  }
> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> index 17e594d57a61..39d5bfc77f4e 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -65,6 +65,9 @@ struct lock_stat {
>   */
>  #define MAX_LOCK_DEPTH 48
>  
> +struct lock_stat *lock_stat_find(u64 addr);
> +struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags);
> +
>  /*
>   * struct lock_seq_stat:
>   * Place to put on state of one lock sequence
> -- 
> 2.39.1.456.gfc5497dd1b-goog
> 

-- 

- Arnaldo
