Return-Path: <bpf+bounces-54525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9C7A6B426
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 06:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B243B2585
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 05:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24171E9B2B;
	Fri, 21 Mar 2025 05:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9EFnLhT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502DF8BE7;
	Fri, 21 Mar 2025 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742536448; cv=none; b=KhzY/7AogbY85XEK5SxS6MMHCcz7o45Vdi1ulCv68itHw8VvaNDWtvJWNeD0xysPGbblz9cFWZK3P8M//WTi6azo7bWwdPuqv9ehn4sE2mXsIvZuX6NiLVMpArj5Y81c32yj3XmRwoASZ26qWqaZUEf30LA58050hv3nF/1ffEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742536448; c=relaxed/simple;
	bh=sF54cMqazZLdkrizp6Kx5IO12q1FP7cX5erX4bhYUzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHyT4HVJRija8hhet3Kd7UjjoVKWGnyp7d24A1ZUpI8ytRnEEgFXa1ezggdXlacwcJFEf0uPHiUcybh2aY9y0bpJhGjOW7hIBWMdo+iy0q76KoiC+JKu/WNBqWsh0e+cX3H8D/oRpDG75BBDsUlYI+r/4Pur8NktQAKakshYLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9EFnLhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E246C4CEE8;
	Fri, 21 Mar 2025 05:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742536447;
	bh=sF54cMqazZLdkrizp6Kx5IO12q1FP7cX5erX4bhYUzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9EFnLhTD9RaQaNsewjo7njCIxEe2OVcjEVptU09Wu/0vVmGWu+DPTAdOLRVGlVDP
	 wShyEqlRlpbXh5j9I/p2NNzXc1n+mC+6hfP/aeuPvZ4Hx48n2MvHiY1dLeq3fHeGRw
	 DKRnsHj3L3vjAey/RFZolGesaSLJmOuRoT/KeYlor7r6uppE2CUi5fV9X0l06eZyDN
	 pwoS8QivZePL7ETBAJnbFlXlVlp5XlPOksPo9UzjNupBh1A+WNIHDSboXFr8tQtVTy
	 /4zZw7U84SynuCg3qGQuIiF28ixVVLXdsDS6x3/bNXflDFkXZPHHE7apkRAyuHokaz
	 O5o1kruVHySpw==
Date: Thu, 20 Mar 2025 22:54:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH v2] perf trace: Implement syscall summary in BPF
Message-ID: <Z9z-_ftY23KcZ6c1@google.com>
References: <20250317180834.1862079-1-namhyung@kernel.org>
 <CAH0uvojj=-BE93VeuxK1LWEEBkYXT_BsRAf17gb-34jFRwnDww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvojj=-BE93VeuxK1LWEEBkYXT_BsRAf17gb-34jFRwnDww@mail.gmail.com>

On Thu, Mar 20, 2025 at 07:35:01PM -0700, Howard Chu wrote:
> Hello again Namhyung,
> 
> As funny as it sounds, I have too much homework this week. I had to
> break the review into two parts. Sorry.

Thanks for taking your time!

> 
> 1) Maybe just '--bpf-summary' instead?
> 
> First of all, is '-s --bpf-summary' is it ergonomic? Why not drop the
> -s and just --bpf-summary since the option has 'summary' in its name.
> Another reason being,
> sudo ./perf trace -S --bpf-summary --summary-mode=total -- sleep 1
> sudo ./perf trace -s --bpf-summary --summary-mode=total -- sleep 1
> are the same (-S will emit no output to stdout).

Hmm.. it looks like a bug, will take a look.  Maybe --bpf-summary is
redundant, but I think we can make it default later so that -s/-S can
use BPF without the option excplicitly.  Then this option can be used
to disable it (--no-bpf-summary) for whatever reasons.

> 
> 2) Anomaly observed when playing around
> 
> sudo ./perf trace -s --bpf-summary --summary-mode=total -- sleep 1
> this gave me 10000 events
> 
> sudo ./perf trace -as --bpf-summary --summary-mode=total -- sleep 1
> while this gave me 1000 events
> 
> I guess it's something to do with the lost events?

No, as you said in the previous message it didn't support process
targets yet.  I plan to disable it without -a for now.

