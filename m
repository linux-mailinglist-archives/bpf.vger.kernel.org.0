Return-Path: <bpf+bounces-50101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8010BA22861
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 06:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFEC3A046B
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 05:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700FE1459E4;
	Thu, 30 Jan 2025 05:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOoQIMqj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35681ACA;
	Thu, 30 Jan 2025 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738214181; cv=none; b=sAGGWc8yKKd1JES/5Y4gooIlUOjp9zDdWGR2YW/4vx80u9oymg7966B2QAvrXbVXoaVwx4EIm0MsGkUIOrP+BLegWPeZK/OU5a2YcJdVKlfxc1AIPzI7y2Sj7eTezjmvWyxOorCirS1Ct9g/Rgy6L86h2Lk67YotAYZFh+iHhnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738214181; c=relaxed/simple;
	bh=cLUpj3kV03tlAWcGGhPSQJcKBlfouIcZLliSR9dhHmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWgS6Rt/gz1DxOENAodwsuXFEdjwF3EdxW8dhNQsSrOguFeXbMmR/M07vu66ru4/JjQBAGR9sm41JQXOPhUmk+8/uVLGqL/mW36V+syw5oPDXP3WNlBpAIGgBmtzqB/UYhvxwbOUW7hoEJWiqioeViT5QG5gosMpkuzvrAHsJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOoQIMqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F49DC4CED2;
	Thu, 30 Jan 2025 05:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738214180;
	bh=cLUpj3kV03tlAWcGGhPSQJcKBlfouIcZLliSR9dhHmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOoQIMqj4iYcRGiPSJxynhAC2g158QewZHPFf5mpBRA8HI5G7KruT6K1WbTrd75qp
	 aHaFdOki9RCYDRu0Xte5MLrIVEqtkv7ihV0uqG9KRQllqS9nCTv2W1ublhL4kS7REZ
	 uaM//aLfOe/cC5lmpM7Z0+mvyjEki4NPJK00lyqGKL2UrzhuhzbyiSEEmVm4SsWNCF
	 Um1BmKo97xI0NhTE1Ey5L1yUZSdxPR5YgRAOhUnoMW8C9tYbzg4wPyd7DzfThVG8BH
	 SjzRf8AusjZOnen0V35YLpXsJyAvzAEaCi48L1HgCJBDyVRi59GOt0xnR/gObCmdn4
	 cpqakdna72iNQ==
Date: Wed, 29 Jan 2025 21:16:18 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>,
	Atish Patra <atishp@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
	Beeman Strong <beeman@rivosinc.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
Message-ID: <Z5sLIiU7D6GwpWY1@google.com>
References: <20250109222109.567031-5-irogers@google.com>
 <Z4F3qxFaYnMTtPw7@google.com>
 <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
 <Z4WNT_UX9eMD_txf@google.com>
 <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
 <CAP-5=fXdq2oSgTnNJJydAnBdSg5WeaPy6zjaink5+bsyXLoPiw@mail.gmail.com>
 <Z4f3fDXemAMpBNMS@google.com>
 <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
 <Z5qjwRG5jX9zAGtf@google.com>
 <CAP-5=fV4Q-J+Coybk5Uw=Xpx9sm5MG=2b-fvRLX14K+ZJcmz5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV4Q-J+Coybk5Uw=Xpx9sm5MG=2b-fvRLX14K+ZJcmz5Q@mail.gmail.com>

On Wed, Jan 29, 2025 at 05:16:58PM -0800, Ian Rogers wrote:
> On Wed, Jan 29, 2025 at 1:55 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Wed, Jan 15, 2025 at 01:20:32PM -0800, Ian Rogers wrote:
> > > On Wed, Jan 15, 2025 at 9:59 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > I think the behavior should be:
> > > >
> > > >   cycles -> PERF_COUNT_HW_CPU_CYCLES
> > > >   cpu-cycles -> PERF_COUNT_HW_CPU_CYCLES
> > > >   cpu_cycles -> no legacy -> sysfs or json
> > > >   cpu/cycles/ -> sysfs or json
> > > >   cpu/cpu-cycles/ -> sysfs or json
> > >
> > > So I disagree as if you add a PMU to an event name the encoding
> > > shouldn't change:
> > > 1) This historically was perf's behavior.
> >
> > Well.. I'm not sure about the history.  I believe the logic I said above
> > is the historic and (I think) right behavior.
> 
> You're wrong as you are describing the behavior post:
> https://lore.kernel.org/r/20231123042922.834425-1-irogers@google.com
> commit a24d9d9dc096fc0d0bd85302c9a4fe4fe3b1107b from Nov 2022, but
> somehow without legacy event fall backs which Intel added with a PMU
> for hybrid.
> 
> The behavior in this patch series is best for RISC-V, presumably ARM
> (particularly for Apple M? CPUs), carries ARM and Intel's tags,
> implements the behavior Arnaldo asked for, and solves the
> inconsistency that I think is fundamentally wrong in the tool that PMU
> names shouldn't matter on an event name (an inconsistency my past
> fixes introduced). It is also part of solving other problems:
> https://lore.kernel.org/linux-perf-users/20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com/

So you think the below behavior is preferred, right?

  cycles -> cpu/cycles/ (or whatever PMU name) -> sysfs or json

And there's no way to use legacy event encodings anymore?

> 
> You've not pointed at anything wrong in the scheme that these patches
> introduce, and are supported by vendors, except that it is a behavior
> change. I can, and have, pointed at many issues with your proposal
> above and the current behavior. The behavior change came about to work
> around PMU bugs over 2 years ago but only partially did so. It makes
> sense to remedy this and for the clean, consistent behavior this
> series achieves. It is unfortunate that it is a behavior change, but
> the first step for that was made 2 years ago. I think it also makes
> sense that something self described as legacy is a lower priority and
> of the past (wrt event naming moving forward).

I want to clarify the event parsing behavior and to find the right way
to deal with various cases.  I haven't followed the activities in this
area closely so I missed some changes in the past.  Maybe the problem
is that the behavior is complex and not clarified.  Hopefully we can
write it down in a doc.

Thanks,
Namhyung


