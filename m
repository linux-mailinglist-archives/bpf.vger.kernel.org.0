Return-Path: <bpf+bounces-54551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB92A6C124
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 18:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F3917AE35
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 17:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEE122D7B2;
	Fri, 21 Mar 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6EwUz+6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391922D7A5;
	Fri, 21 Mar 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577600; cv=none; b=KbjXOA/ThDXm7LlsRqPvcoooX7T7cdnC6KTlgaWr7cBEtg8xTYn/w2IXyOxyCRaKKlzzfIoCxVOMe4Whgj4ZUuu4xR2MFJW8VTl8JMHjQoU/TFb6/U1xR4dVN/aHPz1lxkCgYr5USXNFJxN87uEUUpmFoOS7Q2lR1hJX8XEcGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577600; c=relaxed/simple;
	bh=M8zaBe2BkS1KJbuaAXImoHMI27auLNrjup3v7dsDsRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGcU7OIq9hmDB2wy2g1JQIOf/L/N5zzYKx1K1fo1CCg/cXK38dGrOHPWKgb0qgrduIDv0cO776r87TASxmVzz1Df8erLrBXOfYuF8Fr+p/2whJ8kqzB7ooijIY9iAfMn482ych7MIUlgwWyoR3a7tVhaJMEfaTmFLYOYVrW6rEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6EwUz+6; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so2077516276.0;
        Fri, 21 Mar 2025 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742577597; x=1743182397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK2VLtBzvHxkdfj0PLqV8wQFMsjTofmM3uthc6W8ZtI=;
        b=G6EwUz+66BXBZoFdjhEhd+iugllaGUKlOGzpEbM16QaB9ggMbm6IchoMm0SS7suQH3
         6MNBPAgY11m6DEJCB5AUROiD33yiwkU5OZxP+5sT7mL91dqUTBWQ9/b9a/N971Oppz03
         lDFosULrtTXm3wtOuZ2V20dXLYHlYgXzJMaUnOgWxF0Ujh0+X4CJaul3C38HFJQWx26q
         4PiskcdKSYdSStg0mOGP2Yvu8rv8Y9UKRjx7Egd3bauBq4D88mGhEw0eMiJrUq0n5D+u
         hV/irgAyiPLiK+NA+iS7pDoGPVXR9ltshlhlF0lC9+4eao0DQ75p3YrhgA3Ibpm98nHy
         Lh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577597; x=1743182397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XK2VLtBzvHxkdfj0PLqV8wQFMsjTofmM3uthc6W8ZtI=;
        b=d37yd+KLz0NWgbw3LhmBGhBpFpFPo/Y9jrx/eYDWlXtygoNMC1WgOjbc20pkc4hZZ5
         eSSJrbrma0WSYIKhTR17sTErFZXBlEUvWGugsJpLhgc34y94aW084S3gMh1OF/1RzbdQ
         n3f7bxH3K07x41FarfmEPJFnQnUfcfJ0m3gEz9QRGfMOBp/NK+KAKTtFG4PssUX9m/pi
         jYfGZpLHFCXoBHipmOyIIsKeVn3bCsTNtsMgG0rQ9p0ClJp+4x8gPFOQplXR5kzPUmX5
         OdmjKK3dPGWMZc3QuwvYK2kJk775evyamNvm8bXHEeIwv6d5kwAyqwmT+gM2mlxfodqw
         u0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWr0OIe4NOggDQA0Xtwp4kJPw1RjCAiKZZlTJcQLOuyoukIcErXs68zrWBHKPPLkJEwpoKFcjGQKHP+QxIgsAEEIQ==@vger.kernel.org, AJvYcCX7Zds1S7E7H9g5CP4+0KstYmRgxG3TfcnqZWzxZ1xK1jK8/Zz/rs9S0H1hGuWq7e82sjw=@vger.kernel.org, AJvYcCXMoPUl07O6OgzHE1ak3FZFZ+XtHLeRJaIDDt9JScVfeSxo9MGnZGELN/Jq7IryN+uYixqst+pt9OsNZH6q@vger.kernel.org
