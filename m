Return-Path: <bpf+bounces-56118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA191A9189C
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 12:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8524614D0
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F3722A7EB;
	Thu, 17 Apr 2025 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKsHkD7r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1263F1C84AD;
	Thu, 17 Apr 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884133; cv=none; b=rrxOIRTYTt+2Mwx86ndB7pN68oWmPdr9VeTfBQcbPCXJzpCNwN7muPjV/nJ5GtK+e6TLZD/RknP1v1unR9HYkb1EDdjfdW+THxZf93oL6qex9W+ptKmecQEDlvQ7jl+JeeAUOqDM30b6vDYo/DHVP7i1IbOymtaevPn6OeKPDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884133; c=relaxed/simple;
	bh=XtibpQDEDl52ybjDX3FPM3ylQII6ArvyrAJg1SURkcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzFYdmeM8beMuPldg9qUqjY0Uc/Wr9K/bIHMXTnhBVWBKrgly9sr2ud6OTjyMTCIsIUc9yXRqzSPAyTw64oCC3CqLJs/fYAbT79OUITSteI+yQ3IC5sX6gCwvx1Y+KLj8CrHS2dma40kiLHvyUfHUZuNAdbKPlB0sZ82qYIfYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKsHkD7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16227C4CEEA;
	Thu, 17 Apr 2025 10:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744884132;
	bh=XtibpQDEDl52ybjDX3FPM3ylQII6ArvyrAJg1SURkcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DKsHkD7rC+/0xFkrukJM7QORH/JIjHt2pWlrF9/E1u/eTfoZShufXjTSHvYpxzisu
	 WH2Q5BMASaPNVPUsqW+I1L1P1hFKgLGwR96eUmJEpV4IHI62zMq5T2JGLXFMa7IhwD
	 KNUffw279iTZGmRQn16DcT3eJARymj3yW8V+mYbPNX/9sgTi3PIYnTjUEb9x8wQYni
	 +C1214mI087LiW7+sl5unhFEt2TtOpu01Yxk1icpfJ6G5MJ5wlWYg/NtWv2t+l+9V3
	 VvzsnOWt6/kBkH989AWWrlHBsbJvZIfhXhnGtW27GT7/wzWB1KrAqN2x5tTxff1zQA
	 hKrbtT7vqiYhA==
Message-ID: <120f4e02-77cd-460f-809d-f0bf643884d1@kernel.org>
Date: Thu, 17 Apr 2025 12:02:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, dsahern@kernel.org,
 makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com, phil@nwl.cc
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
 <174472470529.274639.17026526070544068280.stgit@firesoul>
 <20250416063813.75fb83dc@kernel.org> <87r01si4xr.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87r01si4xr.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/04/2025 15.58, Toke Høiland-Jørgensen wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> 
>> On Tue, 15 Apr 2025 15:45:05 +0200 Jesper Dangaard Brouer wrote:
>>> In production, we're seeing TX drops on veth devices when the ptr_ring
>>> fills up. This can occur when NAPI mode is enabled, though it's
>>> relatively rare. However, with threaded NAPI - which we use in
>>> production - the drops become significantly more frequent.
>>
>> It splats:
>>
>> [ 5319.025772][ C1] dump_stack_lvl (lib/dump_stack.c:123)
>> [ 5319.025786][ C1] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6866)
>> [ 5319.025797][ C1] veth_xdp_rcv (drivers/net/veth.c:907 (discriminator 9))
>> [ 5319.025850][ C1] veth_poll (drivers/net/veth.c:977)
> 
> I believe the way to silence this one is to use:
> 
> rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());
> 
> instead of just rcu_dereference()
> 

Thanks for this suggestion.
Normally, this indicate I should add a rcu_read_lock() section around
for-loop in veth_xdp_rcv(), but this isn't necessary due to NAPI, right?

For background, this is because (1) NAPI is already running with RCU
read-lock held or is it because (2) BH is considered a RCU section?

--Jesper

