Return-Path: <bpf+bounces-45948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D229E0BD2
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 20:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863AF161E21
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 19:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634671DE3A7;
	Mon,  2 Dec 2024 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGPVgMg/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BDB1D63CA
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166955; cv=none; b=gyTxY1GiMJvSg0S1O8fEdtHbuuAB4K93vj0pYFXkNqx1Rl/EA8B3qodwXcnP1toLEehzPnFsevkP7LBhEXkoCk/oJm7HgVrZO7cXtld76XW8YSiY7NeJ//k9PH3jo+SdSKTV/JbCVA/ywHwFv32JIWUxG2Wg+Tfr0EcDd6L18SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166955; c=relaxed/simple;
	bh=TChyWFRK+n4ALmjGUzzJhusoWODRT9RM6zm+PMYFfL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXu5ywIT8YGE9Xz5tEZ9NEPbTh0t3sPhpoC1p4hStCl9enM0Psk1ERc4etaDqX1d5Iej3FOUqH0+D74WCZxi5SG11fb6aur35E2YyZslfpm/mLoShWNKgecZDPHDXxhtPpiFPbWOZ7tORKJNS+Uk3+xWF+GGjF0Ix/mkAsn19LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGPVgMg/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee4980f085so2654689a91.2
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 11:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733166954; x=1733771754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TChyWFRK+n4ALmjGUzzJhusoWODRT9RM6zm+PMYFfL0=;
        b=dGPVgMg/YM1Ok/abdxiK22qxlgB3uDomXQz8t9QGcJtGLKIKyKxkAZoGPyItjgl927
         nrppYHys0A57zB6GyqX/RI0H7a4/n/boqx8ylASqsIhXwXx0K2ZxL/wAK3dteRk/xw6b
         oLUNsX7EBVcbKzXy7itL6nC2Pklx9uU/3opVP9CfZk3OEcoN3oljh6U0W9YWYv7wKd3C
         xlGo8bvPtmyblNEzBUGSzoOkvJLihhmguAgnlXYGcXcrz502qVRTabAAZqopYUlIlvqz
         FwykQWaps+xmLGiti6ceXaKNGDQIA7qdAF6PenY2QRzhJkQdTYYXqH6/lML+9dvg5yVy
         YQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733166954; x=1733771754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TChyWFRK+n4ALmjGUzzJhusoWODRT9RM6zm+PMYFfL0=;
        b=nGDVfJ8gkbhXEO2ZS0Rwozpe+SZh2oLKp9JzbLcl+Yma42RJ7DhKAtcxrMPvHpFyaB
         gNzB01tDF8SIG/HoVNy0yQ4p84G/vCnlSsoziscrX0pvhJvqkfh3SIu0ddJeEBh65Rzk
         oZfTtYo7eI50SOTmWnvUskWG1WrBQVDyZzskeDVkb2hwROIVtjI38T8q9d4iPIqv99o6
         PuwKcN1LHTtzUBQ+PpdQmm0xUu2p4EYZuVNdcm11Jpgy/pd+b+SSLErOyyj2EgTOW0Uh
         ANulCZqyVXdfipQPaYonARK4HQjQ4iJYXlsVBDiKwN54dp9FK9bkaJvPfTk99vUGqqT4
         dCeA==
X-Forwarded-Encrypted: i=1; AJvYcCVSNmZQ+I+8fPSqh3agKvtigK6T0w/wCbhKmbI8r0kt9qZlUA2X8WK3mzqhce8A6FKLd+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDKmMyc2uab74UncuFLuMxBYjqA2TOTkqNIljHwbM55SgjBEth
	kprzIGbBXhKWpkt2Zfd8gELfe2HtyUw2iHnRKC5w1t1HbnQ4O7x4AATA1fvvyhUw47Lrt6V5qPs
	64+DZYCUWmxE1DRok9fTvvgDop68=
X-Gm-Gg: ASbGncsNzoOqvy0YXtZfxXh+2fjZMTvTBRogk0gQg/fQLwJnIJc4SxoIQ8OzS1IFl01
	FQF/e7U7gQVAltes9edAqlmFEW/5E
X-Google-Smtp-Source: AGHT+IG4VqF8o8odiNEbxqEBOMA4pIILdnSgoPg+bNn6oQip0MpoLmJ7bw3Sky9bTR6ytBIY+4mVcOtv6beepanAT3k=
X-Received: by 2002:a17:90b:2e50:b0:2ee:e961:303d with SMTP id
 98e67ed59e1d1-2eee9613162mr3444567a91.35.1733166953562; Mon, 02 Dec 2024
 11:15:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121000814.3821326-1-vadfed@meta.com> <20241122113409.GV24774@noisy.programming.kicks-ass.net>
 <CAEf4BzYa5_jOhY3oDgJ-R4jhX7K+EmhcKQAt0VdDeNnpXicJ4g@mail.gmail.com> <20241128112734.GD35539@noisy.programming.kicks-ass.net>
