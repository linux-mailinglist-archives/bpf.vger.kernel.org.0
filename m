Return-Path: <bpf+bounces-59131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D978AC6317
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA374A32AD
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B02451F0;
	Wed, 28 May 2025 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWm/2isP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E336244688
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417646; cv=none; b=ujCOUsdYL5G5vhL51jBPf8jbquitAPs2/VK+u1pONyiPGgqNZlQkeRa2Z0EbIr4dSjP/oI0dN4h6wTPvw2PHQgv8NnVYDyA3mrxxorHMXx2gLj1DDS7RsVScsR0ySNhttHkHyMeQQttgsHAELgnsUyDRlxXsFefsoUQDuQXYH/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417646; c=relaxed/simple;
	bh=wp7LdqPedvDYAse+G9tNyEO6oCgaUn6A7pd+gyrV7qM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BZIkUnmdcVs6O8FR6g/ftmkCIaMhpKThf89uvoU4NejIzIUcfmEHI5e3+Uoi8z8Wli32lg/iMgMsprC3f23bCFbrLoX1zFhUKZQ/767M/d1wi3zttIHrbxJ6ZHbG5X3nmG+gDPxB/w2DetAJgmNEjYMpIikEzK1Nr1yXyLaUUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWm/2isP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748417644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cx1/E7n8px2Cn8C9YEuMbUpQQvtYPWoNjC2S1QtM08s=;
	b=ZWm/2isPLI88Ez7yVz2bG4zFSK+W4MYs4EyLR9YVVh65TOpDLL2qHqBcuRoNE/HnXF8oq7
	5a1KsUDCCAYclCgIuiBrjv2OklDVhB9wYSRL223hzRt3zo7yfc+REqlPTsp2tDeUiakvyM
	wNJrWg9MZg7lkIsBX9r/9rrCf5xO5IU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-gCbOogyoMU6z3rpi6z--5w-1; Wed, 28 May 2025 03:34:02 -0400
X-MC-Unique: gCbOogyoMU6z3rpi6z--5w-1
X-Mimecast-MFC-AGG-ID: gCbOogyoMU6z3rpi6z--5w_1748417641
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac3e0c1336dso214865266b.3
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 00:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417641; x=1749022441;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cx1/E7n8px2Cn8C9YEuMbUpQQvtYPWoNjC2S1QtM08s=;
        b=RpxD/DX/qroN/OputqP7KaM3IpzMuv04sD9V3BOZ3leR7n6xkQ2jFFa/ELWncDx0sL
         twoAU1Rz4s99UEZhkiI5a9IiXcYENk3i/aHktdo8fOOjb9StglziIALb7du3nMtSVlPE
         Hdet5jsAmJar6SRnCQ8A56eNExIG5KmjmWPgSA+aMee5DdCAlef9iPr5MTkBIYEcqXcr
         56FiRZWxYsF+FGVFsnlxZb4yXFHqMO+Ra+zU/GflxcfTyXYUMYr9S/oNnyE+bxHI9a2r
         1bu04s2RrVvMKgGpVeuWBvlUOEv/WBEXCuqxoapkt2TNhv9KrxAmwOKjTd20HfAobe01
         CsgA==
X-Forwarded-Encrypted: i=1; AJvYcCXz6g2h/Y7HbGpOpWo8czfSSMGqvUKz8LiJeyxe08nxqKW7R6brQzxwEmYiEIS9IZ8k0ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye4W0v9/5bY8AuM5C/EAabpPJ6a/yYr4k3EZuUuhR4054gol5i
	iUNExy7LZJIYGyQTYabHIKEXHasUcWV0fTfHxtURDiWv4BhERQe0xlqwmpDbUPhR3tmpAl+0mB+
	QrYTuN+YVPsbuM3J1dy0JXUis4w9etvuDRMB6lAfOYuEl2YevITQLtw==