X-Gm-Message-State: AOJu0YwAMVrxk5c9UpdEfSUOM5q8dcjx7hscFUmrgnOs8Kso5jNee37I
	nsxc9geESrgCV4iY0roCrqGj5d7vWB/xMZRMlBjG1J8ocS4ZziP7jqUj+Q0rV4LXGVfQR8xKVzo
	e5gJ9bUskeXs7oyKd7o+IQP1J9bc=
X-Gm-Gg: ASbGncsL4PuQ18gNVRoYZ9GoBUlw/GTalvE7i8/xj3HT1FHogvmsl3SkEfkXM6fY9aj
	vYo2iYSoO9dfA4xflII4Y5YUE9X8gXPPc3LUMEP+W9j6nRp2sONvfUVJopFY6fsTdkSlcWaYXYm
	7V7EMxVJSzydbalie760VX1MOx
X-Google-Smtp-Source: AGHT+IGMH+OMYBegCxh8SLcFdXeVEjYBIeTmoXniuKRC1kWPRQTtzt1NCjGJRONNDX/PQ0DGStFebXVO9FOrwPeMr0k=
X-Received: by 2002:a25:d813:0:b0:e63:3e25:d71a with SMTP id
 3f1490d57ef6-e6690e98667mr7899768276.15.1742577597086; Fri, 21 Mar 2025
 10:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317180834.1862079-1-namhyung@kernel.org> <CAH0uvojj=-BE93VeuxK1LWEEBkYXT_BsRAf17gb-34jFRwnDww@mail.gmail.com>
 <Z9z-_ftY23KcZ6c1@google.com>
In-Reply-To: <Z9z-_ftY23KcZ6c1@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 21 Mar 2025 10:19:46 -0700
X-Gm-Features: AQ5f1JoulzWw8qBFbIJdNfIO2QGgwoPpYr1Scr-2wN17HctwSGyhrbtb50d4Sng
Message-ID: <CAH0uvogCWPp8n68iCWOWc8xcv+ZSOMEjRVUvYt4ntF2Q5+Tapg@mail.gmail.com>
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

Hello Namhyung,

On Thu, Mar 20, 2025 at 10:54=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Mar 20, 2025 at 07:35:01PM -0700, Howard Chu wrote:
> > Hello again Namhyung,
> >
> > As funny as it sounds, I have too much homework this week. I had to
> > break the review into two parts. Sorry.
>
> Thanks for taking your time!
>
> >
> > 1) Maybe just '--bpf-summary' instead?
> >
> > First of all, is '-s --bpf-summary' is it ergonomic? Why not drop the
> > -s and just --bpf-summary since the option has 'summary' in its name.
> > Another reason being,
> > sudo ./perf trace -S --bpf-summary --summary-mode=3Dtotal -- sleep 1
> > sudo ./perf trace -s --bpf-summary --summary-mode=3Dtotal -- sleep 1
> > are the same (-S will emit no output to stdout).
>
> Hmm.. it looks like a bug, will take a look.  Maybe --bpf-summary is
> redundant, but I think we can make it default later so that -s/-S can
> use BPF without the option excplicitly.  Then this option can be used
> to disable it (--no-bpf-summary) for whatever reasons.
>
> >
> > 2) Anomaly observed when playing around
> >
> > sudo ./perf trace -s --bpf-summary --summary-mode=3Dtotal -- sleep 1
> > this gave me 10000 events
> >
> > sudo ./perf trace -as --bpf-summary --summary-mode=3Dtotal -- sleep 1
> > while this gave me 1000 events
> >
> > I guess it's something to do with the lost events?
>
> No, as you said in the previous message it didn't support process
> targets yet.  I plan to disable it without -a for now.

I copied the wrong command in the email, it should be:

there is a difference between

sudo ./perf trace -as --summary-mode=3Dtotal -- sleep 1
sudo ./perf trace -as --bpf-summary --summary-mode=3Dtotal -- sleep 1