> 
> 3) Wrong stddev values
> Please compare these two outputs
> 
> perf $ sudo ./perf trace -as --summary-mode=total -- sleep 1
> 
>  Summary of events:
> 
>  total, 11290 events
> 
>    syscall            calls  errors  total       min       avg
> max       stddev
>                                      (msec)    (msec)    (msec)
> (msec)        (%)
>    --------------- --------  ------ -------- --------- ---------
> ---------     ------
>    mq_open              214     71 16073.976     0.000    75.112
> 250.120      9.91%
>    futex               1296    195 11592.060     0.000     8.944
> 907.590     13.59%
>    epoll_wait           479      0  4262.456     0.000     8.899
> 496.568     20.34%
>    poll                 241      0  2545.090     0.000    10.561
> 607.894     33.33%
>    ppoll                330      0  1713.676     0.000     5.193
> 410.143     26.45%
>    migrate_pages         45      0  1031.915     0.000    22.931
> 147.830     20.70%
>    clock_nanosleep        2      0  1000.106     0.000   500.053
> 1000.106    100.00%
>    swapoff              340      0   909.827     0.000     2.676
> 50.117     22.76%
>    pselect6               5      0   604.816     0.000   120.963
> 604.808    100.00%
>    readlinkat            26      3   501.205     0.000    19.277
> 499.998     99.75%
> 
> perf $ sudo ./perf trace -as --bpf-summary --summary-mode=total -- sleep 1
> 
>  Summary of events:
> 
>  total, 880 events
> 
>    syscall            calls  errors  total       min       avg
> max       stddev
>                                      (msec)    (msec)    (msec)
> (msec)        (%)
>    --------------- --------  ------ -------- --------- ---------
> ---------     ------
>    futex                219     46  2326.400     0.001    10.623
> 243.028    337.77%
>    mq_open               19      8  2001.347     0.003   105.334
> 250.356    117.26%
>    poll                   6      1  1002.512     0.002   167.085
> 1002.496    223.60%
>    clock_nanosleep        1      0  1000.147  1000.147  1000.147
> 1000.147      0.00%
>    swapoff               43      0   953.251     0.001    22.169
> 50.390    112.37%
>    migrate_pages         43      0   933.727     0.004    21.715
> 49.149    106.68%
>    ppoll                 32      0   838.035     0.002    26.189
> 331.222    252.10%
>    epoll_pwait            5      0   499.578     0.001    99.916
> 499.565    199.99%
>    nanosleep              1      0    10.149    10.149    10.149
> 10.149      0.00%
>    epoll_wait            10      0     3.449     0.003     0.345
> 0.815     88.02%
>    readlinkat            25      3     1.424     0.006     0.057
> 0.080     41.76%
>    recvmsg               61      0     1.326     0.016     0.022
> 0.052     21.71%
>    execve                 6      5     1.100     0.002     0.183
> 1.078    218.21%
> 
> I would say stddev here is a little off. The reason is:
> 
> On Mon, Mar 17, 2025 at 11:08 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > When -s/--summary option is used, it doesn't need (augmented) arguments
> > of syscalls.  Let's skip the augmentation and load another small BPF
> > program to collect the statistics in the kernel instead of copying the
> > data to the ring-buffer to calculate the stats in userspace.  This will
> > be much more light-weight than the existing approach and remove any lost
> > events.
> >
> > Let's add a new option --bpf-summary to control this behavior.  I cannot
> > make it default because there's no way to get e_machine in the BPF which
> > is needed for detecting different ABIs like 32-bit compat mode.
> >
> > No functional changes intended except for no more LOST events. :)
> >
> >   $ sudo perf trace -as --bpf-summary --summary-mode=total -- sleep 1
> >
> >    Summary of events:
> >
> >    total, 2824 events
> >
> >      syscall            calls  errors  total       min       avg       max       stddev
> >                                        (msec)    (msec)    (msec)    (msec)        (%)
> >      --------------- --------  ------ -------- --------- --------- ---------     ------
> >      futex                372     18  4373.773     0.000    11.757   997.715    660.42%
> >      poll                 241      0  2757.963     0.000    11.444   997.758    580.34%
> >      epoll_wait           161      0  2460.854     0.000    15.285   325.189    260.73%
> >      ppoll                 19      0  1298.652     0.000    68.350   667.172    281.46%
> >      clock_nanosleep        1      0  1000.093     0.000  1000.093  1000.093      0.00%
> >      epoll_pwait           16      0   192.787     0.000    12.049   173.994    348.73%
> >      nanosleep              6      0    50.926     0.000     8.488    10.210     43.96%
> >      ...
> >
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > v2)
> >  * rebased on top of Ian's e_machine changes
> >  * add --bpf-summary option
> >  * support per-thread summary
> >  * add stddev calculation  (Howard)
> <SNIP>
> > +static double rel_stddev(struct syscall_stats *stat)
> > +{
> > +       double variance, average;
> > +
> > +       if (stat->count < 2)
> > +               return 0;
> > +
> > +       average = (double)stat->total_time / stat->count;
> > +
> > +       variance = stat->squared_sum;
> > +       variance -= (stat->total_time * stat->total_time) / stat->count;
> > +       variance /= stat->count;
> 
> isn't it 'variance /= stat->count - 1' because we used Bessel's
> correction? (Link:
> https://en.wikipedia.org/wiki/Bessel%27s_correction), that is to use n
> - 1 instead of n, this is what's done in stat.c.
> 
>  *       (\Sum n_i^2) - ((\Sum n_i)^2)/n
>  * s^2 = -------------------------------
>  *                  n - 1
> 
> and the lines down here are unfortunately incorrect
> + variance = stat->squared_sum;
> + variance -= (stat->total_time * stat->total_time) / stat->count;
> + variance /= stat->count;
> +
> + return 100 * sqrt(variance) / average;
> 
> variance /= stat->count - 1; will get you variance, but I think we
> need variance mean.
> Link: https://en.wikipedia.org/wiki/Standard_deviation#Relationship_between_standard_deviation_and_mean
> 
> it holds that:
> variance(mean) = variance / N
> 
> so you are losing a '/ stat->count'

You're right, thanks for pointing that out.

> 
> And with all due respect, although it makes total sense in
> engineering, mathematically, I find variance = stat->squared_sum,
> variance -= ... these accumulated calculations on variable 'variance'
> a little weird... because readers may find difficult to determine at
> which point it becomes the actual 'variance'
> 
> with clarity in mind:
> 
> diff --git a/tools/perf/util/bpf-trace-summary.c
> b/tools/perf/util/bpf-trace-summary.c
> index 5ae9feca244d..a435b4037082 100644
> --- a/tools/perf/util/bpf-trace-summary.c
> +++ b/tools/perf/util/bpf-trace-summary.c
> @@ -62,18 +62,18 @@ struct syscall_node {
> 
>  static double rel_stddev(struct syscall_stats *stat)
>  {
> -       double variance, average;
> +       double variance, average, squared_total;
> 
>         if (stat->count < 2)
>                 return 0;
> 
>         average = (double)stat->total_time / stat->count;
> 
> -       variance = stat->squared_sum;
> -       variance -= (stat->total_time * stat->total_time) / stat->count;
> -       variance /= stat->count;
> +       squared_total = stat->total_time * stat->total_time;
> +       variance = (stat->squared_sum - squared_total / stat->count) /
> (stat->count - 1);
> +       stddev_mean = sqrt(variance / stat->count);
> 
> -       return 100 * sqrt(variance) / average;
> +       return 100 * stddev_mean / average;
>  }

Can it be like this?

diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-trace-summary.c
index a91d42447e850a59..c897fb017914960c 100644
--- a/tools/perf/util/bpf-trace-summary.c
+++ b/tools/perf/util/bpf-trace-summary.c
@@ -71,9 +71,9 @@ static double rel_stddev(struct syscall_stats *stat)
 
        variance = stat->squared_sum;
        variance -= (stat->total_time * stat->total_time) / stat->count;
-       variance /= stat->count;
+       variance /= stat->count - 1;
 
-       return 100 * sqrt(variance) / average;
+       return 100 * sqrt(variance / stat->count) / average;
 }
 
 struct syscall_data {

> 
> btw I haven't checked the legal range for stddev_mean, so I can be wrong.
> <SNIP>
> > +static int update_total_stats(struct hashmap *hash, struct syscall_key *map_key,
> > +                             struct syscall_stats *map_data)
> > +{
> > +       struct syscall_data *data;
> > +       struct syscall_stats *stat;
> > +
> > +       if (!hashmap__find(hash, map_key, &data)) {
> > +               data = zalloc(sizeof(*data));
> > +               if (data == NULL)
> > +                       return -ENOMEM;
> > +
> > +               data->nodes = zalloc(sizeof(*data->nodes));
> > +               if (data->nodes == NULL) {
> > +                       free(data);
> > +                       return -ENOMEM;
> > +               }
> > +
> > +               data->nr_nodes = 1;
> > +               data->key = map_key->nr;
> > +               data->nodes->syscall_nr = data->key;
> Wow, aggressive. I guess you want it to behave like a single value
> when it is SYSCALL_AGGR_CPU, and an array when it is
> SYSCALL_AGGR_THREAD. Do you mind adding a comment about it?
> 
> so it's
> 
> (cpu, syscall_nr) -> data -> {node}
> (tid, syscall_nr) -> data -> [node1, node2, node3]

Right, will add comments.

> 
> 
> > +
> > +               if (hashmap__add(hash, data->key, data) < 0) {
> > +                       free(data->nodes);
> > +                       free(data);
> > +                       return -ENOMEM;
> > +               }
> > +       }
> > +
> > +       /* update total stats for this syscall */
> > +       data->nr_events += map_data->count;
> > +       data->total_time += map_data->total_time;
> > +
> > +       /* This is sum of the same syscall from different CPUs */
> > +       stat = &data->nodes->stats;
> > +
> > +       stat->total_time += map_data->total_time;
> > +       stat->squared_sum += map_data->squared_sum;
> > +       stat->count += map_data->count;
> > +       stat->error += map_data->error;
> > +
> > +       if (stat->max_time < map_data->max_time)
> > +               stat->max_time = map_data->max_time;
> > +       if (stat->min_time > map_data->min_time)
> > +               stat->min_time = map_data->min_time;
> > +
> > +       return 0;
> > +}
> > +
> > +static int print_total_stats(struct syscall_data **data, int nr_data, FILE *fp)
> > +{
> > +       int printed = 0;
> > +       int nr_events = 0;
> > +
> > +       for (int i = 0; i < nr_data; i++)
> > +               nr_events += data[i]->nr_events;
> > +
> > +       printed += fprintf(fp, " total, %d events\n\n", nr_events);
> > +
> > +       printed += fprintf(fp, "   syscall            calls  errors  total       min       avg       max       stddev\n");
> > +       printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
> > +       printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
> > +
> > +       for (int i = 0; i < nr_data; i++)
> > +               printed += print_common_stats(data[i], fp);
> > +
> > +       printed += fprintf(fp, "\n\n");
> > +       return printed;
> > +}
> > +
> > +int trace_print_bpf_summary(FILE *fp)
> > +{
> > +       struct bpf_map *map = skel->maps.syscall_stats_map;
> > +       struct syscall_key *prev_key, key;
> > +       struct syscall_data **data = NULL;
> > +       struct hashmap schash;
> > +       struct hashmap_entry *entry;
> > +       int nr_data = 0;
> > +       int printed = 0;
> > +       int i;
> > +       size_t bkt;
> > +
> > +       hashmap__init(&schash, sc_node_hash, sc_node_equal, /*ctx=*/NULL);
> > +
> > +       printed = fprintf(fp, "\n Summary of events:\n\n");
> > +
> > +       /* get stats from the bpf map */
> > +       prev_key = NULL;
> > +       while (!bpf_map__get_next_key(map, prev_key, &key, sizeof(key))) {
> > +               struct syscall_stats stat;
> > +
> > +               if (!bpf_map__lookup_elem(map, &key, sizeof(key), &stat, sizeof(stat), 0)) {
> > +                       if (skel->rodata->aggr_mode == SYSCALL_AGGR_THREAD)
> > +                               update_thread_stats(&schash, &key, &stat);
> > +                       else
> > +                               update_total_stats(&schash, &key, &stat);
> > +               }
> > +
> > +               prev_key = &key;
> > +       }
> > +
> > +       nr_data = hashmap__size(&schash);
> > +       data = calloc(nr_data, sizeof(*data));
> > +       if (data == NULL)
> > +               goto out;
> > +
> > +       i = 0;
> > +       hashmap__for_each_entry(&schash, entry, bkt)
> > +               data[i++] = entry->pvalue;
> > +
> > +       qsort(data, nr_data, sizeof(*data), datacmp);
> 
> Here syscall_data is sorted for AGGR_THREAD and AGGR_CPU, meaning the
> thread who has the higher total syscall period will be printed first.
> This is an awesome side effect but it is not the behavior of 'sudo
> ./perf trace -as -- sleep 1' without the --bpf-summary option. If it
> is not too trivial, maybe consider documenting this behavior? But it
> may be too verbose so Idk.

The original behavior is random ordering and now it's ordered by total
time.  But still we can think it's randomly ordered.  I believe we need
to maintain strict ordering by total time and then fixed the existing
code.  Once that happen I can add the documentation.

Thanks for your careful review!
Namhyung

> 
> sudo ./perf trace -as -- sleep 1
> 
>  ClientModuleMan (4956), 16 events, 0.1%
> 
>    syscall            calls  errors  total       min       avg
> max       stddev
>                                      (msec)    (msec)    (msec)
> (msec)        (%)
>    --------------- --------  ------ -------- --------- ---------
> ---------     ------
>    futex                  8      4   750.234     0.000    93.779
> 250.105     48.79%
> 
> 
>  CHTTPClientThre (15720), 16 events, 0.1%
> 
>    syscall            calls  errors  total       min       avg
> max       stddev
>                                      (msec)    (msec)    (msec)
> (msec)        (%)
>    --------------- --------  ------ -------- --------- ---------
> ---------     ------
>    futex                  8      4  1000.425     0.000   125.053
> 750.317     75.59%
> 
> The order is random for the command above.
> 
> Thanks,
> Howard

