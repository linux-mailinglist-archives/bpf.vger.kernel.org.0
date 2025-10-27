Return-Path: <bpf+bounces-72332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C346C0E6F3
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 15:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 412DB4FE9DD
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2CF30C368;
	Mon, 27 Oct 2025 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W091BC4C"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8F30BBB3
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574377; cv=none; b=tOIdS0FWqQfHmHmHt4CykLYeJ3VVCxHoSJHURTTqx5pJc3qdJdBYgL6q5OOGSmDrfIDUgelJCQhLL+hKXhkuq+xaCBEvBxku+phbw2llvVphKPRgcBRp3zVBEBWmWBZ0wsy0X1NSj84uTCbLlgsL/CxAJdal3nFRvRRN4eIKg3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574377; c=relaxed/simple;
	bh=CI4EGzYex9h2DBQ9ogFFiNjzj5+5h41s1uUJ6ZNRQN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FnTWdDbtXNnGD030xHrRsP2P73z7SFCAn52DrrmGhdjbgQieHXDo0lwumohjg00R0AYlQeW4xtnXmOAqxvr4f9Z433iqExcCa7Y2IFBnObj5VtSrawh7l2+RqFWKCVxLmlY/eY1ZSZH+MroTHyzqqiWdSSe+mMskxRnF0RKlJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W091BC4C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761574374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXDTiCe61PwOLvz4aepYZofM4YqcnPsE33GQcCHLC5k=;
	b=W091BC4Cp8MQZpzkQE4t5cVCfUkUSsPEqctj8rIgkr1Y++5XUV9YfRi8v5iQb7qvgnP9hs
	gw01o2ej2kgC0oZZFvmngkCLK+Bj7rPMu6UnpqijxeLTru/GdTFqNfAnjRaxkXpLJflXid
	uuL6tTpjcVj96QTZDruqj8gFCn5j+m8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-qO4jGbwpMs6K-uHIHqVM4Q-1; Mon, 27 Oct 2025 10:12:52 -0400
X-MC-Unique: qO4jGbwpMs6K-uHIHqVM4Q-1
X-Mimecast-MFC-AGG-ID: qO4jGbwpMs6K-uHIHqVM4Q_1761574371
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b448c864d45so444678166b.2
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 07:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574370; x=1762179170;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXDTiCe61PwOLvz4aepYZofM4YqcnPsE33GQcCHLC5k=;
        b=GJD0q+NjwzPrpIPEhERnYZOvjOM7Dt0wuX9OR95b4+LCiIvo7Z+6SeobRi+9QHViws
         /J0koxSjHkt6iNmCBjJBQaOBvg3ZdcQN7fCKyOooQGB/4PSHYZXHBcXMOdUuXIMphosS
         XSBLtrjBVCMq+Z68pxW3CpvLaAxoYXhnPAj2a5HONAnKfFNqCiDPcFjCNAZO1ySUF1Jx
         6QXqa+wOX3MlTX8ofCRL0IZL5xqoRZveKG/Q8YGgPsOyEzIWN5pIAt2w1sw7VuvOfExJ
         TT9BRMx9Dn4tXs2fXnv/tPIabwOSsYaSTPhZhv6/MkiDTIHY8RFqihlKQWEuuC4PxXJ7
         OWyg==
X-Forwarded-Encrypted: i=1; AJvYcCV8Jmu5q7bYI6EM/PsJoRxe+VozU0iSyyCLm1apKO3OY9NlJ6u8FCVN2Y+pUgeEGZ/hcP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQDPJ1oGUXGQeBu3UJ69OJXwJ1NTL800b9XpuKhdtgiqsthG/+
	tqwm3Pb6BKtWvSrRsyYyT9x+96Eda/CV1saFbccX1ZTAkGL+7lPUTkX8meceu2M6HmstBTVZUtc
	qAprk/Ro6BWk18JunVViKEe2nQIWDP6aaQYkzOV3aYYeD1nqIlMrETQ==
X-Gm-Gg: ASbGncviaGMRgOwGZ6f0CcvdWnzJPcPvrCwdnQ76RiL2ifb9AaCbbOZ6YUVHNsUkAE/
	/i0r9fWZzHCPtlfVQKIEhEYKHZ7MIkyBB8bmy+uIb7DuB3sdbBhsxU6fS0jyZHIEpFAsCoJwM5Y
	8Mnl4lVOtYmMQJjchZlcGsYQAm6cYSsSR4H9BFo/BQBU9YAduLHD958hB8U+eqs0H581GNJAb8w
	H010YsaWhe1EtcohWUrs4TB590jA906+EpuZQYZ7Ltc+i2GFFOuJ6QDsJF9COxidHR4UV4lZpog
	UzFfwcFkh2xUOpj0sOoc89/iB5g6l+Fi/fKiBK1a/SAP9jfVIPwQwnk6kiSQ0zwf/ITaGLL+SSW
	laD0cs3v/qfwr237k5UThwTnZIQ==
