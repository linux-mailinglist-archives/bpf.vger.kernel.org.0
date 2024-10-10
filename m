Return-Path: <bpf+bounces-41508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBEC99799F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 02:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 205ABB222A8
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 00:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD32EADB;
	Thu, 10 Oct 2024 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwHWn7bh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA4D63C;
	Thu, 10 Oct 2024 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520296; cv=none; b=tDGDi01g6tDVp3L/krOdFNtTLxpGkihi0yMZR+0f6HrJZ3FPLD/+Fhs64PjREefL+98zr7JXvLfdm63i3TQCCGGtlawsqu8bEGKw9x01tdFecJJM4G8XZ3gi8o50GI6OKDbHdWB+FFZVgHtQbYJ6wl061p0eTvrz9ytSZ55l744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520296; c=relaxed/simple;
	bh=kkNfJj1RJ4WClW0GjZ2xR6/HQqOcEkFTBgBDBztekd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiH2P9NtjQTusIA12rz2+4h+K5zVzKLlFTOlYAJvyYhxjcP8BdVVm2NYZ3X/Jh2lhiVLrxR+5XbuySWVodlaFUu1yizQ0Y9C4SQKXMd4mDOTtBGCQoFpMmGWqqNsBOPmwzo40Uqw4KHKMcnOXkyWwAmfMO1xqfTnl5u1rwdGrXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwHWn7bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C04C4CEC3;
	Thu, 10 Oct 2024 00:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728520296;
	bh=kkNfJj1RJ4WClW0GjZ2xR6/HQqOcEkFTBgBDBztekd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwHWn7bhIWuezx2aRXLO4s04278vgJ5DWNpUTaicVZQsEC0hmCVvOty5q9Rgub9gf
	 ruL3hw6XsCcwldQB6zJK7stel97kWQRC+WAWtIpkUW50RWYq49PTv3qqXCmepH9GS6
	 FF0qqFE3CSgaIQHYI6zUIgeIRbqPzWEPQBFdanSrc88GrjzvrnVo9lL0zk9QrArcKc
	 ps1w5r7l0JsLATZ7beDCX165nHgK2y3z8/kyBlZyXaubFRfeaOHuCT54jvt//cHfm9
	 e2iJSt1nC3rG1rpoxRai0yePh6Jl4g/sKT9YG4O1U8rpNUOChHjyfxPxoCWj/KUdd6
	 cgoXMswvZ80vQ==
Date: Wed, 9 Oct 2024 17:31:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Tengda Wu <wutengda@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH -next v3 1/2] perf stat: Support inherit events during
 fork() for bperf
Message-ID: <ZwcgZhOC_gq9kToT@google.com>
References: <20240916014318.267709-1-wutengda@huaweicloud.com>
 <20240916014318.267709-2-wutengda@huaweicloud.com>
 <CAPhsuW6wrwcMYLufVfu-R9OzPBfspJD0w-pZUr68UBRSZExc=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6wrwcMYLufVfu-R9OzPBfspJD0w-pZUr68UBRSZExc=A@mail.gmail.com>

On Wed, Oct 09, 2024 at 10:18:44AM -0700, Song Liu wrote:
> On Sun, Sep 15, 2024 at 6:53 PM Tengda Wu <wutengda@huaweicloud.com> wrote:
> >
> > bperf has a nice ability to share PMUs, but it still does not support
> > inherit events during fork(), resulting in some deviations in its stat
> > results compared with perf.
> >
> > perf stat result:
> > $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop
> >
> >    Performance counter stats for './perf test -w sqrtloop':
> >
> >        2,316,038,116      cycles
> >        2,859,350,725      instructions
> >
> >          1.009603637 seconds time elapsed
> >
> >          1.004196000 seconds user
> >          0.003950000 seconds sys
> >
> > bperf stat result:
> > $ ./perf stat --bpf-counters -e cycles,instructions -- \
> >       ./perf test -w sqrtloop
> >
> >    Performance counter stats for './perf test -w sqrtloop':
> >
> >           18,762,093      cycles
> >           23,487,766      instructions
> >
> >          1.008913769 seconds time elapsed
> >
> >          1.003248000 seconds user
> >          0.004069000 seconds sys
> >
> > In order to support event inheritance, two new bpf programs are added
> > to monitor the fork and exit of tasks respectively. When a task is
> > created, add it to the filter map to enable counting, and reuse the
> > `accum_key` of its parent task to count together with the parent task.
> > When a task exits, remove it from the filter map to disable counting.
> >
> > After support:
> > $ ./perf stat --bpf-counters -e cycles,instructions -- \
> >       ./perf test -w sqrtloop
> >
> >  Performance counter stats for './perf test -w sqrtloop':
> >
> >      2,316,252,189      cycles
> >      2,859,946,547      instructions
> >
> >        1.009422314 seconds time elapsed
> >
> >        1.003597000 seconds user
> >        0.004270000 seconds sys
> >
> > Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> 
> The solution looks good to me. Question on the UI: do we always
> want the inherit behavior from PID and TGID monitoring? If not,
> maybe we should add a flag for it. (I think we do need the flag).

I think it should depend on the value of attr.inherit.  Maybe we can
disable the autoload for !inherit.

> 
> One nitpick below.
> 
> Thanks,
> Song
> 
> [...]
> >
> > +struct bperf_filter_value {
> > +       __u32 accum_key;
> > +       __u8 exited;
> > +};
> nit:
> Can we use a special value of accum_key to replace exited==1
> case?

I'm not sure.  I guess it still needs to use the accum_key to save the
final value when exited = 1.

Thanks,
Namhyung

> 
> > +
> >  #endif /* __BPERF_STAT_U_H */
> > --
> > 2.34.1
> >

