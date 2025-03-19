Return-Path: <bpf+bounces-54424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C17A69CC8
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 00:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC583B34FA
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 23:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B1D22422B;
	Wed, 19 Mar 2025 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMssuKX8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E716F858;
	Wed, 19 Mar 2025 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742427571; cv=none; b=ZZBiF98Qe40K7HFv76AvIhVe+3wa8xq3aZ/FqyFZ3yyD3WPvVrvOF46NeYCUdIXdX3UDN6kX6bl18YXkflst3tg1gmgbNMqhlp9N0ewgct0DsY4AlJMdycnE2DDR2+sQvEuot4GwKtfny+Hr1lPtr4uxKMrKSnwlcnn59bxxZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742427571; c=relaxed/simple;
	bh=VEvV0hAAEzuzFIisaPBMod+lE5QjWK8T2Kmf1DMtKBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftx8XKrKJKhCGuyrhJVNEmC3XlVuNYxlFd9b8rtm+fMZ+f71s7QCsxNgiSNvKuCovmhGfQMLuogy1i6xB9K6GAKsPBoU9xHo68DkyPXjlNUl9kWDFfqvffwkGBD7WJ0sSPuiARUn4X2UCVLLtpydRWB/6bp09qiStmJb/8XFWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMssuKX8; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ff0c9d1761so1901407b3.1;
        Wed, 19 Mar 2025 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742427568; x=1743032368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Cq23PeKRIIRaRLnVCoTwyue9MtxIvEBi1Dzwf2/unk=;
        b=HMssuKX8Z6+Jd/DIS8vSDB/kEJKFWM9REEbf54B7TAj9wcWkif70ppEz2p3Xhe/qcC
         54bmVWrRxUYxPdNknx1jimBa2s16rGI0316S/TwU7zR6ll+XT0pDi63V0nY0sJ4fS4R/
         svAYqCwcIhi4mINBwGf5IUU6VNZIBrSl2cDn1ckhGQx/W2JTCbwr8cW6PybQEd9TUoCA
         oT5Y8x8iMBTDG2lXWSYw09U2QpoVETXPVSlnzfWoDS4cEGVLlqqS7dMtPwRxPy4/AJbL
         Co8drILnKzrin6Bjpk1VcDTo9umCJ0P0L8rgLDHvcnXP1l62CTw7xuQWhubhof3KnIJF
         ezVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742427568; x=1743032368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Cq23PeKRIIRaRLnVCoTwyue9MtxIvEBi1Dzwf2/unk=;
        b=O7NSPqcfIgkUG/ieEyORRPh1G3iXujFXRYgHfFXuoLWBGIuSbioGH6phC5kv/CsDRU
         i6ULsENMszKhG5TSUMzlcSwrrhbFs8g66M8XjFVklacR4Kvw8aipBz+gSb5V3GN5VNWr
         EpEVJI7fz6QZhZEZTs3q6Z7MG0fY6IxDjBAnfYKVDzpUEu8SMvOWglE0sS0cAKzf2phZ
         32YxE+8c65uGvnCLgVpqYcQfuzl8BXKnnUU4/4mxC1N4Sx/GwdcR7Uigu1uQZMGYEmur
         /2j5kV3yqDx6gtIFH4o9Godz2j2w4VzHfHbcbVXvn+9SQc19XABDTfSCCaTC7c+g5Q8H
         atgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDv855FLLUl2kvHBBQtv1yZLe6Zm/8jzHb/PxWMoakYIVREPo8blJjlfhyMnb/gZ33umud7jiHe5tTPDTe@vger.kernel.org, AJvYcCW/Oz7ZdLQLDzNN4mtrLiNN0HYWGtpX6cKfCmuyy+WELwKh5Gi75vmxdXa+lt05pOz1N5wHYepaD8l37EEoF9U7Ew==@vger.kernel.org, AJvYcCXgReu8AFORV5Y568LdoR+Lm7pTgTyXNh59rcMh667xvp1RvkM5qz/LNZiJ4s4aoLKiiqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQLDl8K9bnJt65PSCpSIPpKdMY/1AEqx5xa5uhm9b5b155iaT3
	D1a6sFSKh6UzeWBW6zywqefcIwhyxwEpEXdcT0U5D/Ajc/zrF9e2jG5s6s+QL1ntzg6lqNnKGv+
	/asVPR5nb/AaksiHl2Ay3Ywo4vheDY86ZP7E=
X-Gm-Gg: ASbGncs543mmSRXiZgtrk64RTic71s+5c7ufX7arUnHhvBzWYBJcAlC9jYoxIpy3nif
	j0ahffOYtQHe2MGDs9FU3iRljt3wuE8EBydP16cP/6I4PBjrFaLztPxp3Y7hFP9BjnI0IP363Cu
	wlKXtPP87IR3/kC7Lg30Va9eeT
