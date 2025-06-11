Return-Path: <bpf+bounces-60328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CEEAD58BC
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F2A7AAE38
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B42D2BCF75;
	Wed, 11 Jun 2025 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpiEgkrj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B432882DD;
	Wed, 11 Jun 2025 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652151; cv=none; b=Q3gRHeCOGomykeYkcloBWvFl62v0D7cnu+7wK9UTO+fLe9NiwnhC2MbVkvBjdD1Al0ejY/tAGDWqXOCPIygPNWem2w7tLVOUet4dBvjRw/2ffPybzFsVuHUmA/K3qbNxb2g5dLz8yA7xd8KhJa1lf1UcwxZNCF8l68CdO8AIums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652151; c=relaxed/simple;
	bh=UxNA7j6sLsgsrjFV1dPxluvU1vzmXNZ8ByJQsQehtIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Txw1qEhTFG/8TBDsCetIBvx9BO7sJyk/eEvVNy5oLzcj9o60yXCd1hEZVmgQigvAswEFeilmaR3ev8LVoou1Do3K4M+mS8HX6gytiRORsZHCo66dR0Pn5Pb16AINrtaVfGAHk6JaFyDudYSHWxDbDS4HQGXxBzQrSvHXZwX416Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpiEgkrj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a35c894313so5940635f8f.2;
        Wed, 11 Jun 2025 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749652148; x=1750256948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5y5kfhj5cbce1cwVnaZbUHmhhz08gC5FIwyfzGaoaCo=;
        b=FpiEgkrjkQZxgF5ZBMdy+Pm4xBj24jIVJ1v4wBER/tsxezVwimJP81S/LCXf64UhML
         NP/muKQlHw7VfrBmAYsUw3cyP105+ICBL/kP7/kBQAgOUIv6/FDbPAs8uu8kbxiqH/Ip
         siC4Bny3SXOXa2xhK+YAZscWJO9DLC7FMmJJdCyUKaLyZs2/HLgMJ2WYAnf5aJnJpmLJ
         FCgYqp1c3z8UWJvUuF7aGBvetO0zn6NvbOeA7L/qiqW/AeecY8b5uBZJp/5fK3+3Nsu7
         gRIoyhwPBV3ydvMOsCI7/zbGXq78ldGdd9wHD4i2r/J1Ict/Kln1QK5MGIyx1L/MC2kI
         sG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652148; x=1750256948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5y5kfhj5cbce1cwVnaZbUHmhhz08gC5FIwyfzGaoaCo=;
        b=YIOGJs9nO/IcWbKY+Y5ZRgofEP25YLijGqY8y9IGGOXdkLnF6QCRQgUS7sXRG8xk3u
         Wl/L91FXZX22+7UtE7p6EESaI1nxVKjsP5SXpZyUB83baUtxV9axkLGnWM7/haKL7Zi+
         vHbH2UoEWfTwjaPwJs0QsCzZQGlJPyO7g97wJUP8dULYw5GAei3liYwrYAaLnzJ66X5E
         XyPP0UwMHG4x4vwJL+jABhtYxdwBar7gMTHj1nEyisqa05QdDYVIY13OkT37sz8I08U5
         snfYSg9uV81y1OPBEh74GhO96WvJQZroISlu7XAxIuO3Q0xt+RdiWm6d5JwVabfeR/Fj
         46Qg==
X-Forwarded-Encrypted: i=1; AJvYcCU3xB4BDgbcmyb7XKOrp3qEbqXhV8o8dFl9De2fir/2qOwFioouUfdI6dNw7DbdiIkbfaSdeCSA6+/Vfw==@vger.kernel.org, AJvYcCUzZRFonfet7t2F4wc3/XkQNlobpgUdirluW0sNQozIgXrdXiqA9voyBxcRKAlC4zvkrBTlvoi3wPGWGFBl@vger.kernel.org, AJvYcCXTe80VQKDn2/3f0dWZ3vMN0hdLXIXE59vsYrrp7ElNz4gBw2jUNGEJf9Z9Ii36ZOqAguU=@vger.kernel.org, AJvYcCXUmeB2DrnKASDcO76jug7cx8r46cWxTPYsYQjsxlLDcZEMd3JA8OxoOh2HzCUcYA2y7JESh2Wt@vger.kernel.org
X-Gm-Message-State: AOJu0YzLR0gAB1MlTJAQLZDAfcA96fML+VC49CO1D2S6qRgsiaS88sx6
	oMzij8gkftiBFaRJMRm4EtK+Uo/4UpnfocUd4RIpQlvpsUwjtys97ENN
