Return-Path: <bpf+bounces-22923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5649186B8E5
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52FDB280C2
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 20:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5037441E;
	Wed, 28 Feb 2024 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb5/3KZu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C4A5E06C;
	Wed, 28 Feb 2024 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151389; cv=none; b=sPX2WwFFXvxq/jBjn4CAyZf1e3t+Ir4H8EeAW4XLq17gRYiXmD2dxJ6Qg1GxL8V9ZK3TPGRXOKb2Bn0/kiBzjKThW5+wJUJFJGyZBVycborwHVN21lCyLU30p4Gryv1HUzZvUceR3dh7EC2hYOn8hgJBsDhwuno0wH5Dy1nqTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151389; c=relaxed/simple;
	bh=8Objle7v/jEBe99Hj6SMEzxAZiF4Xti3vQEyGIpNDYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhCdrCE7QU2vtIymfp3UaFv1y7VHPBJJalpUXc2UhqIX4UZL1lXWE37GLr6CPkcKjstdmspT3yC7D5ijZKKvSdZN3at2WSsJ+/Nx+aEmMMkz0WDodDl1p286Oow6iIrQ/9BML/fm6PxYklGD+KtHaB2j7P2iITr5G1kQBxmWmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb5/3KZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C54C433F1;
	Wed, 28 Feb 2024 20:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709151388;
	bh=8Objle7v/jEBe99Hj6SMEzxAZiF4Xti3vQEyGIpNDYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fb5/3KZuVt+nHUzPvWhMwkgdRq0PrU53jDcwftN897mxW60kP/uQnaVPmg5K9U8X4
	 KVaXGbwhwsxY0oKpJ5RhCetxS4KK7d+sDazk9Lm0fPS7yNYziqLT9lx08khNTZIzrn
	 vninn5ZJZ66xpXF0VjnqhlBe+p2FoUC8M6i8zVFDgsH06v5NjkoInffaQv56rAlMQy
	 r7PMDYDpwbYKfSmhnNS1Rl9/ndAONZrQQoUKD2S6ZpEaiSgkP8Pz2E8Vn0U7EFL9ao
	 Aiq8Kz8Rnjl8zNRT+IuTSDunOZrt8HoRZCseHoGpfTb2Sf2ZQ3bmAaW4rcU7fvx7lF
	 actdX0u1KrWSA==
Date: Wed, 28 Feb 2024 17:16:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] perf lock contention: Account contending locks too
Message-ID: <Zd-UmcqV0mbrKnd0@x1>
References: <20240228053335.312776-1-namhyung@kernel.org>
 <Zd8lkcb5irCOY4-m@x1>
 <CAM9d7cicRtxCvMWu4pk6kdZAqT2pt3erpzL4_Jdt1pKLLYoFgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cicRtxCvMWu4pk6kdZAqT2pt3erpzL4_Jdt1pKLLYoFgQ@mail.gmail.com>

On Wed, Feb 28, 2024 at 12:01:55PM -0800, Namhyung Kim wrote:
> On Wed, Feb 28, 2024 at 4:22 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Feb 27, 2024 at 09:33:35PM -0800, Namhyung Kim wrote:
> > > Currently it accounts the contention using delta between timestamps in
> > > lock:contention_begin and lock:contention_end tracepoints.  But it means
> > > the lock should see the both events during the monitoring period.
> > >
> > > Actually there are 4 cases that happen with the monitoring:
> > >
> > >                 monitoring period
> > >             /                       \
> > >             |                       |
> > >  1:  B------+-----------------------+--------E
> > >  2:    B----+-------------E         |
> > >  3:         |           B-----------+----E
> > >  4:         |     B-------------E   |
> > >             |                       |
> > >             t0                      t1
> > >
> > > where B and E mean contention BEGIN and END, respectively.  So it only
> > > accounts the case 4 for now.  It seems there's no way to handle the case
> > > 1.  The case 2 might be handled if it saved the timestamp (t0), but it
> > > lacks the information from the B notably the flags which shows the lock
> > > types.  Also it could be a nested lock which it currently ignores.  So
> > > I think we should ignore the case 2.
> >
> > Perhaps have a separate output listing locks that were found to be with
> > at least tE - t0 time, with perhaps a backtrace at that END time?
> 
> Do you mean long contentions in case 3?  I'm not sure what do
> you mean by tE, but they started after t0 so cannot be greater

case 2

                monitoring period
            /                       \
            |                       |
 2:    B----+-------------E         |
            |             |         |
            t0            tE        t1

We get a notification for event E, right? We don´t have one for B,
because it happened before we were monitoring.

> than or equal to the monitoring period.  Maybe we can try with
> say, 90% of period but we can still miss something.
> 
> And collecting backtrace of other task would be racy as the it
> may not contend anymore.
> 
> > With that we wouldn't miss that info, however incomplete it is and the
> > user would try running again, perhaps for a longer time, or start
> > monitoring before the observed workload starts, etc.
> 
> Yeah, it can be useful.  Let me think about it more.
> 
> >
> > Anyway:
> >
> > Reviwed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Thanks for your review!
> Namhyung
> 