X-Google-Smtp-Source: AGHT+IFAw2POQPH36yc1ixUBdy6/IY9+jU8D5hEFwscQmrtmCZgGr0myaXaQh3Wt79t66lyV5CdD+i57MOfE1GyC1Lw=
X-Received: by 2002:a05:690c:62c3:b0:6fd:3d37:99ce with SMTP id
 00721157ae682-700ac5dd106mr16101017b3.17.1742427568539; Wed, 19 Mar 2025
 16:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317180834.1862079-1-namhyung@kernel.org> <CAH0uvogx1-oz4ZjLpcTRArTb2YJOyY1h1pccMXYSgCnHYD9bPA@mail.gmail.com>
 <Z9tABRzmYYYUyEFO@google.com> <CAH0uvog7uZL2AGyfPdSjCo0eahxDESXT3ZWSNmUCGWFc_SmFYg@mail.gmail.com>
In-Reply-To: <CAH0uvog7uZL2AGyfPdSjCo0eahxDESXT3ZWSNmUCGWFc_SmFYg@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 19 Mar 2025 16:39:17 -0700
X-Gm-Features: AQ5f1Jo3yarlJN9wYot80fffJ5hGYMkUS5yVrPcuTv39SUuE2b6Jr3ic3g8mBv4
Message-ID: <CAH0uvoi_Soj=b1YdsqN=RhHMf340r1YZm72JgkyAyUi-Rox7_g@mail.gmail.com>
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

Hi Namhyung,

I haven't finished the code review yet, but here are something that I
found interesting to share:

## 1
You used sudo ./perf trace -as --bpf-summary --summary-mode=3Dtotal -- slee=
p 1 as
an example

If I use perf trace --bpf-summary without the '-a', that is to record
the process / task of 'sleep 1':

sudo ./perf trace -s --bpf-summary --summary-mode=3Dtotal -- sleep 1

It won't be recording this one process. So there should be a sentence
saying that bpf-summary only does system wide summaries.

## 2
there is a bug in min section, which made min always 0

you can see it in the sample output you provided above:
     syscall            calls  errors  total       min       avg
max       stddev
                                       (msec)    (msec)    (msec)
(msec)        (%)
     --------------- --------  ------ -------- --------- ---------
---------     ------
     futex                372     18  4373.773     0.000    11.757
997.715    660.42%
     poll                 241      0  2757.963     0.000    11.444
997.758    580.34%
     epoll_wait           161      0  2460.854     0.000    15.285
325.189    260.73%
     ppoll                 19      0  1298.652     0.000    68.350
667.172    281.46%
     clock_nanosleep        1      0  1000.093     0.000  1000.093
1000.093      0.00%
     epoll_pwait           16      0   192.787     0.000    12.049
173.994    348.73%
     nanosleep              6      0    50.926     0.000     8.488
10.210     43.96%

clock_nanosleep has only 1 call so min can never be 0, it has to be
equal to the max and the mean.

This can be resolved by adding this line (same as what you did in the BPF c=
ode):

diff --git a/tools/perf/util/bpf-trace-summary.c
b/tools/perf/util/bpf-trace-summary.c
index 5ae9feca244d..eb98db7d6e33 100644
--- a/tools/perf/util/bpf-trace-summary.c
+++ b/tools/perf/util/bpf-trace-summary.c
@@ -243,7 +243,7 @@ static int update_total_stats(struct hashmap
*hash, struct syscall_key *map_key,

  if (stat->max_time < map_data->max_time)
  stat->max_time =3D map_data->max_time;
- if (stat->min_time > map_data->min_time)
+ if (stat->min_time > map_data->min_time || !stat->min_time)
  stat->min_time =3D map_data->min_time;

  return 0;

(sorry for the poor formatting from the gmail browser app)

## 3
Apologies for misunderstanding how the calculation of the 'standard
deviation of mean' works. You can decide what to do with it. :) Thanks
for the explanation in the thread of the previous version.

Thanks,
Howard

On Wed, Mar 19, 2025 at 3:19=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hi Namhyung,
>
> On Wed, Mar 19, 2025 at 3:07=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hello Howard,
> >
> > On Wed, Mar 19, 2025 at 12:00:10PM -0700, Howard Chu wrote:
> > > Hello Namhyung,
> > >
> > > Can you please rebase it? I cannot apply it, getting:
> > >
> > > perf $ git apply --reject --whitespace=3Dfix
> > > ./v2_20250317_namhyung_perf_trace_implement_syscall_summary_in_bpf.mb=
x
> > > Checking patch tools/perf/Documentation/perf-trace.txt...
> > > Checking patch tools/perf/Makefile.perf...
> > > Hunk #1 succeeded at 1198 (offset -8 lines).
> > > Checking patch tools/perf/builtin-trace.c...
> > > error: while searching for:
> > >         bool       hexret;
> > > };
> > >
> > > enum summary_mode {
> > >         SUMMARY__NONE =3D 0,
> > >         SUMMARY__BY_TOTAL,
> > >         SUMMARY__BY_THREAD,
> > > };
> > >
> > > struct trace {
> > >         struct perf_tool        tool;
> > >         struct {
> > >
> > > error: patch failed: tools/perf/builtin-trace.c:140
> >
> > Oops, I think I forgot to say it's on top of Ian's change.
> > Please try this first.  Sorry for the confusion.
> >
> > https://lore.kernel.org/r/20250319050741.269828-1-irogers@google.com
>
> Yep, with Ian's patches it successfully applied. :)
>
> Thanks,
> Howard
> >
> > Thanks,
> > Namhyung
> >

