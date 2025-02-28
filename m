Return-Path: <bpf+bounces-52911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917D2A4A4BA
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F293B796A
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 21:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C811D61B1;
	Fri, 28 Feb 2025 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cheX9VB2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF5523F396;
	Fri, 28 Feb 2025 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777298; cv=none; b=cMCE//O40tZc8P0ELer5drX0avZqJfVyLvZP3IAdA57Dhnj/yoU+aXHjmMW7xIXT+WBe+3vUZC1fw4MGtis0Gli3pxN/uiHxZ649qHadoplBLLjx/Twe5Qnb70kzqnJngj5wcWGcOxGub9mWFnhDV7mByY7Pg3xsgqRMDEDia6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777298; c=relaxed/simple;
	bh=0XgvGcjUrAwi1kFAHtODcTmPecLThdWEAGMsndHtRX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFgkF65ZFE4mtoLem7K+YCGf3jKbiK3f9teTx83soBg0sL64VjnMG8uP+0ZuV9aNFn/zOedrBD5XE3K5jcM40REK/GLyc38KHrtjF4BUTZjGB5j4997PlTmKw3Yj8v4u5sEQw4WErTruoWyJiVv+A3GWtkQ3SMtVnjxko5q9rSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cheX9VB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA09CC4CED6;
	Fri, 28 Feb 2025 21:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777298;
	bh=0XgvGcjUrAwi1kFAHtODcTmPecLThdWEAGMsndHtRX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cheX9VB2F3cFfRmd1Gl4lfeCdap+/XacJavAsuSIa7b6/C/97Zs6/73MrYyujhUP2
	 1/s18H/+T2RML+Qv+ZeQseAuPFo2DDH06MYebP5r0U/+zfcw1vU+qdv0dQjsJCI6kh
	 2EMwywYjZ3cVDURu1+JKp5h/5Bfe7Okha0HVf2e9gVuCPULwBHf+4TK0gaCib5bQGJ
	 haysqSwmm6uY0+gOxm2F72qzHCjKYU2dl6IRPW44OYEKIZ7Cjp5IJpEgC2tnD0bkCq
	 KqfM4lEm4+ZKOLAe8PTlcIjuvgeI6x2jCGiBqEnu9lWoG2yIT+08mSSqahe+N4Kt6N
	 JVFZaZCoqpg4w==
Date: Fri, 28 Feb 2025 11:14:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.15 v3 3/5] sched_ext: Add
 scx_kfunc_ids_ops_context_sensitive for unified filtering of
 context-sensitive SCX kfuncs
Message-ID: <Z8InUDxSbSR_d3kk@slm.duckdns.org>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080648369E8A4508220133E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DKSgzZB5HZgYN8@slm.duckdns.org>
 <AM6PR03MB5080C1F0E0F10BCE67101F6F99CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQK1bekF9XH7EHCciXeyiB_W_jXBO9+tJoL17X0YtmGjng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK1bekF9XH7EHCciXeyiB_W_jXBO9+tJoL17X0YtmGjng@mail.gmail.com>

Hello,

On Thu, Feb 27, 2025 at 06:38:32PM -0800, Alexei Starovoitov wrote:
...
> > > Not from this change but these can probably be allowed from TRACING too.
> > >
> >
> > Not sure if it is safe to make these kfuncs available in TRACING.
> > If Alexei sees this email, could you please leave a comment?
> 
> Hold on, you want to enable all of scx_kfunc_ids_unlocked[] set
> to all of TRACING ? What is the use case ?

I thought it may be useful to be able to iterate DSQs and trigger
dispatching from there but

> Maybe it's safe, but without in-depth analysis we shouldn't.
> Currently sched-ext allows scx_kfunc_set_any[] for tracing.
> I would stick to that in this patch set.

I haven't thought through about safety at all and was mostly naively
thinking that if _any is safe _unlocked should too. Right now, unlocked has
two groups of kfuncs - the ones that should be able to sleep and the ones
that can be called from within scx_dsq_iter iterations. The former is
excluded from TRACING through KF_SLEEPABLE, I think. I don't know whether
dsq iteration is allowed in TRACING.

Anyways, not a real issue either way.

Thanks.

-- 
tejun

