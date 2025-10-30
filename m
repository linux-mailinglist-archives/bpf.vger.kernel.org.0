Return-Path: <bpf+bounces-73007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86111C2002D
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 13:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D25934E3BA
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 12:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D5F314B93;
	Thu, 30 Oct 2025 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0LW+ue8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAEB2F12CC
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827331; cv=none; b=LQCVhMsuLtF5gSiM1UNkYi6jN1y42PVb20FYYgbd8TOxeaJi4Oi6eUfDhRlTH8q6J3Uhb/qnNLb1KqU3Rh0CzOtKE44K6xp8wG9NX6w5u7BJpTeG2MoJCPu8ub9ImSEwv62PfdacsoxGMTkOGSa1Ep6H/44lOeLuqLLhzgoCpQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827331; c=relaxed/simple;
	bh=3rsc6ptPvWByOYOhRv+nQJ1v7jnad7jLTGQxU4GRYQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShtRF3ZYL4ZRd4/nbp2STWfvw8bF+N4XTary7dAO3UD1dp74d6Jc568M6h4vi9yoFhjCaQ6brzetHcISr5G4q83I/khK4Vkc+thqNiGCfYKBUkFw8Bw97ScZ4dE9wR9tJqvdV5mqVnDptM3gig/P5/z+F3aqHfC3KlnNrOr5tWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0LW+ue8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761827329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WMVXs8TQMP3kSanWp9H8RTwHILJeUuZYlKUFoW3Nlw=;
	b=A0LW+ue8xSq37qODwE/SfXSorgI0WFb9q6F0bfaunm3r084Ibu8fbyvgz9rK3LNFyIs9KG
	tJH7n7JHa79HqJCqxEyLoobStESqLnLi2GqwejlFEpq4EqimTAIlMBVyh3NyKCvW5ZO37O
	/dVkacldbuQ62JM35d+J011/iGnR4Dk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-6Sd_NaedNuqA65ZmEmd7ew-1; Thu, 30 Oct 2025 08:28:48 -0400
X-MC-Unique: 6Sd_NaedNuqA65ZmEmd7ew-1
X-Mimecast-MFC-AGG-ID: 6Sd_NaedNuqA65ZmEmd7ew_1761827327
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-475da25c4c4so8666775e9.0
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 05:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827327; x=1762432127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WMVXs8TQMP3kSanWp9H8RTwHILJeUuZYlKUFoW3Nlw=;
        b=nfBMR8zaUMy/jmHyovHRZlUMc171rP63gG3cyfvK1ZqRmOxOws//DtmH9NUY0hLQEd
         1lc6yx65/zH3c+XPjyVmyUJ9jKTHVGfwlgue0s9RoIAyOSdbsyHHhmapgcY3xti0a9tu
         ZsBfKWeCPEy0Ix3W9VZB9iJlYex9BZsdmJ3y15vaxSqr6ChjOxsUZl7sRKQVRxbzBf+e
         gOvopCG9je2f0H+BkJxK89FOxWT8Pta50gutDwao2J2/9WzD+R/jXgaFZ0cCGXfEsklg
         rAktDb0djuSQ4rPYmTCQjKkWbYz1RlrRhgoPL2fnQEi8kebeRkgt6W1TMh84srV3npFT
         1aLg==
X-Forwarded-Encrypted: i=1; AJvYcCWw367Exrn7cJEyTBrpSAkNfSTef6LZF1qsleuFw12jfbouXQlvqXC9LQHYDFGpQ+dhmrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFykcJoVNG7klnJxG1Dzz8Cnns8Ud2xLs9FS31j48DxvOu9Gqr
	+nFuHfaEvrhTBBWVDP1WCP9M7qaklW75XFKGcYLj/M4RXeEutVSHXysvgyNERrtLs7Pl/hnAdov
	YhjPhhuYG5Jnw//P806DYliATPFT5Fh8BiJ+BzzehTYDD7u6qaIIvtQ==
