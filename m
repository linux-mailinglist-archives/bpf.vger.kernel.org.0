Return-Path: <bpf+bounces-70580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6759BC3D25
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 10:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFA43AB567
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 08:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5729B2EC096;
	Wed,  8 Oct 2025 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfJRUJB3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3162ECE90
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912111; cv=none; b=gCg8HwWEGAcO513GeFTOkT70HuRcnVa6sfaJqC8YVWDnpjyEMGJRUP3RWIUwgv20waeXm1zZwixqiA+k97GVpzD75tmUoFr75uEGbkdXgVpNmOVWHWGYfyE4lRdgZVIGscZGZoAs2uKIlRB0s2bXCvP3jsggnCdY2ndrF8THY/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912111; c=relaxed/simple;
	bh=uPuRT0rKbd169LhyOP8vq0tnZqYlljfoH1xigVhCgk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moCPcxG3qV2Oicz5gblRmkfkJ4sXFC902LfN0wtGZySQYkg2lJjiY9DV9gV78XWR2nI9GTGRRWSOkL45LHbegd339LKuWGRde78bdm8z08YOYMAln5MYMO+OUPtpLiUh508fX48hPIb8KDh5UsFE5pmiP3WHDwzo2XKIIf7gg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfJRUJB3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759912108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lgA+tVTVFPOH/IagYGfwbQiNMHCdePGaYyMYs/mQ1ng=;
	b=PfJRUJB36rmSEWSNSdsIjcjXS+z03d85mprVPgftoFLJJwatgjOn7uVDuNByp5sEWz3eX0
	IH/EfxFB6/vyKbRlyFn4tjNNlfqiFcGaNyeKKcYZAJYqcsQgU2ivWFj5y8M8Qc730VZ/1G
	ueJPncuOZ+jMJNiSM12+OnCSPnl0eDU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-FK9ilSedNdur6ic3hnm2fA-1; Wed, 08 Oct 2025 04:28:27 -0400
X-MC-Unique: FK9ilSedNdur6ic3hnm2fA-1
X-Mimecast-MFC-AGG-ID: FK9ilSedNdur6ic3hnm2fA_1759912106
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee10a24246so3685880f8f.3
        for <bpf@vger.kernel.org>; Wed, 08 Oct 2025 01:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759912106; x=1760516906;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgA+tVTVFPOH/IagYGfwbQiNMHCdePGaYyMYs/mQ1ng=;
        b=a9yBLkO/piJ0F5WPBr6PM82cQAc3aeLNGiLX+5h2g2ShspOlOq/mJRpzNn/HTjECfr
         g4rf9hWeROugQ3UmXawVCn8Eq4j0HDaFMhgXlzzJvZvScgMsq26//dVsgXd86kFoBpza
         PdMiuQiA4tBd5Fhnpo4QWCL9QLtQBUuF0XnH7wkzIRBAY3MgWs9gixB1upjvvHK2Zbpg
         tl+RA+iPmZaVhPeCGudXOTs++lGtBwmPB8zhFI/XrNEWBSzlS9DpfQn2GrESnsDVlTuO
         u5BaOPMM1MPiLHYpriHAQHN9F5gbyl1V6jnfTnJFBG8YW5OfpXu41hIrceMIEY8hpf8A
         rJPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYioWsrGK0OvBrXRjXG6TwUB6K5s6IzTdmVDsDatDrkVEaB/NH6L0M53r37gqdW998cy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cT8p28IsS6fz6lW8ie/cYyuOwF+C5NMhAGcZd4CtqlBXs5vw
	QU2fPtzA3Dq85tmTjBcFHKvPGwCI2WkcpYpSE7GnQY+DMe6CGTrsxP0qflwtqxBVCRHHyI9e8Sg
	ycj8WUU/K7xfN0R0wyL7kr7ork6ExnStbe9RYeV2dS1d6lAeg7lBzcQ==
X-Gm-Gg: ASbGncvTVIoqdNKaNWYhk4WeIuE146+ZMLk+OUdWP9h4jF1aHMkg06s9XTVVVR0UHEQ
	5YxDSe6bqtF40UL/tSsDq7CgWEWB2Jv2XA8QT9vy2v2NdCmHN9trwaeqeW3danJ6cl0idtMGWpQ
	BQDGWVl7XUJY3JdKhHSDkw5BGGpQwiI8AIkJIH43bfFzEvOoC0Kg+AyBv9ABGAruM41WmjWe43Y
	5EKU2kO8Hy4s5x2UUa5gbI/87tjyTzlyMiq+ktNxyf3bY3nmd5FQ+im1RZNHFlFU2a2WfSci8MZ
	rHPALfMiufqYCLr1XX7WY8oLh0R80vPg0KKbl/FSB523EhylKXFbsDdo7EnM6kcKw7jx0r12dzm
	8tg51v71F
