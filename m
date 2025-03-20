Return-Path: <bpf+bounces-54427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891ADA69D30
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 01:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6A2188E381
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 00:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A03C2C1A2;
	Thu, 20 Mar 2025 00:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw+/COgU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E11846D;
	Thu, 20 Mar 2025 00:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429852; cv=none; b=HNs+FRRI2Zn4wr94vN1+p4ghiQjVil+SjW/bQjJ1/fRkRziKFSY7JOgrGMYF0ZxVdUqUTQmfhfN73b3E+iXeTBXuSMgCi7Rm9r9kgSRi6nkh/t0Ef9IwpIUJsK3K9uyRa2E7DUxmLxamrYWfib3R9dYgjlW9Wxsv3pnVT52t+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429852; c=relaxed/simple;
	bh=/yS0JpV8hJu3Jxftqy7tqsojZdKf7wKp48xtukVTWUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwcGaPDN86HOOBtj2ecWJP98lAZZoEVWTT2okHr+iNVXTBfKN82qCTE4DWN8zNx3/lYIHwAssVpsjpNccKdnxyJnuAN/abTUe0jyAj5e043HHPrfgoVk/RY0SjkLqoR0WtjpzvXQeK4c3i/1+8Ggy111q2qr5jd7IpnfeDsbwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw+/COgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FF3C4CEE4;
	Thu, 20 Mar 2025 00:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742429852;
	bh=/yS0JpV8hJu3Jxftqy7tqsojZdKf7wKp48xtukVTWUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iw+/COgUvIMB6bKaEBxZOrJJQ/HQEa0tEQa2oH1uO4wSGBBAImqNEvCLBKJiyEyFx
	 NsUQ99wqaGipe7oAi+lFOeNj4IaEHU9rH0it2Dpjd3tEbIEsj64DB7RRBMkQia22YV
	 RqtySWB//7j+eFBv9NXIvAPJGw0Vc/QLsAkpHs7bvqRuKbUjwGTDL9YBHnPB4DQqov
	 Oxe8zL8gC3syMohy81gy3/00558vAJY4eJSywGDxobzMre1XFiKEMETBUMG2ynxd1s
	 1vTAWl4hhabilY5EUJZdw/wYD4QE+3LT12QzPo78fDkHiJLMY1c708aeihDy/JzKAQ
	 hF7+kCWzWYFgQ==
Date: Wed, 19 Mar 2025 17:17:30 -0700
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
Message-ID: <Z9temnrmEHVTfSZD@google.com>
References: <20250317180834.1862079-1-namhyung@kernel.org>
 <CAH0uvogx1-oz4ZjLpcTRArTb2YJOyY1h1pccMXYSgCnHYD9bPA@mail.gmail.com>
 <Z9tABRzmYYYUyEFO@google.com>
 <CAH0uvog7uZL2AGyfPdSjCo0eahxDESXT3ZWSNmUCGWFc_SmFYg@mail.gmail.com>
 <CAH0uvoi_Soj=b1YdsqN=RhHMf340r1YZm72JgkyAyUi-Rox7_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvoi_Soj=b1YdsqN=RhHMf340r1YZm72JgkyAyUi-Rox7_g@mail.gmail.com>

On Wed, Mar 19, 2025 at 04:39:17PM -0700, Howard Chu wrote:
> Hi Namhyung,
> 
> I haven't finished the code review yet, but here are something that I
> found interesting to share:

Thanks a lot for your review!

> 
> ## 1
> You used sudo ./perf trace -as --bpf-summary --summary-mode=total -- sleep 1 as
> an example
> 
> If I use perf trace --bpf-summary without the '-a', that is to record
> the process / task of 'sleep 1':
> 
> sudo ./perf trace -s --bpf-summary --summary-mode=total -- sleep 1
> 
> It won't be recording this one process. So there should be a sentence
> saying that bpf-summary only does system wide summaries.

Hmm.. you're right.  I added per-thread summary but it still works for
system-wide only.  I'll check the target and make it fail with an error
message if it's not in system-wide mode for now.  I think we can add
support for other targets later.

