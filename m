Return-Path: <bpf+bounces-54519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BCDA6B2FF
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 03:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E24189D0C6
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 02:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44581E2614;
	Fri, 21 Mar 2025 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIejCNug"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA07208A7;
	Fri, 21 Mar 2025 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524516; cv=none; b=TjtDpQ+1bnWgAJCKVlSdKGImoBZq1UcyzSGh4aOEI0/Yjb6c9xf+Xt9fygCUFC2IGNJ77wDlOnWa7Iv4MM5InRIEfs3UmIaYBuqwy7RvXWxDYEk3mDOOGJQmxWu4YcTIC+ejJGjVqDWlI4q35xZW/yh4Zw8fucf7z7tLGj6NZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524516; c=relaxed/simple;
	bh=oHagghy2/pwm8Cyf6jd0apltjLRKTgr5nJTYDhZLMG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSi1iZbFCn0sGjVATSxSxxrYhpMMEeuwnakRznM6nQ8cy98EDA9SNVlyWHuv7mf51vKHxYj1MLsZjIM8eClE2MY4u+w10JuSFIj71s/xBJMHKiVo1kfPC94kHH1FQdrgivI8zvZUd8739rkKSmO3JwZfPYDSQqV506hWmpauNXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIejCNug; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f7031ea11cso16537097b3.2;
        Thu, 20 Mar 2025 19:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742524512; x=1743129312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIO3+oZxNc1wARDGJqFxjSosYj/vgSipW8/EbabkP4A=;
        b=nIejCNug5rJekWNvj3s7QOUJYM2MBYCM2gLhboRkiYWnG4bEcKgsDQyGwaefjFTkLW
         E8Syla/x05p8K5F8f+sIpgr6r91IovZtxKdFcQe2yas/DzPhAvOIjogu/F3lCTi3evXO
         q+kPFADpOt1FpJAsAWQ9kiRyauyNSPmdRYaR7CUNwZkNXI/z/4qCgaTbYyZ/CkAqxg/B
         Yd6UDTD++JGJHfgLRiGfxJvUq27bLf+LtsFpakgy+xl9RXIdc0kMmCQblh2LKFgHz77M
         Wvh802sAjDwcP4bSjBHuyaDIfyXQd0Ec+VCcQ3wkvNCe0WkvWlodeiXEq22t22sqWZ7X
         FzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742524512; x=1743129312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIO3+oZxNc1wARDGJqFxjSosYj/vgSipW8/EbabkP4A=;
        b=p+7jz01GESVmVkrbWdqXElOQVJ3q4K3GJqDTdbbQwaTIpc5lBqtJgZbXBibNT+4GVh
         OGZwYdcg9rDzX9p5WQwV52mEIAFIBimhxFh8Gi3UjzBThAOFqIQLnWzBFVzEuMAHejD9
         +k1urZmt2zNoPIgOgdco9KNEz+VvPgaO19Ssej80iuga+F1UABWODzENZERNWrGGQpAD
         Pgsph+Xpu1D3ZnHH1JOpLbQDR+++okKEYRAbtgfrbhYzTcEmX/hMUy5wbBA6DpEXSZSv
         UJF2RULhi5/79MNGOseqVGtDWVRGjLI2pmFtuK7amWJHuxdOvr9lVnjN2m9q+HO19RN2
         EZsA==
X-Forwarded-Encrypted: i=1; AJvYcCUBI1kGxWlX9hGhfGsh+tIWUqw31tV1WriYaRAcC22pVDZP1iZrt+8nGn9TOo1pwmcbqQKi1VZYSOEt4CoT@vger.kernel.org, AJvYcCUbxmV9cNybD7mF37kOT93fUreGQ1ycy2QacRrugH/Pt5LzIL+aYhbRgeE+48bMZ+XIntc=@vger.kernel.org, AJvYcCXJqXJdBwl2u9hCaDJ16IHDi8ZpnNH+kDEXKg02W9xob+ia9BD23eTM9kNbxZI8pS2QmrpRt9bzKCb87uAfgi3zog==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKUHZuUsuCLksXzfGt+r9mlBYqgey/7KlwxG3A4A1w2RSXgivZ
	wQNoIVzh2nL6JdfLLgi20DFRNSIyQx4rUUBngXVWOp5ABMCCACmgaAfLGE6d729Ga8gk7odKALL
	o3OAfxiACLjV/KEluc6IYYa4dN8Y=
