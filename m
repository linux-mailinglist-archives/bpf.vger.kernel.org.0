Return-Path: <bpf+bounces-63115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40519B02AC0
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 14:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EAA1BC34DF
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 12:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71758275AE5;
	Sat, 12 Jul 2025 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW1su9E6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F2381E;
	Sat, 12 Jul 2025 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752321864; cv=none; b=kZZAemtbq+pUEUo+u82ubXccOvLXArnrB2o2xtGAwJMutm2kpnUt3NRLlByc0i4R9ujwAhQvtULUh/xBSudhdCDU7IqmzbRMUuBKNpzpj7i6YW9XHsfbQdo1ioaYHItpzta+FeGD5iACz0Ovzl7LryhUWDOGvF/549zWFnx7YGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752321864; c=relaxed/simple;
	bh=5ArBWQ6pd8vV0fCGUHOWcgpRl/TOo0+fC/jIWlmNn4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X832FUCzcpADOSaOEQhp9Q6N48xZHc1wEGZ/mZyoZBcdea7gkU5P+6glk6ZTEEypGYNfXKkDvZmmS8vKLhCOVGSnx5k4ZpjQgSio/yxpJrfQd78PntpjoS9POm3dUdW0SfHfs5tnF6Eu8Mxa3m/IGUB6mCMYP0xVAmbzu4WqXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW1su9E6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0c571f137so548764466b.0;
        Sat, 12 Jul 2025 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752321861; x=1752926661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVU84Q4TTNFb/InD+14kTpRtPOAaj4ENC3rSLs7cunU=;
        b=lW1su9E6rS2cn8Gvbynb0y0CFwS/rUPs+xrPGnsf771AniifTfS8G2hGFl+efvzKDE
         j+Z0cqfVEYR9YEUwIpDg1r7aMII8rEfpOXqn59cMDWatsmqGU+P5xmup2vgLpBihXus6
         97NVvTXsYpddYRuScc49FBEVM2oT8h2cLq6L2dk5a/R4YG9HG2tIi0hbo8yEQlvx9hTP
         Rt0QE2mGWnAA8Wv4oH6mGwETejPAgkkwQFc6x749EmXvRaBDAZ68PlulBrhY5YvBDgwA
         75hHjD7WsZ/WeViEaSE2a62IHkJZpmtlkYuIZUrSzv06wn6Bnrs6vM+810r1YrEPRejM
         GioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752321861; x=1752926661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVU84Q4TTNFb/InD+14kTpRtPOAaj4ENC3rSLs7cunU=;
        b=wEthRRkG4qEanbDmrHgJ6gMA5mG0wmf9SPN+8CZfzTBfDyj26S9ce5rTUBwNVkDRcw
         63xWwB7VMyINTQl1ZxRmStSUdwg+hUC2yiq8nKWmuFM1QU+d5ZAx30zXR9CF6Pjfp1sM
         9SQK/ce22oFMTr8Di9ysmS40b4m7WHBCrchCIoRyxelN4bdzsLWtpcf4rBm9IdgKU6Ew
         TAqWldaLWzGCeH8WNimTmId8TUEgQhQDJV/zhESCqvWjeQ/jnc29QeiYrLYleJL4i4RE
         H2IRhZtKSdIXK6dgNltmKH7qad8/OXuHtPXlevs+t4M7eFxfYOb2D7TRwntP6xk7kvDV
         FgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM2EyBMQI0rxM7Pc3XKjvhabolLReiZYazrM4DP1tgqnCwqOOlwvuX/47mAQ0W4QTI7EhqoSGGmEolemqO@vger.kernel.org, AJvYcCVwJ03bE0oEJ0hMJFLOYOk+5CDZ+ZuR3e8aGiF0cdY8ynMdNLYpGS2logqwG/+xqaiFtHajhdM3wPK+vA==@vger.kernel.org, AJvYcCWnTNNPEqlNtPTzSxahYfWLKIu5dMXrEE/HXaOycXoMRa6dAS9RkeMR5dluhLQ7LsCW0ulIbaRr@vger.kernel.org, AJvYcCWv1e7uyV5eqqd6WVCjZwVt3RsxrYAUL61ncYKIA6NCnt9ZIYVig5A/qPq8OIek6f3ta6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rs35f8Bu2BlrbZMINTWDvty9qVe4RH0+3Bv2CL+jaLG3tp8X
	nVXOIog5GatR67Ba9IcSxs/C1mIMNI+awqoDicwoguNkcJrQe+bfEOdI
