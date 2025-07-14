Return-Path: <bpf+bounces-63165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBA4B03D99
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 13:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39267189CF72
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 11:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F2C24728D;
	Mon, 14 Jul 2025 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw8evCJU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A8246BA8;
	Mon, 14 Jul 2025 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493432; cv=none; b=oh1duqbwB1ilFqYCDk5tUTifPaJIfp2IMS0ln4WLHqT5QiWqwgbmd5btaQ8X3fWNQj4/I3djBp0SZj7arUFp0uL7gFz9gGfXGHoVS4z+qedn2Z+z3R1MaXJmLLCexw/QETWldf3CYR6/h2kQ4l2CsZANoXsc7wL33qifIuuR6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493432; c=relaxed/simple;
	bh=MAfCKYvuwB12rwS7CxHZcCwA0LyJ9BaDM74pNNpYlp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgr4I1Vz9JuCepULPzn32HupaHSOFn43MjNk20WyDL1Bk7iLWeWa6CGlzKbrCEuNpUzdJOWVu2iqFeHTsCYKZxYKYh9jm7r9ydJqG00JQRcdZur8xNKa/7vcESkUWLfgw5RB5AsgP8d3W/5s8PlTV63zVXPfowXzLpfNjGKUV1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw8evCJU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae35f36da9dso865386666b.0;
        Mon, 14 Jul 2025 04:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752493428; x=1753098228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhNvFDwY+89OVW+p/6NU499AEMOEYY2GKi9Vw3NtXRk=;
        b=Hw8evCJUZgcljHFtbIpJ2te019ND/fHxhMzCxmtWe11lkJYEWQjC64a1wKf1mt9LYa
         Zgru3c00ubP9J3xQlN0rGk7HgE/efAd0Nx4CeijRVRfSaD9KzHstnebuOJKLFa8xrAwj
         NHOqbCHKFGW8cqrdTJOaGZQ+UuVKtzG5BZW1bzaBa9Yk+8AesF5HrhgolX1YfvuZ0Zb1
         Z7rerFcXC4N6DmJ3Y9QXq2tv7xgno+i3YwZc+664PKTGRuiJZidZk5iuNVOpwVVYJ0wp
         32rrYD4lRTspAQ/DjEAHl6JBVOCkJ0VqIVUnZqiFcAwtHmNk0d8w5z9p7eeKLVJyuOEF
         7wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752493428; x=1753098228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhNvFDwY+89OVW+p/6NU499AEMOEYY2GKi9Vw3NtXRk=;
        b=f+HdPdXZ2psCoiFbeiKc6FwPFMwI/twlzBGmC0YUFCGJyRjZaQaYsROhlWrA4rtSRB
         mYd1DY0zpXUue+IHOEoW5mkrVmQK31o6lDtpjIjxPLjBni+5Ym+EanUQg1hkx5UyVZ7y
         6va0uCCGd69Olk6IicIzun53F2Er1Hhd+D6ccnxyjzZBE8YOAZcqOOwnzeZxk2sqMoyt
         C+9bc8vSVSWZr9QNYW3rhmK+qXITJk0BKrGh6/C1oOh2DEMBdcFxev48bd0ubQj6naZj
         KP3Ju2GEA1S70l2+lJwZboegAMCsB+KRsAz1+T8pDYF5784B5PvjM0Vw7RuD+kX35ZMr
         +msw==
X-Forwarded-Encrypted: i=1; AJvYcCVWBSvWTp+/vxbtTPUXJ0NwTsDVCHDqkiuwmiGnptB9oRpby+v8p6MoYsbCLkaHIVRLzERr/gMs@vger.kernel.org, AJvYcCVemQNPSLkNQmQKfDpnujrmHoU5/XpU7im673jJluw924dZhZS1nXKgVB2qHaERce2aSykOyJphVO6RDRqd@vger.kernel.org, AJvYcCWk5PKNbTiJVN6CDDRAp3WL9T3Ijn3RMZ6O53+etmtZz89L+LZR2eqE0ldhLM1PaN//2K4=@vger.kernel.org, AJvYcCXodtNMKN1ybbgkY7QxswkTZN+9LUJaBN3AwhfIyARSOs5WMwW/hfkZCpxnR72u6QU1coaH8jeIOWml7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4oNVxxn6C3omGK5ABU9zVZmHVYA0nVhJ+sTxSOu6JfwZYJAJ1
	ux10+D0WlAl+4tus/Ee2FVL9hV6FgEKpY5D9nxzDsEzh3mxXLdRCZRz2
