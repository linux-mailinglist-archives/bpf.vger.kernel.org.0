Return-Path: <bpf+bounces-63312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A44CB05750
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 12:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE28162F46
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91BA2D63F4;
	Tue, 15 Jul 2025 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHUIsELy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59EBBA42;
	Tue, 15 Jul 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573599; cv=none; b=o32N/mzi/u34wagIyf2qJZsHD/bMdfroz5e9SdOkUnNpRopYFcRCJXJ8QBgu0eJsPILV7Yvdi3OPvoNCxOHc5GC5egpvjEBhsHRp137+JE+cQc8URLtgTovbOuk5wnoMpHeqRxkbDQ3+a24kTGn3ZMzEY8xtfNL1hOrJfKg0apA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573599; c=relaxed/simple;
	bh=KfkXVO6R11coJY+jTBff9gxTZ/FJoNl3D/4pOwtlcNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teyufzHZ2/37why7LMsUR8Ph8PNbRls10+2ld7F4KwANfSKMIzvEtTGShL/Zf0RK04fv2RUMmSoGgbsztL2vZv4UcfWOwPo80FNvmSDIcF/WkvjSB10Gg0oJNMNjGO40iVSfwDaRgSD6VmdlNzcwaQXRQgP7PmSOVSRtR/hivKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHUIsELy; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so1044330066b.0;
        Tue, 15 Jul 2025 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752573596; x=1753178396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYOMLk8TERJztvlhTETYqkHUNW747NVR3GmboO+0P6E=;
        b=KHUIsELyVugFdW+FnRFNBiQIMzG/zgjRZIEOazYNr7Sgi2Bb6sksQSCRBQvD388+Ii
         gtrP8DQnVIoiVvWhcZMfSqmsdSd1a6b9mpidjE/JecMSSkLysKTu3NHkLhSqfnLEtiKT
         REgHEnID/UIvxS/uRf08bGeQUv+mZMKO045YajNjHNIYzIQDoe6Nbi+SXubM3zkBcDGm
         qUSuo77du9idgCI4OJgn6xpxmVnnRnuo66Sxp5HWVD0cw7R0V0zvwt8GZIZWPuHs2cDu
         /ThnDKFZRQAo4rJg+73es7yedSjtoQ+Bou9X0Gxvh1hppohetfOZCT8OX2f5H6AxkTls
         wEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573596; x=1753178396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYOMLk8TERJztvlhTETYqkHUNW747NVR3GmboO+0P6E=;
        b=RgQtG61a0SKrAvzHq4kIExrVQtPZaISNYq7JSttTfz7iN7KAjl5+xAh1gJKnc5L2Br
         ByzuZefyQat/0HIgFlxkcRCMq2W/16fScxdy20EUkPSQkUmxEmgqgtDHKs0X6f+y8NJ8
         izzC4UNlBUBwyEdI5yKsAEQkKDDO04AZlby2TmjaDvJJH+44oXgedJCWIZbxrSw8zoSb
         FHwv2UVa7vXwb8OnH9b/lixuBi90LcJXqu6Uo5v2kRUxi7EmHhbmXBZnSIxRvPTbSqZ5
         gtRvdJFXbvTMn7XPk/j4L0MV2l4vrQwojkjZB+GJlJAahF8Of6VJbNYWvKxLk0bXdQ4F
         Avsg==
X-Forwarded-Encrypted: i=1; AJvYcCV+m9oqyKcH5HHwGER1EHpjQpu/eM7BP8nSNpDoLNAcD8WqAucAR5IKyFwXtjetHfsYsof8eg0i@vger.kernel.org, AJvYcCVZ5kVW4YrJfzEI9r2bYYKJ+EKqK+8Em3FmK8xiTxVD+9o4fCG+Q/RZKyETBTGudoLVO7V3IqQTqzNWc1kM@vger.kernel.org, AJvYcCWt6CBtpWapcv42wtJ1v366fCAdnZpDqf6WRxD5WpK/dg9UhyOjn9EjZEPterJRl8JXzn+P5I4VNY77Yw==@vger.kernel.org, AJvYcCXuZHEiRSL/2B/rVcy7lyOm+C+TTu2e8+Gvvr4xkSGnsHuRAKoQpT/1uhwNSoCxgrA4pNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgprJm5XhqfHJIIJFifaw48QUJoEMND2JtRjFYMci8Fa3arga
	xnQfVHzKiHNLuWqvp378AWSc3bV4Z2Clzg4KBooHoGaVHDLXYZA4+6/C
