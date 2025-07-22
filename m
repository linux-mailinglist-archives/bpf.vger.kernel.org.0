Return-Path: <bpf+bounces-64004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68988B0D2F9
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 09:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478401889660
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 07:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021252C3240;
	Tue, 22 Jul 2025 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObkS81Ym"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9CC273FD
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169290; cv=none; b=QYTMXmpY5/a8fzHxCokNk2+JU5zt9gW3GB0hx3o+Tx5OfyvsAupIXetwdDyFSLJN79BmAKSuipAPfKvEYuhcH9Nh77wzQkbL7a5nsQDfNg1DEM4BrFsYgV6pPHKhugoxaTCg7bYlLVHZIChqnsz64Z/oTvN8st5IbN/YaPVgxv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169290; c=relaxed/simple;
	bh=f3euJtCjWzhAMmjRlnYYc/d46pJsQAFVebwRNH8SbsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWqzLWWdjLjcXNH8afptmZdOQopB/fVzTVyi1kghDBp2RX+WTjW8h/hCT1JNnsMXErjlnH37loYU6J9Vc/uBcugafCM7dt1RFS+QoBJH9b6R5ak/UIZrAiT/5zCAnYLSyngX4cOf0jXpO2dwHh/vqE0BgxksPCTHRaqlLD+81+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObkS81Ym; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753169288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LlcYhCh+mpdur8Xuec9Q8Rl7fYq3nesGug78KA8JyxA=;
	b=ObkS81YmrD9wPDSZgPv+fXimiWckxNWrR2G7hkHqfvgjUvGCsvDIVh0wrPaUO3YKOUTyqe
	dlMs8Z7jrCYdyE+6M+xwqETmm+KaaAdJb+UosD8XlegLc8/aF0tI9Hggv5j+szJDbNmEy8
	wYYnDfOLp32qNx6nmZrTEborF2Hbzzo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-eKYNkF40OmSo96fIZW3OOg-1; Tue, 22 Jul 2025 03:28:06 -0400
X-MC-Unique: eKYNkF40OmSo96fIZW3OOg-1
X-Mimecast-MFC-AGG-ID: eKYNkF40OmSo96fIZW3OOg_1753169285
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso30073165e9.0
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 00:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169285; x=1753774085;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LlcYhCh+mpdur8Xuec9Q8Rl7fYq3nesGug78KA8JyxA=;
        b=pSgYfwBeqwDfEB5mhhy27cT7sUgMwal46AiNUsWteu72H6/x/8lBhvc0kCIHYacuKi
         qvtGnBT56AVsy6tq+RdwsMB27GRyw+5eZUhGikSHQSz48TCNeZuG5EcBBkucSLpeuUlO
         PVYRPI2VV+0ExV911xH5ZKDYqxM756CsjPTf1iAtwlQkBb8pcr6E7PSgKHy/7ugqyGKa
         hv7zOIfls0DwFJsLv3eXA6qitRCcyVh4J31ojHUVT+o//9UvX1+aMUBm4SPLNQu17WZY
         xHBf9L/NYDGctBmGF8irYlvWdSW5dg+aOfREuXZwiQSzomnbQfMWGKkjKtiGsoBC2x0+
         lgeg==
X-Forwarded-Encrypted: i=1; AJvYcCV/3HQ95aljFK9mpEFTm7B7PX0GCQSZ4MEtMX7Hj9LIW06TJMVHAmXqw5u6s1i68B5otYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+AvTqjSupCXx63oKje+hLGsKw/FV2l9nz7xMc5mWqy69L5Iy2
	/4v8fvFPLYuDLmKvRSetPCthGinUQ+ejtrpUc8iwbReIunBX30yq3CkpN3Kdh6M9vpn7fjnHZPO
	HBdGriYFAYbmAZHWvt3MwvSh+aB22Zi1xWLXbNj89tlQ48HbYv9GGWA==
X-Gm-Gg: ASbGncsux32c2UuhUR6vrFXswlCQgQVoAGNL4fK2/XDS/GkhIauTsi37qQ+djU5qPDc
	0O2k6KeI05tj5rHMt6uewhh9qCNk84C1/JdjQBLwuORALELkspiFIyYipsFiBRtEUA7eq66XYPO
	nIbsWR8vaQYp28B/4GWIfSltC/X1uJE6bPQe710wHhXbYcd+IqYv6+uqF9YLaQ6y9+yw1KBephx
	FHTkfEvnvoXR4NmQUO0j5Pmpq4kIOzMqzG85lQmv1Z/jFhKEu0SIkQp6+ltVDp60q+OMugkn0W9
	O6g+A4734ji+i8iV90aSZI640Jyc3Y2hJkJs8cOoTypImoggfJ042poESbTTT0DCtN0LeSY=
X-Received: by 2002:a05:600c:1392:b0:456:1a79:49a0 with SMTP id 5b1f17b1804b1-45862727631mr20932325e9.8.1753169284859;
        Tue, 22 Jul 2025 00:28:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFal3h7GZrBj/9eVw08WSWj5annGF6W46P8sztgQLD9O5WNRuX2DX+rjlXbqp+Gv0of92Kivw==
