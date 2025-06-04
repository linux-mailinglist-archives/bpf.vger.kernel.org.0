Return-Path: <bpf+bounces-59685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFA6ACE696
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 00:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C2F1893F40
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77994224220;
	Wed,  4 Jun 2025 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTNYLMal"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A129A2;
	Wed,  4 Jun 2025 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749075143; cv=none; b=UgUCiBANBw43q/wiNLYVi8JvQL0GeonIH34oGzsBwilf04TwqAGS9rfFlN0oOCfCQwxWc0Nd3U5eOv8+qCjqrPE+WbzEWO1CR4bQclUkcm+gmEmSUEnWcLp3qEtiKBIgEwGbHELjW90X0KdT5EW0u/D7OcNuTXD4U/PLTFkMjYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749075143; c=relaxed/simple;
	bh=ZgNC/tzUGjuhabSWLf9s/V5Dj4iYLMJ7BsfBi8LCeDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXlxBfkTp7hI6am1UQYy8hwqeM3pFNkjwaRmA7lDAwDEaAF8kiUEJdmdvAtoBfg7S2l3mTZHPkYKk7M70As4GNR8LCByWQFpVmM5nI5b4ZUBVUhpyzVJT/UaGrXI9azLip6O+2X7aJIYxqJQAFpo+SO4RIHOPPR+onMVI41lRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTNYLMal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7931C4CEE4;
	Wed,  4 Jun 2025 22:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749075142;
	bh=ZgNC/tzUGjuhabSWLf9s/V5Dj4iYLMJ7BsfBi8LCeDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTNYLMalq6elO/8yeakwihsxnK3xe5UkzqTnVdvj9JT74aJBxwpgy1Foz0W+0aoXj
	 uZ3cbrt51gg0ovSDbusEIHfxRm1CiA7O19bpk/sC1M/4ZKRtoBLFKShyXV9S6ajM6+
	 Q5QjVH8AAMxJqXMbNlQfQAESEXBmZtBKXxPJHRVBOJNpFXyP3uW3o0VXpPv4KQ8hdA
	 XWTltp1U/6wqSQMnRagDlQJlYDY/l/foDyVLSJ02/Wkga+MhhIPC1ygW+418vVYkvm
	 lR5Hp9HDqTuqZ1OpViq/XiN5etrqzbBv0L95mmk9Tdz9CVGno+7ds6Zdh+NVVjGCts
	 IN744KBfKdVEA==
Date: Wed, 4 Jun 2025 19:12:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Blake Jones <blakejones@google.com>, Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 2/3] perf: collect BPF metadata from existing BPF programs
Message-ID: <aEDEw7bCDAtEXfGC@x1>
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-3-blakejones@google.com>
 <aD9Xxhwqpm8BDeKe@google.com>
 <CAP_z_Cj_8uTBGzaoFmi1f956dXi1qDnF4kqc49MSn0jDHYFfxg@mail.gmail.com>
 <aD9sxuFwwxwHGzNi@google.com>
 <CAP_z_Cg+mPpdzxg-d+VV5J9t7vTTNXQmKLdnfuNETm1H40OA+g@mail.gmail.com>
 <aD9yte49C_BM5oA9@google.com>
 <CAP_z_Cg0ZCfvEFpJpvhuRcUkjV_paCODw2J61D3YQMm7dg0aGg@mail.gmail.com>
 <aEC9UqkKeEj4on3M@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEC9UqkKeEj4on3M@google.com>

On Wed, Jun 04, 2025 at 02:40:34PM -0700, Namhyung Kim wrote:
> On Tue, Jun 03, 2025 at 03:29:35PM -0700, Blake Jones wrote:
> > On Tue, Jun 3, 2025 at 3:10 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > Hmmm. Is that documented and tested anywhere? Offhand it sounds like an
> > > > implementation detail that I wouldn't feel great about depending on -
> > > > certainly not without a strong guarantee that it wouldn't change.

> > > Good point.  Maybe BPF folks have some idea?

> > > Anyway the current code generates them together in a function.

> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c?h=v6.15#n9825

> > It certainly does, yeah. But I don't want to have that become another
> > instance of https://www.hyrumslaw.com/.

> Thanks for sharing this.

> I'm curious about the semantics of the KSYMBOL and BPF_EVENT.  And I
> feel like there should be a connection between them.

So, the comment in:

tools/perf/util/bpf-event.c

Is:

 * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
 * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
 * one PERF_RECORD_KSYMBOL is generated for each sub program.

which is not so nicely worded tho :-\

"One KSYMBOL per program", followed by "one KSYMBOL per sub program".

But that matches the referenced:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c?h=v6.15#n9825

So, for these bpf_metadata_ variables, would that be strictly per
program or would it be perf 'sub program'?

Couldn't get an answer from looking at tools/bpf/bpftool/prog.c, but
seems to be with progs, not subprogs, i.e. just the PERF_RECORD_KSYMBOL
associated with progs (not subprogs) will have those variables.

But then it seems those variables _are_ associated with at least one
PERF_RECORD_KSYMBOL, right?

- Arnaldo

> Song and Jiri, what do you think?

> Thanks,
> Namhyung

> > > > Can you say more about why the duplicated records concern you?
> > >
> > > More data means more chance to lost something.  I don't expect this is
> > > gonna be a practical concern but in general we should pursue less data.
> > 
> > That makes sense. In this case, it will only show up for BPF programs that
> > define "bpf_metadata_" variables (which is already an opt-in action), and
> > the number of variables a given program defines is likely to be quite small.
> > So I think the cost of the marginal increase in data generated is outweighed
> > by the usability and reliability benefits of being able to match these events
> > 1:1 with the KSYMBOL events. If this proves to be a problem in practice,
> > it can be revisited.

