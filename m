Return-Path: <bpf+bounces-36827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B794DBDD
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 11:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5CE6B21CE8
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 09:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEE314F130;
	Sat, 10 Aug 2024 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdF6L63C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F921A0B;
	Sat, 10 Aug 2024 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723281159; cv=none; b=H+rOxpCNBWDwqp+kutE58wV4THcj7KDGdlDIVhhxze/fb+5VuQzWe0tAsgVoI5qx+5nKpPsvLU7oVOYrITOqgHe//NBC40TlZ1bXhu8vkXtauvsN6oh+RIwXuBdMTxonVqIpzMUeGFXiEQWkd2Gke3nVybLV4j7/8v531b4DMkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723281159; c=relaxed/simple;
	bh=kETDzJtIbLOwXD4/xpys9fj3UYY1y3oAW9d2FSUpE4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIjs//CoQ3jrY8yH9ov3LJQCCLohmkEX2vGKhCQTPOtVfL+7ffKFLh+k78+TKW4Upc1f9Lw0qPEg6NT4KTVGmNJ1XmGJ12gKrBa5mpyVaH8nHTRuAmWDXrwpngb9mvkpTHnevpNtVYzGrsIEqvsI5pi+ZKZz91VStjVs4Wji93E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdF6L63C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F1BC32781;
	Sat, 10 Aug 2024 09:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723281158;
	bh=kETDzJtIbLOwXD4/xpys9fj3UYY1y3oAW9d2FSUpE4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdF6L63Cw8AtBFWqe5oIQYYv6quo0TPehC3NbXH/V3peL9ZcV58r0kSkmgU8Fhe5x
	 y8P+eO+Q15fIUMYk7hHtpdpFt9muxosR5NpZFtlRaeIzZqoMEW5+FOROUVtr2202w2
	 y6bJ3XGA0jVBluVOBtWp+VpXgpWSaqzGbD+puWsgVIrvGkhNxXJOaTruv2PSj5lou/
	 Gnt0nK0iIuDEImIuyueArWHXBmTENVgWPfp9sJjF/9jnM8Y08CIVaIBMmTQbdWRGeq
	 ODqt83kqB5K5Q6kulcFfs2r5kfzDZ4fHzrG+3ZD35+8emeFQ6hvnlaihLOkrRB8o05
	 VQgeh4xmphE2w==
Date: Sat, 10 Aug 2024 05:12:37 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	daniel@iogearbox.net, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com,
	kees@kernel.org, tandersen@netflix.com, mjguzik@gmail.com,
	willy@infradead.org, kent.overstreet@linux.dev,
	zhangpeng.00@bytedance.com, linmiaohe@huawei.com, hca@linux.ibm.com,
	jiri@resnulli.us, lorenzo@kernel.org, yan@cloudflare.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.10 10/27] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <ZrcvBQh53BKoSinL@sashalap>
References: <20240728005329.1723272-1-sashal@kernel.org>
 <20240728005329.1723272-10-sashal@kernel.org>
 <20240729080014.2bfcd176@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240729080014.2bfcd176@kernel.org>

On Mon, Jul 29, 2024 at 08:00:14AM -0700, Jakub Kicinski wrote:
>On Sat, 27 Jul 2024 20:52:53 -0400 Sasha Levin wrote:
>> Subject: [PATCH AUTOSEL 6.10 10/27] net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
>
>no no no, let's drop this one, it's not a fix, and there's a ton
>of fallout

Ack, will do. Thanks!

-- 
Thanks,
Sasha

