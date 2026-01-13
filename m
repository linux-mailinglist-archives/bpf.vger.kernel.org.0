Return-Path: <bpf+bounces-78663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F32D16C3A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 07:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96A0F301CE98
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 06:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2CB366DC1;
	Tue, 13 Jan 2026 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyQ3nMc+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1FA41
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284533; cv=none; b=XUUrAjkFzve4PPhs1AH/b7IHXbu0NaiPUCaXBFCvWnHocg1/lLX0gxFYEeeSZYSmab13TaDXxP4Od69rrEXRzDGWrvQGrCoFWKWAIBA8mPpeNLmPr/lHaxyc4xbc7MFv/ZJ5g/cJu6gt9lc02y3XtEinYA1xkH8QVZC0F/ldT+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284533; c=relaxed/simple;
	bh=s+Zptr/HPYKDK7I+WrntNKJrNlP3RpkE+kxChvEy6nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlPiaWr78JyRmw1fLA+7FLwYxHFeRVG67govn3hple3ysmaDl9DqLA+Lk9HgkCpyBfNng+rWmce/HmSF5XVY7iAZFKaqXNJKgTnY8Q6JcFHww4NU2cNbLGUnpcicRDuTyaUwtG+XuEPuoV8PdE50/vdS6HfPCIyZfHyo2YIU6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyQ3nMc+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so55295e9.3
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 22:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768284531; x=1768889331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9ZSFs1AHwHUdEkUdQBHwokHKh6cloNR08U6DUqtuI0=;
        b=MyQ3nMc+ojltg9/JczXKRJjjnv5NV26iBkoU3YmLbiUrtVVOX3lwyA4KlW1/TsPqrf
         ZOdg0Z1v74vH0Lu4wf1sphvbTqpGDnzOWDwj3PtuQgKkfXdoZqoEaSm7xZE1KPnUo4qB
         BmfpPMpigsnJhgwN3DNblHFFbtH7a8us8o8o9hSpsPYNkVKHOYN6r6QsBavZJb68ha8g
         LhwmmxoOd2M9miemmfJJ1GnmdPWvjTCkDx8RZlsdyVSZ9YndcsQauZBJXzahu3y0Xfgt
         BkbnGwsN+sKFQyz0C/3KwjHvhEV8AblX1h7sszOSbXhywf7U410GQIWdWeVkl6uTWZk3
         P8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768284531; x=1768889331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9ZSFs1AHwHUdEkUdQBHwokHKh6cloNR08U6DUqtuI0=;
        b=qhOr2htMhOv4rs06O4RYw8QA+sd64MeIaxfaU73BvK3PQNPZlPi4NDpPeMg7DKMb4P
         ZhOAAExKELrv+VAkYKSKLe0T+fuvyGWk0bwDivZfR04NO8iv/MH6hR7aRq2655xA5c42
         T/UgY+6Oz+8j2W/fScH7cjKbQrXgfX2EzmdEhUZEJUCFLpXUHyC3DS6Asluk7+aJ3Tip
         Y0M4uDHDa1A5BwK0E2leaE57mMf9TzJ6r8n2RU7ixpJLcc7ij4TsY9r1kmYFLtB8BNwD
         6Y32defWRGxpwL9tj8YNXKuKDxW5bGibgwWDCHKcagFQH+3pDSUqFNK1WS8Brf8X40C/
         IZTw==
X-Forwarded-Encrypted: i=1; AJvYcCWf7bY508GCz4M6lcv0LVmPL34XEJ4hXP43zB6kO4bDqRIq6V2ZZ2OwRM2qQTmDE15zabc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0TAvoYeQhBJSFJY2XlKWHfaMGVo5BcsRMa3hNpVQcLxPEwbFc
	3MEqOpGbwkTBfDk4HZrf4Th0roJo7Pvuv6LRwJ3iZ0i30pOoxWOm2Rl5
X-Gm-Gg: AY/fxX4+2uGrS/78IDpWn+wwIzn6G9MeXsA18ePPUuoBoMeDFwvPd3ZyaIi2s1oxQu2
	O2jZi4s/20Q6bCFCKtXnuk+fPvsT+ODaZus+9EhFvvDGLP9zsTkD+zjTxs5JE7jkFPSTKSmGmNG
	o5Z/odRBXg4F3K2SSKgdCFMjY5ArbXSpPIJvqz94Ng5XnfTw12R9+PRb02LFxCtoLhk8kl8Jinm
	HGNvogUYf4IShOQ9GGWdUB3mpZyLc9UPnn+ZJzHKwQm40yNEy+Rx/g8hviyOHNVgrbR4/jT66fR
	/SpXQiFq1wpqDXpCS7d2hpU2KvF7CYLc9M45sHoJpwjpB6vLcx179HO6Qxzu/IQvXy73WsbG/vu
	Xqen9Rcghfkz++JB5DC3MHVKXyjDlIiHdLuk9ejg9ehtTJQSvPLEcGRlTZQqwmN7VGQRhDIQBv4
	/gtVj5RL1EvVsdNCrRPCJsweQ9Cla89lPLZoylK5Xfv3+Djg==
X-Google-Smtp-Source: AGHT+IG15wErQ03UH9DVDeoYCjGbCNvRirkF29C6VV/Z9728PIAUXXm8+rFEeW3TuGRjq5cyJFWLUA==
X-Received: by 2002:a05:600c:45c3:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-47d84b3f642mr218415835e9.33.1768284530620;
        Mon, 12 Jan 2026 22:08:50 -0800 (PST)
Received: from [10.221.200.118] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f620ac8sm378935045e9.0.2026.01.12.22.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 22:08:50 -0800 (PST)
Message-ID: <4261e437-84b2-4d0d-af52-c5ee7fcf07cb@gmail.com>
Date: Tue, 13 Jan 2026 08:08:48 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/10] mlx5e: Call skb_metadata_set when
 skb->data points past metadata
To: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, kernel-team@cloudflare.com
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-7-1047878ed1b0@cloudflare.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-7-1047878ed1b0@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/01/2026 23:05, Jakub Sitnicki wrote:
> Prepare to copy the XDP metadata into an skb extension in skb_metadata_set.
> 
> Adjust the driver to pull from skb->data before calling skb_metadata_set.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> index 2b05536d564a..20c983c3ce62 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> @@ -237,8 +237,8 @@ static struct sk_buff *mlx5e_xsk_construct_skb(struct mlx5e_rq *rq, struct xdp_b
>   	skb_put_data(skb, xdp->data_meta, totallen);
>   
>   	if (metalen) {
> -		skb_metadata_set(skb, metalen);
>   		__skb_pull(skb, metalen);
> +		skb_metadata_set(skb, metalen);
>   	}
>   
>   	return skb;
> 

Patch itself is simple..

I share my concerns about the perf impact of the series idea.
Do you have some working PoC? Please share some perf numbers..