X-Received: by 2002:a05:600c:1392:b0:456:1a79:49a0 with SMTP id 5b1f17b1804b1-45862727631mr20931865e9.8.1753169284295;
        Tue, 22 Jul 2025 00:28:04 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0f597.dip0.t-ipconnect.de. [79.224.245.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5cfb0sm12621679f8f.83.2025.07.22.00.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 00:28:03 -0700 (PDT)
Message-ID: <404de270-6d00-4bb7-b84b-ae3b1be1dba8@redhat.com>
Date: Tue, 22 Jul 2025 09:28:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250608073516.22415-1-laoar.shao@gmail.com>
 <b2fc85fb-1c7b-40ab-922b-9351114aa994@redhat.com>
 <CALOAHbD2-f5CRXJy6wpXuCC5P9gqqsbVbjBzgAF4e+PqWv0xNg@mail.gmail.com>
 <9bc57721-5287-416c-aa30-46932d605f63@redhat.com>
 <CALOAHbBoZpAartkb-HEwxJZ90Zgn+u6G4fCC0_Wq-shKqnb6iQ@mail.gmail.com>
 <87a54cdb-1e13-4f6f-9603-14fb1210ae8a@redhat.com>
 <CALOAHbA5NUHXPs+DbQWaKUfMeMWY3SLCxHWK_dda9K1Orqi=WA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CALOAHbA5NUHXPs+DbQWaKUfMeMWY3SLCxHWK_dda9K1Orqi=WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.07.25 04:40, Yafang Shao wrote:
> On Sun, Jul 20, 2025 at 11:56 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>>>
>>>> We discussed this yesterday at a THP upstream meeting, and what we
>>>> should look into is:
>>>>
>>>> (1) Having a callback like
>>>>
>>>> unsigned int (*get_suggested_order)(.., bool in_pagefault);
>>>
>>> This interface meets our needs precisely, enabling allocation orders
>>> of either 0 or 9 as required by our workloads.
>>>
>>>>
>>>> Where we can provide some information about the fault (vma
>>>> size/flags/anon_name), and whether we are in the page fault (or in
>>>> khugepaged).
>>>>
>>>> Maybe we want a bitmap of orders to try (fallback), not sure yet.
>>>>
>>>> (2) Having some way to tag these callbacks as "this is absolutely
>>>> unstable for now and can be changed as we please.".
>>>
>>> BPF has already helped us complete this, so we don’t need to implement
>>> this restriction.
>>> Note that all BPF kfuncs (including struct_ops) are currently unstable
>>> and may change in the future.
>>   > > Alexei, could you confirm this understanding?
>>
>> Every MM person I talked to about this was like "as soon as it's
>> actively used out there (e.g., a distro supports it), there is no way
>> you can easily change these callbacks ever again - it will just silently
>> become stable."
>>
>> That is actually the biggest concern from the MM side: being stuck with
>> an interface that was promised to be "unstable" but suddenly it's
>> not-so-unstable anymore, and we have to support something that is very
>> likely to be changed in the future.
>>
>> Which guarantees do we have in the regard?
>>
>> How can we make it clear to anybody using this specific interface that
>> "if you depend on this being stable, you should learn how to read and
>> you are to blame, not the MM people" ?
> 
> As explained in the kernel document [0]:
> 
> kfuncs provide a kernel <-> kernel API, and thus are not bound by any
> of the strict stability restrictions associated with kernel <-> user
> UAPIs. This means they can be thought of as similar to
> EXPORT_SYMBOL_GPL, and can therefore be modified or removed by a
> maintainer of the subsystem they’re defined in when it’s deemed
> necessary.
> 
> [0] https://docs.kernel.org/bpf/kfuncs.html#bpf-kfunc-lifecycle-expectations
> 
> That said, users of BPF kfuncs should treat them as inherently
> unstable and take responsibility for verifying their compatibility
> when switching kernel versions. However, this does not imply that BPF
> kfuncs can be modified arbitrarily.
> 
> For widely adopted kfuncs that deliver substantial value, changes
> should be made cautiously—preferably through backward-compatible
> extensions to ensure continued functionality across new kernel
> versions. Removal should only be considered in exceptional cases, such
> as:
> - Severe, unfixable issues within the kernel
> - Maintenance burdens that block new features or critical improvements.

And that is exactly what we are worried about.

You don't know beforehand whether something will be "widely adopted".

Even if there is the "A kfunc will never have any hard stability 
guarantees." in there.

The concerning bit is:

"kfuncs that are widely used or have been in the kernel for a long time 
will be more difficult to justify being changed or removed by a 
maintainer. "

Just no. Not going to happen for the kfuncs we know upfront (like here) 
will stand in our way in the future at some point and *will* be changed 
one way or another.


So for these kfuncs I want a clear way of expressing "whatever the 
kfuncs doc says, this here is completely unstable even if widely used"

-- 
Cheers,

David / dhildenb


