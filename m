Return-Path: <bpf+bounces-67356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4C6B42D80
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B987816E82D
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 23:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE5E2BDC1D;
	Wed,  3 Sep 2025 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtnVAY42"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D96824677D;
	Wed,  3 Sep 2025 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942742; cv=none; b=Mc0h7oxHEBu+bEnrBgKN9B2ZLsJpGyiluX9WKbaGyDFE6hkdZRDxyQn1PiBWj0e4LU8aysepUEY4NmFdpoIxrgZFZ9XJtFKAWYSNAybrNAbjLNKplXzJEpCl9LsfkcO5v8+z+iJ4EfFlPurLa804J4aHr14z286NmTscKnqE8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942742; c=relaxed/simple;
	bh=RZOICfDiuL5KBp01Tpbggkwd+ps6zFVvHSlxZn9X+Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnpO0byjVwJUrrqoBfyMPC7Z1kBghXGT9j753VTmO0ND5Q2Uf21QD8RaxNVb5N1GQE7/lpxaKuCqE9PrRaSYY4tDk3O1NcYO7feSnm7QH+9OV6Xb0309nnfUwS6HKUcGrDX1i3Y181wXr7A9IYqkWZ0ess9iR/i5aS+yPutQd90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtnVAY42; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b471737b347so244664a12.1;
        Wed, 03 Sep 2025 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756942740; x=1757547540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z12ABXWEzXqZcaHBvu7IqMQ7zDyeIiaeHwQRXzioUPU=;
        b=BtnVAY42jmdaxWsYHLS3I85t1p5MqRlqXUX2An3kPEDho5hhaK0HUuAOtqKtFAxAs6
         WEodhXSOyU/KTX6nt9pGwfJWhE9K3ixyZM0vjCoFm7n0nn9qt8gHeinZH+jyFjEQuD5t
         BfAi8ktjvf5zEs3cE74zzo/6uZtXte7k6s4WE1dw05WAJpGahpxytxO2+d6y32odGe9e
         9lGei1c0PGGgDT2zfvSQlmG3Qghz5sNjN1y7Cnxb96YXzkMuQgJ+IPzzWb2/GkaHlB+x
         2P7+8lc7fcb+oBsGkZFvyLHZlRQBNhL1ODZtWPxYku9FJ4yRM2Z71mBbtuxg8Jp2atUU
         H1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756942740; x=1757547540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z12ABXWEzXqZcaHBvu7IqMQ7zDyeIiaeHwQRXzioUPU=;
        b=KnBn9VR/NtoofKYw+oJvnilHpIEvx8GbsvCWlXVuowc6BiaUiIQ6y2bctwKu/T8VFb
         c7N5sFCZIdrjQdA+2MQFoulbLuMPBPgdY61xzI+6neP5aE4BQv1jGw/X3rLI3IX7IK6A
         N8cq6pU0c85wTBWwhn8APA2yw9n4afhOD5hsJEJqind/ZQOjfzHA2+Yg7xjxFvXoEnoW
         pjr2aEYhMz7XXrv8fVzJ7cpiI+CKi++22LEu5qTvAnFdaQYdGL3UNbM2KCufJUNC5zmT
         +JlaZ0wkEEA21yioRKAg1AhCv78TmFRkqFLDsQsOXR8uW5yzcShT73gXa1py4SwZKhRk
         Tdog==
X-Forwarded-Encrypted: i=1; AJvYcCVVK1ypy7KVF3xzxgGs1LjB/cD9/vzW5Sh0669bJVyNiz4vrB6WMK6W1xlCZATan7Rh9e3Gywc8rXMbYA==@vger.kernel.org, AJvYcCWxcqf8Z7Eeh92dAMAGbI8ANIxreqp/KblYl33NyqZqcyw7Uru5kJfSbWzraGNwluMV1Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YweWTCmE4aAoCR2GC7Y4S2CJWl1hL5WlDhpPdaFak0wUSCsR5uL
	IHCiQCowMSwiiAXw2gjH8lBWjXGxS8Ed8nds7tjI3KrAq5ID0wFBR0KR
