Return-Path: <bpf+bounces-68089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F25BB528A2
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 08:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDF117586A
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 06:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100C12580EC;
	Thu, 11 Sep 2025 06:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5BDfAn8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F09170826;
	Thu, 11 Sep 2025 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571555; cv=none; b=Dc8zOxPBv7sG1NDOHx7v/bpTwTSRJNlPzNcNR/8X3miEp6BpHNogdFam9YbqljhqHyIGH3GniF1uKNwtCll7VsU0B3J0+PChb6y+8pKgRKQTRCsLxuqsQC5BQPFyEchvKxXg3fAtJc1TUHqS4f88cq5Qcm/G4ev+wuAGO0bp+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571555; c=relaxed/simple;
	bh=dTD0cGz2Uo1jWSkN9mB1baeUSbg33GlVpDGY7z4S/EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfywMLpfLk6CMtL1EIKKsO2GcNgYVDxVJdszrErtxkkZqd67cGZMt+3IyoFGQvURMZ6Jb7KJk+ZyrhX79IGnhgpddnV/1H4xCTgBHdUQycOwHXESzQT1Tn5rjUtQgjoWOlDIeG/WMUtWVRXhS2EBeUM66zfEooIEZxzQA7crDLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5BDfAn8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e34dbc38easo150647f8f.1;
        Wed, 10 Sep 2025 23:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757571552; x=1758176352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hpoq7cqtczkWR7khl7tumJVtpoP16XQx+8a/BNaWOWQ=;
        b=Z5BDfAn8xvCQ7Ije3MCAWiJ/XGK9f0swkUFX8oM6l/5O2rwVZ+imP4jex5DRfqexEC
         BhN4rkXgA3Q5uOhj9rmZTn7O/oDQ0QfsQw4JwdYGPkW8vOcIwkFmqwgrpRJOgvcsZSPr
         gcyDG76F4ZwsLNuSxRFFjbdwN/F+RRkFfhvImE71WeXq5c23Q6nUBeG/p6U9GRINphio
         ozm9rDEwI18ST3qaoMGHcCLDbPxRYQXHySY7EddXJFaHAVHKS5ZKpW5yHq0jo59N2KoM
         8un8hBX42jypto2QK7dxyBaNkIZBnZFvBvOSpEfuWL3QKOnls3AOqfJH5uQhoW5SYhf9
         llww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757571552; x=1758176352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hpoq7cqtczkWR7khl7tumJVtpoP16XQx+8a/BNaWOWQ=;
        b=GBcgkPN5xG+2UG9zqH59K5Um6l0gIN5X03PaE+mhz2B4Is3AYmUlLNDHB8LiLaC+l5
         3csbf2xtNj7T26sL7+fmpibPV5lEk/GHUza3+KJ7gtVk4+2JapNg/OGHiqn0d0OO5fkE
         aq9VxEcMZtyqYXBnoogiKkvn7cvRcx7HPOyaCEitGlUL8+nc7atJy3c8MuC21osCa5Lg
         z5vqT5tGmPxnAjHUGCBMFhk89OdMMVS8Z2/OX0TCvsmzG0nu9Zy88+iOjiq98gVEcGef
         40lSfjbRUgx1YOLHixw1h02Te463hAMd4UQ/pDrhRp5BgR66AyTyI9C7goOt9YjVf7/v
         VaAg==
X-Forwarded-Encrypted: i=1; AJvYcCW7SS3mreQpXxpL4Z+XMmXK4MO3hCalzzfZMEqD/Vm3q9xpIo89oPleW6/2hU2m9hnOMtu47lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaHAOtA5HqbMYnujVkdnjST4iSX6Fpn54w3D97quUv6DS318wX
	KFG6OVYl4mtwL4o6bSaLnId0eelHJlsZyHsLki75Fss+8shuo6Ogz5KR
X-Gm-Gg: ASbGncvvxvC5OBnJy1ZVV6uHolGkSDRYRicKsNEcaYjBoOZ3MnY6B08ToTXHQuiH14c
	C7S5bB+yi19etqeRUEDO13XYlhhCNPhzXKGUfEZb61MoQj7R4RgNQZb7ouuePo53UfqOnHjULie
	ddFtqKltlb9CjLwuGF3lIV24pLbc2pZy8kOIUVRZ9MDmDjmHMKqgIkbuwwIdIW7uBwHVhz1EvC4
	lz8Oxuc478Eal0v0b2R7Zncov0VP22z5rVhHIXPyvr5XevfZ+X8gfucMLawJ4OB9b3380XmMvqv
	lUfl/o8VkXxqro1X8n1oE3UMdZzbhJaUat0ggh99tk6wrWi58+/2Sbqq4WRcuPY82x1OQuHawS/
	CYrmo1+JJ48zajVuq1fSoN+kYhu8t0Lj63EqfU15TKE6JNA==
