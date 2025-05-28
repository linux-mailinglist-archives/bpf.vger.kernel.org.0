Return-Path: <bpf+bounces-59194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8E8AC7241
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C27189DF55
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 20:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B75220F21;
	Wed, 28 May 2025 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIG1LPOz"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E298920FA90
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464370; cv=none; b=RiWV5nO/xmRuMXp06k+GgvSiDlaBY93CvMhNzVpYrvmkpxImSGZxhIcaH3T+O1+W+M0+Z85SasxPJ5nfVRrEZ8GJ5YSDi5I8Ej1Hx4BpURIWk9ahHfXGcxx5x5zOgGjZ8MJ4prxM0Vese6ZwSCnUB4KfSsBTJs14x18gbaunvuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464370; c=relaxed/simple;
	bh=YsCyAH4m5qjROeSr/20+OcPWi6CA6AqCUbeJis7qlvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gakXcbuF7h2VLP0gC67ADYIxTKTQ4kFXvOwj/FSBWJdDyv6KV5VMY7sVYR9I+qjaxujDKZNGMJwEfppkqH6xYRChXdG2K+ZNGXyulMhDT7SdjsoP3N2txTzToXjDqU/YANZi/3T5N6tUkH/nQIPfV8KYbnCB3+5D4/8Lp5Z13lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIG1LPOz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748464367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/YdKtSyBeWnzDbjExQo5+BS8gjd5hjr/5VcmpFwF0sg=;
	b=jIG1LPOz72HoMiWKQe/5MWFhIQYkg1OPYFSGKh1sPOgUEdzzKANuL6EQE/zrbrz5u7jzBj
	4YbMAlSZLjvPOpisUNrNowPldczaQqvmdZIFNn7+rcoiKzD84yJsQauwv0WQh4jWYRERfU
	l4VXklWcQfT3042Yfr1DoDzjf4qPcOY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-QSZ6g791Mcee9bWp3O8eWw-1; Wed, 28 May 2025 16:32:46 -0400
X-MC-Unique: QSZ6g791Mcee9bWp3O8eWw-1
X-Mimecast-MFC-AGG-ID: QSZ6g791Mcee9bWp3O8eWw_1748464365
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so161606f8f.3
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 13:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748464365; x=1749069165;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/YdKtSyBeWnzDbjExQo5+BS8gjd5hjr/5VcmpFwF0sg=;
        b=DgnEndAsLkGFRrSaO4jCxWknpbKfu5kXFMPChYwVcRHlfTaizM4dzCiSe04aD8epOE
         28JnqQcb56Sg5oPTn+Dgs+3pS6d40i8wrePGNECvTsN1KKT66XIZHPuiT3MoTkZBm4TM
         EFUY+7rLgl8GcgRzhS5MDRWWyXac8qv2ShT2Ia8A7jwUJo4voYnSSKdAeECdbBK2iTQ5
         l8JR0tTHz2+sm2Gx82tsDTnmf6+0wZumOLhbMpe1hoOqxWckXhNd0CxZbyb/+95xRHkx
         57aYkPq9XutmpNLhRvuhpqeoZZRMM6TpDAixAzIjUO9gEuMbvmuQmdLaZPIEDLbznLr2
         m5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVkXrRMglvE1UCyCZrxBpC8R8ccUQyVrTl9QpMo2q5E/LlqTsI966NdDAc80haOID0F4F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRvqsMtLHOB6i7lbAfiDYMsBt+zdBF0mb48707uyogGudjNKK2
	5xxTSwOaaOHHM/778iO6MYWW7mxlnqjVwc1AsFf776E1aq8yJrLQQrPHbEf6SFGLh1tpGIGaUbg
	JpQJiTVd8G/WsAFNIXJvJdOQSFKGnYtFofN5kVucETJHGH70hvIN1/w==