X-Gm-Gg: ASbGncufPAp8zBEpgg46Lvwh+LirO62+3mtgwlVImGk/mTgqdk6h7Ucuk/bgzWsmhwS
	Lrmn91ATVHGzWgUwKxoGe4dcrtPwj3cvaHczkfs/TcXdkbXzLkpXPsFAdLmWHkpO7lLsalFZedS
	ZNs9JSdWk9XRq3hkiaIHIpsIbSyN5au2Z0fwnFK4umKazNHkjElkNo+Rkp3Yl9oFwGdqwpwCeEc
	NW72tV+qc9gfWYlWyb7yuKFvTP0arJZAdapJVUB6+VshSQEGYwrBXOM4jPcFHheelAJ19NI5q0O
	faErnMD7LIvU5ZRoJunYCVLfU3rs4VO5brL+BgGbiRj/uB5jjc9G09griOHLwojc94K1yUNPi3t
	RwLgNkDvr9WEXARCwId3FoAtjB0M6SUWINP8AufubF2xKw8yljxxSkuNEFI2Ki25P0ObBvlBoYM
	4o
X-Google-Smtp-Source: AGHT+IFlVlW4wyVFzJGmUC434Y82dVvdmWR0zRlrKzhgQnQHqYzNdkO9p8Iz4i88nTLylMED71XEJw==
X-Received: by 2002:a17:902:d4cb:b0:246:cc24:3934 with SMTP id d9443c01a7336-2494487342emr242374005ad.1.1756942740363;
        Wed, 03 Sep 2025 16:39:00 -0700 (PDT)
Received: from [172.37.169.159] (245.sub-97-133-23.myvzw.com. [97.133.23.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b2570cfc8sm50926475ad.76.2025.09.03.16.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 16:39:00 -0700 (PDT)
Message-ID: <b840533a-25e1-4884-9d9e-222d9bf79635@gmail.com>
Date: Wed, 3 Sep 2025 16:38:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: cpaasch@openai.com, Gal Pressman <gal@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-2-bfcd5033a77c@openai.com>
Content-Language: en-US
From: Amery Hung <ameryhung@gmail.com>
In-Reply-To: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-2-bfcd5033a77c@openai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/28/25 8:36 PM, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
>
> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> bytes from the page-pool to the skb's linear part. Those 256 bytes
> include part of the payload.
>
> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> (and skb->head_frag is not set), we end up aggregating packets in the
> frag_list.
>
> This is of course not good when we are CPU-limited. Also causes a worse
> skb->len/truesize ratio,...
>
> So, let's avoid copying parts of the payload to the linear part. We use
> eth_get_headlen() to parse the headers and compute the length of the
> protocol headers, which will be used to copy the relevant bits ot the
> skb's linear part.
>
> We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking
> stack needs to call pskb_may_pull() later on, we don't need to reallocate
> memory.
>
> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> LRO enabled):
>
> BEFORE:
> =======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>   87380  16384 262144    60.01    32547.82
>
> (netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>   87380  16384 262144    60.00    52531.67
>
> AFTER:
> ======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>   87380  16384 262144    60.00    52896.06
>
> (netserver pinned to adjacent core receiving interrupts)
>   $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>   87380  16384 262144    60.00    85094.90
>
> Additional tests across a larger range of parameters w/ and w/o LRO, w/
> and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
> TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> better performance with this patch.
>
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 8bedbda522808cbabc8e62ae91a8c25d66725ebb..792bb647ba28668ad7789c328456e3609440455d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -2047,6 +2047,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>   		dma_sync_single_for_cpu(rq->pdev, addr + head_offset, headlen,
>   					rq->buff.map_dir);
>   
> +		headlen = eth_get_headlen(skb->dev, head_addr, headlen);
> +

Hi,

I am building on top of this patchset and got a kernel crash. It was 
triggered by attaching an xdp program.

I think the problem is skb->dev is still NULL here. It will be set later by:
mlx5e_complete_rx_cqe() -> mlx5e_build_rx_skb() -> eth_type_trans()


>   		frag_offset += headlen;
>   		byte_cnt -= headlen;
>   		linear_hr = skb_headroom(skb);
> @@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>   				pagep->frags++;
>   			while (++pagep < frag_page);
>   		}
> +
> +		headlen = eth_get_headlen(skb->dev, mxbuf->xdp.data, headlen);
> +
>   		__pskb_pull_tail(skb, headlen);
>   	} else {
>   		if (xdp_buff_has_frags(&mxbuf->xdp)) {
>


