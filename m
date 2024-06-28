Return-Path: <bpf+bounces-33370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C43C391C3E3
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 18:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BB2B21AD3
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 16:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06C61C9EC6;
	Fri, 28 Jun 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCogznlg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374414F136;
	Fri, 28 Jun 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592795; cv=none; b=ekSyjM0Va9WwTp3WCwIBxPHz5Bl278HdKQBxMIRPsARK/bm8eeBSBogGGbwVpAl12tF7Gxwu5UO/dynq33+EDFZiNmQQuMlEVZ4Yx5c41YFE7cwjvIqGeqgtnV3MrsloYiGtrKPGiaOW9I1uFvMwijvNhYnCScnT0OTIbIMg2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592795; c=relaxed/simple;
	bh=fn+F6SB9Tmcyy/VXFEjpwkfaczJIJalSNRk3f6//HJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLkQaXQJpXhMYqJXISqJGCtfDrsq2KOlSqVi0Hzsx8wn6f9MeqeysDdz68z3bubzxoG1BsuypChyuV5T4ose/BDhh/PydXk8JGSYfh+x1emSIXhfg0Ji54ohhfnxhT9ydZEPHYiSDhj48DA7sglcNvV6MqOUUt+N9NsPBlCjH7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCogznlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D29C116B1;
	Fri, 28 Jun 2024 16:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719592794;
	bh=fn+F6SB9Tmcyy/VXFEjpwkfaczJIJalSNRk3f6//HJ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tCogznlguilz2w8zBT7Jn9wl9oLOImWzxPVJdCpLfNQCpYWZckN3/jCvNdoWS3dlC
	 /uMMzd4MrCrq75hEO4iXUg5/1ppaRa7OgIQ/TvKCD83XJZKc9wng/nlFzHyMOMoJmj
	 p6GtGIg1+DnzbCe4K9T4Dj5uIajFVLfur5bzs8WgogZ3okn/QB5r1sIp94z1+fDoca
	 6NLwGKYmP+OR6wkqHdd0+6fteSk2znob2bFTikv19Yu8pnHNfqiLzSpdaACvhQ53Cj
	 AHbth61dJzI1AZHi4GvMNpeA6WlOIt7Z6BXI7QtHeGjt05s3m9imqUyMiJ+ZBeV7TC
	 43Y+T/43MSTRA==
Message-ID: <f565ea65-70e6-48ba-8467-355465a44a4c@kernel.org>
Date: Fri, 28 Jun 2024 18:39:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: Move flush list retrieval to where it
 is used.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Hao Luo <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Paolo Abeni <pabeni@redhat.com>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Thomas Gleixner <tglx@linutronix.de>, Yonghong Song <yonghong.song@linux.dev>
References: <20240628103020.1766241-1-bigeasy@linutronix.de>
 <20240628103020.1766241-4-bigeasy@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240628103020.1766241-4-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 28/06/2024 12.18, Sebastian Andrzej Siewior wrote:
> The bpf_net_ctx_get_.*_flush_list() are used at the top of the function.
> This means the variable is always assigned even if unused. By moving the
> function to where it is used, it is possible to delay the initialisation
> until it is unavoidable.
> Not sure how much this gains in reality but by looking at bq_enqueue()
> (in devmap.c) gcc pushes one register less to the stack. \o/.
> 
>   Move flush list retrieval to where it is used.
> 
> Signed-off-by: Sebastian Andrzej Siewior<bigeasy@linutronix.de>
> ---
>   kernel/bpf/cpumap.c | 6 ++++--
>   kernel/bpf/devmap.c | 3 ++-
>   net/xdp/xsk.c       | 6 ++++--
>   3 files changed, 10 insertions(+), 5 deletions(-)

Nice small optimization :-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

