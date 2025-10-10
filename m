Return-Path: <bpf+bounces-70722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E35EBBCBFD1
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 09:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF6B44ED032
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 07:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614C273D66;
	Fri, 10 Oct 2025 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtUab8bh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C3240611
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082899; cv=none; b=Hq2mTtfkBDiXql0ZMEh6W9rPpE5JaHjBkyYhEX1o/3fUGidGu3FVTPaWAV/aE/BBPveX1HmtkblPmrbPgwjJH2BsPl6gG1ApfbyY4PnV4gTN7uCydnlA23RX84TtE0Q3elW/RN9g3GeOcxTJnuer8Bq6saf7yvPGVad7R6FB2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082899; c=relaxed/simple;
	bh=0VorPrLkyHUVrjuMfLD9PMg+6va8lFyrxWCZ5eKOo6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFAPi7/A9IjhZwXtbn9/dx50A2FoTvMuRYBHcQe2bQhohLmTUm09cEe2u6eLcoRI0ilxxjw+hhw1rTCd2K14Ep7CgHm/d7/+i8RyORHtaUixMKkVsjnnT0fEqC8XE78hHwpDXEaWk/QxQpGB5Pk6+l0llTcUConSVZf2iKwdWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtUab8bh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760082897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M+pjFKpPGhPGCb6BNB3UehKfe41+RfPzqJkeretXuck=;
	b=DtUab8bhf8tK91VdWbE7Nq5fBW6qLMGWK1MB3we4NEmxi60ABd11FKSjYyj1uKfodqYXm2
	pq0bV9GOnBVZUfhjU24lUtcGdDCg3wd9UKGkcujb5tXu4bxYLY+3CvDfE4semfcYJI9nhk
	4hCvdDh5D4Yx+X3XtOYPASvVn0ssczY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-X3YPs0v_OkKkmmw4HujNJw-1; Fri, 10 Oct 2025 03:54:55 -0400
X-MC-Unique: X3YPs0v_OkKkmmw4HujNJw-1
X-Mimecast-MFC-AGG-ID: X3YPs0v_OkKkmmw4HujNJw_1760082895
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3efe4fcc9ccso1428186f8f.3
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 00:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760082894; x=1760687694;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+pjFKpPGhPGCb6BNB3UehKfe41+RfPzqJkeretXuck=;
        b=NSCY2dMMYVWwpiQX5YCJcTSDdj90VQfrSfw1QOLd30fCJZMkkPCDejaTSn2ew2sT7o
         LH4ooha6lRFIjxLtFszLRXfonvogpzfdsWt0+z2tM2NyQR89P8kefit3hQb9lPvVXXJ/
         JQdstJR0tg9FyFk6ojt/TQDRw0Cnkk9XeKUxUsksFXc3Aj/Xr+SM22oML4MiWFVhqhNc
         SHTZ7yef5HRHv5iEdt2+isbRkQjZm1fbzmGGlxS2amIDaL4kusaA2l2Y3IDYt6/oYWBr
         KxWyqJwrQMe9XsGBECPaCOAsqpYvEUtaGedwEp8nj+5l5I6l5Y6V4eeMz46W8hMa4qCt
         wdKg==
X-Forwarded-Encrypted: i=1; AJvYcCWZxpss3NK1FT6VBG0cy3n1t/GER7xPVhQgF2dU8hnXRR/6jwG2WfzC3we4sSjsRnN0LUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdmQ/trQ5Fc7v68KxNAnaesAAqD3ldpO4xl2vcYhIUCbdBsMxJ
	XudTWKvb3CwUXH4qr1iWFMS0lFrN9/s6iMRP6exxF5UyQ0hNCb1ZtU+9cEGZpL7N+R7gwZQz5m4
	7vtBdft94jaShP/rZot2sKJ1jPmPXMp5fYGDzS4VTvQEXyOuMCUX3QQ==
X-Gm-Gg: ASbGncuCauX+6beXi8x1Tkghlqa7/6TDHrlRHDkUoW/wiG+4RwDh/jP8QKKc6/XyOWk
	+IF7J+riwR7XSMJ60vEpK0xv6QRDPzm9sjWxDJ1iQZeapZri2vxLQQodH6Uutq0CQEOZiB9bK0Q
	trjPRwhh/Ix5jB/XHBFEqJv4UloK0q7jzzq7rFnh5WI+BReTiBApddR3J5N07WoZA8cwW4oaRb/
	+Iww8zRd1Ue3zQMR0IDbMOOsY+45Jt2mZRHEwGdQNpkokhyv1R+iYsOpX6PSnW+V0nAA6FSIYLa
	qCy06us/rJVbAe/441a+yzOrfAmwCL2FpbxsQauoglyKw5IlKtBt6vYVxTKWX1eNXhxmEe7VVd/
	TreI=
