Return-Path: <bpf+bounces-59135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F50AC6353
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C874E0037
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B379245000;
	Wed, 28 May 2025 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/mMw2F6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C0193077;
	Wed, 28 May 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418641; cv=none; b=lMrPXmyfyLS4j0DMtawgBprF62lgAzsAIYt41SUk+Bt0q9oaH9/Eaxu11SUqVLvDNJN5kLz/URnSmpsWvafOy6y5FejDE3iTHkbkICkYoaygIclHL6rEjOTBOrgnOBRz97LGAakUpqWNNnbJEh4yTgqx9QPeHho1V1uYVeBUT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418641; c=relaxed/simple;
	bh=/zyrLXezRJjYrfxpfUoQ6048QS9eM9+IT5qoZfTuJC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTJdKseX7fKlQQWgCXQCDIWinEqPHGZUbXZob3QhCDgSkTUkPFunkPVRiFmMPziL9coz4sZbDpGI4gHlBK0Orn4zdYG9RD0wPWSjq5GyhWm7jU2dB34UXVAJCOUUXWs5uECmwoomHswIIbhCpviDJbiqvPBdzgKSip1I2629Bqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/mMw2F6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad5273c1fd7so845961266b.1;
        Wed, 28 May 2025 00:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748418637; x=1749023437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PFDvh+xhYK9vwsPou+GJtGwXTTWho/iEsaQhsuFcYPk=;
        b=a/mMw2F6XRftS0L+tQbti+QZmY2tDea6rorSLlQrwZ+PtnNy4WQPvxxXMrNHesQl/A
         dLCQ0IPONSJ6rNpNXiygRp3aru/JaAqOjEszSS3r5rUl6Q38mA3d+m5x4zRLxvrtjmaV
         KBYqPHWvPxhN3c2++Kb4XGCwRyxB01V8S/Ygf5qpjiW4PyxRu+Xez09EhSnLvO6uL7CQ
         /NISuiHAL5tUHzeH2Dlr9EiFTlFzyap/6YslNJn8UrpBN20QtWUBnlwwU+6P9rY8O1CC
         O0XeC6mA8XvYrM/lw9DXMvPKjbaWHzF7RKC5rYuMhyT6OZHPqxbHrhdtggEQpLPlaZv/
         5n9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748418637; x=1749023437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFDvh+xhYK9vwsPou+GJtGwXTTWho/iEsaQhsuFcYPk=;
        b=RKfPA3ZtZLuYCaH5K7oGIVJ2kBHF3x3m9AB66oFh8/CPMmw9i70xSe5jLB48LCesrj
         NMbaw4u1+4k8cJzg/R3uXYuEet0MrAN8S4R8vXr+e3Wf9kEiPFiM0jAqL8g2BB/JL3RA
         uiBlc+bv8qL+MCEm6a+woRzQLAaSXLnJ+7fZL8iOByLtX86Zv3IOLIJFA8Kk2KJibDmE
         PX72POawLo6hNfE5PakWE0bkBshsYs23HzeXqvZg98uyiw4eMiJYgIDlC/yDEVk3wY0r
         Piz5T4DMdFARZeeQ7KG5KGEW7VCP3WVYMRdbJ3dRpDHuE6kfvr8M7FUKgfanXamCx9gU
         s31g==
X-Forwarded-Encrypted: i=1; AJvYcCVI05DsSo3cti1shxMaS9vHc1x17Gqdf2NgTG3pd2FvM7+MTq8/YRMQpMjhpoZyKTItX1av80wzDw5HOpbM@vger.kernel.org, AJvYcCX/9/UUSJw7j0qMr8T59R5k/1gPhB5W9Bt3r55PxZqDl95P816X2nY7EJDesj2wXZPIoBVtXx3zM//HtQ==@vger.kernel.org, AJvYcCXWO+rvqXvpNfDAm3/McENAp6WPo+4M1r17cNqHzgBA6wUK1dSWtVCHzUshUMaPsEgRnPivqCP/@vger.kernel.org, AJvYcCXtTRJmJx9e9g3vLUpvBL1U/leyt03lRFxoSzGQB9yfwsah90452lBtZxqCA4qrX0gbsoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3qLxQ1UNHWeagQDWp30SjfYHRj1FxH/6gLWxYHxCehwEKlmVX
	blIDmuHJ0CLrcD/vDwuU4mTktj++AFf130MbEpH+gitf+HewRx68dY2b
X-Gm-Gg: ASbGncskm0l7mEZeEAzCk7ZoImEaqkBQW7qocY2r501BR6/2aySLRMid11dvPicTUsK
	45he/+hI8+eLWMO+EupQfx3EDCbTzYBcdo6h7m+BZokD3lcjZuFQWwK33D765d+G8HEUu6+zYCb
	Lie04gDeosKcPWOxfRl4qQVVIO3DCozePZvEeF0Gj1ohEFp0Zi/ef56U+892pU0y1hAiwPyHmMP
	cPGVfrdXHvznRHEA+bq0+8Qi1515guYA056cE9RHYsi77lztuxnWD2OFU8Y+rrhTuVtI/o4tecf
	4H+tf83x5JLh0Y0cICylXcOGLyzjq7ypGxAUwILVRqHtvmMogK0R5eRQA46gOkyiKrt6l1LZgA=
	=
X-Google-Smtp-Source: AGHT+IHzIvt1GsZdZ9b+8NwHHnVvWWl+yKTgbs8TGJXB/bYOk6vqqvJWk7DJJKDVW+H4h0XE0+Ln5g==
X-Received: by 2002:a17:907:9688:b0:ad5:2a24:7c09 with SMTP id a640c23a62f3a-ad85b2b55e8mr1294527966b.60.1748418637260;
        Wed, 28 May 2025 00:50:37 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::6f? ([2620:10d:c092:600::1:c447])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6051d79e78asm399291a12.65.2025.05.28.00.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:50:36 -0700 (PDT)
Message-ID: <a4ff25cb-e31f-4ed7-a3b9-867b861b17bd@gmail.com>
Date: Wed, 28 May 2025 08:51:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access page->pp_magic
 in page_pool_page_is_pp()
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
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250526022307.GA27145@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/26/25 03:23, Byungchul Park wrote:
> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
>> On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
>>>
>>> To simplify struct page, the effort to seperate its own descriptor from
>>> struct page is required and the work for page pool is on going.
>>>
>>> To achieve that, all the code should avoid accessing page pool members
>>> of struct page directly, but use safe APIs for the purpose.
>>>
>>> Use netmem_is_pp() instead of directly accessing page->pp_magic in
>>> page_pool_page_is_pp().
>>>
>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>> ---
>>>   include/linux/mm.h   | 5 +----
>>>   net/core/page_pool.c | 5 +++++
>>>   2 files changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 8dc012e84033..3f7c80fb73ce 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>>>   #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>
>>>   #ifdef CONFIG_PAGE_POOL
>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>> -{
>>> -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>> -}
>>
>> I vote for keeping this function as-is (do not convert it to netmem),
>> and instead modify it to access page->netmem_desc->pp_magic.
> 
> Once the page pool fields are removed from struct page, struct page will
> have neither struct netmem_desc nor the fields..
> 
> So it's unevitable to cast it to netmem_desc in order to refer to
> pp_magic.  Again, pp_magic is no longer associated to struct page.
> 
> Thoughts?

Once the indirection / page shrinking is realized, the page is
supposed to have a type field, isn't it? And all pp_magic trickery
will be replaced with something like

page_pool_page_is_pp() { return page->type == PAGE_TYPE_PP; }


-- 
Pavel Begunkov


