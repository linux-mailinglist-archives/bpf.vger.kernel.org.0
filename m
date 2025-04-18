Return-Path: <bpf+bounces-56230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFBAA93744
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 14:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0913B7D0C
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23CF274FC5;
	Fri, 18 Apr 2025 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVmGAaTa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA31A3168;
	Fri, 18 Apr 2025 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979896; cv=none; b=mk2kToDz+H6SsiszBci6Z/Q5RJ+gljR6JVUKuUTCklPkQ4BNoYOt4nfX/TtT/3ViaWV14hdNpDC6PMqYWklX/N/dB8/PkMg0Jd5NslxqDsL+rWxEAn7owtXiHF1Jg+YYQ7+MKNytdR8K0IwCMpiQvwfnwhhOM6gJCagntaBZ/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979896; c=relaxed/simple;
	bh=wJG98QlVuw7ALXIq2to3ngupDnMlQGXQ6x/DoGA8cz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lg+9iB1ZN5d+x1Ufn7iSzkb06B/mGJYFypFEehYg8NsibE/kziP878nZIJHhAzCjh0AXK2FJZPpQ2PdP69nGQuiUH5adIgeeyI3wTjPm6gwPpA5x3OjFjqRZNjEt/au+GGsa6VDL2uKD0EZMqEv7D4TunZ4gNNujIjCv7esAzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVmGAaTa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223fd89d036so22054115ad.1;
        Fri, 18 Apr 2025 05:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744979894; x=1745584694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vlMNIYfnE2Db++lxxYMWU3y3wqeJ9gD5/8bodKKoCQ=;
        b=XVmGAaTaz21rx7R94q2JV5ATzS99qrCezQT00LLnbmBtrnWwPrqV02D7UM1sA4A01S
         LKDTAWHEYtAp0m8ZPjj+3EOJIgqNDcyR0JtVEle4cLlYO/YnLw+GCPUtIm4sAKjuqd63
         WgwYEstBK6YHAvrZaVSRW09gQMhfPJH8A2523cgtBivHBoKtRiakdW7LwWCgkmKZBHX9
         qQdnOL1t3V1kg0G+H3jjiGzyDLptIo2dmfIJUb54OAyoeyCJGhkZW4mNw63ScdW/6gi0
         lUsgtmrg2Tug+ZWjb+5ZWFdr8Z0w9viek/YXu0l/950wGwbaRoWwM0w6g+OSEhoqjWHE
         7bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744979894; x=1745584694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vlMNIYfnE2Db++lxxYMWU3y3wqeJ9gD5/8bodKKoCQ=;
        b=ExAlmd3GkP/Oe6fvdm6J544raveJdnLqNOaLLY5x1aoD7st0WzM4M5HezFh24ZDMsM
         NFxZuZfS0O/Y+5wGvG5JhHN1KOWdNLWBBWTGgNRsEILWFzhEEy/cwKCkKRuggen1hGr7
         fY4K2UTG+TAFx6G/8PDKS2lV6IMHaE3MFheEllrn0S0oIw1G22lmJo8ZMTXCMenpGxGJ
         5qWn6gMI2s6yTsSqdbEfvHgbugjJSy1mwvooQhV/mKwmecxwPWMCLci6eKYDboPUfObM
         LG48FMv1nCbkuEb3oQOSSKTfHVqOaRx6M71IWWZO1J1kWGCYRCpWUXpaNlwsCUWQio3k
         YgJA==
X-Forwarded-Encrypted: i=1; AJvYcCUo6BIiNGou4cE68BKkOFli9qyav7FPnvBeQFliEzjSo/j/+zuQ/Dw6n41yEgeZqXwmjL75Y5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztq7YgrbNTAENpYGBNveqPv/m6o4EHHCRltbmYJb2r77TdlHNV
	21kQuH3sxOuA4euLCVb+6hFuC2BUjhDNedBmC4+8F3PFDU2oVLNk
X-Gm-Gg: ASbGnctPfcIaVAjKh5nsYdyCaFJdIV+alSbvhvx9t2HcXtLoxzZTxWyN103dJGi4xr9
	EZHFH/E8VOmwrOl/q6gWE4gZGsNZvGL2vJ6zNWxax/BoK8Z2jDxIRWS/sLBPjAsH8jigOox0brW
	NEeBAKgBgwfudl6XesY2MKimiITd5cs6Kj0DaiwEa3BqpW6b92g4KuF3aqv0lUfXxgxeprwo9p3
	L59v7jPeAW7e0OaDdcdwqZHnwR14ATXA2wgwbcd+alscGO+51LLPk/Fjne8VMHzpLs3JouHdUdn
	aAFZZsfyiWBOiAzEqTOn4eZp86BjZU/FyA/ysn0QA05gD/E2N/2tK5q6NB9lPcUHwR6pgNvA70l
	KMqWO9x5jzfy9qlCpnYafsvIz8ECUnQ==
X-Google-Smtp-Source: AGHT+IFAcQ3Mm/tx+7/pVONxwfsP2ENWCNyBh54EpyWBTCVVmzDgFJd7I3eGqwSF5T7tGIat/HVrnw==
X-Received: by 2002:a17:902:d50e:b0:216:6283:5a8c with SMTP id d9443c01a7336-22c53607da5mr34582635ad.39.1744979894208;
        Fri, 18 Apr 2025 05:38:14 -0700 (PDT)
Received: from [192.168.99.14] (i60-34-11-52.s41.a013.ap.plala.or.jp. [60.34.11.52])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73dbf8c04afsm1485644b3a.23.2025.04.18.05.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 05:38:13 -0700 (PDT)
Message-ID: <8265c592-a51f-4b26-9e6d-df69c16aebf4@gmail.com>
Date: Fri, 18 Apr 2025 21:38:07 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
References: <174489803410.355490.13216831426556849084.stgit@firesoul>
 <174489811513.355490.8155513147018728621.stgit@firesoul>
Content-Language: en-US
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
In-Reply-To: <174489811513.355490.8155513147018728621.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/04/17 22:55, Jesper Dangaard Brouer wrote:
...
> +	case NETDEV_TX_BUSY:
> +		/* If a qdisc is attached to our virtual device, returning
> +		 * NETDEV_TX_BUSY is allowed.
> +		 */
> +		txq = netdev_get_tx_queue(dev, rxq);
> +
> +		if (qdisc_txq_has_no_queue(txq)) {
> +			dev_kfree_skb_any(skb);
> +			goto drop;
> +		}
> +		netif_tx_stop_queue(txq);
> +		/* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
> +		__skb_push(skb, ETH_HLEN);
> +		if (use_napi)
> +			__veth_xdp_flush(rq);
> +		/* Cancel TXQ stop for very unlikely race */
> +		if (unlikely(__ptr_ring_empty(&rq->xdp_ring)))
> +			netif_tx_wake_queue(txq);

xdp_ring is only initialized when use_napi is not NULL.
Should add "if (use_napi)" ?

BTW, you added a check for the ring_empty here. so

if empty:
   this function starts the queue by itself
else:
   it is guaranteed that veth_xdp_rcv() consumes the ring after this point.
   so the rcv side definitely starts the queue.

With that, __veth_xdp_flush invocation seems to be unnecessary,
if your concern is starting the queue.

Toshiaki Makita


