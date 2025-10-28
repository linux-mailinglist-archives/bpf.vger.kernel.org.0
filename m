Return-Path: <bpf+bounces-72552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A96CAC15480
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2461E35421C
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6ED337B86;
	Tue, 28 Oct 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONDFyyJs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F5F23C8AE
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663404; cv=none; b=espELVeuIORnQb45B0kTCeVV5MFFWw0RzsQ2JJDzF2D1PLhc9fmh1X8tfFvBowqZ2TRrBo1QBwYIkPqKmm+IbZSiS9MkONp1J77OXPhZjZrqsr0fSFNvz+nDloIbwCl3ZNNh5XLY8mkOUJs+bQIo18Nk5TSmWvL7CFCXfQgG5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663404; c=relaxed/simple;
	bh=er2CNC3QcaaVpEVwyaeUqrEOigVeBx2t4bAbwKskTPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7upgnD41+Q+z0Rgk9/ksu4izOTrYgyGfGiVnqYLFUJbRbWQ0kZAcCQ3WjKZ/AHW/cbmyZbJvkMXl+zG/J+iYfx5dtoxEayF9cG2PEQx56NbXLf8502vjuMpGq4e8PPMQmsTYX/VABYGCaAKE+YWXIcoBKYKG3V6N86ckSm93v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONDFyyJs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781010ff051so4118653b3a.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761663403; x=1762268203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cpT9v3vZsTqou8arP0DXWnWYqvjSdGYFzEcyXBF9plY=;
        b=ONDFyyJsOaEgCxKnEb685WtU5/NKT4nAcUb/D0YPlI+K/+oUNTkjaH0LxaE7Ks7h63
         u9N07qCf5xb4zKJbmfrHisaUrUWKRPYP/nN1kBmKqA4kT1KRdzNeySTm72b+wee2CWM1
         RRs2RMn9VONZqzRV/4uN6sTUFT2uWliR2gdIWaPW6KcT0O7sWzvYJvTmiGk8+9097qFD
         VUvVHm+Yy3H7zShT//YAF1jBLgCJnR8xyFc2k9STW84HWx0WEA+gAEG5ymuk9RKq4anl
         kiCYcseaH01j/XTsEJhvKaWKe+7NFLKi0lnJqmms41jJgre2zPK8OXcU6q0nKQH4DrMK
         Ez5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761663403; x=1762268203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpT9v3vZsTqou8arP0DXWnWYqvjSdGYFzEcyXBF9plY=;
        b=NpCWp8O/hu79D//HKUidV+tnwJpBuiFTFnXwNjDW7rmSQermIeDvLThXA72cw7wJSM
         xF6jz8gJxnUnvlrfZQMqumTdB+lwQuL9MKy12rUyNOH3cH/oY2uSGpWbBo6cucC3zr0b
         fc1ryhtVjKK9O6UcGkl2B9BostWps6dpTaHR801QhmuZlGJxkGXIfJ115g2L/rjpI6Dk
         1l6TOYrm3xtULbjAtoy9wv1DOJMRGIZvNvyfX/S80iii6jRwQGVED/qtvAoHaeigU0vh
         sDRMVt/+ZPoU7Mcx1ZzCHx2btDONTJoVmvA6eJ43/HzAd5k/miRn3s6d6+1FJx5zeynn
         x5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXmhjokDDmYlKflWqzOylAFxhiq7fVcocjR9KUwjzGDOaTigq/1yNpNQ3/8zyz/p9NMTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9sZmIq2z8TIqurlI4dqAr3WSO9Mtqvy7dtM4K+iLWr6f+dP3
	zP6tSo7kgGze1vRoDCdWehgvdZacOcFmUJP7I93mJClxMhRpUmOpC/Xt
