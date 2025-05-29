Return-Path: <bpf+bounces-59327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FCDAC835E
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 22:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26CFE7A3380
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 20:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A35293468;
	Thu, 29 May 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP6K6QCn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231FC1386DA;
	Thu, 29 May 2025 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748551725; cv=none; b=kwrvnJTAByVyrct9QcsbCLMI2iXla4LGGXR9fFLUxvoL/ZDVfzgTiN/zQZwEa0g5memviXxZ9GrjLsR3RzG+ISGd22U5Uif3o/a7Suu/BmX4NXOCaQ3N+5l9C1JremFcYr5QvITZfRLN0IujIIBGJGrhxBCIAY8Dc664Cb24b/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748551725; c=relaxed/simple;
	bh=wxXnLfUrQMikEhxWsI2v5WrZK3UXkyQi5eN5iad6nPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4gA+1e0IDS1rVUDta8VSkD71tc/ZetpewTyijxvOv6WfFgkSdElQ3ggy3VPT1LLBFLdNzWWvtFPmJuj4ojy1kWk47DZz5kCHainFtnetVmr1IFh3/CK/3BX+333Gq3zCQs+sbkL6IaFm+JPUkrJzqCHWStiqo2q0lfftgTPFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP6K6QCn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-441ab63a415so14809225e9.3;
        Thu, 29 May 2025 13:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748551722; x=1749156522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qIpcYfA1//GAtmsBWG/5uUEcJigGm+o9jyY6nduW1k=;
        b=BP6K6QCnDqbPpD2SuTmQHYoKjwNGTmMf5qSUx7jtmUET7T0h1BA4FvBtT015hVzIGB
         cPLc8SFqYB7vPh6FwDcJ+F0y53gl8cDuLr/xtFjhHeZwIcLhbHGF2RjyAs0iAhOE4zKO
         xApGdN72x1tqCJBlligU/TLuLOyE7unXdZgrBZgUD3mYzhe+8jN7s4RZneqLR6LZpnIc
         RQ6epJfHiPRtZnjebzhsHsw5r1CccwPLHMJFzLSZD1xRZuwiUbMdkRTrma68nt6KiLcH
         5Wmr+mk/qTO2b9tW0ZI7psHTOz/61dXMJugV3JrC/C8hh9qvzasNyFNkakxtgQ1E3Gb3
         wj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748551722; x=1749156522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qIpcYfA1//GAtmsBWG/5uUEcJigGm+o9jyY6nduW1k=;
        b=hCzNn94NRxx5l4rHr3HsAcZD+8DCPjzF8YUhhoN1OvSaYE9m9SQS3QR23iSn0WtXKA
         nNcf+lafWjXreFCKtaWuXt69nzlNN/CZoSeW+BkALx2Rd5XS8A1Ocp9ivU4AICEEmSLc
         0XH4KySVzHxoKqsxaevE7PtXRiiBhHucRXxJUdOSvOC0HAR7LuKBJMDUqeIoy/J6VpMe
         XbPfvU0/fZQxyEgex5D7IpjK/MFOeBXFQBpL8IBEph4L9DRFJyzTGgvm+rbO1Aco+/BF
         gTdhrnwQfVrfMilt8DaoiN9UopPgDSUJl+Hxm8HMvTV8xyjxO67tPj0CmpIdDO81FrDI
         hQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCUxK/uQxkMs3ehuueusmTuWzrOLCxNAPDL1Bbf3pNSTdeaKuGZADKO7pwOweRXcQRHWeJ8=@vger.kernel.org, AJvYcCVpoJCfORmCeU4bCU2MXjNYh9sCYb/P5dwTQunQS3pdu51U84EHiV6eQ5e9a1sp4N+zyXs4QDV5R1tk4g==@vger.kernel.org, AJvYcCWZjM7hOcDfne+m4qVvIfQasUzlRpT8VmC7FQZuPtvtESbiNDehYvqCtci6FTGKFYulHYJMxxgZC/t7BhlA@vger.kernel.org, AJvYcCXGAxqNjcBZhsEXYhCx6WCCJDmWzQ1sMA+axg3KxYk6adaHh41N0cJMwFO8EXHc2Oxugiy8Lc8f@vger.kernel.org
X-Gm-Message-State: AOJu0YyYVxN/KroHpa3JTR/ED4SMy/s5CnV36vy0Y4yRV4gypId6Z7dF
	gReya0Xj1CJtkYqeZllm5JPYw0DjvjiEOF21xnR4ZoHOXUNSe6njEPQc
X-Gm-Gg: ASbGnct8sFgvvspRGSr6Uq9GQCTjalAQRXESuQhJC5SKxhtkKUVYT2Q4kIXamYAOaVP
	zg/xRPSbiepT5JZhiB2JUsSJe3NqLq54U6MPBUQ5agsOdmhj05rUlnG3a9pZtgY/1vDgLbITtsE
	zw7aWSvsl89d1uVrg+5OhZZzDA2FiZqh3gNO/NMI90NlahqlgHpfTt0OQq6LDXpgSLKaUCQRSgd
	JyCBTtkEEmUAK5aQqTUI/RJr7uUNaNbv0UufERUfCzKbwEGxTZTNBtUfoFyDRLlAoWBSn8OIOCW
	dW/rzKJtL/a+cNGl/fDKIn9xsfuXEee5IWOZmtyx47A5aHBtlTh8qZ5/Q7jqUQ==
X-Google-Smtp-Source: AGHT+IEn+9dMRrH8DN/e6Mt7FBhNbDQtsoQnNYsnfAv7aLn6S8/nHJo/gZniov+3n78HoXJEC+GV4g==
X-Received: by 2002:a5d:5f84:0:b0:3a4:f430:2547 with SMTP id ffacd0b85a97d-3a4f7a3e50dmr580875f8f.6.1748551722255;
        Thu, 29 May 2025 13:48:42 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.146.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfbf40casm29286315e9.4.2025.05.29.13.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 13:48:41 -0700 (PDT)
Message-ID: <eb82d1c8-fc85-4bcb-aba2-f73c31d69cd3@gmail.com>
Date: Thu, 29 May 2025 21:49:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 18/18] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
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
 vishal.moola@gmail.com
References: <20250529031047.7587-1-byungchul@sk.com>
 <20250529031047.7587-19-byungchul@sk.com>
 <CAHS8izNyXM_KQiySAw4hZQ+FU8yxAZmcqvjsO7P3pM0HNy0STA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNyXM_KQiySAw4hZQ+FU8yxAZmcqvjsO7P3pM0HNy0STA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/25 20:54, Mina Almasry wrote:
...>>   #endif /* _LINUX_MM_H */
>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>> index f05a8b008d00..9e4ed3530788 100644
>> --- a/include/net/netmem.h
>> +++ b/include/net/netmem.h
>> @@ -53,6 +53,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
>>    */
>>   static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
>>
>> +#ifdef CONFIG_PAGE_POOL
>> +static inline bool page_pool_page_is_pp(struct page *page)
>> +{
>> +       struct netmem_desc *desc = (__force struct netmem_desc *)page;
>> +
> 
> Is it expected that page can be cast to netmem_desc freely? I know it
> works now since netmem_desc and page have the same layout, but how is
> it going to continue to work when page is shrunk and no longer has
> 'pp_magic' inside of it? Is that series going to fixup all the places
> where casts are done?

It's expected the struct page will have a type field once it's shrunk.


> Is it also allowed that we can static cast netmem_desc to page?
> 
> Consider creating netmem_desc_page helper like ptdesc_page.
> 
> I'm not sure the __force is needed too.
> 

-- 
Pavel Begunkov


