Return-Path: <bpf+bounces-59684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69534ACE638
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 23:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25BF189A48F
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 21:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DA9221727;
	Wed,  4 Jun 2025 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly5nrdNW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAEB1FC0FE;
	Wed,  4 Jun 2025 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749073238; cv=none; b=e4l09WIJ48uE52o0POpSfRlqONzqynqFVwDgwK5IAncQonVsTFKzAoA7x39hGRSbFDxZ244iBHeEj9l2nNESvnbOuqO3gftGjQEyUdRU02l9whYEEENEgRBvGcJnx705uh8UPobsg/4uF1cRIOELmo5deiaW+T0CyTnMzTmrApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749073238; c=relaxed/simple;
	bh=aAeuHK5WWn3+SYekWH+tpsFhTjD2tgoSA/hS4ezKTkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjinQD3XkA8PgRcwMMk6lUn+KBowQk+wbJ+LLsdyAVTpRs2deD58Dc2ydycpaD0x1qop19H1AtXf8DfmPZZK9qMx0VUzIp+l5BlXaoXM9Tk04Fn9zplCE60Y3Hg7Uxwb93k4bMK26mcRq+GsdmY+b6HZE8MlA1AqUTxVSnbP9Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ly5nrdNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C29C4CEE4;
	Wed,  4 Jun 2025 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749073237;
	bh=aAeuHK5WWn3+SYekWH+tpsFhTjD2tgoSA/hS4ezKTkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ly5nrdNWs6kVeCnPi710BfN63b45OWCwtbvkKFkWSrNnnZ/ML956ygHdjWdKuHvJz
	 3apMaLBfA73s2qNF5+6l04aJqKXpccKBYA0y/OYgwP3jEbILwsWHW+cIselWUaRbGM
	 7mDqdbGc+01hDgdSpEnRkutkibqe2KwZEvKa10l2rdPfht4kREnmKnQkgGgVNyfwMk
	 dl5g9g4I9htbco3lTlRzcFAQZDMhLP5enEgWrXyyBa1HxoyjYPG4pEmOike2Kgl8UJ
	 BHVKQIotuJRelSWbhVQ0xTGxTyllhuy34/3zhksryfxW3AeJLYnk2VsDPjCProtGNk
	 WRJFhk8U/TmEw==
Date: Wed, 4 Jun 2025 14:40:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Blake Jones <blakejones@google.com>, Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH 2/3] perf: collect BPF metadata from existing BPF programs
Message-ID: <aEC9UqkKeEj4on3M@google.com>
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-3-blakejones@google.com>
 <aD9Xxhwqpm8BDeKe@google.com>
 <CAP_z_Cj_8uTBGzaoFmi1f956dXi1qDnF4kqc49MSn0jDHYFfxg@mail.gmail.com>
 <aD9sxuFwwxwHGzNi@google.com>
 <CAP_z_Cg+mPpdzxg-d+VV5J9t7vTTNXQmKLdnfuNETm1H40OA+g@mail.gmail.com>
 <aD9yte49C_BM5oA9@google.com>
 <CAP_z_Cg0ZCfvEFpJpvhuRcUkjV_paCODw2J61D3YQMm7dg0aGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP_z_Cg0ZCfvEFpJpvhuRcUkjV_paCODw2J61D3YQMm7dg0aGg@mail.gmail.com>

On Tue, Jun 03, 2025 at 03:29:35PM -0700, Blake Jones wrote:
> On Tue, Jun 3, 2025 at 3:10 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > Hmmm. Is that documented and tested anywhere? Offhand it sounds like an
> > > implementation detail that I wouldn't feel great about depending on -
> > > certainly not without a strong guarantee that it wouldn't change.
> >
> > Good point.  Maybe BPF folks have some idea?
> >
> > Anyway the current code generates them together in a function.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c?h=v6.15#n9825
> 
> It certainly does, yeah. But I don't want to have that become another
> instance of https://www.hyrumslaw.com/.

Thanks for sharing this.

I'm curious about the semantics of the KSYMBOL and BPF_EVENT.  And I
feel like there should be a connection between them.

Song and Jiri, what do you think?

Thanks,
Namhyung

> 
> > > Can you say more about why the duplicated records concern you?
> >
> > More data means more chance to lost something.  I don't expect this is
> > gonna be a practical concern but in general we should pursue less data.
> 
> That makes sense. In this case, it will only show up for BPF programs that
> define "bpf_metadata_" variables (which is already an opt-in action), and
> the number of variables a given program defines is likely to be quite small.
> So I think the cost of the marginal increase in data generated is outweighed
> by the usability and reliability benefits of being able to match these events
> 1:1 with the KSYMBOL events. If this proves to be a problem in practice,
> it can be revisited.
> 
> Blake

