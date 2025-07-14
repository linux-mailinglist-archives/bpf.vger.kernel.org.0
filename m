Return-Path: <bpf+bounces-63151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAFCB03B1F
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 11:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7F517DAF6
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59788244696;
	Mon, 14 Jul 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Quvcn7lA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A82D24169E;
	Mon, 14 Jul 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486129; cv=none; b=Yg/cUhmUGhFAsjdTCXheryNzRBKt3h2ZIDMifxOaQ/ciL3gukVn/D4ZswHm3rZiC2gJr/qjfbesFIsZVRT9L9/HrNu+3QJ7+mFwmKDSjxkXDBMD2kumkUg5eL33N3uGkn+pJuGvrlF6fIl/RCdHSkpcksDjJUfrOpUsAOkZIWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486129; c=relaxed/simple;
	bh=ACZNz7XObtsYon3XT2mNrIX3BMvWIJPXGcENlDIAxJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edCnjyOKBIBAXrEbkM8fUTS6WFvSgRZtnfG5rnhzc8+ZSWnbOmEFmjgY1U4x+OnjOXkY58K+nl0ccr5NQD/O7u4tsL/VmpWbOXXbBzJu5KnpEUEO14lx61oTUl1l5WRLZreyH8fCIgmNkvH0eBtvSeA3jzteNyt+cUoLARmCiQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Quvcn7lA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so690687466b.1;
        Mon, 14 Jul 2025 02:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752486126; x=1753090926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1z743deKaHEG9b7jO8Cq+3WiEAgoFp/G0Aswapm868=;
        b=Quvcn7lAERZnWKZtXA2PNY8+4fnE59I/OMHozCB6TigwGqcd3t/TgI8l0+mPn96W20
         NagTVV5bkKjWl5ofmYVKThgWy+ncYJ5/QF5QfpK1Qm2ib4sFBpvhZPUdxZHkfN8o6WgH
         Ahr+LQmtzJc/feyFzsZ597vR2n8GAgs488xOA6e22sEcpJ90PtG1ObfpVWsa1fgcgRrg
         RHk/x+Y0mARlklAW7i9KT9kJl1W2qoELroNTqV5MCwcZy574B7OeVjLy55ZLWVKLGQA+
         wNTPY2o3rXm/muSaqvgVOEPyWq4wm46sTdBKYilYmS7XBT8FN1QjHLbRs3CaVL2eTWhc
         Zgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486126; x=1753090926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1z743deKaHEG9b7jO8Cq+3WiEAgoFp/G0Aswapm868=;
        b=HzRYpR8lU+8qLCEMqwppNJCwsC5a/ulnszIdVd4GxW7b9vNIKSBEaz8vxIsAPa0ol7
         2A8CbxrPE201oINBkiadmO8jnNgnh/PUqrm6iml4k0I0cAtdlc4cbznmbZ6EpPdjDpB0
         rbKgnv1ihBrDAFvrwHKC0uLm7gFkj6UYxLY5RjrLuLryGbobr1B9RdxJ6lwiMzXHSFPA
         aSQJ15yEo9gvx2s+XZ3/kpu4DxclWmSuFiLSI433s/Fj20fnB3vPDmOSmyzKTPtC1sZV
         owhvarJYctZVApLJIruZAU2rOxN0EcvNz0aFwBjqIlDQB8vnSwSwrj9VkxYX+o9gPwqL
         J5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUeRUfMhrbUhQoBaWLmspjS4Y9PX3TZHaRo+CBBctJtYxWw0zd4Y2hL40Rgsrgd99DRr94=@vger.kernel.org, AJvYcCVOIJceDcIYv4GVd9JxEHadbT7kl43AtkC9EKQMWQ/IERIypS++nafW4iMJLDi/ZME7LyDLmAYA@vger.kernel.org, AJvYcCVYUbpEyVTga135tp/g7Hgo0sSkL32UCrfKWHjLX0NMUuzAAYKIFsa8YYZa6/ZTxBqeKJrUwpxvIKl71Vto@vger.kernel.org, AJvYcCWmZ4mqt4+9RkYyMZ/rGIwUaFhP4qCjjsmgZWKRtfPNBFPluaga9VqUNpUysgvIhka9wSVm8vOJVMzi1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRKJMYiEJX9Iv5Wm/lvvI3wY+Jj+kpdL4iBOXE/fjFEGY+vOwC
	kIzE9mA05u2AxPGAkAHVU5HvDO0+nuFBdzW+zi674H5k1iWiDtqSE/ma
X-Gm-Gg: ASbGnctApeI6cqp6EYnrwnmHZZJAM0skJ7gVi8+jY36H5eaXHe73R3TOm0WzNkTLgmD
	rGZ4Ngmv6XiNBCFbgMFZMGKVTjP45QirX4z/RbR3zfp4exabwBWGOpyiAQo292CEoS5y7b6kJm4
	xFpEc6VoWlLwj3eUDaXoKVBA115LhTD9cj6XeNN3hi9qUu++6rrSmGTSrrOYQu0PkOOXxVsDDL9
	gG7MkifaSZbPjbM/CIgRiBbBthV+0TwkcECjEkQkCddPkFWHyvRyxFfh/0qLxEAlE2tM6l9/S+z
	dAEzxScZwUgo7sKvTHj8tmYm+mIhP8nRtZ7Al8O1y7MP4Ujof9ADBS6ho2gvbj4996aJugc53YO
	Xzy0d771l5mbCiUNd4NZZrbi12dRzzbXGB3w=
