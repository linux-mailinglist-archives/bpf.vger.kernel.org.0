Return-Path: <bpf+bounces-60150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E2EAD357D
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 14:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A8B3A9071
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 12:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381AF22D9F8;
	Tue, 10 Jun 2025 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAryIj0g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC14B4C96;
	Tue, 10 Jun 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749556910; cv=none; b=Z/XVPFAaEi73Q9sBHcs7B4x+GGyujGo5RdVaTcQXJTDvvnvzwzEVqDt1BLvTcmmZw3PR9kBitSIHXjjutdy/61AI22y8srQybNJeA8EOIsXzfwzSej91B8JFlyopAoBixanAc4Vfh4Jz4cCcT0gPMUH8xHVFGC6pL0sqAT0TC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749556910; c=relaxed/simple;
	bh=tvmLJ7I84f5E7KdYoF1dx2imxUaTzRl2oI5ecGPovPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=re/MNN4HwrT/HLmOgeIXf9akqDeHaGG1vojYT00dai1FrdFaYPYtAyn27wRHMB2x4BHBVb3RMeKXi0fiISfMDeTzNU5rWRG3hnFeyDeb0lBBJBR1y9RTLI+3Zncx2X74DE7OXJW/9x6LsHu0rDkHcSeBgf6Ph9wgeZDXjKuKrE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAryIj0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B14C4CEED;
	Tue, 10 Jun 2025 12:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749556910;
	bh=tvmLJ7I84f5E7KdYoF1dx2imxUaTzRl2oI5ecGPovPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sAryIj0gPbWxkb/KYsh7dul0WWGHTVsvvFJGWEy9nYcaRUhECosN2ncxnc3i4gNu6
	 07TCXjRzVaQqZRjaVVNeMn6oIzo3v7QyZsna5ZoYxYr1n9gMSVNNSi8NN8Bp/jcD+2
	 YcMt0i/kIupp0+lV7Ev4CzgH8YEmPxF1NEkTx59g/lm3YFQJyf3Pjj+YgsEv+XKsxj
	 38+WAKz5voiCvcdQDKjEyf6Z9gOYGFT1/aN+aapp5Nb9/JwjozrV+XrpsHZjbtxwt0
	 A+RkFTfv85NbK0Mto96tGjk9FbNC7aIKwFHA8LkMTr8XygQaBbtBLxXoyESz2CXUDQ
	 qz2W22arkOLmg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4CD901AF6B15; Tue, 10 Jun 2025 14:01:37 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Ujwal Kundur <ujwal.kundur@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 aoluo@google.com, jolsa@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH] bpf: cpumap: report Rx queue index to xdp_rxq_info
In-Reply-To: <20250609173851.778-1-ujwal.kundur@gmail.com>
References: <20250609173851.778-1-ujwal.kundur@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Jun 2025 14:01:37 +0200
Message-ID: <874iwnerfi.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ujwal Kundur <ujwal.kundur@gmail.com> writes:

> Refer to the Rx queue using a XDP frame's attached netdev and ascertain
> the queue index from it.
>
> Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
> ---
>  kernel/bpf/cpumap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 67e8a2fc1a99..8230292deac1 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -34,6 +34,7 @@
>  #include <linux/btf_ids.h>
>  
>  #include <linux/netdevice.h>
> +#include <net/netdev_rx_queue.h>
>  #include <net/gro.h>
>  
>  /* General idea: XDP packets getting XDP redirected to another CPU,
> @@ -196,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>  
>  		rxq.dev = xdpf->dev_rx;
>  		rxq.mem.type = xdpf->mem_type;
> -		/* TODO: report queue_index to xdp_rxq_info */
> +		rxq.queue_index = get_netdev_rx_queue_index(xdpf->dev_rx->_rx);

This is pretty nonsensical; the definition of the function you're
calling is this:

static inline unsigned int
get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
{
	struct net_device *dev = queue->dev;
	int index = queue - dev->_rx;

	BUG_ON(index >= dev->num_rx_queues);
	return index;
}

So passing dev->_rx to that function will always return 0; which is what
the field is already initialised to...

-Toke