X-Gm-Gg: ASbGncusn9Rc8ZQqBieiyUVQdSRD2pkp2PtMNPi6ychUjQ4UQOGG+c8JTkaplUGK3ok
	6TAGTCLY121dcxpLI1h/dqWhBgklye5oYiBw5IAGIKK560S8ZIMr1mFaUmgSNlf2fHDKMByLbNo
	SnXhIqNTxQw0+q2ye3BYrxIoHtN4hmW0Zz9kJ7dA==
X-Google-Smtp-Source: AGHT+IHWGvEVBBp3TZosyEjSm7Lk9SlaY8jV4A2Tup8xNehmCrHGqSuaKwjYEV/uwqPIVxQno8vi4z+iTi8uBMOAdNQ=
X-Received: by 2002:a05:690c:498e:b0:6fb:33e1:2e66 with SMTP id
 00721157ae682-700bac63784mr22019577b3.14.1742524511951; Thu, 20 Mar 2025
 19:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317180834.1862079-1-namhyung@kernel.org>
In-Reply-To: <20250317180834.1862079-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 20 Mar 2025 19:35:01 -0700
X-Gm-Features: AQ5f1JoZphdio9VwjeRwoyhs41tTXrx0Mhg-l-hNUaHpli34QRvGiMvbK5ui74U
Message-ID: <CAH0uvojj=-BE93VeuxK1LWEEBkYXT_BsRAf17gb-34jFRwnDww@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Implement syscall summary in BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello again Namhyung,

As funny as it sounds, I have too much homework this week. I had to
break the review into two parts. Sorry.

1) Maybe just '--bpf-summary' instead?

First of all, is '-s --bpf-summary' is it ergonomic? Why not drop the
-s and just --bpf-summary since the option has 'summary' in its name.
Another reason being,
sudo ./perf trace -S --bpf-summary --summary-mode=3Dtotal -- sleep 1
sudo ./perf trace -s --bpf-summary --summary-mode=3Dtotal -- sleep 1
are the same (-S will emit no output to stdout).

2) Anomaly observed when playing around

sudo ./perf trace -s --bpf-summary --summary-mode=3Dtotal -- sleep 1
this gave me 10000 events

sudo ./perf trace -as --bpf-summary --summary-mode=3Dtotal -- sleep 1
while this gave me 1000 events

I guess it's something to do with the lost events?

3) Wrong stddev values
Please compare these two outputs

perf $ sudo ./perf trace -as --summary-mode=3Dtotal -- sleep 1

 Summary of events:

 total, 11290 events

   syscall            calls  errors  total       min       avg
max       stddev
                                     (msec)    (msec)    (msec)
(msec)        (%)
   --------------- --------  ------ -------- --------- ---------
---------     ------
   mq_open              214     71 16073.976     0.000    75.112
250.120      9.91%
   futex               1296    195 11592.060     0.000     8.944
907.590     13.59%
   epoll_wait           479      0  4262.456     0.000     8.899
496.568     20.34%
   poll                 241      0  2545.090     0.000    10.561
607.894     33.33%
   ppoll                330      0  1713.676     0.000     5.193
410.143     26.45%
   migrate_pages         45      0  1031.915     0.000    22.931
147.830     20.70%
   clock_nanosleep        2      0  1000.106     0.000   500.053
1000.106    100.00%
   swapoff              340      0   909.827     0.000     2.676
50.117     22.76%
   pselect6               5      0   604.816     0.000   120.963
604.808    100.00%
   readlinkat            26      3   501.205     0.000    19.277
499.998     99.75%

