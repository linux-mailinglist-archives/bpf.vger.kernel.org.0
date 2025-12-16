Return-Path: <bpf+bounces-76690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7352DCC1145
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 07:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4764730213F9
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 06:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949CD33D6D2;
	Tue, 16 Dec 2025 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Adcbu32Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D532D7E6;
	Tue, 16 Dec 2025 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866000; cv=none; b=E43nFLBbOxNqh0TiXviLRgCeOlMiZih3dJTl1boPYH5j47F7oPAHOszBxG/FxB01eYaNlHlP+WMLNCmEyAsyJlTevYDeDpIQG3BP3VFL+oT1P8hbbxBpfk85bAnEcZauXjlq2gVUNz9n3vZX7Yr/bE7NNjcJ0ilAjyCyekgvwlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866000; c=relaxed/simple;
	bh=jcEEYLZM+Ahx6ncXaYATQIK3U9/f/6urv5INm84E1XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSfYjLOT2qOb+fUyUwHgOgno4IB55C+SYBslIHVJMuLaINEN/8t5auWtFLPlihpumuwMuP9RLLHg7kygdu3obqbxOK6knKyvCGGz21W0kvKsHtYCPsFr9ObMg6v9TXC7GLz5k5aomm3diOO6NUcrq2sRXvr7uMRgic1T8bT9qDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Adcbu32Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CEFC4CEF1;
	Tue, 16 Dec 2025 06:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765865997;
	bh=jcEEYLZM+Ahx6ncXaYATQIK3U9/f/6urv5INm84E1XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Adcbu32ZsNBcAwhR6eMNWNwTQvZYGyLvz1jjJqksdcWe8kF7/2cutbfQ/+qT4fbFZ
	 t+7hxWzMBuK7bd/vLGpUHLIcum4ak5X/UVb/MML8V47Hj3Io0Pi6a/AGYPdhAxSe7Q
	 4o8zhuGdgBr3tupLNxQsThVcmD9l3sQM052Sk7VpvrSJjZPd4K0LsoKg1A0woIJdcj
	 qYmBeEnEKOu/qQDm6SpNbNlIpXk9W3XTj/3WKKKNRdAoyYVRxqH8f7d18Wh9DdUlzW
	 NUJxZ9EBozoBgFGkQ6LU/JyLZ4IO46oePDJso5fxB/AgHw4IWRU5YS5tnQgY68OG2h
	 qBJmEtBqOAptw==
Date: Mon, 15 Dec 2025 22:19:56 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH 1/2] tools/build: Add a feature test for libopenssl
Message-ID: <aUD6DH_zAI6trA6M@google.com>
References: <20251203232924.1119206-1-namhyung@kernel.org>
 <CAP-5=fU=G75jpsG-X6pa8_rdKapxVc615CqvcdSPBFesj02D6A@mail.gmail.com>
 <aTGz9kFQk2xNvsbC@x1>
 <aTIeuLOcc6c7RWUz@google.com>
 <CAP-5=fVRjs9Dw=_8B9NRkWxgZKn_yg5XEYXhc_UNi9HGz-R23Q@mail.gmail.com>
 <4e7f40fc-114c-4786-86f7-532dce6cb04c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e7f40fc-114c-4786-86f7-532dce6cb04c@kernel.org>

Hello,

On Fri, Dec 05, 2025 at 10:28:03AM +0000, Quentin Monnet wrote:
> 2025-12-04 22:27 UTC-0800 ~ Ian Rogers <irogers@google.com>
> > On Thu, Dec 4, 2025 at 3:52 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >>
> >> On Thu, Dec 04, 2025 at 01:16:54PM -0300, Arnaldo Carvalho de Melo wrote:
> >>> On Wed, Dec 03, 2025 at 04:34:56PM -0800, Ian Rogers wrote:
> >>>> On Wed, Dec 3, 2025 at 3:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >>>>>
> >>>>> It's used by bpftool and the kernel build.  Let's add a feature test so
> >>>>> that perf can decide what to do based on the availability.
> >>>>
> >>>> It seems strange to add a feature test that bpftool is missing and
> >>>> then use it only in the perf build. The signing of bpf programs isn't
> >>>
> >>> It is strange indeed, I agree that since we don't use BPF signing at
> >>> this point in the perf BPf skels, then we could just bootstrap a bpftool
> >>> without such feature and continue building the existing features.
> >>>
> >>> Adding the bpftool maintainer to the CC list, Quentin?
> >>
> >> I've already talked to Quentin and they want libopenssl as a
> >> requirement.
> >>
> >> https://lore.kernel.org/linux-perf-users/e44f70bf-8f50-4a4b-97b8-eaf988aabced@kernel.org/
> > 
> > You can have libopenssl as a requirement and have a bootstrap bpftool
> > that doesn't require it, as the bootstrap version only provides
> > minimal features typically to just build bpftool. You can also have
> > libopenssl as a requirement and have a feature test that fails in the
> > bpftool build saying you are missing a requirement. Having the perf
> > build detect that a feature for the bpftool dependency is missing is
> > fine as we can then recommend installing bpftool or the missing
> > dependency, but doing this without bpftool also doing something just
> > seems inconsistent.
> > 
> > Thanks,
> > Ian
> 
> 
> From bpftool's perspective, it doesn't really make sense to skip the
> OpenSSL dependency for the bootstrap version, given that we want to ship
> the main binary with the signing feature: so you could build a bootstrap
> version without signing, but you won't be able to use it to build the
> final binary because, well, you miss a required dependency.
> 
> This being said, if it really makes it easier for you to build perf, I'd
> be open to adjusting the bootstrap version, as long as it doesn't affect
> the final bpftool build. It might lead to further headaches if someone
> needs to sign the BPF programs when building perf in the future though.
> 
> I'm also OK with adding a dependency check with a simple build error for
> bpftool, although we don't currently do it for other required
> dependencies in bpftool.

Ok, to make a progress, I'll add this series to perf-tools tree for
v6.19 first.

Thanks,
Namhyung