X-Gm-Gg: ASbGncs0iHvU0P+EEHkp6YPyIaqimK0hc78JoBxeLNjqrn7aD98dqD3pbXs8J0KDghI
	88R7c1heiBktSv2fJifWukJVs8RJeTWshJeAzHVCO3WIz6si0MSllhggzu6377OIbMVLKHdScrM
	gcZAp2pqaWqgn9XPTG9JxAJGNqHBITJ23Y01iufDK+zvVyGYSNoCt5UmIZna+CHzujR5g6JImoj
	jfWTFCuBLLhVwnagluTiOcj9rgXbBIV02HzucZP0hAHo5mvvxuUXdNkbLRPRFPestJsh0GE6owl
	Eyi06zik0Ml6BARoRjegLFzP/76c/3fZjwJue86MtFe5Wc9sgv9YnsccuSFIdyLMIqi6JXM+FlQ
	rlH3Fw9hGcw0tl9McxM7EHHLj1DCg/wQDstA=
X-Google-Smtp-Source: AGHT+IGauQ39Mrtto9zdM0mTTamBDa/G8C/Yqj+C34TLbwDZJlxQ7GX6Kbqv9W/BPm289yBVCi/oZg==
X-Received: by 2002:a17:906:9fcc:b0:ae2:a7aa:7efe with SMTP id a640c23a62f3a-ae7013408f4mr555974466b.58.1752321860234;
        Sat, 12 Jul 2025 05:04:20 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:b2ad])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7f292d2sm475605566b.72.2025.07.12.05.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 05:04:19 -0700 (PDT)
Message-ID: <cd9728b1-2710-46b1-a063-6a3204efee45@gmail.com>
Date: Sat, 12 Jul 2025 13:05:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/8] netmem: introduce utility APIs to use
 struct netmem_desc
To: Mina Almasry <almasrymina@google.com>, Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
 jackmanb@google.com
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-3-byungchul@sk.com>
 <CAHS8izO0mgDBde57fxuN3ko38906F_C=pxxrSEnFA=_9ECO8oQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izO0mgDBde57fxuN3ko38906F_C=pxxrSEnFA=_9ECO8oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/10/25 19:11, Mina Almasry wrote:
> On Thu, Jul 10, 2025 at 1:28 AM Byungchul Park <byungchul@sk.com> wrote:
>>
>> To eliminate the use of the page pool fields in struct page, the page
>> pool code should use netmem descriptor and APIs instead.
>>
>> However, some code e.g. __netmem_to_page() is still used to access the
>> page pool fields e.g. ->pp via struct page, which should be changed so
>> as to access them via netmem descriptor, struct netmem_desc instead,
>> since the fields no longer will be available in struct page.
>>
>> Introduce utility APIs to make them easy to use struct netmem_desc as
>> descriptor.  The APIs are:
>>
>>     1. __netmem_to_nmdesc(), to convert netmem_ref to struct netmem_desc,
>>        but unsafely without checking if it's net_iov or system memory.
>>
>>     2. netmem_to_nmdesc(), to convert netmem_ref to struct netmem_desc,
>>        safely with checking if it's net_iov or system memory.
>>
>>     3. nmdesc_to_page(), to convert struct netmem_desc to struct page,
>>        assuming struct netmem_desc overlays on struct page.
>>
>>     4. page_to_nmdesc(), to convert struct page to struct netmem_desc,
>>        assuming struct netmem_desc overlays on struct page, allowing only
>>        head page to be converted.
>>
>>     5. nmdesc_adress(), to get its virtual address corresponding to the
>>        struct netmem_desc.
>>
>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>> ---
>>   include/net/netmem.h | 41 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>> index 535cf17b9134..ad9444be229a 100644
>> --- a/include/net/netmem.h
>> +++ b/include/net/netmem.h
>> @@ -198,6 +198,32 @@ static inline struct page *netmem_to_page(netmem_ref netmem)
>>          return __netmem_to_page(netmem);
>>   }
>>
>> +/**
>> + * __netmem_to_nmdesc - unsafely get pointer to the &netmem_desc backing
>> + * @netmem
>> + * @netmem: netmem reference to convert
>> + *
>> + * Unsafe version of netmem_to_nmdesc(). When @netmem is always backed
>> + * by system memory, performs faster and generates smaller object code
>> + * (no check for the LSB, no WARN). When @netmem points to IOV, provokes
>> + * undefined behaviour.
>> + *
>> + * Return: pointer to the &netmem_desc (garbage if @netmem is not backed
>> + * by system memory).
>> + */
>> +static inline struct netmem_desc *__netmem_to_nmdesc(netmem_ref netmem)
>> +{
>> +       return (__force struct netmem_desc *)netmem;
>> +}
>> +
> 
> Does a netmem_desc represent the pp fields shared between struct page
> and struct net_iov, or does netmem_desc represent paged kernel memory?
> If the former, I don't think we need a safe and unsafe version of this
> helper, since netmem_ref always has netmem_desc fields underneath. If
> the latter, then this helper should not exist at all. We should not
> allow casting netmem_ref to a netmem_desc without first checking if
> it's a net_iov.

+1, and...

> 
> To be honest the cover letter should come up with a detailed
> explanation of (a) what are the current types (b) what are the new
> types (c) what are the relationships between the types, so these
> questions stop coming up.
> 
>> +static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
>> +{
>> +       if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
>> +               return NULL;

... specifically this function should work with net_iov.

-- 
Pavel Begunkov


