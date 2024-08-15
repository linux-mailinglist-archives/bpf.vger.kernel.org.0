Return-Path: <bpf+bounces-37261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AD5952D4E
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 13:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAEDDB21215
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 11:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F717DA7E;
	Thu, 15 Aug 2024 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClcjQcit"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704BC7DA62
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720720; cv=none; b=lDeo5GCzUlDe7d6uSX9ZK3UYu0w4NKVwHvJjOt2l/mOW12rKVOh0NDa3mDIxQxSuAsq6E5vISffcJZoIdbhGN4JgI4js+ztEXwIlz/T4Zfzm+JooGVQMF5ZCr5paKDS9gKzWQzik6FxB0cE8rZgOX25rfjdJTzR9CyQcI/dM+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720720; c=relaxed/simple;
	bh=GfzHkA3NEtdmCsr/KpIs6KlwwNWqBKlqq8cB1Tg+n5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYJ/3OviFBSiXBuUKwOiFskc/JG3if1GZemwILO/TkNr8lTaoGC5a+fY7v2AJRwqCib9I3gbsySH7hwm8wIChoh3IgEqukD9qzd3z1WaS8hE4RUflMzLpXErOWFVCEqmeM8grLXqvGsOXlE5uf6At5tPwmBK6Ok9GH3glxvRAsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClcjQcit; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723720718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24V3VGfwIrKGka7iIRCvCp2rkdbP5TtQ2k/YsWqeb00=;
	b=ClcjQcit89HLaWkst+62OniPPNn3E7JMuKgrar2cghJdhNENVGy/K30Qrqk4BL5I0k9kWv
	Qa/hRi3iZQVef1UnOKS6qsSfxdrp3uY7octyTeuu/dcybROGiWxVeGbj6EjLj3Yg6PhUAN
	mggxtBYNLW6hJv06ePGc5/bBhUF/d+8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-WkAwuYuePbqsxHjMc1K6WA-1; Thu, 15 Aug 2024 07:18:37 -0400
X-MC-Unique: WkAwuYuePbqsxHjMc1K6WA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428086c2187so1606245e9.2
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 04:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723720716; x=1724325516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24V3VGfwIrKGka7iIRCvCp2rkdbP5TtQ2k/YsWqeb00=;
        b=tmTmI21kt4faDH7rGC8tm4pFiWuKSVzco/SjbBibwBqOzg3xp0Nu1eiebWzbmrRJQB
         fPCRqTAlqhEFOieSo/O23lWnETr7pJ0Np4N+hzl32L7t6EnIWJh4zCKaK7J/KQpQCNqZ
         wIokxaEsHGSwc3oogBeACIApud6qLQgh6YQUBclyJG7grs6NPJ1YsPXwKARx08tDK+RO
         /1jFrk+YZHGRcn7YIJXLX6Oj3s89KLCg574MYURwEYaBdvhUkeAkZvog/h8JPryjBZiy
         LPWKtLejVEev5PkBnOUbjSVSQOY3isqVwZt/E2Mi+7BzsmHfwXEItBw6ADzvy7T0U3bw
         QfDw==
X-Forwarded-Encrypted: i=1; AJvYcCXpPOJItBZ3gofN3vnM1H2/cLiI70COO1yhvaINptSkcv7UO9MCsDAr1ZPPKZj6ehsbFL3jEka2mb8M+JyClI7pbprW
X-Gm-Message-State: AOJu0YyWHMiMUBbYGl0qEF2PlZ4p+sYJoNWVSqvxMepk6y3Qb2wOTi60
	st1wd4RDvKw4e+97yxiq8vVkM/xZId6gAG37TvmcqF4YUvnOW7/Lg49vdww7rYlWS7KG5t4VIjW
	KzNyj3933YY+CvMYbyQ6jbXFTXxY3cpl/r0JIdpWAcV1isD71fA==
X-Received: by 2002:a05:600c:35c5:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-429e63a22aamr9302455e9.0.1723720715953;
        Thu, 15 Aug 2024 04:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGnOYnq3ro7PPvOKCikfdHFb1kTWeqIJYge0M34FZQMbh0yh0VysW0l11ZYuiNklVTcOTdkw==
X-Received: by 2002:a05:600c:35c5:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-429e63a22aamr9302335e9.0.1723720715429;
        Thu, 15 Aug 2024 04:18:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19627sm45254015e9.5.2024.08.15.04.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 04:18:34 -0700 (PDT)
Message-ID: <fd30815f-cf2b-42a0-9911-4f71e4e4dd14@redhat.com>
Date: Thu, 15 Aug 2024 13:18:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Don't allow to attach xdp if bond slave device's
 upper already has a program
To: Feng zhou <zhoufeng.zf@bytedance.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20240814090811.35343-1-zhoufeng.zf@bytedance.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240814090811.35343-1-zhoufeng.zf@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/24 11:08, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> Cannot attach when an upper device already has a program, This
> restriction is only for bond's slave devices, and should not be
> accidentally injured for devices like eth0 and vxlan0.
> 
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
>   net/core/dev.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6ea1d20676fb..e1f87662376a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9501,10 +9501,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>   	}
>   
>   	/* don't allow if an upper device already has a program */
> -	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
> -		if (dev_xdp_prog_count(upper) > 0) {
> -			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
> -			return -EEXIST;
> +	if (netif_is_bond_slave(dev)) {

I think we want to consider even team port devices.

Thanks,

Paolo


