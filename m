Return-Path: <bpf+bounces-58537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C219AABD3CD
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 11:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8049A16F4E6
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 09:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03D8268C69;
	Tue, 20 May 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU3IaP6y"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB93264F9D
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734267; cv=none; b=I1845MfbtcCx0GDkJNDQoYu9dq0jECNtpbhZ2X6Fz/fv4CZ4iu+lcQxlJNITLVTVApzmJTIomIVTbsY6vjlK+DWlGWo5H/hX4Yg5yRYe0OTx+i0lNObnPH6N6aOTPte8g4Av4dMlkc3FOztNN/b9Q7wPUe4GCG3nuysHUIEuR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734267; c=relaxed/simple;
	bh=X2ZfLV0JmdOpETHpw3XpeXImr+/cItCBIIcMhjlRask=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnWDPYH+O687hIWq4A0hgF9guEXJY6zkdmLk8mPvsTvm8IJdRswXFz3pLcVOvRaf3rc99lBA5hZGIV4EaQjTZHHMSolYfTm+S8bMxf5vEfLJaMKwU/kDaCZYFK1wYKHcS9b9XNhEe9iLLoUtb2BJwXyDsXbxxaLt5u/5AsBGT70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LU3IaP6y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747734264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MF0O54XTPLn73CadKHodysBQRgXUthp59bXhiVIvtIE=;
	b=LU3IaP6y//p1n6Dfgl6l+q7Fqtx/M+fnP3vH3bZ+3u87eb6Gxc4uygyMHA0333d6S35He7
	Rv0dIk5N8+6CgkGV8gmWL3qvvTZvjcTg7JzZGi25LzKjFcHM/czlUqxidDGOE4zVAP2hZv
	0U2Ls7aauMJuZ3SO6p9ohFBXIQV7rM0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-i075P_4iNnSVM6IKKbvv7A-1; Tue, 20 May 2025 05:44:22 -0400
X-MC-Unique: i075P_4iNnSVM6IKKbvv7A-1
X-Mimecast-MFC-AGG-ID: i075P_4iNnSVM6IKKbvv7A_1747734262
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a36416aef2so908671f8f.1
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 02:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747734261; x=1748339061;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MF0O54XTPLn73CadKHodysBQRgXUthp59bXhiVIvtIE=;
        b=inIWELR+4eUvc0TcTZP7TFRvBDXHR/0U8Ps+XvhtYFy9bgOyP9UR2GNp7OZCXCuZFi
         DT5oXqyAH5WGFeb3GQca3ClpUbPivZk1TrOIbbKqx4Raa5X5qkCCvkmDyE4eGScZGMJv
         B21M9lkm7FJh559zv4ERLhXUj8QDqX++xlfYTuBRRsP+jgLYKSlgGtsJrpCt71nLOq59
         JRp/NJFlrKeOAQR+EpXguS2gy15EtPpkNaQpVuqOS2k8/y8xp/5Kj1duSgUEgckxKtgG
         hcA4jRX5E3ivwVWLcxaV3Cfk46EHpc+38gtxATplie3l6A0PT58Ps1hOGFoxB3dcaUXm
         VYig==
X-Gm-Message-State: AOJu0Ywgw3uFVAG3lJTrFl3IrkGiRoG1R4+fbCS+x8bK4bGgBvrVajZp
	w1Kryrk8mXIattt/qMqrmyCbe7I/Zj3pWiwzoaLopNlpUq9B3ojju9NNf1McxVrHSHqs+Z99egi
	Hp4NSkzbjfDne0tqoeyAT5qweBYLLszwnNBlWM8cSVpnKS2lcfocOpQ==
X-Gm-Gg: ASbGncum9QGv1WD5xHUwhkfBS6PJfzCJ3knaYeyfDmH/CkJBJsu+oxCmcr/nakSkO03
	sxHt1X6swE1XhdQ3BXQ14ucLwtOmYvHqhcHkkn6dhRI1qERu/Gf5GcbUHCjHaF37WQGrfGl9hzS
	89/Qyp5aDZ5/Evk/vnXzkqsC4ziSol96gm+zJzGisoHf+A2lmCyFkbwthmtnlm21IMoT6IhUL1U
	8/k5BybBnsApMksAOYeg2kd9dkrvSGe5OmmE8jqezJlQEVyhJE/5gBU8uNt4cn08H6b2yQTVnQR
	9fCLZRAClXOVbDADTYXboaOsUvTjivQIRGP48AXPJg==
X-Received: by 2002:a05:6000:2503:b0:3a3:7336:fa63 with SMTP id ffacd0b85a97d-3a37336fbcemr4544369f8f.18.1747734261655;
        Tue, 20 May 2025 02:44:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOLqrmYgjGYS6caxm2cIOMUQjPjHncq5ruhRBXE+MuTSCpFvShGR2XYHemd9NXEfeQD1+fAw==
X-Received: by 2002:a05:6000:2503:b0:3a3:7336:fa63 with SMTP id ffacd0b85a97d-3a37336fbcemr4544339f8f.18.1747734261276;
        Tue, 20 May 2025 02:44:21 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0f448.dip0.t-ipconnect.de. [79.224.244.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8caaasm15564347f8f.83.2025.05.20.02.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:44:20 -0700 (PDT)
Message-ID: <746e8123-2332-41c8-851b-787cb8c144a1@redhat.com>
Date: Tue, 20 May 2025 11:43:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250520060504.20251-1-laoar.shao@gmail.com>
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
In-Reply-To: <20250520060504.20251-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Conclusion
> ----------
> 
> Introducing a new "bpf" mode for BPF-based per-task THP adjustments is the
> most effective solution for our requirements. This approach represents a
> small but meaningful step toward making THP truly usable—and manageable—in
> production environments.
A new "bpf" mode sounds way too special.

We currently have:

never -> never
madvise -> MADV_HUGEPAGE, except PR_SET_THP_DISABLE
always -> always, except PR_SET_THP_DISABLE and MADV_NOHUGEPAGE

Whatever new mode we add, it should honor PR_SET_THP_DISABLE + 
MADV_NOHUGEPAGE.

So, if we want another way to enable things, it would live between 
"never" and "madvise".

I'm wondering how we could make that generic: likely we want this new 
mechanism to *not* be triggerable by the process itself (madvise).

I am not convinced bpf is the answer here ...

-- 
Cheers,

David / dhildenb


