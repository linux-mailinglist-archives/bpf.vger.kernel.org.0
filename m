Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759E165359B
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 18:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiLURvC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 12:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiLURvB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 12:51:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDDE21275;
        Wed, 21 Dec 2022 09:50:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 193C9618A9;
        Wed, 21 Dec 2022 17:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DFEC433D2;
        Wed, 21 Dec 2022 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671645058;
        bh=oXMcXsVlPlcGXpz4n9urSXePmE7p0mZGuuSgRKv/LuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6TR7t0TCcFWCX4MFlTJUrNoa8vywYhDG1f8+BvAZUY7JBy8ZM3xiPWIi/1Qfcdf/
         ALSFgAzjy0DE5StAArjBcS0X9Wuxk7TKZpdQ3BpVTPnj+S8HsC2Pt1ZXwSSWmuCaUe
         z7oR64q3CcqBm5cblpcbDMAKe0T44smQTq7i9wKKlBinSb/H3s86J5WwREalZ21fIy
         m3TYIwHMd5Z5RoPORMocU6/7CST75W0rbYPQSutUdOT6LmVsX2c2808JX0yzX1sRg1
         eUl5tSmYDB3dPHKxVmq7kw02hsA/4TegAsDIJZdShRQbRyIADNL5E8LVsrEGD2D4N3
         XJ916YCTILcFQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 24E7D40367; Wed, 21 Dec 2022 14:50:55 -0300 (-03)
Date:   Wed, 21 Dec 2022 14:50:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 2/6] perf lock contention: Add -Y/--type-filter option
Message-ID: <Y6NHf1h2BKOw9J3Q@kernel.org>
References: <20221219201732.460111-1-namhyung@kernel.org>
 <20221219201732.460111-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219201732.460111-3-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Dec 19, 2022 at 12:17:28PM -0800, Namhyung Kim escreveu:
