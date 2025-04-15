Return-Path: <bpf+bounces-55964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5004CA8A32E
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BE33A7C56
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441952144DB;
	Tue, 15 Apr 2025 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifTFX7Ua"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C920E003;
	Tue, 15 Apr 2025 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731808; cv=none; b=Nhk12nXV1LuyiPl31+rNeTDM7QvenOBqsgTJ3BXuU6hGyDef0qCfkGQeArXXcZKgYLLjpPk+3j7cLUf8qBQ+c27g6hj/VLZqcDAaIFSB1aKVAakjtJfk/iYssdqio+T2HVwCG7QuT9LsHUJDCgmKi/DPrwnWgl4n1TgdiIAljXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731808; c=relaxed/simple;
	bh=ccucVTibC96ZiE4Hr+vlu4U/HFUEw1R8eJ/1QIq1PMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elEZ0qfqdlfXCt02D6F/5gNyYObDy9kWUG4qnjzsoSchVzHHj/vYIXwlQ2aj0b8c1Ilu5zHIGUoS1Oj77TcyFllzxxzf6cRbqU/hIKkUf7pSHeauYFntYdXldA4SL4Wv83VDFaVtCOVVhsBL61xsPWrRDJeGRqb4EIi8vgQ8cOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifTFX7Ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4B8C4CEEB;
	Tue, 15 Apr 2025 15:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744731808;
	bh=ccucVTibC96ZiE4Hr+vlu4U/HFUEw1R8eJ/1QIq1PMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ifTFX7Ua7Nbn0m/QP8+nFy/VLJx29jtfQVfAth5qMaRqnLiKKiVhnU7p2Z2PovKQo
	 uChH/Esdx8AnHOV3oQ4/4geGq/LY74Y5FmXH2gGpkmhushoEeFh5xReUjl1JFbyQld
	 syxlCD2xV3YT8wp8aKBwOFZDKCo2L68q4PNPsdlAzBO8Yk9AzTHcMZ0JtzeTdxwp8K
	 RDju9zjvaGHhktQ7BwU44t5hBezPXGhC/K831x0jH/wk4a+dSK54dr5xPcd7/dxKzC
	 rkDUNEiWtewS8loLsWu0iGFgdYGCCC8Aa85w7j2huxFBmv4tO26xCpK8tG1U77jTYZ
	 RqiwlFKmxyy/A==
Message-ID: <f448fcb8-6330-4517-863f-4bf0a2242313@kernel.org>
Date: Tue, 15 Apr 2025 08:43:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 1/2] net: sched: generalize check for no-queue
 qdisc on TX queue
Content-Language: en-US
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com, phil@nwl.cc
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
 <174472469906.274639.14909448343817900822.stgit@firesoul>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <174472469906.274639.14909448343817900822.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 7:44 AM, Jesper Dangaard Brouer wrote:
> The "noqueue" qdisc can either be directly attached, or get default
> attached if net_device priv_flags has IFF_NO_QUEUE. In both cases, the
> allocated Qdisc structure gets it's enqueue function pointer reset to
> NULL by noqueue_init() via noqueue_qdisc_ops.
> 
> This is a common case for software virtual net_devices. For these devices
> with no-queue, the transmission path in __dev_queue_xmit() will bypass
> the qdisc layer. Directly invoking device drivers ndo_start_xmit (via
> dev_hard_start_xmit).  In this mode the device driver is not allowed to
> ask for packets to be queued (either via returning NETDEV_TX_BUSY or
> stopping the TXQ).
> 
> The simplest and most reliable way to identify this no-queue case is by
> checking if enqueue == NULL.
> 
> The vrf driver currently open-codes this check (!qdisc->enqueue). While
> functionally correct, this low-level detail is better encapsulated in a
> dedicated helper for clarity and long-term maintainability.
> 
> To make this behavior more explicit and reusable, this patch introduce a
> new helper: qdisc_txq_has_no_queue(). Helper will also be used by the
> veth driver in the next patch, which introduces optional qdisc-based
> backpressure.
> 
> This is a non-functional change.
> 
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  drivers/net/vrf.c         |    4 +---
>  include/net/sch_generic.h |    8 ++++++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 


>  /* Local traffic destined to local address. Reinsert the packet to rx
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index d48c657191cd..b6c177f7141c 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -803,6 +803,14 @@ static inline bool qdisc_tx_changing(const struct net_device *dev)
>  	return false;
>  }
>  
> +/* "noqueue" qdisc identified by not having any enqueue, see noqueue_init() */
> +static inline bool qdisc_txq_has_no_queue(const struct netdev_queue *txq)
> +{
> +	struct Qdisc *qdisc = rcu_access_pointer(txq->qdisc);
> +
> +	return qdisc->enqueue == NULL;

Did checkpatch not complain that this should be '!qdisc->enqueue' ?


Reviewed-by: David Ahern <dsahern@kernel.org>