X-Gm-Gg: ASbGncsNQYrQSSknGvGFl8oZgqhfasHVpYDPZJklFF7YZ36Nev8HRYHFeqxtyVzkTOh
	19/kteCt5Bpm+63jO/JWA2LX5J34q3BETAi9WuUsJX8enh6UazaHj5DNhLpGcI9kvaoGE0TIpVb
	6V/K4POK1eHFGlcnv0MqUO7TBLt+YIL6DuWPgHWZDVXQKf4lY5XZ+1OhuqNhalsw3u7rqURYA9S
	koZLMhoyczIQhPLMMn7jDWT6DLagctvPuk91czhT3ION9UAno6SdO7OIAMOlWWWTNyl479lCs9b
	djp2DSiVv/NBYYS4Gh0LDhMPsCP43p+QCzs/GEzfjPQ8/7dHdWG57WP05ZyDREw55TYIA1KKXq4
	YMeTbb8f19155HYpu+ctXey3RQl2wHMvAbfNoRS4=
X-Received: by 2002:a05:6000:26d1:b0:3a4:bfda:1e9 with SMTP id ffacd0b85a97d-3a4cb489ab1mr15083992f8f.46.1748464365219;
        Wed, 28 May 2025 13:32:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvz77XKlzlFud1CtlVukgzIgVvU9kE1oLouTpzwra1V2w2tUii0khWsACMLSZPr7/VcR79Ug==
X-Received: by 2002:a05:6000:26d1:b0:3a4:bfda:1e9 with SMTP id ffacd0b85a97d-3a4cb489ab1mr15083969f8f.46.1748464364776;
        Wed, 28 May 2025 13:32:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36? (p200300d82f30ec008f7e58a4ebf06a36.dip0.t-ipconnect.de. [2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eac8a9aasm2439145f8f.51.2025.05.28.13.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 13:32:44 -0700 (PDT)
Message-ID: <4e0e2874-1dfb-428f-9bff-0a6e174399b7@redhat.com>
Date: Wed, 28 May 2025 22:32:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com,
 willy@infradead.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
 <7d8a9a5c-e0ef-4e36-9e1d-1ef8e853aed4@redhat.com>
 <CALOAHbB-KQ4+z-Lupv7RcxArfjX7qtWcrboMDdT4LdpoTXOMyw@mail.gmail.com>
 <c983ffa8-cd14-47d4-9430-b96acedd989c@redhat.com>
 <CALOAHbBjueZhwrzp81FP-7C7ntEp5Uzaz26o2s=ZukVSmidEOA@mail.gmail.com>
 <ada2fcc0-3915-40e7-8908-b4d73a2eb050@redhat.com>
 <CALOAHbB9kuZ_8XJbTw98VuNtSdeUT=m9PAfO0uxsf4WaC3LXrA@mail.gmail.com>
 <5f0aadb1-28a8-4be0-bad9-16b738840e57@redhat.com>
 <CALOAHbB-HtU9ERzxDaz8NoC4-BG5Lb7-dF0v16Bp2Ckr1M7JEw@mail.gmail.com>
 <5d48d0c3-89a3-44da-bc1a-9a4601f146a4@redhat.com>
 <CALOAHbBUK=oPihkG22Z7L92rHNw-fB=p8zSk+1NFmzBjBENmVg@mail.gmail.com>
 <aa7ea2f4-da94-4850-8225-0fb6e0e32767@redhat.com>
 <CALOAHbCRc=t9o7HGqxAHpgzKmt4xBYjwQ6zGWZXm2E-zu1SjHQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALOAHbCRc=t9o7HGqxAHpgzKmt4xBYjwQ6zGWZXm2E-zu1SjHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>> I mean, with THPs, there are no guarantees, ever :(
>>
>>> If that's the case, we should revisit RFC v1 [0],
>>> where we proposed rejecting THP allocations in certain scenarios for
>>> specific tasks.
>>
>> Hooking into actual page allocation during page faults (e.g., THP size,
>> khugepaged collapse decisions) is IMHO a much better application of ebpf
>> than setting a THP mode per process (or MM ... ) using epbf.
>>
>> So yes, you could drive the system in "always" mode and decide to not
>> allocate THPs during page faults / khugepaged for specific processes.
>>
>> IMHO that also does not contradict the VM_HUGEPAGE / VM_NOHUGEPAGE
>> default setting proposal: VM_HUGEPAGE could feed into the epbf program
>> as yet another parameter to make a decision.
> 
> That seems like a viable solution. Thank you for your help.

Good! And the required ebpf hooks would probably come in handy to write 
more advanced policies / allocation logic than just "give it THPs" vs. 
"don't give it THPs".

-- 
Cheers,

David / dhildenb


