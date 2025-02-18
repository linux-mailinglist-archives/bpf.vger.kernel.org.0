Return-Path: <bpf+bounces-51821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A006A3990F
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 11:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46013B8F9E
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637E8234987;
	Tue, 18 Feb 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqykJQ8V"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9CC23C8AB
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874392; cv=none; b=EvSoiKkppKtyXDTSQ/SYqSgjCNcdnaSL2AW2iykrXWubVnGao5cB2nLQX2STCuCLm8QMTSt23TtjJEidjNOHKNm/ZAx2M6VlQzHIR9aTvNLODhBNEGMBwtMZLdaarJZ5S/jXx/BgHPk+UOdKlhFu2IUTipDMCPeNw2KKBZAK584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874392; c=relaxed/simple;
	bh=lTGVYVOIgtjNSuSseJT7KQGGiUReOwLr3tUic5SDfP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AMWbc1TJg+vgWv21tIm9jBU5+b/H4ESXSksgiupAYO4A95AGbOExCaIjT9x/u7H/lVFseDJ3VROLLVQbiGp/kzJjAsuO7t2CaxwafkOzu/uBdHw4GEcAtIjkibcT5QokutwyvL3G/2AlSh/ZBxhfRk3rsGBgRUVoNpN78W3I0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqykJQ8V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj8aRneA036R40Z/93/r0n4BsJ0KrjIQQUbrcu4BIVM=;
	b=DqykJQ8V3Vaxu7LuVi+4Rzbp4hCFCyZtdBd2LQQvGXzlIfV/7dvXYejzg6y5T44Ol3M4Cw
	dHtAd+BHtaV9p8i8/s88pf4WBETVmGdRvSBIAq3RwqGIgSK1XAKcjXYpMIPQb8nJn0eAAH
	U07UihGAY/KQMFIt5ffzEtIWpSNB9vU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-tTInXcc4M12VQx59_YVcpA-1; Tue, 18 Feb 2025 05:26:25 -0500
X-MC-Unique: tTInXcc4M12VQx59_YVcpA-1
X-Mimecast-MFC-AGG-ID: tTInXcc4M12VQx59_YVcpA_1739874385
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43961fb0bafso27051435e9.2
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 02:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874384; x=1740479184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj8aRneA036R40Z/93/r0n4BsJ0KrjIQQUbrcu4BIVM=;
        b=jaKNFoQeMhCvweiLZSYLsps5UA3leFUS3V5qRko8PjrLDh1mb63NM7a3rGbXnVSSks
         2GKfPaZ7W41a58mv4f3loOX4PQZDEWLD25Eha9cz8HZt1SBJK73iVfesjjNIdT1OwMS+
         xoVmdqN+M1MWPd+iA++M4a3pYPPMUMgOTZon2+AEjp88kF5Us1A1K8GF4iRciFtj/5zn
         /DK4Q6Upc4fP+p4dr+qzXGkPqGceH+7WMdbwN24CQePvTmj8lX3e8R3OMLZVKayTPGvt
         +s8Cpl6z62cek4QT2a1xVHksay8rpXMmZ1K5UhUeeoW7GtTU1L4QNMJwL/W6Uq1mPrdk
         Gfag==
X-Forwarded-Encrypted: i=1; AJvYcCXWqJvWTbMrvc8tE1yLb5LvQ6tNdAicVFSGNSn43YMow9Cfc0UU5buKLr6MOJVDKVBxgOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnVy99/PR3a83N8bztnxW+eW5kkiLGTmUHjikBuQOKJ6Xbyky
	NrMD9FfRs2nuer8JgNWIuZO/WG2TxkrQg0wTNobZIaVugIETCIMN4KYeBciRr/lPu1/hx+eTXyQ
	rHOPk9MVLNUFFBB3GKzMtCxpn/ojYFq8loa4eNs7XH8FjFhvmPQ==
X-Gm-Gg: ASbGnctjx9dkgowizz1Sbn63TosV6TERNus+are0TrsyacaVRJ1C9ApaWvazQLQTBJk
	vwK41/GepTDn0x6X7r7jNtyem0zNNV6icOs5jwKZ7Z7JSz0aQl9snre2hu6NGuxYbVqiLfB2xri
	/8uslaJ0tMMK5Car+x6nHlKZUjRp+UPMtlGFi0giitvx56T3Xlslu05k54yHFi5Uw0EQmgEirVR
	S0yC8bukngPmmlF3SAr1IYadUGfEr6Tns8f5AZOIfsCvIlGifn9I1QZF98XDWPeAQrS9skLyttq
	MufPUkS4i3NdgD/ku9/8epCuccvMrhhyGyA=
X-Received: by 2002:a05:600c:3ca3:b0:439:5f7a:e259 with SMTP id 5b1f17b1804b1-4396e739aa7mr116417575e9.23.1739874384576;
        Tue, 18 Feb 2025 02:26:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkSU/VSnOl2Lx5jSHDnvFMf1SdmHIIFIgmwDPLjf61CIhWkI2u1PLCMfAvVZ5aFuhqVLRdZQ==
X-Received: by 2002:a05:600c:3ca3:b0:439:5f7a:e259 with SMTP id 5b1f17b1804b1-4396e739aa7mr116417345e9.23.1739874384260;
        Tue, 18 Feb 2025 02:26:24 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43982bcc607sm58367795e9.16.2025.02.18.02.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:26:23 -0800 (PST)
Message-ID: <1ff73b64-2745-473d-a12d-87e1501262d5@redhat.com>
Date: Tue, 18 Feb 2025 11:26:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v6 6/6] octeontx2-pf: AF_XDP zero copy transmit
 support
To: Suman Ghosh <sumang@marvell.com>, horms@kernel.org, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lcherian@marvell.com,
 jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
 hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org, larysa.zaremba@intel.com
References: <20250213053141.2833254-1-sumang@marvell.com>
 <20250213053141.2833254-7-sumang@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250213053141.2833254-7-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 6:31 AM, Suman Ghosh wrote:
> +void otx2_zc_napi_handler(struct otx2_nic *pfvf, struct xsk_buff_pool *pool,
> +			  int queue, int budget)
> +{
> +	struct xdp_desc *xdp_desc = pool->tx_descs;
> +	int err, i, work_done = 0, batch;
> +
> +	budget = min(budget, otx2_read_free_sqe(pfvf, queue));
> +	batch = xsk_tx_peek_release_desc_batch(pool, budget);
> +	if (!batch)
> +		return;
> +
> +	for (i = 0; i < batch; i++) {
> +		dma_addr_t dma_addr;
> +
> +		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc[i].addr);
> +		err = otx2_xdp_sq_append_pkt(pfvf, NULL, dma_addr, xdp_desc[i].len,
> +					     queue, OTX2_AF_XDP_FRAME);
> +		if (!err) {
> +			netdev_err(pfvf->netdev, "AF_XDP: Unable to transfer packet err%d\n", err);

Here `err` is always 0, dumping it's value is quite confusing.

The root cause is that otx2_xdp_sq_append_pkt() returns a success
boolean value, the variable holding it should possibly be renamed
accordingly.

Since this is the only nit I could find, I think we are better without a
repost, but please follow-up on this chunk soon.

Thanks,

Paolo


