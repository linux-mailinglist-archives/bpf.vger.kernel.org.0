Return-Path: <bpf+bounces-63856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C1EB0B6CC
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 17:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40F23ACCBF
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF9121019E;
	Sun, 20 Jul 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnTRP+Gk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9EE19CC28
	for <bpf@vger.kernel.org>; Sun, 20 Jul 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753027020; cv=none; b=XfG7woeStgiLIhXdcI6Q20MWEBFDKkQAQokukTaaP3NPuN7TsM+Y09oPD67gQBb8nF1QI2f86bBR9me7UpDseVNe6ZB76hPHqs/mn9Vu8U20etKw15t5yXF9C416QKpB70/POiOmZIJkqW63DfOOpKJi7m2B0V+9B8EVwe+rhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753027020; c=relaxed/simple;
	bh=jBjh17DqNsMKZwckttv/NZCt9n+KeRf0S3/RPbSCAvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fv4K0t5UGmO91RmETK9zMYzcYvWF9MxLqJHSNDjnB58K2+QRrY2i4WMFaQqEPC/E6fJFJ2XqO3bSh8z1y7ZjL6Asqc7uVLxTwqNBO4ZHKo3I05Ick6Qh+M545pj+nNKzE4uTD14vk2Hs68VuDfsm++XXap6gRpmrJyOfdO0QmY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnTRP+Gk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753027017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yho5m5l8s6A6mthnL9VNjm4YbqQYSTsJHldeh0ToMsw=;
	b=fnTRP+Gk2ggfHSLS/2Ubzz8CqaEM8UCF8xycZ9UkG+WtsFAxROckFFOA/U6wf1eenmBdtO
	jrkY8KHRJIlUxsK0gsISq4ID3R0XY7Ig40iKeUNCPweyg8C+YFodsey4b5FkOLydTRoajU
	ONZAXhtv86/2siC8pwF3YuEVy2BVZh8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-ELF-G_6QPWGrRuawgLAk_A-1; Sun, 20 Jul 2025 11:56:54 -0400
X-MC-Unique: ELF-G_6QPWGrRuawgLAk_A-1
X-Mimecast-MFC-AGG-ID: ELF-G_6QPWGrRuawgLAk_A_1753027014
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b61e53eea3so1288481f8f.0
        for <bpf@vger.kernel.org>; Sun, 20 Jul 2025 08:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753027013; x=1753631813;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yho5m5l8s6A6mthnL9VNjm4YbqQYSTsJHldeh0ToMsw=;
        b=v3d8dsZnOGk1YTeDMdqpA8V789ty6tXzcLPwuPm7Zvbr3YjcwlKJBUDicfnlavBDO6
         Wk1FD2Nu+EAO3dODOAjlHuSOQpqVf1LcDN1bCwGjNFFO10w97nAtFEGgr5t86jnNv+pR
         C/D6VtGPNN4LGA5aWyz/p58SNNVhXubuyBDfAnvHRRwyNinqcV5MUaQzr2Qq4yAj86SP
         IOyjtzLv1xdDkLjakO1moGxWF4nOu3Zj1DlrI6u9PWfWtNkypSUVJkLOSn/GhLKdyOP+
         H+u5PJiPtgSMHUVNQiigJ7r4jp0Q01clOpnApGm+S0rE1xF6wsxAxdB2cQ5L6Y70kEJe
         jrKw==
X-Forwarded-Encrypted: i=1; AJvYcCXn0/Sa0FBsRW5mVGp4uxKCfrvkBjWNwe43nB/ZoKcs8Ez582YOa46EvSLgbQwiYfov7AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP5WI8sUhTlz77K+nELTc2SbhL9YesI+cYgS16xEeTeMebbQeu
	ZyMJntWmqVWbwmyNqWvqLFv3W93VM2VGdc8DC+dNVK+hi8UXBCSPx/vpwDt3zif6jigrP8p4DQS
	/VlKrPlJJaHL+0CMJNDdImfMM+40uANa5ML+w7pEcDifrp91zguDWwg==
