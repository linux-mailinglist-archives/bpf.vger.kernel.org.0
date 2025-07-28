Return-Path: <bpf+bounces-64488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA97B136F0
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 10:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DBC1894734
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A8223535A;
	Mon, 28 Jul 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cX9YQp8d"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE228E7
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692335; cv=none; b=TEWbGPzkHegCXrO9AXp5233LrFRNuOo1Rr3+R6a54keRb28TtPe3q7NvBzHd/R46hLXyXAvwhDLAPG22Bt/Hu3cK4nVNo6yYYaFv8BgqEazcNT67o1WD8f58PEv+s1s7hgDEh0Zx1HiJq0Cviw36llHExAzIGJAtahLn1H7yQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692335; c=relaxed/simple;
	bh=HJZXsA11lxr8BqYgWr8HoEhcYGee8uuvfqpfw8y1UJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yj8n3l7WW7vKfS6IBb4fA+9ipXG3y0RcUvhXeEHi3tV1D4aA5ecl1i+6idiyfb18I4ScTcbGF1r/IdkrxgVTKJu5lOveN5YHTyUF5ixSMYGayviYMqTdALObHVP7dlDUcSxhAVKceW3lXB2ny/ZX5w3pyIC68a+ZtfTZrJS0GSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cX9YQp8d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753692331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xOI/nhsp0FQxSML+6RN9rUzsV1D1LgxO16j6gmYC+9k=;
	b=cX9YQp8d4tDASB7UilIfCtmzCAlddBxCXl7i+PzrwNN4eqZwyKsv1RBtRgrcokecXPrcoX
	akR2FxFOMEEHOfS3/z8ThBMRV28L2HloZwbOS+TYwa8/v5x2EPUBq2WxFxBVwWskO86F3m
	glz7EGwqdFscCA5r3NXwfZ2Rb6jNMQQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-xkP_QTgDM3yGh66l6CTWYw-1; Mon, 28 Jul 2025 04:45:28 -0400
X-MC-Unique: xkP_QTgDM3yGh66l6CTWYw-1
X-Mimecast-MFC-AGG-ID: xkP_QTgDM3yGh66l6CTWYw_1753692327
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-458892c3283so2919735e9.3
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 01:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753692327; x=1754297127;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xOI/nhsp0FQxSML+6RN9rUzsV1D1LgxO16j6gmYC+9k=;
        b=lBeyBkefY5yJJkF2NubpHyKpk4xLcNZmGuLBQazzrLYF4ujGNtm4IPautRi+aXaSAf
         jjUmnYEONSj2sF5HbSSit1jYrR6BpFpdv8WlkAj1YR5IePFjzYbDcAEHm+HLY+S6e8+l
         qB/WnpYUPyikGVWRQVObAPrgqFSkx7EiRbtV1BZz49f/FraphIr2J4uQy3H47QEmyfjm
         HrKaymnGMomohWCyR+FFDAdK+HsQaoBcTx6Axz98uq6s/Brj4WueuldSPFcpGUfXvbwX
         XPPrpLKFepnkbnOm24cpBDjMGy/dx/rqt8uc+fU9cBi5f1NEDPE6kaTyBNXUAlS7bDKc
         qnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLP0T/7RuETdVqRap3y3a51utspIepFUj1UMktPqcM6BGsBtXsjN/LezO9qzci3va4UWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65RXNwTmiRmlC0DwZd8U2tGngAVAWY5ImA8Xv7+xDQOd173WN
	pu47rtRkprFaWJY8xtFkB8vh6tUGK+uce+VpnJWhCReaxJBCEbJkQkgcyDfymAtyYKvqfGIYBtd
	2y8Mndz9+23M+XEajSRdQRSTMuaAhPSiT/TU2nhsXSGZj+/voe7hlRQ==
X-Gm-Gg: ASbGncvvyOyBdhpWMkAOOrbMNeA7/bHNQr9QmdEe0p+83H4Pq8tj9813bM+LOaL8m/K
	B4s/clZmGlzuVeOWSAafxEJy/GdLSbjp8/1D51HCr3LZp+Lvp5Ra2VgoKPlrODZ5umT3Uu1mI+2
	8uE3V1gPcF4aMC03hhWOJ5UIaNXDfkX4ayHdT6SnBZDVzsMzVOZudI+q4QL87i96NdsxgjIIRr5
	1+L4vusnYXKfuSXUUxOAGNAm68UNSLKWD5qExBHPU1dbz7D8zNkLj7reah3oCCUhUJCVV8AI5F7
	eZW2BzqLaY0GoA4ga5j4AdJH25Tfgc4lSr6c+FM8KVuORQ0yIGatD6FsBglV1eOa10s4iPdn1cK
	24Fags95w6Haa9dU/p75MrtODj2OsmV55CUC7AeTGEpCqJcKnpphoEJ9+FWKO3OG6KFg=
X-Received: by 2002:a05:600c:c4a5:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-458763179bcmr74260305e9.13.1753692326825;
        Mon, 28 Jul 2025 01:45:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0ytbTFRQr+toJytfGYg9ytmkAf7bGWIT/KNRNPVSHmspPTjkBiFTwTnkeGrsjvDaNVuTIwA==
X-Received: by 2002:a05:600c:c4a5:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-458763179bcmr74259825e9.13.1753692326327;
        Mon, 28 Jul 2025 01:45:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705c4fa5sm151414405e9.26.2025.07.28.01.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 01:45:25 -0700 (PDT)
Message-ID: <558720e0-f145-469b-89b8-c8d6ec41da0c@redhat.com>
Date: Mon, 28 Jul 2025 10:45:23 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm, page_pool: introduce a new page type for page pool
 in page type
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250728052742.81294-1-byungchul@sk.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250728052742.81294-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.07.25 07:27, Byungchul Park wrote:
> Changes from v1:
> 	1. Rebase on linux-next.
> 	2. Initialize net_iov->pp = NULL when allocating net_iov in
> 	   net_devmem_bind_dmabuf() and io_zcrx_create_area().
> 	3. Use ->pp for net_iov to identify if it's pp rather than
> 	   always consider net_iov as pp.
> 	4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
> 
> ---8<---
>  From 08b65324282bbe683a2479faef8eb24df249fd18 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Mon, 28 Jul 2025 14:07:17 +0900
> Subject: [PATCH v2] mm, page_pool: introduce a new page type for page pool in page type
> 
> ->pp_magic field in struct page is current used to identify if a page
> belongs to a page pool.  However, ->pp_magic will be removed and page
> type bit in struct page e.i. PGTY_netpp can be used for that purpose.
> 
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
> 
> For net_iov, use ->pp to identify if it's pp, with making sure that ->pp
> is NULL for non-pp net_iov.
> 
> This work was inspired by the following link:
> 
> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> 
> While at it, move the sanity check for page pool to on free.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---

Nothing jumped at me, so

Acked-by: David Hildenbrand <david@redhat.com>

for the MM bits.

-- 
Cheers,

David / dhildenb


