Return-Path: <bpf+bounces-68088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D0AB52840
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 07:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C427316690C
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 05:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA5D253939;
	Thu, 11 Sep 2025 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQKN2SoS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858E243374;
	Thu, 11 Sep 2025 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757569630; cv=none; b=ssdosBSgrhqZ6P1mc4mb4f1vp0tTD/P8GEzMZhj+fWgTG/NUAsAqQtOU2yeyPLqiy6T736WszATJ103dHiYv7wWmkLxz4b6BLD7im9rfVUMGsYmGmVk/Dz6zCd+Pm0/aI4pbHHcxZhj54LNYDBisxLNaTPjbXm0gCbDxL578258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757569630; c=relaxed/simple;
	bh=H29XQbqzf7uX9bLD1wKXBfYJq2En/m9Eyd9XrTz9h+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pv8lUM0BNWtZSDLrjZP/q1qETwCe6JqcZpfZQlwSPJaPoxJEfjNe0UIYpapYUBbO2P+EuJ5NANVKlvAQuHD2p3hagzB3FDQV2m6AVFii29JUGoxjQBDV4bA02tD8xaDdi1/NTg6QrkOmEh4NxfqXWjyfBP7vXoxPiGYFY+4D0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQKN2SoS; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so157277f8f.2;
        Wed, 10 Sep 2025 22:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757569627; x=1758174427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QpubD4ieB+ScVRWQjNbWMrDq3IqqLUY92xxZ0P4UODo=;
        b=DQKN2SoS86xuJpVXKuHz0uzE6+Pmk8GLLetUndWnNvFM985cb6yW1EE8yIsOPZsFAv
         IkIAPWm4sCiQyEUbX36RSHG3eou5bnfdWQJiBSNemXHLwW2URftmdlXLUyFW06is5i7o
         vKTjom+8kld8JQ7OPXA7USbHWTKQbtvJAG1QBDsUB+6TUAjwOYqTSq6uYUAG6DieGIEb
         5Jz3B398IQNiaj2Vdf9ATPcXGCjCYjqIaPLbxiF/eBaVOKMyJyuvyjd7H+z6c61252JY
         DCzKlNiOwPKHOAZUpnfHsB06ILo6KPMGDTzacoiLQZE/Kh9CLbjpSJXyLNFI0mYqqe7K
         hp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757569627; x=1758174427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpubD4ieB+ScVRWQjNbWMrDq3IqqLUY92xxZ0P4UODo=;
        b=EdMQR6mzUn6FrdP2VgkSUxE7jX7z62aiqjqiu5YZU1nLa4GLByy3Advl1/T6X+On6e
         z3X33GMHm64i0rloTgl1c6lPglU9Ly0bSKtRRfwDRDMe9lEBuSDhT5BB0iN2vIgJy1Iq
         /yKawvFYziyCwaWxcy/3xCzzV4NQ2D12qXP9DSTgO6Bdfgc0zYLQ7/UhGesLwAS3gsnR
         p8900BBTXddLvpGA80vaPTOqSOwhWRE3cCGBm2WRgnTFLT+Xsz7e4gzapnr8T5wdc9l3
         YcjDzAw6sjL161TQsUAZxZtHa7jyHncueKOMW2+sya9YFK8aZLW7x0vFaSvl0rKM02/U
         SPXw==
X-Forwarded-Encrypted: i=1; AJvYcCWP44KBEmcg+BSRq/F86/PAbVzZ58xqwxbAAa2+q2982LzvgsuMJeWZo93i4m3+Dfk14jKY0n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygcA+6OvB6AgPxcwtkDG2gmqkweiTKsxI7UdJHTdBRs6cTBs37
	Nky1GY9OuY5HPT3WZRmjU0LuhrKOyLxwiTuztDGf92rWrRAb2JeyLHsr
