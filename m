Return-Path: <bpf+bounces-48766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA26A106E0
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 13:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9BD3A88B0
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DAD236A94;
	Tue, 14 Jan 2025 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2Qw14hO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF3236A85
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858376; cv=none; b=e5KeroYYXRtyBab2/yMSjMkM4HEHeoUSnrThvZYQ1GOyfQ2VyLnzOSPTi7Jm7NboPtYixnjSCSLPAF2wWiKccyuaQSFEPXtLbve38HGq+2lykquO81YeYrI4IoJHSzsr5vezK3s/sHQMoXZr57xUuuy6tpMu8g+l8N4SKC3SAes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858376; c=relaxed/simple;
	bh=v8KipBFQxZeqbnSjWFLnRv0KwhLyukvO8qcuSxB4yaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TVTsM+r/wDWytbItJGoEJSB9p+7CYl4dCAYj689/PnclmJ+ZGHSmrY9Q1nE9FPYAOgVJNHoPRjcVxhxb6YsgZuknDeFgPKSGUsRVnbEt1WZHBiX0fk9jS2ABCVGPp09wqEzVdreXq7/gt51A0B3d2HUh28BWULc4AOTkzm3drxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2Qw14hO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736858373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdVZWClN6BJ6JeXR4QLrzybP9oirqe6vUjWqveAxrbA=;
	b=C2Qw14hOuPsNQK7tnl7oCvmq7ylfmB1gWsyNEucZODmR1yaIFb5qUJzpfuB5COc/wfwRZ/
	0SuQOiA+2L/HohsQ5me5fL8MtA0+VI+pjS1j6tRNb/lcnaitLkI907LO5wN+56EpEeXnvX
	MD78nMXkzoxQFG+WlbRyFtsEA55wQV4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-iY1Bx4owPqOmwu80wRnpKQ-1; Tue, 14 Jan 2025 07:39:32 -0500
X-MC-Unique: iY1Bx4owPqOmwu80wRnpKQ-1
X-Mimecast-MFC-AGG-ID: iY1Bx4owPqOmwu80wRnpKQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4362b9c1641so25819815e9.3
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 04:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736858371; x=1737463171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdVZWClN6BJ6JeXR4QLrzybP9oirqe6vUjWqveAxrbA=;
        b=KZPKODUJB571GEp/83SYPIA4SiXiQh4kUT5CCnCaRStZuGmBIRpHRRjm7jfD/pU4m+
         dvX1GHJkAtBNerGzR2hB/CXRF7MsaOCvqPY+YepXS9/7y5wQbW+xaH/xVKGK3+KV+oz+
         ZJyjG7EWzA2S0w7AVxC0lvzK5LnrzUhVH5iGpwKHjdG6tIq8uLiabZ6WhuAyCIJVA2Kb
         xOkLk10iz6TS1vliZxcIurCr8yCBfe03+lyjwowp6+gsXqkGE3o/+MPC3NbiDsnUKf4f
         L5t2/LoHRx2ot7OS44eIo3ewQggNg5APbG3Zcl8hiUtfJkjLvdqs2S5DXIlZFDGse/9X
         ciNw==
X-Forwarded-Encrypted: i=1; AJvYcCVB4oGM3ESsc3pxKGT3NBghfV4i6qqhxBt0jpX1Lp7GavPzfWWowEpgOIQxnXBNpVI1m+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8oxHAes9+vtUjcDykKgo+u/oTeWIPNovUUQKeXuIbVw8D2jym
	3NAyOmnHFxgymT+viAAKL2PI3zDWD1cSI4TuewAZjcUoGApvc9R9MVtkqF3BcvoizZMlhVRgbtz
	CZ3kg4RadpJ6Oz+NCh16QcJOHGrBuL4sgbAbchTe7lrkdSTb1YA==
X-Gm-Gg: ASbGnctrMZHCeFNSe1Kfdmqre1XCJhrIcfHqGWsJeH19vnZB8ykmuYNwQrpNDj+d1dn
	T1eZEhGa4GzIRpnBLZii0pz7muVIhwQNWe/sICA9719cyvXPr+nvgfYPf5YhGH8pa6D0ISMdgRE
	FWBWinRfV5mub8/bm7M/UrlgR7774sAc0Za9GTx97ytZbCYrAS0Acke4NGovonh1wIw/8NhpC10
	wdnDCCoTEsST/i2aHSx18myRfVoHlLzG39jZkQrhwYtxhoZruOFmLVLCdNF8n3aOkF+aCAI1CgG
	c3WFphvafis=
X-Received: by 2002:a05:600c:214e:b0:436:e8b4:3cde with SMTP id 5b1f17b1804b1-436e8b43d30mr213875655e9.14.1736858370761;
        Tue, 14 Jan 2025 04:39:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH25ZxlgO5gAprBJxK79NYj3ZZTmp61VYUDrYbYjoFhGk9YQgeUCk0Z5b51Kd7Q2c6jO4TYXA==
X-Received: by 2002:a05:600c:214e:b0:436:e8b4:3cde with SMTP id 5b1f17b1804b1-436e8b43d30mr213875315e9.14.1736858370426;
        Tue, 14 Jan 2025 04:39:30 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dd1de9sm173323325e9.15.2025.01.14.04.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 04:39:29 -0800 (PST)
Message-ID: <dddca9a4-9ee3-4da1-b68d-26f208566d5d@redhat.com>
Date: Tue, 14 Jan 2025 13:39:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 2/6] octeontx2-pf: Add AF_XDP non-zero copy
 support
To: Suman Ghosh <sumang@marvell.com>, horms@kernel.org, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lcherian@marvell.com,
 jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
 hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org
References: <20250110093807.2451954-1-sumang@marvell.com>
 <20250110093807.2451954-3-sumang@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250110093807.2451954-3-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 10:38 AM, Suman Ghosh wrote:
> For XDP, page_pool APIs are getting used now. But the memory type was
> not getting set due to which XDP_REDIRECT and hence AF_XDP was not
> working. This patch ads the memory type MEM_TYPE_PAGE_POOL as the memory
> model of the XDP program.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

This looks like a fixes that deserve its own fix tag and likely going
trough the 'net' tree.

I think you can still include in a net-next series to simplify the
merging, but the fix tag should be added anyway.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 2859f397f99e..730f2b7742db 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -96,7 +96,7 @@ static unsigned int frag_num(unsigned int i)
>  
>  static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
>  				     struct otx2_snd_queue *sq,
> -				 struct nix_cqe_tx_s *cqe)
> +				     struct nix_cqe_tx_s *cqe)
>  {
>  	struct nix_send_comp_s *snd_comp = &cqe->comp;
>  	struct sg_list *sg;

For the same reasons, please move the white-space changes to a later patch.

Thanks,

Paolo