X-Gm-Gg: ASbGncs7ABA6xTddOVuqgcGeii+607yq+l2h5Ji5dWsINdDZk2c2mqT63ZfdHQAQUfg
	Omi0CA9nQg7PZnRm+SFqasZNz68NZsid5hu9h9wozWPi5x/rMU78+iErrK+vOGaqRa/YY/SAlS4
	lUHis47rfASBXtHKfzuupJraYXEr3P8LERrSEMubUrQQifWagmwh9EjVE5pTlPKZwbLd8OUcbfX
	toGIKDglLMwrCDEmKFrsU+FwEn3m1rKsSaNX5s4RuXurRPBIA0b1944qmcgBh6pEN8IZfaqI2zz
	CJb48NQfpdTFyyfGh4eyGNPlcvEkqoc/F2+1D32vDhldQ0m/06nvj/BH4V5AefBWhMzyELIazr6
	qHDzMxDCrSkoKUfqXlfhYLBDRV2FeoRKQpQ6578HBbpl3eIZUkZJc67a01ujP9cSyFoxwSh2Cio
	OKjRCdsuDyBy889nB2pHtze6PX4vXdD/JWjaWNLA0e82YGPOLNR7kym5V//HHFF1N9jKwdX01bC
	F49109mCHmUqQ==
X-Google-Smtp-Source: AGHT+IGfeHgVIMC0VHfcmG+idW723Hz2pg/WUGXn0Avn4tmBgDpRwGVIyyi/7yWZfkVRxwppZsPQWw==
X-Received: by 2002:a05:6a20:1582:b0:340:d065:c8b3 with SMTP id adf61e73a8af0-344d375663amr6595914637.36.1761663402796;
        Tue, 28 Oct 2025 07:56:42 -0700 (PDT)
Received: from [192.168.99.24] (i223-218-244-253.s42.a013.ap.plala.or.jp. [223.218.244.253])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a414069164sm12135669b3a.45.2025.10.28.07.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 07:56:42 -0700 (PDT)
Message-ID: <aacc9c56-bea9-44eb-90fd-726d41b418dd@gmail.com>
Date: Tue, 28 Oct 2025 23:56:38 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 2/2] veth: more robust handing of race to avoid txq
 getting stuck
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, makita.toshiaki@lab.ntt.co.jp,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com,
 netdev@vger.kernel.org, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
References: <176159549627.5396.15971398227283515867.stgit@firesoul>
 <176159553930.5396.4492315010562655785.stgit@firesoul>
Content-Language: en-US
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
In-Reply-To: <176159553930.5396.4492315010562655785.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/10/28 5:05, Jesper Dangaard Brouer wrote:

> (1) In veth_xmit(), the racy conditional wake-up logic and its memory barrier
> are removed. Instead, after stopping the queue, we unconditionally call
> __veth_xdp_flush(rq). This guarantees that the NAPI consumer is scheduled,
> making it solely responsible for re-waking the TXQ.

Maybe another option is to use !ptr_ring_full() instead of ptr_ring_empty()?
I'm not sure which is better. Anyway I'm ok with your approach.

...

> (3) Finally, the NAPI completion check in veth_poll() is updated. If NAPI is
> about to complete (napi_complete_done), it now also checks if the peer TXQ
> is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
> reschedule itself. This prevents a new race where the producer stops the
> queue just as the consumer is finishing its poll, ensuring the wakeup is not
> missed.
...

> @@ -986,7 +979,8 @@ static int veth_poll(struct napi_struct *napi, int budget)
>   	if (done < budget && napi_complete_done(napi, done)) {
>   		/* Write rx_notify_masked before reading ptr_ring */
>   		smp_store_mb(rq->rx_notify_masked, false);
> -		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring))) {
> +		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring) ||
> +			     (peer_txq && netif_tx_queue_stopped(peer_txq)))) {

Not sure if this is necessary.
 From commitlog, your intention seems to be making sure to wake up the queue,
but you wake up the queue immediately after this hunk in the same function,
so isn't it guaranteed without scheduling another napi?

>   			if (napi_schedule_prep(&rq->xdp_napi)) {
>   				WRITE_ONCE(rq->rx_notify_masked, true);
>   				__napi_schedule(&rq->xdp_napi);
> @@ -998,6 +992,13 @@ static int veth_poll(struct napi_struct *napi, int budget)
>   		veth_xdp_flush(rq, &bq);
>   	xdp_clear_return_frame_no_direct();
>   
> +	/* Release backpressure per NAPI poll */
> +	smp_rmb(); /* Paired with netif_tx_stop_queue set_bit */
> +	if (peer_txq && netif_tx_queue_stopped(peer_txq)) {
> +		txq_trans_cond_update(peer_txq);
> +		netif_tx_wake_queue(peer_txq);
> +	}
> +
>   	return done;
>   }

--
Toshiaki Makita

