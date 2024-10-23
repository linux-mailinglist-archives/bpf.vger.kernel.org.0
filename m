Return-Path: <bpf+bounces-42955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5399E9AD585
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 22:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84791F255F9
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 20:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4053F1E412A;
	Wed, 23 Oct 2024 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVzgNESq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC891D3624;
	Wed, 23 Oct 2024 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715555; cv=none; b=tOVoaVCd6uyTxj8NPBFwOkHvuDpBAWZHAD2wbV38BpFocH+YY9ZvYGE735GCakjW0sgsd5BY+lgSIstLpcTR3rFRTFoHgMay18Lap0gQEhP4npGRRzgYWIlUNH4f97Gum/1Hq3lTLTbt1Ic5BN3vWsMOqku0pHkuvdEFVz2TVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715555; c=relaxed/simple;
	bh=InQB1J4/HUV7To0lCzKBkwM8VWVIX4uWvtqGbS9u7yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xrdsol/n3qJD8Sna3+Md54nTRFVqzpxQlyEzfCEE230Ij1N/fFUXEOU4nK+O7e7hXuEZEf3gjywC0begTSpMM7aOm1qr7FbsXlRp50DyC3X75Rx1LpcEMxqOSQsDRmbGXxp14zxl70Hvi9bOWZXpXkRvBSVF3kEkeejuAYkcrRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVzgNESq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96932C4CECC;
	Wed, 23 Oct 2024 20:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729715555;
	bh=InQB1J4/HUV7To0lCzKBkwM8VWVIX4uWvtqGbS9u7yI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVzgNESqbNsOLqwqknRhW5hleXaqD45pnR+ZrtPK8KKiDZPURC5GPF351fCNw9mQe
	 oQazEbnj7Yg03Mwi2N2DdrPNMUBGY8gAVk7KmMouReIfgh4G//p0mPmjtFdS3LFE37
	 H99fJH7dM0pLGfb5TdejApSZlq43wgLAEyfyKWi6B3GfqmR/ex6gfcA92tQmy7+N6T
	 QyU4KNUYUwV4qvWkGlbtb12MFho1E6HuqGPyAw4MBHpr8qlVUkULd6+eoZbSAsb6rh
	 53LJyJgZr0tjNCRSY9URZxrlFb9jKe2NLDtbOja/24ImQAoXY+3Sd+LAPMPyqFTzug
	 dfNs4AFehERPw==
Date: Wed, 23 Oct 2024 13:32:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sandipan Das <sandipan.das@amd.com>, Kyle Huey <me@kylehuey.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 3/5] perf/core: Account dropped samples from BPF
Message-ID: <ZxldYfiWJQxu3MfN@google.com>
References: <20241023000928.957077-1-namhyung@kernel.org>
 <20241023000928.957077-4-namhyung@kernel.org>
 <CAEf4BzaoWnUdO0OrmztT1NK62eVzYhFsUiD_E-hY5=oY3E-VeA@mail.gmail.com>
 <ZxlE2jEUzpt0WcFJ@google.com>
 <CAEf4BzaTGSK3ftjuN9sDA7KrBfWsjj7PcGYaJy55X9cHYQT9TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaTGSK3ftjuN9sDA7KrBfWsjj7PcGYaJy55X9cHYQT9TQ@mail.gmail.com>

On Wed, Oct 23, 2024 at 12:13:31PM -0700, Andrii Nakryiko wrote:
> On Wed, Oct 23, 2024 at 11:47 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Wed, Oct 23, 2024 at 09:12:52AM -0700, Andrii Nakryiko wrote:
> > > On Tue, Oct 22, 2024 at 5:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Like in the software events, the BPF overflow handler can drop samples
> > > > by returning 0.  Let's count the dropped samples here too.
> > > >
> > > > Acked-by: Kyle Huey <me@kylehuey.com>
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > > Cc: Song Liu <song@kernel.org>
> > > > Cc: bpf@vger.kernel.org
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  kernel/events/core.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index 5d24597180dec167..b41c17a0bc19f7c2 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -9831,8 +9831,10 @@ static int __perf_event_overflow(struct perf_event *event,
> > > >         ret = __perf_event_account_interrupt(event, throttle);
> > > >
> > > >         if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> > > > -           !bpf_overflow_handler(event, data, regs))
> > > > +           !bpf_overflow_handler(event, data, regs)) {
> > > > +               atomic64_inc(&event->dropped_samples);
> > >
> > > I don't see the full patch set (please cc relevant people and mailing
> > > list on each patch in the patch set), but do we really want to pay the
> >
> > Sorry, you can find the whole series here.
> >
> > https://lore.kernel.org/lkml/20241023000928.957077-1-namhyung@kernel.org
> >
> > I thought it's mostly for the perf part so I didn't CC bpf folks but
> > I'll do in the next version.
> >
> >
> > > price of atomic increment on what's the very typical situation of a
> > > BPF program returning 0?
> >
> > Is it typical for BPF_PROG_TYPE_PERF_EVENT?  I guess TRACING programs
> > usually return 0 but PERF_EVENT should care about the return values.
> >
> 
> Yeah, it's pretty much always `return 0;` for perf_event-based BPF
> profilers. It's rather unusual to return non-zero, actually.

Ok, then it may be local_t or plain unsigned long.  It should be
updated on overflow only.  Read can be racy but I think it's ok to
miss some numbers.  If someone really needs a precise count, they can
read it after disabling the event IMHO.

What do you think?

Thanks,
Namhyung


