Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739C264A831
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 20:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiLLTmj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 14:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbiLLTmh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 14:42:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0551E642A;
        Mon, 12 Dec 2022 11:42:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C26CB80E05;
        Mon, 12 Dec 2022 19:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2130C433D2;
        Mon, 12 Dec 2022 19:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670874153;
        bh=gC0AlNgWrsGUzaTEGZ1ThjNNUzPpMmizYKJ4FeJLZOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pUxpf1HCqX/EKSCN/LLV50xo24dazeRITUHdKUeJIun2N7CUXo4T1o8F7f5rkq8E2
         TL4kykHk44ggLk1CFEqH++BuGhIUtOagpo2JUKzKuCJxsSLXabfe10y4wKBpok0cZf
         K9V0iaMLHSaTCMCkYQDF3vzY78WwFJe8mR19e8Sen02PxDHnzY4Ik0Xfu/7OF1jiR4
         iBh6244tXdPuXTcp3trcLS6OxkDZdBpyz4T8Dnwdtf31KO9f4qe5cXAR7bR4Qsu/aS
         8I6NMyIUEUDWTliULnAiyt+AtOTAI5nQHGdH2W2mGELOuKUHB7dzhYjmqI/6xsEnQ0
         pV1cxdadqUKpg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 02AB340483; Mon, 12 Dec 2022 16:42:29 -0300 (-03)
Date:   Mon, 12 Dec 2022 16:42:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] perf lock contention: Add lock_data.h for common data
Message-ID: <Y5eEJd/AhSzUfILO@kernel.org>
References: <20221209190727.759804-1-namhyung@kernel.org>
 <20221209190727.759804-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221209190727.759804-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Dec 09, 2022 at 11:07:24AM -0800, Namhyung Kim escreveu:
> Accessing BPF maps should use the same data types.  Add bpf_skel/lock_data.h
> to define the common data structures.  No functional changes.

You forgot to update one of the stack_id users, that field got renamed:

util/bpf_skel/lock_contention.bpf.c:144:6: error: no member named 'stack_id' in 'struct contention_key'
        key.stack_id = pelem->stack_id;
        ~~~ ^
1 error generated.
make[2]: *** [Makefile.perf:1075: /tmp/build/perf/util/bpf_skel/.tmp/lock_contention.bpf.o] Error 1
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k NO_LIBTRACEEVENT=1 BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin':

     7,005,216,342      cycles:u
    11,851,225,594      instructions:u                   #    1.69  insn per cycle

       3.168945139 seconds time elapsed

       1.730964000 seconds user
       1.578932000 seconds sys


⬢[acme@toolbox perf]$ git log --oneline -4
f6e7a5f1db49dc8e (HEAD) perf lock contention: Add lock_data.h for common data
5d9b55713c5c037f perf python: Account for multiple words in CC
d9078bf3f3320457 perf off_cpu: Fix a typo in BTF tracepoint name, it should be 'btf_trace_sched_switch'
3b7ea76f0f7844f5 perf test: Update event group check for support of uncore event
⬢[acme@toolbox perf]$

After some point it builds.

I'm fixing this to keep it bisectable.

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_lock_contention.c         | 19 ++++--------
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 17 ++---------
>  tools/perf/util/bpf_skel/lock_data.h          | 30 +++++++++++++++++++
>  3 files changed, 38 insertions(+), 28 deletions(-)
>  create mode 100644 tools/perf/util/bpf_skel/lock_data.h
> 
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> index f4ebb9a2e380..b6a8eb7164b3 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -12,17 +12,10 @@
>  #include <bpf/bpf.h>
>  
>  #include "bpf_skel/lock_contention.skel.h"
> +#include "bpf_skel/lock_data.h"
>  
>  static struct lock_contention_bpf *skel;
>  
> -struct lock_contention_data {
> -	u64 total_time;
> -	u64 min_time;
> -	u64 max_time;
> -	u32 count;
> -	u32 flags;
> -};
> -
>  int lock_contention_prepare(struct lock_contention *con)
>  {
>  	int i, fd;
> @@ -110,8 +103,8 @@ int lock_contention_stop(void)
>  int lock_contention_read(struct lock_contention *con)
>  {
>  	int fd, stack, err = 0;
> -	s32 prev_key, key;
> -	struct lock_contention_data data = {};
> +	struct contention_key *prev_key, key;
> +	struct contention_data data = {};
>  	struct lock_stat *st = NULL;
>  	struct machine *machine = con->machine;
>  	u64 *stack_trace;
> @@ -126,8 +119,8 @@ int lock_contention_read(struct lock_contention *con)
>  	if (stack_trace == NULL)
>  		return -1;
>  
> -	prev_key = 0;
> -	while (!bpf_map_get_next_key(fd, &prev_key, &key)) {
> +	prev_key = NULL;
> +	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
>  		struct map *kmap;
>  		struct symbol *sym;
>  		int idx = 0;
> @@ -184,7 +177,7 @@ int lock_contention_read(struct lock_contention *con)
>  		}
>  
>  		hlist_add_head(&st->hash_entry, con->result);
> -		prev_key = key;
> +		prev_key = &key;
>  
>  		/* we're fine now, reset the values */
>  		st = NULL;
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 9681cb59b0df..0f63cc28ccba 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -5,24 +5,11 @@
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_core_read.h>
>  
> -/* maximum stack trace depth */
> -#define MAX_STACKS   8
> +#include "lock_data.h"
>  
>  /* default buffer size */
>  #define MAX_ENTRIES  10240
>  
> -struct contention_key {
> -	__s32 stack_id;
> -};
> -
> -struct contention_data {
> -	__u64 total_time;
> -	__u64 min_time;
> -	__u64 max_time;
> -	__u32 count;
> -	__u32 flags;
> -};
> -
>  struct tstamp_data {
>  	__u64 timestamp;
>  	__u64 lock;
> @@ -34,7 +21,7 @@ struct tstamp_data {
>  struct {
>  	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
>  	__uint(key_size, sizeof(__u32));
> -	__uint(value_size, MAX_STACKS * sizeof(__u64));
> +	__uint(value_size, sizeof(__u64));
>  	__uint(max_entries, MAX_ENTRIES);
>  } stacks SEC(".maps");
>  
> diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
> new file mode 100644
> index 000000000000..dbdf4caedc4a
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/lock_data.h
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/* Data structures shared between BPF and tools. */
> +#ifndef UTIL_BPF_SKEL_LOCK_DATA_H
> +#define UTIL_BPF_SKEL_LOCK_DATA_H
> +
> +struct contention_key {
> +	s32 stack_or_task_id;
> +};
> +
> +#define TASK_COMM_LEN  16
> +
> +struct contention_task_data {
> +	char comm[TASK_COMM_LEN];
> +};
> +
> +struct contention_data {
> +	u64 total_time;
> +	u64 min_time;
> +	u64 max_time;
> +	u32 count;
> +	u32 flags;
> +};
> +
> +enum lock_aggr_mode {
> +	LOCK_AGGR_ADDR = 0,
> +	LOCK_AGGR_TASK,
> +	LOCK_AGGR_CALLER,
> +};
> +
> +#endif /* UTIL_BPF_SKEL_LOCK_DATA_H */
> -- 
> 2.39.0.rc1.256.g54fd8350bd-goog

-- 

- Arnaldo
