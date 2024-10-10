Return-Path: <bpf+bounces-41544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620BB998090
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 10:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7563C1C277B7
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3F71E573E;
	Thu, 10 Oct 2024 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ybory6lo"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9151E7C00
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549041; cv=none; b=NxEDTOslMaL3M+jDogxFF6Y947iQmo+EvL/3XmwSGoj9rMT0RG3oQjsugpLXGrsSj1PXOqXDbQ3rG7CQEhl5czmD3/LjessV8B7GZFdnfWKsmhI2NFe6nqrbkhZJGm193HwipnLSl741H0NhtpSIxWqqfa64hRu12Bl5rLfmOYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549041; c=relaxed/simple;
	bh=81ZjBvLUwY6eeqLyJYGD5q162fu/lz7B7IRHnVgSMbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZXXgBzHCH8LaIf02z54c/0A5a0J939CJh1iai3lAwxDA6OIQTzjy8botE3ZZ8Q+iTj/WU2wIBqnBlCXP7U293WjLr4X4AqSs4rYowX3n9h6BWzIRpLXklpFkl3K8XxSEpDhiRca0rQaLiCzyaQybqLZzh6WEFKwT2dB+hcNDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ybory6lo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728549038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNbzRipITp2ZX+tjoP83fC53vO8P93j48ZH+sfRT9Js=;
	b=Ybory6log4HmViFr65EPJyHauEMq5y23qPT5yqKfqd3ti1a3smwKm3qBqRks3PgbN5ZCtZ
	GqzwUhGMllhqzC8KtNWKyO8nxErt9zTPcU+5SPwj/MpqtndM1ff0O9uRsC9pjK6WmmOS6T
	Fyfd4+ppSXCXArg+o389YuYVgV+Xdyo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-XpIM8U8TMYGISVG32tMarg-1; Thu, 10 Oct 2024 04:30:36 -0400
X-MC-Unique: XpIM8U8TMYGISVG32tMarg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43111c47d0bso3079075e9.2
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 01:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728549035; x=1729153835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNbzRipITp2ZX+tjoP83fC53vO8P93j48ZH+sfRT9Js=;
        b=bZKSWAzGvtte/4xolVGQFp4BkNG1PNG4k+Z5A9DM/uXhf9KPndj4S3OVOXTiCQH7Hn
         YSl0vzQtcrtsytQood9dlqixv5P9OgcVgYzfBbyih5Rwx/wvaSfbPZwpSeqyxKrDrlQB
         USGLhYxSt1aKXQdR4Z1frmHJAGUVX/gho2xU2GeOis+TBz5ULZ2b0IzZ/ez8Ej2QazYU
         O+FHmtHaen1318VnPkraadGY/UYHE6YRhKkqzIa6HBHkjWSsdBRXKnHTKf5w5K0uU18E
         MUZFCohL845osnvJsW9DFzZmfIunjPvSmSQtpNm01EwrQGoDSfQJZw6ZoNOT1EdH7MyT
         6HvA==
X-Forwarded-Encrypted: i=1; AJvYcCVbL0K2z4nTuBWeKFdqk7+GMmKWCg2/kGaXIFUe6ZW8C+3QU1nVH+rL0tgbfeVHDGesajg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPBIMOAK2ypXaCDuhv2AIZuukItuMhoobX6C7u4aWSyznDdjYL
	2lgC+xm5ONxftV1VMxA85oVjAKpCC0iWM7FFnhmqHawj2J+c1WrcTjdLUvDsmn13ph+IMJGog6i
	r4UCfTZw3qqJcmBV6sZ8vVZGE4jne0QOy5fSpr2mZTd0N9ioAiw==
X-Received: by 2002:a05:600c:19d4:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-430ccf089fcmr38015275e9.6.1728549034889;
        Thu, 10 Oct 2024 01:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeQK3ESd3VwoQDVpFI6ih7FY4v1pI7Ubmg/YooSwZcbyZPfJMPk+upbulnUHJyo4gp+F3rfw==
X-Received: by 2002:a05:600c:19d4:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-430ccf089fcmr38015025e9.6.1728549034560;
        Thu, 10 Oct 2024 01:30:34 -0700 (PDT)
Received: from [192.168.88.248] (146-241-27-157.dyn.eolo.it. [146.241.27.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51c69sm41070265e9.28.2024.10.10.01.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 01:30:34 -0700 (PDT)
Message-ID: <3c2ad895-3546-4269-8e6d-6f187035f4b5@redhat.com>
Date: Thu, 10 Oct 2024 10:30:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/7] net: ip: add drop reasons to input route
To: Menglong Dong <menglong8.dong@gmail.com>, edumazet@google.com,
 kuba@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dongml2@chinatelecom.cn, bigeasy@linutronix.de,
 toke@redhat.com, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241007074702.249543-1-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241007074702.249543-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 09:46, Menglong Dong wrote:
> In this series, we mainly add some skb drop reasons to the input path of
> ip routing.
> 
> The errno from fib_validate_source() is -EINVAL or -EXDEV, and -EXDEV is
> used in ip_rcv_finish_core() to increase the LINUX_MIB_IPRPFILTER. For
> this case, we can check it by
> "drop_reason == SKB_DROP_REASON_IP_RPFILTER" instead. Therefore, we can
> make fib_validate_source() return -reason.
> 
> Meanwhile, we make the following functions return drop reasons too:
> 
>    ip_route_input_mc()
>    ip_mc_validate_source()
>    ip_route_input_slow()
>    ip_route_input_rcu()
>    ip_route_input_noref()
>    ip_route_input()

A few other functions are excluded, so that the ip input path coverage 
is not completed - i.e. ip_route_use_hint(), is that intentional?

In any case does not apply cleanly anymore.

Please answer to the above question and question on patch 1 before 
submitting a new revision. At very least the new revision should include 
a comment explaining the reasoning for the current choice.

Please, include in each patch the detailed changelog after the '---' 
separator.

Thanks,

Paolo


