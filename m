Return-Path: <bpf+bounces-58580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3340ABDE0D
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 17:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0793A9F92
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C052517B5;
	Tue, 20 May 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIndQ5LK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7C24677D
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753217; cv=none; b=Wyt5MXU97gPkfee1qnOW/ArK3fkaIHH6VHCCnwkWOawsMKCxphJtAB2O18EDUQrM95fYgnb7Gl/8e1wgck/9qQfsQMP/tkSzx2R+U9pBqv4FCSKTUy6gTEsfbnZfsbG9CLNaDsheZtUAX60uwqIxZEkFOBG8CT8GAd4McuQX1as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753217; c=relaxed/simple;
	bh=N03cSfvpE6Ti8vz2eztDN+QQToULLQ3LokMh/Q0mvjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXReCMk4CozKwdXN7LXbpDF1bR6ippXmrJfneFPYOyhyDBcgD1z98b2pWftOKa5Mk6fmcEVsdbE9eccVp67CuTR3t+k8jg/MC2679e/e5KB1TxX/LJxsYgjAzb3y8Q3G/BHda3s1cQFUMxU4RtozzUWAbQ0cK34B8pgXlxZb4r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QIndQ5LK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747753212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i2s5zJn6VDiqf+Oamn2t1mC0KNMDw8+pdHeLY6X/rWw=;
	b=QIndQ5LKSxhtOGx48O2gQZXPzDkTe1G5xRDCu1LiYnCBOt+m9vX2Mo6YBDEotqU4tfY6g2
	nDCmcrQY2P8yUAPP0AcnoIOj9upNshMvXX/SK9fVDz5ayWgOeDqqKeNtkaoutcy+jVmuWR
	rxXn4Xe0yn4VzF6hoxwcyB7xxfKu+IE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-j0vRMEbuPESsobE35IeWFA-1; Tue, 20 May 2025 11:00:09 -0400
X-MC-Unique: j0vRMEbuPESsobE35IeWFA-1
X-Mimecast-MFC-AGG-ID: j0vRMEbuPESsobE35IeWFA_1747753207
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so41044075e9.2
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 08:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753207; x=1748358007;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i2s5zJn6VDiqf+Oamn2t1mC0KNMDw8+pdHeLY6X/rWw=;
        b=kW+kdWyKcjM9Sbt+Vapo/GZC44RA3UTADOqGSph/6ZBInZBYST4TneOK5Lfm+bOdxy
         DedpSM0xVM7oapzz8x8IIm6MzD5CE7jZXmGww2pFk/RA05nM8EK8UwrTJpClLMnHhite
         YCTJktsRWGNZ9nnaEg6jGF+RPGgOoOXvQQu3+S4cYBNvmAGiSixwvgMTdoo7fGhO2Dp0
         6/0Uqa7XfIqISZ3nr2TzBWkulR19ZgEt7jlvpl/YYFsUzEqkPm4sDJ5TTo0NUPhFA484
         XtmMOkxn4jdbLSUMSc0pSR5veAUbwWdjV8obFxx4KSgJS/e/OpKxmP0pHbQ96WIkLMF1
         XheQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4ReKp18Ou8rQiOirelZQXZicY0ARpa1aQflGhMUtG8AdTKw9x2VsNSQ2Uffa50gKrepY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8Eg1dhtRurrOJkbvlLvEC7/VkcJRJedtChRpt4tUiEKCXiaj
	kecpkm1FoM5zH9fmZ4CCG1NzqahgKi5I7ur9oDJlOHhbRxh9Cn9EfGTdvacWxbY12BLAup4jewX
	9fL4b13Au9yDcSZX5xyHICPencPFfshPKYchmgxn6w+KdIf75KUFY1A==
X-Gm-Gg: ASbGnctWxxGaSwVCoOQHmILJC4JISeC+XYP1nULoaAli4/K0/OcugnonaoLF3W1vHdg
	Nzzgfy8+h/2yKHJWVNkLB4Sm5+j3GEDvj7FyDJzkg7FR6I712zrDv9S9Zn7hikZ3sUhxdD/0qmV
	1E53mVf+eAEJJ67Mu6eXgklSve13gqo3trDBXll+Z1odXG2G2oBKTUkHQ5TsDFoIy2unfLTX73/
	iqcABjcu4CA9WJ5NEOfP9y46jJtLy0UGjBPLCiPCbWvgcOhuaUwTEJSt7vSDMnx3yb/qfn3RroG
	BKoJdusVhDP2KBVIBWAaa3xllm9aL6W7WMGf5c94bQmYkR8ysXb7bMuNc7WxVOXf3nHad+0GFPM
	a6o6GZArmubKwswqwb71Ko9sggyFI36jrHKZ5uAI=