X-Gm-Gg: ASbGnctSJzXFqXYUHwr0WnsNHi4mg6+gWcQQcx6R/EETIVRXcGC4wviBfL0lo9mhCbK
	V4EASvs75vabd7hszef9rq9Pv9Zu6e0zJWyP97Fe1g/yGBws+QOjdK2HVccLrfCTWw+2RbJt7X0
	D/kun6D6bTVkf1hL1u6kHnMQt+oXsb9dkaCS9mIcpgdSJz0SKwwxoqpfSqVI1pmuT2m/MwfByXG
	lsiIooM8yTmw/eUf5EesjzNjA4q3zw/iTTzef6yqKFxGfr8rdQ5RE/NCUcdD+fUwESBTRLcgyEh
	Qj/vHxmLRyvblSntDFp+t28MNXP7uwyUkzk+S8lRWZgbdinqHSMYXCTCdAdEfvcvwllD9ggtmEY
	YXx8tY/+BU5YKmxo6RipEVqPi1SELMKQj/QzrIkVeFOtp
X-Received: by 2002:a05:600c:4511:b0:477:e66:4082 with SMTP id 5b1f17b1804b1-4771e1ec1d1mr66499225e9.29.1761827326740;
        Thu, 30 Oct 2025 05:28:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQc3JgzM1QEslivftQlK3inQluENUMNYgDE1rjtok3+8IGknzl6HMn3biCdPkc1D7PQaX66g==
X-Received: by 2002:a05:600c:4511:b0:477:e66:4082 with SMTP id 5b1f17b1804b1-4771e1ec1d1mr66498985e9.29.1761827326363;
        Thu, 30 Oct 2025 05:28:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289adc18sm41187325e9.6.2025.10.30.05.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 05:28:45 -0700 (PDT)
Message-ID: <154ebe12-6e3c-4b16-9f55-e10a30f5c989@redhat.com>
Date: Thu, 30 Oct 2025 13:28:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 2/2] veth: more robust handing of race to avoid txq
 getting stuck
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 ihor.solodrai@linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 makita.toshiaki@lab.ntt.co.jp, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com
References: <176159549627.5396.15971398227283515867.stgit@firesoul>
 <176159553930.5396.4492315010562655785.stgit@firesoul>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <176159553930.5396.4492315010562655785.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 9:05 PM, Jesper Dangaard Brouer wrote:
> (3) Finally, the NAPI completion check in veth_poll() is updated. If NAPI is
> about to complete (napi_complete_done), it now also checks if the peer TXQ
> is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
> reschedule itself. This prevents a new race where the producer stops the
> queue just as the consumer is finishing its poll, ensuring the wakeup is not
> missed.

[...]

> @@ -986,7 +979,8 @@ static int veth_poll(struct napi_struct *napi, int budget)
>  	if (done < budget && napi_complete_done(napi, done)) {
>  		/* Write rx_notify_masked before reading ptr_ring */
>  		smp_store_mb(rq->rx_notify_masked, false);
> -		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring))) {
> +		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring) ||
> +			     (peer_txq && netif_tx_queue_stopped(peer_txq)))) {
>  			if (napi_schedule_prep(&rq->xdp_napi)) {
>  				WRITE_ONCE(rq->rx_notify_masked, true);
>  				__napi_schedule(&rq->xdp_napi);

Double checking I'm read the code correctly. The above is supposed to
trigger when something alike the following happens

[producer]				[consumer]
					veth_poll()
					[ring empty]
veth_xmit
  veth_forward_skb
  [NETDEV_TX_BUSY]		
					napi_complete_done()
					
  netif_tx_stop_queue
  __veth_xdp_flush()
  rq->rx_notify_masked == true
					WRITE_ONCE(rq->rx_notify_masked,
						   false);

?

I think the above can't happen, the producer should need to fill the
whole ring in-between the ring check and napi_complete_done().

Am I misreading it?

/P


