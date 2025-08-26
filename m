Return-Path: <bpf+bounces-66522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D38CAB355EA
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48E91B653E0
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F502F39D7;
	Tue, 26 Aug 2025 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iM/ajq/g"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5940F21B9CD
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194160; cv=none; b=mgEWWLnQA80AEmTR6wGUIQ7xV1pO13DpqQuF/y9O1aOWs25HtwjkjfZ1RkDPAkHrubhInG3Gb2JK3Vw7AQ7VcvcSIKdlAnElfE+E+1jarmjCLVst8Fzzgk08B8EZvA5b2h2fRsTBlrlbGpKenbiMdBxSf8g9KZaIKsNYeENcNS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194160; c=relaxed/simple;
	bh=fOpNnm9TPDvkBhb5WU5Fcf0z+ahPPe3KFXcJMRobyW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaTF4pKGAobNsp5MGk9p4WVLq6VM9IuDEUy7kJ6Swc8SvCrG+64gp1xlL7+/J3EUbwe06v3SyjbRn3dS3gFW0ul5fwPN1lCEZ9dNwJbC9wBcX8VKS4v1Z8RfCkXjTQ9I8SrKa9gefC4pNHwJlC5Lkl/rIdCzdBxmu1nvI3968Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iM/ajq/g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756194156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z7i9YDbg96XPkSuor69lux2weqUhbZRVG7R4LIN4byE=;
	b=iM/ajq/geB/t4xXQEewZwBE22hBRkeIBFyUcfbwzjUSEco+EEN+fjbeaJICBKHz43TEVpm
	Q1yoatk1R46PVdWbPAl5Lu7zKm+3BOCP+rCO8FNb+ADBO8vFExgc9vUqm6fg/PfWOc9FWN
	9KBqde0m3n2w2SK35qrZW9iVUDPo3uw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-7oj2b0cBMK65TJx6FO_NBQ-1; Tue, 26 Aug 2025 03:42:34 -0400
X-MC-Unique: 7oj2b0cBMK65TJx6FO_NBQ-1
X-Mimecast-MFC-AGG-ID: 7oj2b0cBMK65TJx6FO_NBQ_1756194153
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-afe81959c3cso220966466b.2
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 00:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756194153; x=1756798953;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7i9YDbg96XPkSuor69lux2weqUhbZRVG7R4LIN4byE=;
        b=LfBs2q3N+H02UHC3yDZnN7dOfgSM8EF7Hpynvh9E0JwarEKlf2WEAo1QAUzc1DvGdE
         UEasrMiB/+CZDl3LI1x4c+ZyGLB4fe1GtwCS4RZXqMLLEN9//ogsFG6JW7iR6LgTFTkS
         j0PwmEDw8KX57ObSm2k6uwT9FJ0oZhBTusvkDrc44dj619O3ic0fEiVWo4qzR8Wlhp3K
         uufOjhA4ywsDFMVdkhxVGDAKXFrdfu1V/Gn2gXJA0/TwDlQx5pnynAkCaWYWDXLKhUtp
         EDyIbcyBSbG2OcN4L33h2grAtrX5uWtOCsgdBnASPdMUw3MmiRNuZI3G/gA0LNaF3VYH
         FghA==
X-Gm-Message-State: AOJu0YyLZGTrWqWERLd5qs9BJSBPKMrJDZGYsupmIkVBTmQGxcTmCvmp
	FgEpSd+s7l43XeqCUoen3dheJG4uyiDvl+MQ+yPIGEkP4r7JlZ/cxFJzxqvZxdIukmde1P3oVya
	P1ffUnzumDpos0Al58fuaZ0fNjCd0pi/bhEyLGq7GLMszwjilH0iCdA==
X-Gm-Gg: ASbGncuvnKVgYM6E4yCdZlnirhvZKMNYY9CTKw0VcZYYs89LcuR/y9gnfHM2lV5/Brk
	8eMCnUdthTcB4hi88SJQI6bZrSdGttWdl0p0lJ/yn+Nz2VjK2hMqeBkJb10iOe6q6EaMZB20YVm
	HcN8jFutO7N+WdpubT5w0cOxRQuuT3ysnCghKFTbN5QIS93elarNO0Ok8WNR2FZHmExNlZY6NLN
	BUrpxpOjOWRfOGDfXxrO2mEl++UFHPcmdT1n6iCqcaXhoJ5AC6EJzLaQ7D+m7Bsg4QFre8ZkvxD
	PTYiCLAzfrYgVM63JqiCHXkXSM2YRWZZ3r43VIhQxLX1Ex0TF8MHRs2HmO+yAJkPOXexU9E1MQ=
	=
X-Received: by 2002:a17:907:3f08:b0:ae6:f163:5d75 with SMTP id a640c23a62f3a-afe28ffbfcemr1407482566b.11.1756194152793;
        Tue, 26 Aug 2025 00:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlXdN5Emxb0ONjeXO0an5VSsBo5+DtdMvl/wre4Bq+MCj3yWiGfw8uKRt2GgJjy2gdrHrI8A==
X-Received: by 2002:a17:907:3f08:b0:ae6:f163:5d75 with SMTP id a640c23a62f3a-afe28ffbfcemr1407477966b.11.1756194152305;
        Tue, 26 Aug 2025 00:42:32 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe75109c4bsm458246966b.70.2025.08.26.00.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 00:42:31 -0700 (PDT)
Message-ID: <d8f723c4-4cb0-431d-9df2-ba4ec74c7b43@redhat.com>
Date: Tue, 26 Aug 2025 09:42:30 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 mm-new 00/10] mm, bpf: BPF based THP order selection
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com,
 rientjes@google.com, corbet@lwn.net
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20250826071948.2618-1-laoar.shao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250826071948.2618-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.08.25 09:19, Yafang Shao wrote:
> Background
> ==========
> 
> Our production servers consistently configure THP to "never" due to
> historical incidents caused by its behavior. Key issues include:
> - Increased Memory Consumption
>    THP significantly raises overall memory usage, reducing available memory
>    for workloads.
> 
> - Latency Spikes
>    Random latency spikes occur due to frequent memory compaction triggered
>    by THP.
> 
> - Lack of Fine-Grained Control
>    THP tuning is globally configured, making it unsuitable for containerized
>    environments. When multiple workloads share a host, enabling THP without
>    per-workload control leads to unpredictable behavior.
> 
> Due to these issues, administrators avoid switching to madvise or always
> modes—unless per-workload THP control is implemented.
> 
> To address this, we propose BPF-based THP policy for flexible adjustment.
> Additionally, as David mentioned [0], this mechanism can also serve as a
> policy prototyping tool (test policies via BPF before upstreaming them).

There is a lot going on and most reviewers (including me) are fairly 
busy right now, so getting more detailed review could take a while.

This topic sounds like a good candidate for the bi-weekly MM alignment 
session.

Would you be interested in presenting the current bpf interface, how to 
use it,  drawbacks, todos, ... in that forum?

David Rientjes, who organizes this meeting, is already on Cc.

-- 
Cheers

David / dhildenb


