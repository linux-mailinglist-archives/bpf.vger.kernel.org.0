Return-Path: <bpf+bounces-35886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2F393F8E7
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 17:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C09D1F22CB0
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2315539F;
	Mon, 29 Jul 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCPE+ojv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118F4204F;
	Mon, 29 Jul 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265217; cv=none; b=LVzO1d5Q7mVyoy49K7tqSCKAyY8sC/jbyJqBz8UYw6ZIbnmqnua2dzcL7HPDmGhsfWoWZqQTuHkkiNiGvna0zLj5rIFyU4kXU525mv5coegxV2+HdgHaR7TutxLRAxkdLA/YZBwv8VwXbyIv5AismsJCcFEQK+JyavG1FqnF3fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265217; c=relaxed/simple;
	bh=SP81HaLYpX9r66j4fF+r/9B/OsLhtauDSo0XGdlEm1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0upRUDvuv2E0VOb2/D8riqPyU3rAerFkz8umlhr7pdN723BoRY/AnDWYl14maPpnkWKIMz/sxDCtFv08WuoNGel+V0Gmd86wu+0ULjH1V7uJtJ39gaSXPLswBO9cs8lSXecDOuQajyJLOOgnbY5hi1lN/mH4jexQC1br5xQJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCPE+ojv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74662C4AF0A;
	Mon, 29 Jul 2024 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722265217;
	bh=SP81HaLYpX9r66j4fF+r/9B/OsLhtauDSo0XGdlEm1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qCPE+ojvGlbjAbwmKxlIlwx9dUOunUYwN9vP+85/GpZE6D9mb9ur/eSbGfSnMLhBt
	 tVn2Xh3gBkVT0SDRaIzIx8/f6lr/kuUZRVgaM493p6ZoxmojdQAuWm3A45F645TUUg
	 P8A5InPAJJ7/8HDUgwUwKW1n6m0k5++xn4rTtqotdFc38if2HkSK9bp9XIuJWKipBF
	 +W6vb8PF3u3Y7deof1yffkS0q0Kpj3vh0kzw1voCmvhKe81DmIHjbT8I2Is2Yi6mHg
	 wWlWAgMhh8t1BRKnSNqsn0hRzxBrkDbAuLd+lucOxHDgGk01Cv++X4F+kjuoZ5iHj7
	 7foRA3krtPCyg==
Date: Mon, 29 Jul 2024 08:00:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, daniel@iogearbox.net,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, akpm@linux-foundation.org, brauner@kernel.org,
 oleg@redhat.com, kees@kernel.org, tandersen@netflix.com, mjguzik@gmail.com,
 willy@infradead.org, kent.overstreet@linux.dev, zhangpeng.00@bytedance.com,
 linmiaohe@huawei.com, hca@linux.ibm.com, jiri@resnulli.us,
 lorenzo@kernel.org, yan@cloudflare.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.10 10/27] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240729080014.2bfcd176@kernel.org>
In-Reply-To: <20240728005329.1723272-10-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
	<20240728005329.1723272-10-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jul 2024 20:52:53 -0400 Sasha Levin wrote:
> Subject: [PATCH AUTOSEL 6.10 10/27] net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.

no no no, let's drop this one, it's not a fix, and there's a ton 
of fallout

