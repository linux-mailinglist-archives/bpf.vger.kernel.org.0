Return-Path: <bpf+bounces-23062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB4B86D07C
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 18:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823021F233BC
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5C070AC5;
	Thu, 29 Feb 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="athSDJtJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2346CBE3;
	Thu, 29 Feb 2024 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227414; cv=none; b=iNuRKnT3UMwr+ok7g2Eohd9MdoOBurkC8BPpJlP4KiWbhZC8qQ912x5QgjEk0doZk+2UrpRYlJsFlKNGFBfJiQKd/vHq4JkBTcUKR9+pVyjPwHhwyfQTeJyMNOOL52eDxH9a2hy9EUD7VQm0vAxQC7AHtmk0hfnrleUqPQYRRHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227414; c=relaxed/simple;
	bh=Oa4oT6c0wAHeOFyXLWOIs7ozD28bcI/Oq64bMT9EcJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG5cYO5CM3NG3YBdGKwn10eay458B6+92wDCoATpbC1W4iCdM01YKKPNZLq9yU3utJ3vlPf/1NaVMg06r5Bs3iW0h6sGz+76UXuYyig1oQ00o0n5eE0rtZbZaPx+31UNbUE8HGjQ1TWqaRInfTAsNd4RfSuiIDyRLHJ5Sb3zP+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=athSDJtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4454EC433F1;
	Thu, 29 Feb 2024 17:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709227413;
	bh=Oa4oT6c0wAHeOFyXLWOIs7ozD28bcI/Oq64bMT9EcJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=athSDJtJ8RuUu8fWSuuZtAHY+/s0ZdAujGSirhTSKDm+/GWp0C+aiudrumr6R8IRH
	 tJN50ftZC/WUuPg26zLc3h6Pc+G6RYFagSlXWAK3lAzeZJD+qagCSAXYkMyz+q9Vvj
	 Uqga1oiRlU9mhAsyCUVN9P5l8tuDd3u8fEKwYzO3OiM2bNStw1X+dW2lHQUPmRL3SR
	 FkshneKh+/a1QToNkyGGsMo1Lsnr3hwR9zo2Top0LbKDRo8WMPow+45nOIJa5vdcLE
	 4JKLfW96OOZpjYISfpxvrs7evO4dizAdNswCQiWnSRpOAAu20olEl7tIWDXWkgYJFw
	 baswQ2+HSwgZQ==
Date: Thu, 29 Feb 2024 14:23:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] perf lock contention: Account contending locks too
Message-ID: <ZeC9ki-4SGa-iU0C@x1>
References: <20240228053335.312776-1-namhyung@kernel.org>
 <Zd8lkcb5irCOY4-m@x1>
 <CAM9d7cicRtxCvMWu4pk6kdZAqT2pt3erpzL4_Jdt1pKLLYoFgQ@mail.gmail.com>
 <Zd-UmcqV0mbrKnd0@x1>
 <CAM9d7cg-M_8V0O2rv_gx+1u=axpRmCp4XcBkkqsiGmDgeU2xZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cg-M_8V0O2rv_gx+1u=axpRmCp4XcBkkqsiGmDgeU2xZw@mail.gmail.com>

On Wed, Feb 28, 2024 at 01:19:12PM -0800, Namhyung Kim wrote:
> On Wed, Feb 28, 2024 at 12:16 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Wed, Feb 28, 2024 at 12:01:55PM -0800, Namhyung Kim wrote:
> > > On Wed, Feb 28, 2024 at 4:22 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > On Tue, Feb 27, 2024 at 09:33:35PM -0800, Namhyung Kim wrote:
> > > > > Currently it accounts the contention using delta between timestamps in
> > > > > lock:contention_begin and lock:contention_end tracepoints.  But it means
> > > > > the lock should see the both events during the monitoring period.

> > > > > Actually there are 4 cases that happen with the monitoring:

> > > > >                 monitoring period
> > > > >             /                       \
> > > > >             |                       |
> > > > >  1:  B------+-----------------------+--------E
> > > > >  2:    B----+-------------E         |
> > > > >  3:         |           B-----------+----E
> > > > >  4:         |     B-------------E   |
> > > > >             |                       |
> > > > >             t0                      t1

> > > > > where B and E mean contention BEGIN and END, respectively.  So it only
> > > > > accounts the case 4 for now.  It seems there's no way to handle the case
> > > > > 1.  The case 2 might be handled if it saved the timestamp (t0), but it
> > > > > lacks the information from the B notably the flags which shows the lock
> > > > > types.  Also it could be a nested lock which it currently ignores.  So
> > > > > I think we should ignore the case 2.

> > > > Perhaps have a separate output listing locks that were found to be with
> > > > at least tE - t0 time, with perhaps a backtrace at that END time?

> > > Do you mean long contentions in case 3?  I'm not sure what do
> > > you mean by tE, but they started after t0 so cannot be greater

> > case 2

> >                 monitoring period
> >             /                       \
> >             |                       |
> >  2:    B----+-------------E         |
> >             |             |         |
> >             t0            tE        t1
> >
> > We get a notification for event E, right? We don´t have one for B,
> > because it happened before we were monitoring.
> 
> Ah, ok.  But there should be too many events in case 2 and
> I don't think users want to see them all.  And they don't have

So maybe a summary, something like:

  N locks that were locked before this session started have been
  released, no further info besides this histogram of in-session
  durations:

    0-N units of time: ++
  N+1-M units of time: ++++
    ...

> flags.  But maybe we can update the flag when it sees exactly
> the same callstack later.

  The callstack, if going all the way to userspace may have the workload
targeted in the command line ( some pid, tid, CPU, etc) and thus would
point for things the user probably is interested than some other lock
that may affect it but indirectly.

- Arnaldo