X-Received: by 2002:a05:600c:34d4:b0:442:e0e0:250 with SMTP id 5b1f17b1804b1-442fd67200emr158111135e9.29.1747753207161;
        Tue, 20 May 2025 08:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQDqxiGKA4tkeiSH2PDNWUB5/u9yZfVoEssPnM5TVx5ileUuEXFfJoIauzZIlle9PhXQ+k0g==
X-Received: by 2002:a05:600c:34d4:b0:442:e0e0:250 with SMTP id 5b1f17b1804b1-442fd67200emr158110825e9.29.1747753206705;
        Tue, 20 May 2025 08:00:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84? (p200300d82f287c00a95eac49f2adab84.dip0.t-ipconnect.de. [2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78b2f19sm33137685e9.32.2025.05.20.08.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:00:06 -0700 (PDT)
Message-ID: <f3bd0607-ca42-444c-81a3-2e052eb8f14c@redhat.com>
Date: Tue, 20 May 2025 17:00:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Usama Arif <usamaarif642@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yafang Shao <laoar.shao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Nico Pache <npache@redhat.com>,
 akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CAA1CXcD=P8tBASK1X=+2=+_RANi062X8QMsi632MjPh=dkuD9Q@mail.gmail.com>
 <CALOAHbDbcdBZb_4mCpr4S81t8EBtDeSQ2OVSOH6qLNC-iYMa4A@mail.gmail.com>
 <aCx_Ngyjl3oOwJKG@casper.infradead.org>
 <CALOAHbDUmad6nHnW755P8VYf+Pk=DogW0gMH4G73TwvKodW54A@mail.gmail.com>
 <2345b8b9-b084-4661-8b55-61fd7fc7de57@lucifer.local>
 <82f7bca5-384f-41e5-a0fc-0e1e8e260607@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <82f7bca5-384f-41e5-a0fc-0e1e8e260607@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.05.25 16:32, Usama Arif wrote:
> 
> 
> On 20/05/2025 15:22, Lorenzo Stoakes wrote:
>> On Tue, May 20, 2025 at 10:08:03PM +0800, Yafang Shao wrote:
>>> On Tue, May 20, 2025 at 9:10 PM Matthew Wilcox <willy@infradead.org> wrote:
>>>>
>>>> On Tue, May 20, 2025 at 03:25:07PM +0800, Yafang Shao wrote:
>>>>> The challenge we face is that our system administration team doesn't
>>>>> permit enabling THP globally in production by setting it to "madvise"
>>>>> or "always". As a result, we can only experiment with your feature on
>>>>> our test servers at this stage.
>>>>
>>>> That's a you problem.
>>>
>>> perhaps.
>>>
>>>> You need to figure out how to influence your
>>>> sysadmin team to change their mind; whether it's by talking to their
>>>> superiors or persuading them directly.
>>>
>>> I believe that "practicing" matters more than "talking" or "persuading".
>>> I’m surprised your suggestion relies on "talking" ;-)
>>> If I understand correctly, we all agree that "talk is cheap", right?
>>>
>>>> It's not a justification for why
>>>> upstream should take this patch.
>>>
>>> I believe Johannes has clearly explained the challenges the community
>>> is currently facing [0].
>>>
>>> [0]. https://lore.kernel.org/linux-mm/20250430174521.GC2020@cmpxchg.org/
>>
>> (Sorry to interject on your conversation, but :)
>>
>> I don't think anybody denies we have issues in configuring this stuff
>> sensibly. A global-only control isn't going to cut it in the real world it
>> seems.
>>
>> To me as you say yourself, definining the ABI/API here is what really matters,
>> and we're right now inundated with several series all at once (you wait for one
>> bus then 3 come at once... :).
>>
>> So this I think, should be the question.
>>
>> I like the idea of just exposing something like madvise(), which is something
>> we're going to maintain indefinitely.
>>
>> Though any such exposure would in my view would need to be opt-in i.e. have a
>> list of MADV_... options that are accepted, as we'd need to very cautiously
>> determine which are safe from this context.
>>
>> Of course then this leads to the whole thing (and I really know very little
>> about BPF internals - obviously happy to understand more) of whether we can just
>> use the madvise() code direct or what locking we can do or how all that works.
>>
>> At any rate, a custom thing that is specific as 'switch mode for mTHP pages of
>> size X to Y' is just something I'd rather us not tie ourselves to.
>>
>>>
>>>
>>> --
>>> Regards
>>>
>>> Yafang
>>
>> What do you think re: bpf vs. something like my proposed process_madvise()
>> extensions or Usama's proposed prctl()?
>>
>> Simpler, but really just using madvise functionality and having a means of
>> defaulting across fork/exec (notwithstanding Jann's concerns in this area).
> 
> Unfortunately I think the issue is that neither prctl or process_madvise would work
> for Yafangs usecase? Its usecase 3 mentioned in [1], i.e.
> global system policy=never, process wants "madvise" policy for itself.

If the global system policy would be "madvise", you'd need a way to just 
disable it for processes where you wouldn't ever want them.

-- 
Cheers,

David / dhildenb


