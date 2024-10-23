Return-Path: <bpf+bounces-42943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8319AD43C
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 20:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB50B22FEB
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C231D0418;
	Wed, 23 Oct 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXwvN2fA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A744A3E;
	Wed, 23 Oct 2024 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709277; cv=none; b=KZL/i+L7hB7sYaROASjDgs7xxFWtr6my9tIQaDcPBszrh70wlaiFakt/P39wcF5Q7mMyaK0sr8PHj67QPw99nkS72f38Le/liKmvtGp3GQ/MuCU3p8j1i63z1bzCAwF/M8BIyegdTJi7t/kYzLgW3XIiNRuYJASf8+vLDq4675g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709277; c=relaxed/simple;
	bh=qWfZl6GigbiKNKZlaEt7CGTYEHkyFaSyrLfK2HMbToE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZKcjjpU8vg+lUXVcJUKq9C4rRZylPh/nklUM3tIbc1AwvOdshcN4HpXNqAvlhbdgEKeKpH2dOsA2cM6gDq63JMDjEsRxb8nwYyX99eU7ZU/M/+nHeRt3dM0JoLujBRA8XCkITsXBubM4UdpmdOgmO555AgRVuPWWNkBWIvqySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXwvN2fA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E48C4CEC6;
	Wed, 23 Oct 2024 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729709277;
	bh=qWfZl6GigbiKNKZlaEt7CGTYEHkyFaSyrLfK2HMbToE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXwvN2fAQ29oL3b4aB88gpIEqZ9Oi6eWL7Ho/nldfCIn/54IfzZwYDNptWGmKBYh9
	 jG+emCwdJNTGm+jtF93+zxqOXwgWLb+P4kV9MBr2eiIglltTnct3lnSsVq6GzAZBtq
	 avXgabTLIlCpepQwGVqmZPEtUG8TshFcRsjMiiCcRJt2ytbgmKTCbnOp/FCRfTsMTu
	 RoR700NEygypwPTZUW2fn7JtXOwO3Rg1wk6T80WEnG/blnEmsHfGsGCrlKR27bVb6v
	 4kDoRJCqvdGOiP8oDj7eRZYjXUSKY39cWxcUtp2mxuJgUKiNuWgG9rFtlBmWL17XNj
	 1l2gIsB75WjKA==
Date: Wed, 23 Oct 2024 11:47:54 -0700
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
Message-ID: <ZxlE2jEUzpt0WcFJ@google.com>
References: <20241023000928.957077-1-namhyung@kernel.org>
 <20241023000928.957077-4-namhyung@kernel.org>
 <CAEf4BzaoWnUdO0OrmztT1NK62eVzYhFsUiD_E-hY5=oY3E-VeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaoWnUdO0OrmztT1NK62eVzYhFsUiD_E-hY5=oY3E-VeA@mail.gmail.com>

Hello,

On Wed, Oct 23, 2024 at 09:12:52AM -0700, Andrii Nakryiko wrote:
> On Tue, Oct 22, 2024 at 5:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Like in the software events, the BPF overflow handler can drop samples
> > by returning 0.  Let's count the dropped samples here too.
> >
> > Acked-by: Kyle Huey <me@kylehuey.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Song Liu <song@kernel.org>
> > Cc: bpf@vger.kernel.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  kernel/events/core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 5d24597180dec167..b41c17a0bc19f7c2 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9831,8 +9831,10 @@ static int __perf_event_overflow(struct perf_event *event,
> >         ret = __perf_event_account_interrupt(event, throttle);
> >
> >         if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> > -           !bpf_overflow_handler(event, data, regs))
> > +           !bpf_overflow_handler(event, data, regs)) {
> > +               atomic64_inc(&event->dropped_samples);
> 
> I don't see the full patch set (please cc relevant people and mailing
> list on each patch in the patch set), but do we really want to pay the

Sorry, you can find the whole series here.

https://lore.kernel.org/lkml/20241023000928.957077-1-namhyung@kernel.org

I thought it's mostly for the perf part so I didn't CC bpf folks but
I'll do in the next version.


> price of atomic increment on what's the very typical situation of a
> BPF program returning 0?

Is it typical for BPF_PROG_TYPE_PERF_EVENT?  I guess TRACING programs
usually return 0 but PERF_EVENT should care about the return values.

> 
> At least from a BPF perspective this is no "dropping sample", it's
> just processing it in BPF and not paying the overhead of the perf
> subsystem continuing processing it afterwards. So the dropping part is
> also misleading, IMO.

In the perf tools, we have a filtering logic in BPF to read sample
values and to decide whether we want this sample or not.  In that case
users would be interested in the exact number of samples.

Thanks,
Namhyung

> 
> >                 return ret;
> > +       }
> >
> >         /*
> >          * XXX event_limit might not quite work as expected on inherited
> > --
> > 2.47.0.105.g07ac214952-goog
> >