> The -Y/--type-filter option is to filter the result for specific lock
> types only.  It can accept comma-separated values.  Note that it would
> accept type names like one in the output.  spinlock, mutex, rwsem:R and
> so on.
> 
> For RW-variant lock types, it converts the name to the both variants.
> In other words, "rwsem" is same as "rwsem:R,rwsem:W".  Also note that
> "mutex" has two different encoding - one for sleeping wait, another for
> optimistic spinning.  Add "mutex-spin" entry for the lock_type_table so
> that we can add it for "mutex" under the table.
> 
>   $ sudo ./perf lock record -a -- ./perf bench sched messaging
> 
>   $ sudo ./perf lock con -E 5 -Y spinlock
>    contended   total wait     max wait     avg wait         type   caller
> 
>          802      1.26 ms     11.73 us      1.58 us     spinlock   __wake_up_common_lock+0x62
>           13    787.16 us    105.44 us     60.55 us     spinlock   remove_wait_queue+0x14
>           12    612.96 us     78.70 us     51.08 us     spinlock   prepare_to_wait+0x27
>          114    340.68 us     12.61 us      2.99 us     spinlock   try_to_wake_up+0x1f5
>           83    226.38 us      9.15 us      2.73 us     spinlock   folio_lruvec_lock_irqsave+0x5e
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-lock.txt |  23 +++--
>  tools/perf/builtin-lock.c              | 116 ++++++++++++++++++++++++-
>  tools/perf/util/lock-contention.h      |   5 ++
>  3 files changed, 136 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index 38e79d45e426..dea04ad5c28e 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -143,25 +143,25 @@ CONTENTION OPTIONS
>          System-wide collection from all CPUs.
>  
>  -C::
> ---cpu::
> +--cpu=<value>::
>  	Collect samples only on the list of CPUs provided. Multiple CPUs can be
>  	provided as a comma-separated list with no space: 0,1. Ranges of CPUs
>  	are specified with -: 0-2.  Default is to monitor all CPUs.
>  
>  -p::
> ---pid=::
> +--pid=<value>::
>  	Record events on existing process ID (comma separated list).
>  
> ---tid=::
> +--tid=<value>::
>          Record events on existing thread ID (comma separated list).
>  
> ---map-nr-entries::
> +--map-nr-entries=<value>::
>  	Maximum number of BPF map entries (default: 10240).
>  
> ---max-stack::
> +--max-stack=<value>::
>  	Maximum stack depth when collecting lock contention (default: 8).
>  
> ---stack-skip
> +--stack-skip=<value>::
>  	Number of stack depth to skip when finding a lock caller (default: 3).
>  
>  -E::
> @@ -172,6 +172,17 @@ CONTENTION OPTIONS
>  --lock-addr::
>  	Show lock contention stat by address
>  
> +-Y::
> +--type-filter=<value>::
> +	Show lock contention only for given lock types (comma separated list).
> +	Available values are:
> +	  semaphore, spinlock, rwlock, rwlock:R, rwlock:W, rwsem, rwsem:R, rwsem:W,
> +	  rtmutex, rwlock-rt, rwlock-rt:R, rwlock-rt:W, pcpu-sem, pcpu-sem:R, pcpu-sem:W,
> +	  mutex
> +
> +	Note that RW-variant of locks have :R and :W suffix.  Names without the
> +	suffix are shortcuts for the both variants.  Ex) rwsem = rwsem:R + rwsem:W.
> +
>  
>  SEE ALSO
>  --------
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 548d81eb0b18..49b4add53204 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -63,6 +63,8 @@ static int max_stack_depth = CONTENTION_STACK_DEPTH;
>  static int stack_skip = CONTENTION_STACK_SKIP;
>  static int print_nr_entries = INT_MAX / 2;
>  
> +static struct lock_filter filters;
> +
>  static enum lock_aggr_mode aggr_mode = LOCK_AGGR_ADDR;
>  
>  static struct thread_stat *thread_stat_find(u32 tid)
> @@ -990,8 +992,9 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
>  	struct thread_stat *ts;
>  	struct lock_seq_stat *seq;
>  	u64 addr = evsel__intval(evsel, sample, "lock_addr");
> +	unsigned int flags = evsel__intval(evsel, sample, "flags");
>  	u64 key;
> -	int ret;
> +	int i, ret;
>  
>  	ret = get_key_by_aggr_mode(&key, addr, evsel, sample);
>  	if (ret < 0)
> @@ -1001,7 +1004,6 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
>  	if (!ls) {
>  		char buf[128];
>  		const char *name = "";
> -		unsigned int flags = evsel__intval(evsel, sample, "flags");
>  		struct machine *machine = &session->machines.host;
>  		struct map *kmap;
>  		struct symbol *sym;
> @@ -1036,6 +1038,20 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
>  		}
>  	}
>  
> +	if (filters.nr_types) {
> +		bool found = false;
> +
> +		for (i = 0; i < filters.nr_types; i++) {
> +			if (flags == filters.types[i]) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found)
> +			return 0;
> +	}
> +
>  	ts = thread_stat_findnew(sample->tid);
>  	if (!ts)
>  		return -ENOMEM;
> @@ -1454,6 +1470,8 @@ static const struct {
>  	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W" },
>  	{ LCB_F_MUTEX,			"mutex" },
>  	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex" },
> +	/* alias for get_type_flag() */
> +	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin" },
>  };
>  
>  static const char *get_type_str(unsigned int flags)
> @@ -1465,6 +1483,21 @@ static const char *get_type_str(unsigned int flags)
>  	return "unknown";
>  }
>  
> +static unsigned int get_type_flag(const char *str)
> +{
> +	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> +		if (!strcmp(lock_type_table[i].name, str))
> +			return lock_type_table[i].flags;
> +	}
> +	return -1U;
> +}
> +
> +static void lock_filter_finish(void)
> +{
> +	zfree(&filters.types);
> +	filters.nr_types = 0;
> +}
> +
>  static void sort_contention_result(void)
>  {
>  	sort_result();
> @@ -1507,6 +1540,9 @@ static void print_contention_result(struct lock_contention *con)
>  		if (st->broken)
>  			bad++;
>  
> +		if (!st->wait_time_total)
> +			continue;
> +
>  		list_for_each_entry(key, &lock_keys, list) {
>  			key->print(key, st);
>  			pr_info(" ");
> @@ -1753,6 +1789,7 @@ static int __cmd_contention(int argc, const char **argv)
>  	print_contention_result(&con);
>  
>  out_delete:
> +	lock_filter_finish();
>  	evlist__delete(con.evlist);
>  	lock_contention_finish();
>  	perf_session__delete(session);
> @@ -1884,6 +1921,79 @@ static int parse_max_stack(const struct option *opt, const char *str,
>  	return 0;
>  }
>  
> +static bool add_lock_type(unsigned int flags)
> +{
> +	unsigned int *tmp;
> +
> +	tmp = realloc(filters.types, (filters.nr_types + 1) * sizeof(*filters.types));
> +	if (tmp == NULL)
> +		return false;
> +
> +	tmp[filters.nr_types++] = flags;
> +	filters.types = tmp;
> +	return true;
> +}
> +
> +static int parse_lock_type(const struct option *opt __maybe_unused, const char *str,
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
> +		unsigned int flags = get_type_flag(tok);
> +
> +		if (flags == -1U) {
> +			char buf[32];
> +
> +			if (strchr(tok, ':'))
> +			    continue;
> +
> +			/* try :R and :W suffixes for rwlock, rwsem, ... */
> +			scnprintf(buf, sizeof(buf), "%s:R", tok);
> +			flags = get_type_flag(buf);
> +			if (flags != -1UL) {
> +				if (!add_lock_type(flags)) {
> +					ret = -1;
> +					break;
> +				}
> +			}


clang doesn't like this:

  34    97.97 fedora:36                     : FAIL clang version 14.0.5 (Fedora 14.0.5-2.fc36)
    builtin-lock.c:2012:14: error: result of comparison of constant 18446744073709551615 with expression of type 'unsigned int' is always true [-Werror,-Wtautological-constant-out-of-range-compare]
                            if (flags != -1UL) {
                                ~~~~~ ^  ~~~~
    builtin-lock.c:2021:14: error: result of comparison of constant 18446744073709551615 with expression of type 'unsigned int' is always true [-Werror,-Wtautological-constant-out-of-range-compare]
                            if (flags != -1UL) {
                                ~~~~~ ^  ~~~~
    builtin-lock.c:2037:14: error: result of comparison of constant 18446744073709551615 with expression of type 'unsigned int' is always true [-Werror,-Wtautological-constant-out-of-range-compare]
                            if (flags != -1UL) {
                                ~~~~~ ^  ~~~~
    3 errors generated.

I applied this on top, Ack?

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index daef37fe0ccda249..c73d02082cdf4b3a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1489,7 +1489,7 @@ static unsigned int get_type_flag(const char *str)
 		if (!strcmp(lock_type_table[i].name, str))
 			return lock_type_table[i].flags;
 	}
-	return -1U;
+	return UINT_MAX;
 }
 
 static void lock_filter_finish(void)
@@ -1956,7 +1956,7 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 			/* try :R and :W suffixes for rwlock, rwsem, ... */
 			scnprintf(buf, sizeof(buf), "%s:R", tok);
 			flags = get_type_flag(buf);
-			if (flags != -1UL) {
+			if (flags != UINT_MAX) {
 				if (!add_lock_type(flags)) {
 					ret = -1;
 					break;
@@ -1965,7 +1965,7 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 
 			scnprintf(buf, sizeof(buf), "%s:W", tok);
 			flags = get_type_flag(buf);
-			if (flags != -1UL) {
+			if (flags != UINT_MAX) {
 				if (!add_lock_type(flags)) {
 					ret = -1;
 					break;
@@ -1981,7 +1981,7 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 
 		if (!strcmp(tok, "mutex")) {
 			flags = get_type_flag("mutex-spin");
-			if (flags != -1UL) {
+			if (flags != UINT_MAX) {
 				if (!add_lock_type(flags)) {
 					ret = -1;
 					break;

> +			flags = get_type_flag(buf);
> +			if (flags != -1UL) {
> +				if (!add_lock_type(flags)) {
> +					ret = -1;
> +					break;
> +				}
> +			}
> +			continue;
> +		}
> +
> +		if (!add_lock_type(flags)) {
> +			ret = -1;
> +			break;
> +		}
> +
> +		if (!strcmp(tok, "mutex")) {
> +			flags = get_type_flag("mutex-spin");
> +			if (flags != -1UL) {
> +				if (!add_lock_type(flags)) {
> +					ret = -1;
> +					break;
> +				}
> +			}
> +		}
> +	}
> +
> +	free(s);
> +	return ret;
> +}
> +
>  int cmd_lock(int argc, const char **argv)
>  {
>  	const struct option lock_options[] = {
> @@ -1947,6 +2057,8 @@ int cmd_lock(int argc, const char **argv)
>  		    "Default: " __stringify(CONTENTION_STACK_SKIP)),
>  	OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
>  	OPT_BOOLEAN('l', "lock-addr", &show_lock_addrs, "show lock stats by address"),
> +	OPT_CALLBACK('Y', "type-filter", NULL, "FLAGS",
> +		     "Filter specific type of locks", parse_lock_type),
>  	OPT_PARENT(lock_options)
>  	};
>  
> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> index 47fd47fb56c1..d5b75b222d8e 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -5,6 +5,11 @@
>  #include <linux/list.h>
>  #include <linux/rbtree.h>
>  
> +struct lock_filter {
> +	int			nr_types;
> +	unsigned int		*types;
> +};
> +
>  struct lock_stat {
>  	struct hlist_node	hash_entry;
>  	struct rb_node		rb;		/* used for sorting */
> -- 
> 2.39.0.314.g84b9a713c41-goog

-- 

- Arnaldo
