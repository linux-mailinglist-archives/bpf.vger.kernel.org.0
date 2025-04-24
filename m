Return-Path: <bpf+bounces-56608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BAEA9B15F
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 16:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2645A6B4F
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCBE19C558;
	Thu, 24 Apr 2025 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhKu4kC9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10F513CA9C;
	Thu, 24 Apr 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505925; cv=none; b=MiZdHK5vXg6YPd7coHZCkZNNdCZwVbQRGV4zHj6684jTit1OIOe7ODecJtDr4dNS57FUVj10QkmphIYnCf6rrgIpcv6YWZIW2bNZF7/r0qUhM13bv8Yxh/UUXSIIIWMkT2KmgI5Ff0IFTKOrQ56mUjzKGDjv15Z5LJg5yhKQzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505925; c=relaxed/simple;
	bh=WfFFauBOimAA1xG7/eaugx9UY2R4AXtESa3PSQzg0KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jngROzsK/hN9ZmlcI3bj6VTOvZwexHN2KzY25Ko0YvGKDSOLUGjUHFyVJsJf6AC/fGxBw/rhe8vDqVEU3Kdaeg6jqYOe5lrjLyQhXcUZ6TmCEN/OdlV7dAZ5LTDcthJx4U1z8cKd9Q8NEWu/XYxSpwZIRtx2VbfpJiQMv2BsOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhKu4kC9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73c17c770a7so1495296b3a.2;
        Thu, 24 Apr 2025 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745505923; x=1746110723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PAGLeinOTw1BegEcFTcz+g2dJ2nTYeNG2yLekJHkNo=;
        b=ZhKu4kC948GYQQf0HzrVY5w+PpKrvbIARLw2ZoPdGrfnQonoqW8pyCzdNMN9n5gCvZ
         Z5ZfJwu8AKb4ZEPpkWOrMeceAL8Y/UHG/cWAkL5TMK13tYgG7HN8DNyDNuq81NzmKgzB
         cv4VLkD9w0J4j3cPLG0Xhkn+sdQEiZOzmvSeW5sYmv0VJj6B9edODN89D4e+BSBxai4w
         rt5Rh4Cq7icOpvrY5gUY36rh0Z62q7/WYulbHaa5Td//bBQMt7eFwXoJNxTZkbQWsGli
         n0Bkh3STpKk6/4NfkHBDC8+PShP7aCIlM0/hBlV7paW+OxiXmhCQ7rw8U0FRfiyFNdb8
         4BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745505923; x=1746110723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PAGLeinOTw1BegEcFTcz+g2dJ2nTYeNG2yLekJHkNo=;
        b=urJXbN3ui5VkJ93wPp/hkkWdFoTpUGTBd5vLt4BMrEasFPiV7ZSzzW46XjhI6mvMSH
         TIu3affq9Hj18Otwr8oYuI+MfA+2NOLi5i9DEcrN7GYhZitVzyYnoMRfeiwGa7VJo4LG
         XkZArDDIRIqPEP64+H7JaYm0kjymlV4PfDcbYdcrtGUx2vHU7Fgiuxdh/NQ5KfEYmI+g
         OlzOrl20DBBj6h6mtvojh0rHXQGm3g7kvZacnNJwuzx0pBCAsa6FSfsKOjrErhpi16mt
         yDM6AHmltcVTamHkuhQBIF905BgMOs698Nkxmxb5S9tiCA7rz0/wI13naTlozwc0m2K5
         TyLw==
X-Forwarded-Encrypted: i=1; AJvYcCUfoWllnK1DAGm1YEgJ5hnbZrY+HV8xVOq3CLnh+ivfQlkwtFz65oozP5ldkQ3fHF0IGLE=@vger.kernel.org, AJvYcCXMViui7smLkkh1PMciRg8jgDEP1YYRafvC7W0M/dc2eShXxMb3mpEWgHWhNm7KIAhnZClsIHSQVsN+in+n@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQpxkGNFRaA2YxQYVnpz0KIGi6Sb5kiV+57yYC68EUTo22eFF
	001aXOglqRpodkIeUKpp3+ewzExadq+sOozZ3EmvNS1iSkzzuaNR
