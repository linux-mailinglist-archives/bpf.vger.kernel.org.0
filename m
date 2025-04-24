Return-Path: <bpf+bounces-56585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF009A9AC83
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 13:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6715E3B2AE6
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 11:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5456229B38;
	Thu, 24 Apr 2025 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0x6VSFZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994C202F79
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495627; cv=none; b=uRG2rV8yw1wqLo3jpGRRQbelMTqHwsFGEXp8R76QSgHpzmtHaBons2MTgn6fZg4VrQ48dfVQSDwhPcna5/URsiYXjcXMV1HUM2kcuubmAodbe52IOi0/w2jNL2QDe4xLcvSul4S5VoZMnFm5U9UdSwCf/QPLAwQaAMz6vv6eWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495627; c=relaxed/simple;
	bh=Fpd73RRnHn/l4PYVjhLh24iJQjof1gdaW83Nyo/GhgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j16B+A/BNpCvUyuDqF9gmPgmFUdooFhTfQ7IQpQqEpItu3l5pvc1xBD3+nIbx2Iqfw3rp6Japfi7ZJXBWTPL0f/tW7F85PcSA4DMCpnmlsgpDF1O/4kvZDOUDiH5mtAZIceF5RbugR/YaEFZakvcd9MNLVpI75K7eWScAPtRm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0x6VSFZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745495624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7O71wS6omUP4Za+qu8KkJ9Z+HYsi5jrXQRVuEjbLS/Y=;
	b=U0x6VSFZpsG194wzvpvDS5puCDW1O4c6T2wxbF4VaeOkTqTz8aUnoZ8dIdiCV/bFQlsJSZ
	B23RuiJbzuIAYP2Xey7gg9+hQdr3WC79uHcoQquf/Fi6bzAfYF2wBwlEraZgplsbU8nYh0
	NP2+iAKn90MetYoSuwWcWga6M4nmHfA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-7a74jtISPlC7YPSUh8-m_Q-1; Thu, 24 Apr 2025 07:53:43 -0400
X-MC-Unique: 7a74jtISPlC7YPSUh8-m_Q-1
X-Mimecast-MFC-AGG-ID: 7a74jtISPlC7YPSUh8-m_Q_1745495622
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso5598915e9.3
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 04:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745495622; x=1746100422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7O71wS6omUP4Za+qu8KkJ9Z+HYsi5jrXQRVuEjbLS/Y=;
        b=KH0GrUg5IyQNPFOJGO1Y3ss9GB4N/pOL3WVSzvmnlSeBo51BMi7MwIWuO3l4cBaJHA
         f0JzKYBYr5tp3uMr8smiiBauQky7p7uZpZstl3e6iWiKZ256WyI8G7J2uaJlGvn4t3lR
         PL1l8dZYOFehrzwOAcLTu2247O64L2HQJn9i8zWFvx9H9GJezLZrlwH4mz4xS1h+C6mV
         3kLTMSkc1ALrcWJe0Qyllej7h5PeeowTqGCUzUSfs5wTSJpWW3F7UXw1q4mPqIs7WFUM
         nhG0/ayM/IRR2Xo5Ow4SmjbsjFcG92BFqxM5H1COKQjE2jkz4aIb+gVoDKG8O4k+urgb
         20PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMcyRbSg0EgxxMkUppCtQZztyn5y5HrGCaBL+jTvGphY+tvP7YQ5UP1yI+TDVUKmHXZng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz31LfJA1HLhal8mJPFKbNDXlAMTtYXvX1Tjb1CTMYaoHWxP5UE
	VvrJF/gHvbkixDGsKoqZZFAnFMPYnpO4XgJBtiReTNAZy6BTlRTXtkgmHjHM0MAg5PYFz6JVGmF
	3CfqgpZTOS7Ai9aLmoQm+DGCQycCMBqS93o0yK66i6lxlN+bUDg==
X-Gm-Gg: ASbGncv5TBzMhfV3cN6hCu82R3VEZmFFTPP3aI9Spt1qgCow413avrPDqAJEfYXL+UX
	Isk2Ex5UckRtwJ197SuDTNWe0H+/vNImbsrIjEP7Ej9kX+tChrBSgh45yzEB5bsMjxrIAS4PQJ8
	cxJPG3yBATwMzlXbmhJP3JEVKoIlCdVEbwTAdndQfeMa3WoDsTJ+66YtipMM3v0TLBzTLxYkfDr
	i96CT0RwjqxszoW1JFLZ/hjxzbRV51LCjv7Q2jACN/iUAyGLNHPdDTdn14a5vJXk5MTyXD9gamh
	55oyvmcy7qjDTo1INnC9iEEdh6iE1Bs4Y89FYEw=
X-Received: by 2002:a05:600c:4e0a:b0:43c:f513:9585 with SMTP id 5b1f17b1804b1-4409bd210eemr25352615e9.13.1745495621864;
        Thu, 24 Apr 2025 04:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUAI2NQUKhz4qnOoSRg3Qvi8tq8xdza5SLA8RiijZXZRu9gfA8tceguZucQbwMmFsJdyoLyg==
X-Received: by 2002:a05:600c:4e0a:b0:43c:f513:9585 with SMTP id 5b1f17b1804b1-4409bd210eemr25352255e9.13.1745495621516;
        Thu, 24 Apr 2025 04:53:41 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-183.dyn.eolo.it. [146.241.7.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d54c246sm1831740f8f.86.2025.04.24.04.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 04:53:40 -0700 (PDT)
Message-ID: <edfa1585-c10c-4211-a985-ebfcb8e671d5@redhat.com>
Date: Thu, 24 Apr 2025 13:53:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: stmmac: dwxgmac2: Add support for
 HW-accelerated VLAN stripping
To: Boon Khai Ng <boon.khai.ng@altera.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Matthew Gerlach <matthew.gerlach@altera.com>,
 Tien Sung Ang <tien.sung.ang@altera.com>,
 Mun Yew Tham <mun.yew.tham@altera.com>,
 G Thomas Rohan <rohan.g.thomas@altera.com>
References: <20250421162930.10237-1-boon.khai.ng@altera.com>
 <20250421162930.10237-3-boon.khai.ng@altera.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250421162930.10237-3-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/25 6:29 PM, Boon Khai Ng wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> index 389aad7b5c1e..55921c88efd0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
> @@ -4,6 +4,7 @@
>   * stmmac XGMAC support.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/stmmac.h>
>  #include "common.h"
>  #include "dwxgmac2.h"
> @@ -69,6 +70,21 @@ static int dwxgmac2_get_tx_ls(struct dma_desc *p)
>  	return (le32_to_cpu(p->des3) & XGMAC_RDES3_LD) > 0;
>  }
>  
> +static u16 dwxgmac2_wrback_get_rx_vlan_tci(struct dma_desc *p)
> +{
> +	return (le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG_MASK);
> +}
> +
> +static inline bool dwxgmac2_wrback_get_rx_vlan_valid(struct dma_desc *p)

Please, avoid 'inline' function in .c files, especially for functions
that will land into function pointer like this one.

Thanks,

Paolo