X-Received: by 2002:a17:907:7fa9:b0:b5c:66ce:bfe6 with SMTP id a640c23a62f3a-b6dba5b93c6mr7313766b.55.1761574370143;
        Mon, 27 Oct 2025 07:12:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHWFDRx5i9mX7rcWZGcqjqX78dTPRFO24SYv/vkyQCe2mPe6GEsHT6TdQO2AtM0Tv0FNE6dg==
X-Received: by 2002:a17:907:7fa9:b0:b5c:66ce:bfe6 with SMTP id a640c23a62f3a-b6dba5b93c6mr7309566b.55.1761574369676;
        Mon, 27 Oct 2025 07:12:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d9b536710sm451408066b.57.2025.10.27.07.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:12:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 721F12EAA56; Mon, 27 Oct 2025 15:12:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 makita.toshiaki@lab.ntt.co.jp
Cc: Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, ihor.solodrai@linux.dev, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
Subject: Re: [PATCH net V1 3/3] veth: more robust handing of race to avoid
 txq getting stuck
In-Reply-To: <b021f5c3-5105-445d-b919-8282363a19fc@kernel.org>
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
 <176123158453.2281302.11061466460805684097.stgit@firesoul>
 <871pmsfjye.fsf@toke.dk> <b021f5c3-5105-445d-b919-8282363a19fc@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 27 Oct 2025 15:12:48 +0100
Message-ID: <87sef4e8m7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 24/10/2025 16.33, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>>=20
>>> Commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
>>> reduce TX drops") introduced a race condition that can lead to a perman=
ently
>>> stalled TXQ. This was observed in production on ARM64 systems (Ampere A=
ltra
>>> Max).
>>>
>>> The race occurs in veth_xmit(). The producer observes a full ptr_ring a=
nd
>>> stops the queue (netif_tx_stop_queue()). The subsequent conditional log=
ic,
>>> intended to re-wake the queue if the consumer had just emptied it (if
>>> (__ptr_ring_empty(...)) netif_tx_wake_queue()), can fail. This leads to=
 a
>>> "lost wakeup" where the TXQ remains stopped (QUEUE_STATE_DRV_XOFF) and
>>> traffic halts.
>>>
>>> This failure is caused by an incorrect use of the __ptr_ring_empty() API
>>> from the producer side. As noted in kernel comments, this check is not
>>> guaranteed to be correct if a consumer is operating on another CPU. The
>>> empty test is based on ptr_ring->consumer_head, making it reliable only=
 for
>>> the consumer. Using this check from the producer side is fundamentally =
racy.
>>>
>>> This patch fixes the race by adopting the more robust logic from an ear=
lier
>>> version V4 of the patchset, which always flushed the peer:
>>>
>>> (1) In veth_xmit(), the racy conditional wake-up logic and its memory b=
arrier
>>> are removed. Instead, after stopping the queue, we unconditionally call
>>> __veth_xdp_flush(rq). This guarantees that the NAPI consumer is schedul=
ed,
>>> making it solely responsible for re-waking the TXQ.
>>=20
>> This makes sense.
>>=20
>>> (2) On the consumer side, the logic for waking the peer TXQ is centrali=
zed.
>>> It is moved out of veth_xdp_rcv() (which processes a batch) and placed =
at
>>> the end of the veth_poll() function. This ensures netif_tx_wake_queue()=
 is
>>> called once per complete NAPI poll cycle.
>>=20
>> So is this second point strictly necessary to fix the race, or is it
>> more of an optimisation?
>>=20
>
> IMHO it is strictly necessary to fix the race.  The wakeup check
> netif_tx_queue_stopped() in veth_poll() needs to be after the code that
> (potentially) writes rx_notify_masked.
>
> This handles the race where veth_xmit() haven't called
> netif_tx_stop_queue() yet, but veth_poll() manage to consume all packets
> and stopped NAPI.  Then we know that __veth_xdp_flush(rq) in veth_xmit()
> will see rx_notify_masked=3D=3Dfalse and start NAPI/veth_poll() again, and
> even-though there is no packets left to process we still hit the check
> netif_tx_queue_stopped() which start txq and will allow veth_xmit() to
> run again.
>
> I'll see if I can improve the description for (2).

Right, okay. Yes, adding this reasoning to the commit message would be
good :)

-Toke