perf $ sudo ./perf trace -as --bpf-summary --summary-mode=3Dtotal -- sleep =
1

 Summary of events:

 total, 880 events

   syscall            calls  errors  total       min       avg
max       stddev
                                     (msec)    (msec)    (msec)
(msec)        (%)
   --------------- --------  ------ -------- --------- ---------
---------     ------
   futex                219     46  2326.400     0.001    10.623
243.028    337.77%
   mq_open               19      8  2001.347     0.003   105.334
250.356    117.26%
   poll                   6      1  1002.512     0.002   167.085
1002.496    223.60%
   clock_nanosleep        1      0  1000.147  1000.147  1000.147
1000.147      0.00%
   swapoff               43      0   953.251     0.001    22.169
50.390    112.37%
   migrate_pages         43      0   933.727     0.004    21.715
49.149    106.68%
   ppoll                 32      0   838.035     0.002    26.189
331.222    252.10%
   epoll_pwait            5      0   499.578     0.001    99.916
499.565    199.99%
   nanosleep              1      0    10.149    10.149    10.149
10.149      0.00%
   epoll_wait            10      0     3.449     0.003     0.345
0.815     88.02%
   readlinkat            25      3     1.424     0.006     0.057
0.080     41.76%
   recvmsg               61      0     1.326     0.016     0.022
0.052     21.71%
   execve                 6      5     1.100     0.002     0.183
1.078    218.21%

I would say stddev here is a little off. The reason is:

