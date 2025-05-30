Return-Path: <bpf+bounces-59367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D5FAC94DD
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 19:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1D9A43D05
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 17:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB416243367;
	Fri, 30 May 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPRNhvs1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620E18D63A;
	Fri, 30 May 2025 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626831; cv=none; b=DPEEkZskAg6eaXmExpu0x9yGcknsEYl0JhoT1VIEGfxGIv4jGPgiKxp7bCKtCKK3ydD4DSqK2KXxHamNZDwWWu/8DTt4CLlkwNI59ybbAwo3H55GPthRGnapNrlwJmyTPtdETWWCa+gLLdp3vIOos/6WgOEh2pM5W74vacqLpw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626831; c=relaxed/simple;
	bh=7xZ9W71BF3RoT97HSMbSH9YxDhQwTnTKwYdgTZlMI80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDO+T1HOFLQXRqSRGWif/b3YPVf56GEnzLr50aZEcNjqNH7Dy3u13PC/gOQEvfKOrxL8HFJAIrKGcI+O0WILHgM2ocQI7fXjJemlMLMd7qc24XEfSiGSZU2glUgq4q8Th6NUYI0izNVRq9slYaq1KBvMbDgPaAYUcbCHaloqXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPRNhvs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723C1C4CEE9;
	Fri, 30 May 2025 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748626830;
	bh=7xZ9W71BF3RoT97HSMbSH9YxDhQwTnTKwYdgTZlMI80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPRNhvs1GYz+M2PrubRwhYgF2onCP90ePtGemYcHnKxGhvPzLTCnByw4QuwSvPDE+
	 2v8kFV4ec1d0vK7thraK877EK3WfBqrrjpF3461TotTKb5XsfKg+30+cZxloJR3RoC
	 obwUmibpFUAyGDEkLsd3ZE2u1s6wzl9l49LZ7bXuOSeBTiqSSWZLom70S+fIoTvmjq
	 pHAVbdSkVJgjnUKPHUFgvHgJnB/bKe1o1vpFGvRCz4jPhO8zfsEwHr9E1e4pdMol/c
	 jPZBD9EIrL1Nol1TWpFaU2bq9ZqEPudztInAOx3UePK4rKWak8pVldcde6mvQt20hs
	 lNQ/SbAT66BAA==
Date: Fri, 30 May 2025 10:40:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Blake Jones <blakejones@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	James Clark <james.clark@linaro.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf: add support for printing BTF character arrays
 as strings
Message-ID: <aDntjJcJsrQWfPkB@google.com>
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-2-blakejones@google.com>
 <aC9iF4_eASPkPxXd@x1>
 <CAP_z_Cg_vH1+BAm87U4gYQ0hDRGtHkkYb2DHtTRSd_QNvg3ZLQ@mail.gmail.com>
 <CAP_z_ChErhmooT5rhyXH8L-Ltkz3xdJ7PG20UKDpn9usMUgqTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP_z_ChErhmooT5rhyXH8L-Ltkz3xdJ7PG20UKDpn9usMUgqTA@mail.gmail.com>

Hi Blake,

On Wed, May 28, 2025 at 05:58:32PM -0700, Blake Jones wrote:
> Hi Arnaldo,
> 
> On Thu, May 22, 2025 at 11:19 AM Blake Jones <blakejones@google.com> wrote:
> > On Thu, May 22, 2025 at 1:42 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > > I'll test this but unsure if this part should go thru the perf tool
> > > tree, perhaps should go, together with some test case, via the libbpf
> > > tree?
> >
> > Thanks for taking a look at this. I'd appreciate your guidance here - I
> > sent it here because the other two patches in my patch set depend on this
> > one.
> 
> Do you think this can be merged through the perf tree, or should I separate
> this patch and send it though the BPF tree first?

I think it's better to go to the bpf tree although it'd take longer to
get your perf patches.

Thanks,
Namhyung