X-Gm-Gg: ASbGncvA1hgLdM0qRgXDOxdfbDt/s7tz9MtqLHFrUaKSOW2CpZSdYEyZUMh7I04PpCu
	S17ZwDOwm2OAO1Je2KPLgFlF8J7rM4HltuAZ4pnmo/WfaefrAwQHuk34agAvanWZHEO5KfgWNXa
	3yEoyQtKiIWOE+WGUdTN64/74aewLeTwau+fpFhDvzC5BsMvg6m38yGteKPQrY2vSZPNrYXmugR
	yuJ7p+I6+uD7xHid7SHWWQk9S4W0Y+vwQ5rxUZHnOJt8tz8FT+u3X2UneQdrd0SwbenSNk3v7Ns
	OzZM7gtwPVip74A8iu+NOdbz2RBhIPBueoJqMsPAUfifSzs+Af+7tMXBJhs+/quKTEFNyIqLsnZ
	2NG7N3bEA76EzZEXMw7U=
X-Google-Smtp-Source: AGHT+IFVuYKB/RLifTofF8XnjcJX6TCVuQ5lhxXULqxxcU1gSNRlAOIL1o0jpGAizcAW5raamumQWA==
X-Received: by 2002:a05:6a00:391b:b0:737:6e1f:29da with SMTP id d2e1a72fcca58-73e24e05a1cmr4301845b3a.21.1745505922795;
        Thu, 24 Apr 2025 07:45:22 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:f632:6238:46f4:702e? ([2001:ee0:4f0e:fb30:f632:6238:46f4:702e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e2593f557sm1474503b3a.42.2025.04.24.07.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 07:45:22 -0700 (PDT)
Message-ID: <9cb42173-e394-4c5b-aef2-fe9ce737689e@gmail.com>
Date: Thu, 24 Apr 2025 21:45:15 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xsk: respect the offsets when copying frags
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250423101047.31402-1-minhquangbui99@gmail.com>
 <34e2c7f7-4d83-4e5c-af56-d91e68b3e7e1@intel.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <34e2c7f7-4d83-4e5c-af56-d91e68b3e7e1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/25 21:02, Alexander Lobakin wrote:
> From: Bui Quang Minh <minhquangbui99@gmail.com>
> Date: Wed, 23 Apr 2025 17:10:47 +0700
>
>> Add the missing offsets when copying frags in xdp_copy_frags_from_zc().
>>
>> Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   net/core/xdp.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>> index f86eedad586a..a723dc301f94 100644
>> --- a/net/core/xdp.c
>> +++ b/net/core/xdp.c
>> @@ -697,7 +697,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>>   	nr_frags = xinfo->nr_frags;
>>   
>>   	for (u32 i = 0; i < nr_frags; i++) {
>> -		u32 len = skb_frag_size(&xinfo->frags[i]);
>> +		const skb_frag_t *frag = &xinfo->frags[i];
>> +		u32 len = skb_frag_size(frag);
>>   		u32 offset, truesize = len;
>>   		netmem_ref netmem;
>>   
>> @@ -707,8 +708,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>>   			return false;
>>   		}
>>   
>> -		memcpy(__netmem_address(netmem),
>> -		       __netmem_address(xinfo->frags[i].netmem),
>> +		memcpy(__netmem_address(netmem) + offset,
>> +		       __netmem_address(frag->netmem) + skb_frag_off(frag),
>>   		       LARGEST_ALIGN(len));
>>   		__skb_fill_netmem_desc_noacc(sinfo, i, netmem, offset, len);
> Incorrect fix.
>
> page_pool_dev_alloc_netmem() allocates a buffer of skb_frag_size() len,
> but then you pass offset when copying, which may lead to access beyond
> the end of the buffer.
>
> I know that my code here is incorrect as well, but the idea was to
> allocate only skb_frag_size() and copy the actual payload without any
> offset to the new buffer. So, you need to pass the offset only to the
> second argument of memcpy() and then pass 0 as @offset to
> __skb_fill_netmem_desc_noacc().

I'm not quite familiar with the page_pool API so I might be wrong. 
AFAICS, the netmem_ref is just a wrapper around struct page now. 
page_pool_dev_alloc_netmem(pp, &offset, &truesize) returns the allocated 
page for our request but we must use the returned offset to access our 
allocated space. The start of page may be currently used by other user.

That's my understanding when looking at this code path

page_pool_dev_alloc_netmem
-> page_pool_alloc_netmem
     -> page_pool_alloc_frag_netmem <- specifically this function

Thanks,
Quang Minh.