X-Gm-Gg: ASbGncuyCun4gEKUYug0f9AchzEF/vDlfoOYK6XJSVQxqvRC6dqIfyevoHobT95p/TQ
	aZgOjsw32BY++x9eXp71FBi9M3PFUe7Mx8+X39wvm6DPavxlOVyW9kuJl0EJ0EE/p6jHMs9hfYE
	BglyEszjtxA0Mb5RqQOglksV7tpn9MfmAqDsn2Pn7ZZnX37EKiJZZpHJURfHl6UTRDkHqv9PMVU
	PAOscT193et/dNJN7ZJGYOEhq1UmM+52wQOOf0L5LJoRBgMkApEzOJ6OneGcem9XGIJl8UpXBCD
	tDQzCVOIrTsfQpq9Lv91ppaopmjFMdOnntax
X-Received: by 2002:a17:907:9715:b0:ad8:8841:b393 with SMTP id a640c23a62f3a-ad88841b3a0mr601920066b.6.1748417641427;
        Wed, 28 May 2025 00:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9KtaRBWywvd7zEOcu9IyROxtjjzZhhygOMCxeJM4DbxyWYXeOrAIlAA0NCDwD/ITwJYGxIQ==
X-Received: by 2002:a17:907:9715:b0:ad8:8841:b393 with SMTP id a640c23a62f3a-ad88841b3a0mr601916266b.6.1748417640996;
        Wed, 28 May 2025 00:34:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a1b5d89bsm59534966b.183.2025.05.28.00.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 00:34:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E72221AA87CA; Wed, 28 May 2025 09:33:58 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [PATCH v2 16/16] mt76: use netmem descriptor and APIs for page
 pool
In-Reply-To: <20250528060715.GE9346@system.software.com>
References: <20250528022911.73453-1-byungchul@sk.com>
 <20250528022911.73453-17-byungchul@sk.com>
 <20250528060715.GE9346@system.software.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 28 May 2025 09:33:58 +0200
Message-ID: <87v7plmbo9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Byungchul Park <byungchul@sk.com> writes:

> On Wed, May 28, 2025 at 11:29:11AM +0900, Byungchul Park wrote:
>> To simplify struct page, the effort to separate its own descriptor from
>> struct page is required and the work for page pool is on going.
>> 
>> Use netmem descriptor and APIs for page pool in mt76 code.
>> 
>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>> ---
>>  drivers/net/wireless/mediatek/mt76/dma.c      |  6 ++---
>>  drivers/net/wireless/mediatek/mt76/mt76.h     | 12 +++++-----
>>  .../net/wireless/mediatek/mt76/sdio_txrx.c    | 24 +++++++++----------
>>  drivers/net/wireless/mediatek/mt76/usb.c      | 10 ++++----
>>  4 files changed, 26 insertions(+), 26 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
>> index 35b4ec91979e..cceff435ec4a 100644
>> --- a/drivers/net/wireless/mediatek/mt76/dma.c
>> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
>> @@ -820,10 +820,10 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
>>  	int nr_frags = shinfo->nr_frags;
>>  
>>  	if (nr_frags < ARRAY_SIZE(shinfo->frags)) {
>> -		struct page *page = virt_to_head_page(data);
>> -		int offset = data - page_address(page) + q->buf_offset;
>> +		netmem_ref netmem = netmem_compound_head(virt_to_netmem(data));
>> +		int offset = data - netmem_address(netmem) + q->buf_offset;
>>  
>> -		skb_add_rx_frag(skb, nr_frags, page, offset, len, q->buf_size);
>> +		skb_add_rx_frag_netmem(skb, nr_frags, netmem, offset, len, q->buf_size);
>>  	} else {
>>  		mt76_put_page_pool_buf(data, allow_direct);
>>  	}
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
>> index 5f8d81cda6cd..f075c1816554 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
>> @@ -1795,21 +1795,21 @@ int mt76_rx_token_consume(struct mt76_dev *dev, void *ptr,
>>  int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q);
>>  static inline void mt76_put_page_pool_buf(void *buf, bool allow_direct)
>>  {
>> -	struct page *page = virt_to_head_page(buf);
>> +	netmem_ref netmem = netmem_compound_head(virt_to_netmem(buf));
>>  
>> -	page_pool_put_full_page(page->pp, page, allow_direct);
>
> To Mina,
>
> They touch ->pp field.  That's why I thought they use page pool.  Am I
> missing something?

It does, since commit: 2f5c3c77fc9b ("wifi: mt76: switch to page_pool allocator")

-Toke


