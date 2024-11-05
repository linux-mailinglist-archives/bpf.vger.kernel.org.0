Return-Path: <bpf+bounces-44026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B519BCB97
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 12:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A98DB22BB9
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18D71D4350;
	Tue,  5 Nov 2024 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxC3rNLZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9701D4141
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805764; cv=none; b=PD4tz4uqZI5XWXAja2mg/rZ0aaMgPAhS0bHoK+b6/LC0V9jPlSKJ9SQhWPloLN/fP6kEb3soHWn6Kzw9Zmx7xPAaxZCRGQsU0nirzBNX7GQ20u2qZRAZM/vdFdl9FgIbWa4uu41kF+87qmrTO3wuGK7G1nVJ99UXMQuVozkFD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805764; c=relaxed/simple;
	bh=DREiJ3+9uPmoBRjO+WZh8yLPw0vGXk6MYVHENj4AzFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxPIcqIkE7iOfSleirVD1F7e5iHTgJFqk+Su+LavUmQ8dm1c+tppgeq1TYRMlZmMKuJTz4gtlwK8zEGWeOVZ8HXiDA6E1auQu+Rkz2djgFTvNmVklIyheiwPoVZ4G5aUtwjBOkcU9H6ya1oP8zFloeolG3Vv23k16NUDRx1Smyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxC3rNLZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730805761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0w4cqL75qypebxW4II7sYIZNVtJj6dqkjoh3JctPnZs=;
	b=UxC3rNLZRLKbE/zRFbUlPXagAo0Fbzr+6/miF+wk/OowqzrCtsGKhBi4fZyo1KjwVmudot
	ImObGztQpt/R/fretnrjSPwm2V8+ehJLIOIlAxiP1VuHxyOrjkwVOaqtncEJOiJGZOXOl6
	jXJqMs0iWd5W2UY06pEVF5ikUBBXWDw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-yBxIt_cfOnuRt_odeK3teg-1; Tue, 05 Nov 2024 06:22:40 -0500
X-MC-Unique: yBxIt_cfOnuRt_odeK3teg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539e5f9df25so3187229e87.0
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 03:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805759; x=1731410559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0w4cqL75qypebxW4II7sYIZNVtJj6dqkjoh3JctPnZs=;
        b=mSAUz0HJnqL0nmIv9soHz0NdOpV8VMgWnjoq0mx9P5Y+zZqTh83aKJiiRwYwfvjCET
         V0wVo1aEyVxbHZBy1x4BRQygEE8i5bnf7nphPXTLU17QIVd3k4B+djezYJ57eUsAr2F+
         TtcokH01VP1Brf3+MPBg9pzmLqYq+3nCcOcnFj7tGpSNhPVOJc4GNb47VnRt2kXln3FY
         HfmpuXnijEsIMTplsUBDSamgZOqAIy/r0Lk6EWZzv0l0naiBjNcPAi/xp7Tu5mL9+u9l
         UOsPYDf5NY34h3NZi4Jdv4eifodzRi/BN1F6ek7zt4C+dhsy5bWdyvL4bpnFJcBi5l/u
         4Z2g==
X-Forwarded-Encrypted: i=1; AJvYcCVWyjEZw5/NeNmFS6sDG+q6pBBHYbB+ost1lcU1hEiFa8lDjBfeyQbyo2/02yqBQmx6Irk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15yQWyY0lL4pH24ZvHUmVXk5klBaHlqqBdLoOamBkXhOVrr8x
	YSzQvwpygbIpJplQkn+BU2c6M3MD7wQbcBhWJSz6DUcxqhd95Rm3Eww2jOO0oMIIsjt7EZacGd7
	3JaGrW2E8OO3oTc3UEMGhKJ1KsnKDN4JR3gmHWio729OPpfyWZw==
X-Received: by 2002:a05:6512:1107:b0:539:f7ba:c982 with SMTP id 2adb3069b0e04-53b348ee5c3mr17252873e87.33.1730805758665;
        Tue, 05 Nov 2024 03:22:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkZhLSHmVvI05Xa7tNeYy4VrWo47n8S+oU5OPC7haYZemC98IoPNLINInGw/qiJ6rXUQ23dg==
X-Received: by 2002:a05:6512:1107:b0:539:f7ba:c982 with SMTP id 2adb3069b0e04-53b348ee5c3mr17252853e87.33.1730805758231;
        Tue, 05 Nov 2024 03:22:38 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7365sm15705047f8f.54.2024.11.05.03.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 03:22:37 -0800 (PST)
Message-ID: <62773e8f-884c-4bfe-b412-97ad976f9cb8@redhat.com>
Date: Tue, 5 Nov 2024 12:22:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v4 6/9] net: ip: make
 ip_route_input_noref() return drop reasons
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, dsahern@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org,
 gnault@redhat.com, bigeasy@linutronix.de, hawk@kernel.org,
 idosch@nvidia.com, dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
 <20241030014145.1409628-7-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241030014145.1409628-7-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/30/24 02:41, Menglong Dong wrote:
> @@ -175,10 +175,12 @@ static void ip_expire(struct timer_list *t)
>  
>  	/* skb has no dst, perform route lookup again */
>  	iph = ip_hdr(head);
> -	err = ip_route_input_noref(head, iph->daddr, iph->saddr, ip4h_dscp(iph),
> -				   head->dev);
> -	if (err)
> +	reason = ip_route_input_noref(head, iph->daddr, iph->saddr,
> +				      ip4h_dscp(iph), head->dev);
> +	if (reason)
>  		goto out;
> +	else
> +		reason = SKB_DROP_REASON_FRAG_REASM_TIMEOUT;

I think the else branch above is confusing - and unneeded.

Please move the assignment after the comment below, so it's clear why we
get a TIMEOUT drop reason.

Thanks,

Paolo