perf $ sudo ./perf trace -as --summary-mode=3Dtotal -- sleep 1
[sudo] password for howard:

 Summary of events:

 total, 15354 events

perf $ sudo ./perf trace -as --bpf-summary --summary-mode=3Dtotal -- sleep =
1


 Summary of events:

 total, 1319 events


without the --bpf-summary perf trace gave more events, and it ran slower

as for 'I plan to disable it without -a for now.' I think this makes sense.

>
> >
> > 3) Wrong stddev values
> > Please compare these two outputs
> >
> > perf $ sudo ./perf trace -as --summary-mode=3Dtotal -- sleep 1
> >
> >  Summary of events:
> >
> >  total, 11290 events
> >
> >    syscall            calls  errors  total       min       avg
> > max       stddev
> >                                      (msec)    (msec)    (msec)
> > (msec)        (%)
> >    --------------- --------  ------ -------- --------- ---------
> > ---------     ------
> >    mq_open              214     71 16073.976     0.000    75.112
> > 250.120      9.91%
> >    futex               1296    195 11592.060     0.000     8.944
> > 907.590     13.59%
> >    epoll_wait           479      0  4262.456     0.000     8.899
> > 496.568     20.34%
> >    poll                 241      0  2545.090     0.000    10.561
> > 607.894     33.33%
> >    ppoll                330      0  1713.676     0.000     5.193
> > 410.143     26.45%
> >    migrate_pages         45      0  1031.915     0.000    22.931
> > 147.830     20.70%
> >    clock_nanosleep        2      0  1000.106     0.000   500.053
> > 1000.106    100.00%
> >    swapoff              340      0   909.827     0.000     2.676
> > 50.117     22.76%
> >    pselect6               5      0   604.816     0.000   120.963
> > 604.808    100.00%
> >    readlinkat            26      3   501.205     0.000    19.277
> > 499.998     99.75%
> >
> > perf $ sudo ./perf trace -as --bpf-summary --summary-mode=3Dtotal -- sl=
eep 1
> >
> >  Summary of events:
> >
> >  total, 880 events
> >
> >    syscall            calls  errors  total       min       avg
> > max       stddev
> >                                      (msec)    (msec)    (msec)
> > (msec)        (%)
> >    --------------- --------  ------ -------- --------- ---------
> > ---------     ------
> >    futex                219     46  2326.400     0.001    10.623
> > 243.028    337.77%
> >    mq_open               19      8  2001.347     0.003   105.334
> > 250.356    117.26%
> >    poll                   6      1  1002.512     0.002   167.085
> > 1002.496    223.60%
> >    clock_nanosleep        1      0  1000.147  1000.147  1000.147
> > 1000.147      0.00%
> >    swapoff               43      0   953.251     0.001    22.169
> > 50.390    112.37%
> >    migrate_pages         43      0   933.727     0.004    21.715
> > 49.149    106.68%
> >    ppoll                 32      0   838.035     0.002    26.189
> > 331.222    252.10%
> >    epoll_pwait            5      0   499.578     0.001    99.916
> > 499.565    199.99%
> >    nanosleep              1      0    10.149    10.149    10.149
> > 10.149      0.00%
> >    epoll_wait            10      0     3.449     0.003     0.345
> > 0.815     88.02%
> >    readlinkat            25      3     1.424     0.006     0.057
> > 0.080     41.76%
> >    recvmsg               61      0     1.326     0.016     0.022
> > 0.052     21.71%
> >    execve                 6      5     1.100     0.002     0.183
> > 1.078    218.21%
> >
> > I would say stddev here is a little off. The reason is:
> >
> > On Mon, Mar 17, 2025 at 11:08=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > When -s/--summary option is used, it doesn't need (augmented) argumen=
ts
> > > of syscalls.  Let's skip the augmentation and load another small BPF
> > > program to collect the statistics in the kernel instead of copying th=
e
> > > data to the ring-buffer to calculate the stats in userspace.  This wi=
ll
> > > be much more light-weight than the existing approach and remove any l=
ost
> > > events.
> > >
> > > Let's add a new option --bpf-summary to control this behavior.  I can=
not
> > > make it default because there's no way to get e_machine in the BPF wh=
ich
> > > is needed for detecting different ABIs like 32-bit compat mode.
> > >
> > > No functional changes intended except for no more LOST events. :)
> > >
> > >   $ sudo perf trace -as --bpf-summary --summary-mode=3Dtotal -- sleep=
 1