X-Received: by 2002:a05:6000:26c2:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-4266e7beb57mr6225747f8f.23.1760082894465;
        Fri, 10 Oct 2025 00:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTTPZj7hzRMoj+OIEk2jkUAprMdCN7KGM1KZIMXJPUWlJSecGQKX1yuYPKejz1THVQLE0NVA==
X-Received: by 2002:a05:6000:26c2:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-4266e7beb57mr6225728f8f.23.1760082893829;
        Fri, 10 Oct 2025 00:54:53 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b9easm35213505e9.1.2025.10.10.00.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 00:54:53 -0700 (PDT)
Message-ID: <3577f7fd-429a-49c5-973b-38174a67be15@redhat.com>
Date: Fri, 10 Oct 2025 09:54:50 +0200
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
Cc: Zi Yan <ziy@nvidia.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, baolin.wang@linux.alibaba.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, usamaarif642@gmail.com,
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
 <7723a2c7-3750-44f7-9eb5-4ef64b64fbb8@redhat.com>
 <CALOAHbD_tRSyx1LXKfFrUriH6BcRS6Hw9N1=KddCJpgXH8vZug@mail.gmail.com>
 <96AE1C18-3833-4EB8-9145-202517331DF5@nvidia.com>
 <f743cfcd-2467-42c5-9a3c-3dceb6ff7aa8@redhat.com>
 <CALOAHbAY9sjG-M=nwWRdbp3_m2cx_YJCb7DToaXn-kHNV+A5Zg@mail.gmail.com>
 <129379f6-18c7-4d10-8241-8c6c5596d6d5@redhat.com>
 <CALOAHbD8ko104PEFHPYjvnhKL50XTtpbHL_ehTLCCwSX0HG3-A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <CALOAHbD8ko104PEFHPYjvnhKL50XTtpbHL_ehTLCCwSX0HG3-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.10.25 11:59, Yafang Shao wrote:
> On Thu, Oct 9, 2025 at 5:19 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.10.25 15:11, Yafang Shao wrote:
>>> On Wed, Oct 8, 2025 at 8:07 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 08.10.25 13:27, Zi Yan wrote:
>>>>> On 8 Oct 2025, at 5:04, Yafang Shao wrote:
>>>>>
>>>>>> On Wed, Oct 8, 2025 at 4:28 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>
>>>>>>> On 08.10.25 10:18, Yafang Shao wrote:
>>>>>>>> On Wed, Oct 8, 2025 at 4:08 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On 03.10.25 04:18, Alexei Starovoitov wrote:
>>>>>>>>>> On Mon, Sep 29, 2025 at 10:59 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
>>>>>>>>>>> +                                     enum tva_type type,
>>>>>>>>>>> +                                     unsigned long orders)
>>>>>>>>>>> +{
>>>>>>>>>>> +       thp_order_fn_t *bpf_hook_thp_get_order;
>>>>>>>>>>> +       int bpf_order;
>>>>>>>>>>> +
>>>>>>>>>>> +       /* No BPF program is attached */
>>>>>>>>>>> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
>>>>>>>>>>> +                     &transparent_hugepage_flags))
>>>>>>>>>>> +               return orders;
>>>>>>>>>>> +
>>>>>>>>>>> +       rcu_read_lock();
>>>>>>>>>>> +       bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
>>>>>>>>>>> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
>>>>>>>>>>> +               goto out;
>>>>>>>>>>> +
>>>>>>>>>>> +       bpf_order = bpf_hook_thp_get_order(vma, type, orders);
>>>>>>>>>>> +       orders &= BIT(bpf_order);
>>>>>>>>>>> +
>>>>>>>>>>> +out:
>>>>>>>>>>> +       rcu_read_unlock();
>>>>>>>>>>> +       return orders;
>>>>>>>>>>> +}
>>>>>>>>>>
>>>>>>>>>> I thought I explained it earlier.
>>>>>>>>>> Nack to a single global prog approach.
>>>>>>>>>
>>>>>>>>> I agree. We should have the option to either specify a policy globally,
>>>>>>>>> or more refined for cgroups/processes.
>>>>>>>>>
>>>>>>>>> It's an interesting question if a program would ever want to ship its
>>>>>>>>> own policy: I can see use cases for that.
>>>>>>>>>
>>>>>>>>> So I agree that we should make it more flexible right from the start.
>>>>>>>>
>>>>>>>> To achieve per-process granularity, the struct-ops must be embedded
>>>>>>>> within the mm_struct as follows:
>>>>>>>>
>>>>>>>> +#ifdef CONFIG_BPF_MM
>>>>>>>> +struct bpf_mm_ops {
>>>>>>>> +#ifdef CONFIG_BPF_THP
>>>>>>>> +       struct bpf_thp_ops bpf_thp;
>>>>>>>> +#endif
>>>>>>>> +};
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>>      /*
>>>>>>>>       * Opaque type representing current mm_struct flag state. Must be accessed via
>>>>>>>>       * mm_flags_xxx() helper functions.
>>>>>>>> @@ -1268,6 +1281,10 @@ struct mm_struct {
>>>>>>>>      #ifdef CONFIG_MM_ID
>>>>>>>>                     mm_id_t mm_id;
>>>>>>>>      #endif /* CONFIG_MM_ID */
>>>>>>>> +
>>>>>>>> +#ifdef CONFIG_BPF_MM
>>>>>>>> +               struct bpf_mm_ops bpf_mm;
>>>>>>>> +#endif
>>>>>>>>             } __randomize_layout;
>>>>>>>>
>>>>>>>> We should be aware that this will involve extensive changes in mm/.
>>>>>>>
>>>>>>> That's what we do on linux-mm :)
>>>>>>>
>>>>>>> It would be great to use Alexei's feedback/experience to come up with
>>>>>>> something that is flexible for various use cases.
>>>>>>
>>>>>> I'm still not entirely convinced that allowing individual processes or
>>>>>> cgroups to run independent progs is a valid use case. However, since
>>>>>> we have a consensus that this is the right direction, I will proceed
>>>>>> with this approach.
>>>>>>
>>>>>>>
>>>>>>> So I think this is likely the right direction.
>>>>>>>
>>>>>>> It would be great to evaluate which scenarios we could unlock with this
>>>>>>> (global vs. per-process vs. per-cgroup) approach, and how
>>>>>>> extensive/involved the changes will be.
>>>>>>
>>>>>> 1. Global Approach
>>>>>>       - Pros:
>>>>>>         Simple;
>>>>>>         Can manage different THP policies for different cgroups or processes.
>>>>>>      - Cons:
>>>>>>         Does not allow individual processes to run their own BPF programs.
>>>>>>
>>>>>> 2. Per-Process Approach
>>>>>>        - Pros:
>>>>>>          Enables each process to run its own BPF program.
>>>>>>        - Cons:
>>>>>>          Introduces significant complexity, as it requires handling the
>>>>>> BPF program's lifecycle (creation, destruction, inheritance) within
>>>>>> every mm_struct.
>>>>>>
>>>>>> 3. Per-Cgroup Approach
>>>>>>        - Pros:
>>>>>>           Allows individual cgroups to run their own BPF programs.
>>>>>>           Less complex than the per-process model, as it can leverage the
>>>>>> existing cgroup operations structure.
>>>>>>        - Cons:
>>>>>>           Creates a dependency on the cgroup subsystem.
>>>>>>           might not be easy to control at the per-process level.
>>>>>
>>>>> Another issue is that how and who to deal with hierarchical cgroup, where one
>>>>> cgroup is a parent of another. Should bpf program to do that or mm code
>>>>> to do that? I remember hierarchical cgroup is the main reason THP control
>>>>> at cgroup level is rejected. If we do per-cgroup bpf control, wouldn't we
>>>>> get the same rejection from cgroup folks?
>>>>
>>>> Valid point.
>>>>
>>>> I do wonder if that problem was already encountered elsewhere with bpf
>>>> and if there is already a solution.
>>>
>>> Our standard is to run only one instance of a BPF program type
>>> system-wide to avoid conflicts. For example, we can't have both
>>> systemd and a container runtime running bpf-thp simultaneously.
>>
>> Right, it's a good question how to combine policies, or "who wins".
> 
>  From my perspective, the ideal approach is to have one BPF-THP
> instance per mm_struct. This allows for separate managers in different
> domains, such as systemd managing BPF-THP for system processes and
> containerd for container processes, while ensuring that any single
> process is managed by only one BPF-THP.

I came to the same conclusion. At least it's a valid start.

Maybe we would later want a global fallback BPF-THP prog if none was 
enabled for a specific MM.

But I would expect to start with a per MM way of doing it, it gives you 
way more flexibility in the long run.

-- 
Cheers

David / dhildenb