X-Gm-Gg: ASbGncsiTq+l/KvGChIvtKxKICuQH2Etk61bhtQS9PcVQE46u2Hxit+8FNCSSXxtKvx
	27CdkUxipAl7Ss1Eck7V7e6O5IOHd9vxeHoc+I422zJF6v20TR3czE8c1JlsYuRrnqYd0e5v3N/
	3cFyxxUjdvfJeilVOOCobrEnh/z0AEFkAWY+63lieA1dfKpGBKnrPlJeAIEPLS+2Uh/xKkHGOwu
	/y0/CrXcgTe1OGJV3TF9ba1RjWKNsoS2STZNOW45NF/Wo5BZn/RHpKMklJZRAo/6OjtcnmKwgNR
	oykq1xF+q7J+1vuTyv0zZxVPvK9SG55t2abdSxUZZh/A1ih99vBGvEx3cPUEISwALoPhSnA=
X-Google-Smtp-Source: AGHT+IHmkB8/NBjZkYtctHG9v624zEnD1N4W2D/2KDPOKG11BkanIXfCpmFC/D77CHTnUyMvt0ZpaQ==
X-Received: by 2002:a05:6000:250e:b0:3a3:727d:10e8 with SMTP id ffacd0b85a97d-3a558a1e2a2mr2708910f8f.50.1749652147978;
        Wed, 11 Jun 2025 07:29:07 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.145.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45320562afbsm35319785e9.1.2025.06.11.07.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 07:29:07 -0700 (PDT)
Message-ID: <937e62c5-0d12-4bea-b0c1-a267c491cf72@gmail.com>
Date: Wed, 11 Jun 2025 15:30:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 9/9] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
To: Byungchul Park <byungchul@sk.com>, Mina Almasry <almasrymina@google.com>
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
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-10-byungchul@sk.com>
 <CAHS8izMLnyJNnK-K-kR1cSt0LOaZ5iGSYsM2R=QhTQDSjCm8pg@mail.gmail.com>
 <20250610014500.GB65598@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250610014500.GB65598@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/25 02:45, Byungchul Park wrote:
> On Mon, Jun 09, 2025 at 10:39:06AM -0700, Mina Almasry wrote:
>> On Sun, Jun 8, 2025 at 9:32 PM Byungchul Park <byungchul@sk.com> wrote:
>>>
>>> To simplify struct page, the effort to separate its own descriptor from
>>> struct page is required and the work for page pool is on going.
>>>
>>> To achieve that, all the code should avoid directly accessing page pool
>>> members of struct page.
>>>
>>> Access ->pp_magic through struct netmem_desc instead of directly
>>> accessing it through struct page in page_pool_page_is_pp().  Plus, move
>>> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
>>> without header dependency issue.
>>>
>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>> ---
>>>   include/linux/mm.h   | 12 ------------
>>>   include/net/netmem.h | 14 ++++++++++++++
>>>   mm/page_alloc.c      |  1 +
>>>   3 files changed, 15 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index e51dba8398f7..f23560853447 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -4311,16 +4311,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>>>    */
>>>   #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>
>>> -#ifdef CONFIG_PAGE_POOL
>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>> -{
>>> -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>> -}
>>> -#else
>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>> -{
>>> -       return false;
>>> -}
>>> -#endif
>>> -
>>>   #endif /* _LINUX_MM_H */
>>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>>> index d84ab624b489..8f354ae7d5c3 100644
>>> --- a/include/net/netmem.h
>>> +++ b/include/net/netmem.h
>>> @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
>>>    */
>>>   static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
>>>
>>> +#ifdef CONFIG_PAGE_POOL
>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>> +{
>>> +       struct netmem_desc *desc = (struct netmem_desc *)page;
>>> +
>>> +       return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>> +}
>>> +#else
>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>> +{
>>> +       return false;
>>> +}
>>> +#endif
>>> +
>>>   /* net_iov */
>>>
>>>   DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 4f29e393f6af..be0752c0ac92 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -55,6 +55,7 @@
>>>   #include <linux/delayacct.h>
>>>   #include <linux/cacheinfo.h>
>>>   #include <linux/pgalloc_tag.h>
>>> +#include <net/netmem.h>
>>
>> mm files starting to include netmem.h is a bit interesting. I did not
>> expect/want dependencies outside of net. If anything the netmem stuff
>> include linux/mm.h
> 
> That's what I also concerned.  However, now that there are no way to
> check the type of memory in a general way but require to use one of pp
> fields, page_pool_page_is_pp() should be served by pp code e.i. network
> subsystem.
> 
> This should be changed once either 1) mm provides a general way to check
> the type or 2) pp code is moved to mm code.  I think this approach
> should acceptable until then.

I'd argue in the end the helper should be in mm.h as mm is going to
dictate how to check the type and keep them enumerated.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


