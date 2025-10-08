Return-Path: <bpf+bounces-70578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E408FBC3C2C
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 10:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D59C4F7C99
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E5334BA3C;
	Wed,  8 Oct 2025 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTW+KpQG"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED992EDD5F
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759910923; cv=none; b=r7U9PCPCExgLkpFgGRr8ngEcwW/qhgFm7bnd/1c1iV6+2DR1NOOOYeVhTLtafFaYTVIKmqgvs54Qf6mkWGK94fSw/HVJ9E3Vq7l3XHZU+eqD12mwsxMw2pe7y2dOnR9ZQoeAJCwKvhRExGHzYto0l2cM4SrPemoP1y8z3X/59Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759910923; c=relaxed/simple;
	bh=0oBuy1AvIFn9zFaE6aFYo2LPcYpCIpUnDurQ5XCDCUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcJTFVeTlyF0Jl5k6Qd46NLghGXEAo3pam1+XeY2iRhWMvfVxBKyJegv0eLZm6C3QV6DyjhjkmHAkYJ7FPEFKnCHQ9XUAWvtqm8YJqejtxbOx4tA7ToBsftiBsgpqc19qTLPeprmJ8WQx0thasF3+FdQgFz4qD5bzPdYXVrfOug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTW+KpQG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759910921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qUJOe88Utm5QNIgMeCqO4mlDI62Txc3nSegvqhoAV8o=;
	b=UTW+KpQGSYVm0zm6yV87cia38kjiVJevLrW2RgND4J6d3PcByGTdAsbjxG3JZxocdq2fNU
	banPJkQCDFsw83KZuiJ2CneiwE+YE2huoiVXc0Ypav6Z3+b8lTrDtWU5Lom+AP1uJAKnS2
	dpgD95Dn4LyDz0kX1nKrTjZd3EizbFc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-DdKd4wR4MD-XObiOwh7J_A-1; Wed, 08 Oct 2025 04:08:39 -0400
X-MC-Unique: DdKd4wR4MD-XObiOwh7J_A-1
X-Mimecast-MFC-AGG-ID: DdKd4wR4MD-XObiOwh7J_A_1759910919
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ed9557f976so4791045f8f.3
        for <bpf@vger.kernel.org>; Wed, 08 Oct 2025 01:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759910918; x=1760515718;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUJOe88Utm5QNIgMeCqO4mlDI62Txc3nSegvqhoAV8o=;
        b=WY+I4Efz3J8k0JOUR7MOxKKwuVzNPPanjX6CG0grsDHyRb7gaV4CkfIbpt7FCY3cQM
         A0vTIuJBKZV0qyyIp38q3jCiO+LnOO5yufXlw2n76KZmX+g6XfV/9beerppnkLj87vQq
         +Qg7x8xWhleFWOoimlnzbvRJ04Vbu7gej0OjTAvMLU3Nkr5ADGiocamfrsLzmVoOTJYx
         4XEiQG5ZNGDRA0W9SLy/JFDQtkkIQ/LLXlA0CsGwAmp2zp9iAU5q9Bz9USZNiJY8IoyD
         pvA//iE9PEEOLnEAowYYbnssAq0sa/umnxoyJjmYo/1dwZO0DamPgfZrHCtq2KcAF/PP
         nGDw==
X-Forwarded-Encrypted: i=1; AJvYcCVHyb12ryPCvDreLyxgQLfsoNtRqJY2XXZSumTJxBv/ttlJBjH6L3xB/O/dl+oP5Ku5bmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLljkZl1W5uGaWGaYusTZZtiCF7B2uGOgu8aExo8ItQfImnBLA
	FF+71qcxxo32WbxpKtsJo514PTfdb0jJpNr4RzWZkO8lC9Awy0DJVo+uJ+mqezZY/zv68+3QiX+
	uExWx/v6jEabqjAEdRjCjFO4pO0wRu9JVPYcBpDw/P5n+aTE83LW7dg==
X-Gm-Gg: ASbGncu7/V1l8mjQMArbMcfgZ9LMOy7qBduX4vtCuJksiq9z3ajfqqKVhFUmBqlYzCu
	3Zll9L/TrBJOxjGcFvLs8uTIkZiCA0sBT/Lngse2NO0UTejyJZvYhhmJ4VJVBbSfcPNJfwJzLub
	TVmjHqjTqsk17mv4c+cEUA1w0Mr/nIqUJ6/eTrt/nJJiDePFRgQYY/wBqMFLSJpnGkJhNpFIsB5
	tANlOhSfBqN2JE7LCrJKE9bUU/HWT2xHbN2g/p5GUxxLZFyJq7MH4eRVfwCulXaPsbscerMNlqc
	PVZA7pmaB1cxAkKXSIAiVTS0npqvSSm1UfN35zxVMHOUBdAYMjWceWazDqQr49O2tAP3bMaXQu6
	OhPpBNdle
X-Received: by 2002:a05:6000:230e:b0:425:76e3:81c5 with SMTP id ffacd0b85a97d-4266726c314mr1495469f8f.17.1759910918429;
        Wed, 08 Oct 2025 01:08:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeXMx3ZBbvp7+9qSDMAqpT3IYsrp+qNxlZMMZPXXl0yLI8Wog+oOvMr+BPXNZWvH4I9ELECQ==
X-Received: by 2002:a05:6000:230e:b0:425:76e3:81c5 with SMTP id ffacd0b85a97d-4266726c314mr1495424f8f.17.1759910917942;
        Wed, 08 Oct 2025 01:08:37 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf87c1sm27190025e9.3.2025.10.08.01.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:08:37 -0700 (PDT)
Message-ID: <27e002e3-b39f-40f9-b095-52da0fbd0fc7@redhat.com>
Date: Wed, 8 Oct 2025 10:08:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, Johannes Weiner
 <hannes@cmpxchg.org>, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>,
 21cnbao@gmail.com, Shakeel Butt <shakeel.butt@linux.dev>,
 Tejun Heo <tj@kernel.org>, lance.yang@linux.dev,
 Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
 <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.10.25 04:18, Alexei Starovoitov wrote:
> On Mon, Sep 29, 2025 at 10:59 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
>> +                                     enum tva_type type,
>> +                                     unsigned long orders)
>> +{
>> +       thp_order_fn_t *bpf_hook_thp_get_order;
>> +       int bpf_order;
>> +
>> +       /* No BPF program is attached */
>> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
>> +                     &transparent_hugepage_flags))
>> +               return orders;
>> +
>> +       rcu_read_lock();
>> +       bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
>> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
>> +               goto out;
>> +
>> +       bpf_order = bpf_hook_thp_get_order(vma, type, orders);
>> +       orders &= BIT(bpf_order);
>> +
>> +out:
>> +       rcu_read_unlock();
>> +       return orders;
>> +}
> 
> I thought I explained it earlier.
> Nack to a single global prog approach.

I agree. We should have the option to either specify a policy globally, 
or more refined for cgroups/processes.

It's an interesting question if a program would ever want to ship its 
own policy: I can see use cases for that.

So I agree that we should make it more flexible right from the start.

-- 
Cheers

David / dhildenb


