Return-Path: <bpf+bounces-64526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C14B13D25
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6790E3ACAC3
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 14:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C3B26E6E2;
	Mon, 28 Jul 2025 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjmOky1n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96586250;
	Mon, 28 Jul 2025 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712910; cv=none; b=TvuJ4da8caiLIWmriPhQwAqjaqKuTBVWXHFgQiL1GN+hkplpyrzANk40GiJPIjjj27q0DTp5BG0ScTiCfdKya12ORD8NVv6L7qJy1cgk0fvINyuv/Fpp0bcTyLiGvNIkde/PiU++cM+gpQQnFCS9vqUemDD1FCJtX92fIIhKfD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712910; c=relaxed/simple;
	bh=iRH2UsZKcpiK6aEbDmW/DcvCToZyl1+N9KkD2LLa4ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHn4ppFY7B7/kRCILa0iSI+B9jsoatiRSQbGqw1AN7nkCI4tPdntkOfeCb5KPNGohN5np4/yZPgOLs6EuBIKclF06gdXmd2GLxKkxgNaxNYUGy6kmHS7kF0ugIpJNJGZa4RrVx0VjF4FEJh5D3VtkJ3m28R5yW+RzvHz8GU4T1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjmOky1n; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a528243636so2700955f8f.3;
        Mon, 28 Jul 2025 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753712907; x=1754317707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iRH2UsZKcpiK6aEbDmW/DcvCToZyl1+N9KkD2LLa4ik=;
        b=PjmOky1nSqYskWo6o6kG9O+329OJITTS673B/+ICwEq2Ftro6T6p1UNYPFeQb8lmk1
         9OEI+Xal+XoCXSrSOs4PrmMbxPNOBRj4hvypLUM69j8ZYdipmnD8Itp0vuPOdGR63z7D
         z9O1K2WJcx/bnwZVxLjVD1us6euZsKJ4Bfdee3754OWaWWZkrg/p3bAx7pu1TXnqqc+v
         ciHZOScdEKjv5iZ9iQQ6cN/MzwK/25maKGaCHbx/yFkb8l9M0VjIoSEHG1KC/seN4nDE
         KaF71PrQI6ij8oaCO9hi36t3DMRj7C5alErocSvom7dnCt4swqc1vgfHd3DyjaD1R++b
         X37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753712907; x=1754317707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRH2UsZKcpiK6aEbDmW/DcvCToZyl1+N9KkD2LLa4ik=;
        b=lkWgS/FhzA8NKdr2QvyMiwTlIE6eGN9WxMsJ3FAJkAWvP2a0P8+MsHtHEbw1m+ihGD
         7uYxlJTXRFxc9e21oeDYXn7jgxknYK2gk1OmfIR5JQxiKCU/lro6GGG3FHeFl7P0N4E2
         rF9GfzipzyZu/32bVM4wxW/d9UWrrt+A1+IjEOYyUl7nJHLx4N3hkhjA/M4ByLzlrYLx
         2BO5mO4len+S0Y9pmgx0Ostc+nUaw/JJRvM0OPSrCSIHu6Nh+PbPWF0E+sQU72zKd2YU
         KU1vST1ze9Eq1sdL8HHdzva7OjFTgrpzZ+ZojIpIPbkWjDmYQqgEWsVr8mq2dwJ//4Vc
         NRqg==
X-Forwarded-Encrypted: i=1; AJvYcCWDrh0hFwI2GM/pPp3USe+aI9gt1CA8SEIyT0GwL3pYacAYZDs6/vsqkR2Sx6i3xAqXUds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiVHNB9cEkTr3ziYzhrDdNnf4Z/PIsECdGgk0SXhnMgcP5L9Mj
	sPpoFzpTripCXS3uPPBMSpRIwfsYkv4bSs+bgLWfG9zEXh8IrQVptTLh
X-Gm-Gg: ASbGnctIWcKqot/Ma+rAVqQsaH8SbJqkbE1/aKpNdf6ANspHKdwTL3KhXXYBuKTKfyr
	icY9+1oVnsUdKyehVOi3qmhilSUuc0u2FJa++40jotEsZ1XF6NObcrBCm27Hxh6RU4s0nWw316L
	dr9D1FrDrD7POEOMm/zmsJjtDmFDGv+HQ12Pf7V/1q+w22Dww9kdwuchE9xv8A6n3cu/cAfGSTU
	rpBqdRP7wnlTolzbYMfqsKSxnOii+lpI40kKWXwNoYYJ2WsIzQorml1Al+ki+0aCI41S9GjBWUs
	96T61P5U3XHWnJkjVMOPq9CLQUABYmPe59WH3dsTGnNe+RGpJ6ZMXEjbFPzH4lphHVzGNmM20cv
	f04SWCo5MNzTWYa7giPesxk8NlohVCuzE2ftHbZVuND5eh7n5Cxt5yaOQiP3nGh9ofKbkS2U6P0
	ywqn3GP359EA==
X-Google-Smtp-Source: AGHT+IFBwAUdcdlt7TU/wdxNp7rLD3IJAb9Fzi1dd3FWgtDJ5TdDJ55NzxD+kEKC/fGFRXOuUrzS/A==
X-Received: by 2002:adf:8bca:0:b0:3b7:5cd3:fa8b with SMTP id ffacd0b85a97d-3b77668b430mr5012852f8f.55.1753712906690;
        Mon, 28 Jul 2025 07:28:26 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eba147sm9044449f8f.27.2025.07.28.07.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 07:28:26 -0700 (PDT)
Message-ID: <4169cfd4-2231-417f-b091-d8fa2f73f176@gmail.com>
Date: Mon, 28 Jul 2025 15:28:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sfc: handle NULL returned by xdp_convert_buff_to_frame()
To: Kunwu Chan <kunwu.chan@linux.dev>, Edward Cree <ecree@amd.com>,
 Paolo Abeni <pabeni@redhat.com>, Chenyuan Yang <chenyuan0y@gmail.com>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, bpf@vger.kernel.org,
 zzjas98@gmail.com
References: <20250723003203.1238480-1-chenyuan0y@gmail.com>
 <045d1ff5-bb20-481d-a067-0a42345ab83d@redhat.com>
 <de14f60e-b1f0-432c-80b4-a2f0453e0fe2@amd.com>
 <8d987133-0e22-4aa8-bf2e-57ef105c8db8@linux.dev>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <8d987133-0e22-4aa8-bf2e-57ef105c8db8@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/07/2025 13:38, Kunwu Chan wrote:
> Proposed refinement:
...
>          if (net_ratelimit())
>              netif_err(efx, rx_err, efx->net_dev,
> -                  "XDP TX failed (%d)\n", err);
> +                  "XDP TX failed (%d)%s\n", err,
> +                  err == -ENOBUFS ? " [frame conversion]" : "");

Unnecessary, since efx_xdp_tx_buffers() never returns ENOBUFS.

>          channel->n_rx_xdp_bad_drops++;
> -        trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
> +        if (err != -ENOBUFS)
> +            trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);

Why prevent the tracepoint in this case??