> > >
> > >    Summary of events:
> > >
> > >    total, 2824 events
> > >
> > >      syscall            calls  errors  total       min       avg     =
  max       stddev
> > >                                        (msec)    (msec)    (msec)    =
(msec)        (%)
> > >      --------------- --------  ------ -------- --------- --------- --=
-------     ------
> > >      futex                372     18  4373.773     0.000    11.757   =
997.715    660.42%
> > >      poll                 241      0  2757.963     0.000    11.444   =
997.758    580.34%
> > >      epoll_wait           161      0  2460.854     0.000    15.285   =
325.189    260.73%
> > >      ppoll                 19      0  1298.652     0.000    68.350   =
667.172    281.46%
> > >      clock_nanosleep        1      0  1000.093     0.000  1000.093  1=
000.093      0.00%
> > >      epoll_pwait           16      0   192.787     0.000    12.049   =
173.994    348.73%
> > >      nanosleep              6      0    50.926     0.000     8.488   =
 10.210     43.96%
> > >      ...
> > >
> > > Cc: Howard Chu <howardchu95@gmail.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > > v2)
> > >  * rebased on top of Ian's e_machine changes
> > >  * add --bpf-summary option
> > >  * support per-thread summary
> > >  * add stddev calculation  (Howard)
> > <SNIP>
> > > +static double rel_stddev(struct syscall_stats *stat)
> > > +{
> > > +       double variance, average;
> > > +
> > > +       if (stat->count < 2)
> > > +               return 0;
> > > +
> > > +       average =3D (double)stat->total_time / stat->count;
> > > +
> > > +       variance =3D stat->squared_sum;
> > > +       variance -=3D (stat->total_time * stat->total_time) / stat->c=
ount;
> > > +       variance /=3D stat->count;
> >
> > isn't it 'variance /=3D stat->count - 1' because we used Bessel's
> > correction? (Link:
> > https://en.wikipedia.org/wiki/Bessel%27s_correction), that is to use n
> > - 1 instead of n, this is what's done in stat.c.
> >
> >  *       (\Sum n_i^2) - ((\Sum n_i)^2)/n
> >  * s^2 =3D -------------------------------
> >  *                  n - 1
> >
> > and the lines down here are unfortunately incorrect
> > + variance =3D stat->squared_sum;
> > + variance -=3D (stat->total_time * stat->total_time) / stat->count;
> > + variance /=3D stat->count;
> > +
> > + return 100 * sqrt(variance) / average;
> >
> > variance /=3D stat->count - 1; will get you variance, but I think we
> > need variance mean.
> > Link: https://en.wikipedia.org/wiki/Standard_deviation#Relationship_bet=
ween_standard_deviation_and_mean
> >
> > it holds that:
> > variance(mean) =3D variance / N
> >
> > so you are losing a '/ stat->count'
>
> You're right, thanks for pointing that out.
>
> >
> > And with all due respect, although it makes total sense in
> > engineering, mathematically, I find variance =3D stat->squared_sum,
> > variance -=3D ... these accumulated calculations on variable 'variance'
> > a little weird... because readers may find difficult to determine at
> > which point it becomes the actual 'variance'
> >
> > with clarity in mind:
> >
> > diff --git a/tools/perf/util/bpf-trace-summary.c
> > b/tools/perf/util/bpf-trace-summary.c
> > index 5ae9feca244d..a435b4037082 100644
> > --- a/tools/perf/util/bpf-trace-summary.c
> > +++ b/tools/perf/util/bpf-trace-summary.c
> > @@ -62,18 +62,18 @@ struct syscall_node {
> >
> >  static double rel_stddev(struct syscall_stats *stat)
> >  {
> > -       double variance, average;
> > +       double variance, average, squared_total;
> >
> >         if (stat->count < 2)
> >                 return 0;
> >
> >         average =3D (double)stat->total_time / stat->count;
> >
> > -       variance =3D stat->squared_sum;
> > -       variance -=3D (stat->total_time * stat->total_time) / stat->cou=
nt;
> > -       variance /=3D stat->count;
> > +       squared_total =3D stat->total_time * stat->total_time;
> > +       variance =3D (stat->squared_sum - squared_total / stat->count) =
/
> > (stat->count - 1);
> > +       stddev_mean =3D sqrt(variance / stat->count);
> >
> > -       return 100 * sqrt(variance) / average;
> > +       return 100 * stddev_mean / average;
> >  }
>
> Can it be like this?
>
> diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-tr=
ace-summary.c
> index a91d42447e850a59..c897fb017914960c 100644
> --- a/tools/perf/util/bpf-trace-summary.c
> +++ b/tools/perf/util/bpf-trace-summary.c
> @@ -71,9 +71,9 @@ static double rel_stddev(struct syscall_stats *stat)
>
>         variance =3D stat->squared_sum;
>         variance -=3D (stat->total_time * stat->total_time) / stat->count=
;
> -       variance /=3D stat->count;
> +       variance /=3D stat->count - 1;
>
> -       return 100 * sqrt(variance) / average;
> +       return 100 * sqrt(variance / stat->count) / average;
>  }

Of course. Then the variable 'variance' would mean 'variance of mean'.

>
>  struct syscall_data {
>
> >
> > btw I haven't checked the legal range for stddev_mean, so I can be wron=
g.
> > <SNIP>
> > > +static int update_total_stats(struct hashmap *hash, struct syscall_k=
ey *map_key,
> > > +                             struct syscall_stats *map_data)
> > > +{
> > > +       struct syscall_data *data;
> > > +       struct syscall_stats *stat;
> > > +
> > > +       if (!hashmap__find(hash, map_key, &data)) {
> > > +               data =3D zalloc(sizeof(*data));
> > > +               if (data =3D=3D NULL)
> > > +                       return -ENOMEM;
> > > +
> > > +               data->nodes =3D zalloc(sizeof(*data->nodes));
> > > +               if (data->nodes =3D=3D NULL) {
> > > +                       free(data);
> > > +                       return -ENOMEM;
> > > +               }
> > > +
> > > +               data->nr_nodes =3D 1;
> > > +               data->key =3D map_key->nr;
> > > +               data->nodes->syscall_nr =3D data->key;
> > Wow, aggressive. I guess you want it to behave like a single value
> > when it is SYSCALL_AGGR_CPU, and an array when it is
> > SYSCALL_AGGR_THREAD. Do you mind adding a comment about it?
> >
> > so it's
> >
> > (cpu, syscall_nr) -> data -> {node}
> > (tid, syscall_nr) -> data -> [node1, node2, node3]
>
> Right, will add comments.
>
> >
> >
> > > +
> > > +               if (hashmap__add(hash, data->key, data) < 0) {
> > > +                       free(data->nodes);
> > > +                       free(data);
> > > +                       return -ENOMEM;
> > > +               }
> > > +       }
> > > +
> > > +       /* update total stats for this syscall */
> > > +       data->nr_events +=3D map_data->count;
> > > +       data->total_time +=3D map_data->total_time;
> > > +
> > > +       /* This is sum of the same syscall from different CPUs */
> > > +       stat =3D &data->nodes->stats;
> > > +
> > > +       stat->total_time +=3D map_data->total_time;
> > > +       stat->squared_sum +=3D map_data->squared_sum;
> > > +       stat->count +=3D map_data->count;
> > > +       stat->error +=3D map_data->error;
> > > +
> > > +       if (stat->max_time < map_data->max_time)
> > > +               stat->max_time =3D map_data->max_time;
> > > +       if (stat->min_time > map_data->min_time)
> > > +               stat->min_time =3D map_data->min_time;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int print_total_stats(struct syscall_data **data, int nr_data=
, FILE *fp)
> > > +{
> > > +       int printed =3D 0;
> > > +       int nr_events =3D 0;
> > > +
> > > +       for (int i =3D 0; i < nr_data; i++)
> > > +               nr_events +=3D data[i]->nr_events;
> > > +
> > > +       printed +=3D fprintf(fp, " total, %d events\n\n", nr_events);
> > > +
> > > +       printed +=3D fprintf(fp, "   syscall            calls  errors=
  total       min       avg       max       stddev\n");
> > > +       printed +=3D fprintf(fp, "                                   =
  (msec)    (msec)    (msec)    (msec)        (%%)\n");
> > > +       printed +=3D fprintf(fp, "   --------------- --------  ------=
 -------- --------- --------- ---------     ------\n");
> > > +
> > > +       for (int i =3D 0; i < nr_data; i++)
> > > +               printed +=3D print_common_stats(data[i], fp);
> > > +
> > > +       printed +=3D fprintf(fp, "\n\n");
> > > +       return printed;
> > > +}
> > > +
> > > +int trace_print_bpf_summary(FILE *fp)
> > > +{
> > > +       struct bpf_map *map =3D skel->maps.syscall_stats_map;
> > > +       struct syscall_key *prev_key, key;
> > > +       struct syscall_data **data =3D NULL;
> > > +       struct hashmap schash;
> > > +       struct hashmap_entry *entry;
> > > +       int nr_data =3D 0;
> > > +       int printed =3D 0;
> > > +       int i;
> > > +       size_t bkt;
> > > +
> > > +       hashmap__init(&schash, sc_node_hash, sc_node_equal, /*ctx=3D*=
/NULL);
> > > +
> > > +       printed =3D fprintf(fp, "\n Summary of events:\n\n");
> > > +
> > > +       /* get stats from the bpf map */
> > > +       prev_key =3D NULL;
> > > +       while (!bpf_map__get_next_key(map, prev_key, &key, sizeof(key=
))) {
> > > +               struct syscall_stats stat;
> > > +
> > > +               if (!bpf_map__lookup_elem(map, &key, sizeof(key), &st=
at, sizeof(stat), 0)) {
> > > +                       if (skel->rodata->aggr_mode =3D=3D SYSCALL_AG=
GR_THREAD)
> > > +                               update_thread_stats(&schash, &key, &s=
tat);
> > > +                       else
> > > +                               update_total_stats(&schash, &key, &st=
at);
> > > +               }
> > > +
> > > +               prev_key =3D &key;
> > > +       }
> > > +
> > > +       nr_data =3D hashmap__size(&schash);
> > > +       data =3D calloc(nr_data, sizeof(*data));
> > > +       if (data =3D=3D NULL)
> > > +               goto out;
> > > +
> > > +       i =3D 0;
> > > +       hashmap__for_each_entry(&schash, entry, bkt)
> > > +               data[i++] =3D entry->pvalue;
> > > +
> > > +       qsort(data, nr_data, sizeof(*data), datacmp);
> >
> > Here syscall_data is sorted for AGGR_THREAD and AGGR_CPU, meaning the
> > thread who has the higher total syscall period will be printed first.
> > This is an awesome side effect but it is not the behavior of 'sudo
> > ./perf trace -as -- sleep 1' without the --bpf-summary option. If it
> > is not too trivial, maybe consider documenting this behavior? But it
> > may be too verbose so Idk.
>
> The original behavior is random ordering and now it's ordered by total
> time.  But still we can think it's randomly ordered.  I believe we need
> to maintain strict ordering by total time and then fixed the existing
> code.  Once that happen I can add the documentation.

ofc.

>
> Thanks for your careful review!

You are welcome.

> Namhyung

Thanks,
Howard

