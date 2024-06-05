Return-Path: <bpf+bounces-31429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2418F8FC915
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 12:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7821F236B9
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 10:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54C6191469;
	Wed,  5 Jun 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esl7LlX5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F4190048;
	Wed,  5 Jun 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583295; cv=none; b=mmZBAgCOxYKshFvEeQZ3PmjVSFGINIPdutL29BIHtBiHyqfbrB8yA6pxWd5PfngmPjm8oE4scn8PbMGpUsh72/tERFdoKLj2VLpEBP1bDx+pqPdljCX+M79oCEg5zDrsfK7/rTvAAOPND2f7aQwcJrpKi4/vo7bR47LwOfAIujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583295; c=relaxed/simple;
	bh=4OAyJRFBCWhd57GkH0+Vdq+6qk4KBfmFKqynSGutKcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5Eq9sFBJ6gXY9e+1keHwJuwnP23i7HmQR6qlRNwoNQYMrBfRxzGf6bDjC1mv6osQchkg/49/F4GNFfwcI4wYP0UlQZ/Bi4Ze4u8ZaX7dvSfygt4WX2dUV8MI6QnKRIFTTqrLFC89te1luA2VY44G8I003yRycSv+D8frqx1LZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esl7LlX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677D1C3277B;
	Wed,  5 Jun 2024 10:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717583295;
	bh=4OAyJRFBCWhd57GkH0+Vdq+6qk4KBfmFKqynSGutKcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=esl7LlX5Hnl8Wr9JETfxAYEr2uDnklk2I//XLWaX2U8G8sQtUs6478AnN5xPXyzlk
	 1YISe5y3JQs7yPRhd6aZBagykgnzk6SZT2X8D0Q7WNpY9s5ov2WQlD+edKude9G2Vf
	 8nQUKEHwwu6XDZ2d25FKNEqaRTYa2xf+daoAh0GrAcXLjgiOYDWcYcNlII0AcFJdlo
	 +yCytkmMMOICF5gQdpgeKKDZRm5h4qB1vh3IyA/AGe0hluv54GzAxo7kXCpAMr80DF
	 zSs2ZozWApgnn+VBvvY/1tiKPIntArhgdC6nmA59gkKvXi5K48dB/uLr+FFW9F8+78
	 ZbOBHUckptSRA==
Message-ID: <9afab1bb-43d6-4f17-b45d-7f4569d9db70@kernel.org>
Date: Wed, 5 Jun 2024 12:28:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
References: <20240529162927.403425-1-bigeasy@linutronix.de>
 <20240529162927.403425-15-bigeasy@linutronix.de> <87y17sfey6.fsf@toke.dk>
 <20240531103807.QjzIOAOh@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240531103807.QjzIOAOh@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 31/05/2024 12.38, Sebastian Andrzej Siewior wrote:
> On 2024-05-30 00:09:21 [+0200], Toke Høiland-Jørgensen wrote:
>> [...]
>>> @@ -240,12 +240,14 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
>>>   				int xdp_n, struct xdp_cpumap_stats *stats,
>>>   				struct list_head *list)
>>>   {
>>> +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>>>   	int nframes;
 >>
>> I think we need to zero-initialise all the context objects we allocate
>> on the stack.
>>
> Okay, I can do that.

Hmm, but how will this affect performance?

--Jesper

