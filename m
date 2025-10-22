Return-Path: <bpf+bounces-71717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D251BFC041
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 15:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E3362392D
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44334CFC7;
	Wed, 22 Oct 2025 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="KMxgWjg4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D7934B67E
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137563; cv=none; b=CHbE/gwAea4gLk/uaKNxkdjaumEz1sp1K7Q8HK3rAUkWTszLncxCqW/b+mcu/hplwvr81aZyJEkfLNLDGNvxhNE/IPIZywdj59e/xoQAEPklUdsFksc4asUHtASBGty1P3UkKKPFxB1pmS/l42FbJ52vKnY/LGOcq4lMgXzljSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137563; c=relaxed/simple;
	bh=VZVgC1YwZPF1ZLzGTbrJlddJZQAeaUXbPPpVfaOy9UI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSg02js7T4lC+hSiacLQ/741QhwFGEr/hSnxYG5PKT2NwNWswXqc9pXkQny8/eWDja24ppJLvMuKdMLP0cxcneZWGboEjFGZLLiPtmTYUUtWZ192Cl4yFXBxjiEmk7hHfvu0r/KjiJvQKlkOfP3INLE3aCvRHiBTYun3kPG+flA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=KMxgWjg4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1538537166b.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761137554; x=1761742354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYtjFjyDSGPyQgAsiMBskSF57u8HRlpgh4uJI8sR664=;
        b=KMxgWjg4WNDjVE9XUxQ0yF54uDZslDDvlkcXgkbcy4fFDdFX0JKjzQgXxBNdV/qBr9
         CnjfnhJVbkTTouUy20LZ0+t4FARQ/6cRz5awgKB3efrATKQRBFGk2STigyJwrf/SyM9D
         KwNhIk8hfOiV5n7kVXPhvvMOSmc9ihswngmLaDwEwGC+j5E2BGNo1eY8for0xGwEVFcp
         J76R4ZPFMOn4EgGAquqxnexwRjGmt4eJ0CY/mQOdu4RLWklk9iYEGCTD68gNveTLatv8
         mbPM5oSpuRPVbam/RMU77ULjU9j3i7VLuYUDRkMcxyZ4GlgR7lqC5XBZV/73pCwU7g4T
         N6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137554; x=1761742354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYtjFjyDSGPyQgAsiMBskSF57u8HRlpgh4uJI8sR664=;
        b=q0O+uwD9evYaTCB44gWqR0Jzyex2BucLU+0THSO3M1c8cutsOHDRq5USakhuegkZtq
         oQPlmOCBB8k3UFrqqePpb2vaLCqWPIQOdSHe1DvZ2sWCSepuMBeuZqHY2NzzMTiAZM6J
         qOlKiABxtdClIwnVaEBF/3dU6e0wq+21cGdYQWR8fpAXDiubLEHMgwYxPTI6FiWSr0kh
         WXyezdjO73Sim5jmAEYxJgZ4xB6Q2fZ8j0r4wC9lvvIbpK0R8kVd5t36NAO2MAw0mAfw
         78fQ1kYwYNap/R4C1samcDCNBLiQhNI09WAR4PySwHeMwIOS9VjhBTIK/uVM9vWw7JNQ
         TqtA==
X-Gm-Message-State: AOJu0YyNYfJyUrnTdE0I4TEUTNzfJaDNgjxNOgtvQvvg5oll7OrScOtd
	SJVKNdDkqn/jB+N0X1UJNlRMOayNnMAhpzot3T/wvpEz/unRHPLw1nsFFg4xDWJxXfY=
X-Gm-Gg: ASbGncv/imRpcCN3NFUAm+xixH0n91f6BB/K0H8TPQ9O2qTcdw8nJ7VRu4IzIqFcpvR
	F/FecQV0j+i02IQPJyURlxkgExVUpOmiX2X9RRlRqJRoFW6iXlkpapT4dLCztN83yOZyhBukfax
	H6+jVcIW2tuoZVY/iI+B3BQqL6jqfg5b2/ge+nuMZf9WvFgcQ5cQoxJbI/Sciba2lc697SsKj0v
	2aqeKevfuPdo9qJvQ/K0wn3efP0E6L3GqBc+QBTdDCzBXHZbVX3YcI116TeaNeOQbDS9q1gaTgD
	imqxXZ2/K3k6gOnjetfLsXoK8IRqDaw9V4evgSbu95fHBbWC2QH3DKYp3ATKnnAcsilvIK3eXz+
	UGhrYSDONsfD4Xlto4UPrzI9j2hiaOX5fEcTxs44le1HmtdUKUbbLecf52B6tj4lHLdfCAzpn0C
	AT4JjpZowgRdbYzxhp4Hx0VQPaVvSg3eu0Qy4R/D4U3wPGfkFk/EXwVQ==
X-Google-Smtp-Source: AGHT+IHlE41iokHBpJyEUCj+aXxvQXK11Z67SspY9zznVrz/3HXGFHcj+KaHBOjAU60lWsLeWCydGw==
X-Received: by 2002:a17:906:9c82:b0:b38:6689:b9fe with SMTP id a640c23a62f3a-b6471d45a01mr2396441966b.7.1761137553282;
        Wed, 22 Oct 2025 05:52:33 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebb4ae4dsm1317990966b.74.2025.10.22.05.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 05:52:32 -0700 (PDT)
Message-ID: <330d315e-53c0-453e-9b5d-a432c2bbf7d5@blackwall.org>
Date: Wed, 22 Oct 2025 15:52:31 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/15] xsk: Add small helper xp_pool_bindable
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-9-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-9-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> Add another small helper called xp_pool_bindable and move the current
> dev_get_min_mp_channel_count test into this helper. Pass in the pool
> object, such that we derive the netdev from the prior registered pool.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  net/xdp/xsk_buff_pool.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 62a176996f02..701be6a5b074 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -54,6 +54,11 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs)
>  	return 0;
>  }
>  
> +static bool xp_pool_bindable(struct xsk_buff_pool *pool)
> +{
> +	return dev_get_min_mp_channel_count(pool->netdev) == 0;
> +}
> +
>  struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>  						struct xdp_umem *umem)
>  {
> @@ -204,7 +209,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		goto err_unreg_pool;
>  	}
>  
> -	if (dev_get_min_mp_channel_count(netdev)) {
> +	if (!xp_pool_bindable(pool)) {
>  		err = -EBUSY;
>  		goto err_unreg_pool;
>  	}

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


