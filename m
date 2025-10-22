Return-Path: <bpf+bounces-71714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B0EBFBF90
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 14:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA505505B85
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 12:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361AD347BD1;
	Wed, 22 Oct 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HKwN8OeP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1113491C9
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137536; cv=none; b=DRnH6Y61rQlF68F9euH3Uj/fDfgpuFaUIvdCWXk9Oc9JIWr/73GovlFCJ1o92wAcjQ/LcR1/2z8LpOnA7hmrIfwWlFD9sp9BC5De9nfANdwxwOeuskK34L5VLgySy+0hRcrbZ9ZSs1ebJwyjTpeISmKydH+U1sLUYE0Vx7ALXWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137536; c=relaxed/simple;
	bh=kJHhhrYyKgYKexTzgIwJopTXyxMwS7j9M+0/ZQd5n+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2DNV/ZSX1ftEi0foIqT2WD6WL5dWBOhxji+ZT1xDxNRw+Us0a0YcX0N3QwJH4eGX31zbnFANmP7BB3Vqhl2f57RLVkbG6zbSD96bdGBqp9RwZdcnyJY5A4WNlNTrCRzhnNUpl0UQ4RDsFqfp7W1UcWtaHM4fYcaoPPRxLrI/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HKwN8OeP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c09ff13aeso12075462a12.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761137528; x=1761742328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGkRTGtX5VRtNncGlrnjJT92qVOFJfz+SCD1fTkUyjU=;
        b=HKwN8OePDIQ9CBQkdXsLgkvFGNQIDJAVy92gkeKEIe8agIudZlzN5RmREb4axBXTPb
         1SXtaLL/wj8d3uUAgVtpYUijwwHUrhYD0p4+P/mZ5wJyUIAJaIu3a4GJMxX8WOuCIeTS
         jIMw35EDs53rs7U04wphYG0exuxRMruD2AZOanIIozJ6pvuL1lHRRsCXEhLnivh+3mpN
         iX/NaVZHuh6PP4Yf8x1y4kXVRbIxXPNIUy8iKyMBQwREmbEKTEjhAB+FRA+bpljy7TG5
         xPrH2B3R+LqRGtR69jggz+wwGQ/qEKWawXOcFMG4WxZOk/Au8XE9YSsJEpv9tO2hxZ0y
         wtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137528; x=1761742328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGkRTGtX5VRtNncGlrnjJT92qVOFJfz+SCD1fTkUyjU=;
        b=h3e4+LdK/Z6iSZUE8qk5CeLDyKhFaOFFmXwN03Pm/UnTAC5RTVepRRCtjhefRjnx7v
         tcrC7RZM4a5oqWq9VXd5iLTJWI7O/Z1AymKl6g6rzM12bqD1fALnlErfDA8MVebGpzh/
         A1soNFAhG9cJgnEBYQlCVt1WVgp3Pu9RfywM/vJ9hs3HEEXEhyYYFnftVGueRSHAjRpj
         7zAD0dMjBDsZ3xOwE7hhu4aaXpb71o/w7AgB/gOdnt5H7iGDlmn4rbV5K3ubHxSSSLSv
         U8xlkLz68xq5wu0AlNLwTM2JA9FPbqtKQwQ4PWQk0dpOn++zgeVD+NHxXUD9aAvpW/lv
         tYyg==
X-Gm-Message-State: AOJu0YxCt4s4PTtC6+d7RRnKAFjsFpwAbA435zCWENzdhJlEyFFVjPT/
	rYzosebixAQiReqIfmiuNeEQYIytTJOP7ahEjX/e50TmflN7VpWxeKZpC7VbGZr82Qc=
X-Gm-Gg: ASbGncurUixA99k3rYnBtiGFBZmuYwcOMOj1qxNmowI1G4f3iSff/WNRuwVItPid1J2
	EvOSm5PqyFMfnMVa3Rc6hO4z16VRS8L4OrmbvT5oZ1qW52ciY20CDlVpf8E5KOvzFAEIZbsRBvy
	N0HE14I8xLImPFKSQX6yw7N4LV0wahoh4Hff4VbPbpRe2MxEKWs2e16G9uCL4BKr0D0kvon1sOH
	BSNj8Eh0IIDEuQHokYymqOdhsGe0OsOq3DkXhY5EBv+sgiLVTZK9mP9d9+FYKQZvpnRgkaLEyMw
	BRaphavpEDo7B4g2VTJZAk3891ogHH7uFGiJP5ubBuFypd0NewbC3SjhMF0s3pWLTh2ZlsOZ6Fa
	j2gJYmAwt+IHU25YAk0teS5paKAfaTo9BIeCL3YUROas5U6fEy4++KIshfBfYpnEBZbeRpxpjOb
	9c6npr2zhhqZ5AkzMzPtA6Uo8aw/EuJN46nyUzODQlY7Y=
X-Google-Smtp-Source: AGHT+IF6MXbvgO5FjwtHa42y+ByPHy6g3dQa9gyh0FKLccgvNLFAjykW8W1eT0Mf6L2mz1tna6nv1g==
X-Received: by 2002:a05:6402:398b:b0:63a:294:b02a with SMTP id 4fb4d7f45d1cf-63c1f640da1mr15389576a12.13.1761137527911;
        Wed, 22 Oct 2025 05:52:07 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab52b6sm12060841a12.10.2025.10.22.05.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 05:52:07 -0700 (PDT)
Message-ID: <5f99d86a-6409-4e4f-8e11-b990d6d99b68@blackwall.org>
Date: Wed, 22 Oct 2025 15:52:06 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/15] xsk: Move pool registration into single
 function
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-8-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-8-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> Small refactor to move the pool registration into xsk_reg_pool_at_qid,
> such that the netdev and queue_id can be registered there. No change
> in functionality.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  net/xdp/xsk.c           | 5 +++++
>  net/xdp/xsk_buff_pool.c | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7b0c68a70888..0e9a385f5680 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -141,6 +141,11 @@ int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
>  			      dev->real_num_rx_queues,
>  			      dev->real_num_tx_queues))
>  		return -EINVAL;
> +	if (xsk_get_pool_from_qid(dev, queue_id))
> +		return -EBUSY;
> +
> +	pool->netdev = dev;
> +	pool->queue_id = queue_id;
>  
>  	if (queue_id < dev->real_num_rx_queues)
>  		dev->_rx[queue_id].pool = pool;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 26165baf99f4..62a176996f02 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -173,11 +173,6 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (force_zc && force_copy)
>  		return -EINVAL;
>  
> -	if (xsk_get_pool_from_qid(netdev, queue_id))
> -		return -EBUSY;
> -
> -	pool->netdev = netdev;
> -	pool->queue_id = queue_id;
>  	err = xsk_reg_pool_at_qid(netdev, pool, queue_id);
>  	if (err)
>  		return err;

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