X-Gm-Gg: ASbGncvqfE57+GbHy/4OFnvai6vtNhJDOZ6PPxTR5odfb+oAoGLrFzy0QJ4sX8GOMLE
	1pIH2YpiUHefKLJv8gWC02adUguQtDVFPg6RUv4MNq+yzk7TNFHpt39aVJBR5Kc+l7GSw7GTVeH
	cKYi+3o3+bEZw8FKarl5BmU+IYqPsYec1WnoafB9hZz14W96u0O0kIzsJ7zHTbdNvSueCAimW2c
	jcZqLAfIsYiT4E8CjqJx4MNZRiuP/PPlyttadsfqXPvYVOhLbqLKQhNfAt7OA/nPuzyIGc+8JHJ
	dNZhwBf4uMfds4C9fc7g0J3nQ5A1dvPRPSjlyhn+cV4h/FMHygeRbicX/1kXRatb8hGLnijIbG9
	HtlGUZy1wLVdX9kYIX2ktD92QwFDNxK1xUg5rLFgoTAdGMg==
X-Google-Smtp-Source: AGHT+IH4XDXUYBC3IyYI7m9BFssRePDq1TrN3jEhRxvwI3xkBjld6YESbLHoVhj0SOKMitZy55PW9A==
X-Received: by 2002:a05:6000:4028:b0:3e7:4620:4a99 with SMTP id ffacd0b85a97d-3e746204d6bmr12741520f8f.54.1757569626528;
        Wed, 10 Sep 2025 22:47:06 -0700 (PDT)
Received: from [10.221.203.56] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d7c0dsm1015990f8f.47.2025.09.10.22.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 22:47:06 -0700 (PDT)
Message-ID: <ea28ab1d-eace-4c6e-b5b4-2eb835eaaa64@gmail.com>
Date: Thu, 11 Sep 2025 08:47:06 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/2] net/mlx5e: RX, Fix generating skb from
 non-linear xdp_buff for legacy RQ
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 martin.lau@kernel.org, noren@nvidia.com, dtatulea@nvidia.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, cpaasch@openai.com,
 kernel-team@meta.com
References: <20250910034103.650342-1-ameryhung@gmail.com>
 <20250910034103.650342-2-ameryhung@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250910034103.650342-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/09/2025 6:41, Amery Hung wrote:
> XDP programs can release xdp_buff fragments when calling
> bpf_xdp_adjust_tail(). The driver currently assumes the number of
> fragments to be unchanged and may generate skb with wrong truesize or
> containing invalid frags. Fix the bug by generating skb according to
> xdp_buff after the XDP program runs.
> 
> Fixes: ea5d49bdae8b ("net/mlx5e: Add XDP multi buffer support to the non-linear legacy RQ")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Hi,

Thanks for your patch!

>   drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index b8c609d91d11..1d3eacfd0325 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1729,6 +1729,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
>   	struct mlx5e_wqe_frag_info *head_wi = wi;
>   	u16 rx_headroom = rq->buff.headroom;
>   	struct mlx5e_frag_page *frag_page;
> +	u8 nr_frags_free, old_nr_frags;
>   	struct skb_shared_info *sinfo;
>   	u32 frag_consumed_bytes;
>   	struct bpf_prog *prog;
> @@ -1772,17 +1773,25 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
>   		wi++;
>   	}
>   
> +	old_nr_frags = sinfo->nr_frags;
> +
>   	prog = rcu_dereference(rq->xdp_prog);
>   	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
>   		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
>   			struct mlx5e_wqe_frag_info *pwi;
>   
> +			wi -= old_nr_frags - sinfo->nr_frags;
> +
>   			for (pwi = head_wi; pwi < wi; pwi++)
>   				pwi->frag_page->frags++;
>   		}
>   		return NULL; /* page/packet was consumed by XDP */
>   	}
>   
> +	nr_frags_free = old_nr_frags - sinfo->nr_frags;
> +	wi -= nr_frags_free;
> +	truesize -= nr_frags_free * frag_info->frag_stride;
> +

New code section better be under if (prog), rather than running 
unconditionally.
Also move all needed new local vars under if (prog) to minimize their scope.

>   	skb = mlx5e_build_linear_skb(
>   		rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
>   		mxbuf->xdp.data - mxbuf->xdp.data_hard_start,


