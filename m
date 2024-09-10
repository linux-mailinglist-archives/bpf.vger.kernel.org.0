Return-Path: <bpf+bounces-39416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0C7972D3D
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39DA1C2492B
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8901188CAD;
	Tue, 10 Sep 2024 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ge+J3Yvu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C187713AD09
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959755; cv=none; b=hCm+Q4QJBOLN4zYe2xyk0xOA0/qW0HBUNQ9OcL3gxwobaRy26t/OOMF4KWyZcZJ4WaBUApfOZi4p9U5Na+uoyfXlaKRvDjpCe28EdWRxt67lH3lHIy27QswcRWB+ph+gO9TCzOTRKAgppGSn0gmdXR88faHrrD3rpLBiGg4souM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959755; c=relaxed/simple;
	bh=eGyGPmj8qP4a1HJ7icwsHB0lz2Y8kobW0ucA08xti3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKpFKkU1kskoIP/+SbYCjztw4CuosPRCO7an+7RGS0zgW+T0/oCz/FTTnZMM0VMrbGR0USX+ljDrRNcoRbCtEg++A/lwgeeSUbuL84vqhPAEcrmqjqQMppL6+lv/QgrOQfvgnqJrXMM53FgqtFPtb5+n3vSwmddop6ZMKV3/i/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ge+J3Yvu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725959752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOrTsaC9yhyU98rc48UtcdzEBQ3VCVbDacgXHoEqlXI=;
	b=Ge+J3Yvu/DRiNgjC9TNQhoyqrRqrEiL8yJdhiEj5i2vBsDMwnsBLHkfNuClvQWCpIxN8MS
	asFySrAzlAJWA2zhGrIRn1XVCEF+3GxOPvJPuo2UHnJ+MSxtiihvkoaFeTkfkw+XroL1Z9
	cxq1zD+fZJkVa3+ZG2rNFvOlXtHf6/4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-O8wbpwtJO5iW2xLtkSTiGg-1; Tue, 10 Sep 2024 05:15:49 -0400
X-MC-Unique: O8wbpwtJO5iW2xLtkSTiGg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374bb1e931cso3105630f8f.0
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 02:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725959748; x=1726564548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOrTsaC9yhyU98rc48UtcdzEBQ3VCVbDacgXHoEqlXI=;
        b=mvfqJPaNGAgBIhOs4xx+RjNM8gJxDenSUURdilHvR3QQ7akHQlKgDy9mWbbVVmObsx
         bsmEDWnu/R6jSD+jg4LxGih5CMxbMXVdJXU3JsU5Bz3wngN9GEI7DzlecMuC3oAX2q0S
         yXHqc+Sg266RdE5RybRLFiOnRzwu+cJHMNaTlhrILGW4Q00Ekh+aMSKLgNF4sX04Uhn7
         EXLu801kh0jhpprN2YmXghqWTgM/JawFSxAEWsg951ZDmAZty2H2nU3B/qypOwGNWn3q
         uXBxyY7SU9jUshcPMI81/DJLfuU0G7yuxZUCOtBPisMIHCjdH6ElPuQPgTJ+5+4pC9lf
         Je/w==
X-Forwarded-Encrypted: i=1; AJvYcCV2wqFe0KqFFVt8QdKCw/AhFPzMQw6/nH1mQfYPZDUoXda4ydbU/pihPIBHn52pNMTQtNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWDKLH5Jjzmst1JTqpgwIwLiFU+b0L6uz8LYy5e+t+KkgalZU
	y9hvS+kRfodjP0JNSK0P6u+SK/xEIVgep0DLouOSngfyP1D0Mt+SG6oRTNrQbYU8DJL0zz4t+Ek
	RQ+CMX4ELe3JtmiFLmP2UlUDnSgyZzIsqsIL3RAApQ6bpkA2nMg==
X-Received: by 2002:adf:e805:0:b0:378:8b56:4665 with SMTP id ffacd0b85a97d-378a8a5a250mr1421993f8f.24.1725959747761;
        Tue, 10 Sep 2024 02:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDlVz9KnKxoBPJUs8BJvknxY3Fteh43Ykemjb+fUuzFfRMvSS6AWG+AceJowT+ugSPw6DlDA==
X-Received: by 2002:adf:e805:0:b0:378:8b56:4665 with SMTP id ffacd0b85a97d-378a8a5a250mr1421962f8f.24.1725959747193;
        Tue, 10 Sep 2024 02:15:47 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a52csm8331824f8f.11.2024.09.10.02.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 02:15:46 -0700 (PDT)
Message-ID: <f8b58d30-cd45-4cb6-b6ca-ac076f072688@redhat.com>
Date: Tue, 10 Sep 2024 11:15:44 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/12] net: lan966x: use the FDMA library for
 allocation of rx buffers
To: Daniel Machon <daniel.machon@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20240905-fdma-lan966x-v1-0-e083f8620165@microchip.com>
 <20240905-fdma-lan966x-v1-4-e083f8620165@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240905-fdma-lan966x-v1-4-e083f8620165@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 10:06, Daniel Machon wrote:
> Use the two functions: fdma_alloc_phys() and fdma_dcb_init() for rx
> buffer allocation and use the new buffers throughout.
> 
> In order to replace the old buffers with the new ones, we have to do the
> following refactoring:
> 
>      - use fdma_alloc_phys() and fdma_dcb_init()
> 
>      - replace the variables: rx->dma, rx->dcbs and rx->last_entry
>        with the equivalents from the FDMA struct.
> 
>      - make use of fdma->db_size for rx buffer size.
> 
>      - add lan966x_fdma_rx_dataptr_cb callback for obtaining the dataptr.
> 
>      - Initialize FDMA struct values.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>   .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 116 ++++++++++-----------
>   .../net/ethernet/microchip/lan966x/lan966x_main.h  |  15 ---
>   2 files changed, 55 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index b64f04ff99a8..99d09c97737e 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -6,13 +6,30 @@
>   
>   #include "lan966x_main.h"
>   
> +static int lan966x_fdma_rx_dataptr_cb(struct fdma *fdma, int dcb, int db,
> +				      u64 *dataptr)
> +{
> +	struct lan966x *lan966x = (struct lan966x *)fdma->priv;
> +	struct lan966x_rx *rx = &lan966x->rx;
> +	struct page *page;
> +
> +	page = page_pool_dev_alloc_pages(rx->page_pool);
> +	if (unlikely(!page))
> +		return -ENOMEM;
> +
> +	rx->page[dcb][db] = page;
> +	*dataptr = page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM;
> +
> +	return 0;
> +}

Very nice cleanup indeed!

Out of ENOMEM I can't recall if the following was already discussed, but 
looking at this cb, I'm wondering if a possible follow-up could replace 
the dataptr_cb() and nextptr_cb() with lib functions i.e. operating on 
page pool or doing netdev allocations according to some fdma lib flags.

Cheers,

Paolo


