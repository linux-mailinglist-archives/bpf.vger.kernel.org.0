Return-Path: <bpf+bounces-70802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2816CBD3061
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 14:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61BD74E3C3C
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B551E21C19D;
	Mon, 13 Oct 2025 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSi/Sinh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B355B262FCB
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359328; cv=none; b=ktv5Gv1KpGMgUdABqP5Zg0YsEx8QudTJXk7cisB++uYNi5UkOi/StOIEW+QYnzIoK2n1J5n1760FVcaeb9sMHdQ1wBywi+HbBRsmdhzbyb8LMsJWJ7TrrYw68t9kdpWU5oEk8nMQatw1E1iWtv6iHUplLk26CyqCrH1Pqt2gGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359328; c=relaxed/simple;
	bh=UtC3ud1uDkWBT2eatRa4V31cwvWr8x1KM9nA7kHeLro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMWQcpGfDzrTs62AQ0w9vy7SGMQ/xkPmn2pLoCisnZy3ZaGsDPEIReOINfqpYdap4lJkot//IMeishigBdLODmm6TtEFfkJzQMwpx4zTpET5qjqzK8Spu7WJ/01QhVanESP4pH7eOuoL5PoAHq001hVR+91sEwHBrlxG8JJa2wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSi/Sinh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760359325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GV6V42eNmRofCKO2ajQk2DVZzbVn5SWQi1G7vlqlVt0=;
	b=fSi/Sinh1FxlFchbwfTnXvKg5q7TU78HtIIstJVntj1KfHMDc7Gan/EtfIsUSFskJ+8MCz
	q/1ybPh/Quox0qWr/1zbrNvJjenzFKI44/O+GIea8Tz4lSvZstJsq1JLnsNYM1T3EChX50
	pTHNv/Ao+/DCK69pBfn8ETpsk8NO7nE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-gxJTbvN5PK-n0sz2LozsRg-1; Mon, 13 Oct 2025 08:42:04 -0400
X-MC-Unique: gxJTbvN5PK-n0sz2LozsRg-1
X-Mimecast-MFC-AGG-ID: gxJTbvN5PK-n0sz2LozsRg_1760359323
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e7a2c3773so21880275e9.0
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 05:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760359323; x=1760964123;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GV6V42eNmRofCKO2ajQk2DVZzbVn5SWQi1G7vlqlVt0=;
        b=ZsBSAXDD9IfFXIOhsALw2e0qydnAJMTnAuo+FafIoicpoEz6wSk1vVhGrhzOp4s2+c
         Ky/zinLhxHkiFBXUlYDdOuL5a3SwTvkLrF2SX6r846CBkM7NzIWC5hDMVQIGNr8cXpOV
         VZuXUEElgPQRb5dIvGzyQlvtqS7zjHndYdusWJeLzqBwyBsnkAhdPsI64nELoBC7lcEV
         DgSeo1Kza0opp434Y4tLgSWHh8E3QjHL/WTNlNhWoSsdcTgKLTL7TWEOE7S0D0OKjVLJ
         b3KV+RqyUhHZMldbzIeE0C/t/D/vf1iy6MmuTpfnTgatiuXJZHSQ43MDSYfnu/Pgi/ap
         R3kA==
X-Forwarded-Encrypted: i=1; AJvYcCV/AcT0gohfHwuqpcXQsk87A5tNXlj/O/ubQgRERvi3sIrOfdNmJjN3fTPtgWW4I2dGlsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTL1f5Da+YYnTbFmo3MJ60uUOq4u206skxUfhJ+AIX1u49Z8p
	vuWHlCNl/HdGEh7zM6hyH4B+eKYAmZofMARN+T1sDZT/VjwXH3hr/h5xbeLsEvMJ8m0FFrTHaf6
	TocxZ+56cu2E/DUYDVt3Wv5xiQoA4XAl2le1XutCIO424uzhNSRHtsg==
X-Gm-Gg: ASbGnctosIaQ2Bs10P0wmGg5nijlArOQnmd49aTzvZTSx9udwdIL1o5Wz0U1G350IpF
	Xw+XuxpXUPGYbSGURYHEzuWZ8a4UHVoJVe1yPvvLZrnam5fLAW7AgKAvm21Gi+LF6Wqlct1QDWb
	jLMY/onbQLwqxJ4NSeDU45D2b1bjvyBcSfrmDEUUA6StGFZpgEcsf9VpM2OXVwOQioijVuiOtNK
	WWuvIFSqKqc2Ip/aod9qYE7B3eO8ddH8C+mtXaoTbc6JtsgWC7FczQ9B4wvv49zVHR13ftJmAFI
	L8j+ztyc/lghn7TKa9mvVxdyv/cvGlE0X0biJv8UYeVXGC3oWhRMgudlFPMsjxYnLR8SVYuRl4q
	qg1E=
X-Received: by 2002:a05:600c:674a:b0:45c:b6d3:a11d with SMTP id 5b1f17b1804b1-46fa9e8dc8bmr158955185e9.1.1760359323085;
        Mon, 13 Oct 2025 05:42:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHauSt6ruiV5Kk8L/+gHwRrp8105EYALDJNBUwgBgUbnyLWlMo37UXqi0DKsbi3Tl2D4kwzpA==
X-Received: by 2002:a05:600c:674a:b0:45c:b6d3:a11d with SMTP id 5b1f17b1804b1-46fa9e8dc8bmr158954865e9.1.1760359322699;
        Mon, 13 Oct 2025 05:42:02 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc78559c8sm29186175e9.4.2025.10.13.05.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 05:42:02 -0700 (PDT)
Message-ID: <7176597b-006f-40ad-9421-860d80d7e696@redhat.com>
Date: Mon, 13 Oct 2025 14:41:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Yafang Shao <laoar.shao@gmail.com>, Tejun Heo <tj@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>
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
 lance.yang@linux.dev, Randy Dunlap <rdunlap@infradead.org>,
 bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
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
 <3577f7fd-429a-49c5-973b-38174a67be15@redhat.com>
 <CALOAHbAeS2HzQN96UZNOCuME098=GvXBUh1P4UwUJr0U-bB5EQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CALOAHbAeS2HzQN96UZNOCuME098=GvXBUh1P4UwUJr0U-bB5EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I came to the same conclusion. At least it's a valid start.
>>
>> Maybe we would later want a global fallback BPF-THP prog if none was
>> enabled for a specific MM.
> 
> good idea. We can fallback to the global model when attaching pid 1.
> 
>>
>> But I would expect to start with a per MM way of doing it, it gives you
>> way more flexibility in the long run.
> 
> THP, such as shmem and file-backed THP, are shareable across multiple
> processes and cgroups. If we allow different BPF-THP policies to be
> applied to these shared resources, it could lead to policy
> inconsistencies.

Sure, but nothing new about that (e.g., VM_HUGEPAGE, VM_NOHUGEPAGE, 
PR_GET_THP_DISABLE).

I'd expect that we focus on anon THP as the first step either way.

Skimming over this series, anon memory seems to be the main focus.

> This would ultimately recreate a long-standing issue
> in memcg, which still lacks a robust solution for this problem [0].
> 
> This suggests that applying SCOPED policies to SHAREABLE memory may be
> fundamentally flawed ;-)

Yeah, shared memory is usually more tricky: see mempolicy handling for 
shmem. There, the policy is much rather glued to a file than to a process.

-- 
Cheers

David / dhildenb


