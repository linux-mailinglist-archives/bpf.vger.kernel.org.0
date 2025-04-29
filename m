Return-Path: <bpf+bounces-56957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D7BAA1059
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE2D846B98
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 15:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FA7221553;
	Tue, 29 Apr 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xz3vLE3Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77F1D2FB;
	Tue, 29 Apr 2025 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940167; cv=none; b=puLXp09J5QFARGM8WzAtErLS518QTj9bf1mK4mB21mic/8Ck+sw0v/AnTGEwN6G+lr110OCq6dMg1RoUQtv37VW+9NGhBtQeI++97VT0iQTMyCGkAITFBXxyw/Ets+IBu9CIMff6XGcVHEdccwUECKQe0VZ0Y+l4E409VPMsG5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940167; c=relaxed/simple;
	bh=sLZTqkYX+I6t5xbGQiBFcDp6YarT8zcQhgI0CSYOOCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnVZbKUON/nF56bjIf55csPTa0ZjFWLCHLh7bfo7QMbWzjC+4zRd09UPCzOGYYTEAI3OIoiDFA4/orXGYGqc6dsmgasJTwgSLg6MAx7OBhipWvA+erB1KMKHB9WklhKQnAgCythDPbzOMc4dTbcN/g1RjXRjxg8X0gpVUtGoZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xz3vLE3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CDBC4CEE3;
	Tue, 29 Apr 2025 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745940167;
	bh=sLZTqkYX+I6t5xbGQiBFcDp6YarT8zcQhgI0CSYOOCQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xz3vLE3YgOtNoghCWwd+di0me0x3CibIHQ6DTZE5k5vBifjscY/i/WSHYvlG+i/Z4
	 yCUXEGZv0LKOy014aI7FyfqUWvmD9dfmyvu3kSmzlax7y//kLQ6UUItr/8dJi60sIp
	 vhqdbgXDVYEyPmfxEBD6GTBuHmWaIJBdO1fZbgQL60af5yBx0yl/5k8A3dqOSiTkYl
	 sRSNUJYGikrZEYts+C1wO8RrlTpepXL3zORcrY8aUJNscuUCdxMmrf4/HfPZxpae05
	 EekrL2CWwW44KPdkIKp2hQgefenk2N3n/0pS8enatpwTkJcNOEYwmpfx1UMOpKzXvy
	 rluDQZwMtX0/A==
Message-ID: <c3855595-d8b4-4b4b-b1fb-0efa44d064b0@kernel.org>
Date: Tue, 29 Apr 2025 09:22:46 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] ipv6: sr: switch to GFP_ATOMIC flag to allocate memory
 during seg6local LWT setup
Content-Language: en-US
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels.dev@gmail.com>
References: <20250429132453.31605-1-andrea.mayer@uniroma2.it>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250429132453.31605-1-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 6:24 AM, Andrea Mayer wrote:
> Recent updates to the locking mechanism that protects IPv6 routing tables
> [1] have affected the SRv6 networking subsystem. Such changes cause
> problems with some SRv6 Endpoints behaviors, like End.B6.Encaps and also
> impact SRv6 counters.
> 
> Starting from commit 169fd62799e8 ("ipv6: Get rid of RTNL for SIOCADDRT and
> RTM_NEWROUTE."), the inet6_rtm_newroute() function no longer needs to
> acquire the RTNL lock for creating and configuring IPv6 routes and set up
> lwtunnels.
> The RTNL lock can be avoided because the ip6_route_add() function
> finishes setting up a new route in a section protected by RCU.
> This makes sure that no dev/nexthops can disappear during the operation.
> Because of this, the steps for setting up lwtunnels - i.e., calling
> lwtunnel_build_state() - are now done in a RCU lock section and not
> under the RTNL lock anymore.
> 
> However, creating and configuring a lwtunnel instance in an
> RCU-protected section can be problematic when that tunnel needs to
> allocate memory using the GFP_KERNEL flag.
> For example, the following trace shows what happens when an SRv6
> End.B6.Encaps behavior is instantiated after commit 169fd62799e8 ("ipv6:
> Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE."):
> 

...

> 
> To solve this issue, we replace the GFP_KERNEL flag with the GFP_ATOMIC
> one in those SRv6 Endpoints that need to allocate memory during the
> setup phase. This change makes sure that memory allocations are handled
> in a way that works with RCU critical sections.
> 
> [1] - https://lore.kernel.org/all/20250418000443.43734-1-kuniyu@amazon.com/
> 
> Fixes: 169fd62799e8 ("ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.")
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/seg6_local.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