In-Reply-To: <20241128112734.GD35539@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 2 Dec 2024 11:15:41 -0800
Message-ID: <CAEf4Bzbks0ZrKkRikGMOrn0p4O7ij0DtwTJ4M_1sFo4_Bmbiaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 0/4] bpf: add cpu cycles kfuncss
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vadim Fedorenko <vadfed@meta.com>, Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Yonghong Song <yonghong.song@linux.dev>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Mykola Lysenko <mykolal@fb.com>, x86@kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 3:27=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Nov 26, 2024 at 10:12:57AM -0800, Andrii Nakryiko wrote:
> > On Fri, Nov 22, 2024 at 3:34=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Wed, Nov 20, 2024 at 04:08:10PM -0800, Vadim Fedorenko wrote:
> > > > This patchset adds 2 kfuncs to provide a way to precisely measure t=
he
> > > > time spent running some code. The first patch provides a way to get=
 cpu
> > > > cycles counter which is used to feed CLOCK_MONOTONIC_RAW. On x86
> > > > architecture it is effectively rdtsc_ordered() function while on ot=
her
> > > > architectures it falls back to __arch_get_hw_counter(). The second =
patch
> > > > adds a kfunc to convert cpu cycles to nanoseconds using shift/mult
> > > > constants discovered by kernel. The main use-case for this kfunc is=
 to
> > > > convert deltas of timestamp counter values into nanoseconds. It is =
not
> > > > supposed to get CLOCK_MONOTONIC_RAW values as offset part is skippe=
d.
> > > > JIT version is done for x86 for now, on other architectures it fall=
s
> > > > back to slightly simplified version of vdso_calc_ns.
> > >
> > > So having now read this. I'm still left wondering why you would want =
to
> > > do this.
> > >
> > > Is this just debug stuff, for when you're doing a poor man's profile
> > > run? If it is, why do we care about all the precision or the ns. And =
why
> > > aren't you using perf?
> >
> > No, it's not debug stuff. It's meant to be used in production for
> > measuring durations of whatever is needed. Like uprobe entry/exit
> > duration, or time between scheduling switches, etc.
> >
> > Vadim emphasizes benchmarking at scale, but that's a bit misleading.
> > It's not "benchmarking", it's measuring durations of relevant pairs of
> > events. In production and at scale, so the unnecessary overhead all
> > adds up. We'd like to have the minimal possible overhead for this time
> > passage measurement. And some durations are very brief,
>
> You might want to consider leaving out the LFENCE before the RDTSC on
> some of those, LFENCE isn't exactly cheap.
>
> > so precision
> > matters as well. And given this is meant to be later used to do
> > aggregation and comparison across large swaths of production hosts, we
> > have to have comparable units, which is why nanoseconds and not some
> > abstract "time cycles".
> >
> > Does this address your concerns?
>
> Well, it's clearly useful for you guys, but I do worry about it. Even on
> servers DVFS is starting to play a significant role. And the TSC is
> unaffected by it.
>
> Directly comparing these numbers, esp. across different systems makes no
> sense to me. Yes putting them all in [ns] allows for comparison, but
> you're still comparing fundamentally different things.
>
> How does it make sense to measure uprobe entry/exit in wall-clock when
> it can vary by at least a factor of 2 depending on DVFS. How does it
> make sense to compare an x86-64 uprobe entry/exit to an aaargh64 one?
>
> Or are you trying to estimate the fraction of overhead spend on
> instrumentation instead of real work? Like, this machine spends 5% of
> its wall-time in instrumentation, which is effectively not doing work?

Yes, exactly. I think most of the time it will be comparisons based on
percentages. E.g., we can measure total latency of handling the whole
request, and separately total time spent on some extra metrics
collection and/or logging during that request. This would inform how
much (in relative terms) this extra metrics/logging infrastructure
costs, and would inform any of the planned efficiency work. And it's
just one possible use case.

We do collect CPU cycles-based measurements as well, just to be clear.
But we have lots of time-based data collection, and currently we are
just using bpf_ktime_get_ns() for those.

>
> The part I'm missing is how using wall-time for these things makes
> sense.
>
> I mean, if all you're doing is saying, hey, we appear to be spending X
> on this action on this particular system Y doing workload Z (irrespecive
> of you then having like a million Ys) and this patch reduces X by half
> given the same Y and Z. So patch must be awesome.
>
> Then you don't need the conversion to [ns], and the DVFS angle is more
> or less mitigated by the whole 'same workload' thing.
>

We run big services across different types of machines, and usually
people look at aggregate metrics across all of them. It might not be
the most accurate and precise way to quantify overheads, but it seems
to be good enough in practice to drive (some of) efficiency work. They
*can* dive deeper and look at breakdown by specific type of CPU, if
they care, but it's totally up to them (all this data is self-service
data sets, so tons of people have various uses for it and they often
don't consult anyone related to actual collection of this data).

In summary, I think we understand the DVFS concern you have, but in a
lot of cases this doesn't matter to specific use cases our customers
have. All in all, these new APIs seem good and useful and are an
improvement to the currently abused bpf_ktime_get_ns(). Thanks for
your reviews!

