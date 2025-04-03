Return-Path: <bpf+bounces-55208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE18A79CDD
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 09:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3069A7A1A5C
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 07:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE4F24113D;
	Thu,  3 Apr 2025 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZye6mhy"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C3F23F42D
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665055; cv=none; b=iwMnvyEPjJvg0YbOOGpx9+136ypP2xLNcHb/FyCLLbNFrv/CCYyCUXJmTauJMzGL2yez+itczjhfqFnofhyJiPXoJm+Y2NZzM/Vf3AqLS9xDpzRiKWuXv4NJxFLutKtX/oG103peGzY8wapbfSfw2UAy6oNaoGWG9oW9j/Ou6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665055; c=relaxed/simple;
	bh=BmGXNVrTqxXAkUExqcGcIkfGVthayzRf/XdQRf0ErJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5MnH+uW0yHV3CLLUOvyxcXtPAVI/lCpJpsugaEI2DKtWJ+bmlA8A7PX2XK2n40d8QBpIveEH0UkvXgLGcYFae4qBF5usZ4ryG7Q+SiuZBmpxtlYhYRNAOxebdyGq2bcQa3G/xKySNroes77EE8UOWFkKGu27+wvIvGMJVWHMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZye6mhy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743665051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4GpbdVAioAsBhxItBe3Gp1I1aqveVV1B4xHRWy2NlY=;
	b=fZye6mhylmx+dpbsv2k4N6OZMzqaOgsvd/qgqR3DLbEhi59sHTr3QISe97Kbsb37eQ8zkz
	LOCrYZC5lSV2SNy/d5dycRKQ6pMfY3l5n4acDkgOSsJDRl5qsmBRUyR3wLZ9wsafMeyTU5
	q6vcxp/WPWcnxpEcj91COc/s4cm6nYI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-4f9sEl9XPdGyawPoAKCtjA-1; Thu, 03 Apr 2025 03:24:10 -0400
X-MC-Unique: 4f9sEl9XPdGyawPoAKCtjA-1
X-Mimecast-MFC-AGG-ID: 4f9sEl9XPdGyawPoAKCtjA_1743665049
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so2723645e9.3
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 00:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743665049; x=1744269849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4GpbdVAioAsBhxItBe3Gp1I1aqveVV1B4xHRWy2NlY=;
        b=cvbDr6HmJ+A5CjEEEVUFmQHpwk0e+024zPeSb0dcvXlUhlxYXt+CCZOyQd39Z2sXVs
         Z7+46Qg2EMveNiJaxUseKc3QKymL+GT1WEW2M0VOVlp3x/VxlcTn+4CQRPzpXByq1C68
         gMVgOAe/upP0R7kJ4WGMzxjV9BQulkW31pwZ8s6b4A/6TmuAybEpmvI47FjR2Le+BK03
         2fuZ3HSMZDau1SfK3HJE2NngAm+sy62XYsF1dTP7tRaNUL+eIv+l9fU1whCo2l5Bdm2I
         GSv8IUxizTB6Tdeh+arYxaMhHSMeI6vWlKhmnAqOoQbtRwaTkHdS38Ow5ZrrjiNmFLeu
         1nqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGXIH6ZCXcInWoTUNVdDh83rSaOjblpBK3C8qCzvIEGlpTRRhDdsGaRbvfjrtShVLTX7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXPQ5hAoq87n2gYNa1S2MgAEIpVY2PcxPr3ESnYGTELHOZp+IO
	utTJutl2RMT9bXkqFhyxvU8eSERGIQL/46b6PoI2eND0OXB7vtmHxhczSRtZIvs0UKYZupVeGd4
	mRyqrR+2OnOr1iDbpVnGfjvG1RGC3zOFTz0XotTpvJU+QlKLg9g==
X-Gm-Gg: ASbGncvSNuaVLmaFt/CA3fLmQ1V5cYazGMRoSRfuzSO4OodVgdOfyogelNe/uLSV5ot
	wJlPENwFiwAOr2yCU10dx/aw7PKmI4dhxER8Z3UqJWxHXQjqAkPRzQ+Gl1mF1EvEbuazf9SpKRO
	HYoCcjjYa9WEDx2+/Ol6JcMEgrYqgUcFTLs80Q4tgbyvJPK1x/6KBGbNgXdtHY16hUxbwE6YAyO
	v23ZnX1Tn9uOwCeCCAH3h/yS9Fk9gl0nG/cAQygfT6mnUs8Z5IQ8lzRcjx5YjYRdCIiQdOFXrOP
	jHTI2DIb7yMld2qqnVPuDxxcpJqbFY+9Zs+84vESFlRw1w==
X-Received: by 2002:a5d:6d8a:0:b0:39c:dcc:f589 with SMTP id ffacd0b85a97d-39c120dd036mr17302227f8f.20.1743665049160;
        Thu, 03 Apr 2025 00:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLjiN+esCynIJ2+bi2OUprGrFibkCQORORxWzFxwa+nAcvodEQofseNEFH/q+D6t/l5rRnhg==
X-Received: by 2002:a5d:6d8a:0:b0:39c:dcc:f589 with SMTP id ffacd0b85a97d-39c120dd036mr17302194f8f.20.1743665048726;
        Thu, 03 Apr 2025 00:24:08 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d68esm975281f8f.67.2025.04.03.00.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 00:24:08 -0700 (PDT)
Message-ID: <4b3bea7c-110d-48eb-bcf6-58f4b2cd1999@redhat.com>
Date: Thu, 3 Apr 2025 09:24:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when setting up xdp
To: Bui Quang Minh <minhquangbui99@gmail.com>, virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250402054210.67623-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250402054210.67623-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/25 7:42 AM, Bui Quang Minh wrote:
> When setting up XDP for a running interface, we call napi_disable() on
> the receive queue's napi. In delayed refill_work, it also calls
> napi_disable() on the receive queue's napi. This can leads to deadlock
> when napi_disable() is called on an already disabled napi. This commit
> fixes this by disabling future and cancelling all inflight delayed
> refill works before calling napi_disabled() in virtnet_xdp_set.
> 
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e4617216a4b..33406d59efe2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5956,6 +5956,15 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	if (!prog && !old_prog)
>  		return 0;
>  
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	if (netif_running(dev)) {
> +		disable_delayed_refill(vi);
> +		cancel_delayed_work_sync(&vi->refill);

AFAICS at this point refill_work() could still be running, why don't you
need to call flush_delayed_work()?

@Jason: somewhat related, why virtnet_close() does not use
flush_delayed_work(), too?

Thanks,

Paolo