X-Google-Smtp-Source: AGHT+IG5zymW4WVcmYoVjDy8SO33HJRxu7OFm/LAnNIw4AuNNwnvNZHL5mtK6ZyU7Ys+pPZDX1jxyw==
X-Received: by 2002:a05:6000:4021:b0:3cd:e63a:cfd5 with SMTP id ffacd0b85a97d-3e64ce4fd38mr17882871f8f.56.1757571551605;
        Wed, 10 Sep 2025 23:19:11 -0700 (PDT)
Received: from [10.221.203.56] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037b91e6sm10306515e9.14.2025.09.10.23.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 23:19:11 -0700 (PDT)
Message-ID: <5b41324c-34d2-4b19-9713-43e118e5629c@gmail.com>
Date: Thu, 11 Sep 2025 09:19:11 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 2/2] net/mlx5e: RX, Fix generating skb from
 non-linear xdp_buff for striding RQ
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 martin.lau@kernel.org, noren@nvidia.com, dtatulea@nvidia.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, cpaasch@openai.com,
 kernel-team@meta.com
References: <20250910034103.650342-1-ameryhung@gmail.com>
 <20250910034103.650342-3-ameryhung@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250910034103.650342-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/09/2025 6:41, Amery Hung wrote:
> XDP programs can change the layout of an xdp_buff through
> bpf_xdp_adjust_tail() and bpf_xdp_adjust_head(). Therefore, the driver
> cannot assume the size of the linear data area nor fragments. Fix the
> bug in mlx5 by generating skb according to xdp_buff after XDP programs
> run.
> 
> Currently, when handling multi-buf XDP, the mlx5 driver assumes the
> layout of an xdp_buff to be unchanged. That is, the linear data area
> continues to be empty and fragments remain the same. This may cause
> the driver to generate erroneous skb or triggering a kernel
> warning. When an XDP program added linear data through
> bpf_xdp_adjust_head(), the linear data will be ignored as
> mlx5e_build_linear_skb() builds an skb without linear data and then
> pull data from fragments to fill the linear data area. When an XDP
> program has shrunk the non-linear data through bpf_xdp_adjust_tail(),
> the delta passed to __pskb_pull_tail() may exceed the actual nonlinear
> data size and trigger the BUG_ON in it.
> 
> To fix the issue, first record the original number of fragments. If the
> number of fragments changes after the XDP program runs, rewind the end
> fragment pointer by the difference and recalculate the truesize. Then,
> build the skb with the linear data area matching the xdp_buff. Finally,
> only pull data in if there is non-linear data and fill the linear part
> up to 256 bytes.
> 
> Fixes: f52ac7028bec ("net/mlx5e: RX, Add XDP multi-buffer support in Striding RQ")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Thanks for your patch!

>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 21 ++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 1d3eacfd0325..fc881d8d2d21 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -2013,6 +2013,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>   	u32 byte_cnt       = cqe_bcnt;
>   	struct skb_shared_info *sinfo;
>   	unsigned int truesize = 0;
> +	u32 pg_consumed_bytes;
>   	struct bpf_prog *prog;
>   	struct sk_buff *skb;
>   	u32 linear_frame_sz;
> @@ -2066,7 +2067,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>   
>   	while (byte_cnt) {
>   		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
> -		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
> +		pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
>   
>   		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
>   			truesize += pg_consumed_bytes;
> @@ -2082,10 +2083,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>   	}
>   
>   	if (prog) {
> +		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
> +		u32 len;
> +
>   		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
>   			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
>   				struct mlx5e_frag_page *pfp;
>   
> +				frag_page -= old_nr_frags - sinfo->nr_frags;
> +
>   				for (pfp = head_page; pfp < frag_page; pfp++)
>   					pfp->frags++;
>   
> @@ -2096,9 +2102,16 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>   			return NULL; /* page/packet was consumed by XDP */
>   		}
>   
> +		nr_frags_free = old_nr_frags - sinfo->nr_frags;
> +		frag_page -= nr_frags_free;
> +		truesize -= ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz)) +
> +			    (nr_frags_free - 1) * ALIGN(PAGE_SIZE, BIT(rq->mpwqe.log_stride_sz));

This is a very complicated calculation resulting zero in the common case 
nr_frags_free == 0.
Maybe better do it conditionally under if (nr_frags_free), together with 
'frag_page -= nr_frags_free;' ?

We never use stride_size > PAGE_SIZE so the second alignment here is 
redundant.

Also, what about truesize changes due to adjust header, i.e. when we 
extend the header into the linear part.
I think 'len' calculated below is missing from truesize.
> +
> +		len = mxbuf->xdp.data_end - mxbuf->xdp.data;
> +
>   		skb = mlx5e_build_linear_skb(
>   			rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
> -			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
> +			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, len,
>   			mxbuf->xdp.data - mxbuf->xdp.data_meta);
>   		if (unlikely(!skb)) {
>   			mlx5e_page_release_fragmented(rq->page_pool,
> @@ -2123,8 +2136,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>   			do
>   				pagep->frags++;
>   			while (++pagep < frag_page);
> +
> +			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len, skb->data_len);
> +			__pskb_pull_tail(skb, headlen);
>   		}
> -		__pskb_pull_tail(skb, headlen);
>   	} else {
>   		dma_addr_t addr;
>   


