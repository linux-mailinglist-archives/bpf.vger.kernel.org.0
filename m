Return-Path: <bpf+bounces-55053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED48A776F7
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 10:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0DA3AA9D6
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028881EB9EF;
	Tue,  1 Apr 2025 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xa1b5g3B"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090EF1EB5D0
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497767; cv=none; b=tQ1EKwNPXS+l4iTGkAFd154+B966B1WAAwlpZEmVd0HLTuwg9Fwob5o/VDUrwa+i5+3mbQqle2MZDLHfpk2graW7EvgJyBYa2y2l93OT6ChvtlYnXGjzZWCGlME/3ogEPKuirwp0sl1e43XrWK+6TYX/Bmt88g1gUI5/tkyRZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497767; c=relaxed/simple;
	bh=tV7GHmfr5Si8SRiqwT6boi3Gj3jsFs4R9lIa/PbtSKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwX7ltSns4H7ZYmo/Q/mXXcZkvunCK9REfyYSm51K3MKs87VjD4EraSswCPmmK58/pmVPaUfCMU3l/b9NthBiMYT0KtZ8VSSzMOF8cSdFIMfZ7qddWkw/52SCx9fZL8utURqdDw72zIp0pLVUr5VmIRlWNjGAGG6LUaXc1rTLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xa1b5g3B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743497765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/EOGpZgMMwI61gNswk7Hqy4zEoEqDiKfuBQe+kGOmzE=;
	b=Xa1b5g3BriYlUA5VNSoObwldecuYJmbPxvW+fI6QgxRaN3T2RbHY22klk0qX064bGWF6Rn
	SEHx6iEeBhwbvu+24L36vR2OJ2Rz42he3E3LxY3Qyo1NtNZQoNYwUmEj5bBiUuyVQYVhOv
	WTn9YJCswgrpSms3VJ3wrX4PMLGvfbE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-5ShsdABkNxmL-HWaBmUINg-1; Tue, 01 Apr 2025 04:56:03 -0400
X-MC-Unique: 5ShsdABkNxmL-HWaBmUINg-1
X-Mimecast-MFC-AGG-ID: 5ShsdABkNxmL-HWaBmUINg_1743497763
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so3047091f8f.0
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 01:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743497763; x=1744102563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EOGpZgMMwI61gNswk7Hqy4zEoEqDiKfuBQe+kGOmzE=;
        b=sAtmH02DzS9qCcYmRpi+egAg4P17MV7iaftbdmMZ7+QErv9IiRTkLmZwTt85rmAtPl
         WgIzN6trs/9rYmFmUoRxD/UbPwG0K0xhvs0EtztgTz4dmvvQyzxNFiZInX6ysNXNr5Nw
         ay29a7JM8Dx9u/0yEg6roy5dmnYHULxTLHwLTO0wpN8OYFXKJcJvTdw24BlT4tpVVMN0
         fSuxFMAwLe1dnaBmOQ/gkShsmS5ZicZjsUhP5PAOv66DXbbIcp563hb056ifVxosUwfM
         6oRmbTebiVTLuQa5ks+nTIL5L1eBMROPK32fooRUNacscZMvBXmlQAP1GOSPu8yGouBW
         bmWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC621AueuE3kb0EAbvSKfGHtHGSOFoNbfs52zoZ5Mx+QPRn929Uoiu39PWzPv47k6pOFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBJzOP46E9BhLZUVLPG3CWM4EVAjNHWa64S42CETlM1kNVhud
	CMnY7zRBCGI8tjk0BRJG+2r7NmwvKJU7Pc1XwwV0Ix5pdyZgc+8UVb7+fCARqby6e8swkqzH6rd
	DqaAMRrzO1ryiTTYJXHf/tFxSplG6PG/hrnBRKl65jX4xY1eYMQ==
X-Gm-Gg: ASbGnctWEg6V07tj+vpJrZF8UAkVtyx0x0JMOhQ7706hWBq78g5MrmLan3Bshh8UmuZ
	V8Nh1q0dhDTeHujuAG7v9QCBkaCRDpJJ4Q4BZfkHkjDmhSN1e9oRO6VOogPnkMaoPDBUe6g3t2J
	ZrhK8i5DDq+uoqjEtNb4MqxV9tQKNeLA2JTwpLEREQf8/VNqpqiwWHjEMe0xcVctCOERN8riggN
	u6OEz9XBzVaBlgIFfYjwZxz8HNBI6ypzWKCAih9TGlsQKjVJGhWydvy4SJp/XSaPfYQutPqw3VM
	uji54iFUch5cr4zUv9E7dCtr++yuxNhu+ScAv0gH6ZryWw==
X-Received: by 2002:a05:6000:2913:b0:391:122c:8b2 with SMTP id ffacd0b85a97d-39c120e1566mr10357899f8f.31.1743497762664;
        Tue, 01 Apr 2025 01:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPPFEHn5QvMX8T7Toc4UY1OJQWioAVuAJM2JZ1z1ZDDcbJGmm1kVkDwd+dzHOwCnzyaJepwA==
X-Received: by 2002:a05:6000:2913:b0:391:122c:8b2 with SMTP id ffacd0b85a97d-39c120e1566mr10357860f8f.31.1743497762256;
        Tue, 01 Apr 2025 01:56:02 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e141sm13581555f8f.77.2025.04.01.01.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 01:56:01 -0700 (PDT)
Message-ID: <7488e6cf-e68b-4404-aaa9-f4892b2ff94b@redhat.com>
Date: Tue, 1 Apr 2025 10:56:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-mm@kvack.org, Qiuling Ren
 <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
 <aaf31c50-9b57-40b7-bbd7-e19171370563@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aaf31c50-9b57-40b7-bbd7-e19171370563@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/31/25 6:35 PM, Alexander Lobakin wrote:
> From: Toke Høiland-Jørgensen <toke@redhat.com>
> Date: Fri, 28 Mar 2025 13:19:09 +0100
> 
>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>> they are released from the pool, to avoid the overhead of re-mapping the
>> pages every time they are used. This causes resource leaks and/or
>> crashes when there are pages still outstanding while the device is torn
>> down, because page_pool will attempt an unmap through a non-existent DMA
>> device on the subsequent page return.
> 
> [...]
> 
>> @@ -173,10 +212,10 @@ struct page_pool {
>>  	int cpuid;
>>  	u32 pages_state_hold_cnt;
>>  
>> -	bool has_init_callback:1;	/* slow::init_callback is set */
>> +	bool dma_sync;			/* Perform DMA sync for device */
> 
> Have you seen my comment under v3 (sorry but I missed that there was v4
> already)? Can't we just test the bit atomically?

My understanding is that to make such operation really atomic, we will
need to access all the other bits within the same bitfield with atomic
bit ops, leading to a significant code churn (and possibly some overhead).

I think that using a full bool field is a better option.

Thanks,

Paolo


