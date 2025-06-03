Return-Path: <bpf+bounces-59562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FABEACCF9D
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 00:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CE51895F75
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 22:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14127253941;
	Tue,  3 Jun 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apt0Rs/F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807081A2643;
	Tue,  3 Jun 2025 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988600; cv=none; b=SaYdIpLSQbLrRefqeMESOR0NVl6+f+plYdg+zt7K6+ieQZAWK09U/vMxDv8oirRnnRZIKjpUhtLX3+ZzQyjHN9Q3noLt2iDHgueE0ZPdEKW9zjDI1UEm2C2r7ZVz8cnv9L6k0vSCLzSiAk/Ed7uu59PFDCdLpfyVqZyTrOVSUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988600; c=relaxed/simple;
	bh=yDwtTU7q5ftKQNzN/brcoLgZJNUcYEqPo41Z09sqrYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq9qJypbB4RKsqWLi+p6nc+aZeEXtCbz3as2fXDClEGr8pIePcw2mLPSnQkIGd8Ybmdu3AbVoSVcVeaPN3iGXrvTnEZoCVxjzvet1zwN0N3e26kHKovfEhJFnmCgS9ZcQBBx7YxE36CchfM/Oppjh1UiyiEVhGRkvl5EvhZC9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Apt0Rs/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BFDC4CEED;
	Tue,  3 Jun 2025 22:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748988599;
	bh=yDwtTU7q5ftKQNzN/brcoLgZJNUcYEqPo41Z09sqrYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Apt0Rs/FW6gf736dQ7/ejmjD8IszQ0GRdGw8RM8CkIvCUW5W90Q4FH11vJtYRblqv
	 9rBtkWZtP1QBc0roa36IRl6YBNwscgbBxKPNYTLm4Q8S83ewbFYqEBU9gdQ4vErvcl
	 AnSGRhGgcfbyionV6zX/0pca7M/EYPtc3JLL1wq3fLe35Vc2J/sK5kZHKxh4QpG6ov
	 ELZ7m7pqIdkCakQNZ54g8b8Ajwo5NXI1mkl1QFCQNCOcb7m+RzgD2gkdblyBDywx7O
	 ZLvgFm374M7uOMrUw9mIaP4CigRkLt9XBk4XZvoxaM8MfpnodsmvfUNDdmrmtcxIog
	 sUBaoSIdiNSFg==
Date: Tue, 3 Jun 2025 15:09:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Blake Jones <blakejones@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <aD9yte49C_BM5oA9@google.com>
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-3-blakejones@google.com>
 <aD9Xxhwqpm8BDeKe@google.com>
 <CAP_z_Cj_8uTBGzaoFmi1f956dXi1qDnF4kqc49MSn0jDHYFfxg@mail.gmail.com>
 <aD9sxuFwwxwHGzNi@google.com>
 <CAP_z_Cg+mPpdzxg-d+VV5J9t7vTTNXQmKLdnfuNETm1H40OA+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP_z_Cg+mPpdzxg-d+VV5J9t7vTTNXQmKLdnfuNETm1H40OA+g@mail.gmail.com>

On Tue, Jun 03, 2025 at 02:54:50PM -0700, Blake Jones wrote:
> Hi Namhyung,
> 
> On Tue, Jun 3, 2025 at 2:44 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > IIUC the metadata is collected for each BPF program which may have
> > > > multiple subprograms.  Then this patch creates multiple PERF_RECORD_
> > > > BPF_METADATA for each subprogram, right?
> > > >
> > > > Can it be shared using the BPF program ID?
> > >
> > > In theory, yes, it could be shared. But I want to be able to correlate them
> > > with the corresponding PERF_RECORD_KSYMBOL events, and KSYMBOL events for
> > > subprograms don't have the full-program ID, so I wouldn't be able to do that.
> >
> > It's unfortunate that KSYMBOL doesn't have the program ID, but IIRC the
> > following BPF_EVENT should have it.  I think it's safe to think KSYMBOLs
> > belong to the BPF_EVENT when they are from the same thread.
> 
> Hmmm. Is that documented and tested anywhere? Offhand it sounds like an
> implementation detail that I wouldn't feel great about depending on -
> certainly not without a strong guarantee that it wouldn't change.

Good point.  Maybe BPF folks have some idea?

Anyway the current code generates them together in a function.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c?h=v6.15#n9825

> 
> Can you say more about why the duplicated records concern you?

More data means more chance to lost something.  I don't expect this is
gonna be a practical concern but in general we should pursue less data.

Thanks,
Namhyung