On Mon, Mar 17, 2025 at 11:08=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> When -s/--summary option is used, it doesn't need (augmented) arguments
> of syscalls.  Let's skip the augmentation and load another small BPF
> program to collect the statistics in the kernel instead of copying the
> data to the ring-buffer to calculate the stats in userspace.  This will
> be much more light-weight than the existing approach and remove any lost
> events.
>
> Let's add a new option --bpf-summary to control this behavior.  I cannot
> make it default because there's no way to get e_machine in the BPF which
> is needed for detecting different ABIs like 32-bit compat mode.
>
> No functional changes intended except for no more LOST events. :)
>
>   $ sudo perf trace -as --bpf-summary --summary-mode=3Dtotal -- sleep 1
>
>    Summary of events:
>
>    total, 2824 events
>
>      syscall            calls  errors  total       min       avg       ma=
x       stddev
>                                        (msec)    (msec)    (msec)    (mse=
c)        (%)
>      --------------- --------  ------ -------- --------- --------- ------=
---     ------
>      futex                372     18  4373.773     0.000    11.757   997.=
715    660.42%
>      poll                 241      0  2757.963     0.000    11.444   997.=
758    580.34%
>      epoll_wait           161      0  2460.854     0.000    15.285   325.=
189    260.73%
>      ppoll                 19      0  1298.652     0.000    68.350   667.=
172    281.46%
>      clock_nanosleep        1      0  1000.093     0.000  1000.093  1000.=
093      0.00%
>      epoll_pwait           16      0   192.787     0.000    12.049   173.=
994    348.73%
>      nanosleep              6      0    50.926     0.000     8.488    10.=
210     43.96%
>      ...
>
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2)
>  * rebased on top of Ian's e_machine changes
>  * add --bpf-summary option
>  * support per-thread summary
>  * add stddev calculation  (Howard)
<SNIP>
> +static double rel_stddev(struct syscall_stats *stat)
> +{
> +       double variance, average;
> +
> +       if (stat->count < 2)
> +               return 0;
> +
> +       average =3D (double)stat->total_time / stat->count;
> +
> +       variance =3D stat->squared_sum;
> +       variance -=3D (stat->total_time * stat->total_time) / stat->count=
;
> +       variance /=3D stat->count;

isn't it 'variance /=3D stat->count - 1' because we used Bessel's
correction? (Link:
https://en.wikipedia.org/wiki/Bessel%27s_correction), that is to use n
- 1 instead of n, this is what's done in stat.c.

 *       (\Sum n_i^2) - ((\Sum n_i)^2)/n
 * s^2 =3D -------------------------------
 *                  n - 1

and the lines down here are unfortunately incorrect
+ variance =3D stat->squared_sum;
+ variance -=3D (stat->total_time * stat->total_time) / stat->count;
+ variance /=3D stat->count;
+
+ return 100 * sqrt(variance) / average;

variance /=3D stat->count - 1; will get you variance, but I think we
need variance mean.
Link: https://en.wikipedia.org/wiki/Standard_deviation#Relationship_between=
_standard_deviation_and_mean

it holds that:
variance(mean) =3D variance / N

so you are losing a '/ stat->count'

And with all due respect, although it makes total sense in
engineering, mathematically, I find variance =3D stat->squared_sum,
variance -=3D ... these accumulated calculations on variable 'variance'
a little weird... because readers may find difficult to determine at
which point it becomes the actual 'variance'

with clarity in mind:

diff --git a/tools/perf/util/bpf-trace-summary.c
b/tools/perf/util/bpf-trace-summary.c
index 5ae9feca244d..a435b4037082 100644
--- a/tools/perf/util/bpf-trace-summary.c
+++ b/tools/perf/util/bpf-trace-summary.c
@@ -62,18 +62,18 @@ struct syscall_node {

 static double rel_stddev(struct syscall_stats *stat)
 {
-       double variance, average;
+       double variance, average, squared_total;

        if (stat->count < 2)
                return 0;

        average =3D (double)stat->total_time / stat->count;

-       variance =3D stat->squared_sum;
-       variance -=3D (stat->total_time * stat->total_time) / stat->count;
-       variance /=3D stat->count;
+       squared_total =3D stat->total_time * stat->total_time;
+       variance =3D (stat->squared_sum - squared_total / stat->count) /
(stat->count - 1);
+       stddev_mean =3D sqrt(variance / stat->count);

-       return 100 * sqrt(variance) / average;
+       return 100 * stddev_mean / average;
 }

btw I haven't checked the legal range for stddev_mean, so I can be wrong.
<SNIP>
> +static int update_total_stats(struct hashmap *hash, struct syscall_key *=
map_key,
> +                             struct syscall_stats *map_data)
> +{
> +       struct syscall_data *data;
> +       struct syscall_stats *stat;
> +
> +       if (!hashmap__find(hash, map_key, &data)) {
> +               data =3D zalloc(sizeof(*data));
> +               if (data =3D=3D NULL)
> +                       return -ENOMEM;
> +
> +               data->nodes =3D zalloc(sizeof(*data->nodes));
> +               if (data->nodes =3D=3D NULL) {
> +                       free(data);
> +                       return -ENOMEM;
> +               }
> +
> +               data->nr_nodes =3D 1;
> +               data->key =3D map_key->nr;
> +               data->nodes->syscall_nr =3D data->key;
Wow, aggressive. I guess you want it to behave like a single value
when it is SYSCALL_AGGR_CPU, and an array when it is
SYSCALL_AGGR_THREAD. Do you mind adding a comment about it?

so it's

(cpu, syscall_nr) -> data -> {node}
(tid, syscall_nr) -> data -> [node1, node2, node3]


> +
> +               if (hashmap__add(hash, data->key, data) < 0) {
> +                       free(data->nodes);
> +                       free(data);
> +                       return -ENOMEM;
> +               }
> +       }
> +
> +       /* update total stats for this syscall */
> +       data->nr_events +=3D map_data->count;
> +       data->total_time +=3D map_data->total_time;
> +
> +       /* This is sum of the same syscall from different CPUs */
> +       stat =3D &data->nodes->stats;
> +
> +       stat->total_time +=3D map_data->total_time;
> +       stat->squared_sum +=3D map_data->squared_sum;
> +       stat->count +=3D map_data->count;
> +       stat->error +=3D map_data->error;
> +
> +       if (stat->max_time < map_data->max_time)
> +               stat->max_time =3D map_data->max_time;
> +       if (stat->min_time > map_data->min_time)
> +               stat->min_time =3D map_data->min_time;
> +
> +       return 0;
> +}
> +
> +static int print_total_stats(struct syscall_data **data, int nr_data, FI=
LE *fp)
> +{
> +       int printed =3D 0;
> +       int nr_events =3D 0;
> +
> +       for (int i =3D 0; i < nr_data; i++)
> +               nr_events +=3D data[i]->nr_events;
> +
> +       printed +=3D fprintf(fp, " total, %d events\n\n", nr_events);
> +
> +       printed +=3D fprintf(fp, "   syscall            calls  errors  to=
tal       min       avg       max       stddev\n");
> +       printed +=3D fprintf(fp, "                                     (m=
sec)    (msec)    (msec)    (msec)        (%%)\n");
> +       printed +=3D fprintf(fp, "   --------------- --------  ------ ---=
----- --------- --------- ---------     ------\n");
> +
> +       for (int i =3D 0; i < nr_data; i++)
> +               printed +=3D print_common_stats(data[i], fp);
> +
> +       printed +=3D fprintf(fp, "\n\n");
> +       return printed;
> +}
> +
> +int trace_print_bpf_summary(FILE *fp)
> +{
> +       struct bpf_map *map =3D skel->maps.syscall_stats_map;
> +       struct syscall_key *prev_key, key;
> +       struct syscall_data **data =3D NULL;
> +       struct hashmap schash;
> +       struct hashmap_entry *entry;
> +       int nr_data =3D 0;
> +       int printed =3D 0;
> +       int i;
> +       size_t bkt;
> +
> +       hashmap__init(&schash, sc_node_hash, sc_node_equal, /*ctx=3D*/NUL=
L);
> +
> +       printed =3D fprintf(fp, "\n Summary of events:\n\n");
> +
> +       /* get stats from the bpf map */
> +       prev_key =3D NULL;
> +       while (!bpf_map__get_next_key(map, prev_key, &key, sizeof(key))) =
{
> +               struct syscall_stats stat;
> +
> +               if (!bpf_map__lookup_elem(map, &key, sizeof(key), &stat, =
sizeof(stat), 0)) {
> +                       if (skel->rodata->aggr_mode =3D=3D SYSCALL_AGGR_T=
HREAD)
> +                               update_thread_stats(&schash, &key, &stat)=
;
> +                       else
> +                               update_total_stats(&schash, &key, &stat);
> +               }
> +
> +               prev_key =3D &key;
> +       }
> +
> +       nr_data =3D hashmap__size(&schash);
> +       data =3D calloc(nr_data, sizeof(*data));
> +       if (data =3D=3D NULL)
> +               goto out;
> +
> +       i =3D 0;
> +       hashmap__for_each_entry(&schash, entry, bkt)
> +               data[i++] =3D entry->pvalue;
> +
> +       qsort(data, nr_data, sizeof(*data), datacmp);

Here syscall_data is sorted for AGGR_THREAD and AGGR_CPU, meaning the
thread who has the higher total syscall period will be printed first.
This is an awesome side effect but it is not the behavior of 'sudo
./perf trace -as -- sleep 1' without the --bpf-summary option. If it
is not too trivial, maybe consider documenting this behavior? But it
may be too verbose so Idk.

sudo ./perf trace -as -- sleep 1

 ClientModuleMan (4956), 16 events, 0.1%

   syscall            calls  errors  total       min       avg
max       stddev
                                     (msec)    (msec)    (msec)
(msec)        (%)
   --------------- --------  ------ -------- --------- ---------
---------     ------
   futex                  8      4   750.234     0.000    93.779
250.105     48.79%


 CHTTPClientThre (15720), 16 events, 0.1%

   syscall            calls  errors  total       min       avg
max       stddev
                                     (msec)    (msec)    (msec)
(msec)        (%)
   --------------- --------  ------ -------- --------- ---------
---------     ------
   futex                  8      4  1000.425     0.000   125.053
750.317     75.59%

The order is random for the command above.

Thanks,
Howard

