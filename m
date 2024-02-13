Return-Path: <bpf+bounces-21839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DDC852DFB
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 11:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFA2282C20
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 10:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9002822636;
	Tue, 13 Feb 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmmNzIWJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327522630
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820540; cv=none; b=pdB9RIvBXgTnX5TcIcYh2BfR/cixvNqd/WEtcp7/nSe6Qie9VmqfZmCCxxmDmX3+dxl06PjzWvgAaUJLjoFKZ31H0nGK3n8Vmug+iG3kkxDWKtcvt+n3EDo+MMskzQbIWPY0XjBSYNowRESyeI0O6v2CpKPLJFweJzz98cUR7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820540; c=relaxed/simple;
	bh=lOHYbQBrB2CsXB+FhbkZrKyE8qxPerKPfslIYM60v6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBb/ocENXKI/wfxOyYZ+zGU9wd6NZNdF/5pNIFYkoaEgFLzB9da4rC8ltkisl2Sr7hjDjqQA9pABVmkIV+mMgA+GXf8CYj+2IE+fcHEBmoI8YAFiy2vHdV166rWohxVF4yhz30I3XaPcHFIuOP3lKYxR3m6dJCqbLkojBNTfcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmmNzIWJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707820537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=94CGc8C3RNCzA4ug/rXnYY/4jow0sgtDYF5aBFbKpTI=;
	b=PmmNzIWJy0ccvrPWR7zFIAodTCBBNyxDJoCKkfgb60z7js19l0fJ5NROOJLk3tvoTNsKqV
	Vc0A/+qylVTcbHvn2QNHTZM+HNUCpC/fy82Uji48+iJlHp7LPcCmG96nUsGWylU/1a9H3+
	hCVFC5ELlbDu11XuCJQb6gcgghi/Ykk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-czWDbAO4NSOqvPbp1UFDVA-1; Tue, 13 Feb 2024 05:35:34 -0500
X-MC-Unique: czWDbAO4NSOqvPbp1UFDVA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-410e6b59df4so8295935e9.3
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 02:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707820534; x=1708425334;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94CGc8C3RNCzA4ug/rXnYY/4jow0sgtDYF5aBFbKpTI=;
        b=ClXl2B0Bs/KzvSwMRm40b55lWLH1aqS9Hrf2RA/ec3VMtVcWRF0BjphX5yPZ0P0UN2
         +M24+qw21nebwslndmepc9E/Yt2ggNXc0Yh20wwESKUSkW2VcdJYnu3K8GlpCqkdBL0u
         YHaGkpZjU1fulTXPSyS+t4/2zG6btkeSaAc1eta+jPdZ4TYdZjmEp72LjwHFMyv6iimw
         ay5/0eSeGt36bq+/p+/FSWPPRbJO8H+A+NulPhxaL8PoJwEMriSelt06JtLLAzlruOYX
         xIxsaAdwMMxbTdJt/xxHfs74Jo2Xr2qIqwMpbInpFpjP8dZrzWevOFJ4sN11pHMtERap
         n1/w==
X-Gm-Message-State: AOJu0YxJbBZm7FJAe/OxRoGcWnrqb/Po9dHBjyQKQ1YEz2Xmtv52koIm
	wlZVtsXuO/gcsqj5F6c5TVOULozl2dDtkjbr7Sr7dgqm9PM+yA4bTxyon19zsW9esnhW4Wwiy+j
	3hxdG5zel8tQ66irS23CFhBA0De/03dHf+oQRJ/rp66FOosDY88K0Zj/t3g==
X-Received: by 2002:a05:600c:4511:b0:411:ba7c:99a with SMTP id t17-20020a05600c451100b00411ba7c099amr1352726wmo.38.1707820533848;
        Tue, 13 Feb 2024 02:35:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOb4xGg8BDbhQhdZjBonzE6AA2wjuToT9maNwG+fikcue/KzhD3xECDzmAAPD/n4kvmWvrvQ==
X-Received: by 2002:a05:600c:4511:b0:411:ba7c:99a with SMTP id t17-20020a05600c451100b00411ba7c099amr1352700wmo.38.1707820533409;
        Tue, 13 Feb 2024 02:35:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSdlXAfsEbXg/YKO8HftPVCIQNei+OyqhGipL1RyHZZNQredG1PZdGrAvHppPuntrmYcHDKyU2cAc3VmzrxgMzdySGyncRdhAoiNm1c0idHUAzeXYv05FqcTG50f6ZwjUzAG6CsM8EeArB5Movyj4e9geD6SXuEQtUm/J7IcBoHJF470J/9KQ/4RVJSXNx10M98vPZTp0xd2aj+5A1c5GQoWjyh8rgIM1bOXFTq+ZCij/GKBpBZb7ieJKkKyLd+IuzwqDVkVPxliEC84prnTAeeJFOnAdb0/8xAYx8h214SeMSys2lZHyD2PhNSFtATDc/rIhYmtPUEwAagHWzxDKnG9iUoTOsQqayEDtOdTtoJ2MlmLMcYqat1D2oMXX6AjRkmmhJS+8SnU82QJM=
Received: from ?IPV6:2003:cb:c70a:4d00:b968:9e7a:af8b:adf7? (p200300cbc70a4d00b9689e7aaf8badf7.dip0.t-ipconnect.de. [2003:cb:c70a:4d00:b968:9e7a:af8b:adf7])
        by smtp.gmail.com with ESMTPSA id bp9-20020a5d5a89000000b0033b4796641asm9321521wrb.22.2024.02.13.02.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 02:35:32 -0800 (PST)
Message-ID: <1a290655-f8ab-41b6-8c44-377a44847c5d@redhat.com>
Date: Tue, 13 Feb 2024 11:35:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 00/20] bpf: Introduce BPF arena.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>,
 Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <8dd6d3c0-6b76-480c-8fba-3b0e50fd9040@redhat.com>
 <CAADnVQ+nQuD1mNfe0ihX2fjAEGfBVtT=U+_ek8yD-uW=0GKbHA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAADnVQ+nQuD1mNfe0ihX2fjAEGfBVtT=U+_ek8yD-uW=0GKbHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.02.24 19:14, Alexei Starovoitov wrote:
> On Mon, Feb 12, 2024 at 6:14 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> How easy is this to access+use by unprivileged userspace?
> 
> not possible. bpf arena requires cap_bpf + cap_perfmon.
> 
>> arena_vm_fault() seems to allocate new pages simply via
>> alloc_page(GFP_KERNEL | __GFP_ZERO); No memory accounting, mlock limit
>> checks etc.
> 
> Right. That's a bug. As Kumar commented on the patch 5 that it needs to
> move to memcg accounting the way we do for all other maps.
> It will be very similar to bpf_map_kmalloc_node().
> 

Great, thanks!

-- 
Cheers,

David / dhildenb