X-Gm-Gg: ASbGncsu8Ml3vMlC9fBUPKN0pF+eUoV8o/WJpv+AbUqYslKJvXRSlveNZBrEb8eQfcQ
	qPI+TQhhzjW3SH0wwBWqgrX1Z+Uc4ojklR5rCkLaOrgvqwq8F+LRMpNtWKgE4NhebPjn4am3niT
	MnHMK459Cy6Dc3PEVvqJul2Zc4tnDBJlMHLWVWy7F0x9RzYokSc4KCBQpfIHmRM9alJ9KwvMmj+
	yb/t8W7o3m1LKdMgwB1cONcJsAj+8oubQTS+1Hnosthv9dlhnZOTRrLQHMZASXi1uHYeN6Msluk
	sr/iUF05GlC4NlRoauYPkIu04vYk8iWe2u1lcj3+zFSEBZaDCbVPyd//9q7Gu0S85OKM0e4sBtN
	AJp5r1PgzdEMqw5UHZsGSq8H7NendK8a4lf8=
X-Google-Smtp-Source: AGHT+IGEx+pgbI/Dk0bg/jaDAuvm8nSoDeCL6TnQgT5rti99cozEAJYWdcYjsGg03LSYS5a27YPlQw==
X-Received: by 2002:a17:907:3d9e:b0:ae0:c0b3:5648 with SMTP id a640c23a62f3a-ae6fbe1986dmr1236283266b.1.1752493428108;
        Mon, 14 Jul 2025 04:43:48 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:f749])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e949f2sm816205566b.34.2025.07.14.04.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 04:43:47 -0700 (PDT)
Message-ID: <ac59fba9-4f39-4691-afae-aa7a0b1270af@gmail.com>
Date: Mon, 14 Jul 2025 12:45:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/8] netmem: introduce utility APIs to use
 struct netmem_desc
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, almasrymina@google.com, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
 jackmanb@google.com
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-3-byungchul@sk.com>
 <4a8b0a45-b829-462c-a655-af0bda10a246@gmail.com>
 <20250713230752.GA7758@system.software.com>
 <5ee839d6-2734-41c5-b34c-8d686c910bc8@gmail.com>
 <20250714100551.GA44803@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250714100551.GA44803@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 11:05, Byungchul Park wrote:
> On Mon, Jul 14, 2025 at 10:43:35AM +0100, Pavel Begunkov wrote:
>> On 7/14/25 00:07, Byungchul Park wrote:
>>> On Sat, Jul 12, 2025 at 12:59:34PM +0100, Pavel Begunkov wrote:
>>>> On 7/10/25 09:28, Byungchul Park wrote:
>>>> ...> +
>>>>>     static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
>>>>>     {
>>>>>         if (netmem_is_net_iov(netmem))
>>>>> @@ -314,6 +340,21 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
>>>>>         return page_to_netmem(compound_head(netmem_to_page(netmem)));
>>>>>     }
>>>>>
>>>>> +#define nmdesc_to_page(nmdesc)               (_Generic((nmdesc),             \
>>>>> +     const struct netmem_desc * :    (const struct page *)(nmdesc),  \
>>>>> +     struct netmem_desc * :          (struct page *)(nmdesc)))
>>>>
>>>> Considering that nmdesc is going to be separated from pages and
>>>> accessed through indirection, and back reference to the page is
>>>> not needed (at least for net/), this helper shouldn't even exist.
>>>> And in fact, you don't really use it ...
>>>>> +static inline struct netmem_desc *page_to_nmdesc(struct page *page)
>>>>> +{
>>>>> +     VM_BUG_ON_PAGE(PageTail(page), page);
>>>>> +     return (struct netmem_desc *)page;
>>>>> +}
>>>>> +
>>>>> +static inline void *nmdesc_address(struct netmem_desc *nmdesc)
>>>>> +{
>>>>> +     return page_address(nmdesc_to_page(nmdesc));
>>>>> +}
>>>>
>>>> ... That's the only caller, and nmdesc_address() is not used, so
>>>> just nuke both of them. This helper doesn't even make sense.
>>>>
>>>> Please avoid introducing functions that you don't use as a general
>>>> rule.
>>>
>>> I'm sorry about making you confused.  I should've included another patch
>>> using the helper like the following.
>>
>> Ah, I see. And still, it's not a great function. There should be
>> no way to extract a page or a page address from a nmdesc.
>>
>> For the diff below it's same as with the mt76 patch, it's allocating
>> a page, expects it to be a page, using it as a page, but for no reason
>> keeps it wrapped into netmem. It only adds confusion and overhead.
>> A rule of thumb would be only converting to netmem if the new code
>> would be able to work with a netmem-wrapped net_iovs.
> 
> Thanks.  I'm now working on this job, avoiding your concern.
> 
> By the way, am I supposed to wait for you to complete the work about
> extracting type from page e.g. page pool (or bump) type?

1/8 doesn't depend on it, if you're sending it separately. As for
the rest, it might need to wait for the PGTY change, which is more
likely to be for 6.18

-- 
Pavel Begunkov


