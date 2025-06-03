Return-Path: <bpf+bounces-59534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD7BACCDD2
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 21:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFFD3A69F8
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 19:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F9A21A444;
	Tue,  3 Jun 2025 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R32VR7JS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75952F2D;
	Tue,  3 Jun 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748980079; cv=none; b=Bph2/rXwSp3VIvUOwf0HVkfCdjTu/SvuA6Q6gvTIq72shxL6sb607br+PfrebuIwt4ejXJyj2VgHqloXBScwSW373IJFRXat18clpDU4kc8HSSy3HE3azWNjz6+Vf/r44s0jLXCFPu2VvN9a15/0YT7BfWK6oayAWlMR/ikTFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748980079; c=relaxed/simple;
	bh=LWkW+z8oJRiz4xGcOsRePMDjzkA2VpUFqR1OSJf6SaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhywXXijOfa3Co84lIgq1iguzYbN0LF4TRNiA05Nq+jR7i4s/ncuuXwmwq2YTg4KtS8TnE2hZjpHCfxPYnaTcmGcckrzY2r6n9SLu5TWFepK5dLZwO090cvNoAMZzzRrWKTnsMvqOMkyG4oRO6igiNHyhz7Ez+M4SS52RgNrdQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R32VR7JS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113CEC4CEED;
	Tue,  3 Jun 2025 19:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748980079;
	bh=LWkW+z8oJRiz4xGcOsRePMDjzkA2VpUFqR1OSJf6SaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R32VR7JSaFXPfNzlGHKKmE9xRZWE2lUsL5/u7kdwQttgeyqYCzMrp/FlZrgpyCFui
	 VBbhqC25Sm1i11M1gCsYbghA7bzBwWJuwt7N3tRODn7cyA3pQXx2Pcb8ypmA4AatSF
	 vum5dc3ARgAg/AnLKIGqLRjGXsJAHL8yZRsSWvd3JENEOStsm52ujsuJAilUaiM+Yd
	 uNKUMVZfIj5Adw0NxfQir2l5ClOClfurkJoPlRgn/qX9UI1ZepvHQmp1v8PS1pnfJ/
	 Gxmn0eVupgn4y8ftbEym6i522gM3w2QFamXW/8dNzjFTluY7uNPb24haCsAd6KrfwH
	 HdCTvPmCEsd2g==
Date: Tue, 3 Jun 2025 12:47:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Blake Jones <blakejones@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
	Ben Gainey <ben.gainey@arm.com>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/3] perf: add support for printing BTF character arrays
 as strings
Message-ID: <aD9RbG8ePGESPwRf@google.com>
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-2-blakejones@google.com>
 <aC9iF4_eASPkPxXd@x1>
 <CAP_z_Cg_vH1+BAm87U4gYQ0hDRGtHkkYb2DHtTRSd_QNvg3ZLQ@mail.gmail.com>
 <CAP_z_ChErhmooT5rhyXH8L-Ltkz3xdJ7PG20UKDpn9usMUgqTA@mail.gmail.com>
 <aDntjJcJsrQWfPkB@google.com>
 <CAP_z_CjLtMq_FvmijnFUQbD5UUw=T9jP_pHWCw5fS=38dgSh9g@mail.gmail.com>
 <CAP_z_Ch8hKvGvot7140ShuCZOxkb+7M7Wpa4AY-D-Arp9P5ffg@mail.gmail.com>
 <CAADnVQ+pnP-L7WOxBHGfiT2yF5WBWa_6=UccnYib8ugm+o6G3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+pnP-L7WOxBHGfiT2yF5WBWa_6=UccnYib8ugm+o6G3Q@mail.gmail.com>

On Tue, Jun 03, 2025 at 11:43:29AM -0700, Alexei Starovoitov wrote:
> On Tue, Jun 3, 2025 at 11:24 AM Blake Jones <blakejones@google.com> wrote:
> >
> > The libbpf patch set is under discussion right now. Once it converges,
> > is there a way to include those patches in the perf tree without
> > waiting for them to go up to the main tree and then back down? Could I
> > resend them here, or include them as the first part of my next patch
> > series?
> 
> Not really. libbpf is developed in kernel tree, sync to github
> and released from github.

But you can continue to work on the perf side after adding a feature
test.  I think we can accept the change once the libbpf change is
finalized.

It won't actually work until the both changes are merged to the
mainline in the next cycle, but you can test it locally.

Thanks,
Namhyung


