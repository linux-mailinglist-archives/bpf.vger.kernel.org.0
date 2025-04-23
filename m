Return-Path: <bpf+bounces-56539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2EEA999B4
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 22:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0137463A67
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 20:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9A626FDBB;
	Wed, 23 Apr 2025 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilumO0+D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE1253921;
	Wed, 23 Apr 2025 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441451; cv=none; b=u9B3oDJLEA0wSFjr0A0+HRV9YyZC13M1LTfEfiAdAj//CsHqu/WgAWkszmhH3POUzSlNi1tiTuSIGPQW1WVjdC/tapguIepN5pmQJ/S+O0iNDGc8Y6eVAVhhEfvO0QQvzkXyoZQxUOmm7C7G4zK8Mg+egk9VoYG3kRx7gcM/osY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441451; c=relaxed/simple;
	bh=QtGXRfFMS/QaPxnRDW/0E9DsynCEdAmHR+SsZfWDV1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4xKqJXPHEZtqcWImdyWxubzjOuCiA/U0aRuILuKP0aFMp1u86EjHG1YTQvBjxzxcus8uNkkBm5Lewa7QBlhTs2oOXlYHPTnncmfXhDFr37LSawCIU2fNtyEaWX3PfKC3DgAYlobYkcOuAGnJEby9wG3B+5W1/zvnORRbygJWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilumO0+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7523C4CEE2;
	Wed, 23 Apr 2025 20:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745441451;
	bh=QtGXRfFMS/QaPxnRDW/0E9DsynCEdAmHR+SsZfWDV1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilumO0+DTjX1Py8AKdxCdlORL66qfTr57cM42sZpcWz7jDZN4tqa2lV0FwvYC+y1P
	 6cdONllQCx5ARnUA7uuwjKCP38IB4lsPU7SbB0Tz9V1VjE4sqH28qIBXChNKJjY8tW
	 D5fLXcsc2LkVXgSJmVkvdVH1YCfxjEkdO6piOQhyOeiP0pm9Q4kR+wfYCOGjf7J2YH
	 IEkpDZkkg/B0G/MT6V9Nu6dBYztq4yPRB/2pH/TYBOEG7tQ0g5yh8X/RnA0BJk8tU0
	 bDEDsC2TpT/p0Mh9DXe8jR1uFx34tseAVcPqwEQuxxs9we6Z4MoPeEWP+ZkiZ1GZ8O
	 gk4xqcmf9liQQ==
Date: Wed, 23 Apr 2025 17:50:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 1/2] perf trace: Implement syscall summary in BPF
Message-ID: <aAlSqGN9Sx4x6_sI@x1>
References: <20250326044001.3503432-1-namhyung@kernel.org>
 <CAH0uvojPaZ-byE-quc=sUvXyExaZPU3PUjdTYOzE5iDAT_wNVA@mail.gmail.com>
 <aAkUyFjRFLkS170u@x1>
 <aAkmY0hLXarmCSIA@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAkmY0hLXarmCSIA@google.com>

On Wed, Apr 23, 2025 at 10:41:55AM -0700, Namhyung Kim wrote:
> Hi Arnaldo,
> 
> On Wed, Apr 23, 2025 at 01:26:48PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Mar 28, 2025 at 06:46:36PM -0700, Howard Chu wrote:
> > > On Tue, Mar 25, 2025 at 9:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >      syscall            calls  errors  total       min       avg       max       stddev
> > > >                                        (msec)    (msec)    (msec)    (msec)        (%)
> > > >      --------------- --------  ------ -------- --------- --------- ---------     ------
> > > >      epoll_wait           561      0  4530.843     0.000     8.076   520.941     18.75%
> > > >      futex                693     45  4317.231     0.000     6.230   500.077     21.98%
> > > >      poll                 300      0  1040.109     0.000     3.467   120.928     17.02%
> > > >      clock_nanosleep        1      0  1000.172  1000.172  1000.172  1000.172      0.00%
> > > >      ppoll                360      0   872.386     0.001     2.423   253.275     41.91%
> > > >      epoll_pwait           14      0   384.349     0.001    27.453   380.002     98.79%
> > > >      pselect6              14      0   108.130     7.198     7.724     8.206      0.85%
> > > >      nanosleep             39      0    43.378     0.069     1.112    10.084     44.23%
> > > >      ...
> > 
> > I added the following to align sched_[gs]etaffinity,
> 
> Thanks for processing the patch and updating this.  But I'm afraid there
> are more syscalls with longer names and this is not the only place to
> print the syscall names.  Also I think we need to update length of the
> time fields.  So I prefer handling them in a separate patch later.

Fair enough, I'm leaving the patch as-is.

- Arnaldo

