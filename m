Return-Path: <bpf+bounces-48768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B443EA1070C
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 13:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35951885A0E
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0B2236A73;
	Tue, 14 Jan 2025 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0LmrXx7"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291C1DA21
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858825; cv=none; b=bPyQMlkrP6Y/8rUogrIt2Vf5taAVDgUkVTgh+Ocdi8o1tIaz6Nz6qg5YamkoMRMJn9d5c5+Nh1dzJZ+f3Qx8NUaoIrd/wCJK6m7scSVbYbMHsuP0OXyK+o9uB7ZQerL1AGcFY7XyCCsU49WK2lEc0vXSeMReDVMRBMJdoJPWIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858825; c=relaxed/simple;
	bh=Uin1dOmwdUP+SHUBgd6PscEgsxreyrFU/vwVc8g8y7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CVPXRCRuA03RvFvpVHFNF8aVcolMDt7PQpFelokE+lOUYdl2+2imZu54dDEkH7TmvKqCAi2lFO5EbW/hOOTBKOITKD7PourrqNOPgJvKkHydsTYVUg9iu/2Q3C6IiEuRB60EfYh0EiyDTCmEudFx5hBeYSUX3uXieb9oZmGoC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0LmrXx7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736858812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kH/iRgPgE7A5Fhhf2p8dKe9HdDfKM5Ah+Fq/yovw5X4=;
	b=T0LmrXx7ia/DwHp3WdAoYMtcxB7cE7yXUAZEBcSz0xpqMQuG0UxsAbVozogH0/cHNpBCw/
	MZH8qrSstSGlwMIAJAqul/bprabAsa1mrwfEVxiq61/JhUyoeqrTODVNIT/15ITmLii9a+
	cWdK23ULDdfZlAbw3xyfzQeV15R9nfg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-f9Xa2o6_M6ORlCDSef57RQ-1; Tue, 14 Jan 2025 07:46:51 -0500
X-MC-Unique: f9Xa2o6_M6ORlCDSef57RQ-1
X-Mimecast-MFC-AGG-ID: f9Xa2o6_M6ORlCDSef57RQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38639b4f19cso1358443f8f.0
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 04:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736858810; x=1737463610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kH/iRgPgE7A5Fhhf2p8dKe9HdDfKM5Ah+Fq/yovw5X4=;
        b=dqltiTlsoWgH1b433pR59SfUab0icJiC2hBoiyzkzAC+KXOMei74mr+1+anR9mRYJ6
         8VJnHF7qI1oUeJj/5Xwf+H3sywPnhdb+f+/PRMbkjKaK7AUVhKE7kkxNk2r75BgE01MA
         kl8INy3B2ARzMbW6xL+3oliK8OyMwkiJBJW/86B0C9+16lqUEu3ovSoKi6HgutObxfIF
         zkz6kPELq4persJhtD54CjEzCCsMTOSzy096wfUn3EBmX2TTW0luBxQgCpEPEgtyGUWV
         z5cJLtkVYJ9jLniuFtR4DalYdkGUoPBXXaItwdahih2wFflVphCjdyNeEp3TGp0BvDZl
         NErw==
X-Forwarded-Encrypted: i=1; AJvYcCVLnzaXAPVnfP1ZFBj9OMqKf8zgFgUoaaKGp6lcwgJdVHDvSZ8SCYCe1hIvqXgYge5Yy0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMr9aehVuiNbQ3Ol5Qoqp7uS0wcwF2FGuULD7FbEl4F5Hi+Tnj
	4vF7fMrY06D6bt8SFyt4QEABBfWshnK6toTNKWHUUO1dDtOrXMeVci4DmhAhJM1fkI446aGgCJ9
	spqWm4ydqCQJAKVLGqUHCt13Ondt1mx/W7Dj8/OsOyrL8Cg0kIQ==
X-Gm-Gg: ASbGncuNL4GG1B68skpze4x0H0Ly1kBYmV1Nla+DvC27Y0MImfc1ainpuqUsCUqrLLD
	XShrS1d7Cih0D05BYtYW2dlPZCw5J/SYJjqH/1XK+8MiEHAKoBbkrSRKcmJNiNDJAHcySifHjy6
	FZpj0k/6WX67Tqxo3+3nn5YgErQ11csiL491buiqvpUvxZk37jK/bwcs3X9df4S85dtZ2hz5TWT
	YJ2l1B/gUNXawMP8RfduGInclQcMlfu/+DaW5zAo6LlQe5QL0kbNZGwNn5JRrSuX794M3dIAH3Q
	RduSoZpcxf8=
X-Received: by 2002:a05:6000:4a06:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-38a87338df5mr20454024f8f.36.1736858810318;
        Tue, 14 Jan 2025 04:46:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+9v10x1N2wFoQ1EghG8MZMb2tc7d0Q08/8q5FSV+ZT6GN8dur266nKm/Vs31WmKlGP+I9ZA==
X-Received: by 2002:a05:6000:4a06:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-38a87338df5mr20453986f8f.36.1736858809912;
        Tue, 14 Jan 2025 04:46:49 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d26a7bsm180090335e9.0.2025.01.14.04.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 04:46:49 -0800 (PST)
Message-ID: <49043623-f34e-4274-ab4d-494d8319cb32@redhat.com>
Date: Tue, 14 Jan 2025 13:46:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 3/6] octeontx2-pf: AF_XDP zero copy receive
 support
To: Suman Ghosh <sumang@marvell.com>, horms@kernel.org, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lcherian@marvell.com,
 jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
 hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org
References: <20250110093807.2451954-1-sumang@marvell.com>
 <20250110093807.2451954-4-sumang@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250110093807.2451954-4-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 10:38 AM, Suman Ghosh wrote:
> @@ -1337,8 +1358,12 @@ void otx2_aura_pool_free(struct otx2_nic *pfvf)
>  		pool = &pfvf->qset.pool[pool_id];
>  		qmem_free(pfvf->dev, pool->stack);
>  		qmem_free(pfvf->dev, pool->fc_addr);
> -		page_pool_destroy(pool->page_pool);
> -		pool->page_pool = NULL;
> +		if (pool->page_pool) {
> +			page_pool_destroy(pool->page_pool);
> +			pool->page_pool = NULL;
> +		}

It looks like the above delta is not needed: page_pool_destroy() handles
correctly NULL value for the page pool.

/P