X-Gm-Gg: ASbGncs8VuTvI3XlqLnK3y3+DxXdOQNAZv/I/hZ6SrqWxcBO84oh/wza5e0v2pBB2cT
	86EBXTV6TmfsCirvff2doHA2IZMB383zq0ELPYspDSKxT0XncCEFusC0fVSVn+dXLVXTIVvPSoH
	XbNiPgYpivzNOqkezICgtsd7WeCxsEnMy+YRHP77mv9yKFo+2Hm2cOnmtfEFo/fqw1WoGD9Nk6Z
	P2RseAxR5zcKam5JdFeRMC1D6pZe6l4qRqhZ1rxcA6dFogWO8PUAX9VlpsJqmrTMpxUNIvIQob/
	msMLMr/rR15PTxj1EzV94qcWFwovJRt/0QaX0r9V99iVFiIMKXFEj7g6LwlL+9oM3e0nPPrBblS
	y43X/lo1pYvkjHPtv9Txk2kfXtcK02LyNuag=
X-Google-Smtp-Source: AGHT+IEClANar98EqQcH01HezY8+daSMVOJbnjooC+tE4RrQapF+6luAQA+hn2S+9tC3xu75GcdOmg==
X-Received: by 2002:a17:907:d2d5:b0:ae7:ec3:ef41 with SMTP id a640c23a62f3a-ae70ec3f087mr1332966566b.45.1752573595500;
        Tue, 15 Jul 2025 02:59:55 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:a4c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e910d2sm973242366b.2.2025.07.15.02.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:59:54 -0700 (PDT)
Message-ID: <d5d8db9b-580e-4ede-8949-c8accc725e78@gmail.com>
Date: Tue, 15 Jul 2025 11:01:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/8] netmem: introduce struct netmem_desc
 mirroring struct page
To: Mina Almasry <almasrymina@google.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
 jackmanb@google.com
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-2-byungchul@sk.com>
 <b1f80514-3bd8-4feb-b227-43163b70d5c4@gmail.com>
 <20250714042346.GA68818@system.software.com>
 <a7bd1e6f-b854-4172-a29a-3f0662c6fd6e@gmail.com>
 <CAHS8izMGGCG2kNkj2vqcUO3-M77P_7whY1BeRH58b6ix+R-kRw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izMGGCG2kNkj2vqcUO3-M77P_7whY1BeRH58b6ix+R-kRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/14/25 20:17, Mina Almasry wrote:
> On Mon, Jul 14, 2025 at 4:28 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
...>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>> index 535cf17b9134..41f3a3fd6b6c 100644
>> --- a/include/net/netmem.h
>> +++ b/include/net/netmem.h
>> @@ -247,6 +247,8 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
>>          return page_to_pfn(netmem_to_page(netmem));
>>    }
>>
>> +#define pp_page_to_nmdesc(page)        ((struct netmem_desc *)(page))
>> +
>>    /* __netmem_clear_lsb - convert netmem_ref to struct net_iov * for access to
>>     * common fields.
>>     * @netmem: netmem reference to extract as net_iov.
>> @@ -262,11 +264,18 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
>>     *
>>     * Return: the netmem_ref cast to net_iov* regardless of its underlying type.
>>     */
>> -static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
>> +static inline struct net_iov *__netmem_to_niov(netmem_ref netmem)
>>    {
>>          return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
>>    }
>>
>> +static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
>> +{
>> +       if (netmem_is_net_iov(netmem))
>> +               return &__netmem_to_niov(netmem)->desc;
>> +       return pp_page_to_nmdesc(__netmem_to_page(netmem));
>> +}
>> +
> 
> I think instead of netmem_to_nmdesc, you want __netmem_clear_lsb to
> return a netmem_desc instead of net_iov.

Same thing, the diff just renames __netmem_clear_lsb -> netmem_to_nmdesc
on top.

> __netmem_clear_lsb returning a net_iov was always a bit of a hack. The
> return value of __netmem_clear_lsb is clearly not a net_iov, but we
> needed to access the pp fields, and net_iov encapsulates the pp
> fields.

Right, and netmem_desc nicely solves that. I remember suggesting such
a common type during review to the initial netmem / niov patches as well.

-- 
Pavel Begunkov