> 
> ## 2
> there is a bug in min section, which made min always 0
> 
> you can see it in the sample output you provided above:
>      syscall            calls  errors  total       min       avg
> max       stddev
>                                        (msec)    (msec)    (msec)
> (msec)        (%)
>      --------------- --------  ------ -------- --------- ---------
> ---------     ------
>      futex                372     18  4373.773     0.000    11.757
> 997.715    660.42%
>      poll                 241      0  2757.963     0.000    11.444
> 997.758    580.34%
>      epoll_wait           161      0  2460.854     0.000    15.285
> 325.189    260.73%
>      ppoll                 19      0  1298.652     0.000    68.350
> 667.172    281.46%
>      clock_nanosleep        1      0  1000.093     0.000  1000.093
> 1000.093      0.00%
>      epoll_pwait           16      0   192.787     0.000    12.049
> 173.994    348.73%
>      nanosleep              6      0    50.926     0.000     8.488
> 10.210     43.96%
> 
> clock_nanosleep has only 1 call so min can never be 0, it has to be
> equal to the max and the mean.

Oops, right.

> 
> This can be resolved by adding this line (same as what you did in the BPF code):
> 
> diff --git a/tools/perf/util/bpf-trace-summary.c
> b/tools/perf/util/bpf-trace-summary.c
> index 5ae9feca244d..eb98db7d6e33 100644
> --- a/tools/perf/util/bpf-trace-summary.c
> +++ b/tools/perf/util/bpf-trace-summary.c
> @@ -243,7 +243,7 @@ static int update_total_stats(struct hashmap
> *hash, struct syscall_key *map_key,
> 
>   if (stat->max_time < map_data->max_time)
>   stat->max_time = map_data->max_time;
> - if (stat->min_time > map_data->min_time)
> + if (stat->min_time > map_data->min_time || !stat->min_time)
>   stat->min_time = map_data->min_time;
> 
>   return 0;
> 
> (sorry for the poor formatting from the gmail browser app)

No problem, I'll add this change.

> 
> ## 3
> Apologies for misunderstanding how the calculation of the 'standard
> deviation of mean' works. You can decide what to do with it. :) Thanks
> for the explanation in the thread of the previous version.

No, it turns out that it can be calculated easily with the squared sum.
So I've added it.

Thanks,
Namhyung

> 
> Thanks,
> Howard
> 
> On Wed, Mar 19, 2025 at 3:19 PM Howard Chu <howardchu95@gmail.com> wrote:
> >
> > Hi Namhyung,
> >
> > On Wed, Mar 19, 2025 at 3:07 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello Howard,
> > >
> > > On Wed, Mar 19, 2025 at 12:00:10PM -0700, Howard Chu wrote:
> > > > Hello Namhyung,
> > > >
> > > > Can you please rebase it? I cannot apply it, getting:
> > > >
> > > > perf $ git apply --reject --whitespace=fix
> > > > ./v2_20250317_namhyung_perf_trace_implement_syscall_summary_in_bpf.mbx
> > > > Checking patch tools/perf/Documentation/perf-trace.txt...
> > > > Checking patch tools/perf/Makefile.perf...
> > > > Hunk #1 succeeded at 1198 (offset -8 lines).
> > > > Checking patch tools/perf/builtin-trace.c...
> > > > error: while searching for:
> > > >         bool       hexret;
> > > > };
> > > >
> > > > enum summary_mode {
> > > >         SUMMARY__NONE = 0,
> > > >         SUMMARY__BY_TOTAL,
> > > >         SUMMARY__BY_THREAD,
> > > > };
> > > >
> > > > struct trace {
> > > >         struct perf_tool        tool;
> > > >         struct {
> > > >
> > > > error: patch failed: tools/perf/builtin-trace.c:140
> > >
> > > Oops, I think I forgot to say it's on top of Ian's change.
> > > Please try this first.  Sorry for the confusion.
> > >
> > > https://lore.kernel.org/r/20250319050741.269828-1-irogers@google.com
> >
> > Yep, with Ian's patches it successfully applied. :)
> >
> > Thanks,
> > Howard
> > >
> > > Thanks,
> > > Namhyung
> > >

