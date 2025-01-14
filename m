Return-Path: <bpf+bounces-48767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B53A10706
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 13:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9E318830DA
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5A31C5F22;
	Tue, 14 Jan 2025 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFq3cSND"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D3236A8B
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858650; cv=none; b=OBYG9mxdfgegr51lcSHU9llklSxDVYcg5ERBDfXlc9/xQId/VkvpZEfAfq3QKj+jU1ro4yZ8X+gWAzscbxnKBm2ohFqIHDBxl342N0Hif86SQSrbcdZTbPOIOMc3FCGWPOtrnpmP/lA8BAw1PWKAgx4q8+XtQM9ZtwYbkOsjArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858650; c=relaxed/simple;
	bh=OMKrfMlZN5TDVYArU+0YAZRjYiiWfczb/1GftAm3SMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bGo7ZqQTN5rfMtis24/rSKFCK24ZyqizzbZKMoeWAX85kwMMWyNwsgZT05YCNq1zwLfzmmFUF78enTurCspJz2Ra4nwFejY+0Tnk7lcklLBPWfssvPUzbwubCB18rSSkMYlyH7WIuNoeFT3KlP6PARita3T/lCmM6dA6waY99dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFq3cSND; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736858647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ta39/7Gq7xX5aLwxAYnRlrTh0UUs0/WJpTt34X/Rrf0=;
	b=HFq3cSNDANQUZFPuMFx0rS+bi0VZQ+SyolWeWmFSxQyKiFERW9DZCUhRj88SmLl1I8OALv
	wQSggHhb4UinNrzxsB2ZPhs/Hb1w+Hx9+fpXUZPbIcUfPPO9O6d2WzrJ4DNUIewpoOs/Ue
	4dkDLsCjIjqKmGwA/jX5CRKRit0QqbY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-nAwoyFPRM826zxU47DM8bQ-1; Tue, 14 Jan 2025 07:44:06 -0500
X-MC-Unique: nAwoyFPRM826zxU47DM8bQ-1
X-Mimecast-MFC-AGG-ID: nAwoyFPRM826zxU47DM8bQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e27c5949so3133134f8f.3
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 04:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736858645; x=1737463445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta39/7Gq7xX5aLwxAYnRlrTh0UUs0/WJpTt34X/Rrf0=;
        b=rfH2//CZvWoyhPchimcEPaD1hKAeL+diRRe/oRw6nFlobOkiI6vZPg6jTsJcUdRFSR
         e2/aCzWrTRFG5Pv8hqeTy9oPAAzQIo8Q14PBSHePco3QVrYnIgb9fpKZP78h/kOi2Tg0
         w0KvopVN1rhXokWwCzicqL0jEfaKw+VYq4nZ9RgJrig0Yj8lnSGHltri961jQOriqoOu
         0oZHsEzaCbI7bnw0DWq5H+OafrFSUobmpAjeXWQHzOq18dJea/QHFzWtOPj5ce0/ylQs
         MOiOMs74BaJbc1/0NfozXP/LNwoGO3oMRVUwaWXVhlX6bVfualBhjqji3E7ENtXlIqxh
         MJGw==
X-Forwarded-Encrypted: i=1; AJvYcCVoApMlqEk0hGeKT0oUwTrh+1IyjNinXXzBjwtar1zO4loZjoNAKASOvPnGEQJnyeYqf4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/ttD6LDQo1tgB5UsGJ5Ip29IhMLT9dZgXeRteVLcSIt+eq4z
	vzseSW8FRkjG8uNPHu8tfCGNsnWYBdu/plfPfjAkEEJbE+DKbG6cZVC0akHro7LtBI9TG98KXSX
	FoxOmHp+F6kBjzQl3BwbXEVrk5Ij6lPh3pyzds91iPlbEjBqzwg==
X-Gm-Gg: ASbGncvhPcox73dIxRVRzAX/glN5HMmRddCKEpp4nooYgGLy0/5oI9xyXriNIWQzgB5
	e5RmFhMkTv7zprkRuVdQUucozeBcmtl/MGkI5a+pf4+ivhUC9i6lxOXfJXIJvPKrkp69ZqW55UZ
	CgfMXeYyyQRWsZ4D6vSSKSdzORmbo9t07+WdKGnalv3IfLZ9Hz/YVCeCt4s0h3TQ06iVCBWuI5W
	HyIntR8PSt7UoFljAc8Oh9MpfmjRG9XGRrjXtgli0DiTPchvaotBXoTauvkZ0iUiYw1SdhwQF+K
	9hx+ODDWfRM=
X-Received: by 2002:a05:6000:460b:b0:385:dffb:4d56 with SMTP id ffacd0b85a97d-38a87317e45mr20803717f8f.53.1736858645126;
        Tue, 14 Jan 2025 04:44:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8z2W6BEbpjKGLRHPJS/UY8AoBh/kFNQVVZ6bs77tXT63OqEK3gkw3n8/KgPqqOevuPHMV2w==
X-Received: by 2002:a05:6000:460b:b0:385:dffb:4d56 with SMTP id ffacd0b85a97d-38a87317e45mr20803688f8f.53.1736858644819;
        Tue, 14 Jan 2025 04:44:04 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37ce18sm15105147f8f.14.2025.01.14.04.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 04:44:04 -0800 (PST)
Message-ID: <2e4d11f6-843b-4e25-b4d1-727dc4edbefe@redhat.com>
Date: Tue, 14 Jan 2025 13:44:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 1/6] octeontx2-pf: Don't unmap page pool
 buffer used by XDP
To: Suman Ghosh <sumang@marvell.com>, horms@kernel.org, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lcherian@marvell.com,
 jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
 hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org
References: <20250110093807.2451954-1-sumang@marvell.com>
 <20250110093807.2451954-2-sumang@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250110093807.2451954-2-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 10:38 AM, Suman Ghosh wrote:
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index e1dde93e8af8..8ba44164736a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2701,11 +2701,15 @@ static int otx2_xdp_xmit_tx(struct otx2_nic *pf, struct xdp_frame *xdpf,
>  	if (dma_mapping_error(pf->dev, dma_addr))
>  		return -ENOMEM;
>  
> -	err = otx2_xdp_sq_append_pkt(pf, dma_addr, xdpf->len, qidx);
> +	err = otx2_xdp_sq_append_pkt(pf, dma_addr, xdpf->len,
> +				     qidx, XDP_REDIRECT);
>  	if (!err) {
>  		otx2_dma_unmap_page(pf, dma_addr, xdpf->len, DMA_TO_DEVICE);
>  		page = virt_to_page(xdpf->data);
> -		put_page(page);
> +		if (page->pp)
> +			page_pool_recycle_direct(page->pp, page);
> +		else
> +			put_page(page);

Side note for a possible follow-up: I guess that if you enable the page
pool usage for all the RX ring, regardless of XDP presence you could
avoid a bunch of conditionals in the fast-path and simplify the code a bit.

/P