X-Google-Smtp-Source: AGHT+IFjHAJ2Ei43qKTDj50O6TlqM/ZbZMAztCWqwW7M1VxgsSk3pdmlTcreKCO23+9PcxpLN0q8YA==
X-Received: by 2002:a17:907:1b0d:b0:ad5:3a97:8438 with SMTP id a640c23a62f3a-ae7012970d8mr1211045566b.41.1752486126016;
        Mon, 14 Jul 2025 02:42:06 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:f749])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7f2aa1asm795946066b.71.2025.07.14.02.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 02:42:05 -0700 (PDT)
Message-ID: <5ee839d6-2734-41c5-b34c-8d686c910bc8@gmail.com>
Date: Mon, 14 Jul 2025 10:43:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/8] netmem: introduce utility APIs to use
 struct netmem_desc
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, almasrymina@google.com, ilias.apalodimas@linaro.org,
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
 <20250710082807.27402-3-byungchul@sk.com>
 <4a8b0a45-b829-462c-a655-af0bda10a246@gmail.com>
 <20250713230752.GA7758@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250713230752.GA7758@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 00:07, Byungchul Park wrote:
> On Sat, Jul 12, 2025 at 12:59:34PM +0100, Pavel Begunkov wrote:
>> On 7/10/25 09:28, Byungchul Park wrote:
>> ...> +
>>>    static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
>>>    {
>>>        if (netmem_is_net_iov(netmem))
>>> @@ -314,6 +340,21 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
>>>        return page_to_netmem(compound_head(netmem_to_page(netmem)));
>>>    }
>>>
>>> +#define nmdesc_to_page(nmdesc)               (_Generic((nmdesc),             \
>>> +     const struct netmem_desc * :    (const struct page *)(nmdesc),  \
>>> +     struct netmem_desc * :          (struct page *)(nmdesc)))
>>
>> Considering that nmdesc is going to be separated from pages and
>> accessed through indirection, and back reference to the page is
>> not needed (at least for net/), this helper shouldn't even exist.
>> And in fact, you don't really use it ...
>>> +static inline struct netmem_desc *page_to_nmdesc(struct page *page)
>>> +{
>>> +     VM_BUG_ON_PAGE(PageTail(page), page);
>>> +     return (struct netmem_desc *)page;
>>> +}
>>> +
>>> +static inline void *nmdesc_address(struct netmem_desc *nmdesc)
>>> +{
>>> +     return page_address(nmdesc_to_page(nmdesc));
>>> +}
>>
>> ... That's the only caller, and nmdesc_address() is not used, so
>> just nuke both of them. This helper doesn't even make sense.
>>
>> Please avoid introducing functions that you don't use as a general
>> rule.
> 
> I'm sorry about making you confused.  I should've included another patch
> using the helper like the following.

Ah, I see. And still, it's not a great function. There should be
no way to extract a page or a page address from a nmdesc.

For the diff below it's same as with the mt76 patch, it's allocating
a page, expects it to be a page, using it as a page, but for no reason
keeps it wrapped into netmem. It only adds confusion and overhead.
A rule of thumb would be only converting to netmem if the new code
would be able to work with a netmem-wrapped net_iovs.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index cef9dfb877e8..adccc7c8e68f 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -3266,7 +3266,7 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
>   			     struct libeth_fqe *buf, u32 data_len)
>   {
>   	u32 copy = data_len <= L1_CACHE_BYTES ? data_len : ETH_HLEN;
> -	struct page *hdr_page, *buf_page;
> +	struct netmem_desc *hdr_nmdesc, *buf_nmdesc;
>   	const void *src;
>   	void *dst;
>   
> @@ -3274,10 +3274,10 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
>   	    !libeth_rx_sync_for_cpu(buf, copy))
>   		return 0;
>   
> -	hdr_page = __netmem_to_page(hdr->netmem);
> -	buf_page = __netmem_to_page(buf->netmem);
> -	dst = page_address(hdr_page) + hdr->offset + hdr_page->pp->p.offset;
> -	src = page_address(buf_page) + buf->offset + buf_page->pp->p.offset;
> +	hdr_nmdesc = __netmem_to_nmdesc(hdr->netmem);
> +	buf_nmdesc = __netmem_to_nmdesc(buf->netmem);
> +	dst = nmdesc_address(hdr_nmdesc) + hdr->offset + hdr_nmdesc->pp->p.offset;
> +	src = nmdesc_address(buf_nmdesc) + buf->offset + buf_nmdesc->pp->p.offset;
>   
>   	memcpy(dst, src, LARGEST_ALIGN(copy));
>   	buf->offset += copy;
-- 
Pavel Begunkov