X-Received: by 2002:a05:6000:1ac8:b0:3ee:1118:df81 with SMTP id ffacd0b85a97d-42666abb532mr1522629f8f.13.1759912106373;
        Wed, 08 Oct 2025 01:28:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU7A/ilDozaFzXNrA4EK/JkMpcDnq8RVYdbBoUgVDvboLxb5QtC0kI8nRYuU9+KmgVx5jgmw==
X-Received: by 2002:a05:6000:1ac8:b0:3ee:1118:df81 with SMTP id ffacd0b85a97d-42666abb532mr1522597f8f.13.1759912105942;
        Wed, 08 Oct 2025 01:28:25 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0853sm29247216f8f.50.2025.10.08.01.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:28:25 -0700 (PDT)
Message-ID: <7723a2c7-3750-44f7-9eb5-4ef64b64fbb8@redhat.com>
Date: Wed, 8 Oct 2025 10:28:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, ziy@nvidia.com,
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
 <27e002e3-b39f-40f9-b095-52da0fbd0fc7@redhat.com>
 <CALOAHbBFNNXHdzp1zNuD530r9ZjpQF__wGWyAdR7oDLvemYSMw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CALOAHbBFNNXHdzp1zNuD530r9ZjpQF__wGWyAdR7oDLvemYSMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.10.25 10:18, Yafang Shao wrote:
> On Wed, Oct 8, 2025 at 4:08 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 03.10.25 04:18, Alexei Starovoitov wrote:
>>> On Mon, Sep 29, 2025 at 10:59 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>
>>>> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
>>>> +                                     enum tva_type type,
>>>> +                                     unsigned long orders)
>>>> +{
>>>> +       thp_order_fn_t *bpf_hook_thp_get_order;
>>>> +       int bpf_order;
>>>> +
>>>> +       /* No BPF program is attached */
>>>> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
>>>> +                     &transparent_hugepage_flags))
>>>> +               return orders;
>>>> +
>>>> +       rcu_read_lock();
>>>> +       bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
>>>> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
>>>> +               goto out;
>>>> +
>>>> +       bpf_order = bpf_hook_thp_get_order(vma, type, orders);
>>>> +       orders &= BIT(bpf_order);
>>>> +
>>>> +out:
>>>> +       rcu_read_unlock();
>>>> +       return orders;
>>>> +}
>>>
>>> I thought I explained it earlier.
>>> Nack to a single global prog approach.
>>
>> I agree. We should have the option to either specify a policy globally,
>> or more refined for cgroups/processes.
>>
>> It's an interesting question if a program would ever want to ship its
>> own policy: I can see use cases for that.
>>
>> So I agree that we should make it more flexible right from the start.
> 
> To achieve per-process granularity, the struct-ops must be embedded
> within the mm_struct as follows:
> 
> +#ifdef CONFIG_BPF_MM
> +struct bpf_mm_ops {
> +#ifdef CONFIG_BPF_THP
> +       struct bpf_thp_ops bpf_thp;
> +#endif
> +};
> +#endif
> +
>   /*
>    * Opaque type representing current mm_struct flag state. Must be accessed via
>    * mm_flags_xxx() helper functions.
> @@ -1268,6 +1281,10 @@ struct mm_struct {
>   #ifdef CONFIG_MM_ID
>                  mm_id_t mm_id;
>   #endif /* CONFIG_MM_ID */
> +
> +#ifdef CONFIG_BPF_MM
> +               struct bpf_mm_ops bpf_mm;
> +#endif
>          } __randomize_layout;
> 
> We should be aware that this will involve extensive changes in mm/.

That's what we do on linux-mm :)

It would be great to use Alexei's feedback/experience to come up with 
something that is flexible for various use cases.

So I think this is likely the right direction.

It would be great to evaluate which scenarios we could unlock with this 
(global vs. per-process vs. per-cgroup) approach, and how 
extensive/involved the changes will be.

If we need a slot in the bi-weekly mm alignment session to brainstorm, 
we can ask Dave R. for one in the upcoming weeks.

-- 
Cheers

David / dhildenb