X-Gm-Gg: ASbGnctaWYbQmIvbSn/cl4g6hZCjuzOqxe4gChVpo6KdRyB1WoK9m3yjqn/k6dfoQpS
	AMe9Txc/jmV1ngO6W9U333cloYMCHJx43KSA38TujSXUeBd4ybfmbOXdjoWW0A38oeCAwZVXx66
	6uNPqoU90Zw6vKc540/NPNzW/L+Gz132SMSWaZJyQ6RUGuV3VsBC/xC9ltj4B7GqHSHONkqz/Rf
	gYhnMclEXAXJrvpls6vljkO/JF9F42yVCS6yxpGdLvS2EAmIdkrdxU81E0gCpXzI8G+XPa7WVRM
	9CHsfE0DHlApZL1cdVktii7XMcrkEeO6zDOs3lsCXtyXs/SW9L2yzY9E2BHZjPfJE34XRrpMgHs
	k2ck/q9ZbW3hfQFeO6j1JnqOxcHHlf993cEMpBO87YoaMUcW3drDYlyRJbJMXTHiH
X-Received: by 2002:a05:6000:2084:b0:3a5:1c3c:8d8d with SMTP id ffacd0b85a97d-3b60e53b9ebmr13319187f8f.55.1753027013550;
        Sun, 20 Jul 2025 08:56:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFqT/iI1j10m0T5k/++2TiqF/cUAc+LuE5qOBTEFPJdJIfLN4q5hvu/m9Jrtu6FTUWzr0/tw==
X-Received: by 2002:a05:6000:2084:b0:3a5:1c3c:8d8d with SMTP id ffacd0b85a97d-3b60e53b9ebmr13319163f8f.55.1753027013051;
        Sun, 20 Jul 2025 08:56:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2f:300:375b:35f9:1c34:328c? (p200300d82f2f0300375b35f91c34328c.dip0.t-ipconnect.de. [2003:d8:2f2f:300:375b:35f9:1c34:328c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48823sm7888927f8f.43.2025.07.20.08.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 08:56:52 -0700 (PDT)
Message-ID: <87a54cdb-1e13-4f6f-9603-14fb1210ae8a@redhat.com>
Date: Sun, 20 Jul 2025 17:56:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CALOAHbBoZpAartkb-HEwxJZ90Zgn+u6G4fCC0_Wq-shKqnb6iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>
>> We discussed this yesterday at a THP upstream meeting, and what we
>> should look into is:
>>
>> (1) Having a callback like
>>
>> unsigned int (*get_suggested_order)(.., bool in_pagefault);
> 
> This interface meets our needs precisely, enabling allocation orders
> of either 0 or 9 as required by our workloads.
> 
>>
>> Where we can provide some information about the fault (vma
>> size/flags/anon_name), and whether we are in the page fault (or in
>> khugepaged).
>>
>> Maybe we want a bitmap of orders to try (fallback), not sure yet.
>>
>> (2) Having some way to tag these callbacks as "this is absolutely
>> unstable for now and can be changed as we please.".
> 
> BPF has already helped us complete this, so we don’t need to implement
> this restriction.
> Note that all BPF kfuncs (including struct_ops) are currently unstable
> and may change in the future.
 > > Alexei, could you confirm this understanding?

Every MM person I talked to about this was like "as soon as it's 
actively used out there (e.g., a distro supports it), there is no way 
you can easily change these callbacks ever again - it will just silently 
become stable."

That is actually the biggest concern from the MM side: being stuck with 
an interface that was promised to be "unstable" but suddenly it's 
not-so-unstable anymore, and we have to support something that is very 
likely to be changed in the future.

Which guarantees do we have in the regard?

How can we make it clear to anybody using this specific interface that 
"if you depend on this being stable, you should learn how to read and 
you are to blame, not the MM people" ?

-- 
Cheers,

David / dhildenb


