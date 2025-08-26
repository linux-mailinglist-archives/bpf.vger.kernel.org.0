Return-Path: <bpf+bounces-66534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A43B35965
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 11:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2536850EC
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6A531984D;
	Tue, 26 Aug 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym6c7DAW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E52D7381;
	Tue, 26 Aug 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201934; cv=none; b=oaXipAAoVxKI4oasBwfv7vG6p/zrDkrfjUomDCq3jFBHPt3GDX5nbA6SxmcKDrSC6vN0rmIicTnSI0vP+gGe3TGUQRu/d/kJf5dFMcwl0WW36yQTR5gP3PkGBLNAHTB6d35k4ZR7EiEzJ/iUshFMYLVlLpV24necdy+8PI391H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201934; c=relaxed/simple;
	bh=J7ysEHKiuU/GAQAt+B/FI8bS5mPb7RX8rn+Pv2ExXvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pa2VnsHr58ZXxxPPACtuWtjCyQMBcwOi00DJhJgKayP+AZvQQ9cEE1zpPaNrWIANe3FHK69yzjEk1Eqeo243qdq1kav06H4ITl3HM+iddpWLjf5Uu1oaDzE7cR02+fxc1W6EGbAyv1nj0qMyBkSWjmYLT+6Lflvl/VRmdx+pulI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym6c7DAW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso31339975e9.3;
        Tue, 26 Aug 2025 02:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756201931; x=1756806731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zINnuaBM5jY+LnKv0RHMN8aDv06gHxZMWVC8kSjaf9s=;
        b=Ym6c7DAWkKVEyolr0ltgrGky3Dp9VehP1bJYUH2C/vbvrhthMvfeu51Nn9U4+yLE+W
         7NwdWdW9+5DbOBMuFCKKfgyn73BlidKBuSUCFwbNkaBUuKgXVIo9TEBGZq/I5t2mBiSp
         Hd4ORIZF7z1OvrnLaDmrUb4/cfui+7X3ouBsFJQdOUOilgXMLW/X6TA+eNcp0yDNRmry
         vXGSzmjCC+M1h3UZneCuyqVE8K7rWnXtKAwFSx2AS1yVOzYTNiU+1iowQXQHFoQurxzB
         abOy9ztCgDDmvz+smWRZrLrR87wgH1SMxdJQfxK8g22IpwvTrnljei5DoYJF332/MBpR
         yanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756201931; x=1756806731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zINnuaBM5jY+LnKv0RHMN8aDv06gHxZMWVC8kSjaf9s=;
        b=SpaScWFw2Hry9V2voOAE3n0X4dinLOLuJWI6+VKU1AgkTRgaEgfxKfkw3O/JYuBEW3
         /u4PlBlmActXzJMkjH+U2vEP/vzveoO97nxlSPMb5A3m2fhgIlZHaBeC0eb8tP9VNKUi
         Xu7ZLFutUpDFucJlUlDAqFtwkh3Ru2/4w1OD9zbE4tBirQEsMXT4cD1NOzDaLDPmJftT
         eQ7u/QhKZvsEO3DRGKek+RpPdIUn2fKb4urV6rBelblYk3qj3tXFopoIt2bzh+67CSjm
         uOWll35Qlzih853W3MmOi8IAPkFBz1UQDZtGtc2risAR6OA9zTZEw188sWTdY3PvZDxi
         kN4w==
X-Forwarded-Encrypted: i=1; AJvYcCXy33lylwGbwr0NaxRS/4119zCKti8blrYgRYs60fi7Yr+evd91rtcnkMP9SKY8Lt8viV0DWZNjk+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxuy2Ixh14SCpmpILbvdOVAL3hsVrWTdMaluS0hDpaOnvGYPk
	MaQ3DsgRAC/xs51CDhcT5nGICeLaEj/hxxgNYJ4s0wye8nKABwzUj6kJ
X-Gm-Gg: ASbGncvURqlBz2fIAho2R29OlXSl36LFRhQwxpDokEGZ16nklr7X3HNwzx6eIKRQwyy
	jBcMaNBgQRDHXzNuRgBLAkxTLN1iBL6Cq9P2oqpRrkOWZIhIJacVAngY9KRmvz+KebOzf1w/0pR
	jBJtUMZwqYq4fdCcgKXhGgiDiT5MU/HjhnWo4JZ55n2ehYiDG6i1pnKWNK8BFXxh6Ef7aIjNvM5
	XFjwvpSzNChPTD3FyYSjpiKMe66R+zReCOsaLEwr1G4ZZVsugwMnIA4xRAS0kWTTiGUnvcHw8QA
	TqQNoITvmfaS5qsMCpGcc+1HbipF46LjGhaaRmPZYUsfupGewEt7PMPbuTFAXkg242Iid7iDCc+
	nPhyVO2Zv4mX7/EU0RogRU2N6XV9RXUhlP3oTpoDBPlFjw0lskcL+3FOv5lei4GKfhypvOw4=
X-Google-Smtp-Source: AGHT+IFKQdWy6VOJNLDLaTKqGDmbcvShGmfha1Y5OVvRHw7Jd/2Y6z+QukXL8SXmZ752TF56eRlH0Q==
X-Received: by 2002:a05:6000:188d:b0:3ca:c607:ad8a with SMTP id ffacd0b85a97d-3cac607b234mr2794959f8f.57.1756201930397;
        Tue, 26 Aug 2025 02:52:10 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::6:c6e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57444b3asm146358405e9.4.2025.08.26.02.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:52:09 -0700 (PDT)
Message-ID: <ed4fc853-97ce-47b3-be80-4de9627c3276@gmail.com>
Date: Tue, 26 Aug 2025 10:52:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 mm-new 00/10] mm, bpf: BPF based THP order selection
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Yafang Shao <laoar.shao@gmail.com>,
 akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com,
 rientjes@google.com, corbet@lwn.net
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <d8f723c4-4cb0-431d-9df2-ba4ec74c7b43@redhat.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <d8f723c4-4cb0-431d-9df2-ba4ec74c7b43@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/08/2025 08:42, David Hildenbrand wrote:
> On 26.08.25 09:19, Yafang Shao wrote:
>> Background
>> ==========
>>
>> Our production servers consistently configure THP to "never" due to
>> historical incidents caused by its behavior. Key issues include:
>> - Increased Memory Consumption
>>    THP significantly raises overall memory usage, reducing available memory
>>    for workloads.
>>
>> - Latency Spikes
>>    Random latency spikes occur due to frequent memory compaction triggered
>>    by THP.
>>
>> - Lack of Fine-Grained Control
>>    THP tuning is globally configured, making it unsuitable for containerized
>>    environments. When multiple workloads share a host, enabling THP without
>>    per-workload control leads to unpredictable behavior.
>>
>> Due to these issues, administrators avoid switching to madvise or always
>> modes—unless per-workload THP control is implemented.
>>
>> To address this, we propose BPF-based THP policy for flexible adjustment.
>> Additionally, as David mentioned [0], this mechanism can also serve as a
>> policy prototyping tool (test policies via BPF before upstreaming them).
> 
> There is a lot going on and most reviewers (including me) are fairly busy right now, so getting more detailed review could take a while.
> 
> This topic sounds like a good candidate for the bi-weekly MM alignment session.
> 
> Would you be interested in presenting the current bpf interface, how to use it,  drawbacks, todos, ... in that forum?
> 

Could I get an invite please? Thanks!

Usama

> David Rientjes, who organizes this meeting, is already on Cc.
> 


