Return-Path: <bpf+bounces-57193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515C9AA6B6E
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 09:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D42B3AECA2
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A6621B180;
	Fri,  2 May 2025 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqFVcs+m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602B319DF41;
	Fri,  2 May 2025 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746170175; cv=none; b=hacfcBlJt9CfjG2uEPyujxg1rB6St7L4mVOzS9TwKHApxQQf4omUq9kq6jW3tei+qY0qCmlMwGfaQEC5DCVw/XMfUByFlI8ZllobvUtevejFoRYPDz0vAK1M6itiM4bDHx63JEBYcEWznfx2a6vEolCuEehw2Ie1Xbx950gmFnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746170175; c=relaxed/simple;
	bh=2ogR7mfOhi8SAd6iUoSl0ROEi0IAYvwqSFk3KRePUPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALZPpsqlNHxanuawmmQMedSXeskaOCSFf2k7KP4MNBUkvz0COPgqQq3FIiY9fBL1diD4fCSbdGyliBMzcy3JmMpYL6SeGMdVRsM5XUFy8fk7vyXyqedn6RneCsyOfzcTQqpKne42XQeHqvZgW1Uw5nkPEvL5b4z0P1Gii587TjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqFVcs+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA457C4CEE4;
	Fri,  2 May 2025 07:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746170174;
	bh=2ogR7mfOhi8SAd6iUoSl0ROEi0IAYvwqSFk3KRePUPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nqFVcs+m7CD22XXjLVFYTwWYYNfjvquVL6Xm+Qe5tdQ8rKzT+HRRM1HJEJUTVkzl8
	 YtzzrLxmj+D+KKSNCinTu+utxmemTZej0K2+MDFm0BDGsWZ/qkqWX9d3TMsal2k7Gx
	 YPs5Er8oQ3EbhPLmtdVVzNQgFewOqoSIvrJBoRVOqbT7zlvdfp64oOY0rcyAvU2UTO
	 NcB7wDURJ+Wgg79KooIqI6zfzzIvmkeZpZS8bjXuIvqMhvoqgAKKhRswVMOeZ2Ft26
	 f2GufgW8o+Ts0IFQByjedILDPEVwrmBJG+YN1BVkQPwcRunKeiObJnoGG8oZNisLlw
	 c6v2FQeoL3SJA==
Message-ID: <0608a65d-f657-4ef3-aeea-7b2664aa7625@kernel.org>
Date: Fri, 2 May 2025 09:16:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/4] Bug fixes from XDP patch series
To: Meghana Malladi <m-malladi@ti.com>, dan.carpenter@linaro.org,
 john.fastabend@gmail.com, daniel@iogearbox.net, ast@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 danishanwar@ti.com
References: <20250428120459.244525-1-m-malladi@ti.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250428120459.244525-1-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/04/2025 14.04, Meghana Malladi wrote:
> This patch series fixes the bugs introduced while adding
> xdp support in the icssg driver, and were reproduced while
> running xdp-trafficgen to generate xdp traffic on icssg interfaces.
> 

This patchset clearly hurts performance by introducing a lot of locking.

Can you please report what the performance regressions this is introducing?


> Meghana Malladi (4):
>    net: ti: icssg-prueth: Set XDP feature flags for ndev
>    net: ti: icssg-prueth: Report BQL before sending XDP packets
>    net: ti: icssg-prueth: Fix race condition for traffic from different
>      network sockets
>    net: ti: icssg-prueth: Fix kernel panic during concurrent Tx queue
>      access
> 
>   drivers/net/ethernet/ti/icssg/icssg_common.c | 22 ++++++++++++++++++--
>   drivers/net/ethernet/ti/icssg/icssg_prueth.c | 16 ++++++++------
>   drivers/net/ethernet/ti/icssg/icssg_prueth.h |  1 +
>   3 files changed, 31 insertions(+), 8 deletions(-)
> 
> 
> base-commit: cc17b4b9c332cc654b248619c1d8ca40d80d1155

