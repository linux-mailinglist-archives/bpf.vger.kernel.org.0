Return-Path: <bpf+bounces-60147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF55AD34F2
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A631893302
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90C028A1E9;
	Tue, 10 Jun 2025 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuvPwHe1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6F227EA3;
	Tue, 10 Jun 2025 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555000; cv=none; b=EVA7ugL9x+8cyLgjlnDoc+H6PckHwXiVQ20XF2RRkYHjO7MSdV+URhcqPM6xl8f4pirs1C3YMN7khTZSlzcLJtGsyKbuv7MjRVUYVeap+D3BpgY2h54c5VWN3JukCiS1JMQ+hQ7DMiJzd9a5tFYQidynleaeoh6/dQlByCrslTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555000; c=relaxed/simple;
	bh=b5nUIzqm3EUmBKYjt0opVpGPnsw1G6P3eA2WugutoP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpXC7G7F0LdRn8JtpEmBRrTQh7vHLFh67NVS8PI9ywWt73RJ0xYBt43QjHrb0WjhKzl1TtVInrG2JdrE3m3HSpa1xqKN9X5cDcr20HL6WmRwmrnrRBRQ/rrBc5apC0bHrLlJZge30sb69TbRu2OIBg/NdD18A+paMr8qqzMFGcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuvPwHe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48035C4CEED;
	Tue, 10 Jun 2025 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749554999;
	bh=b5nUIzqm3EUmBKYjt0opVpGPnsw1G6P3eA2WugutoP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FuvPwHe1xCld1Q8ATLa4J8sn2DcS8xWs3+Kj5Uvn3Q/4nd3jXarHhvEInSuped4w2
	 sIQyPLJbJuTWqAevPBbwKTXTTwgDqA0wOHBEfcDyu6od9jeEH/a15ItmZUcPcMkCYf
	 vWQ+NNznSeTHp6GxWhQDZPVMiKbaxuzJrXnrfR2+29dnqXuEG2g24jIgtN2x6SE3+q
	 UGBbxt+C95dKwjUVozaTZISOGdv5dBJWKj7ac8eqLv22tONXYS5P3JS/SR7sQP0myG
	 xRTxh/GEHGo4Saf2sq3Qwsg0Dd0Ww5s/c1hrT+DAEazxMFSxfXc3T308tILHD5lWFH
	 UA4huvjkfXCpQ==
Message-ID: <2d7c6d00-692b-442c-931f-ace85f8b1477@kernel.org>
Date: Tue, 10 Jun 2025 13:29:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: cpumap: report Rx queue index to xdp_rxq_info
To: Ujwal Kundur <ujwal.kundur@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, aoluo@google.com, jolsa@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250609173851.778-1-ujwal.kundur@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250609173851.778-1-ujwal.kundur@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/06/2025 19.38, Ujwal Kundur wrote:
> Refer to the Rx queue using a XDP frame's attached netdev and ascertain
> the queue index from it.
> 
> Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
> ---
>   kernel/bpf/cpumap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 67e8a2fc1a99..8230292deac1 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -34,6 +34,7 @@
>   #include <linux/btf_ids.h>
>   
>   #include <linux/netdevice.h>
> +#include <net/netdev_rx_queue.h>
>   #include <net/gro.h>
>   
>   /* General idea: XDP packets getting XDP redirected to another CPU,
> @@ -196,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>   
>   		rxq.dev = xdpf->dev_rx;
>   		rxq.mem.type = xdpf->mem_type;
> -		/* TODO: report queue_index to xdp_rxq_info */
> +		rxq.queue_index = get_netdev_rx_queue_index(xdpf->dev_rx->_rx);

This looks wrong...
I think this will always return index 0

--Jesper

